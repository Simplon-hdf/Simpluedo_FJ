--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Homebrew)
-- Dumped by pg_dump version 16.4 (Homebrew)

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

--
-- Name: ajout_objet(character varying, character varying); Type: PROCEDURE; Schema: public; Owner: justindidelot
--

CREATE PROCEDURE public.ajout_objet(IN var_nom_objets character varying, IN var_nom_salles character varying)
    LANGUAGE plpgsql
    AS $$
 BEGIN
     -- Insérer directement l'objet en liant la salle par son nom
     INSERT INTO objets (nom_objets, id_salles)
     SELECT var_nom_objets, salles.id_salles
     FROM salles
     WHERE salles.nom_salles = var_nom_salles;
 
     -- Vérification si aucune salle ne correspond
     IF NOT FOUND THEN
         RAISE EXCEPTION 'La salle "%" n''existe pas.', var_nom_salles;
     END IF;
 END;
 $$;


ALTER PROCEDURE public.ajout_objet(IN var_nom_objets character varying, IN var_nom_salles character varying) OWNER TO justindidelot;

--
-- Name: lister_objet(character varying); Type: FUNCTION; Schema: public; Owner: justindidelot
--

CREATE FUNCTION public.lister_objet(nom_salle character varying) RETURNS TABLE(nom_objets character varying)
    LANGUAGE sql
    AS $$
    SELECT nom_objets
    FROM objets
    INNER JOIN salles ON salles.id_salles = objets.id_salles
    WHERE nom_salles = nom_salle;
 $$;


ALTER FUNCTION public.lister_objet(nom_salle character varying) OWNER TO justindidelot;

--
-- Name: trigger_update_position(); Type: FUNCTION; Schema: public; Owner: justindidelot
--

CREATE FUNCTION public.trigger_update_position() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 BEGIN
     -- Complète l'heure de sortie dans visiter
     UPDATE visiter
     SET heure_sortie = NEW.heure_arrivee
     WHERE id_personnages = NEW.id_personnages
       AND heure_sortie IS NULL;

     -- Mets à jour ou insère dans position
     INSERT INTO position (id_personnages, id_salles, heure_arrivee)
     VALUES (NEW.id_personnages, NEW.id_salles, NEW.heure_arrivee)
     ON CONFLICT (id_personnages)
     DO UPDATE SET id_salles = EXCLUDED.id_salles, heure_arrivee = EXCLUDED.heure_arrivee;

     RETURN NEW;
 END;
 $$;


ALTER FUNCTION public.trigger_update_position() OWNER TO justindidelot;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: objets; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.objets (
    id_objets integer NOT NULL,
    nom_objets character varying(50) NOT NULL,
    id_salles integer
);


ALTER TABLE public.objets OWNER TO justindidelot;

--
-- Name: objets_id_objets_seq; Type: SEQUENCE; Schema: public; Owner: justindidelot
--

ALTER TABLE public.objets ALTER COLUMN id_objets ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.objets_id_objets_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: personnages; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.personnages (
    id_personnages integer NOT NULL,
    nom_personnages character varying(50) NOT NULL
);


ALTER TABLE public.personnages OWNER TO justindidelot;

--
-- Name: personnages_id_personnages_seq; Type: SEQUENCE; Schema: public; Owner: justindidelot
--

ALTER TABLE public.personnages ALTER COLUMN id_personnages ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personnages_id_personnages_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: position; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public."position" (
    id_personnages integer NOT NULL,
    id_salles integer NOT NULL,
    heure_arrivee time without time zone NOT NULL
);


