--
-- PostgreSQL database dump
--

\restrict Uv0sPoGQjo8nuBxaHf6yl9J3PV8lOVmDYKHYJ9jGFMo2eXEuZAYFi5ffPoN3SVT

-- Dumped from database version 17.6 (Debian 17.6-1.pgdg13+1)
-- Dumped by pg_dump version 17.6 (Debian 17.6-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: content; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA content;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: film_work; Type: TABLE; Schema: content; Owner: -
--

CREATE TABLE content.film_work (
    id uuid NOT NULL,
    title text NOT NULL,
    description text,
    creation_date date,
    rating double precision,
    type text NOT NULL,
    created timestamp with time zone,
    modified timestamp with time zone
);


--
-- Name: genre; Type: TABLE; Schema: content; Owner: -
--

CREATE TABLE content.genre (
    id uuid NOT NULL,
    name text NOT NULL,
    description text,
    created timestamp with time zone,
    modified timestamp with time zone
);


--
-- Name: genre_film_work; Type: TABLE; Schema: content; Owner: -
--

CREATE TABLE content.genre_film_work (
    id uuid,
    genre_id uuid NOT NULL,
    film_work_id uuid NOT NULL,
    created timestamp with time zone
);


--
-- Name: person; Type: TABLE; Schema: content; Owner: -
--

CREATE TABLE content.person (
    id uuid NOT NULL,
    full_name character varying(255) NOT NULL,
    created timestamp with time zone,
    modified timestamp with time zone
);


--
-- Name: person_film_work; Type: TABLE; Schema: content; Owner: -
--

CREATE TABLE content.person_film_work (
    id uuid,
    person_id uuid NOT NULL,
    film_work_id uuid NOT NULL,
    role text NOT NULL,
    created timestamp with time zone
);


--
-- Name: film_work film_work_pkey; Type: CONSTRAINT; Schema: content; Owner: -
--

ALTER TABLE ONLY content.film_work
    ADD CONSTRAINT film_work_pkey PRIMARY KEY (id);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: content; Owner: -
--

ALTER TABLE ONLY content.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: content; Owner: -
--

ALTER TABLE ONLY content.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: film_work_creation_date_idx; Type: INDEX; Schema: content; Owner: -
--

CREATE INDEX film_work_creation_date_idx ON content.film_work USING btree (creation_date);


--
-- Name: genre_film_work_idx; Type: INDEX; Schema: content; Owner: -
--

CREATE UNIQUE INDEX genre_film_work_idx ON content.genre_film_work USING btree (genre_id, film_work_id);


--
-- Name: person_film_work_idx; Type: INDEX; Schema: content; Owner: -
--

CREATE UNIQUE INDEX person_film_work_role_idx ON content.person_film_work USING btree (film_work_id, person_id, role);


--
-- Name: genre_film_work genre_film_work_film_work_id_fkey; Type: FK CONSTRAINT; Schema: content; Owner: -
--

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_film_work_id_fkey FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) ON DELETE CASCADE;


--
-- Name: genre_film_work genre_film_work_genre_id_fkey; Type: FK CONSTRAINT; Schema: content; Owner: -
--

ALTER TABLE ONLY content.genre_film_work
    ADD CONSTRAINT genre_film_work_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES content.genre(id) ON DELETE CASCADE;


--
-- Name: person_film_work person_film_work_film_work_id_fkey; Type: FK CONSTRAINT; Schema: content; Owner: -
--

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_film_work_id_fkey FOREIGN KEY (film_work_id) REFERENCES content.film_work(id) ON DELETE CASCADE;


--
-- Name: person_film_work person_film_work_person_id_fkey; Type: FK CONSTRAINT; Schema: content; Owner: -
--

ALTER TABLE ONLY content.person_film_work
    ADD CONSTRAINT person_film_work_person_id_fkey FOREIGN KEY (person_id) REFERENCES content.person(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict Uv0sPoGQjo8nuBxaHf6yl9J3PV8lOVmDYKHYJ9jGFMo2eXEuZAYFi5ffPoN3SVT
