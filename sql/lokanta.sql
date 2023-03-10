--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2022-12-26 16:27:13

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
-- TOC entry 246 (class 1255 OID 16920)
-- Name: adresekle(integer, integer, integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.adresekle(IN ilce integer, IN mahalle integer, IN sokak integer, IN girisdetay character varying)
    LANGUAGE plpgsql
    AS $$
begin
insert into adres values(ilce+mahalle+sokak,ilce,mahalle,sokak,girisDetay);
end;$$;


ALTER PROCEDURE public.adresekle(IN ilce integer, IN mahalle integer, IN sokak integer, IN girisdetay character varying) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 17221)
-- Name: fiyat_guncelleme(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fiyat_guncelleme() RETURNS trigger
    LANGUAGE plpgsql
    AS $$  
BEGIN  
    IF NEW."fiyati" <> OLD."fiyati" THEN  
         INSERT INTO eskifiyatlistesi("urunNo","adi","kalori","fiyati","kategori","degistirmezamani" )  
         VALUES(OLD."urunNo",OLD."adi", OLD."kalori",OLD."fiyati",OLD."kategori",now());  
    END IF;  
RETURN NEW;  
END;  
$$;


ALTER FUNCTION public.fiyat_guncelleme() OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 17206)
-- Name: malzeme_değişiklikleri(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."malzeme_değişiklikleri"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$  
BEGIN  
    IF NEW."miktar" <> OLD."miktar" THEN  
         INSERT INTO depo("malzemeno","adi","miktar","tedarikcino","degistirmezamani" )  
         VALUES(OLD."malzemeno",OLD."adi", OLD."miktar",OLD."tedarikcino",now());  
    END IF;  
RETURN NEW;  
END;  
$$;


ALTER FUNCTION public."malzeme_değişiklikleri"() OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 17199)
-- Name: personal_gorevi_değişiklikleri(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."personal_gorevi_değişiklikleri"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$  
BEGIN  
    IF NEW."gorevi" <> OLD."gorevi" THEN  
         INSERT INTO personal_degismeler("personalno","adi","soyadi","gorevi","degistirmezamani" )  
         VALUES(OLD."personalNo",OLD."adi", OLD."soyadi",OLD."gorevi",now());  
    END IF;  
RETURN NEW;  
END;  
$$;


ALTER FUNCTION public."personal_gorevi_değişiklikleri"() OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 17193)
-- Name: personallersiniflendir(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.personallersiniflendir(personel_tipi character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$  
Declare  
Begin  
   return  count("gorevi")   
   from personal  
   where gorevi = personel_tipi;  
End;  
$$;


ALTER FUNCTION public.personallersiniflendir(personel_tipi character varying) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 17172)
-- Name: personelsayisihesapla(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.personelsayisihesapla() RETURNS integer
    LANGUAGE plpgsql
    AS $$  
Declare  
 personel_sayisi integer;  
Begin  
   select count(*) 
   into personel_sayisi
   from personal  ;
   return personel_sayisi;  
End;  
$$;


ALTER FUNCTION public.personelsayisihesapla() OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 17229)
-- Name: sifre_guncelleme(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sifre_guncelleme() RETURNS trigger
    LANGUAGE plpgsql
    AS $$  
BEGIN  
    IF NEW."sifresi" <> OLD."sifresi" THEN  
         INSERT INTO yoneticisifresi("yoneticiNo","adi","soyadi","sifresi","degistirmezamani" )  
         VALUES(OLD."yoneticiNo",OLD."adi", OLD."soyadi",OLD."sifresi",now());  
    END IF;  
RETURN NEW;  
END;  
$$;


ALTER FUNCTION public.sifre_guncelleme() OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 17214)
-- Name: silinen_adresler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.silinen_adresler() RETURNS trigger
    LANGUAGE plpgsql
    AS $$  
BEGIN  
--     IF NEW."adresKodu" <> OLD."adresKodu" THEN  
         INSERT INTO silinenadres("adresKodu","ilceKodu","mahalleKodu","sokakNo","girisDetay","degistirmezamani" )  
         VALUES(OLD."adresKodu",OLD."ilceKodu", OLD."mahalleKodu",OLD."sokakNo",OLD."girisDetay",now());  
--     END IF;  
RETURN NEW;  
END;  
$$;


ALTER FUNCTION public.silinen_adresler() OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 16921)
-- Name: urunlistesiekle(integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.urunlistesiekle(IN sparisno integer, IN urunno integer, IN adet integer)
    LANGUAGE plpgsql
    AS $$
	declare 
	fiyat int;
	tutar int;
begin
fiyat:= (select fiyati where "urun"."urunNo" = urunNo);
tutar:= adet*fiyat;
insert into adres values(sparisNo,urunNo,adet,tutar);
end;$$;


ALTER PROCEDURE public.urunlistesiekle(IN sparisno integer, IN urunno integer, IN adet integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 211 (class 1259 OID 16922)
-- Name: adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adres (
    "adresKodu" integer NOT NULL,
    "ilceKodu" integer NOT NULL,
    "mahalleKodu" integer NOT NULL,
    "sokakNo" integer NOT NULL,
    "girisDetay" character varying(100) NOT NULL
);


ALTER TABLE public.adres OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16925)
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    "ilceKodu" integer NOT NULL,
    adi character varying(25) NOT NULL
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16928)
-- Name: mahalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mahalle (
    "mahalleKodu" integer NOT NULL,
    adi character varying(25) NOT NULL
);


