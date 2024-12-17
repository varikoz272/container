--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: text_note; Type: TABLE; Schema: public; Owner: admin-nahren
--

CREATE TABLE public.text_note (
    id integer NOT NULL,
    creator_id integer,
    body text NOT NULL
);


ALTER TABLE public.text_note OWNER TO "admin-nahren";

--
-- Name: text_note_id_seq; Type: SEQUENCE; Schema: public; Owner: admin-nahren
--

ALTER TABLE public.text_note ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.text_note_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: trusted_user; Type: TABLE; Schema: public; Owner: admin-nahren
--

CREATE TABLE public.trusted_user (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    color integer NOT NULL,
    password character varying(32)
);


ALTER TABLE public.trusted_user OWNER TO "admin-nahren";

--
-- Name: text_note_view; Type: VIEW; Schema: public; Owner: admin-nahren
--

CREATE VIEW public.text_note_view AS
 SELECT trusted_user.name,
    trusted_user.color,
    text_note.body
   FROM (public.text_note
     JOIN public.trusted_user ON ((text_note.creator_id = trusted_user.id)));


ALTER VIEW public.text_note_view OWNER TO "admin-nahren";

--
-- Name: trusted_user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin-nahren
--

ALTER TABLE public.trusted_user ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.trusted_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: text_note; Type: TABLE DATA; Schema: public; Owner: admin-nahren
--

COPY public.text_note (id, creator_id, body) FROM stdin;
1	1	privet
2	1	привет
\.


--
-- Data for Name: trusted_user; Type: TABLE DATA; Schema: public; Owner: admin-nahren
--

COPY public.trusted_user (id, name, color, password) FROM stdin;
1	home pc	10606061	admin
\.


--
-- Name: text_note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin-nahren
--

SELECT pg_catalog.setval('public.text_note_id_seq', 2, true);


--
-- Name: trusted_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin-nahren
--

SELECT pg_catalog.setval('public.trusted_user_id_seq', 1, true);


--
-- Name: text_note text_note_pkey; Type: CONSTRAINT; Schema: public; Owner: admin-nahren
--

ALTER TABLE ONLY public.text_note
    ADD CONSTRAINT text_note_pkey PRIMARY KEY (id);


--
-- Name: trusted_user trusted_user_color_key; Type: CONSTRAINT; Schema: public; Owner: admin-nahren
--

ALTER TABLE ONLY public.trusted_user
    ADD CONSTRAINT trusted_user_color_key UNIQUE (color);


--
-- Name: trusted_user trusted_user_name_key; Type: CONSTRAINT; Schema: public; Owner: admin-nahren
--

ALTER TABLE ONLY public.trusted_user
    ADD CONSTRAINT trusted_user_name_key UNIQUE (name);


--
-- Name: trusted_user trusted_user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin-nahren
--

ALTER TABLE ONLY public.trusted_user
    ADD CONSTRAINT trusted_user_pkey PRIMARY KEY (id);


--
-- Name: text_note text_note_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin-nahren
--

ALTER TABLE ONLY public.text_note
    ADD CONSTRAINT text_note_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.trusted_user(id);


--
-- PostgreSQL database dump complete
--

