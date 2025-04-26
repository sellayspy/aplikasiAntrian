--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: antrian_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antrian_detail (
    id bigint NOT NULL,
    antrian_kategori_id bigint NOT NULL,
    antrian_tujuan_id bigint NOT NULL,
    aktif character varying(255) DEFAULT 'Y'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT antrian_detail_aktif_check CHECK (((aktif)::text = ANY ((ARRAY['Y'::character varying, 'N'::character varying])::text[])))
);


ALTER TABLE public.antrian_detail OWNER TO postgres;

--
-- Name: antrian_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antrian_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antrian_detail_id_seq OWNER TO postgres;

--
-- Name: antrian_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antrian_detail_id_seq OWNED BY public.antrian_detail.id;


--
-- Name: antrian_kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antrian_kategori (
    id bigint NOT NULL,
    nama_kategori character varying(255) NOT NULL,
    awalan character(1) NOT NULL,
    aktif character varying(255) DEFAULT 'Y'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT antrian_kategori_aktif_check CHECK (((aktif)::text = ANY ((ARRAY['Y'::character varying, 'N'::character varying])::text[])))
);


ALTER TABLE public.antrian_kategori OWNER TO postgres;

--
-- Name: antrian_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antrian_kategori_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antrian_kategori_id_seq OWNER TO postgres;

--
-- Name: antrian_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antrian_kategori_id_seq OWNED BY public.antrian_kategori.id;


