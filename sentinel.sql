--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO sentinel;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO sentinel;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO sentinel;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO sentinel;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO sentinel;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO sentinel;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO sentinel;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO sentinel;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO sentinel;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO sentinel;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO sentinel;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO sentinel;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: countries_chart; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE countries_chart (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    title character varying(255) NOT NULL,
    scale character varying(20) NOT NULL,
    ordinals character varying(100)[],
    segments integer,
    CONSTRAINT countries_chart_segments_check CHECK ((segments >= 0))
);


ALTER TABLE countries_chart OWNER TO sentinel;

--
-- Name: countries_chart_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE countries_chart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE countries_chart_id_seq OWNER TO sentinel;

--
-- Name: countries_chart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE countries_chart_id_seq OWNED BY countries_chart.id;


--
-- Name: countries_country; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE countries_country (
    id integer NOT NULL,
    code character varying(3) NOT NULL,
    name character varying(255) NOT NULL,
    mdr_estimated_cases integer NOT NULL,
    mdr_eval_0 integer NOT NULL,
    mdr_eval_5 integer NOT NULL,
    mdr_treat_0 integer NOT NULL,
    mdr_treat_5 integer NOT NULL,
    mdr_therapy_0 integer NOT NULL,
    mdr_therapy_5 integer NOT NULL,
    reported_mdr boolean NOT NULL,
    reported_xdr boolean NOT NULL,
    documented_adult_mdr boolean NOT NULL,
    documented_child_mdr boolean NOT NULL,
    documented_adult_xdr boolean NOT NULL,
    documented_child_xdr boolean NOT NULL,
    CONSTRAINT countries_country_mdr_estimated_cases_check CHECK ((mdr_estimated_cases >= 0)),
    CONSTRAINT countries_country_mdr_eval_0_check CHECK ((mdr_eval_0 >= 0)),
    CONSTRAINT countries_country_mdr_eval_5_check CHECK ((mdr_eval_5 >= 0)),
    CONSTRAINT countries_country_mdr_therapy_0_check CHECK ((mdr_therapy_0 >= 0)),
    CONSTRAINT countries_country_mdr_therapy_5_check CHECK ((mdr_therapy_5 >= 0)),
    CONSTRAINT countries_country_mdr_treat_0_check CHECK ((mdr_treat_0 >= 0)),
    CONSTRAINT countries_country_mdr_treat_5_check CHECK ((mdr_treat_5 >= 0))
);


ALTER TABLE countries_country OWNER TO sentinel;

--
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE countries_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE countries_country_id_seq OWNER TO sentinel;