ALTER TABLE public."position" OWNER TO justindidelot;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.roles (
    id_roles integer NOT NULL,
    nom_roles character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO justindidelot;

--
-- Name: roles_id_roles_seq; Type: SEQUENCE; Schema: public; Owner: justindidelot
--

ALTER TABLE public.roles ALTER COLUMN id_roles ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.roles_id_roles_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: salles; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.salles (
    id_salles integer NOT NULL,
    nom_salles character varying(50) NOT NULL
);


ALTER TABLE public.salles OWNER TO justindidelot;

--
-- Name: salles_id_salles_seq; Type: SEQUENCE; Schema: public; Owner: justindidelot
--

ALTER TABLE public.salles ALTER COLUMN id_salles ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.salles_id_salles_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.utilisateurs (
    uuid_utilisateurs uuid DEFAULT gen_random_uuid() NOT NULL,
    pseudo_utilisateurs character varying(50) NOT NULL,
    id_roles integer,
    id_personnages integer
);


ALTER TABLE public.utilisateurs OWNER TO justindidelot;

--
-- Name: visiter; Type: TABLE; Schema: public; Owner: justindidelot
--

CREATE TABLE public.visiter (
    id_personnages integer NOT NULL,
    id_salles integer NOT NULL,
    heure_arrivee time without time zone NOT NULL,
    heure_sortie time without time zone
);


ALTER TABLE public.visiter OWNER TO justindidelot;

--
-- Data for Name: objets; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.objets (id_objets, nom_objets, id_salles) FROM stdin;
1	Poignard	3
2	Revolver	5
3	Chandelier	1
4	Corde	6
5	Clé anglaise	4
6	Matraque	2
7	VANDAL	4
\.


--
-- Data for Name: personnages; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.personnages (id_personnages, nom_personnages) FROM stdin;
1	Colonel MOUTARDE
2	Docteur OLIVE
3	Professeur VIOLET
4	Madame PERVENCHE
5	Mademoiselle ROSE
6	Madame LEBLANC
\.


--
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public."position" (id_personnages, id_salles, heure_arrivee) FROM stdin;
1	1	08:00:00
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.roles (id_roles, nom_roles) FROM stdin;
1	observateur
2	utilisateur
3	maitre du jeu
\.


--
-- Data for Name: salles; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.salles (id_salles, nom_salles) FROM stdin;
1	Cuisine
2	Grand salon
3	Petit salon
4	Bureau
5	Bibliothèque
6	Studio
7	Hall
8	Véranda
9	Salle à manger
\.


--
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.utilisateurs (uuid_utilisateurs, pseudo_utilisateurs, id_roles, id_personnages) FROM stdin;
946fc3e9-5a57-4c47-88c0-c00244f5c4fe	Srekaens	3	2
43e05a01-5456-483c-bf03-d9fdd184b2e4	MessaKami	2	1
9e1d4450-194a-46c8-995c-bd6d93092769	GETGETR	2	3
6cf257c8-59a8-47d9-9186-c22f92a0c317	Shotax	2	6
2abd96af-ee91-414c-8836-006a01ad570c	Nuage	2	5
27804421-425b-4149-b36e-1ae3da99e478	Puduchlip	2	4
fb112539-f204-4340-89ae-cae129d41eaf	Martial	1	\N
be781939-436c-462d-812d-e63e7e388974	Enguerran	1	\N
f95e824e-4bb8-4d52-a11e-866c97d8173b	Boris	1	\N
bbafeb8a-4b89-4d02-81fc-780468615b67	Yohan	1	\N
2f70d20a-93ef-4ecd-bdf6-feb5a843566c	Aurore	1	\N
a037cf4c-ec4c-4397-bed2-8ef800032ed1	Gabriel	1	\N
\.


--
-- Data for Name: visiter; Type: TABLE DATA; Schema: public; Owner: justindidelot
--

COPY public.visiter (id_personnages, id_salles, heure_arrivee, heure_sortie) FROM stdin;
1	2	08:30:00	08:30:00
1	3	09:30:00	09:30:00
1	1	08:30:00	09:00:00
1	1	08:00:00	09:00:00
\.


--
-- Name: objets_id_objets_seq; Type: SEQUENCE SET; Schema: public; Owner: justindidelot
--

SELECT pg_catalog.setval('public.objets_id_objets_seq', 7, true);


--
-- Name: personnages_id_personnages_seq; Type: SEQUENCE SET; Schema: public; Owner: justindidelot
--

SELECT pg_catalog.setval('public.personnages_id_personnages_seq', 6, true);


--
-- Name: roles_id_roles_seq; Type: SEQUENCE SET; Schema: public; Owner: justindidelot
--

SELECT pg_catalog.setval('public.roles_id_roles_seq', 3, true);


--
-- Name: salles_id_salles_seq; Type: SEQUENCE SET; Schema: public; Owner: justindidelot
--

SELECT pg_catalog.setval('public.salles_id_salles_seq', 9, true);


--
-- Name: objets objets_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.objets
    ADD CONSTRAINT objets_pkey PRIMARY KEY (id_objets);


--
-- Name: personnages personnages_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.personnages
    ADD CONSTRAINT personnages_pkey PRIMARY KEY (id_personnages);


--
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (id_personnages);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_roles);


--
-- Name: salles salles_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.salles
    ADD CONSTRAINT salles_pkey PRIMARY KEY (id_salles);


--
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (uuid_utilisateurs);


--
-- Name: visiter visiter_pkey; Type: CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT visiter_pkey PRIMARY KEY (id_personnages, id_salles, heure_arrivee);


--
-- Name: visiter update_position; Type: TRIGGER; Schema: public; Owner: justindidelot
--

CREATE TRIGGER update_position AFTER INSERT ON public.visiter FOR EACH ROW EXECUTE FUNCTION public.trigger_update_position();


--
-- Name: objets fk_objets_id_salles; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.objets
    ADD CONSTRAINT fk_objets_id_salles FOREIGN KEY (id_salles) REFERENCES public.salles(id_salles);


--
-- Name: utilisateurs fk_utilisateur_id_personnages; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT fk_utilisateur_id_personnages FOREIGN KEY (id_personnages) REFERENCES public.personnages(id_personnages);


--
-- Name: utilisateurs fk_utilisateurs_id_roles; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT fk_utilisateurs_id_roles FOREIGN KEY (id_roles) REFERENCES public.roles(id_roles);


--
-- Name: position position_id_personnages_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_id_personnages_fkey FOREIGN KEY (id_personnages) REFERENCES public.personnages(id_personnages);


--
-- Name: position position_id_salles_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_id_salles_fkey FOREIGN KEY (id_salles) REFERENCES public.salles(id_salles);


--
-- Name: visiter visiter_id_personnages_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT visiter_id_personnages_fkey FOREIGN KEY (id_personnages) REFERENCES public.personnages(id_personnages);


--
-- Name: visiter visiter_id_salles_fkey; Type: FK CONSTRAINT; Schema: public; Owner: justindidelot
--

ALTER TABLE ONLY public.visiter
    ADD CONSTRAINT visiter_id_salles_fkey FOREIGN KEY (id_salles) REFERENCES public.salles(id_salles);


--
-- Name: TABLE objets; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.objets TO simpluedo_admin;


--
-- Name: TABLE personnages; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.personnages TO simpluedo_admin;


--
-- Name: TABLE "position"; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,UPDATE ON TABLE public."position" TO simpluedo_admin;


--
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.roles TO simpluedo_admin;


--
-- Name: TABLE salles; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.salles TO simpluedo_admin;


--
-- Name: TABLE utilisateurs; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.utilisateurs TO simpluedo_admin;


--
-- Name: TABLE visiter; Type: ACL; Schema: public; Owner: justindidelot
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.visiter TO simpluedo_admin;


--
-- PostgreSQL database dump complete
--

