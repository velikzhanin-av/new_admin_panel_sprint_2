from enum import Enum

from django.contrib.postgres.aggregates import ArrayAgg
from django.http import JsonResponse
from django.views.generic.detail import BaseDetailView
from django.views.generic.list import BaseListView

from movies.models import FilmWork

class Roles(Enum):
    ACTOR = 'actor'
    DIRECTOR = 'director'
    WRITER = 'writer'

class MoviesApiMixin:
    model = FilmWork
    http_method_names = ['get']
    paginate_by = 50

    def get_queryset(self):
        base_query = (self.model.objects.all()
                .prefetch_related('genres', 'persons')
                .values('id',
                        'title',
                        'description',
                        'creation_date',
                        'rating')
                .annotate(
                        genres=ArrayAgg('genres__name', distinct=True),
                        persons=ArrayAgg('persons__full_name', distinct=True)))


        # for role in Roles:


        return (self.model.objects.all()
                .prefetch_related('genres', 'persons')
                .values('id',
                        'title',
                        'description',
                        'creation_date',
                        'rating')
                .annotate(
                        genres=ArrayAgg('genres__name', distinct=True),
                        persons=ArrayAgg('persons__full_name', distinct=True),
        ))

    def render_to_response(self, context: dict, **response_kwargs):
        return JsonResponse(context)

class MoviesListApi(MoviesApiMixin, BaseListView):

    def get_context_data(self, *, object_list=None, **kwargs):
        results_qs = self.get_queryset()

        paginator, page, queryset, is_paginated = self.paginate_queryset(results_qs, self.paginate_by)

        context = {
            'count': paginator.count,
            'total_pages': paginator.num_pages,
            'prev': page.previous_page_number() if page.has_previous() else None,
            'next': page.next_page_number() if page.has_next() else None,
            'results': list(queryset),
        }
        return context

class MoviesDetailApi(MoviesApiMixin, BaseDetailView):

    def get_context_data(self, *, object_list=None, **kwargs):
        return self.get_object(queryset=self.get_queryset())