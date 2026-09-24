--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: m_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO m_role (role_id, nama_role, is_active) VALUES
('11dc1faf-2c66-4525-932d-a90e24da8987', 'Administrator', true),
('c58ee40a-5ae2-4067-b6ad-8cae9c65913c', 'Owner', true),
('42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a', 'Kasir', true),
('29656af0-c3f6-44e8-9c74-c3643f38e871', 'Supervisor', true);

--
-- PostgreSQL database dump complete
--