ALTER TABLE public.mahalle OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16931)
-- Name: sokak; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sokak (
    "sokakNo" integer NOT NULL,
    adi character varying(25) NOT NULL
);


ALTER TABLE public.sokak OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16934)
-- Name: adresgoruntusu; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.adresgoruntusu AS
 SELECT adres."adresKodu",
    ilce.adi AS ilce,
    mahalle.adi AS mahelle,
    sokak.adi AS sokak,
    adres."girisDetay"
   FROM (((public.adres
     JOIN public.ilce ON ((adres."ilceKodu" = ilce."ilceKodu")))
     JOIN public.mahalle ON ((adres."mahalleKodu" = mahalle."mahalleKodu")))
     JOIN public.sokak ON ((adres."sokakNo" = sokak."sokakNo")));


ALTER TABLE public.adresgoruntusu OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16938)
-- Name: urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urun (
    "urunNo" integer NOT NULL,
    adi character varying(40) NOT NULL,
    kalori integer NOT NULL,
    fiyati integer NOT NULL,
    kategori "char" NOT NULL
);


ALTER TABLE public.urun OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16941)
-- Name: anayemek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anayemek (
    "servisSekli" character varying(50),
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);


ALTER TABLE public.anayemek OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16944)
-- Name: personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal (
    "personalNo" integer NOT NULL,
    adi character varying(25) NOT NULL,
    soyadi character varying(25) NOT NULL,
    gorevi character varying(15) NOT NULL
);


ALTER TABLE public.personal OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16947)
-- Name: asci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asci (
    sorumlulugu character varying(100)
)
INHERITS (public.personal);


ALTER TABLE public.asci OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17201)
-- Name: depo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.depo (
    malzemeno integer NOT NULL,
    adi character varying(25) NOT NULL,
    miktar integer NOT NULL,
    tedarikcino integer NOT NULL,
    degistirmezamani timestamp(5) without time zone NOT NULL
);


ALTER TABLE public.depo OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16950)
-- Name: fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fatura (
    "faturaNo" integer NOT NULL,
    tarih date NOT NULL,
    zaman time(1) with time zone[] NOT NULL,
    tutar integer NOT NULL
);


ALTER TABLE public.fatura OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16955)
-- Name: garson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.garson (
    sorumlulugu character varying(100)
)
INHERITS (public.personal);


ALTER TABLE public.garson OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16958)
-- Name: garsonseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.garsonseq
    START WITH 100
    INCREMENT BY 1
    MINVALUE 100
    MAXVALUE 199
    CACHE 1
    CYCLE;


ALTER TABLE public.garsonseq OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16959)
-- Name: icecek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.icecek (
    "tedarikciNo" integer NOT NULL,
    "mevcutSayisi" integer
)
INHERITS (public.urun);


ALTER TABLE public.icecek OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16962)
-- Name: ilceseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ilceseq
    START WITH 0
    INCREMENT BY 10000
    MINVALUE 0
    MAXVALUE 990000
    CACHE 1
    CYCLE;


ALTER TABLE public.ilceseq OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16963)
-- Name: kurye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kurye (
    motorplaka character varying(15) NOT NULL
)
INHERITS (public.personal);


ALTER TABLE public.kurye OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16966)
-- Name: mahalleseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mahalleseq
    START WITH 0
    INCREMENT BY 100
    MINVALUE 0
    MAXVALUE 9900
    CACHE 1
    CYCLE;


ALTER TABLE public.mahalleseq OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16967)
-- Name: malzeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.malzeme (
    malzemeno integer NOT NULL,
    adi character varying(25) NOT NULL,
    miktar integer NOT NULL,
    tedarikcino integer NOT NULL
);


ALTER TABLE public.malzeme OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16970)
-- Name: masalar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.masalar (
    "masaNo" integer NOT NULL,
    "faturaNo" integer,
    "personalNo " integer
);