--
-- Name: antrian_panggil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antrian_panggil (
    id bigint NOT NULL,
    antrian_kategori_id bigint NOT NULL,
    jumlah_antrian integer NOT NULL,
    jumlah_antrian_terpanggil integer DEFAULT 0 NOT NULL,
    tanggal date NOT NULL,
    waktu_ambil time(0) without time zone NOT NULL,
    waktu_selesai time(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    setting_layar_id bigint
);


ALTER TABLE public.antrian_panggil OWNER TO postgres;

--
-- Name: antrian_panggil_awalan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antrian_panggil_awalan (
    id bigint NOT NULL,
    nama_file text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.antrian_panggil_awalan OWNER TO postgres;

--
-- Name: antrian_panggil_awalan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antrian_panggil_awalan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antrian_panggil_awalan_id_seq OWNER TO postgres;

--
-- Name: antrian_panggil_awalan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antrian_panggil_awalan_id_seq OWNED BY public.antrian_panggil_awalan.id;


--
-- Name: antrian_panggil_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antrian_panggil_detail (
    id bigint NOT NULL,
    antrian_panggil_id bigint NOT NULL,
    antrian_detail_id bigint NOT NULL,
    awalan_panggil character(1),
    nomor_panggil smallint,
    status character varying(255) DEFAULT 'Menunggu'::character varying NOT NULL,
    waktu_panggil timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    waktu_selesai timestamp(0) without time zone,
    CONSTRAINT antrian_panggil_detail_status_check CHECK (((status)::text = ANY ((ARRAY['Menunggu'::character varying, 'Sedang Dilayani'::character varying, 'Selesai'::character varying])::text[])))
);


ALTER TABLE public.antrian_panggil_detail OWNER TO postgres;

--
-- Name: antrian_panggil_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antrian_panggil_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antrian_panggil_detail_id_seq OWNER TO postgres;

--
-- Name: antrian_panggil_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antrian_panggil_detail_id_seq OWNED BY public.antrian_panggil_detail.id;


--
-- Name: antrian_panggil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antrian_panggil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antrian_panggil_id_seq OWNER TO postgres;

--
-- Name: antrian_panggil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antrian_panggil_id_seq OWNED BY public.antrian_panggil.id;


--
-- Name: antrian_panggil_ulang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antrian_panggil_ulang (
    id bigint NOT NULL,
    setting_layar_id bigint NOT NULL,
    antrian_panggil_detail_id bigint NOT NULL,
    tangal_panggil_ulang date NOT NULL,
    waktu_panggil_ulang time(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.antrian_panggil_ulang OWNER TO postgres;

--
-- Name: antrian_panggil_ulang_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antrian_panggil_ulang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antrian_panggil_ulang_id_seq OWNER TO postgres;

--
-- Name: antrian_panggil_ulang_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antrian_panggil_ulang_id_seq OWNED BY public.antrian_panggil_ulang.id;


--
-- Name: antrian_tujuan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antrian_tujuan (
    id bigint NOT NULL,
    nama_antrian character varying(255) NOT NULL,
    nama_file character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.antrian_tujuan OWNER TO postgres;

--
-- Name: antrian_tujuan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antrian_tujuan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antrian_tujuan_id_seq OWNER TO postgres;

--
-- Name: antrian_tujuan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antrian_tujuan_id_seq OWNED BY public.antrian_tujuan.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: identitas_perusahaan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identitas_perusahaan (
    id bigint NOT NULL,
    nama_perusahaan character varying(255) NOT NULL,
    alamat character varying(255) NOT NULL,
    telepon character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    website character varying(255) NOT NULL,
    logo character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.identitas_perusahaan OWNER TO postgres;

--
-- Name: identitas_perusahaan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.identitas_perusahaan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.identitas_perusahaan_id_seq OWNER TO postgres;

--
-- Name: identitas_perusahaan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.identitas_perusahaan_id_seq OWNED BY public.identitas_perusahaan.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    id bigint NOT NULL,
    nama_menu character varying(255) NOT NULL,
    menu_kategori_id bigint NOT NULL,
    class character varying(255),
    url character varying(255),
    module_id bigint NOT NULL,
    aktif smallint DEFAULT '1'::smallint NOT NULL,
    new smallint DEFAULT '0'::smallint NOT NULL,
    urut smallint DEFAULT '0'::smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_id_seq OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_id_seq OWNED BY public.menu.id;


--
-- Name: menu_kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_kategori (
    id bigint NOT NULL,
    nama_kategori character varying(255) NOT NULL,
    deskripsi character varying(255) NOT NULL,
    aktif character varying(255) NOT NULL,
    show_title character varying(255) NOT NULL,
    urut smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT menu_kategori_aktif_check CHECK (((aktif)::text = ANY ((ARRAY['Y'::character varying, 'N'::character varying])::text[]))),
    CONSTRAINT menu_kategori_show_title_check CHECK (((show_title)::text = ANY ((ARRAY['Y'::character varying, 'N'::character varying])::text[])))
);


ALTER TABLE public.menu_kategori OWNER TO postgres;

--
-- Name: menu_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_kategori_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_kategori_id_seq OWNER TO postgres;

--
-- Name: menu_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_kategori_id_seq OWNED BY public.menu_kategori.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO postgres;

--
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO postgres;

--
-- Name: module; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.module (
    id bigint NOT NULL,
    nama_module character varying(255) NOT NULL,
    judul_module character varying(255) NOT NULL,
    model_status_id bigint NOT NULL,
    login character varying(255) DEFAULT 'Y'::character varying NOT NULL,
    deskripsi character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    CONSTRAINT module_login_check CHECK (((login)::text = ANY ((ARRAY['Y'::character varying, 'N'::character varying, 'R'::character varying])::text[])))
);


ALTER TABLE public.module OWNER TO postgres;

--
-- Name: module_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.module_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.module_id_seq OWNER TO postgres;

--
-- Name: module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.module_id_seq OWNED BY public.module.id;


--
-- Name: module_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.module_status (
    id bigint NOT NULL,
    nama_status character varying(255) NOT NULL,
    keterangan character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.module_status OWNER TO postgres;

--
-- Name: module_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.module_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.module_status_id_seq OWNER TO postgres;

--
-- Name: module_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.module_status_id_seq OWNED BY public.module_status.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: setting_layar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.setting_layar (
    id bigint NOT NULL,
    nama_layar character varying(255) NOT NULL,
    setting_printer_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.setting_layar OWNER TO postgres;

--
-- Name: setting_layar_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.setting_layar_detail (
    id bigint NOT NULL,
    setting_layar_id bigint NOT NULL,
    antrian_kategori_id bigint NOT NULL,
    urut smallint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.setting_layar_detail OWNER TO postgres;

--
-- Name: setting_layar_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.setting_layar_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.setting_layar_detail_id_seq OWNER TO postgres;

--
-- Name: setting_layar_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.setting_layar_detail_id_seq OWNED BY public.setting_layar_detail.id;


--
-- Name: setting_layar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.setting_layar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.setting_layar_id_seq OWNER TO postgres;

--
-- Name: setting_layar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.setting_layar_id_seq OWNED BY public.setting_layar.id;


--
-- Name: setting_printer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.setting_printer (
    id bigint NOT NULL,
    nama_printer character varying(255) NOT NULL,
    alamat_printer character varying(255) NOT NULL,
    aktif smallint DEFAULT '0'::smallint NOT NULL,
    feed_paper smallint DEFAULT '0'::smallint NOT NULL,
    orientation character varying(255) DEFAULT 'portrait'::character varying NOT NULL,
    font_size_width smallint DEFAULT '0'::smallint NOT NULL,
    font_size_height smallint DEFAULT '0'::smallint NOT NULL,
    autocat character varying(255) DEFAULT 'N'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT setting_printer_autocat_check CHECK (((autocat)::text = ANY ((ARRAY['Y'::character varying, 'N'::character varying])::text[]))),
    CONSTRAINT setting_printer_orientation_check CHECK (((orientation)::text = ANY ((ARRAY['portrait'::character varying, 'landscape'::character varying])::text[])))
);


ALTER TABLE public.setting_printer OWNER TO postgres;

--
-- Name: setting_printer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.setting_printer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.setting_printer_id_seq OWNER TO postgres;

--
-- Name: setting_printer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.setting_printer_id_seq OWNED BY public.setting_printer.id;


--
-- Name: user_antrian_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_antrian_detail (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    antrian_detail_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.user_antrian_detail OWNER TO postgres;

--
-- Name: user_antrian_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_antrian_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_antrian_detail_id_seq OWNER TO postgres;

--
-- Name: user_antrian_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_antrian_detail_id_seq OWNED BY public.user_antrian_detail.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    verified integer DEFAULT 0 NOT NULL,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    avatar character varying(255),
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT users_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying, 'banned'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: antrian_detail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_detail ALTER COLUMN id SET DEFAULT nextval('public.antrian_detail_id_seq'::regclass);


--
-- Name: antrian_kategori id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_kategori ALTER COLUMN id SET DEFAULT nextval('public.antrian_kategori_id_seq'::regclass);


--
-- Name: antrian_panggil id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil ALTER COLUMN id SET DEFAULT nextval('public.antrian_panggil_id_seq'::regclass);


--
-- Name: antrian_panggil_awalan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_awalan ALTER COLUMN id SET DEFAULT nextval('public.antrian_panggil_awalan_id_seq'::regclass);


--
-- Name: antrian_panggil_detail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_detail ALTER COLUMN id SET DEFAULT nextval('public.antrian_panggil_detail_id_seq'::regclass);


--
-- Name: antrian_panggil_ulang id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_ulang ALTER COLUMN id SET DEFAULT nextval('public.antrian_panggil_ulang_id_seq'::regclass);


--
-- Name: antrian_tujuan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_tujuan ALTER COLUMN id SET DEFAULT nextval('public.antrian_tujuan_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: identitas_perusahaan id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identitas_perusahaan ALTER COLUMN id SET DEFAULT nextval('public.identitas_perusahaan_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: menu id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN id SET DEFAULT nextval('public.menu_id_seq'::regclass);


--
-- Name: menu_kategori id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_kategori ALTER COLUMN id SET DEFAULT nextval('public.menu_kategori_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: module id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module ALTER COLUMN id SET DEFAULT nextval('public.module_id_seq'::regclass);


--
-- Name: module_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_status ALTER COLUMN id SET DEFAULT nextval('public.module_status_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: setting_layar id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_layar ALTER COLUMN id SET DEFAULT nextval('public.setting_layar_id_seq'::regclass);


--
-- Name: setting_layar_detail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_layar_detail ALTER COLUMN id SET DEFAULT nextval('public.setting_layar_detail_id_seq'::regclass);


--
-- Name: setting_printer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_printer ALTER COLUMN id SET DEFAULT nextval('public.setting_printer_id_seq'::regclass);


--
-- Name: user_antrian_detail id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_antrian_detail ALTER COLUMN id SET DEFAULT nextval('public.user_antrian_detail_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: antrian_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antrian_detail (id, antrian_kategori_id, antrian_tujuan_id, aktif, created_at, updated_at, deleted_at) FROM stdin;
2	1	5	Y	2025-02-25 15:39:45	2025-02-25 15:39:45	\N
3	2	5	Y	2025-02-25 15:39:50	2025-02-25 15:39:50	\N
4	3	5	Y	2025-02-25 15:39:54	2025-02-25 15:39:54	\N
5	8	1	Y	2025-02-26 02:33:33	2025-02-26 02:33:33	\N
\.


--
-- Data for Name: antrian_kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antrian_kategori (id, nama_kategori, awalan, aktif, created_at, updated_at, deleted_at) FROM stdin;
1	BPJS Non Racikan	A	Y	\N	\N	\N
2	BPJS Racikan	B	Y	\N	\N	\N
3	Pasien Umum Dan Asuransi	C	Y	\N	\N	\N
4	Poliklinik Gigi Dan Mulut	D	Y	\N	\N	\N
5	Poliklinik Ibu Dan Anak	E	Y	\N	\N	\N
6	Poliklinik Kebidanan	F	Y	\N	\N	\N
7	Poliklinik Mata	G	Y	\N	\N	\N
8	Counter	H	Y	\N	\N	\N
\.


--
-- Data for Name: antrian_panggil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antrian_panggil (id, antrian_kategori_id, jumlah_antrian, jumlah_antrian_terpanggil, tanggal, waktu_ambil, waktu_selesai, created_at, updated_at, deleted_at, setting_layar_id) FROM stdin;
29	3	1	0	2025-03-05	04:13:13	\N	2025-03-05 04:13:13	2025-03-05 04:13:13	\N	1
28	2	2	0	2025-03-05	04:13:05	\N	2025-03-05 04:13:05	2025-03-05 05:44:20	\N	1
27	1	38	16	2025-03-05	04:12:51	\N	2025-03-05 04:12:51	2025-03-05 08:10:30	\N	1
31	1	3	0	2025-03-06	01:43:10	\N	2025-03-06 01:43:10	2025-03-06 01:43:33	\N	1
\.


--
-- Data for Name: antrian_panggil_awalan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antrian_panggil_awalan (id, nama_file, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: antrian_panggil_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antrian_panggil_detail (id, antrian_panggil_id, antrian_detail_id, awalan_panggil, nomor_panggil, status, waktu_panggil, created_at, updated_at, deleted_at, waktu_selesai) FROM stdin;
358	28	3	B	1	Menunggu	2025-03-05 04:13:05	2025-03-05 04:13:05	2025-03-05 04:13:05	\N	\N
359	29	4	C	1	Menunggu	2025-03-05 04:13:13	2025-03-05 04:13:13	2025-03-05 04:13:13	\N	\N
375	27	2	A	16	Selesai	2025-03-05 08:00:48	2025-03-05 06:44:04	2025-03-05 08:10:30	\N	2025-03-05 08:10:30
357	27	2	A	1	Selesai	2025-03-05 04:13:31	2025-03-05 04:12:51	2025-03-05 05:40:05	\N	2025-03-05 05:40:05
376	27	2	A	17	Sedang Dilayani	2025-03-05 08:10:30	2025-03-05 06:47:21	2025-03-05 08:10:30	\N	\N
363	28	3	B	2	Menunggu	2025-03-05 05:44:20	2025-03-05 05:44:20	2025-03-05 05:44:20	\N	\N
360	27	2	A	2	Selesai	2025-03-05 05:40:05	2025-03-05 05:36:34	2025-03-05 06:28:41	\N	2025-03-05 06:28:41
361	27	2	A	3	Selesai	2025-03-05 06:28:41	2025-03-05 05:37:09	2025-03-05 06:28:48	\N	2025-03-05 06:28:48
399	31	2	A	1	Menunggu	2025-03-06 01:43:10	2025-03-06 01:43:10	2025-03-06 01:43:10	\N	\N
362	27	2	A	4	Selesai	2025-03-05 06:28:48	2025-03-05 05:37:14	2025-03-05 06:43:46	\N	2025-03-05 06:43:46
400	31	2	A	2	Menunggu	2025-03-06 01:43:20	2025-03-06 01:43:20	2025-03-06 01:43:20	\N	\N
377	27	2	A	18	Menunggu	2025-03-05 07:08:30	2025-03-05 07:08:30	2025-03-05 07:08:30	\N	\N
364	27	2	A	5	Selesai	2025-03-05 06:43:46	2025-03-05 05:45:12	2025-03-05 07:08:55	\N	2025-03-05 07:08:55
378	27	2	A	19	Menunggu	2025-03-05 07:11:34	2025-03-05 07:11:34	2025-03-05 07:11:34	\N	\N
379	27	2	A	20	Menunggu	2025-03-05 07:12:51	2025-03-05 07:12:51	2025-03-05 07:12:51	\N	\N
380	27	2	A	21	Menunggu	2025-03-05 07:18:42	2025-03-05 07:18:42	2025-03-05 07:18:42	\N	\N
381	27	2	A	22	Menunggu	2025-03-05 07:19:19	2025-03-05 07:19:19	2025-03-05 07:19:19	\N	\N
365	27	2	A	6	Selesai	2025-03-05 07:08:55	2025-03-05 05:45:24	2025-03-05 07:19:40	\N	2025-03-05 07:19:40
382	27	2	A	23	Menunggu	2025-03-05 07:19:52	2025-03-05 07:19:52	2025-03-05 07:19:52	\N	\N
383	27	2	A	24	Menunggu	2025-03-05 07:22:08	2025-03-05 07:22:08	2025-03-05 07:22:08	\N	\N
384	27	2	A	25	Menunggu	2025-03-05 07:25:39	2025-03-05 07:25:39	2025-03-05 07:25:39	\N	\N
385	27	2	A	26	Menunggu	2025-03-05 07:26:52	2025-03-05 07:26:52	2025-03-05 07:26:52	\N	\N
386	27	2	A	27	Menunggu	2025-03-05 07:28:03	2025-03-05 07:28:03	2025-03-05 07:28:03	\N	\N
387	27	2	A	28	Menunggu	2025-03-05 07:32:38	2025-03-05 07:32:38	2025-03-05 07:32:38	\N	\N
388	27	2	A	29	Menunggu	2025-03-05 07:33:29	2025-03-05 07:33:29	2025-03-05 07:33:29	\N	\N
389	27	2	A	30	Menunggu	2025-03-05 07:37:13	2025-03-05 07:37:13	2025-03-05 07:37:13	\N	\N
390	27	2	A	31	Menunggu	2025-03-05 07:37:20	2025-03-05 07:37:20	2025-03-05 07:37:20	\N	\N
391	27	2	A	32	Menunggu	2025-03-05 07:37:26	2025-03-05 07:37:26	2025-03-05 07:37:26	\N	\N
392	27	2	A	33	Menunggu	2025-03-05 07:37:47	2025-03-05 07:37:47	2025-03-05 07:37:47	\N	\N
366	27	2	A	7	Selesai	2025-03-05 07:19:40	2025-03-05 05:52:59	2025-03-05 07:42:45	\N	2025-03-05 07:42:45
403	31	2	A	3	Menunggu	2025-03-06 01:43:33	2025-03-06 01:43:33	2025-03-06 01:43:33	\N	\N
367	27	2	A	8	Selesai	2025-03-05 07:42:45	2025-03-05 05:53:16	2025-03-05 07:42:50	\N	2025-03-05 07:42:50
393	27	2	A	34	Menunggu	2025-03-05 07:48:40	2025-03-05 07:48:40	2025-03-05 07:48:40	\N	\N
394	27	2	A	35	Menunggu	2025-03-05 07:49:10	2025-03-05 07:49:10	2025-03-05 07:49:10	\N	\N
368	27	2	A	9	Selesai	2025-03-05 07:42:50	2025-03-05 06:01:12	2025-03-05 07:49:21	\N	2025-03-05 07:49:21
395	27	2	A	36	Menunggu	2025-03-05 07:50:48	2025-03-05 07:50:48	2025-03-05 07:50:48	\N	\N
396	27	2	A	37	Menunggu	2025-03-05 07:50:53	2025-03-05 07:50:53	2025-03-05 07:50:53	\N	\N
369	27	2	A	10	Selesai	2025-03-05 07:49:21	2025-03-05 06:02:09	2025-03-05 07:51:00	\N	2025-03-05 07:51:00
397	27	2	A	38	Menunggu	2025-03-05 07:59:32	2025-03-05 07:59:32	2025-03-05 07:59:32	\N	\N
370	27	2	A	11	Selesai	2025-03-05 07:51:00	2025-03-05 06:28:10	2025-03-05 07:59:56	\N	2025-03-05 07:59:56
371	27	2	A	12	Selesai	2025-03-05 07:59:56	2025-03-05 06:28:56	2025-03-05 08:00:02	\N	2025-03-05 08:00:02
372	27	2	A	13	Selesai	2025-03-05 08:00:02	2025-03-05 06:31:00	2025-03-05 08:00:09	\N	2025-03-05 08:00:09
373	27	2	A	14	Selesai	2025-03-05 08:00:09	2025-03-05 06:31:55	2025-03-05 08:00:16	\N	2025-03-05 08:00:16
374	27	2	A	15	Selesai	2025-03-05 08:00:16	2025-03-05 06:35:13	2025-03-05 08:00:48	\N	2025-03-05 08:00:48
\.


--
-- Data for Name: antrian_panggil_ulang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antrian_panggil_ulang (id, setting_layar_id, antrian_panggil_detail_id, tangal_panggil_ulang, waktu_panggil_ulang, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: antrian_tujuan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antrian_tujuan (id, nama_antrian, nama_file, created_at, updated_at, deleted_at) FROM stdin;
1	Counter 2	["1740497374_dua.wav","1740497374_counter.wav"]	2025-02-25 15:29:35	2025-02-25 15:29:35	\N
2	Poliklinik Kebidana	["1740497530_kebidanan.wav"]	2025-02-25 15:32:10	2025-02-25 15:32:10	\N
3	Poliklinik Gigi Dana Mulut	["1740497550_gigi_dan_mulut.wav"]	2025-02-25 15:32:30	2025-02-25 15:32:30	\N
4	Counter 1	["1740497581_counter.wav","1740497581_satu.wav"]	2025-02-25 15:33:01	2025-02-25 15:33:01	\N
5	Apotek	["1740497967_counter.wav"]	2025-02-25 15:39:27	2025-02-25 15:39:27	\N
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
illuminate:queue:restart	i:1740975340;	2056335340
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
259	a51e2651-1f79-4eeb-b842-032ea4370fa5	database	default	{"uuid":"a51e2651-1f79-4eeb-b842-032ea4370fa5","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:18;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:25:41
260	7115c8ac-4027-4297-b673-5c25e52428ef	database	default	{"uuid":"7115c8ac-4027-4297-b673-5c25e52428ef","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:19;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:26:53
261	2572d8bf-e097-4c05-b352-da033d96f9b7	database	default	{"uuid":"2572d8bf-e097-4c05-b352-da033d96f9b7","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:20;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:28:06
262	921a870d-7865-4541-b01d-40627ba6927b	database	default	{"uuid":"921a870d-7865-4541-b01d-40627ba6927b","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:21;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:32:40
263	bd9fce17-c476-4024-9128-ab1737e8e8a2	database	default	{"uuid":"bd9fce17-c476-4024-9128-ab1737e8e8a2","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:22;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:33:31
264	7be8a1fb-0cb1-45e6-b674-5ea86e1dcbe7	database	default	{"uuid":"7be8a1fb-0cb1-45e6-b674-5ea86e1dcbe7","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:23;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:37:14
265	b13a1a7a-f8f0-477a-81cc-88d3404775ca	database	default	{"uuid":"b13a1a7a-f8f0-477a-81cc-88d3404775ca","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:24;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:37:21
266	49fd0088-5723-4c17-90ab-0bd37d300e02	database	default	{"uuid":"49fd0088-5723-4c17-90ab-0bd37d300e02","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:25;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:37:27
267	58efb279-afc4-48c9-9cae-c18710a239c6	database	default	{"uuid":"58efb279-afc4-48c9-9cae-c18710a239c6","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:26;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:2;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:1;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:37:48
268	a6690fe1-f403-48f7-9f75-e541ad9ddde8	database	default	{"uuid":"a6690fe1-f403-48f7-9f75-e541ad9ddde8","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:25;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:25;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:25;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:48:42
269	60899a3a-5fc7-440e-8c61-86ef44e80bd7	database	default	{"uuid":"60899a3a-5fc7-440e-8c61-86ef44e80bd7","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:26;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:26;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:26;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:49:12
270	868c86b6-4cb9-4cdd-ad12-f79d74040fe8	database	default	{"uuid":"868c86b6-4cb9-4cdd-ad12-f79d74040fe8","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:26;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:26;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:26;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:50:49
271	5c6995e4-7d9a-45bf-b891-1f7d0a1391ee	database	default	{"uuid":"5c6995e4-7d9a-45bf-b891-1f7d0a1391ee","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:27;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:27;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:27;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:50:55
272	f4d7d044-fa40-4822-98bf-9de59f8873a2	database	default	{"uuid":"f4d7d044-fa40-4822-98bf-9de59f8873a2","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:27;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:27;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:27;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Pusher\\PusherException: Invalid channel name antrian.Layar Apotik in D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php:209\nStack trace:\n#0 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(195): Pusher\\Pusher->validate_channel('antrian.Layar A...')\n#1 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(1139): Pusher\\Pusher->validate_channels(Array)\n#2 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\pusher\\pusher-php-server\\src\\Pusher.php(439): Pusher\\Pusher->make_trigger_body(Array, 'AntrianAmbilUpd...', Array, Array, false)\n#3 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(161): Pusher\\Pusher->trigger(Array, 'AntrianAmbilUpd...', Array, Array)\n#4 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(261): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->Illuminate\\Broadcasting\\Broadcasters\\{closure}(Object(Illuminate\\Support\\Collection), 0)\n#5 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php(160): Illuminate\\Support\\Collection->each(Object(Closure))\n#6 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), 'AntrianAmbilUpd...', Array)\n#7 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#8 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#9 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#10 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#11 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#12 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#13 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#14 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#16 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#17 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#18 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#19 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#21 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#22 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#23 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process('database', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#24 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 'database', Object(Illuminate\\Queue\\WorkerOptions))\n#25 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon('database', 'default', Object(Illuminate\\Queue\\WorkerOptions))\n#26 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker('database', 'default')\n#27 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#28 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#29 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#30 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#31 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#32 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#33 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#34 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#35 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#39 D:\\laragon\\www\\AplikasiAntrian\\Backend\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 D:\\laragon\\www\\AplikasiAntrian\\Backend\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#41 {main}	2025-03-05 07:59:33
\.


--
-- Data for Name: identitas_perusahaan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identitas_perusahaan (id, nama_perusahaan, alamat, telepon, email, website, logo, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
495	default	{"uuid":"e56bf8d6-3a9b-4032-9609-908360fc81c8","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:24;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:24;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:24;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	0	\N	1741225413	1741225413
496	default	{"uuid":"1c3b0089-5179-400c-a8bd-cbdfbca2fcf8","displayName":"App\\\\Events\\\\AntrianDiambil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:25:\\"App\\\\Events\\\\AntrianDiambil\\":6:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"namaKategori\\";s:16:\\"BPJS Non Racikan\\";s:11:\\"sisaAntrian\\";i:24;s:13:\\"jumlahAntrian\\";i:3;s:13:\\"awalanPanggil\\";s:1:\\"A\\";s:12:\\"nomorPanggil\\";i:3;}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	0	\N	1741225413	1741225413
491	default	{"uuid":"56d0b9cc-2c04-4465-bf42-95f78073a40f","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:22;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:22;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:22;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	0	\N	1741225393	1741225393
492	default	{"uuid":"5c9a480c-7b30-47c1-b1dd-1dacf4be7aea","displayName":"App\\\\Events\\\\AntrianDiambil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:25:\\"App\\\\Events\\\\AntrianDiambil\\":6:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"namaKategori\\";s:16:\\"BPJS Non Racikan\\";s:11:\\"sisaAntrian\\";i:22;s:13:\\"jumlahAntrian\\";i:1;s:13:\\"awalanPanggil\\";s:1:\\"A\\";s:12:\\"nomorPanggil\\";i:1;}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	0	\N	1741225394	1741225394
493	default	{"uuid":"f5755af2-b2d5-4250-a60f-134648da9789","displayName":"App\\\\Events\\\\AntrianSisaAmbil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:27:\\"App\\\\Events\\\\AntrianSisaAmbil\\":2:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"kategoriData\\";a:3:{i:0;a:4:{s:13:\\"nama_kategori\\";s:16:\\"BPJS Non Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:23;s:4:\\"urut\\";i:1;}i:1;a:4:{s:13:\\"nama_kategori\\";s:12:\\"BPJS Racikan\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:23;s:4:\\"urut\\";i:2;}i:2;a:4:{s:13:\\"nama_kategori\\";s:24:\\"Pasien Umum Dan Asuransi\\";s:14:\\"tujuan_antrian\\";s:6:\\"Apotek\\";s:12:\\"sisa_antrian\\";i:23;s:4:\\"urut\\";i:3;}}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	0	\N	1741225400	1741225400
494	default	{"uuid":"1b520b00-6add-4621-adf1-d59328540761","displayName":"App\\\\Events\\\\AntrianDiambil","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:25:\\"App\\\\Events\\\\AntrianDiambil\\":6:{s:9:\\"namaLayar\\";s:12:\\"Layar Apotik\\";s:12:\\"namaKategori\\";s:16:\\"BPJS Non Racikan\\";s:11:\\"sisaAntrian\\";i:23;s:13:\\"jumlahAntrian\\";i:2;s:13:\\"awalanPanggil\\";s:1:\\"A\\";s:12:\\"nomorPanggil\\";i:2;}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	0	\N	1741225400	1741225400
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (id, nama_menu, menu_kategori_id, class, url, module_id, aktif, new, urut, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: menu_kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_kategori (id, nama_kategori, deskripsi, aktif, show_title, urut, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2025_02_14_021416_create_permission_tables	1
5	2025_02_14_022331_create_identitas_perusahaan_table	1
6	2025_02_14_022647_create_antrian_kategori_table	1
7	2025_02_14_022956_create_antrian_tujuan_table	1
8	2025_02_14_023152_create_antrian_detail_table	1
9	2025_02_14_023353_create_antrian_panggil_table	1
10	2025_02_14_023906_create_antrian_panggil_awalan_table	1
11	2025_02_14_024027_create_antrian_panggil_detail_table	1
12	2025_02_14_024332_create_setting_printer_table	1
13	2025_02_14_024333_create_setting_layar_table	1
14	2025_02_14_025256_create_user_antrian_detail_table	1
15	2025_02_14_042536_create_personal_access_tokens_table	1
16	2025_02_15_093313_alter_antrian_tujuan_table	2
17	2025_02_17_044843_create_antrian_panggil_ulang_table	2
18	2025_02_17_054548_create_menu_kategori_table	2
19	2025_02_17_054549_create_module_status_table	2
20	2025_02_17_054550_create_module	2
21	2025_02_17_054555_create_menu_table	2
22	2025_02_25_155729_create_setting_layar_detail_table	3
23	2025_03_01_035536_add_setting_layar_id_to_antrian_panggil_table	4
24	2025_03_01_071152_add_waktu_selesai_to_antrian_panggil_table	5
\.


--
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
\.


--
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
\.


--
-- Data for Name: module; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.module (id, nama_module, judul_module, model_status_id, login, deskripsi, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: module_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.module_status (id, nama_status, keterangan, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, name, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
mtF7PNpClvHOvMV4Ovces41bj8UcKGkaEKiPwkhe	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiU0dncmV5a2VYT29CN1hSNkJJSjhYVmpFUUFhSWdIWTJENVVVbGRJWiI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC90ZXN0LWJyb2FkY2FzdCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1740980559
\.


--
-- Data for Name: setting_layar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.setting_layar (id, nama_layar, setting_printer_id, created_at, updated_at, deleted_at) FROM stdin;
1	Layar Apotik	1	2025-02-25 16:04:56	2025-02-25 16:04:56	\N
2	Layar Counter	1	2025-02-25 16:05:06	2025-02-25 16:05:06	\N
3	Layar Pendaftaran	1	2025-02-25 16:05:16	2025-02-25 16:05:16	\N
\.


--
-- Data for Name: setting_layar_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.setting_layar_detail (id, setting_layar_id, antrian_kategori_id, urut, created_at, updated_at, deleted_at) FROM stdin;
4	1	1	1	2025-02-25 16:44:13	2025-02-25 16:44:13	\N
5	1	2	2	2025-02-25 16:44:20	2025-02-25 16:44:20	\N
6	1	3	3	2025-02-25 16:44:27	2025-02-25 16:44:27	\N
7	2	8	1	2025-02-25 16:45:12	2025-02-25 16:45:12	\N
\.


--
-- Data for Name: setting_printer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.setting_printer (id, nama_printer, alamat_printer, aktif, feed_paper, orientation, font_size_width, font_size_height, autocat, created_at, updated_at) FROM stdin;
1	Printer C	192.168.1.12	0	5	portrait	14	16	Y	2025-02-25 16:04:33	2025-02-25 16:04:33
\.


--
-- Data for Name: user_antrian_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_antrian_detail (id, user_id, antrian_detail_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, username, email, email_verified_at, password, verified, status, avatar, remember_token, created_at, updated_at) FROM stdin;
\.


--
-- Name: antrian_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antrian_detail_id_seq', 5, true);


--
-- Name: antrian_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antrian_kategori_id_seq', 8, true);


--
-- Name: antrian_panggil_awalan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antrian_panggil_awalan_id_seq', 1, false);


--
-- Name: antrian_panggil_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antrian_panggil_detail_id_seq', 403, true);


--
-- Name: antrian_panggil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antrian_panggil_id_seq', 33, true);


--
-- Name: antrian_panggil_ulang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antrian_panggil_ulang_id_seq', 4, true);


--
-- Name: antrian_tujuan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antrian_tujuan_id_seq', 5, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 272, true);


--
-- Name: identitas_perusahaan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.identitas_perusahaan_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 496, true);


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_id_seq', 1, false);


--
-- Name: menu_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_kategori_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 24, true);


--
-- Name: module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.module_id_seq', 1, false);


--
-- Name: module_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.module_status_id_seq', 1, false);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- Name: setting_layar_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.setting_layar_detail_id_seq', 33, true);


--
-- Name: setting_layar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.setting_layar_id_seq', 3, true);


--
-- Name: setting_printer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.setting_printer_id_seq', 1, true);


--
-- Name: user_antrian_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_antrian_detail_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: antrian_detail antrian_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_detail
    ADD CONSTRAINT antrian_detail_pkey PRIMARY KEY (id);


--
-- Name: antrian_kategori antrian_kategori_nama_kategori_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_kategori
    ADD CONSTRAINT antrian_kategori_nama_kategori_unique UNIQUE (nama_kategori);


--
-- Name: antrian_kategori antrian_kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_kategori
    ADD CONSTRAINT antrian_kategori_pkey PRIMARY KEY (id);


--
-- Name: antrian_panggil_awalan antrian_panggil_awalan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_awalan
    ADD CONSTRAINT antrian_panggil_awalan_pkey PRIMARY KEY (id);


--
-- Name: antrian_panggil_detail antrian_panggil_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_detail
    ADD CONSTRAINT antrian_panggil_detail_pkey PRIMARY KEY (id);


--
-- Name: antrian_panggil antrian_panggil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil
    ADD CONSTRAINT antrian_panggil_pkey PRIMARY KEY (id);


--
-- Name: antrian_panggil_ulang antrian_panggil_ulang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_ulang
    ADD CONSTRAINT antrian_panggil_ulang_pkey PRIMARY KEY (id);


--
-- Name: antrian_tujuan antrian_tujuan_nama_antrian_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_tujuan
    ADD CONSTRAINT antrian_tujuan_nama_antrian_unique UNIQUE (nama_antrian);


--
-- Name: antrian_tujuan antrian_tujuan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_tujuan
    ADD CONSTRAINT antrian_tujuan_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: identitas_perusahaan identitas_perusahaan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identitas_perusahaan
    ADD CONSTRAINT identitas_perusahaan_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: menu_kategori menu_kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_kategori
    ADD CONSTRAINT menu_kategori_pkey PRIMARY KEY (id);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- Name: module module_nama_module_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module
    ADD CONSTRAINT module_nama_module_unique UNIQUE (nama_module);


--
-- Name: module module_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module
    ADD CONSTRAINT module_pkey PRIMARY KEY (id);


--
-- Name: module_status module_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module_status
    ADD CONSTRAINT module_status_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: setting_layar_detail setting_layar_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_layar_detail
    ADD CONSTRAINT setting_layar_detail_pkey PRIMARY KEY (id);


--
-- Name: setting_layar setting_layar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_layar
    ADD CONSTRAINT setting_layar_pkey PRIMARY KEY (id);


--
-- Name: setting_printer setting_printer_nama_printer_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_printer
    ADD CONSTRAINT setting_printer_nama_printer_unique UNIQUE (nama_printer);


--
-- Name: setting_printer setting_printer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_printer
    ADD CONSTRAINT setting_printer_pkey PRIMARY KEY (id);


--
-- Name: user_antrian_detail user_antrian_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_antrian_detail
    ADD CONSTRAINT user_antrian_detail_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: antrian_detail antrian_detail_antrian_kategori_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_detail
    ADD CONSTRAINT antrian_detail_antrian_kategori_id_foreign FOREIGN KEY (antrian_kategori_id) REFERENCES public.antrian_kategori(id) ON DELETE CASCADE;


--
-- Name: antrian_detail antrian_detail_antrian_tujuan_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_detail
    ADD CONSTRAINT antrian_detail_antrian_tujuan_id_foreign FOREIGN KEY (antrian_tujuan_id) REFERENCES public.antrian_tujuan(id) ON DELETE CASCADE;


--
-- Name: antrian_panggil antrian_panggil_antrian_kategori_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil
    ADD CONSTRAINT antrian_panggil_antrian_kategori_id_foreign FOREIGN KEY (antrian_kategori_id) REFERENCES public.antrian_kategori(id) ON DELETE CASCADE;


--
-- Name: antrian_panggil_detail antrian_panggil_detail_antrian_detail_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_detail
    ADD CONSTRAINT antrian_panggil_detail_antrian_detail_id_foreign FOREIGN KEY (antrian_detail_id) REFERENCES public.antrian_detail(id) ON DELETE CASCADE;


--
-- Name: antrian_panggil_detail antrian_panggil_detail_antrian_panggil_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_detail
    ADD CONSTRAINT antrian_panggil_detail_antrian_panggil_id_foreign FOREIGN KEY (antrian_panggil_id) REFERENCES public.antrian_panggil(id) ON DELETE CASCADE;


--
-- Name: antrian_panggil antrian_panggil_setting_layar_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil
    ADD CONSTRAINT antrian_panggil_setting_layar_id_foreign FOREIGN KEY (setting_layar_id) REFERENCES public.setting_layar(id) ON DELETE CASCADE;


--
-- Name: antrian_panggil_ulang antrian_panggil_ulang_antrian_panggil_detail_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_ulang
    ADD CONSTRAINT antrian_panggil_ulang_antrian_panggil_detail_id_foreign FOREIGN KEY (antrian_panggil_detail_id) REFERENCES public.antrian_panggil_detail(id) ON DELETE CASCADE;


--
-- Name: antrian_panggil_ulang antrian_panggil_ulang_setting_layar_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antrian_panggil_ulang
    ADD CONSTRAINT antrian_panggil_ulang_setting_layar_id_foreign FOREIGN KEY (setting_layar_id) REFERENCES public.setting_layar(id) ON DELETE CASCADE;


--
-- Name: menu menu_menu_kategori_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_menu_kategori_id_foreign FOREIGN KEY (menu_kategori_id) REFERENCES public.menu_kategori(id) ON DELETE CASCADE;


--
-- Name: menu menu_module_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_module_id_foreign FOREIGN KEY (module_id) REFERENCES public.module(id) ON DELETE CASCADE;


--
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: module module_model_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.module
    ADD CONSTRAINT module_model_status_id_foreign FOREIGN KEY (model_status_id) REFERENCES public.module_status(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: setting_layar_detail setting_layar_detail_antrian_kategori_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_layar_detail
    ADD CONSTRAINT setting_layar_detail_antrian_kategori_id_foreign FOREIGN KEY (antrian_kategori_id) REFERENCES public.antrian_kategori(id) ON DELETE CASCADE;


--
-- Name: setting_layar_detail setting_layar_detail_setting_layar_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_layar_detail
    ADD CONSTRAINT setting_layar_detail_setting_layar_id_foreign FOREIGN KEY (setting_layar_id) REFERENCES public.setting_layar(id) ON DELETE CASCADE;


--
-- Name: setting_layar setting_layar_setting_printer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.setting_layar
    ADD CONSTRAINT setting_layar_setting_printer_id_foreign FOREIGN KEY (setting_printer_id) REFERENCES public.setting_printer(id) ON DELETE CASCADE;


--
-- Name: user_antrian_detail user_antrian_detail_antrian_detail_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_antrian_detail
    ADD CONSTRAINT user_antrian_detail_antrian_detail_id_foreign FOREIGN KEY (antrian_detail_id) REFERENCES public.antrian_detail(id) ON DELETE CASCADE;


--
-- Name: user_antrian_detail user_antrian_detail_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_antrian_detail
    ADD CONSTRAINT user_antrian_detail_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

