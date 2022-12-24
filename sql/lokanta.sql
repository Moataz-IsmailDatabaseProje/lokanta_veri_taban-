toc.dat                                                                                             0000600 0004000 0002000 00000105336 14351571421 0014452 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       ,    '                z            Lokanta    15.1    15.0 }    �
           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �
           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �
           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �
           1262    18107    Lokanta    DATABASE     �   CREATE DATABASE "Lokanta" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.utf8';
    DROP DATABASE "Lokanta";
                postgres    false         �            1255    18398 7   adresekle(integer, integer, integer, character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.adresekle(IN ilce integer, IN mahalle integer, IN sokak integer, IN girisdetay character varying)
    LANGUAGE plpgsql
    AS $$
begin
insert into adres values(ilce+mahalle+sokak,ilce,mahalle,sokak,girisDetay);
end;$$;
 y   DROP PROCEDURE public.adresekle(IN ilce integer, IN mahalle integer, IN sokak integer, IN girisdetay character varying);
       public          postgres    false         �            1255    18403 *   urunlistesiekle(integer, integer, integer) 	   PROCEDURE     2  CREATE PROCEDURE public.urunlistesiekle(IN sparisno integer, IN urunno integer, IN adet integer)
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
 `   DROP PROCEDURE public.urunlistesiekle(IN sparisno integer, IN urunno integer, IN adet integer);
       public          postgres    false         �            1259    18205    adres    TABLE     �   CREATE TABLE public.adres (
    "adresKodu" integer NOT NULL,
    "ilceKodu" integer NOT NULL,
    "mahalleKodu" integer NOT NULL,
    "sokakNo" integer NOT NULL,
    "girisDetay" character varying(100) NOT NULL
);
    DROP TABLE public.adres;
       public         heap    postgres    false         �            1259    18210    ilce    TABLE     f   CREATE TABLE public.ilce (
    "ilceKodu" integer NOT NULL,
    adi character varying(25) NOT NULL
);
    DROP TABLE public.ilce;
       public         heap    postgres    false         �            1259    18215    mahalle    TABLE     l   CREATE TABLE public.mahalle (
    "mahalleKodu" integer NOT NULL,
    adi character varying(25) NOT NULL
);
    DROP TABLE public.mahalle;
       public         heap    postgres    false         �            1259    18220    sokak    TABLE     f   CREATE TABLE public.sokak (
    "sokakNo" integer NOT NULL,
    adi character varying(25) NOT NULL
);
    DROP TABLE public.sokak;
       public         heap    postgres    false         �            1259    18379    adresgoruntusu    VIEW     �  CREATE VIEW public.adresgoruntusu AS
 SELECT adres."adresKodu",
    ilce.adi AS ilce,
    mahalle.adi AS mahelle,
    sokak.adi AS sokak,
    adres."girisDetay"
   FROM (((public.adres
     JOIN public.ilce ON ((adres."ilceKodu" = ilce."ilceKodu")))
     JOIN public.mahalle ON ((adres."mahalleKodu" = mahalle."mahalleKodu")))
     JOIN public.sokak ON ((adres."sokakNo" = sokak."sokakNo")));
 !   DROP VIEW public.adresgoruntusu;
       public          postgres    false    233    231    231    231    231    234    234    233    232    232    231         �            1259    18188    urun    TABLE     �   CREATE TABLE public.urun (
    "urunNo" integer NOT NULL,
    adi character varying(40) NOT NULL,
    kalori integer NOT NULL,
    fiyati integer NOT NULL,
    kategori "char" NOT NULL
);
    DROP TABLE public.urun;
       public         heap    postgres    false         �            1259    18193    anayemek    TABLE     |   CREATE TABLE public.anayemek (
    "servisSekli" character varying(50),
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);
    DROP TABLE public.anayemek;
       public         heap    postgres    false    226         �            1259    18145    personal    TABLE     �   CREATE TABLE public.personal (
    "personalNo" integer NOT NULL,
    adi character varying(25) NOT NULL,
    soyadi character varying(25) NOT NULL,
    gorevi "char" NOT NULL
);
    DROP TABLE public.personal;
       public         heap    postgres    false         �            1259    18169    asci    TABLE     `   CREATE TABLE public.asci (
    sorumlulugu character varying(100)
)
INHERITS (public.personal);
    DROP TABLE public.asci;
       public         heap    postgres    false    218         �            1259    18138    fatura    TABLE     �   CREATE TABLE public.fatura (
    "faturaNo" integer NOT NULL,
    tarih date NOT NULL,
    zaman time(1) with time zone[] NOT NULL,
    tutar integer NOT NULL
);
    DROP TABLE public.fatura;
       public         heap    postgres    false         �            1259    18163    garson    TABLE     b   CREATE TABLE public.garson (
    sorumlulugu character varying(100)
)
INHERITS (public.personal);
    DROP TABLE public.garson;
       public         heap    postgres    false    218         �            1259    18400 	   garsonseq    SEQUENCE     �   CREATE SEQUENCE public.garsonseq
    START WITH 100
    INCREMENT BY 1
    MINVALUE 100
    MAXVALUE 199
    CACHE 1
    CYCLE;
     DROP SEQUENCE public.garsonseq;
       public          postgres    false         �            1259    18196    icecek    TABLE     v   CREATE TABLE public.icecek (
    "tedarikciNo" integer NOT NULL,
    "mevcutSayisi" integer
)
INHERITS (public.urun);
    DROP TABLE public.icecek;
       public         heap    postgres    false    226         �            1259    18391    ilceseq    SEQUENCE     �   CREATE SEQUENCE public.ilceseq
    START WITH 0
    INCREMENT BY 10000
    MINVALUE 0
    MAXVALUE 990000
    CACHE 1
    CYCLE;
    DROP SEQUENCE public.ilceseq;
       public          postgres    false         �            1259    18166    kurye    TABLE     h   CREATE TABLE public.kurye (
    motorplaka character varying(15) NOT NULL
)
INHERITS (public.personal);
    DROP TABLE public.kurye;
       public         heap    postgres    false    218         �            1259    18390 
   mahalleseq    SEQUENCE     �   CREATE SEQUENCE public.mahalleseq
    START WITH 0
    INCREMENT BY 100
    MINVALUE 0
    MAXVALUE 9900
    CACHE 1
    CYCLE;
 !   DROP SEQUENCE public.mahalleseq;
       public          postgres    false         �            1259    18178    malzeme    TABLE     �   CREATE TABLE public.malzeme (
    "malzemeNo" integer NOT NULL,
    adi character varying(25) NOT NULL,
    miktar integer NOT NULL,
    "tedarikciNo" integer NOT NULL
);
    DROP TABLE public.malzeme;
       public         heap    postgres    false         �            1259    18128    masalar    TABLE     r   CREATE TABLE public.masalar (
    "masaNo" integer NOT NULL,
    "faturaNo" integer,
    "personalNo " integer
);
    DROP TABLE public.masalar;
       public         heap    postgres    false         �            1259    18399 
   masalarseq    SEQUENCE     }   CREATE SEQUENCE public.masalarseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99
    CACHE 1
    CYCLE;
 !   DROP SEQUENCE public.masalarseq;
       public          postgres    false         �            1259    18404 
   masasparisseq    SEQUENCE     �   CREATE SEQUENCE public.masasparisseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1
    CYCLE;
 $   DROP SEQUENCE public.masasparisseq;
       public          postgres    false         �            1259    18202 	   mez&extra    TABLE     V   CREATE TABLE public."mez&extra" (
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);
    DROP TABLE public."mez&extra";
       public         heap    postgres    false    226         �            1259    18133    paket    TABLE     �   CREATE TABLE public.paket (
    "paketNo" integer NOT NULL,
    "adresKodu" integer NOT NULL,
    "faturaNo" integer NOT NULL,
    "yoneticiNo" integer,
    "personalNo" integer
);
    DROP TABLE public.paket;
       public         heap    postgres    false         �            1259    18401    paketseq    SEQUENCE     �   CREATE SEQUENCE public.paketseq
    START WITH 1000000
    INCREMENT BY 1000000
    MINVALUE 1000000
    MAXVALUE 1000000000
    CACHE 1
    CYCLE;
    DROP SEQUENCE public.paketseq;
       public          postgres    false         �            1259    18405    paketsparisseq    SEQUENCE     �   CREATE SEQUENCE public.paketsparisseq
    START WITH 1000000
    INCREMENT BY 1000000
    MINVALUE 1000000
    MAXVALUE 1000000000
    CACHE 1
    CYCLE;
 %   DROP SEQUENCE public.paketsparisseq;
       public          postgres    false         �            1259    18389    sokakseq    SEQUENCE     z   CREATE SEQUENCE public.sokakseq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 99
    CACHE 1
    CYCLE;
    DROP SEQUENCE public.sokakseq;
       public          postgres    false         �            1259    18123 	   sparisler    TABLE     �   CREATE TABLE public.sparisler (
    sparisno integer NOT NULL,
    masano integer,
    paketno integer,
    listeno integer NOT NULL,
    personalno integer
);
    DROP TABLE public.sparisler;
       public         heap    postgres    false         �            1259    18199    tatli    TABLE     P   CREATE TABLE public.tatli (
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);
    DROP TABLE public.tatli;
       public         heap    postgres    false    226         �            1259    18183 	   tedarikci    TABLE     �   CREATE TABLE public.tedarikci (
    "tedarikciNo" integer NOT NULL,
    "telefonNo" numeric(11,0) NOT NULL,
    "firmaAdi" character varying(100) NOT NULL
);
    DROP TABLE public.tedarikci;
       public         heap    postgres    false         �            1259    18172    urunlistesi    TABLE     �   CREATE TABLE public.urunlistesi (
    "listeNo" integer NOT NULL,
    "urunNo" integer NOT NULL,
    "urunAdedi" integer DEFAULT 1 NOT NULL,
    tutari integer NOT NULL
);
    DROP TABLE public.urunlistesi;
       public         heap    postgres    false         �            1259    18150    yonetici    TABLE     �   CREATE TABLE public.yonetici (
    "yoneticiNo" integer NOT NULL,
    adi character varying(25) NOT NULL,
    soyadi character varying(25) NOT NULL,
    sifresi character varying(10) NOT NULL
);
    DROP TABLE public.yonetici;
       public         heap    postgres    false         �
          0    18205    adres 
   TABLE DATA           `   COPY public.adres ("adresKodu", "ilceKodu", "mahalleKodu", "sokakNo", "girisDetay") FROM stdin;
    public          postgres    false    231       3507.dat �
          0    18193    anayemek 
   TABLE DATA           a   COPY public.anayemek ("urunNo", adi, kalori, fiyati, kategori, "servisSekli", varmi) FROM stdin;
    public          postgres    false    227       3503.dat �
          0    18169    asci 
   TABLE DATA           N   COPY public.asci ("personalNo", adi, soyadi, gorevi, sorumlulugu) FROM stdin;
    public          postgres    false    222       3498.dat �
          0    18138    fatura 
   TABLE DATA           A   COPY public.fatura ("faturaNo", tarih, zaman, tutar) FROM stdin;
    public          postgres    false    217       3493.dat �
          0    18163    garson 
   TABLE DATA           P   COPY public.garson ("personalNo", adi, soyadi, gorevi, sorumlulugu) FROM stdin;
    public          postgres    false    220       3496.dat �
          0    18196    icecek 
   TABLE DATA           h   COPY public.icecek ("urunNo", adi, kalori, fiyati, kategori, "tedarikciNo", "mevcutSayisi") FROM stdin;
    public          postgres    false    228       3504.dat �
          0    18210    ilce 
   TABLE DATA           /   COPY public.ilce ("ilceKodu", adi) FROM stdin;
    public          postgres    false    232       3508.dat �
          0    18166    kurye 
   TABLE DATA           N   COPY public.kurye ("personalNo", adi, soyadi, gorevi, motorplaka) FROM stdin;
    public          postgres    false    221       3497.dat �
          0    18215    mahalle 
   TABLE DATA           5   COPY public.mahalle ("mahalleKodu", adi) FROM stdin;
    public          postgres    false    233       3509.dat �
          0    18178    malzeme 
   TABLE DATA           J   COPY public.malzeme ("malzemeNo", adi, miktar, "tedarikciNo") FROM stdin;
    public          postgres    false    224       3500.dat �
          0    18128    masalar 
   TABLE DATA           F   COPY public.masalar ("masaNo", "faturaNo", "personalNo ") FROM stdin;
    public          postgres    false    215       3491.dat �
          0    18202 	   mez&extra 
   TABLE DATA           U   COPY public."mez&extra" ("urunNo", adi, kalori, fiyati, kategori, varmi) FROM stdin;
    public          postgres    false    230       3506.dat �
          0    18133    paket 
   TABLE DATA           _   COPY public.paket ("paketNo", "adresKodu", "faturaNo", "yoneticiNo", "personalNo") FROM stdin;
    public          postgres    false    216       3492.dat �
          0    18145    personal 
   TABLE DATA           E   COPY public.personal ("personalNo", adi, soyadi, gorevi) FROM stdin;
    public          postgres    false    218       3494.dat �
          0    18220    sokak 
   TABLE DATA           /   COPY public.sokak ("sokakNo", adi) FROM stdin;
    public          postgres    false    234       3510.dat �
          0    18123 	   sparisler 
   TABLE DATA           S   COPY public.sparisler (sparisno, masano, paketno, listeno, personalno) FROM stdin;
    public          postgres    false    214       3490.dat �
          0    18199    tatli 
   TABLE DATA           O   COPY public.tatli ("urunNo", adi, kalori, fiyati, kategori, varmi) FROM stdin;
    public          postgres    false    229       3505.dat �
          0    18183 	   tedarikci 
   TABLE DATA           K   COPY public.tedarikci ("tedarikciNo", "telefonNo", "firmaAdi") FROM stdin;
    public          postgres    false    225       3501.dat �
          0    18188    urun 
   TABLE DATA           G   COPY public.urun ("urunNo", adi, kalori, fiyati, kategori) FROM stdin;
    public          postgres    false    226       3502.dat �
          0    18172    urunlistesi 
   TABLE DATA           O   COPY public.urunlistesi ("listeNo", "urunNo", "urunAdedi", tutari) FROM stdin;
    public          postgres    false    223       3499.dat �
          0    18150    yonetici 
   TABLE DATA           F   COPY public.yonetici ("yoneticiNo", adi, soyadi, sifresi) FROM stdin;
    public          postgres    false    219       3495.dat �
           0    0 	   garsonseq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.garsonseq', 108, true);
          public          postgres    false    240         �
           0    0    ilceseq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.ilceseq', 130000, true);
          public          postgres    false    238         �
           0    0 
   mahalleseq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.mahalleseq', 1400, true);
          public          postgres    false    237         �
           0    0 
   masalarseq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.masalarseq', 30, true);
          public          postgres    false    239         �
           0    0 
   masasparisseq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.masasparisseq', 1, false);
          public          postgres    false    242         �
           0    0    paketseq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.paketseq', 1000000, false);
          public          postgres    false    241         �
           0    0    paketsparisseq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.paketsparisseq', 1000000, false);
          public          postgres    false    243         �
           0    0    sokakseq    SEQUENCE SET     7   SELECT pg_catalog.setval('public.sokakseq', 39, true);
          public          postgres    false    236         �           2606    18209    adres adres_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY ("adresKodu");
 :   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_pkey;
       public            postgres    false    231         �           2606    18144    fatura fatura_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.fatura
    ADD CONSTRAINT fatura_pkey PRIMARY KEY ("faturaNo");
 <   ALTER TABLE ONLY public.fatura DROP CONSTRAINT fatura_pkey;
       public            postgres    false    217         �           2606    18214    ilce ilce_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY ("ilceKodu");
 8   ALTER TABLE ONLY public.ilce DROP CONSTRAINT ilce_pkey;
       public            postgres    false    232         �           2606    18219    mahalle mahalle_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.mahalle
    ADD CONSTRAINT mahalle_pkey PRIMARY KEY ("mahalleKodu");
 >   ALTER TABLE ONLY public.mahalle DROP CONSTRAINT mahalle_pkey;
       public            postgres    false    233         �           2606    18182    malzeme malzeme_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.malzeme
    ADD CONSTRAINT malzeme_pkey PRIMARY KEY ("malzemeNo");
 >   ALTER TABLE ONLY public.malzeme DROP CONSTRAINT malzeme_pkey;
       public            postgres    false    224         �           2606    18132    masalar masalar_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masalar_pkey PRIMARY KEY ("masaNo");
 >   ALTER TABLE ONLY public.masalar DROP CONSTRAINT masalar_pkey;
       public            postgres    false    215         �           2606    18137    paket pakert_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.paket
    ADD CONSTRAINT pakert_pkey PRIMARY KEY ("paketNo");
 ;   ALTER TABLE ONLY public.paket DROP CONSTRAINT pakert_pkey;
       public            postgres    false    216         �           2606    18149    personal personal_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY ("personalNo");
 @   ALTER TABLE ONLY public.personal DROP CONSTRAINT personal_pkey;
       public            postgres    false    218         �           2606    18288    asci primaryofasci 
   CONSTRAINT     Z   ALTER TABLE ONLY public.asci
    ADD CONSTRAINT primaryofasci PRIMARY KEY ("personalNo");
 <   ALTER TABLE ONLY public.asci DROP CONSTRAINT primaryofasci;
       public            postgres    false    222         �           2606    18286    garson primaryofgarson 
   CONSTRAINT     ^   ALTER TABLE ONLY public.garson
    ADD CONSTRAINT primaryofgarson PRIMARY KEY ("personalNo");
 @   ALTER TABLE ONLY public.garson DROP CONSTRAINT primaryofgarson;
       public            postgres    false    220         �           2606    18290    icecek primaryoficecek 
   CONSTRAINT     Z   ALTER TABLE ONLY public.icecek
    ADD CONSTRAINT primaryoficecek PRIMARY KEY ("urunNo");
 @   ALTER TABLE ONLY public.icecek DROP CONSTRAINT primaryoficecek;
       public            postgres    false    228         �           2606    18298    kurye primaryofkurye 
   CONSTRAINT     \   ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT primaryofkurye PRIMARY KEY ("personalNo");
 >   ALTER TABLE ONLY public.kurye DROP CONSTRAINT primaryofkurye;
       public            postgres    false    221         �           2606    18324    mez&extra primaryofmez&extra 
   CONSTRAINT     d   ALTER TABLE ONLY public."mez&extra"
    ADD CONSTRAINT "primaryofmez&extra" PRIMARY KEY ("urunNo");
 J   ALTER TABLE ONLY public."mez&extra" DROP CONSTRAINT "primaryofmez&extra";
       public            postgres    false    230         �           2606    18354    tatli primaryoftatli 
   CONSTRAINT     X   ALTER TABLE ONLY public.tatli
    ADD CONSTRAINT primaryoftatli PRIMARY KEY ("urunNo");
 >   ALTER TABLE ONLY public.tatli DROP CONSTRAINT primaryoftatli;
       public            postgres    false    229         �           2606    18224    sokak sokak_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.sokak
    ADD CONSTRAINT sokak_pkey PRIMARY KEY ("sokakNo");
 :   ALTER TABLE ONLY public.sokak DROP CONSTRAINT sokak_pkey;
       public            postgres    false    234         �           2606    18127    sparisler sparisler_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT sparisler_pkey PRIMARY KEY (sparisno);
 B   ALTER TABLE ONLY public.sparisler DROP CONSTRAINT sparisler_pkey;
       public            postgres    false    214         �           2606    18187    tedarikci tedarikci_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.tedarikci
    ADD CONSTRAINT tedarikci_pkey PRIMARY KEY ("tedarikciNo");
 B   ALTER TABLE ONLY public.tedarikci DROP CONSTRAINT tedarikci_pkey;
       public            postgres    false    225         �           2606    18177    urunlistesi urunListesi_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.urunlistesi
    ADD CONSTRAINT "urunListesi_pkey" PRIMARY KEY ("listeNo");
 H   ALTER TABLE ONLY public.urunlistesi DROP CONSTRAINT "urunListesi_pkey";
       public            postgres    false    223         �           2606    18192    urun urun_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_pkey PRIMARY KEY ("urunNo");
 8   ALTER TABLE ONLY public.urun DROP CONSTRAINT urun_pkey;
       public            postgres    false    226         �           2606    18154    yonetici yonetici_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT yonetici_pkey PRIMARY KEY ("yoneticiNo");
 @   ALTER TABLE ONLY public.yonetici DROP CONSTRAINT yonetici_pkey;
       public            postgres    false    219         �           1259    18342    fki_a    INDEX     >   CREATE INDEX fki_a ON public.paket USING btree ("adresKodu");
    DROP INDEX public.fki_a;
       public            postgres    false    216         �           1259    18254    fki_adres_ilce    INDEX     F   CREATE INDEX fki_adres_ilce ON public.adres USING btree ("ilceKodu");
 "   DROP INDEX public.fki_adres_ilce;
       public            postgres    false    231         �           1259    18260    fki_adres_mahalle    INDEX     L   CREATE INDEX fki_adres_mahalle ON public.adres USING btree ("mahalleKodu");
 %   DROP INDEX public.fki_adres_mahalle;
       public            postgres    false    231         �           1259    18266    fki_adres_sokak    INDEX     F   CREATE INDEX fki_adres_sokak ON public.adres USING btree ("sokakNo");
 #   DROP INDEX public.fki_adres_sokak;
       public            postgres    false    231         �           1259    18272    fki_anayemek_urun    INDEX     J   CREATE INDEX fki_anayemek_urun ON public.anayemek USING btree ("urunNo");
 %   DROP INDEX public.fki_anayemek_urun;
       public            postgres    false    227         �           1259    18278    fki_asci_personal    INDEX     J   CREATE INDEX fki_asci_personal ON public.asci USING btree ("personalNo");
 %   DROP INDEX public.fki_asci_personal;
       public            postgres    false    222         �           1259    18316    fki_f    INDEX     ?   CREATE INDEX fki_f ON public.masalar USING btree ("faturaNo");
    DROP INDEX public.fki_f;
       public            postgres    false    215         �           1259    18296    fki_icecek_tedarikci    INDEX     P   CREATE INDEX fki_icecek_tedarikci ON public.icecek USING btree ("tedarikciNo");
 (   DROP INDEX public.fki_icecek_tedarikci;
       public            postgres    false    228         �           1259    18304    fki_kurye_prsonal    INDEX     K   CREATE INDEX fki_kurye_prsonal ON public.kurye USING btree ("personalNo");
 %   DROP INDEX public.fki_kurye_prsonal;
       public            postgres    false    221         �           1259    18248    fki_liste-sparis    INDEX     K   CREATE INDEX "fki_liste-sparis" ON public.sparisler USING btree (listeno);
 &   DROP INDEX public."fki_liste-sparis";
       public            postgres    false    214         �           1259    18310    fki_malzeme_tedarkci    INDEX     Q   CREATE INDEX fki_malzeme_tedarkci ON public.malzeme USING btree ("tedarikciNo");
 (   DROP INDEX public.fki_malzeme_tedarkci;
       public            postgres    false    224         �           1259    18322    fki_masa_personal    INDEX     N   CREATE INDEX fki_masa_personal ON public.masalar USING btree ("personalNo ");
 %   DROP INDEX public.fki_masa_personal;
       public            postgres    false    215         �           1259    18284    fki_p    INDEX     @   CREATE INDEX fki_p ON public.garson USING btree ("personalNo");
    DROP INDEX public.fki_p;
       public            postgres    false    220         �           1259    18336    fki_paket_kurye    INDEX     I   CREATE INDEX fki_paket_kurye ON public.paket USING btree ("personalNo");
 #   DROP INDEX public.fki_paket_kurye;
       public            postgres    false    216         �           1259    18242    fki_paket_personal    INDEX     N   CREATE INDEX fki_paket_personal ON public.sparisler USING btree (personalno);
 &   DROP INDEX public.fki_paket_personal;
       public            postgres    false    214         �           1259    18236    fki_paket_sparis    INDEX     I   CREATE INDEX fki_paket_sparis ON public.sparisler USING btree (paketno);
 $   DROP INDEX public.fki_paket_sparis;
       public            postgres    false    214         �           1259    18360    fki_tatli_urun    INDEX     D   CREATE INDEX fki_tatli_urun ON public.tatli USING btree ("urunNo");
 "   DROP INDEX public.fki_tatli_urun;
       public            postgres    false    229         �           1259    18366    fki_urunlistei_urun    INDEX     O   CREATE INDEX fki_urunlistei_urun ON public.urunlistesi USING btree ("urunNo");
 '   DROP INDEX public.fki_urunlistei_urun;
       public            postgres    false    223         �           1259    18330    fki_y    INDEX     ?   CREATE INDEX fki_y ON public.paket USING btree ("yoneticiNo");
    DROP INDEX public.fki_y;
       public            postgres    false    216         �           1259    18230    fki_ة    INDEX     @   CREATE INDEX "fki_ة" ON public.sparisler USING btree (masano);
    DROP INDEX public."fki_ة";
       public            postgres    false    214         
           2606    18249    adres adres_ilce 
   FK CONSTRAINT     y   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_ilce FOREIGN KEY ("ilceKodu") REFERENCES public.ilce("ilceKodu");
 :   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_ilce;
       public          postgres    false    232    3322    231         
           2606    18255    adres adres_mahalle 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_mahalle FOREIGN KEY ("mahalleKodu") REFERENCES public.mahalle("mahalleKodu");
 =   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_mahalle;
       public          postgres    false    231    233    3324         
           2606    18261    adres adres_sokak 
   FK CONSTRAINT     y   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_sokak FOREIGN KEY ("sokakNo") REFERENCES public.sokak("sokakNo");
 ;   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_sokak;
       public          postgres    false    231    234    3326         

           2606    18374    anayemek anayemek_uru 
   FK CONSTRAINT     z   ALTER TABLE ONLY public.anayemek
    ADD CONSTRAINT anayemek_uru FOREIGN KEY ("urunNo") REFERENCES public.urun("urunNo");
 ?   ALTER TABLE ONLY public.anayemek DROP CONSTRAINT anayemek_uru;
       public          postgres    false    226    3306    227         

           2606    18273    asci asci_personal 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.asci
    ADD CONSTRAINT asci_personal FOREIGN KEY ("personalNo") REFERENCES public.personal("personalNo");
 <   ALTER TABLE ONLY public.asci DROP CONSTRAINT asci_personal;
       public          postgres    false    218    3285    222         
           2606    18291    icecek icecek_tedarikci 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.icecek
    ADD CONSTRAINT icecek_tedarikci FOREIGN KEY ("tedarikciNo") REFERENCES public.tedarikci("tedarikciNo");
 A   ALTER TABLE ONLY public.icecek DROP CONSTRAINT icecek_tedarikci;
       public          postgres    false    3304    225    228         	
           2606    18299    kurye kurye_prsonal 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT kurye_prsonal FOREIGN KEY ("personalNo") REFERENCES public.personal("personalNo");
 =   ALTER TABLE ONLY public.kurye DROP CONSTRAINT kurye_prsonal;
       public          postgres    false    221    3285    218         �           2606    18243    sparisler liste-sparis 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT "liste-sparis" FOREIGN KEY (listeno) REFERENCES public.urunlistesi("listeNo");
 B   ALTER TABLE ONLY public.sparisler DROP CONSTRAINT "liste-sparis";
       public          postgres    false    223    3299    214         
           2606    18305    malzeme malzeme_tedarkci 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.malzeme
    ADD CONSTRAINT malzeme_tedarkci FOREIGN KEY ("tedarikciNo") REFERENCES public.tedarikci("tedarikciNo");
 B   ALTER TABLE ONLY public.malzeme DROP CONSTRAINT malzeme_tedarkci;
       public          postgres    false    225    224    3304         
           2606    18311    masalar masa_fatura 
   FK CONSTRAINT     ~   ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masa_fatura FOREIGN KEY ("faturaNo") REFERENCES public.fatura("faturaNo");
 =   ALTER TABLE ONLY public.masalar DROP CONSTRAINT masa_fatura;
       public          postgres    false    215    217    3283         
           2606    18317    masalar masa_garson 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masa_garson FOREIGN KEY ("personalNo ") REFERENCES public.garson("personalNo");
 =   ALTER TABLE ONLY public.masalar DROP CONSTRAINT masa_garson;
       public          postgres    false    215    220    3290          
           2606    18225    sparisler masa_sparis 
   FK CONSTRAINT     {   ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT masa_sparis FOREIGN KEY (masano) REFERENCES public.masalar("masaNo");
 ?   ALTER TABLE ONLY public.sparisler DROP CONSTRAINT masa_sparis;
       public          postgres    false    215    214    3276         
           2606    18337    paket paket_adres 
   FK CONSTRAINT     }   ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_adres FOREIGN KEY ("adresKodu") REFERENCES public.adres("adresKodu");
 ;   ALTER TABLE ONLY public.paket DROP CONSTRAINT paket_adres;
       public          postgres    false    3317    231    216         
           2606    18343    paket paket_fatura 
   FK CONSTRAINT     }   ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_fatura FOREIGN KEY ("faturaNo") REFERENCES public.fatura("faturaNo");
 <   ALTER TABLE ONLY public.paket DROP CONSTRAINT paket_fatura;
       public          postgres    false    3283    216    217         
           2606    18331    paket paket_kurye 
   FK CONSTRAINT        ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_kurye FOREIGN KEY ("personalNo") REFERENCES public.kurye("personalNo");
 ;   ALTER TABLE ONLY public.paket DROP CONSTRAINT paket_kurye;
       public          postgres    false    221    216    3293         
           2606    18231    sparisler paket_sparis 
   FK CONSTRAINT     |   ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT paket_sparis FOREIGN KEY (paketno) REFERENCES public.paket("paketNo");
 @   ALTER TABLE ONLY public.sparisler DROP CONSTRAINT paket_sparis;
       public          postgres    false    216    3281    214         
           2606    18325    paket paket_yonetici 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_yonetici FOREIGN KEY ("yoneticiNo") REFERENCES public.yonetici("yoneticiNo");
 >   ALTER TABLE ONLY public.paket DROP CONSTRAINT paket_yonetici;
       public          postgres    false    219    216    3287         
           2606    18348    sparisler sparis_asci 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT sparis_asci FOREIGN KEY (personalno) REFERENCES public.asci("personalNo");
 ?   ALTER TABLE ONLY public.sparisler DROP CONSTRAINT sparis_asci;
       public          postgres    false    214    3296    222         
           2606    18355    tatli tatli_urun 
   FK CONSTRAINT     u   ALTER TABLE ONLY public.tatli
    ADD CONSTRAINT tatli_urun FOREIGN KEY ("urunNo") REFERENCES public.urun("urunNo");
 :   ALTER TABLE ONLY public.tatli DROP CONSTRAINT tatli_urun;
       public          postgres    false    3306    229    226         
           2606    18361    urunlistesi urunlistei_urun 
   FK CONSTRAINT     �   ALTER TABLE ONLY public.urunlistesi
    ADD CONSTRAINT urunlistei_urun FOREIGN KEY ("urunNo") REFERENCES public.urun("urunNo");
 E   ALTER TABLE ONLY public.urunlistesi DROP CONSTRAINT urunlistei_urun;
       public          postgres    false    223    226    3306                                                                                                                                                                                                                                                                                                          3507.dat                                                                                            0000600 0004000 0002000 00000000037 14351571421 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        130920	130000	900	20	39/6
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 3503.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014242 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3498.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3493.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3496.dat                                                                                            0000600 0004000 0002000 00000000133 14351571421 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        106	muharrem	karay	g	garsonbaşı
107	mehdi	kaya	g	masa temizliği
108	memik	ataş	g	
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                     3504.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3508.dat                                                                                            0000600 0004000 0002000 00000000315 14351571421 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        0	adapazari
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


                                                                                                                                                                                                                                                                                                                   3497.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014256 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3509.dat                                                                                            0000600 0004000 0002000 00000000332 14351571421 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        0	istiklal
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


                                                                                                                                                                                                                                                                                                      3500.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014237 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3491.dat                                                                                            0000600 0004000 0002000 00000000412 14351571421 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	\N	\N
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


                                                                                                                                                                                                                                                      3506.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3492.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3494.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3510.dat                                                                                            0000600 0004000 0002000 00000000353 14351571421 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        0	01
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


                                                                                                                                                                                                                                                                                     3490.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3505.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3501.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014240 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3502.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3499.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3495.dat                                                                                            0000600 0004000 0002000 00000000005 14351571421 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           restore.sql                                                                                         0000600 0004000 0002000 00000066375 14351571421 0015410 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.0

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

DROP DATABASE "Lokanta";
--
-- Name: Lokanta; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Lokanta" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.utf8';


ALTER DATABASE "Lokanta" OWNER TO postgres;

\connect "Lokanta"

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
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    "ilceKodu" integer NOT NULL,
    adi character varying(25) NOT NULL
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: mahalle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mahalle (
    "mahalleKodu" integer NOT NULL,
    adi character varying(25) NOT NULL
);


ALTER TABLE public.mahalle OWNER TO postgres;

--
-- Name: sokak; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sokak (
    "sokakNo" integer NOT NULL,
    adi character varying(25) NOT NULL
);


ALTER TABLE public.sokak OWNER TO postgres;

--
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
-- Name: anayemek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anayemek (
    "servisSekli" character varying(50),
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);


ALTER TABLE public.anayemek OWNER TO postgres;

--
-- Name: personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal (
    "personalNo" integer NOT NULL,
    adi character varying(25) NOT NULL,
    soyadi character varying(25) NOT NULL,
    gorevi "char" NOT NULL
);


ALTER TABLE public.personal OWNER TO postgres;

--
-- Name: asci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asci (
    sorumlulugu character varying(100)
)
INHERITS (public.personal);


ALTER TABLE public.asci OWNER TO postgres;

--
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
-- Name: garson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.garson (
    sorumlulugu character varying(100)
)
INHERITS (public.personal);


ALTER TABLE public.garson OWNER TO postgres;

--
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
-- Name: icecek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.icecek (
    "tedarikciNo" integer NOT NULL,
    "mevcutSayisi" integer
)
INHERITS (public.urun);


ALTER TABLE public.icecek OWNER TO postgres;

--
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
-- Name: kurye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kurye (
    motorplaka character varying(15) NOT NULL
)
INHERITS (public.personal);


ALTER TABLE public.kurye OWNER TO postgres;

--
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
-- Name: malzeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.malzeme (
    "malzemeNo" integer NOT NULL,
    adi character varying(25) NOT NULL,
    miktar integer NOT NULL,
    "tedarikciNo" integer NOT NULL
);


ALTER TABLE public.malzeme OWNER TO postgres;

--
-- Name: masalar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.masalar (
    "masaNo" integer NOT NULL,
    "faturaNo" integer,
    "personalNo " integer
);


ALTER TABLE public.masalar OWNER TO postgres;

--
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
-- Name: mez&extra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."mez&extra" (
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);


ALTER TABLE public."mez&extra" OWNER TO postgres;

--
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
-- Name: tatli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tatli (
    varmi bit(1) NOT NULL
)
INHERITS (public.urun);


ALTER TABLE public.tatli OWNER TO postgres;

--
-- Name: tedarikci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tedarikci (
    "tedarikciNo" integer NOT NULL,
    "telefonNo" numeric(11,0) NOT NULL,
    "firmaAdi" character varying(100) NOT NULL
);


ALTER TABLE public.tedarikci OWNER TO postgres;

--
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
-- Data for Name: adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adres ("adresKodu", "ilceKodu", "mahalleKodu", "sokakNo", "girisDetay") FROM stdin;
\.
COPY public.adres ("adresKodu", "ilceKodu", "mahalleKodu", "sokakNo", "girisDetay") FROM '$$PATH$$/3507.dat';

--
-- Data for Name: anayemek; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anayemek ("urunNo", adi, kalori, fiyati, kategori, "servisSekli", varmi) FROM stdin;
\.
COPY public.anayemek ("urunNo", adi, kalori, fiyati, kategori, "servisSekli", varmi) FROM '$$PATH$$/3503.dat';

--
-- Data for Name: asci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.asci ("personalNo", adi, soyadi, gorevi, sorumlulugu) FROM stdin;
\.
COPY public.asci ("personalNo", adi, soyadi, gorevi, sorumlulugu) FROM '$$PATH$$/3498.dat';

--
-- Data for Name: fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fatura ("faturaNo", tarih, zaman, tutar) FROM stdin;
\.
COPY public.fatura ("faturaNo", tarih, zaman, tutar) FROM '$$PATH$$/3493.dat';

--
-- Data for Name: garson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.garson ("personalNo", adi, soyadi, gorevi, sorumlulugu) FROM stdin;
\.
COPY public.garson ("personalNo", adi, soyadi, gorevi, sorumlulugu) FROM '$$PATH$$/3496.dat';

--
-- Data for Name: icecek; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.icecek ("urunNo", adi, kalori, fiyati, kategori, "tedarikciNo", "mevcutSayisi") FROM stdin;
\.
COPY public.icecek ("urunNo", adi, kalori, fiyati, kategori, "tedarikciNo", "mevcutSayisi") FROM '$$PATH$$/3504.dat';

--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ilce ("ilceKodu", adi) FROM stdin;
\.
COPY public.ilce ("ilceKodu", adi) FROM '$$PATH$$/3508.dat';

--
-- Data for Name: kurye; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kurye ("personalNo", adi, soyadi, gorevi, motorplaka) FROM stdin;
\.
COPY public.kurye ("personalNo", adi, soyadi, gorevi, motorplaka) FROM '$$PATH$$/3497.dat';

--
-- Data for Name: mahalle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mahalle ("mahalleKodu", adi) FROM stdin;
\.
COPY public.mahalle ("mahalleKodu", adi) FROM '$$PATH$$/3509.dat';

--
-- Data for Name: malzeme; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.malzeme ("malzemeNo", adi, miktar, "tedarikciNo") FROM stdin;
\.
COPY public.malzeme ("malzemeNo", adi, miktar, "tedarikciNo") FROM '$$PATH$$/3500.dat';

--
-- Data for Name: masalar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.masalar ("masaNo", "faturaNo", "personalNo ") FROM stdin;
\.
COPY public.masalar ("masaNo", "faturaNo", "personalNo ") FROM '$$PATH$$/3491.dat';

--
-- Data for Name: mez&extra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."mez&extra" ("urunNo", adi, kalori, fiyati, kategori, varmi) FROM stdin;
\.
COPY public."mez&extra" ("urunNo", adi, kalori, fiyati, kategori, varmi) FROM '$$PATH$$/3506.dat';

--
-- Data for Name: paket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paket ("paketNo", "adresKodu", "faturaNo", "yoneticiNo", "personalNo") FROM stdin;
\.
COPY public.paket ("paketNo", "adresKodu", "faturaNo", "yoneticiNo", "personalNo") FROM '$$PATH$$/3492.dat';

--
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal ("personalNo", adi, soyadi, gorevi) FROM stdin;
\.
COPY public.personal ("personalNo", adi, soyadi, gorevi) FROM '$$PATH$$/3494.dat';

--
-- Data for Name: sokak; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sokak ("sokakNo", adi) FROM stdin;
\.
COPY public.sokak ("sokakNo", adi) FROM '$$PATH$$/3510.dat';

--
-- Data for Name: sparisler; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sparisler (sparisno, masano, paketno, listeno, personalno) FROM stdin;
\.
COPY public.sparisler (sparisno, masano, paketno, listeno, personalno) FROM '$$PATH$$/3490.dat';

--
-- Data for Name: tatli; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tatli ("urunNo", adi, kalori, fiyati, kategori, varmi) FROM stdin;
\.
COPY public.tatli ("urunNo", adi, kalori, fiyati, kategori, varmi) FROM '$$PATH$$/3505.dat';

--
-- Data for Name: tedarikci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tedarikci ("tedarikciNo", "telefonNo", "firmaAdi") FROM stdin;
\.
COPY public.tedarikci ("tedarikciNo", "telefonNo", "firmaAdi") FROM '$$PATH$$/3501.dat';

--
-- Data for Name: urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.urun ("urunNo", adi, kalori, fiyati, kategori) FROM stdin;
\.
COPY public.urun ("urunNo", adi, kalori, fiyati, kategori) FROM '$$PATH$$/3502.dat';

--
-- Data for Name: urunlistesi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.urunlistesi ("listeNo", "urunNo", "urunAdedi", tutari) FROM stdin;
\.
COPY public.urunlistesi ("listeNo", "urunNo", "urunAdedi", tutari) FROM '$$PATH$$/3499.dat';

--
-- Data for Name: yonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yonetici ("yoneticiNo", adi, soyadi, sifresi) FROM stdin;
\.
COPY public.yonetici ("yoneticiNo", adi, soyadi, sifresi) FROM '$$PATH$$/3495.dat';

--
-- Name: garsonseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.garsonseq', 108, true);


--
-- Name: ilceseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ilceseq', 130000, true);


--
-- Name: mahalleseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mahalleseq', 1400, true);


--
-- Name: masalarseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.masalarseq', 30, true);


--
-- Name: masasparisseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.masasparisseq', 1, false);


--
-- Name: paketseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paketseq', 1000000, false);


--
-- Name: paketsparisseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paketsparisseq', 1000000, false);


--
-- Name: sokakseq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sokakseq', 39, true);


--
-- Name: adres adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY ("adresKodu");


--
-- Name: fatura fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fatura
    ADD CONSTRAINT fatura_pkey PRIMARY KEY ("faturaNo");


--
-- Name: ilce ilce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY ("ilceKodu");


--
-- Name: mahalle mahalle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mahalle
    ADD CONSTRAINT mahalle_pkey PRIMARY KEY ("mahalleKodu");


--
-- Name: malzeme malzeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.malzeme
    ADD CONSTRAINT malzeme_pkey PRIMARY KEY ("malzemeNo");


--
-- Name: masalar masalar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masalar_pkey PRIMARY KEY ("masaNo");


--
-- Name: paket pakert_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT pakert_pkey PRIMARY KEY ("paketNo");


--
-- Name: personal personal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY ("personalNo");


--
-- Name: asci primaryofasci; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asci
    ADD CONSTRAINT primaryofasci PRIMARY KEY ("personalNo");


--
-- Name: garson primaryofgarson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.garson
    ADD CONSTRAINT primaryofgarson PRIMARY KEY ("personalNo");


--
-- Name: icecek primaryoficecek; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icecek
    ADD CONSTRAINT primaryoficecek PRIMARY KEY ("urunNo");


--
-- Name: kurye primaryofkurye; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT primaryofkurye PRIMARY KEY ("personalNo");


--
-- Name: mez&extra primaryofmez&extra; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."mez&extra"
    ADD CONSTRAINT "primaryofmez&extra" PRIMARY KEY ("urunNo");


--
-- Name: tatli primaryoftatli; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tatli
    ADD CONSTRAINT primaryoftatli PRIMARY KEY ("urunNo");


--
-- Name: sokak sokak_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sokak
    ADD CONSTRAINT sokak_pkey PRIMARY KEY ("sokakNo");


--
-- Name: sparisler sparisler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT sparisler_pkey PRIMARY KEY (sparisno);


--
-- Name: tedarikci tedarikci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikci
    ADD CONSTRAINT tedarikci_pkey PRIMARY KEY ("tedarikciNo");


--
-- Name: urunlistesi urunListesi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urunlistesi
    ADD CONSTRAINT "urunListesi_pkey" PRIMARY KEY ("listeNo");


--
-- Name: urun urun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_pkey PRIMARY KEY ("urunNo");


--
-- Name: yonetici yonetici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yonetici
    ADD CONSTRAINT yonetici_pkey PRIMARY KEY ("yoneticiNo");


--
-- Name: fki_a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_a ON public.paket USING btree ("adresKodu");


--
-- Name: fki_adres_ilce; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_adres_ilce ON public.adres USING btree ("ilceKodu");


--
-- Name: fki_adres_mahalle; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_adres_mahalle ON public.adres USING btree ("mahalleKodu");


--
-- Name: fki_adres_sokak; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_adres_sokak ON public.adres USING btree ("sokakNo");


--
-- Name: fki_anayemek_urun; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_anayemek_urun ON public.anayemek USING btree ("urunNo");


--
-- Name: fki_asci_personal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_asci_personal ON public.asci USING btree ("personalNo");


--
-- Name: fki_f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_f ON public.masalar USING btree ("faturaNo");


--
-- Name: fki_icecek_tedarikci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_icecek_tedarikci ON public.icecek USING btree ("tedarikciNo");


--
-- Name: fki_kurye_prsonal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_kurye_prsonal ON public.kurye USING btree ("personalNo");


--
-- Name: fki_liste-sparis; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_liste-sparis" ON public.sparisler USING btree (listeno);


--
-- Name: fki_malzeme_tedarkci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_malzeme_tedarkci ON public.malzeme USING btree ("tedarikciNo");


--
-- Name: fki_masa_personal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_masa_personal ON public.masalar USING btree ("personalNo ");


--
-- Name: fki_p; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_p ON public.garson USING btree ("personalNo");


--
-- Name: fki_paket_kurye; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_paket_kurye ON public.paket USING btree ("personalNo");


--
-- Name: fki_paket_personal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_paket_personal ON public.sparisler USING btree (personalno);


--
-- Name: fki_paket_sparis; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_paket_sparis ON public.sparisler USING btree (paketno);


--
-- Name: fki_tatli_urun; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_tatli_urun ON public.tatli USING btree ("urunNo");


--
-- Name: fki_urunlistei_urun; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_urunlistei_urun ON public.urunlistesi USING btree ("urunNo");


--
-- Name: fki_y; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_y ON public.paket USING btree ("yoneticiNo");


--
-- Name: fki_ة; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_ة" ON public.sparisler USING btree (masano);


--
-- Name: adres adres_ilce; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_ilce FOREIGN KEY ("ilceKodu") REFERENCES public.ilce("ilceKodu");


--
-- Name: adres adres_mahalle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_mahalle FOREIGN KEY ("mahalleKodu") REFERENCES public.mahalle("mahalleKodu");


--
-- Name: adres adres_sokak; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_sokak FOREIGN KEY ("sokakNo") REFERENCES public.sokak("sokakNo");


--
-- Name: anayemek anayemek_uru; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anayemek
    ADD CONSTRAINT anayemek_uru FOREIGN KEY ("urunNo") REFERENCES public.urun("urunNo");


--
-- Name: asci asci_personal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asci
    ADD CONSTRAINT asci_personal FOREIGN KEY ("personalNo") REFERENCES public.personal("personalNo");


--
-- Name: icecek icecek_tedarikci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icecek
    ADD CONSTRAINT icecek_tedarikci FOREIGN KEY ("tedarikciNo") REFERENCES public.tedarikci("tedarikciNo");


--
-- Name: kurye kurye_prsonal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye
    ADD CONSTRAINT kurye_prsonal FOREIGN KEY ("personalNo") REFERENCES public.personal("personalNo");


--
-- Name: sparisler liste-sparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT "liste-sparis" FOREIGN KEY (listeno) REFERENCES public.urunlistesi("listeNo");


--
-- Name: malzeme malzeme_tedarkci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.malzeme
    ADD CONSTRAINT malzeme_tedarkci FOREIGN KEY ("tedarikciNo") REFERENCES public.tedarikci("tedarikciNo");


--
-- Name: masalar masa_fatura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masa_fatura FOREIGN KEY ("faturaNo") REFERENCES public.fatura("faturaNo");


--
-- Name: masalar masa_garson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.masalar
    ADD CONSTRAINT masa_garson FOREIGN KEY ("personalNo ") REFERENCES public.garson("personalNo");


--
-- Name: sparisler masa_sparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT masa_sparis FOREIGN KEY (masano) REFERENCES public.masalar("masaNo");


--
-- Name: paket paket_adres; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_adres FOREIGN KEY ("adresKodu") REFERENCES public.adres("adresKodu");


--
-- Name: paket paket_fatura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_fatura FOREIGN KEY ("faturaNo") REFERENCES public.fatura("faturaNo");


--
-- Name: paket paket_kurye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_kurye FOREIGN KEY ("personalNo") REFERENCES public.kurye("personalNo");


--
-- Name: sparisler paket_sparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT paket_sparis FOREIGN KEY (paketno) REFERENCES public.paket("paketNo");


--
-- Name: paket paket_yonetici; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_yonetici FOREIGN KEY ("yoneticiNo") REFERENCES public.yonetici("yoneticiNo");


--
-- Name: sparisler sparis_asci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sparisler
    ADD CONSTRAINT sparis_asci FOREIGN KEY (personalno) REFERENCES public.asci("personalNo");


--
-- Name: tatli tatli_urun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tatli
    ADD CONSTRAINT tatli_urun FOREIGN KEY ("urunNo") REFERENCES public.urun("urunNo");


--
-- Name: urunlistesi urunlistei_urun; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urunlistesi
    ADD CONSTRAINT urunlistei_urun FOREIGN KEY ("urunNo") REFERENCES public.urun("urunNo");


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   


-- tartar