ALTER TABLE public.masalar OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16973)
-- Name: masalarseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.masalarseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99
    CACHE 1
    CYCLE;


ALTER TABLE public.masalarseq OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16974)
-- Name: masasparisseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.masasparisseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1
    CYCLE;


ALTER TABLE public.masasparisseq OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16975)
-- Name: mez&extra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."mez&extra" (
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);


ALTER TABLE public."mez&extra" OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16978)
-- Name: paket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paket (
    "paketNo" integer NOT NULL,
    "adresKodu" integer NOT NULL,
    "faturaNo" integer NOT NULL,
    "yoneticiNo" integer,
    "personalNo" integer
);


ALTER TABLE public.paket OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16981)
-- Name: paketseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paketseq
    START WITH 1000000
    INCREMENT BY 1000000
    MINVALUE 1000000
    MAXVALUE 1000000000
    CACHE 1
    CYCLE;


ALTER TABLE public.paketseq OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16982)
-- Name: paketsparisseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paketsparisseq
    START WITH 1000000
    INCREMENT BY 1000000
    MINVALUE 1000000
    MAXVALUE 1000000000
    CACHE 1
    CYCLE;


ALTER TABLE public.paketsparisseq OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17194)
-- Name: personal_degismeler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_degismeler (
    personalno integer NOT NULL,
    adi character varying(25) NOT NULL,
    soyadi character varying(25) NOT NULL,
    gorevi character varying(15) NOT NULL,
    degistirmezamani timestamp(5) without time zone NOT NULL
);


ALTER TABLE public.personal_degismeler OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16460)
-- Name: personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel (
    personel_no integer NOT NULL,
    adi character varying(15),
    soyadi character varying(15),
    gorevi character varying(15)
);


ALTER TABLE public.personel OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16459)
-- Name: personel_personel_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personel_personel_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personel_personel_no_seq OWNER TO postgres;

--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 209
-- Name: personel_personel_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personel_personel_no_seq OWNED BY public.personel.personel_no;


--
-- TOC entry 244 (class 1259 OID 17209)
-- Name: silinenadres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silinenadres (
    "adresKodu" integer NOT NULL,
    "ilceKodu" integer NOT NULL,
    "mahalleKodu" integer NOT NULL,
    "sokakNo" integer NOT NULL,
    "girisDetay" character varying(100) NOT NULL,
    degistirmezamani timestamp(5) without time zone NOT NULL
);


ALTER TABLE public.silinenadres OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16983)
-- Name: sokakseq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sokakseq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 99
    CACHE 1
    CYCLE;


ALTER TABLE public.sokakseq OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16984)
-- Name: sparisler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sparisler (
    sparisno integer NOT NULL,
    masano integer,
    paketno integer,
    listeno integer NOT NULL,
    personalno integer
);


ALTER TABLE public.sparisler OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16987)
-- Name: tatli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tatli (
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);


ALTER TABLE public.tatli OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16990)
-- Name: tedarikci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tedarikci (
    "tedarikciNo" integer NOT NULL,
    "telefonNo" numeric(11,0) NOT NULL,
    "firmaAdi" character varying(100) NOT NULL
);


ALTER TABLE public.tedarikci OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17166)
-- Name: urun_no_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.urun_no_seq
    START WITH 0
    INCREMENT BY 5
    MINVALUE 0
    MAXVALUE 100000
    CACHE 1;


ALTER TABLE public.urun_no_seq OWNER TO postgres;

--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 241
-- Name: urun_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.urun_no_seq OWNED BY public.urun."urunNo";


--
-- TOC entry 239 (class 1259 OID 16993)
-- Name: urunlistesi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urunlistesi (
    "listeNo" integer NOT NULL,
    "urunNo" integer NOT NULL,
    "urunAdedi" integer DEFAULT 1 NOT NULL,
    tutari integer NOT NULL
);


ALTER TABLE public.urunlistesi OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16997)
-- Name: yonetici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yonetici (
    "yoneticiNo" integer NOT NULL,
    adi character varying(25) NOT NULL,
    soyadi character varying(25) NOT NULL,
    sifresi character varying(10) NOT NULL
);


ALTER TABLE public.yonetici OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17224)
-- Name: yoneticisifresi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yoneticisifresi (
    "yoneticiNo" integer NOT NULL,
    adi character varying(25) NOT NULL,
    soyadi character varying(25) NOT NULL,
    sifresi character varying(10) NOT NULL,
    degistirmezamani timestamp(5) without time zone NOT NULL
);


ALTER TABLE public.yoneticisifresi OWNER TO postgres;

--
-- TOC entry 3286 (class 2604 OID 16463)
-- Name: personel personel_no; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel ALTER COLUMN personel_no SET DEFAULT nextval('public.personel_personel_no_seq'::regclass);