--
-- Name: countries_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE countries_country_id_seq OWNED BY countries_country.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO sentinel;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO sentinel;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO sentinel;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO sentinel;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO sentinel;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: sentinel
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO sentinel;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sentinel
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO sentinel;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY countries_chart ALTER COLUMN id SET DEFAULT nextval('countries_chart_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY countries_country ALTER COLUMN id SET DEFAULT nextval('countries_country_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add country	7	add_country
20	Can change country	7	change_country
21	Can delete country	7	delete_country
22	Can add chart	8	add_chart
23	Can change chart	8	change_chart
24	Can delete chart	8	delete_chart
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('auth_permission_id_seq', 24, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$20000$dLXzK6iSnb7E$0vrnkh98NDVnicWnQbOrIhiJ/664U75O0S8CuDLs/Gc=	2015-08-23 13:42:47.376594-04	t	clinton			clinton@dreisbach.us	t	t	2015-08-23 13:41:48.585358-04
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: countries_chart; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY countries_chart (id, name, title, scale, ordinals, segments) FROM stdin;
1	reported	Reported MDR-TB & XDR-TB Cases	ordinal	{"No Reported Cases","Reported MDR-TB Case","Reported XDR-TB Case","Reported MDR-TB & XDR-TB"}	\N
2	pub_mdr	Publication Documenting MDR-TB Cases	ordinal	{"No Publication","Publication with Adult MDR-TB","Publication with Child MDR-TB","Publication with Adult & Child MDR-TB"}	\N
3	pub_xdr	Publication Documenting XDR-TB Cases	ordinal	{"No Publication","Publication with Adult XDR-TB","Publication with Child XDR-TB","Publication with Adult & Child XDR-TB"}	\N
5	all_xdr	All Data on XDR-TB	ordinal	{"No Reported Cases","Reported Cases without Publication","Reported Cases with Publications for Adults","Reported Cases with Publications for Adults & Children"}	\N
6	mdr_estimated_cases	Estimated MDR-TB Cases	log	\N	5
8	mdr_eval_5	5-14 Year Olds: Needing Evaluation	log	\N	5
9	mdr_treat_0	0-4 Year Olds: Needing Treatment	log	\N	5
10	mdr_treat_5	5-14 Year Olds: Needing Treatment	log	\N	5
11	mdr_therapy_0	0-4 Year Olds: Needing Preventative Therapy	log	\N	5
12	mdr_therapy_5	5-14 Year Olds: Needing Preventative Therapy	log	\N	5
4	all_mdr	All MDR-TB Data	ordinal	{"No Reported Cases","Reported Cases without Publication","Reported Cases with Publications for Adults","Reported Cases with Publications for Adults & Children"}	\N
7	mdr_eval_0	0-4 Year Olds: Needing Evaluation	log	{}	5
\.


--
-- Name: countries_chart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('countries_chart_id_seq', 12, true);


--
-- Data for Name: countries_country; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY countries_country (id, code, name, mdr_estimated_cases, mdr_eval_0, mdr_eval_5, mdr_treat_0, mdr_treat_5, mdr_therapy_0, mdr_therapy_5, reported_mdr, reported_xdr, documented_adult_mdr, documented_child_mdr, documented_adult_xdr, documented_child_xdr) FROM stdin;
70	ETH	Ethiopia	2000	1332	2668	133	224	1199	1298	t	f	t	t	f	f
19	BRB	Barbados	0	0	0	0	0	0	0	t	f	t	f	f	f
7	AGO	Angola	1700	1132	2268	113	190	1019	1103	t	f	f	f	f	f
12	ABW	Aruba	1	1	1	0	0	1	1	f	f	f	f	f	f
5	ASM	American Samoa	0	0	0	0	0	0	0	f	f	f	f	f	f
10	ARG	Argentina	340	226	454	23	38	204	221	t	t	t	t	t	f
28	BIH	Bosnia and Herzegovina	13	9	17	1	1	8	8	t	f	t	t	f	f
13	AUS	Australia	17	11	23	1	2	10	11	t	t	t	t	t	f
34	BFA	Burkina Faso	150	100	200	10	17	90	97	t	t	t	t	t	f
21	BEL	Belgium	15	10	20	1	2	9	10	t	t	t	t	t	t
18	BGD	Bangladesh	4200	2797	5603	280	471	2517	2725	t	t	t	t	t	f
39	CAN	Canada	7	5	9	0	1	4	5	t	t	t	t	t	f
27	BES	Bonaire, Saint Eustatius and Saba	0	0	0	0	0	0	0	t	t	f	f	f	f
35	BDI	Burundi	150	100	200	10	17	90	97	t	f	t	f	f	f
17	BHR	Bahrain	3	2	4	0	0	2	2	t	f	t	f	f	f
49	COG	Congo	250	167	334	17	28	150	162	f	f	f	f	f	f
23	BEN	Benin	54	36	72	4	6	32	35	t	t	t	f	f	f
52	CIV	Cote d'Ivoire	580	386	774	39	65	348	376	t	f	t	t	f	f
16	BHS	Bahamas	1	1	1	0	0	1	1	t	f	f	f	f	f
25	BTN	Bhutan	25	17	33	2	3	15	16	t	t	f	f	f	f
59	COD	Democratic Republic of the Congo	2900	1931	3869	193	325	1738	1882	t	t	t	f	f	f
20	BLR	Belarus	2200	1465	2935	147	247	1319	1427	t	t	t	t	t	f
33	BGR	Bulgaria	100	67	133	7	11	60	65	t	t	t	t	t	f
41	CAF	Central African Republic	130	87	173	9	15	78	84	t	f	t	t	f	f
22	BLZ	Belize	3	2	4	0	0	2	2	t	f	t	f	f	f
3	ALB	Albania	2	1	3	0	0	1	1	t	f	t	f	f	f
29	BWA	Botswana	140	93	187	9	16	84	91	t	t	t	f	f	f
32	BRN	Brunei Darussalam	0	0	0	0	0	0	0	f	f	f	f	f	f
24	BMU	Bermuda	0	0	0	0	0	0	0	f	f	f	f	f	f
30	BRA	Brazil	1700	1132	2268	113	190	1019	1103	t	t	t	t	t	f
74	PYF	French Polynesia	0	0	0	0	0	0	0	f	f	f	f	f	f
55	CUW	Curacao	0	0	0	0	0	0	0	f	f	f	f	f	f
50	COK	Cook Islands	1	1	1	0	0	1	1	t	f	f	f	f	f
31	VGB	British Virgin Islands	0	0	0	0	0	0	0	f	f	f	f	f	f
38	CMR	Cameroon	670	446	894	45	75	402	435	t	f	t	f	f	f
8	AIA	Anguilla	0	0	0	0	0	0	0	f	f	f	f	f	f
54	CUB	Cuba	11	7	15	1	1	7	7	t	t	t	f	t	f
56	CYP	Cyprus	2	1	3	0	0	1	1	t	f	f	f	f	f
93	IDN	Indonesia	6900	4595	9205	460	773	4136	4477	t	t	t	f	t	f
78	DEU	Germany	63	42	84	4	7	38	41	t	t	t	t	t	f
66	SLV	El Salvador	16	11	21	1	2	10	10	t	f	t	f	f	f
44	CHN	China	59000	39294	78706	3929	6611	35365	38282	t	t	t	t	t	t
51	CRI	Costa Rica	6	4	8	0	1	4	4	t	f	f	f	f	f
61	DJI	Djibouti	81	54	108	5	9	49	53	t	f	t	t	f	f
47	COL	Colombia	310	206	414	21	35	186	201	t	t	t	t	t	f
95	IRQ	Iraq	420	280	560	28	47	252	273	t	f	t	f	f	f
60	DNK	Denmark	3	2	4	0	0	2	2	t	f	t	t	f	f
62	DMA	Dominica	0	0	0	0	0	0	0	f	f	f	f	f	f
63	DOM	Dominican Republic	330	220	440	22	37	198	214	t	t	t	f	f	f
42	TCD	Chad	320	213	427	21	36	192	208	t	f	t	f	f	f
43	CHL	Chile	19	13	25	1	2	11	12	t	t	t	f	f	f
69	EST	Estonia	70	47	93	5	8	42	45	t	t	t	t	t	f
64	ECU	Ecuador	380	253	507	25	43	228	247	t	t	t	f	f	f
65	EGY	Egypt	330	220	440	22	37	198	214	t	t	t	t	t	f
68	ERI	Eritrea	79	53	105	5	9	47	51	t	f	f	f	f	f
72	FIN	Finland	3	2	4	0	0	2	2	t	t	t	t	t	f
73	FRA	France	45	30	60	3	5	27	29	t	t	t	t	t	f
9	ATG	Antigua and Barbuda	0	0	0	0	0	0	0	f	f	f	f	f	f
45	HKG	China, Hong Kong SAR	48	32	64	3	5	29	31	t	t	t	t	t	f
75	GAB	Gabon	170	113	227	11	19	102	110	f	f	f	f	f	f
71	FJI	Fiji	0	0	0	0	0	0	0	f	f	f	f	f	f
82	GRD	Grenada	0	0	0	0	0	0	0	f	f	f	f	f	f
79	GHA	Ghana	390	260	520	26	44	234	253	t	f	t	f	f	f
77	GEO	Georgia	630	420	840	42	71	378	409	t	t	t	t	t	t
81	GRL	Greenland	2	1	3	0	0	1	1	t	f	f	f	f	f
6	AND	Andorra	0	0	0	0	0	0	0	f	f	f	f	f	f
76	GMB	Gambia	10	7	13	1	1	6	6	t	f	t	f	f	f
86	GNB	Guinea-Bissau	45	30	60	3	5	27	29	t	f	f	f	f	f
67	GNQ	Equatorial Guinea	0	0	0	0	0	0	0	t	f	t	f	f	f
4	DZA	Algeria	180	120	240	12	20	108	117	t	f	t	f	f	f
84	GTM	Guatemala	140	93	187	9	16	84	91	t	f	t	f	f	f
83	GUM	Guam	0	0	0	0	0	0	0	t	f	f	f	f	f
85	GIN	Guinea	250	167	334	17	28	150	162	t	f	t	f	f	f
53	HRV	Croatia	2	1	3	0	0	1	1	t	f	f	f	f	f
89	HND	Honduras	71	47	95	5	8	43	46	t	f	t	f	f	f
87	GUY	Guyana	48	32	64	3	5	29	31	t	f	t	f	f	f
88	HTI	Haiti	390	260	520	26	44	234	253	t	f	t	f	f	f
90	HUN	Hungary	31	21	41	2	3	19	20	t	t	t	t	f	f
94	IRN	Iran (Islamic Republic of)	750	500	1001	50	84	450	487	t	t	t	t	t	f
92	IND	India	64000	42624	85376	4262	7172	38362	41527	t	t	t	t	t	t
91	ISL	Iceland	1	1	1	0	0	1	1	t	f	t	f	f	f
46	MAC	China, Macao SAR	8	5	11	1	1	5	5	t	t	t	f	f	f
48	COM	Comoros	3	2	4	0	0	2	2	t	f	f	f	f	f
37	KHM	Cambodia	380	253	507	25	43	228	247	t	t	t	f	f	f
40	CYM	Cayman Islands	0	0	0	0	0	0	0	f	f	f	f	f	f
58	PRK	Democratic People's Republic of Korea	3800	2531	5069	253	426	2278	2466	t	t	t	t	t	f
11	ARM	Armenia	250	167	334	17	28	150	162	t	t	t	t	t	f
14	AUT	Austria	18	12	24	1	2	11	12	t	t	t	t	t	f
106	KGZ	Kyrgyzstan	1800	1199	2401	120	202	1079	1168	t	t	t	f	f	f
104	KIR	Kiribati	15	10	20	1	2	9	10	t	f	f	f	f	f
157	KOR	South Korea	2201	1465	2935	147	247	1319	1427	t	t	t	t	t	f
162	KNA	Saint Kitts and Nevis	0	0	0	0	0	0	0	f	f	f	f	f	f
105	KWT	Kuwait	0	0	0	0	0	0	0	t	f	t	f	f	f
110	LSO	Lesotho	170	113	227	11	19	102	110	t	t	t	t	t	f
109	LBN	Lebanon	10	7	13	1	1	6	6	t	f	t	t	f	f
128	MNE	Montenegro	0	0	0	0	0	0	0	t	f	f	f	f	f
113	LTU	Lithuania	300	200	400	20	34	180	195	t	t	t	t	t	f
130	MAR	Morocco	300	200	400	20	34	180	195	t	f	t	f	f	f
112	LBY	Libya	36	24	48	2	4	22	23	t	f	f	f	f	f
115	MDG	Madagascar	170	113	227	11	19	102	110	t	f	t	f	f	f
126	MCO	Monaco	0	0	0	0	0	0	0	f	f	f	f	f	f
158	MDA	Republic of Moldova	1700	1132	2268	113	190	1019	1103	t	t	t	t	f	f
129	MSR	Montserrat	0	0	0	0	0	0	0	t	f	f	f	f	f
137	NCL	New Caledonia	0	0	0	0	0	0	0	t	f	f	f	f	f
141	NGA	Nigeria	3600	2398	4802	240	403	2158	2336	t	t	t	t	f	f
133	NAM	Namibia	630	420	840	42	71	378	409	t	t	t	t	f	f
120	MLT	Malta	0	0	0	0	0	0	0	t	f	f	f	f	f
117	MYS	Malaysia	18	12	24	1	2	11	12	t	f	t	f	f	f
116	MWI	Malawi	96	64	128	6	11	58	62	t	f	t	f	f	f
131	MOZ	Mozambique	2000	1332	2668	133	224	1199	1298	t	t	t	f	t	f
140	NER	Niger	270	180	360	18	30	162	175	t	t	f	f	f	f
100	JPN	Japan	240	160	320	16	27	144	156	t	t	t	t	t	f
132	MMR	Myanmar	6000	3996	8004	400	672	3596	3893	t	t	t	f	f	f
118	MDV	Maldives	2	1	3	0	0	1	1	t	t	f	f	f	f
122	MRT	Mauritania	59	39	79	4	7	35	38	t	f	f	f	f	f
124	MEX	Mexico	480	320	640	32	54	288	311	t	t	t	t	f	f
119	MLI	Mali	140	93	187	9	16	84	91	t	f	t	f	f	f
139	NIC	Nicaragua	46	31	61	3	5	28	30	t	f	t	f	f	f
123	MUS	Mauritius	0	0	0	0	0	0	0	t	f	f	f	f	f
136	NLD	Netherlands	9	6	12	1	1	5	6	t	t	t	t	t	f
151	PER	Peru	2200	1465	2935	147	247	1319	1427	t	t	t	t	t	t
148	PAN	Panama	56	37	75	4	6	34	36	t	f	t	t	f	f
138	NZL	New Zealand	4	3	5	0	0	2	3	t	t	t	t	t	f
144	NOR	Norway	3	2	4	0	0	2	2	t	t	t	t	f	f
152	PHL	Philippines	12000	7992	16008	799	1345	7193	7786	t	t	t	t	f	f
142	NIU	Niue	0	0	0	0	0	0	0	f	f	f	f	f	f
135	NPL	Nepal	990	659	1321	66	111	593	642	t	t	t	t	t	f
134	NRU	Nauru	0	0	0	0	0	0	0	f	f	f	f	f	f
149	PNG	Papua New Guinea	1100	733	1467	73	123	659	714	t	t	t	t	t	f
145	OMN	Oman	6	4	8	0	1	4	4	t	t	t	f	f	f
146	PAK	Pakistan	11000	7326	14674	733	1233	6593	7137	t	t	t	t	t	f
150	PRY	Paraguay	55	37	73	4	6	33	36	t	f	t	t	f	f
160	RUS	Russian Federation	46000	30636	61364	3064	5155	27572	29847	t	t	t	t	t	f
153	POL	Poland	48	32	64	3	5	29	31	t	t	t	t	t	f
154	PRT	Portugal	35	23	47	2	4	21	23	t	t	t	t	t	t
161	RWA	Rwanda	240	160	320	16	27	144	156	t	f	t	t	f	f
155	PRI	Puerto Rico	1	1	1	0	0	1	1	t	f	f	f	f	f
147	PLW	Palau	0	0	0	0	0	0	0	t	f	f	f	f	f
156	QAT	Qatar	6	4	8	0	1	4	4	t	t	t	f	f	f
170	SRB	Serbia	20	13	27	1	2	12	13	t	t	t	f	t	f
159	ROU	Romania	800	533	1067	53	90	480	519	t	t	t	t	t	f
168	SAU	Saudi Arabia	84	56	112	6	9	50	55	t	f	t	t	f	f
111	LBR	Liberia	130	87	173	9	15	78	84	t	f	f	f	f	f
127	MNG	Mongolia	170	113	227	11	19	102	110	t	t	t	t	f	f
177	SLB	Solomon Islands	12	8	16	1	1	7	8	f	f	f	f	f	f
183	SDN	Sudan	580	386	774	39	65	348	376	t	f	t	f	f	f
186	SWE	Sweden	11	7	15	1	1	7	7	t	t	t	t	f	f
182	LKA	Sri Lanka	21	14	28	1	2	13	14	t	f	t	f	f	f
114	LUX	Luxembourg	0	0	0	0	0	0	0	t	f	f	f	f	f
181	ESP	Spain	31	21	41	2	3	19	20	t	t	t	t	t	f
125	FSM	Micronesia (Federated States of)	7	5	9	0	1	4	5	t	f	t	t	f	f
174	SXM	Sint Maarten (Dutch part)	0	0	0	0	0	0	0	f	f	f	f	f	f
173	SGP	Singapore	36	24	48	2	4	22	23	t	f	t	f	f	f
188	SYR	Syrian Arab Republic	97	65	129	6	11	58	63	t	f	t	f	f	f
171	SYC	Seychelles	0	0	0	0	0	0	0	f	f	f	f	f	f
175	SVK	Slovakia	2	1	3	0	0	1	1	t	f	f	f	f	f
180	SSD	South Sudan	250	167	334	17	28	150	162	t	f	f	f	f	f
169	SEN	Senegal	400	266	534	27	45	240	260	t	f	t	f	f	f
164	VCT	Saint Vincent and the Grenadines	1	1	1	0	0	1	1	t	f	f	f	f	f
184	SUR	Suriname	3	2	4	0	0	2	2	t	f	f	f	f	f
178	SOM	Somalia	770	513	1027	51	86	462	500	t	f	t	t	f	f
176	SVN	Slovenia	0	0	0	0	0	0	0	t	t	t	f	f	f
185	SWZ	Swaziland	730	486	974	49	82	438	474	t	t	t	f	t	f
97	ISR	Israel	22	15	29	1	2	13	14	t	t	t	t	t	f
189	TJK	Tajikistan	910	606	1214	61	102	545	590	t	t	t	t	f	f
101	JOR	Jordan	15	10	20	1	2	9	10	t	f	t	f	f	f
108	LVA	Latvia	120	80	160	8	13	72	78	t	t	t	t	t	f
172	SLE	Sierra Leone	220	147	293	15	25	132	143	t	f	t	f	f	f
190	THA	Thailand	1800	1199	2401	120	202	1079	1168	t	t	t	t	t	f
179	ZAF	South Africa	8100	5395	10805	539	908	4855	5256	t	t	t	t	t	t
166	SMR	San Marino	0	0	0	0	0	0	0	f	f	f	f	f	f
99	JAM	Jamaica	3	2	4	0	0	2	2	t	f	f	f	f	f
165	WSM	Samoa	0	0	0	0	0	0	0	f	f	f	f	f	f
187	CHE	Switzerland	9	6	12	1	1	5	6	t	f	t	t	f	f
98	ITA	Italy	43	29	57	3	5	26	28	t	t	t	t	t	f
103	KEN	Kenya	2800	1865	3735	186	314	1678	1817	t	t	t	f	f	f
163	LCA	Saint Lucia	0	0	0	0	0	0	0	f	f	f	f	f	f
204	ARE	United Arab Emirates	2	1	3	0	0	1	1	t	t	t	f	f	f
2	AFG	Afghanistan	1300	866	1734	87	146	779	844	t	f	f	f	f	f
15	AZE	Azerbaijan	2800	1865	3735	186	314	1678	1817	t	t	t	f	t	f
26	BOL	Bolivia (Plurinational State of)	150	100	200	10	17	90	97	t	f	t	f	f	f
36	CPV	Cabo Verde	10	7	13	1	1	6	6	f	f	f	f	f	f
57	CZE	Czech Republic	10	7	13	1	1	6	6	t	t	t	f	f	f
205	GBR	United Kingdom of Great Britain and Northern Ireland	69	46	92	5	8	41	45	t	t	t	t	f	f
80	GRC	Greece	6	4	8	0	1	4	4	t	t	t	t	t	t
96	IRL	Ireland	2	1	3	0	0	1	1	t	t	t	t	t	f
102	KAZ	Kazakhstan	7000	4662	9338	466	784	4196	4542	t	t	t	t	t	f
107	LAO	Lao People's Democratic Republic	220	147	293	15	25	132	143	t	f	t	f	f	f
121	MHL	Marshall Islands	4	3	5	0	0	2	3	t	f	t	t	f	f
191	MKD	The Former Yugoslav Republic of Macedonia	5	3	7	0	1	3	3	t	t	f	f	f	f
143	MNP	Northern Mariana Islands	0	0	0	0	0	0	0	t	f	f	f	f	f
167	STP	Sao Tome and Principe	15	10	20	1	2	9	10	t	f	f	f	f	f
200	TCA	Turks and Caicos Islands	0	0	0	0	0	0	0	t	f	f	f	f	f
193	TGO	Togo	77	51	103	5	9	46	50	t	t	f	f	f	f
194	TKL	Tokelau	0	0	0	0	0	0	0	f	f	f	f	f	f
192	TLS	Timor-Leste	82	55	109	5	9	49	53	t	f	t	f	f	f
199	TKM	Turkmenistan	0	0	0	0	0	0	0	t	f	t	f	f	f
197	TUN	Tunisia	19	13	25	1	2	11	12	t	t	t	f	f	f
195	TON	Tonga	0	0	0	0	0	0	0	f	f	f	f	f	f
198	TUR	Turkey	520	346	694	35	58	312	337	t	t	t	t	f	f
196	TTO	Trinidad and Tobago	11	7	15	1	1	7	7	t	f	f	f	f	f
201	TUV	Tuvalu	1	1	1	0	0	1	1	t	f	f	f	f	f
206	TZA	United Republic of Tanzania	510	340	680	34	57	306	331	t	t	t	f	f	f
203	UKR	Ukraine	6800	4529	9071	453	762	4076	4412	t	t	t	f	t	f
202	UGA	Uganda	1000	666	1334	67	112	599	649	t	f	t	f	f	f
207	USA	United States of America	81	54	108	5	9	49	53	t	t	t	t	t	t
208	URY	Uruguay	1	1	1	0	0	1	1	t	f	f	t	f	f
209	UZB	Uzbekistan	4000	2664	5336	266	448	2398	2595	t	t	t	t	t	f
211	VEN	Venezuela (Bolivarian Republic of)	100	67	133	7	11	60	65	t	t	t	f	f	f
212	VNM	Vietnam	3800	2531	5069	253	426	2278	2466	t	t	t	f	f	f
210	VUT	Vanuatu	0	0	0	0	0	0	0	f	f	f	f	f	f
213	WLF	Wallis and Futuna Islands	0	0	0	0	0	0	0	f	f	f	f	f	f
214	YEM	Yemen	150	100	200	10	17	90	97	t	f	t	t	f	f
215	ZMB	Zambia	620	413	827	41	69	372	402	t	f	t	t	f	f
216	ZWE	Zimbabwe	930	619	1241	62	104	557	603	t	f	t	f	f	f
\.


--
-- Name: countries_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('countries_country_id_seq', 216, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2015-09-01 23:07:58.637833-04	1	Chart object	1		8	1
2	2015-09-01 23:09:16.245487-04	1	Chart object	2	Changed ordinals.	8	1
3	2015-09-02 21:59:08.482255-04	4	All MDR-TB Data	2	Changed title.	8	1
4	2015-09-02 22:02:08.26208-04	7	0-4 Year Olds: Needing Evaluation	2	Changed ordinals and segments.	8	1
5	2015-09-02 22:06:44.450755-04	7	0-4 Year Olds: Needing Evaluation	2	Changed segments.	8	1
6	2015-09-02 22:08:13.814865-04	7	0-4 Year Olds: Needing Evaluation	2	Changed segments.	8	1
7	2015-09-02 22:08:38.480383-04	7	0-4 Year Olds: Needing Evaluation	2	Changed segments.	8	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 7, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	countries	country
8	countries	chart
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('django_content_type_id_seq', 8, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2015-08-23 13:38:15.167468-04
2	auth	0001_initial	2015-08-23 13:38:15.229773-04
3	admin	0001_initial	2015-08-23 13:38:15.270052-04
4	contenttypes	0002_remove_content_type_name	2015-08-23 13:38:15.305003-04
5	auth	0002_alter_permission_name_max_length	2015-08-23 13:38:15.318468-04
6	auth	0003_alter_user_email_max_length	2015-08-23 13:38:15.332325-04
7	auth	0004_alter_user_username_opts	2015-08-23 13:38:15.345354-04
8	auth	0005_alter_user_last_login_null	2015-08-23 13:38:15.361007-04
9	auth	0006_require_contenttypes_0002	2015-08-23 13:38:15.363159-04
10	sessions	0001_initial	2015-08-23 13:38:15.370484-04
11	countries	0001_initial	2015-08-23 13:38:23.04277-04
12	countries	0002_auto_20150902_0306	2015-09-01 23:06:21.835264-04
13	countries	0003_auto_20150903_0156	2015-09-02 21:56:27.503116-04
14	countries	0004_auto_20150903_0156	2015-09-02 21:56:59.036398-04
15	countries	0005_auto_20150905_1915	2015-09-05 15:15:16.219046-04
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sentinel
--

SELECT pg_catalog.setval('django_migrations_id_seq', 15, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: sentinel
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
e5h6lxqiqlhrupf4aa05frjoywz10n2y	NDMxY2ViMjI3YTI4MmEyNjliYTBmZmMxMDgyOGE4NzY4MzBmZjM2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1ZDk4MjViNjVkZTE1ZjhmYWY4N2E5OWVkMjBkMjc3NzZkNjliMzMwIn0=	2015-09-06 13:42:47.379039-04
\.


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: countries_chart_name_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY countries_chart
    ADD CONSTRAINT countries_chart_name_key UNIQUE (name);


--
-- Name: countries_chart_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY countries_chart
    ADD CONSTRAINT countries_chart_pkey PRIMARY KEY (id);


--
-- Name: countries_country_code_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY countries_country
    ADD CONSTRAINT countries_country_code_key UNIQUE (code);


--
-- Name: countries_country_name_key; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY countries_country
    ADD CONSTRAINT countries_country_name_key UNIQUE (name);


--
-- Name: countries_country_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY countries_country
    ADD CONSTRAINT countries_country_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_fa58a9b394361dd_uniq; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_fa58a9b394361dd_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: sentinel; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: auth_group_name_40917f1640c3186b_like; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_group_name_40917f1640c3186b_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_7c1751599c7d5dfe_like; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX auth_user_username_7c1751599c7d5dfe_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: countries_chart_name_2d7dfebe776610f2_like; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX countries_chart_name_2d7dfebe776610f2_like ON countries_chart USING btree (name varchar_pattern_ops);


--
-- Name: countries_country_code_55fef164cadb0bbc_like; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX countries_country_code_55fef164cadb0bbc_like ON countries_country USING btree (code varchar_pattern_ops);


--
-- Name: countries_country_name_1b8312eb09c9a73e_like; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX countries_country_name_1b8312eb09c9a73e_like ON countries_country USING btree (name varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_23a9f7e6493678e3_like; Type: INDEX; Schema: public; Owner: sentinel; Tablespace: 
--

CREATE INDEX django_session_session_key_23a9f7e6493678e3_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_content_type_id_38fc3af3233ee244_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_38fc3af3233ee244_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_13c9895a4e59c7db_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_13c9895a4e59c7db_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_3cfabd8a990ac384_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_3cfabd8a990ac384_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user__permission_id_6364f6eed9f1ccf1_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_6364f6eed9f1ccf1_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_66ff53fb4cc4d63e_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_66ff53fb4cc4d63e_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_1a43ffc2b9330b0c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_1a43ffc2b9330b0c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_48896a0dc8afe780_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_48896a0dc8afe780_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_333892b762375d2b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_333892b762375d2b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_46a1217abc8df327_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: sentinel
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_46a1217abc8df327_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: clinton
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM clinton;
GRANT ALL ON SCHEMA public TO clinton;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