--
-- TOC entry 3526 (class 0 OID 16922)
-- Dependencies: 211
-- Data for Name: adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adres ("adresKodu", "ilceKodu", "mahalleKodu", "sokakNo", "girisDetay") FROM stdin;
20302	20000	300	2	10/25/2013
31105	30000	1100	5	10/25/2022
41006	40000	1000	6	12/23/2021
\.


--
-- TOC entry 3531 (class 0 OID 16941)
-- Dependencies: 217
-- Data for Name: anayemek; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anayemek ("urunNo", adi, kalori, fiyati, kategori, "servisSekli", varmi) FROM stdin;
\.


--
-- TOC entry 3533 (class 0 OID 16947)
-- Dependencies: 219
-- Data for Name: asci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asci ("personalNo", adi, soyadi, gorevi, sorumlulugu) FROM stdin;
\.


--
-- TOC entry 3557 (class 0 OID 17201)
-- Dependencies: 243
-- Data for Name: depo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.depo (malzemeno, adi, miktar, tedarikcino, degistirmezamani) FROM stdin;
10	ayran	100	2	2022-12-26 15:14:01.75479
\.


--
-- TOC entry 3534 (class 0 OID 16950)
-- Dependencies: 220
-- Data for Name: fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fatura ("faturaNo", tarih, zaman, tutar) FROM stdin;
\.


--
-- TOC entry 3535 (class 0 OID 16955)
-- Dependencies: 221
-- Data for Name: garson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.garson ("personalNo", adi, soyadi, gorevi, sorumlulugu) FROM stdin;
107	mehdi	kaya	garson	masa temizliği
106	muharrem	karay	asci	garsonbaşı
108	memik	ataş	kurye	
\.


--
-- TOC entry 3537 (class 0 OID 16959)
-- Dependencies: 223
-- Data for Name: icecek; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.icecek ("urunNo", adi, kalori, fiyati, kategori, "tedarikciNo", "mevcutSayisi") FROM stdin;
1	ayran	23	4	i	1	4
\.


--
-- TOC entry 3527 (class 0 OID 16925)
-- Dependencies: 212
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ilce ("ilceKodu", adi) FROM stdin;
0	adapazari
10000	akyazi
20000	arifiye
30000	erenler
40000	ferizli
50000	geyve
60000	hendek
70000	karapürçek
80000	karasu
90000	kaynarca
100000	kocaeli
110000	pamukova
120000	spanca
130000	serdivan
\.


--
-- TOC entry 3539 (class 0 OID 16963)
-- Dependencies: 225
-- Data for Name: kurye; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kurye ("personalNo", adi, soyadi, gorevi, motorplaka) FROM stdin;
\.


--
-- TOC entry 3528 (class 0 OID 16928)
-- Dependencies: 213
-- Data for Name: mahalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mahalle ("mahalleKodu", adi) FROM stdin;
0	istiklal
100	arabacılar
200	karşıyaka
300	60.yıl
400	1000evler
500	merveşehir
600	cinderesi
700	hacı mahmut
800	şeker
900	karataş
1000	mavikent
1100	postancılar
1200	çamurlu
1300	akkent
1400	kayaönü
\.


--
-- TOC entry 3541 (class 0 OID 16967)
-- Dependencies: 227
-- Data for Name: malzeme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.malzeme (malzemeno, adi, miktar, tedarikcino) FROM stdin;
11	peynir	70	1
10	ayran	200	2
\.


--
-- TOC entry 3542 (class 0 OID 16970)
-- Dependencies: 228
-- Data for Name: masalar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.masalar ("masaNo", "faturaNo", "personalNo ") FROM stdin;
1	\N	\N
2	\N	\N
3	\N	\N
4	\N	\N
5	\N	\N
6	\N	\N
7	\N	\N
8	\N	\N
9	\N	\N
10	\N	\N
11	\N	\N
12	\N	\N
13	\N	\N
14	\N	\N
15	\N	\N
16	\N	\N
17	\N	\N
18	\N	\N
19	\N	\N
20	\N	\N
21	\N	\N
22	\N	\N
23	\N	\N
24	\N	\N
25	\N	\N
26	\N	\N
27	\N	\N
28	\N	\N
29	\N	\N
30	\N	\N
\.


--
-- TOC entry 3545 (class 0 OID 16975)
-- Dependencies: 231
-- Data for Name: mez&extra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."mez&extra" ("urunNo", adi, kalori, fiyati, kategori, varmi) FROM stdin;
\.


--
-- TOC entry 3546 (class 0 OID 16978)
-- Dependencies: 232
-- Data for Name: paket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paket ("paketNo", "adresKodu", "faturaNo", "yoneticiNo", "personalNo") FROM stdin;
\.


--
-- TOC entry 3532 (class 0 OID 16944)
-- Dependencies: 218
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal ("personalNo", adi, soyadi, gorevi) FROM stdin;
110	mazen	hossam	kurye
109	ali	hassan	garson
\.


--
-- TOC entry 3556 (class 0 OID 17194)
-- Dependencies: 242
-- Data for Name: personal_degismeler; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_degismeler (personalno, adi, soyadi, gorevi, degistirmezamani) FROM stdin;
109	ali	hassan	kurye	2022-12-26 14:51:02.16614
\.


--
-- TOC entry 3525 (class 0 OID 16460)
-- Dependencies: 210
-- Data for Name: personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel (personel_no, adi, soyadi, gorevi) FROM stdin;
25	hossam	mehmet	Kurye
24	hamza	ahmet	Kurye
\.


--
-- TOC entry 3558 (class 0 OID 17209)
-- Dependencies: 244
-- Data for Name: silinenadres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silinenadres ("adresKodu", "ilceKodu", "mahalleKodu", "sokakNo", "girisDetay", degistirmezamani) FROM stdin;
10201	10000	200	1	10/25/2011	2022-12-26 15:35:37.0214
\.


--
-- TOC entry 3529 (class 0 OID 16931)
-- Dependencies: 214
-- Data for Name: sokak; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sokak ("sokakNo", adi) FROM stdin;
0	01
1	02
2	03
3	04
4	05
5	06
6	07
7	08
8	09
9	10
10	11
11	12
12	13
13	14
14	15
15	16
16	17
17	18
18	19
19	20
20	21
21	22
22	23
23	24
24	25
25	26
26	27
27	28
28	29
29	30
30	31
31	32
32	33
33	34
34	35
35	36
36	37
37	38
38	39
39	40
\.


--
-- TOC entry 3550 (class 0 OID 16984)
-- Dependencies: 236
-- Data for Name: sparisler; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sparisler (sparisno, masano, paketno, listeno, personalno) FROM stdin;
\.


--
-- TOC entry 3551 (class 0 OID 16987)
-- Dependencies: 237
-- Data for Name: tatli; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tatli ("urunNo", adi, kalori, fiyati, kategori, varmi) FROM stdin;
5	trelece	43	5	t	1
45	trelece	43	100	t	1
\.


--
-- TOC entry 3552 (class 0 OID 16990)
-- Dependencies: 238
-- Data for Name: tedarikci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tedarikci ("tedarikciNo", "telefonNo", "firmaAdi") FROM stdin;
1	54534	mis\n
2	43343	icim\n
\.


--
-- TOC entry 3530 (class 0 OID 16938)
-- Dependencies: 216
-- Data for Name: urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.urun ("urunNo", adi, kalori, fiyati, kategori) FROM stdin;
\.


--
-- TOC entry 3553 (class 0 OID 16993)
-- Dependencies: 239
-- Data for Name: urunlistesi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.urunlistesi ("listeNo", "urunNo", "urunAdedi", tutari) FROM stdin;
\.


--
-- TOC entry 3554 (class 0 OID 16997)
-- Dependencies: 240
-- Data for Name: yonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yonetici ("yoneticiNo", adi, soyadi, sifresi) FROM stdin;
2	kadir	ataş	56789
1	mohsin\n	kayan	12
\.


--
-- TOC entry 3559 (class 0 OID 17224)
-- Dependencies: 245
-- Data for Name: yoneticisifresi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yoneticisifresi ("yoneticiNo", adi, soyadi, sifresi, degistirmezamani) FROM stdin;
1	mohsin\n	kayan	12345	2022-12-26 16:12:31.87308
\.


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 222
-- Name: garsonseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.garsonseq', 108, true);


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 224
-- Name: ilceseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ilceseq', 130000, true);


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 226
-- Name: mahalleseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mahalleseq', 1400, true);


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 229
-- Name: masalarseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.masalarseq', 30, true);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 230
-- Name: masasparisseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.masasparisseq', 1, false);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 233
-- Name: paketseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paketseq', 1000000, false);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 234
-- Name: paketsparisseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paketsparisseq', 1000000, false);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 209
-- Name: personel_personel_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_personel_no_seq', 25, true);


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 235
-- Name: sokakseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sokakseq', 39, true);


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 241
-- Name: urun_no_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.urun_no_seq', 55, true);


--
-- TOC entry 3291 (class 2606 OID 17001)
-- Name: adres adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY ("adresKodu");


--
-- TOC entry 3353 (class 2606 OID 17205)
-- Name: depo depo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.depo
    ADD CONSTRAINT depo_pkey PRIMARY KEY (malzemeno);


--
-- TOC entry 3310 (class 2606 OID 17003)
-- Name: fatura fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fatura
    ADD CONSTRAINT fatura_pkey PRIMARY KEY ("faturaNo");


--
-- TOC entry 3296 (class 2606 OID 17005)
-- Name: ilce ilce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY ("ilceKodu");


--
-- TOC entry 3298 (class 2606 OID 17007)
-- Name: mahalle mahalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mahalle
    ADD CONSTRAINT mahalle_pkey PRIMARY KEY ("mahalleKodu");


--
-- TOC entry 3322 (class 2606 OID 17009)
-- Name: malzeme malzeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.malzeme
    ADD CONSTRAINT malzeme_pkey PRIMARY KEY (malzemeno);


--
-- TOC entry 3326 (class 2606 OID 17011)
-- Name: masalar masalar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masalar_pkey PRIMARY KEY ("masaNo");


--
-- TOC entry 3333 (class 2606 OID 17013)
-- Name: paket pakert_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT pakert_pkey PRIMARY KEY ("paketNo");


--
-- TOC entry 3351 (class 2606 OID 17198)
-- Name: personal_degismeler personal_degismeler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_degismeler
    ADD CONSTRAINT personal_degismeler_pkey PRIMARY KEY (personalno);


--
-- TOC entry 3305 (class 2606 OID 17015)
-- Name: personal personal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY ("personalNo");


--
-- TOC entry 3289 (class 2606 OID 16465)
-- Name: personel personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT personel_pkey PRIMARY KEY (personel_no);


--
-- TOC entry 3308 (class 2606 OID 17017)
-- Name: asci primaryofasci; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asci
    ADD CONSTRAINT primaryofasci PRIMARY KEY ("personalNo");


--
-- TOC entry 3313 (class 2606 OID 17019)
-- Name: garson primaryofgarson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garson
    ADD CONSTRAINT primaryofgarson PRIMARY KEY ("personalNo");


--
-- TOC entry 3316 (class 2606 OID 17021)
-- Name: icecek primaryoficecek; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icecek
    ADD CONSTRAINT primaryoficecek PRIMARY KEY ("urunNo");


--
-- TOC entry 3319 (class 2606 OID 17023)
-- Name: kurye primaryofkurye; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT primaryofkurye PRIMARY KEY ("personalNo");


--
-- TOC entry 3328 (class 2606 OID 17025)
-- Name: mez&extra primaryofmez&extra; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."mez&extra"
    ADD CONSTRAINT "primaryofmez&extra" PRIMARY KEY ("urunNo");


--
-- TOC entry 3342 (class 2606 OID 17027)
-- Name: tatli primaryoftatli; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tatli
    ADD CONSTRAINT primaryoftatli PRIMARY KEY ("urunNo");


--
-- TOC entry 3355 (class 2606 OID 17213)
-- Name: silinenadres silinenadres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silinenadres
    ADD CONSTRAINT silinenadres_pkey PRIMARY KEY ("adresKodu");


--
-- TOC entry 3300 (class 2606 OID 17029)
-- Name: sokak sokak_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sokak
    ADD CONSTRAINT sokak_pkey PRIMARY KEY ("sokakNo");


--
-- TOC entry 3339 (class 2606 OID 17031)
-- Name: sparisler sparisler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT sparisler_pkey PRIMARY KEY (sparisno);


--
-- TOC entry 3344 (class 2606 OID 17033)
-- Name: tedarikci tedarikci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikci
    ADD CONSTRAINT tedarikci_pkey PRIMARY KEY ("tedarikciNo");


--
-- TOC entry 3347 (class 2606 OID 17035)
-- Name: urunlistesi urunListesi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urunlistesi
    ADD CONSTRAINT "urunListesi_pkey" PRIMARY KEY ("listeNo");


--
-- TOC entry 3302 (class 2606 OID 17037)
-- Name: urun urun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_pkey PRIMARY KEY ("urunNo");


--
-- TOC entry 3349 (class 2606 OID 17039)
-- Name: yonetici yonetici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT yonetici_pkey PRIMARY KEY ("yoneticiNo");


--
-- TOC entry 3357 (class 2606 OID 17228)
-- Name: yoneticisifresi yoneticisifresi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yoneticisifresi
    ADD CONSTRAINT yoneticisifresi_pkey PRIMARY KEY ("yoneticiNo");


--
-- TOC entry 3329 (class 1259 OID 17040)
-- Name: fki_a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_a ON public.paket USING btree ("adresKodu");


--
-- TOC entry 3292 (class 1259 OID 17041)
-- Name: fki_adres_ilce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_adres_ilce ON public.adres USING btree ("ilceKodu");


--
-- TOC entry 3293 (class 1259 OID 17042)
-- Name: fki_adres_mahalle; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_adres_mahalle ON public.adres USING btree ("mahalleKodu");


--
-- TOC entry 3294 (class 1259 OID 17043)
-- Name: fki_adres_sokak; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_adres_sokak ON public.adres USING btree ("sokakNo");


--
-- TOC entry 3303 (class 1259 OID 17044)
-- Name: fki_anayemek_urun; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_anayemek_urun ON public.anayemek USING btree ("urunNo");


--
-- TOC entry 3306 (class 1259 OID 17045)
-- Name: fki_asci_personal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_asci_personal ON public.asci USING btree ("personalNo");


--
-- TOC entry 3323 (class 1259 OID 17046)
-- Name: fki_f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_f ON public.masalar USING btree ("faturaNo");


--
-- TOC entry 3314 (class 1259 OID 17047)
-- Name: fki_icecek_tedarikci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_icecek_tedarikci ON public.icecek USING btree ("tedarikciNo");


--
-- TOC entry 3317 (class 1259 OID 17048)
-- Name: fki_kurye_prsonal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_kurye_prsonal ON public.kurye USING btree ("personalNo");


--
-- TOC entry 3334 (class 1259 OID 17049)
-- Name: fki_liste-sparis; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_liste-sparis" ON public.sparisler USING btree (listeno);


--
-- TOC entry 3320 (class 1259 OID 17050)
-- Name: fki_malzeme_tedarkci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_malzeme_tedarkci ON public.malzeme USING btree (tedarikcino);


--
-- TOC entry 3324 (class 1259 OID 17051)
-- Name: fki_masa_personal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_masa_personal ON public.masalar USING btree ("personalNo ");


--
-- TOC entry 3311 (class 1259 OID 17052)
-- Name: fki_p; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_p ON public.garson USING btree ("personalNo");


--
-- TOC entry 3330 (class 1259 OID 17053)
-- Name: fki_paket_kurye; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_paket_kurye ON public.paket USING btree ("personalNo");


--
-- TOC entry 3335 (class 1259 OID 17054)
-- Name: fki_paket_personal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_paket_personal ON public.sparisler USING btree (personalno);


--
-- TOC entry 3336 (class 1259 OID 17055)
-- Name: fki_paket_sparis; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_paket_sparis ON public.sparisler USING btree (paketno);


--
-- TOC entry 3340 (class 1259 OID 17056)
-- Name: fki_tatli_urun; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_tatli_urun ON public.tatli USING btree ("urunNo");


--
-- TOC entry 3345 (class 1259 OID 17057)
-- Name: fki_urunlistei_urun; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_urunlistei_urun ON public.urunlistesi USING btree ("urunNo");


--
-- TOC entry 3331 (class 1259 OID 17058)
-- Name: fki_y; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_y ON public.paket USING btree ("yoneticiNo");


--
-- TOC entry 3337 (class 1259 OID 17059)
-- Name: fki_ة; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_ة" ON public.sparisler USING btree (masano);


--
-- TOC entry 3379 (class 2620 OID 17223)
-- Name: urun fiyat_guncelleme_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER fiyat_guncelleme_tr BEFORE UPDATE ON public.urun FOR EACH ROW EXECUTE FUNCTION public.fiyat_guncelleme();


--
-- TOC entry 3382 (class 2620 OID 17208)
-- Name: malzeme malzeme_değişiklikleri_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "malzeme_değişiklikleri_tr" AFTER UPDATE ON public.malzeme FOR EACH ROW EXECUTE FUNCTION public."malzeme_değişiklikleri"();


--
-- TOC entry 3380 (class 2620 OID 17207)
-- Name: personal malzeme_değişiklikleri_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "malzeme_değişiklikleri_tr" AFTER UPDATE ON public.personal FOR EACH ROW EXECUTE FUNCTION public."malzeme_değişiklikleri"();


--
-- TOC entry 3381 (class 2620 OID 17200)
-- Name: personal personalgorev_değişiklikleri; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "personalgorev_değişiklikleri" BEFORE UPDATE ON public.personal FOR EACH ROW EXECUTE FUNCTION public."personal_gorevi_değişiklikleri"();


--
-- TOC entry 3378 (class 2620 OID 17230)
-- Name: urun sifre_guncelleme_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER sifre_guncelleme_tr AFTER UPDATE ON public.urun FOR EACH ROW EXECUTE FUNCTION public.sifre_guncelleme();


--
-- TOC entry 3383 (class 2620 OID 17231)
-- Name: yonetici sifre_guncelleme_tr; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER sifre_guncelleme_tr AFTER UPDATE ON public.yonetici FOR EACH ROW EXECUTE FUNCTION public.sifre_guncelleme();


--
-- TOC entry 3377 (class 2620 OID 17215)
-- Name: adres silinen_adresler; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER silinen_adresler AFTER DELETE ON public.adres FOR EACH ROW EXECUTE FUNCTION public.silinen_adresler();


--
-- TOC entry 3358 (class 2606 OID 17060)
-- Name: adres adres_ilce; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_ilce FOREIGN KEY ("ilceKodu") REFERENCES public.ilce("ilceKodu");


--
-- TOC entry 3359 (class 2606 OID 17065)
-- Name: adres adres_mahalle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_mahalle FOREIGN KEY ("mahalleKodu") REFERENCES public.mahalle("mahalleKodu");


--
-- TOC entry 3360 (class 2606 OID 17070)
-- Name: adres adres_sokak; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_sokak FOREIGN KEY ("sokakNo") REFERENCES public.sokak("sokakNo");


--
-- TOC entry 3361 (class 2606 OID 17075)
-- Name: anayemek anayemek_uru; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anayemek
    ADD CONSTRAINT anayemek_uru FOREIGN KEY ("urunNo") REFERENCES public.urun("urunNo");


--
-- TOC entry 3362 (class 2606 OID 17080)
-- Name: asci asci_personal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asci
    ADD CONSTRAINT asci_personal FOREIGN KEY ("personalNo") REFERENCES public.personal("personalNo");


--
-- TOC entry 3363 (class 2606 OID 17085)
-- Name: icecek icecek_tedarikci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icecek
    ADD CONSTRAINT icecek_tedarikci FOREIGN KEY ("tedarikciNo") REFERENCES public.tedarikci("tedarikciNo");


--
-- TOC entry 3364 (class 2606 OID 17090)
-- Name: kurye kurye_prsonal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT kurye_prsonal FOREIGN KEY ("personalNo") REFERENCES public.personal("personalNo");


--
-- TOC entry 3372 (class 2606 OID 17095)
-- Name: sparisler liste-sparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT "liste-sparis" FOREIGN KEY (listeno) REFERENCES public.urunlistesi("listeNo");


--
-- TOC entry 3365 (class 2606 OID 17100)
-- Name: malzeme malzeme_tedarkci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.malzeme
    ADD CONSTRAINT malzeme_tedarkci FOREIGN KEY (tedarikcino) REFERENCES public.tedarikci("tedarikciNo");


--
-- TOC entry 3366 (class 2606 OID 17105)
-- Name: masalar masa_fatura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masa_fatura FOREIGN KEY ("faturaNo") REFERENCES public.fatura("faturaNo");


--
-- TOC entry 3367 (class 2606 OID 17110)
-- Name: masalar masa_garson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masa_garson FOREIGN KEY ("personalNo ") REFERENCES public.garson("personalNo");


--
-- TOC entry 3373 (class 2606 OID 17115)
-- Name: sparisler masa_sparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT masa_sparis FOREIGN KEY (masano) REFERENCES public.masalar("masaNo");


--
-- TOC entry 3368 (class 2606 OID 17120)
-- Name: paket paket_adres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_adres FOREIGN KEY ("adresKodu") REFERENCES public.adres("adresKodu");


--
-- TOC entry 3369 (class 2606 OID 17125)
-- Name: paket paket_fatura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_fatura FOREIGN KEY ("faturaNo") REFERENCES public.fatura("faturaNo");


--
-- TOC entry 3370 (class 2606 OID 17130)
-- Name: paket paket_kurye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_kurye FOREIGN KEY ("personalNo") REFERENCES public.kurye("personalNo");


--
-- TOC entry 3374 (class 2606 OID 17135)
-- Name: sparisler paket_sparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT paket_sparis FOREIGN KEY (paketno) REFERENCES public.paket("paketNo");


--
-- TOC entry 3371 (class 2606 OID 17140)
-- Name: paket paket_yonetici; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_yonetici FOREIGN KEY ("yoneticiNo") REFERENCES public.yonetici("yoneticiNo");


--
-- TOC entry 3375 (class 2606 OID 17145)
-- Name: sparisler sparis_asci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT sparis_asci FOREIGN KEY (personalno) REFERENCES public.asci("personalNo");


--
-- TOC entry 3376 (class 2606 OID 17155)
-- Name: urunlistesi urunlistei_urun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urunlistesi
    ADD CONSTRAINT urunlistei_urun FOREIGN KEY ("urunNo") REFERENCES public.urun("urunNo");


-- Completed on 2022-12-26 16:27:13

--
-- PostgreSQL database dump complete
--

