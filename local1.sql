--
-- PostgreSQL database dump
--

\restrict QTQkcbFV109ROHvh9hm4dgfrdW1s9ConC05ipg2hmNGTktsdcjyEdvSDYRySa9O

-- Dumped from database version 17.10
-- Dumped by pg_dump version 17.10

-- Started on 2026-09-25 19:46:48

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
-- TOC entry 928 (class 1247 OID 24886)
-- Name: t_alamat; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_alamat AS character varying(100);


ALTER DOMAIN public.t_alamat OWNER TO postgres;

--
-- TOC entry 931 (class 1247 OID 24888)
-- Name: t_alamat_panjang; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_alamat_panjang AS character varying(250);


ALTER DOMAIN public.t_alamat_panjang OWNER TO postgres;

--
-- TOC entry 934 (class 1247 OID 24890)
-- Name: t_bool; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_bool AS boolean DEFAULT true;


ALTER DOMAIN public.t_bool OWNER TO postgres;

--
-- TOC entry 937 (class 1247 OID 24892)
-- Name: t_diskon; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_diskon AS numeric(5,2) DEFAULT 0.00;


ALTER DOMAIN public.t_diskon OWNER TO postgres;

--
-- TOC entry 940 (class 1247 OID 24894)
-- Name: t_guid; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_guid AS character(36);


ALTER DOMAIN public.t_guid OWNER TO postgres;

--
-- TOC entry 943 (class 1247 OID 24896)
-- Name: t_harga; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_harga AS numeric(15,2) DEFAULT 0.00;


ALTER DOMAIN public.t_harga OWNER TO postgres;

--
-- TOC entry 946 (class 1247 OID 24898)
-- Name: t_jumlah; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_jumlah AS numeric(10,2) DEFAULT 0.00;


ALTER DOMAIN public.t_jumlah OWNER TO postgres;

--
-- TOC entry 949 (class 1247 OID 24900)
-- Name: t_keterangan; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_keterangan AS character varying(100);


ALTER DOMAIN public.t_keterangan OWNER TO postgres;

--
-- TOC entry 952 (class 1247 OID 24902)
-- Name: t_kode_pos; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_kode_pos AS character varying(6);


ALTER DOMAIN public.t_kode_pos OWNER TO postgres;

--
-- TOC entry 955 (class 1247 OID 24904)
-- Name: t_kode_produk; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_kode_produk AS character varying(15);


ALTER DOMAIN public.t_kode_produk OWNER TO postgres;

--
-- TOC entry 958 (class 1247 OID 24906)
-- Name: t_nama; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_nama AS character varying(50);


ALTER DOMAIN public.t_nama OWNER TO postgres;

--
-- TOC entry 961 (class 1247 OID 24908)
-- Name: t_nama_panjang; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_nama_panjang AS character varying(300);


ALTER DOMAIN public.t_nama_panjang OWNER TO postgres;

--
-- TOC entry 964 (class 1247 OID 24910)
-- Name: t_nota; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_nota AS character varying(20);


ALTER DOMAIN public.t_nota OWNER TO postgres;

--
-- TOC entry 967 (class 1247 OID 24912)
-- Name: t_password; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_password AS character(32);


ALTER DOMAIN public.t_password OWNER TO postgres;

--
-- TOC entry 970 (class 1247 OID 24914)
-- Name: t_satuan; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_satuan AS character varying(20);


ALTER DOMAIN public.t_satuan OWNER TO postgres;

--
-- TOC entry 973 (class 1247 OID 24916)
-- Name: t_telepon; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.t_telepon AS character varying(20);


ALTER DOMAIN public.t_telepon OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 24917)
-- Name: f_hapus_header_bayar_hutang_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_hapus_header_bayar_hutang_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE var_pembayaran_hutang_produk_id t_guid;
DECLARE var_row_count integer;

BEGIN		    
    var_pembayaran_hutang_produk_id := OLD.pembayaran_hutang_produk_id;
	
    var_row_count := (select count(*) from t_item_pembayaran_hutang_produk
                      where pembayaran_hutang_produk_id = var_pembayaran_hutang_produk_id);
                      
    IF var_row_count IS NULL THEN
        var_row_count := 0;  
    END IF;
	
	IF (var_row_count = 0) THEN
    	DELETE FROM t_pembayaran_hutang_produk WHERE pembayaran_hutang_produk_id = var_pembayaran_hutang_produk_id;
    END IF;
    
  	RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_hapus_header_bayar_hutang_produk() OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 24918)
-- Name: f_hapus_header_bayar_piutang_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_hapus_header_bayar_piutang_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE var_pembayaran_piutang_id t_guid;
DECLARE var_row_count integer;

BEGIN		    
    var_pembayaran_piutang_id := OLD.pembayaran_piutang_id;
	
    var_row_count := (select count(*) from t_item_pembayaran_piutang_produk
                      where pembayaran_piutang_id = var_pembayaran_piutang_id);
                      
    IF var_row_count IS NULL THEN
        var_row_count := 0;  
    END IF;
	
	IF (var_row_count = 0) THEN
    	DELETE FROM t_pembayaran_piutang_produk WHERE pembayaran_piutang_id = var_pembayaran_piutang_id;
    END IF;
    
  	RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_hapus_header_bayar_piutang_produk() OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 24919)
-- Name: f_kurangi_stok_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_kurangi_stok_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
	var_produk_id 				t_guid;
    
	var_stok_sekarang 			t_jumlah; -- stok etalase	
    var_stok_gudang_sekarang 	t_jumlah; -- stok gudang
    
    var_jumlah_lama 		t_jumlah;
	var_jumlah_baru 		t_jumlah;
    
    var_jumlah_retur_lama 	t_jumlah;
    var_jumlah_retur_baru 	t_jumlah;

	var_harga 				t_harga;
    
    is_retur				t_bool;
    is_update_harga_jual	t_bool;
    
BEGIN		
	is_retur := FALSE;
                
    IF TG_OP = 'INSERT' THEN
    	var_produk_id := NEW.produk_id;
        var_jumlah_baru = NEW.jumlah;        
        var_harga = NEW.harga_jual;

	ELSIF TG_OP = 'UPDATE' THEN      
    	var_produk_id := NEW.produk_id;
        var_jumlah_baru = NEW.jumlah;
        var_jumlah_lama = OLD.jumlah;
        var_harga = NEW.harga_jual;
        
        -- jumlah retur
        var_jumlah_retur_baru = NEW.jumlah_retur;
        var_jumlah_retur_lama = OLD.jumlah_retur;        
    ELSE
    	var_produk_id := OLD.produk_id;
        var_jumlah_lama = OLD.jumlah;
        var_harga = OLD.harga_jual;
    END IF;        
            
    SELECT stok, stok_gudang INTO var_stok_sekarang, var_stok_gudang_sekarang
    FROM m_produk WHERE produk_id = var_produk_id;
    
    IF var_stok_sekarang IS NULL THEN -- stok etalase
        var_stok_sekarang := 0;  
    END IF;
    
    IF var_stok_gudang_sekarang IS NULL THEN -- stok gudang
        var_stok_gudang_sekarang := 0;  
    END IF;
        
    IF TG_OP = 'UPDATE' THEN -- pengecekan retur
    	IF var_jumlah_retur_lama <> var_jumlah_retur_baru THEN
        	is_retur := TRUE;                    
            
            IF var_jumlah_retur_lama IS NULL THEN
                var_jumlah_retur_lama := 0;  
            END IF;
            
            IF var_jumlah_retur_baru IS NULL THEN
                var_jumlah_retur_baru := 0;  
            END IF;
                           
            var_stok_gudang_sekarang = var_stok_gudang_sekarang - var_jumlah_retur_lama + var_jumlah_retur_baru;
			            
            UPDATE m_produk SET stok_gudang = var_stok_gudang_sekarang WHERE produk_id = var_produk_id;
        END IF;        
    END IF;
	
    IF (is_retur = FALSE) THEN -- bukan retur    	    	        
        IF TG_OP = 'INSERT' THEN
            var_stok_gudang_sekarang := var_stok_gudang_sekarang - var_jumlah_baru;
            
            IF (var_stok_gudang_sekarang < 0 AND var_stok_sekarang > 0) THEN -- stok gudang kurang, sisanya ambil dari stok etalase
            	var_stok_sekarang = var_stok_sekarang - abs(var_stok_gudang_sekarang);
                
                IF (var_stok_sekarang >= 0) THEN
                	var_stok_gudang_sekarang := 0; --stok gudang habis
                ELSE
                	var_stok_gudang_sekarang := var_stok_sekarang;
                    var_stok_sekarang := 0;
                END IF;
            END IF;
                        
            
        ELSIF TG_OP = 'UPDATE' THEN      
            var_stok_gudang_sekarang = var_stok_gudang_sekarang + var_jumlah_lama - var_jumlah_baru;
        ELSE
            var_stok_gudang_sekarang = var_stok_gudang_sekarang + var_jumlah_lama;
        END IF;
        
        IF TG_OP = 'INSERT' THEN   
            -- baca setting aplikasi
        	SELECT is_update_harga_jual_master_produk INTO is_update_harga_jual
            FROM m_setting_aplikasi LIMIT 1;
            
            IF is_update_harga_jual IS NULL THEN
				is_update_harga_jual := TRUE;
            END IF;
    
        	IF (is_update_harga_jual = TRUE) THEN -- update harga jual di master produk
            	UPDATE m_produk SET stok = var_stok_sekarang, stok_gudang = var_stok_gudang_sekarang, harga_jual = var_harga WHERE produk_id = var_produk_id;
            ELSE          
	            UPDATE m_produk SET stok = var_stok_sekarang, stok_gudang = var_stok_gudang_sekarang WHERE produk_id = var_produk_id;        
			END IF;         
        ELSE        
            UPDATE m_produk SET stok = var_stok_sekarang, stok_gudang = var_stok_gudang_sekarang WHERE produk_id = var_produk_id;        
        END IF;    
    END IF;	
            
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_kurangi_stok_produk() OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 24920)
-- Name: f_penyesuaian_stok_aiud(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_penyesuaian_stok_aiud() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	var_produk_id 						t_guid;
    
    var_stok_etalase					t_jumlah;
    var_stok_gudang						t_jumlah;
    
    var_penambahan_stok_etalase			t_jumlah;
    var_penambahan_stok_gudang			t_jumlah;
    
    var_pengurangan_stok_etalase		t_jumlah;
    var_pengurangan_stok_gudang			t_jumlah;
    
    var_penambahan_stok_etalase_old		t_jumlah;
    var_penambahan_stok_gudang_old		t_jumlah;
    
    var_pengurangan_stok_etalase_old	t_jumlah;
    var_pengurangan_stok_gudang_old		t_jumlah;
    
BEGIN    
	IF TG_OP = 'INSERT' THEN
    	var_produk_id := NEW.produk_id;
        
        var_penambahan_stok_etalase = NEW.penambahan_stok;        
		var_penambahan_stok_gudang = NEW.penambahan_stok_gudang;        
        
        var_pengurangan_stok_etalase = NEW.pengurangan_stok;        
		var_pengurangan_stok_gudang = NEW.pengurangan_stok_gudang;        

	ELSIF TG_OP = 'UPDATE' THEN      
    	var_produk_id := NEW.produk_id;
        
        var_penambahan_stok_etalase = NEW.penambahan_stok;        
        var_penambahan_stok_etalase_old = OLD.penambahan_stok;        
        
		var_penambahan_stok_gudang = NEW.penambahan_stok_gudang;        
        var_penambahan_stok_gudang_old = OLD.penambahan_stok_gudang;        
        
        var_pengurangan_stok_etalase = NEW.pengurangan_stok;        
        var_pengurangan_stok_etalase_old = OLD.pengurangan_stok;        
        
		var_pengurangan_stok_gudang = NEW.pengurangan_stok_gudang;        
        var_pengurangan_stok_gudang_old = OLD.pengurangan_stok_gudang;        
               
    ELSE
    	var_produk_id := OLD.produk_id;
        
        var_penambahan_stok_etalase_old = OLD.penambahan_stok;                
        var_penambahan_stok_gudang_old = OLD.penambahan_stok_gudang;        
        
        var_pengurangan_stok_etalase_old = OLD.pengurangan_stok;                
        var_pengurangan_stok_gudang_old = OLD.pengurangan_stok_gudang; 
    END IF;
    
    SELECT stok, stok_gudang INTO var_stok_etalase, var_stok_gudang
    FROM m_produk WHERE produk_id = var_produk_id;
    
    IF var_stok_etalase IS NULL THEN
        var_stok_etalase := 0;  
    END IF;
    
    IF var_stok_gudang IS NULL THEN
        var_stok_gudang := 0;  
    END IF;
    
    IF TG_OP = 'INSERT' THEN		         
        IF (var_penambahan_stok_etalase > 0 OR var_penambahan_stok_gudang > 0) THEN
        	var_stok_etalase := var_stok_etalase + var_penambahan_stok_etalase;
            var_stok_gudang := var_stok_gudang + var_penambahan_stok_gudang;                    	
        END IF;   	        
        
        IF (var_pengurangan_stok_etalase > 0 OR var_pengurangan_stok_gudang > 0) THEN
        	var_stok_etalase := var_stok_etalase - var_pengurangan_stok_etalase;
            var_stok_gudang := var_stok_gudang - var_pengurangan_stok_gudang;                    	
        END IF;        

	ELSIF TG_OP = 'UPDATE' THEN      		      	                     
        IF (var_penambahan_stok_etalase > 0 OR var_penambahan_stok_etalase_old > 0 OR var_penambahan_stok_gudang > 0 OR var_penambahan_stok_gudang_old > 0) THEN
        	var_stok_etalase := var_stok_etalase - var_penambahan_stok_etalase_old + var_penambahan_stok_etalase;
            var_stok_gudang := var_stok_gudang - var_penambahan_stok_gudang_old + var_penambahan_stok_gudang;                    	
        END IF;
        
        IF (var_pengurangan_stok_etalase > 0 OR var_pengurangan_stok_etalase_old > 0 OR var_pengurangan_stok_gudang > 0 OR var_pengurangan_stok_gudang_old > 0) THEN
			var_stok_etalase := var_stok_etalase + var_pengurangan_stok_etalase_old - var_pengurangan_stok_etalase;
            var_stok_gudang := var_stok_gudang + var_pengurangan_stok_gudang_old - var_pengurangan_stok_gudang;                    	
        END IF;                        
        
    ELSE    	        
        IF (var_penambahan_stok_etalase_old > 0 OR var_penambahan_stok_gudang_old > 0) THEN
        	var_stok_etalase := var_stok_etalase - var_penambahan_stok_etalase_old;
            var_stok_gudang := var_stok_gudang - var_penambahan_stok_gudang_old;
        END IF;
        
        IF (var_pengurangan_stok_etalase_old > 0 OR var_pengurangan_stok_gudang_old > 0) THEN
        	var_stok_etalase := var_stok_etalase + var_pengurangan_stok_etalase_old;
            var_stok_gudang := var_stok_gudang + var_pengurangan_stok_gudang_old;
        END IF;
    END IF;    
    
    UPDATE m_produk SET stok = var_stok_etalase, stok_gudang = var_stok_gudang WHERE produk_id = var_produk_id;
            
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_penyesuaian_stok_aiud() OWNER TO postgres;

--
-- TOC entry 298 (class 1255 OID 24921)
-- Name: f_tambah_stok_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_tambah_stok_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
	var_produk_id 				t_guid;
	
    var_stok_awal				t_jumlah;
	var_stok_akhir				t_jumlah;
    var_stok_sekarang 			t_jumlah; -- stok etalase
	var_stok_gudang_sekarang 	t_jumlah; -- stok gudang
    
    var_jumlah_lama 			t_jumlah;
	var_jumlah_baru 			t_jumlah;
	
    var_jumlah_retur_lama 		t_jumlah;
    var_jumlah_retur_baru 		t_jumlah;
    
	var_harga 					t_harga; -- harga beli di item beli
    var_hpp_awal				t_harga; -- harga beli di master produk
    var_hpp_akhir				t_harga;
	var_saldo_awal				t_harga; -- (stok etalasi + stok gudang) * harga beli di master produk 
    var_saldo_pembelian			t_harga;
    
    is_retur					t_bool;
  
BEGIN		   
	is_retur := FALSE;	
    	     
    IF TG_OP = 'INSERT' THEN
    	var_produk_id := NEW.produk_id;
        var_jumlah_baru = NEW.jumlah;
        var_harga = NEW.harga;
        
	ELSIF TG_OP = 'UPDATE' THEN      
    	var_produk_id := NEW.produk_id;
        var_jumlah_baru = NEW.jumlah;
        var_jumlah_lama = OLD.jumlah;
        var_harga = NEW.harga;
        
        -- jumlah retur
        var_jumlah_retur_baru = NEW.jumlah_retur;
        var_jumlah_retur_lama = OLD.jumlah_retur;                
    ELSE
    	var_produk_id := OLD.produk_id;
        var_jumlah_baru = 0;
        var_jumlah_lama = OLD.jumlah;
        var_harga = OLD.harga;
    END IF;        
    
    SELECT stok, stok_gudang, harga_beli INTO var_stok_sekarang, var_stok_gudang_sekarang, var_hpp_awal
    FROM m_produk WHERE produk_id = var_produk_id;
    
    IF var_stok_sekarang IS NULL THEN
    	var_stok_sekarang := 0;  
	END IF;
    
    IF var_stok_gudang_sekarang IS NULL THEN
    	var_stok_gudang_sekarang := 0;  
	END IF;
    
    IF var_hpp_awal IS NULL THEN
    	var_hpp_awal := 0;  
	END IF;        
    
    var_stok_akhir := 1;
    var_stok_awal := var_stok_sekarang + var_stok_gudang_sekarang;    
    var_saldo_awal := var_stok_awal * var_hpp_awal;
    
    IF TG_OP = 'UPDATE' THEN -- pengecekan retur
    	IF var_jumlah_retur_lama <> var_jumlah_retur_baru THEN
        	is_retur := TRUE;                    
            
            IF var_jumlah_retur_lama IS NULL THEN
                var_jumlah_retur_lama := 0;  
            END IF;
            
            IF var_jumlah_retur_baru IS NULL THEN
                var_jumlah_retur_baru := 0;  
            END IF;
			          
            var_saldo_pembelian := ABS(var_jumlah_retur_lama - var_jumlah_retur_baru) * var_harga;  
            
            var_stok_akhir := (var_stok_awal - ABS(var_jumlah_retur_lama - var_jumlah_retur_baru));
            IF (var_stok_akhir = 0) THEN
            	var_stok_akhir := 1;
            END IF;
            
            var_hpp_akhir := (var_saldo_awal - var_saldo_pembelian) / var_stok_akhir;
                                       
            var_stok_gudang_sekarang = var_stok_gudang_sekarang + var_jumlah_retur_lama - var_jumlah_retur_baru;			            
                          			            
            UPDATE m_produk SET stok_gudang = var_stok_gudang_sekarang, harga_beli = ROUND(var_hpp_akhir, 0) WHERE produk_id = var_produk_id;
        END IF;        
    END IF;
    
    IF (is_retur = FALSE) THEN -- bukan retur    	        	                                    
      IF TG_OP = 'INSERT' THEN                        
          var_saldo_pembelian := var_jumlah_baru * var_harga;          
          
          var_stok_akhir := (var_stok_awal + var_jumlah_baru);
          
          IF (var_stok_akhir = 0) THEN
              var_stok_akhir := 1;
          END IF;
          
		  var_hpp_akhir := (var_saldo_awal + var_saldo_pembelian) / var_stok_akhir;                                         
          
          var_stok_gudang_sekarang = var_stok_gudang_sekarang + var_jumlah_baru;
          
      ELSIF TG_OP = 'UPDATE' THEN             
          var_saldo_pembelian := ABS(var_jumlah_baru - var_jumlah_lama) * var_harga;
          var_hpp_akhir := var_hpp_awal;
          
      	  IF (var_jumlah_baru > var_jumlah_lama) THEN      
          	
          	 var_stok_akhir := (var_stok_awal + var_jumlah_baru - var_jumlah_lama);
             IF (var_stok_akhir = 0) THEN
             	var_stok_akhir := 1;
             END IF;

          	 var_hpp_akhir := (var_saldo_awal + var_saldo_pembelian) / var_stok_akhir;                     
             
          ELSEIF (var_jumlah_baru < var_jumlah_lama) THEN          	 
          	 
          	 var_stok_akhir := (var_stok_awal - ABS(var_jumlah_baru - var_jumlah_lama));
             IF (var_stok_akhir = 0) THEN
             	var_stok_akhir := 1;
             END IF;
             
          	 var_hpp_akhir := (var_saldo_awal - var_saldo_pembelian) / var_stok_akhir;                                   
          END IF;          
                                        
          var_stok_gudang_sekarang = var_stok_gudang_sekarang - var_jumlah_lama + var_jumlah_baru;
      ELSE -- DELETE
          var_saldo_pembelian := var_jumlah_lama * var_harga;
          
          var_stok_akhir := (var_stok_awal - var_jumlah_lama);
          IF (var_stok_akhir = 0) THEN
             var_stok_akhir := 1;
          END IF;
             
          var_hpp_akhir := (var_saldo_awal - var_saldo_pembelian) / var_stok_akhir;                     
                    
          var_stok_gudang_sekarang = var_stok_gudang_sekarang - var_jumlah_lama;          
      END IF;          
      
	  UPDATE m_produk SET stok_gudang = var_stok_gudang_sekarang, harga_beli = ROUND(var_hpp_akhir, 0) WHERE produk_id = var_produk_id;              
    END IF;    	
            
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_tambah_stok_produk() OWNER TO postgres;

--
-- TOC entry 299 (class 1255 OID 24922)
-- Name: f_update_jumlah_retur_beli(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_jumlah_retur_beli() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	var_item_beli_id 		t_guid;
    var_jumlah_retur		t_jumlah;
        
BEGIN	
      
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_item_beli_id := NEW.item_beli_id;    
        var_jumlah_retur := NEW.jumlah_retur;
    ELSE
    	var_item_beli_id := OLD.item_beli_id;
        var_jumlah_retur := 0;
    END IF;
    
    IF var_jumlah_retur IS NULL THEN
        var_jumlah_retur := 0;  
    END IF; 
            
    UPDATE t_item_beli_produk SET jumlah_retur = var_jumlah_retur 
    WHERE item_beli_produk_id = var_item_beli_id;
	
	RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_jumlah_retur_beli() OWNER TO postgres;

--
-- TOC entry 300 (class 1255 OID 24923)
-- Name: f_update_jumlah_retur_jual(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_jumlah_retur_jual() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	var_item_jual_id 		t_guid;
    var_jumlah_retur		t_jumlah;
        
BEGIN	
      
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_item_jual_id := NEW.item_jual_id;    
        var_jumlah_retur := NEW.jumlah_retur;
    ELSE
    	var_item_jual_id := OLD.item_jual_id;
        var_jumlah_retur := 0;
    END IF;
    
    IF var_jumlah_retur IS NULL THEN
        var_jumlah_retur := 0;  
    END IF; 
            
    UPDATE t_item_jual_produk SET jumlah_retur = var_jumlah_retur 
    WHERE item_jual_id = var_item_jual_id;
	
	RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_jumlah_retur_jual() OWNER TO postgres;

--
-- TOC entry 301 (class 1255 OID 24924)
-- Name: f_update_pelunasan_beli_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_pelunasan_beli_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE var_beli_produk_id t_guid;
DECLARE var_pelunasan_nota t_harga;
  
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_beli_produk_id := NEW.beli_produk_id;    
    ELSE
    	var_beli_produk_id := OLD.beli_produk_id;
    END IF;
	        
    var_pelunasan_nota := (SELECT SUM(nominal) FROM t_item_pembayaran_hutang_produk 
    			 	       WHERE beli_produk_id = var_beli_produk_id);
	
    IF var_pelunasan_nota IS NULL THEN
    	var_pelunasan_nota := 0;  
	END IF;
    
    UPDATE t_beli_produk SET total_pelunasan = var_pelunasan_nota 
    WHERE beli_produk_id = var_beli_produk_id;                        
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_pelunasan_beli_produk() OWNER TO postgres;

--
-- TOC entry 302 (class 1255 OID 24925)
-- Name: f_update_pelunasan_jual_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_pelunasan_jual_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE var_jual_id t_guid;
DECLARE var_pelunasan_nota t_harga;
  
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_jual_id := NEW.jual_id;    
    ELSE
    	var_jual_id := OLD.jual_id;
    END IF;
	        
    var_pelunasan_nota := (SELECT SUM(nominal) FROM t_item_pembayaran_piutang_produk 
    			 	       WHERE jual_id = var_jual_id);	
    IF var_pelunasan_nota IS NULL THEN
    	var_pelunasan_nota := 0;  
	END IF;
    
    UPDATE t_jual_produk SET total_pelunasan = var_pelunasan_nota 
    WHERE jual_id = var_jual_id;                        
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_pelunasan_jual_produk() OWNER TO postgres;

--
-- TOC entry 303 (class 1255 OID 24926)
-- Name: f_update_pelunasan_kasbon(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_pelunasan_kasbon() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
	var_kasbon_id				t_guid;   
    var_gaji_karyawan_id		t_guid; 
	var_total_pelunasan_kasbon 	t_harga;

BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_kasbon_id := NEW.kasbon_id;    
        var_gaji_karyawan_id := NEW.gaji_karyawan_id;
    ELSE
    	var_kasbon_id := OLD.kasbon_id;
        var_gaji_karyawan_id := OLD.gaji_karyawan_id;
    END IF;
	        
    -- pelunasan kasbon
    var_total_pelunasan_kasbon := (SELECT SUM(nominal) FROM t_pembayaran_kasbon 
    							   WHERE kasbon_id = var_kasbon_id);	    
	
    IF var_total_pelunasan_kasbon IS NULL THEN
    	var_total_pelunasan_kasbon := 0;  
	END IF;        
    
    -- kasbon
    UPDATE t_kasbon SET total_pelunasan = var_total_pelunasan_kasbon 
    WHERE kasbon_id = var_kasbon_id;    
    
    -- hitung total pelunasan yang dibayar pake gaji (potongan gaji untuk kasbon) 
    IF NOT (var_gaji_karyawan_id IS NULL) THEN
    	-- pelunasan kasbon
    	var_total_pelunasan_kasbon := (SELECT SUM(nominal) FROM t_pembayaran_kasbon 
    							   	   WHERE gaji_karyawan_id = var_gaji_karyawan_id);	    
	
	    IF var_total_pelunasan_kasbon IS NULL THEN
    		var_total_pelunasan_kasbon := 0;  
		END IF;
    	
        UPDATE t_gaji_karyawan SET kasbon = var_total_pelunasan_kasbon 
	    WHERE gaji_karyawan_id = var_gaji_karyawan_id;
	END IF;
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_pelunasan_kasbon() OWNER TO postgres;

--
-- TOC entry 304 (class 1255 OID 24927)
-- Name: f_update_total_beli_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_total_beli_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
	var_beli_produk_id 		t_guid;
    var_retur_beli_id		t_guid;
    var_diskon				t_harga;
    var_ppn					t_harga;
	var_total_nota 			t_harga;
  	var_jumlah_retur_lama 	t_jumlah;
    var_jumlah_retur_baru 	t_jumlah;
    var_tanggal_tempo		DATE;  
    is_retur				t_bool;
    
BEGIN
	is_retur := FALSE;
    
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_beli_produk_id := NEW.beli_produk_id;    
    ELSE
    	var_beli_produk_id := OLD.beli_produk_id;
    END IF;	 
                       
    var_total_nota := (SELECT SUM((jumlah - jumlah_retur) * (harga - (diskon / 100 * harga))) 
    				   FROM t_item_beli_produk
					   WHERE beli_produk_id = var_beli_produk_id);
	
    IF var_total_nota IS NULL THEN
    	var_total_nota := 0;  
	END IF;              
    --
    SELECT ppn, diskon INTO var_ppn, var_diskon
    FROM t_beli_produk WHERE beli_produk_id = var_beli_produk_id;            
    
    IF var_ppn IS NULL THEN
    	var_ppn := 0;  
	END IF;
    
    IF var_diskon IS NULL THEN
    	var_diskon := 0;  
	END IF;           

	IF TG_OP = 'UPDATE' THEN -- pengecekan retur
    	-- jumlah retur
        var_jumlah_retur_baru = NEW.jumlah_retur;
        var_jumlah_retur_lama = OLD.jumlah_retur;        
        
    	IF var_jumlah_retur_lama <> var_jumlah_retur_baru THEN
			is_retur := TRUE;
			
            var_retur_beli_id := (SELECT retur_beli_produk_id FROM t_retur_beli_produk WHERE beli_produk_id = var_beli_produk_id LIMIT 1);
			var_tanggal_tempo := (SELECT tanggal_tempo FROM t_beli_produk WHERE beli_produk_id = var_beli_produk_id);                                    
            
            IF var_tanggal_tempo IS NULL THEN -- nota tunai            	
                UPDATE t_beli_produk SET total_nota = ROUND(var_total_nota, 0), retur_beli_produk_id = var_retur_beli_id 
                WHERE beli_produk_id = var_beli_produk_id;                
                
                UPDATE t_item_pembayaran_hutang_produk SET nominal = ROUND(var_total_nota, 0) - var_diskon + var_ppn
                WHERE beli_produk_id = var_beli_produk_id;
            ELSE
            	UPDATE t_beli_produk SET total_nota = ROUND(var_total_nota, 0), retur_beli_produk_id = var_retur_beli_id 
                WHERE beli_produk_id = var_beli_produk_id;
            END IF;        
        END IF;        
    END IF;
    
    IF (is_retur = FALSE) THEN -- bukan retur    	
	    UPDATE t_beli_produk SET total_nota = ROUND(var_total_nota, 0) 
        WHERE beli_produk_id = var_beli_produk_id;
    END IF;
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_total_beli_produk() OWNER TO postgres;

--
-- TOC entry 305 (class 1255 OID 24928)
-- Name: f_update_total_hutang_supplier(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_total_hutang_supplier() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    var_supplier_id 				t_guid;  
    var_supplier_id_old				t_guid;
    
    var_total_hutang_produk			t_harga;
  	var_total_pelunasan_produk		t_harga;
    
BEGIN	    
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_supplier_id := NEW.supplier_id;        
    ELSE
    	var_supplier_id := OLD.supplier_id;
        var_supplier_id_old := OLD.supplier_id;
    END IF;
	    	           	                
    -- hitung total hutang dan pelunasan pembelian produk
    SELECT SUM(total_nota - diskon + ppn) AS total_hutang, SUM(total_pelunasan) AS total_pelunasan
    INTO var_total_hutang_produk, var_total_pelunasan_produk
    FROM t_beli_produk 
    WHERE tanggal_tempo IS NOT NULL AND supplier_id = var_supplier_id;

    IF var_total_hutang_produk IS NULL THEN
        var_total_hutang_produk := 0;  
    END IF; 
        
    IF var_total_pelunasan_produk IS NULL THEN
        var_total_pelunasan_produk := 0;  
    END IF;
                
    UPDATE m_supplier SET total_hutang = var_total_hutang_produk, total_pembayaran_hutang = var_total_pelunasan_produk 
    WHERE supplier_id = var_supplier_id;       
    
    IF TG_OP = 'UPDATE' THEN
    	var_supplier_id_old := OLD.supplier_id;
        
    	IF var_supplier_id <> var_supplier_id_old THEN
            -- hitung total hutang dan pelunasan pembelian produk
            SELECT SUM(total_nota - diskon + ppn) AS total_hutang, SUM(total_pelunasan) AS total_pelunasan
            INTO var_total_hutang_produk, var_total_pelunasan_produk
            FROM t_beli_produk             
            WHERE tanggal_tempo IS NOT NULL AND supplier_id = var_supplier_id_old;

            IF var_total_hutang_produk IS NULL THEN
                var_total_hutang_produk := 0;  
            END IF; 
                
            IF var_total_pelunasan_produk IS NULL THEN
                var_total_pelunasan_produk := 0;  
            END IF;
                
            UPDATE m_supplier SET total_hutang = var_total_hutang_produk, total_pembayaran_hutang = var_total_pelunasan_produk 
            WHERE supplier_id = var_supplier_id_old;                                    
    		                        
            UPDATE t_pembayaran_hutang_produk SET supplier_id = var_supplier_id
            WHERE pembayaran_hutang_produk_id IN (SELECT pembayaran_hutang_produk_id FROM t_item_pembayaran_hutang_produk WHERE beli_produk_id = NEW.beli_produk_id);                
            
        END IF;
    END IF;            
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_total_hutang_supplier() OWNER TO postgres;

--
-- TOC entry 306 (class 1255 OID 24929)
-- Name: f_update_total_jual_produk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_total_jual_produk() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
	var_jual_id 			t_guid;
    var_retur_jual_id		t_guid;
    var_diskon				t_harga;
    var_ppn					t_harga;
	var_ongkos_kirim		t_harga;
	var_total_nota 			t_harga;        
    var_jumlah_retur_lama 	t_jumlah;
    var_jumlah_retur_baru 	t_jumlah;
    var_tanggal_tempo		DATE;
    is_retur				t_bool;
    
BEGIN
	is_retur := FALSE;
    
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_jual_id := NEW.jual_id;    
    ELSE
    	var_jual_id := OLD.jual_id;        
    END IF;	    	          

    var_total_nota := (SELECT SUM((jumlah - jumlah_retur) * (harga_jual - (diskon / 100 * harga_jual))) 
    				   FROM t_item_jual_produk
					   WHERE jual_id = var_jual_id);	    
	IF var_total_nota IS NULL THEN
    	var_total_nota := 0;  
	END IF;     
    
    var_total_nota := ROUND(var_total_nota, 0);      
    
	SELECT ppn, ongkos_kirim, diskon INTO var_ppn, var_ongkos_kirim, var_diskon
    FROM t_jual_produk WHERE jual_id = var_jual_id;            
    
    IF var_ppn IS NULL THEN
    	var_ppn := 0;  
	END IF;
    
	IF var_ongkos_kirim IS NULL THEN
    	var_ongkos_kirim := 0;  
	END IF;
	
    IF var_diskon IS NULL THEN
    	var_diskon := 0;  
	END IF;
    
    IF TG_OP = 'UPDATE' THEN -- pengecekan retur
    	-- jumlah retur
        var_jumlah_retur_baru = NEW.jumlah_retur;
        var_jumlah_retur_lama = OLD.jumlah_retur;        
        
    	IF var_jumlah_retur_lama <> var_jumlah_retur_baru THEN
			is_retur := TRUE;
			
            var_retur_jual_id := (SELECT retur_jual_id FROM t_retur_jual_produk WHERE jual_id = var_jual_id LIMIT 1);
            var_tanggal_tempo := (SELECT tanggal_tempo FROM t_jual_produk WHERE jual_id = var_jual_id);                                                
            
            IF var_tanggal_tempo IS NULL THEN -- nota tunai            	
                UPDATE t_jual_produk SET total_nota = ROUND(var_total_nota, 0), retur_jual_id = var_retur_jual_id 
                WHERE jual_id = var_jual_id;                
                
                UPDATE t_item_pembayaran_piutang_produk SET nominal = ROUND(var_total_nota, 0) - var_diskon + var_ppn + var_ongkos_kirim
                WHERE jual_id = var_jual_id;
            ELSE
            	UPDATE t_jual_produk SET total_nota = ROUND(var_total_nota, 0), retur_jual_id = var_retur_jual_id 
                WHERE jual_id = var_jual_id;
            END IF;        
        END IF;        
    END IF;              

	IF (is_retur = FALSE) THEN -- bukan retur    	
    	UPDATE t_jual_produk SET total_nota = ROUND(var_total_nota, 0), retur_jual_id = NULL 
        WHERE jual_id = var_jual_id;
    END IF;
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_total_jual_produk() OWNER TO postgres;

--
-- TOC entry 307 (class 1255 OID 24930)
-- Name: f_update_total_kasbon_karyawan(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_total_kasbon_karyawan() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    var_karyawan_id		t_guid;
    
	var_total_kasbon 	t_harga;
  	var_total_pelunasan	t_harga;
    
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_karyawan_id := NEW.karyawan_id;    
    ELSE
    	var_karyawan_id := OLD.karyawan_id;
    END IF;	            
	
    SELECT SUM(nominal), SUM(total_pelunasan)
    INTO var_total_kasbon, var_total_pelunasan
	FROM t_kasbon WHERE karyawan_id = var_karyawan_id;
        
    IF var_total_kasbon IS NULL THEN
    	var_total_kasbon := 0;  
	END IF;
    
    IF var_total_pelunasan IS NULL THEN
    	var_total_pelunasan := 0;  
	END IF;
        
    UPDATE m_karyawan SET total_kasbon = var_total_kasbon, total_pembayaran_kasbon = var_total_pelunasan 
    WHERE karyawan_id = var_karyawan_id;
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_total_kasbon_karyawan() OWNER TO postgres;

--
-- TOC entry 308 (class 1255 OID 24931)
-- Name: f_update_total_pengeluaran(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_total_pengeluaran() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE v_pengeluaran_id t_guid;
DECLARE v_total t_harga;
  
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	v_pengeluaran_id := NEW.pengeluaran_id;    
    ELSE
    	v_pengeluaran_id := OLD.pengeluaran_id;
    END IF;
        
    v_total := (SELECT SUM(jumlah * harga) FROM t_item_pengeluaran_biaya
			    WHERE pengeluaran_id = v_pengeluaran_id);
	
    IF v_total IS NULL THEN
    	v_total := 0;  
	END IF;
    
    UPDATE t_pengeluaran_biaya SET total = v_total WHERE pengeluaran_id = v_pengeluaran_id;                        
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_total_pengeluaran() OWNER TO postgres;

--
-- TOC entry 309 (class 1255 OID 24932)
-- Name: f_update_total_piutang_customer(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_total_piutang_customer() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    var_total_piutang	t_harga;
    var_total_pelunasan	t_harga;
  	var_customer_id		t_guid;
    var_customer_id_old	t_guid;
    
BEGIN
	IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_customer_id := NEW.customer_id;        
    ELSE
    	var_customer_id := OLD.customer_id;
        var_customer_id_old = OLD.customer_id;
    END IF;
	    	            
	SELECT SUM(total_nota - diskon + ongkos_kirim + ppn), SUM(total_pelunasan)
    INTO var_total_piutang, var_total_pelunasan
	FROM t_jual_produk     
    WHERE tanggal_tempo IS NOT NULL AND customer_id = var_customer_id;
    
    IF var_total_piutang IS NULL THEN
        var_total_piutang := 0;  
    END IF;
    
    IF var_total_pelunasan IS NULL THEN
        var_total_pelunasan := 0;  
    END IF;
        
    UPDATE m_customer SET total_piutang = var_total_piutang, total_pembayaran_piutang = var_total_pelunasan
	WHERE customer_id = var_customer_id;        
    
    IF TG_OP = 'UPDATE' THEN
		var_customer_id_old = OLD.customer_id;
		
        IF var_customer_id <> var_customer_id_old THEN
        	SELECT SUM(total_nota - diskon + ongkos_kirim + ppn), SUM(total_pelunasan)
            INTO var_total_piutang, var_total_pelunasan
            FROM t_jual_produk             
            WHERE tanggal_tempo IS NOT NULL AND customer_id = var_customer_id_old;
            
            IF var_total_piutang IS NULL THEN
                var_total_piutang := 0;  
            END IF;
            
            IF var_total_pelunasan IS NULL THEN
                var_total_pelunasan := 0;  
            END IF;                           
			
			UPDATE m_customer SET total_piutang = var_total_piutang, total_pembayaran_piutang = var_total_pelunasan
            WHERE customer_id = var_customer_id_old;
            
            UPDATE t_pembayaran_piutang_produk SET customer_id = var_customer_id 
            WHERE pembayaran_piutang_id IN (SELECT pembayaran_piutang_id FROM t_item_pembayaran_piutang_produk WHERE jual_id = NEW.jual_id);
        END IF;
    END IF;
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_total_piutang_customer() OWNER TO postgres;

--
-- TOC entry 310 (class 1255 OID 24933)
-- Name: f_update_total_retur_beli_aiud(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_total_retur_beli_aiud() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	var_retur_beli_produk_id	t_guid;
	var_total_nota 		t_harga;
    
BEGIN    
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_retur_beli_produk_id := NEW.retur_beli_produk_id;    
    ELSE
    	var_retur_beli_produk_id := OLD.retur_beli_produk_id;
    END IF;
        
    var_total_nota := (SELECT SUM(jumlah_retur * harga) 
    				   FROM t_item_retur_beli_produk
					   WHERE retur_beli_produk_id = var_retur_beli_produk_id);
                           
    IF var_total_nota IS NULL THEN
    	var_total_nota := 0;  
	END IF;                         
    
    UPDATE t_retur_beli_produk SET total_nota = var_total_nota 
    WHERE retur_beli_produk_id = var_retur_beli_produk_id;
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_total_retur_beli_aiud() OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 24934)
-- Name: f_update_total_retur_produk_aiud(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_total_retur_produk_aiud() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	var_retur_jual_id	t_guid;
	var_total_nota 		t_harga;
    
BEGIN    
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    	var_retur_jual_id := NEW.retur_jual_id;    
    ELSE
    	var_retur_jual_id := OLD.retur_jual_id;
    END IF;
        
    var_total_nota := (SELECT SUM(jumlah_retur * harga_jual) 
    				   FROM t_item_retur_jual_produk
					   WHERE retur_jual_id = var_retur_jual_id);
                           
    IF var_total_nota IS NULL THEN
    	var_total_nota := 0;  
	END IF;                         
    
    UPDATE t_retur_jual_produk SET total_nota = var_total_nota 
    WHERE retur_jual_id = var_retur_jual_id;
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.f_update_total_retur_produk_aiud() OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 24935)
-- Name: fn_log_last_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_log_last_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    var_produk_id		t_guid;
    var_harga_jual		t_harga;
    var_harga_jual_old	t_harga;
    
BEGIN
	IF TG_OP = 'UPDATE' THEN
    	var_produk_id := NEW.produk_id;
        var_harga_jual := NEW.harga_jual;        
        var_harga_jual_old := OLD.harga_jual;    	
    END IF;
    
    IF var_harga_jual IS NULL THEN
    	var_harga_jual := 0;
    END IF;
    	   
    IF var_harga_jual_old IS NULL THEN
    	var_harga_jual_old := 0;
    END IF;
    
    IF var_harga_jual_old <> var_harga_jual THEN
    	UPDATE m_produk SET last_update = now() WHERE produk_id = var_produk_id;
    END IF;
    
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.fn_log_last_update() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 24936)
-- Name: m_alasan_penyesuaian_stok; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_alasan_penyesuaian_stok (
    alasan_penyesuaian_stok_id public.t_guid NOT NULL,
    alasan public.t_keterangan
);


ALTER TABLE public.m_alasan_penyesuaian_stok OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 57926)
-- Name: m_cabang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_cabang (
    cabang_id character varying(10) NOT NULL,
    nama_cabang character varying(100) NOT NULL
);


ALTER TABLE public.m_cabang OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24941)
-- Name: m_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_customer (
    customer_id public.t_guid NOT NULL,
    nama_customer public.t_nama,
    alamat public.t_alamat_panjang,
    kontak public.t_nama,
    telepon public.t_telepon,
    plafon_piutang public.t_harga,
    total_piutang public.t_harga,
    total_pembayaran_piutang public.t_harga,
    kecamatan public.t_alamat,
    kelurahan public.t_alamat,
    kota public.t_alamat,
    kode_pos public.t_kode_pos,
    diskon public.t_jumlah,
    desa public.t_alamat,
    kabupaten public.t_alamat,
    provinsi_id character(2),
    kabupaten_id character(4),
    kecamatan_id character(7),
    kode_customer character varying(20) NOT NULL,
    pin character varying(255),
    last_login timestamp without time zone,
    email character varying(255)
);


ALTER TABLE public.m_customer OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24946)
-- Name: m_database_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_database_version (
    version_number integer NOT NULL
);


ALTER TABLE public.m_database_version OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24949)
-- Name: m_dropshipper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_dropshipper (
    dropshipper_id public.t_guid NOT NULL,
    nama_dropshipper public.t_nama,
    alamat public.t_alamat,
    kontak public.t_nama,
    telepon public.t_telepon
);


ALTER TABLE public.m_dropshipper OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24954)
-- Name: m_footer_nota_mini_pos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_footer_nota_mini_pos (
    footer_nota_id public.t_guid NOT NULL,
    keterangan public.t_keterangan,
    order_number integer,
    is_active public.t_bool
);


ALTER TABLE public.m_footer_nota_mini_pos OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24959)
-- Name: m_golongan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_golongan (
    golongan_id public.t_guid NOT NULL,
    nama_golongan public.t_nama,
    diskon public.t_jumlah,
    persentase_keuntungan public.t_jumlah
);


ALTER TABLE public.m_golongan OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24964)
-- Name: m_harga_grosir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_harga_grosir (
    harga_grosir_id public.t_guid NOT NULL,
    produk_id public.t_guid,
    harga_ke integer,
    harga_grosir public.t_harga,
    jumlah_minimal public.t_jumlah,
    diskon public.t_jumlah
);


ALTER TABLE public.m_harga_grosir OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24969)
-- Name: m_header_nota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_header_nota (
    header_nota_id public.t_guid NOT NULL,
    keterangan public.t_keterangan,
    order_number integer,
    is_active public.t_bool
);


ALTER TABLE public.m_header_nota OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24974)
-- Name: m_header_nota_mini_pos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_header_nota_mini_pos (
    header_nota_id public.t_guid NOT NULL,
    keterangan public.t_keterangan,
    order_number integer,
    is_active public.t_bool
);


ALTER TABLE public.m_header_nota_mini_pos OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24979)
-- Name: m_item_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_item_menu (
    item_menu_id public.t_guid NOT NULL,
    menu_id public.t_guid,
    grant_id integer,
    keterangan public.t_keterangan
);


ALTER TABLE public.m_item_menu OWNER TO postgres;

--
-- TOC entry 5456 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN m_item_menu.grant_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.m_item_menu.grant_id IS 'Mereference ke tabel m_role_privilege';


--
-- TOC entry 227 (class 1259 OID 24984)
-- Name: m_jabatan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_jabatan (
    jabatan_id public.t_guid NOT NULL,
    nama_jabatan public.t_nama,
    keterangan public.t_keterangan
);


ALTER TABLE public.m_jabatan OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24989)
-- Name: m_jenis_pengeluaran; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_jenis_pengeluaran (
    jenis_pengeluaran_id public.t_guid NOT NULL,
    nama_jenis_pengeluaran public.t_keterangan
);


ALTER TABLE public.m_jenis_pengeluaran OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24994)
-- Name: m_kabupaten; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_kabupaten (
    kabupaten_id integer NOT NULL,
    provinsi_id integer,
    tipe character varying(15),
    nama_kabupaten public.t_keterangan,
    kode_pos public.t_kode_pos
);


ALTER TABLE public.m_kabupaten OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24999)
-- Name: m_kabupaten2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_kabupaten2 (
    kabupaten_id character(4) NOT NULL,
    provinsi_id character(2),
    nama_kabupaten public.t_alamat_panjang
);


ALTER TABLE public.m_kabupaten2 OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25004)
-- Name: m_kartu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_kartu (
    kartu_id public.t_guid NOT NULL,
    nama_kartu public.t_nama,
    is_debit public.t_bool
);


ALTER TABLE public.m_kartu OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25009)
-- Name: m_karyawan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_karyawan (
    karyawan_id public.t_guid NOT NULL,
    jabatan_id public.t_guid,
    nama_karyawan public.t_nama,
    alamat public.t_alamat,
    telepon public.t_telepon,
    gaji_pokok public.t_harga,
    is_active public.t_bool,
    keterangan public.t_keterangan,
    jenis_gajian integer DEFAULT 1,
    gaji_lembur public.t_harga DEFAULT 0,
    total_kasbon public.t_harga,
    total_pembayaran_kasbon public.t_harga
);


ALTER TABLE public.m_karyawan OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25016)
-- Name: m_kecamatan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_kecamatan (
    kecamatan_id character(7) NOT NULL,
    kabupaten_id character(4),
    nama_kecamatan public.t_alamat_panjang
);


ALTER TABLE public.m_kecamatan OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 25021)
-- Name: m_label_nota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_label_nota (
    label_nota_id public.t_guid NOT NULL,
    keterangan public.t_keterangan,
    order_number integer,
    is_active public.t_bool
);


ALTER TABLE public.m_label_nota OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 25026)
-- Name: m_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_menu (
    menu_id public.t_guid NOT NULL,
    nama_menu public.t_nama,
    judul_menu public.t_keterangan,
    parent_id public.t_guid,
    order_number integer,
    is_active public.t_bool,
    nama_form public.t_keterangan,
    is_enabled public.t_bool
);


ALTER TABLE public.m_menu OWNER TO postgres;

--
-- TOC entry 5457 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN m_menu.parent_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.m_menu.parent_id IS 'Diisi dengan menu_id';


--
-- TOC entry 236 (class 1259 OID 25031)
-- Name: m_pengguna; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_pengguna (
    pengguna_id public.t_guid NOT NULL,
    role_id public.t_guid,
    nama_pengguna public.t_nama,
    pass_pengguna public.t_password,
    is_active public.t_bool,
    status_user integer DEFAULT 2,
    email public.t_keterangan,
    cabang_id character varying(10)
);


ALTER TABLE public.m_pengguna OWNER TO postgres;

--
-- TOC entry 5458 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN m_pengguna.status_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.m_pengguna.status_user IS '1 = Kasir
2 = Server
3 = Kasir dan Server';


--
-- TOC entry 237 (class 1259 OID 25037)
-- Name: m_prefix_nota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_prefix_nota (
    prefix_nota_id integer DEFAULT 1 NOT NULL,
    prefix_nota character varying(3),
    keterangan public.t_keterangan
);


ALTER TABLE public.m_prefix_nota OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 25043)
-- Name: m_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_produk (
    produk_id public.t_guid NOT NULL,
    nama_produk public.t_nama_panjang,
    satuan public.t_satuan,
    stok public.t_jumlah,
    harga_beli public.t_harga,
    harga_jual public.t_harga,
    kode_produk public.t_kode_produk,
    golongan_id public.t_guid,
    minimal_stok public.t_jumlah DEFAULT 0,
    stok_gudang public.t_jumlah,
    minimal_stok_gudang public.t_jumlah,
    diskon public.t_jumlah,
    persentase_keuntungan public.t_jumlah,
    is_aktif public.t_bool,
    last_update timestamp(0) without time zone DEFAULT now()
);


ALTER TABLE public.m_produk OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 25050)
-- Name: m_produk_produk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.m_produk_produk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.m_produk_produk_id_seq OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 25051)
-- Name: m_profil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_profil (
    profil_id public.t_guid NOT NULL,
    nama_profil public.t_keterangan,
    alamat public.t_alamat,
    kota public.t_alamat,
    telepon public.t_telepon,
    email public.t_keterangan,
    website public.t_keterangan,
    register_id public.t_guid,
    is_register boolean DEFAULT false,
    hash public.t_keterangan
);


ALTER TABLE public.m_profil OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 25057)
-- Name: m_provinsi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_provinsi (
    provinsi_id integer NOT NULL,
    nama_provinsi public.t_keterangan
);


ALTER TABLE public.m_provinsi OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 25062)
-- Name: m_provinsi2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_provinsi2 (
    provinsi_id character(2) NOT NULL,
    nama_provinsi public.t_alamat_panjang
);


ALTER TABLE public.m_provinsi2 OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 25067)
-- Name: m_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_role (
    role_id public.t_guid NOT NULL,
    nama_role public.t_nama,
    is_active public.t_bool
);


ALTER TABLE public.m_role OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 25072)
-- Name: m_role_privilege; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_role_privilege (
    role_id public.t_guid NOT NULL,
    menu_id public.t_guid NOT NULL,
    grant_id integer NOT NULL,
    is_grant public.t_bool
);


ALTER TABLE public.m_role_privilege OWNER TO postgres;

--
-- TOC entry 5459 (class 0 OID 0)
-- Dependencies: 244
-- Name: COLUMN m_role_privilege.grant_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.m_role_privilege.grant_id IS 'Tambah, Perbaiki, Hapus, Dll';


--
-- TOC entry 279 (class 1259 OID 49219)
-- Name: m_role_privilege_backup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_role_privilege_backup (
    role_id public.t_guid,
    menu_id public.t_guid,
    grant_id integer,
    is_grant public.t_bool
);


ALTER TABLE public.m_role_privilege_backup OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 25077)
-- Name: m_setting_aplikasi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_setting_aplikasi (
    setting_aplikasi_id public.t_guid NOT NULL,
    is_update_harga_jual_master_produk public.t_bool,
    is_stok_produk_boleh_minus public.t_bool,
    is_fokus_input_kolom_jumlah public.t_bool,
    is_tampilkan_keterangan_tambahan_item_jual public.t_bool,
    keterangan_tambahan_item_jual public.t_keterangan
);


ALTER TABLE public.m_setting_aplikasi OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 25082)
-- Name: m_shift; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_shift (
    shift_id public.t_guid NOT NULL,
    nama_shift public.t_keterangan,
    jam_mulai timestamp without time zone,
    jam_selesai timestamp without time zone,
    is_active public.t_bool
);


ALTER TABLE public.m_shift OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 25087)
-- Name: m_supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.m_supplier (
    supplier_id public.t_guid NOT NULL,
    nama_supplier public.t_nama,
    alamat public.t_alamat,
    kontak public.t_nama,
    telepon public.t_telepon,
    total_hutang public.t_harga,
    total_pembayaran_hutang public.t_harga
);


ALTER TABLE public.m_supplier OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 25092)
-- Name: t_beli_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_beli_produk (
    beli_produk_id public.t_guid NOT NULL,
    pengguna_id public.t_guid,
    supplier_id public.t_guid,
    retur_beli_produk_id public.t_guid,
    nota public.t_nota,
    tanggal date,
    tanggal_tempo date,
    ppn public.t_harga,
    diskon public.t_harga,
    total_nota public.t_harga,
    total_pelunasan public.t_harga,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now()
);


ALTER TABLE public.t_beli_produk OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 25098)
-- Name: t_beli_produk_beli_produk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_beli_produk_beli_produk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_beli_produk_beli_produk_id_seq OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 25099)
-- Name: t_gaji_karyawan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_gaji_karyawan (
    gaji_karyawan_id public.t_guid NOT NULL,
    karyawan_id public.t_guid,
    pengguna_id public.t_guid,
    bulan integer,
    tahun integer,
    kehadiran integer,
    absen integer,
    gaji_pokok public.t_harga,
    lembur public.t_harga,
    bonus public.t_harga,
    potongan public.t_harga,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    jam integer DEFAULT 0,
    lainnya public.t_harga DEFAULT 0,
    keterangan public.t_keterangan,
    jumlah_hari integer DEFAULT 0,
    tunjangan public.t_harga DEFAULT 0,
    kasbon public.t_harga DEFAULT 0,
    tanggal date,
    nota public.t_nota
);


ALTER TABLE public.t_gaji_karyawan OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 25110)
-- Name: t_gaji_karyawan_gaji_karyawan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_gaji_karyawan_gaji_karyawan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_gaji_karyawan_gaji_karyawan_id_seq OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 25111)
-- Name: t_item_beli_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_item_beli_produk (
    item_beli_produk_id public.t_guid NOT NULL,
    beli_produk_id public.t_guid,
    pengguna_id public.t_guid,
    produk_id public.t_guid,
    harga public.t_harga,
    jumlah public.t_jumlah,
    diskon public.t_jumlah,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    jumlah_retur public.t_jumlah
);


ALTER TABLE public.t_item_beli_produk OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 25117)
-- Name: t_item_jual_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_item_jual_produk (
    item_jual_id public.t_guid NOT NULL,
    jual_id public.t_guid,
    pengguna_id public.t_guid,
    produk_id public.t_guid,
    harga_beli public.t_harga,
    harga_jual public.t_harga,
    jumlah public.t_jumlah,
    diskon public.t_jumlah,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    jumlah_retur public.t_jumlah,
    keterangan public.t_keterangan
);


ALTER TABLE public.t_item_jual_produk OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 25123)
-- Name: t_item_pembayaran_hutang_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_item_pembayaran_hutang_produk (
    item_pembayaran_hutang_produk_id public.t_guid NOT NULL,
    pembayaran_hutang_produk_id public.t_guid,
    beli_produk_id public.t_guid,
    nominal public.t_harga,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now()
);


ALTER TABLE public.t_item_pembayaran_hutang_produk OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 25129)
-- Name: t_item_pembayaran_piutang_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_item_pembayaran_piutang_produk (
    item_pembayaran_piutang_id public.t_guid NOT NULL,
    pembayaran_piutang_id public.t_guid,
    jual_id public.t_guid,
    nominal public.t_harga,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now()
);


ALTER TABLE public.t_item_pembayaran_piutang_produk OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 25135)
-- Name: t_item_pengeluaran_biaya; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_item_pengeluaran_biaya (
    item_pengeluaran_id public.t_guid NOT NULL,
    pengeluaran_id public.t_guid,
    pengguna_id public.t_guid,
    jumlah public.t_jumlah,
    harga public.t_harga,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    jenis_pengeluaran_id public.t_guid
);


ALTER TABLE public.t_item_pengeluaran_biaya OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 25141)
-- Name: t_item_retur_beli_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_item_retur_beli_produk (
    item_retur_beli_produk_id public.t_guid NOT NULL,
    retur_beli_produk_id public.t_guid,
    pengguna_id public.t_guid,
    produk_id public.t_guid,
    harga public.t_harga,
    jumlah public.t_jumlah,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    jumlah_retur public.t_jumlah,
    item_beli_id public.t_guid
);


ALTER TABLE public.t_item_retur_beli_produk OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 25147)
-- Name: t_item_retur_jual_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_item_retur_jual_produk (
    item_retur_jual_id public.t_guid NOT NULL,
    retur_jual_id public.t_guid,
    pengguna_id public.t_guid,
    produk_id public.t_guid,
    harga_jual public.t_harga,
    jumlah public.t_jumlah,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    jumlah_retur public.t_jumlah,
    item_jual_id public.t_guid
);


ALTER TABLE public.t_item_retur_jual_produk OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 25153)
-- Name: t_jual_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_jual_produk (
    jual_id public.t_guid NOT NULL,
    pengguna_id public.t_guid,
    customer_id public.t_guid,
    nota public.t_nota,
    tanggal date,
    tanggal_tempo date,
    ppn public.t_harga,
    diskon public.t_harga,
    total_nota public.t_harga,
    total_pelunasan public.t_harga,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    retur_jual_id public.t_guid,
    shift_id public.t_guid,
    is_sdac public.t_bool,
    kirim_kecamatan public.t_alamat_panjang,
    kirim_kelurahan public.t_alamat_panjang,
    kirim_kota public.t_alamat_panjang,
    kirim_kode_pos public.t_kode_pos,
    kirim_kepada public.t_nama,
    kirim_alamat public.t_alamat_panjang,
    kirim_telepon public.t_telepon,
    ongkos_kirim public.t_harga,
    label_dari1 public.t_keterangan,
    label_dari2 public.t_keterangan,
    label_dari3 public.t_keterangan,
    label_dari4 public.t_keterangan,
    label_kepada1 public.t_alamat_panjang,
    label_kepada2 public.t_alamat_panjang,
    label_kepada3 public.t_alamat_panjang,
    label_kepada4 public.t_alamat_panjang,
    kurir public.t_keterangan,
    is_dropship boolean,
    kirim_desa public.t_alamat_panjang,
    kirim_kabupaten public.t_alamat_panjang,
    mesin_id public.t_guid,
    bayar_tunai public.t_harga,
    bayar_kartu public.t_harga,
    kartu_id public.t_guid,
    nomor_kartu public.t_nota,
    dropshipper_id public.t_guid
);


ALTER TABLE public.t_jual_produk OWNER TO postgres;

--
-- TOC entry 5460 (class 0 OID 0)
-- Dependencies: 259
-- Name: COLUMN t_jual_produk.is_sdac; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.t_jual_produk.is_sdac IS 'Sama dengan alamat customer';


--
-- TOC entry 260 (class 1259 OID 25159)
-- Name: t_jual_produk_jual_produk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_jual_produk_jual_produk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_jual_produk_jual_produk_id_seq OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 25160)
-- Name: t_kasbon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_kasbon (
    kasbon_id public.t_guid NOT NULL,
    karyawan_id public.t_guid,
    pengguna_id public.t_guid,
    nota public.t_nota,
    tanggal date,
    nominal public.t_harga,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    total_pelunasan public.t_harga DEFAULT 0
);


ALTER TABLE public.t_kasbon OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 25167)
-- Name: t_kasbon_kasbon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_kasbon_kasbon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_kasbon_kasbon_id_seq OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 25168)
-- Name: t_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_logs (
    log_id bigint DEFAULT nextval(('public.t_logs_log_id_seq'::text)::regclass) NOT NULL,
    level character varying(10),
    class_name character varying(200),
    method_name character varying(100),
    message character varying(100),
    new_value character varying(10000),
    old_value character varying(10000),
    exception character varying(10000),
    created_by character varying(50),
    log_date timestamp(0) without time zone DEFAULT now()
);


ALTER TABLE public.t_logs OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 25175)
-- Name: t_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_logs_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_logs_log_id_seq OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 25176)
-- Name: t_mesin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_mesin (
    mesin_id public.t_guid NOT NULL,
    pengguna_id public.t_guid,
    tanggal date DEFAULT ('now'::text)::date,
    saldo_awal public.t_harga,
    uang_masuk public.t_harga,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    shift_id public.t_guid,
    uang_keluar public.t_harga
);


ALTER TABLE public.t_mesin OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 25183)
-- Name: t_pembayaran_hutang_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_pembayaran_hutang_produk (
    pembayaran_hutang_produk_id public.t_guid NOT NULL,
    supplier_id public.t_guid,
    pengguna_id public.t_guid,
    tanggal date,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    nota public.t_nota,
    is_tunai public.t_bool
);


ALTER TABLE public.t_pembayaran_hutang_produk OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 25189)
-- Name: t_pembayaran_hutang_produk_pembayaran_hutang_produk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_pembayaran_hutang_produk_pembayaran_hutang_produk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_pembayaran_hutang_produk_pembayaran_hutang_produk_id_seq OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 25190)
-- Name: t_pembayaran_kasbon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_pembayaran_kasbon (
    pembayaran_kasbon_id public.t_guid NOT NULL,
    kasbon_id public.t_guid,
    gaji_karyawan_id public.t_guid,
    tanggal date,
    nominal public.t_harga,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    nota public.t_nota,
    pengguna_id public.t_guid
);


ALTER TABLE public.t_pembayaran_kasbon OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 25196)
-- Name: t_pembayaran_kasbon_pembayaran_kasbon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_pembayaran_kasbon_pembayaran_kasbon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_pembayaran_kasbon_pembayaran_kasbon_id_seq OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 25197)
-- Name: t_pembayaran_piutang_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_pembayaran_piutang_produk (
    pembayaran_piutang_id public.t_guid NOT NULL,
    customer_id public.t_guid,
    pengguna_id public.t_guid,
    tanggal date,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    nota public.t_nota,
    is_tunai public.t_bool
);


ALTER TABLE public.t_pembayaran_piutang_produk OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 25203)
-- Name: t_pembayaran_piutang_produk_pembayaran_piutang_produk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_pembayaran_piutang_produk_pembayaran_piutang_produk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_pembayaran_piutang_produk_pembayaran_piutang_produk_id_seq OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 25204)
-- Name: t_pengeluaran_biaya; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_pengeluaran_biaya (
    pengeluaran_id public.t_guid NOT NULL,
    pengguna_id public.t_guid,
    nota public.t_nota,
    tanggal date,
    total public.t_harga,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now()
);


ALTER TABLE public.t_pengeluaran_biaya OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 25210)
-- Name: t_pengeluaran_biaya_pengeluaran_biaya_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_pengeluaran_biaya_pengeluaran_biaya_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_pengeluaran_biaya_pengeluaran_biaya_id_seq OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 25211)
-- Name: t_penyesuaian_stok; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_penyesuaian_stok (
    penyesuaian_stok_id public.t_guid NOT NULL,
    produk_id public.t_guid,
    alasan_penyesuaian_id public.t_guid,
    tanggal date,
    penambahan_stok public.t_jumlah,
    pengurangan_stok public.t_jumlah,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    penambahan_stok_gudang public.t_jumlah,
    pengurangan_stok_gudang public.t_jumlah
);
ALTER TABLE ONLY public.t_penyesuaian_stok ALTER COLUMN alasan_penyesuaian_id SET STATISTICS 0;


ALTER TABLE public.t_penyesuaian_stok OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 25217)
-- Name: t_retur_beli_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_retur_beli_produk (
    retur_beli_produk_id public.t_guid NOT NULL,
    beli_produk_id public.t_guid,
    pengguna_id public.t_guid,
    supplier_id public.t_guid,
    nota public.t_nota,
    tanggal date,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    total_nota public.t_harga
);


ALTER TABLE public.t_retur_beli_produk OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 25223)
-- Name: t_retur_beli_produk_retur_beli_produk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_retur_beli_produk_retur_beli_produk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_retur_beli_produk_retur_beli_produk_id_seq OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 25224)
-- Name: t_retur_jual_produk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_retur_jual_produk (
    retur_jual_id public.t_guid NOT NULL,
    jual_id public.t_guid,
    pengguna_id public.t_guid,
    customer_id public.t_guid,
    nota public.t_nota,
    tanggal date,
    keterangan public.t_keterangan,
    tanggal_sistem timestamp without time zone DEFAULT now(),
    total_nota public.t_harga
);


ALTER TABLE public.t_retur_jual_produk OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 25230)
-- Name: t_retur_jual_produk_retur_jual_produk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.t_retur_jual_produk_retur_jual_produk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_retur_jual_produk_retur_jual_produk_id_seq OWNER TO postgres;

--
-- TOC entry 5386 (class 0 OID 24936)
-- Dependencies: 217
-- Data for Name: m_alasan_penyesuaian_stok; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_alasan_penyesuaian_stok (alasan_penyesuaian_stok_id, alasan) FROM stdin;
83bbf9aa-0d45-7041-e53b-d6c9073a49c0	Hilang Barang hilang
e4ef2a27-6600-365f-1e07-2963d55cc4bf	Koreksi Koreksi karena kesalahan input
1c23364b-e65d-62ef-4180-b2f3f7f560c1	Rusak Barang rusak
b1ad1bca-b590-2231-06a3-8c3cc5445eaf	Saldo Awal Stok awal barang
f227318c-72dc-5284-6b00-58005d511043	Stock Opname Selisih stock buku dengan stok opname
f9b35798-6725-244f-fec0-fdee38c5ad44	Pindah stok gudang ke etalase
7aa5ecff-4ed3-2e57-ead3-a493d822ab96	Lainnya
7092373e-91df-4c3a-b98a-1fc8d09d91e8	Dipake sendiri
\.


--
-- TOC entry 5449 (class 0 OID 57926)
-- Dependencies: 280
-- Data for Name: m_cabang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_cabang (cabang_id, nama_cabang) FROM stdin;
UTM	RSPB UTAMA
PNR	PANORAMA
\.


--
-- TOC entry 5387 (class 0 OID 24941)
-- Dependencies: 218
-- Data for Name: m_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_customer (customer_id, nama_customer, alamat, kontak, telepon, plafon_piutang, total_piutang, total_pembayaran_piutang, kecamatan, kelurahan, kota, kode_pos, diskon, desa, kabupaten, provinsi_id, kabupaten_id, kecamatan_id, kode_customer, pin, last_login, email) FROM stdin;
0c47012a-38b2-44c0-99fb-0602636f9f46	afiqah				1500000.00	0.00	0.00	\N	\N	\N		0.00	\N	\N	\N	\N	\N	KOP000001	\N	\N	\N
1573a49e-9ef0-43e5-9c17-3a3b55ca57a1	saputra				1500000.00	0.00	0.00	\N	\N	\N		0.00	\N	\N	\N	\N	\N	KOP000003	\N	\N	\N
da7f0132-d3cb-4260-b0c6-130060da29e9	ALEEYA				1500000.00	0.00	0.00	\N	\N	\N		0.00	\N	\N	\N	\N	\N	KOP000004	\N	\N	\N
3306895e-e08e-4e71-a58c-a7ce6d7a5484	lutfi				1500000.00	0.00	0.00	\N				0.00		\N	11	1103	1103020	KOP000005	\N	\N	\N
3c7f3bc1-9edf-4eac-9275-56499a853d22	surya				1500000.00	0.00	0.00	\N	\N	\N		0.00	\N	\N	\N	\N	\N	kop00006	\N	\N	\N
40d0dad9-bb58-447e-8187-147d61b78362	muhammad deden	balikpapan		08115965955	1500000.00	150000.00	100000.00	\N				0.00		\N	11	1103	1103021	KOP000002	009988	2026-09-25 05:22:14	\N
\.


--
-- TOC entry 5388 (class 0 OID 24946)
-- Dependencies: 219
-- Data for Name: m_database_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_database_version (version_number) FROM stdin;
12
\.


--
-- TOC entry 5389 (class 0 OID 24949)
-- Dependencies: 220
-- Data for Name: m_dropshipper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_dropshipper (dropshipper_id, nama_dropshipper, alamat, kontak, telepon) FROM stdin;
\.


--
-- TOC entry 5390 (class 0 OID 24954)
-- Dependencies: 221
-- Data for Name: m_footer_nota_mini_pos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_footer_nota_mini_pos (footer_nota_id, keterangan, order_number, is_active) FROM stdin;
4c50cfc6-9cfb-0dcd-c648-76db95e6f1a4	TERIMA KASIH. SELAMAT BELANJA KEMBALI	1	t
63602003-1368-81e4-dd6c-0bc7b25417d7	=== LAYANAN KONSUMEN ===	2	t
82ae35a7-bc2b-f4c1-ea53-43c8386ddc56	SMS: 081381769915 CALL: 1102580	3	t
\.


--
-- TOC entry 5391 (class 0 OID 24959)
-- Dependencies: 222
-- Data for Name: m_golongan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_golongan (golongan_id, nama_golongan, diskon, persentase_keuntungan) FROM stdin;
6c9f2842-7cf5-4715-9830-5e97d6a1801a	makanan	0.00	0.00
\.


--
-- TOC entry 5392 (class 0 OID 24964)
-- Dependencies: 223
-- Data for Name: m_harga_grosir; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_harga_grosir (harga_grosir_id, produk_id, harga_ke, harga_grosir, jumlah_minimal, diskon) FROM stdin;
\.


--
-- TOC entry 5393 (class 0 OID 24969)
-- Dependencies: 224
-- Data for Name: m_header_nota; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_header_nota (header_nota_id, keterangan, order_number, is_active) FROM stdin;
fdc91c63-7497-ae8c-36ba-2e6762a16408	KR Software - https://github.com/rudi-krsoftware/open-retail/	1	t
3e4dca2d-7041-daa9-5d32-dfc4f68cd306	Jl. Raya Berbah	2	t
567abd02-cd14-1c97-262b-805038b7d6a8	Berbah, Yogyakarta	3	t
3ed349af-4671-a8ce-6ff4-6467556343e4	HP: 0813 8176 9915, Email: rudi.krsoftware@gmail.com	4	t
b01bf51a-d03c-1e70-256c-4e5384eaa782	Rek: MANDIRI 137-00-0553-7820 MUAMALAT 537-000-1068 a.n Kamaruddin	5	t
\.


--
-- TOC entry 5394 (class 0 OID 24974)
-- Dependencies: 225
-- Data for Name: m_header_nota_mini_pos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_header_nota_mini_pos (header_nota_id, keterangan, order_number, is_active) FROM stdin;
2d51b16b-73c7-6d91-bdd9-099f76b342ad	KR Software	1	t
d131a867-9ce6-ab39-7fa0-5da0f1f4acc2	Jl. Raya Berbah	2	t
089d446a-fd39-cf69-7ce7-d734bf845a16	NPWP: 1234567890	3	t
8979e6c1-c3a4-b21a-5acb-38696d29e975	Berbah, Yogyakarta	4	t
57fd0c2a-450a-32c1-f4f1-1fec61a438cb	0813 8176 9915	5	t
\.


--
-- TOC entry 5395 (class 0 OID 24979)
-- Dependencies: 226
-- Data for Name: m_item_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_item_menu (item_menu_id, menu_id, grant_id, keterangan) FROM stdin;
c4ffec93-ad1e-839a-ff41-4565e2e444bf	0a516b56-ed73-dafe-aaa0-332fadd2f088	2	Edit Data
1dabcdae-eb41-8c9b-1ab6-fc64b0f4e965	f18fbb6e-bd6f-5d21-fa8d-11923327b436	0	Melihat Data
3d92f6bc-c702-6737-6e9e-0c8e72e9ff9f	f18fbb6e-bd6f-5d21-fa8d-11923327b436	1	Tambah Data
356a458f-f27f-b912-bfb9-1a9627b14651	f18fbb6e-bd6f-5d21-fa8d-11923327b436	2	Edit Data
a994ad2b-724e-c741-0643-da10b6fe3c6b	f18fbb6e-bd6f-5d21-fa8d-11923327b436	3	Hapus Data
d0818cc8-582b-4d31-81bf-9cf1ca20fef9	a0c6daf8-b0c8-4e9d-9702-7a2bb781580c	0	Melihat Data
144d104d-d114-4bfe-b4ee-1149f0121a8f	a0c6daf8-b0c8-4e9d-9702-7a2bb781580c	1	Tambah Data
870d8e3e-c83d-4ed1-9dd6-89639cec6499	a0c6daf8-b0c8-4e9d-9702-7a2bb781580c	2	Edit Data
64c1ec17-eebb-4e31-96d1-006dad1a0721	a0c6daf8-b0c8-4e9d-9702-7a2bb781580c	3	Hapus Data
62dbc844-2271-4a5e-9ba0-f5d32308847a	b94a2365-c063-491e-a798-c68dccd2d80b	0	Melihat Data
57880071-1966-4052-976b-5ab1275787f1	b94a2365-c063-491e-a798-c68dccd2d80b	1	Tambah Data
6c4a6251-153c-49ab-b49c-64aeb47c1f70	b94a2365-c063-491e-a798-c68dccd2d80b	2	Edit Data
bf730e62-a35e-437a-803d-672af221b6bd	b94a2365-c063-491e-a798-c68dccd2d80b	3	Hapus Data
b4292bb5-48ad-4119-9138-5ffbd1443d41	a1b976fc-99d3-4b5f-89b5-bc7e7fc4c0d2	0	Melihat Data
a44b809a-91a3-44b6-aa27-4d327b0ea9ac	a1b976fc-99d3-4b5f-89b5-bc7e7fc4c0d2	1	Tambah Data
d38ee02c-15d0-4d3e-aec6-2923b650cfe4	a1b976fc-99d3-4b5f-89b5-bc7e7fc4c0d2	2	Edit Data
81e56e1f-6d9f-4114-ad88-8e55cda0c6a9	a1b976fc-99d3-4b5f-89b5-bc7e7fc4c0d2	3	Hapus Data
b2e1120f-b872-4f33-9b1b-2f93b6ced471	7c7a2763-ed8b-41a7-a42d-b79233d02e02	0	Melihat Data
1e26a1e7-9a54-4c4a-b0c8-9634420ba30f	7c7a2763-ed8b-41a7-a42d-b79233d02e02	1	Tambah Data
16949b89-1155-40ae-abf8-dbde817e4ceb	7c7a2763-ed8b-41a7-a42d-b79233d02e02	2	Edit Data
0c1fd367-ded8-49f0-adae-04fbf425cc1f	7c7a2763-ed8b-41a7-a42d-b79233d02e02	3	Hapus Data
707ab536-89c9-4967-b9e3-829a5efe62c9	33d081b5-8e4d-424b-a00a-eccf1f1a8809	0	Melihat Data
560ba445-9d7c-4bda-ae22-ef9002015b10	33d081b5-8e4d-424b-a00a-eccf1f1a8809	1	Tambah Data
8065089a-e117-49e5-a0fd-eded6141faeb	33d081b5-8e4d-424b-a00a-eccf1f1a8809	2	Edit Data
1a9f375b-d052-4c61-8c1f-4b34c21eb11e	33d081b5-8e4d-424b-a00a-eccf1f1a8809	3	Hapus Data
1e5d52e7-f0ef-46a9-b9fc-945186e39700	65afc8bf-4df2-486a-b878-e77638ae2688	0	Melihat Data
497a89a1-4f1f-4e96-8a40-f548ab72aed1	65afc8bf-4df2-486a-b878-e77638ae2688	1	Tambah Data
d56e46eb-53ae-4344-801a-81fe2459111f	65afc8bf-4df2-486a-b878-e77638ae2688	2	Edit Data
7b518174-4d11-4c68-9930-4cc32e5a1b05	65afc8bf-4df2-486a-b878-e77638ae2688	3	Hapus Data
445e6e28-6525-4ac0-ac6e-4a80f2e64fa9	7cca3d24-3fc3-4c64-b361-78c0c7581920	0	Cetak Label Harga Produk
623a5162-e107-41fe-bb3a-25e8d32e30ae	fa7e83ee-9b49-4cda-badd-d68cda7b7a9a	0	Cetak Barcode
e6d7d44f-a22d-4b8c-8a79-21ccf62c501c	ed926af3-61a5-40e7-8975-de78c90eb784	0	Melihat Data
51caa0e2-7004-4b5c-9eff-98d0e5cf11cb	ed926af3-61a5-40e7-8975-de78c90eb784	1	Tambah Data
d1d37165-0aad-4637-b8de-bd36b7bdecaa	ed926af3-61a5-40e7-8975-de78c90eb784	2	Edit Data
64c02357-121c-4bdc-b158-367ae6519e80	ed926af3-61a5-40e7-8975-de78c90eb784	3	Hapus Data
0fda778f-0b00-474c-95f8-b91b9759c484	948af0c2-5c0d-4887-8d81-4cd42e1b02a0	0	Melihat Data
d701f09f-1ff8-4a83-92ce-ae0080055538	948af0c2-5c0d-4887-8d81-4cd42e1b02a0	1	Tambah Data
ddf9f9c6-d23c-48d1-9896-c2c613174934	948af0c2-5c0d-4887-8d81-4cd42e1b02a0	2	Edit Data
939446e1-4185-4ef1-a072-7541a781bb58	948af0c2-5c0d-4887-8d81-4cd42e1b02a0	3	Hapus Data
fb063166-8527-4a30-b22e-69b3b97b17c8	8a8c6d23-963b-4819-819d-b9cdeaad7718	0	Melihat Data
6c5872a2-8ba5-4842-952a-3aa7f7fdae31	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	Tambah Data
7931d986-3f1f-4e23-9a11-4ffb7e122067	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	Edit Data
7633ad97-ce8d-468b-9b4d-af19d4bcf138	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	Hapus Data
acf0a50a-277c-4c52-80a7-f0efd7026784	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	Melihat Data
14900edb-6426-4f26-a9d0-aece69ccb2c1	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	Tambah Data
a6429c39-0751-4cf9-8993-4d74649a1e81	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	Edit Data
e15969eb-7bbc-403d-bb99-f6465393d697	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	Hapus Data
0ebfb075-f973-4a5d-ad86-60411ce6a787	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	Melihat Data
bbe4ca31-5bbd-4791-91d1-bf196a6f8f35	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	Tambah Data
eb0bca07-ddca-4e6b-a499-49a7173330b4	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	Edit Data
52a12c7c-34bb-46aa-9000-e5fef6afa2be	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	Hapus Data
9aa2f5e9-f8b8-4696-9e2d-10e1118820b9	fd48562f-9096-4cec-ad9c-37229fc072a3	0	Melihat Data
b6842258-25f4-4ce1-8a62-b3ed0a5a5f1d	fd48562f-9096-4cec-ad9c-37229fc072a3	1	Tambah Data
ae432c77-b9fe-4cac-b512-3c51b70b5cdc	fd48562f-9096-4cec-ad9c-37229fc072a3	2	Edit Data
216ef3b3-b3c7-4a2c-814b-16f1e8f491dd	fd48562f-9096-4cec-ad9c-37229fc072a3	3	Hapus Data
a826173e-5ef2-4d84-80dc-1346a3b55d87	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	Melihat Data
1dbddce5-13ee-4ef5-b30d-9fe2c6ea5702	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	Tambah Data
9fb7dca3-649c-47cd-ae65-385a0664b3e4	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	Edit Data
cc3ffcb4-0ce5-4b5a-8a48-7997629df57d	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	Hapus Data
1e5d489a-6091-4285-88cd-33b543faeee0	e7be0d85-9f96-4095-be35-1da049028cef	0	Melihat Data
cc1039a5-fd4b-47fc-bf8a-8e6ffaae0d64	e7be0d85-9f96-4095-be35-1da049028cef	1	Tambah Data
d3473ff5-faa9-42ca-992c-78c7171e48af	e7be0d85-9f96-4095-be35-1da049028cef	2	Edit Data
8026dd31-bf35-4a86-a5bf-8b5d9554ab9e	e7be0d85-9f96-4095-be35-1da049028cef	3	Hapus Data
95e679e8-0716-4a8a-a560-ab578e25c20f	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	Melihat Data
1adfa5d6-6769-466b-aaa9-2b923a939945	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	Tambah Data
46cebf0e-27e1-444d-a2a3-84eb0e21a3d3	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	Edit Data
86503188-5b09-4132-a1f3-b38cb63c6786	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	Hapus Data
818f879b-157c-472c-934b-745cbd7389fe	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	Melihat Data
45f2437b-e741-4bf4-97e2-220db7af6171	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	Tambah Data
f7c9d53c-764f-4feb-9188-e1c5401a0a6a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	Edit Data
c0c1cc14-8b9c-4dd9-9435-b4cc777b834f	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	Hapus Data
ef2d0758-cbf1-4c2a-8887-eb022d316b2f	a6043b21-18d0-4fcd-9ea9-f146542081d5	0	Melihat Data
1977fd24-fb8c-443e-be71-1067e7266a57	a6043b21-18d0-4fcd-9ea9-f146542081d5	1	Tambah Data
686eed4d-08cc-4e00-8edf-9ae0041613df	a6043b21-18d0-4fcd-9ea9-f146542081d5	2	Edit Data
9cfad67a-73c3-4b8c-852c-aa3c3baf5d7f	a6043b21-18d0-4fcd-9ea9-f146542081d5	3	Hapus Data
9988ecb3-6768-4b01-b1db-449c81c6b9d4	084488a3-092d-4e8c-8bf2-72dcf90262b4	0	Melihat Data
2b937e8d-2395-4f39-866d-b1569bc91faf	084488a3-092d-4e8c-8bf2-72dcf90262b4	1	Tambah Data
94cff94e-29f1-4905-a840-df6422552162	084488a3-092d-4e8c-8bf2-72dcf90262b4	2	Edit Data
60093fb2-340b-45f5-a1ff-5ca6b8d9a13e	084488a3-092d-4e8c-8bf2-72dcf90262b4	3	Hapus Data
579bb10a-b19a-4cfd-ae62-799ef9c5fe71	870ec1d3-5b71-47dc-b241-1b0ae933217c	0	Melihat Data
40b82838-fa26-431e-89f1-1ca918a11c40	870ec1d3-5b71-47dc-b241-1b0ae933217c	1	Tambah Data
e9e52f8b-9dcb-4953-9c69-31981385d49d	870ec1d3-5b71-47dc-b241-1b0ae933217c	2	Edit Data
9193e4c5-958c-478c-96b8-0902ea6cd917	870ec1d3-5b71-47dc-b241-1b0ae933217c	3	Hapus Data
3f8caa2e-136e-4a3c-bc98-2c00209a364b	b4be7b7c-4587-4af4-af07-fce34df723df	0	Melihat Data
27ba706a-cfa5-4814-acec-b759816d0a40	b4be7b7c-4587-4af4-af07-fce34df723df	1	Tambah Data
9bbf8a5e-1366-4bb1-81e4-b403914a107d	b4be7b7c-4587-4af4-af07-fce34df723df	2	Edit Data
d7a4b2f8-e1ad-4bef-a615-26a922f03141	b4be7b7c-4587-4af4-af07-fce34df723df	3	Hapus Data
c49e137e-cdca-4507-8d09-24fbe083449b	99302348-4d3c-48dd-8d67-c422e3061f1c	0	Melihat Data
4fccd5ce-39cd-4dac-bd0d-7c03ba2e5b78	99302348-4d3c-48dd-8d67-c422e3061f1c	1	Tambah Data
a65ae8d6-1645-4df8-8dfb-d31d253035e5	99302348-4d3c-48dd-8d67-c422e3061f1c	2	Edit Data
cbaf9fa6-e958-482d-a645-960dd2f78f66	99302348-4d3c-48dd-8d67-c422e3061f1c	3	Hapus Data
47424a6a-d185-443f-a227-b81014af1aff	576b9f00-c29d-4c2c-9a6b-5a563344de93	0	Melihat Data
c1bb7b36-efe8-4740-8e18-4f56d064481a	576b9f00-c29d-4c2c-9a6b-5a563344de93	1	Tambah Data
6d2b565d-eb55-4da1-a987-04eca17099ab	576b9f00-c29d-4c2c-9a6b-5a563344de93	2	Edit Data
5cade8ec-00eb-4d8f-ae94-3a7d17a64451	576b9f00-c29d-4c2c-9a6b-5a563344de93	3	Hapus Data
b931c11c-6051-4aac-8f11-f0dd368985d7	08392673-2e61-4266-a6ae-5cb75fdf42e8	0	Melihat Data
e259ac80-3176-4a82-a640-d1c2c53752f3	08392673-2e61-4266-a6ae-5cb75fdf42e8	1	Tambah Data
226b6941-ee52-4a8e-9b02-215a7e1d5c37	08392673-2e61-4266-a6ae-5cb75fdf42e8	2	Edit Data
464336fe-e2ac-47af-a0bc-960efbe8f2be	08392673-2e61-4266-a6ae-5cb75fdf42e8	3	Hapus Data
8b939067-c6ac-4c2f-abed-11add45bb6d3	13b929f3-d349-4686-b803-b350732003c8	0	Melihat Data
5c81d781-8429-4d26-970e-f32a2b4845ad	13b929f3-d349-4686-b803-b350732003c8	1	Tambah Data
157445a9-9189-45a2-9fba-26c81fc2a498	13b929f3-d349-4686-b803-b350732003c8	2	Edit Data
43dbb63b-6259-4b1e-94ee-fbefa6dbd4aa	13b929f3-d349-4686-b803-b350732003c8	3	Hapus Data
a990873c-bc20-4365-a747-ccc0a66fb6b2	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	0	Melihat Data
f0e18302-98f3-4658-91cb-03dc1ad17555	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	1	Tambah Data
1825820a-040c-41dd-bfd3-1193dc0b03a6	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	2	Edit Data
ef115fab-edaa-414f-8c9e-0f0f81cc2f4d	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	3	Hapus Data
853d4604-5e44-4f64-aa53-a10af1fd8126	295f6ddd-b934-4215-8e44-74905efd2273	0	Melihat Data
9c83adeb-b152-49b0-87da-e7fad85464ab	295f6ddd-b934-4215-8e44-74905efd2273	1	Tambah Data
96fbe49d-2ffb-4541-91d8-f63c02ea016d	295f6ddd-b934-4215-8e44-74905efd2273	2	Edit Data
a18cadbd-3127-49a9-935e-e36a123d0fe4	295f6ddd-b934-4215-8e44-74905efd2273	3	Hapus Data
7b730f8f-8be7-46e8-8ecd-fc6cd9c353f3	335e115b-8f25-4cad-96cf-22481c98c525	0	Melihat Data
07aaad91-b21a-4033-b54f-8030ae8fd9bd	335e115b-8f25-4cad-96cf-22481c98c525	1	Tambah Data
838dafdf-527c-428b-a071-6578be6fdc38	335e115b-8f25-4cad-96cf-22481c98c525	2	Edit Data
a64354e6-f81d-4753-a1e4-2840b05464b4	335e115b-8f25-4cad-96cf-22481c98c525	3	Hapus Data
91e62019-5f2f-408f-bfa8-6577d8d9e495	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	0	Melihat Data
d115d67d-2760-41d2-9d38-46c108759217	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	1	Tambah Data
2db01574-2ffc-4cd6-b491-0b139cf86957	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	2	Edit Data
3693f7b8-2dc1-4b37-b94a-6ecaf47b700d	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	3	Hapus Data
217210c0-1190-4e02-9407-4877304bd86e	b0b538ba-3535-4308-8012-9e2fa0daa0b0	0	Melihat Data
6b01ff73-47e4-4a07-a670-4d45841251be	b0b538ba-3535-4308-8012-9e2fa0daa0b0	1	Tambah Data
cd3fb679-a3da-42cb-89d7-f684382ebd02	b0b538ba-3535-4308-8012-9e2fa0daa0b0	2	Edit Data
70ea7e61-b3c2-4c74-85f9-f3941e59e030	b0b538ba-3535-4308-8012-9e2fa0daa0b0	3	Hapus Data
e97ae76a-3c59-4f95-b896-ec757020e5d3	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	0	Melihat Data
0d3cafe1-5d85-48d9-8ff6-7759f059f72d	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	1	Tambah Data
7550e753-02c9-45ed-b105-3b9714fc0340	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	2	Edit Data
14b47dd7-05c3-4bf3-b2a9-6fcc634d120e	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	3	Hapus Data
68b7c124-dfb7-4631-828f-13f0c4173aef	5a114aab-28cc-4655-b676-d08075bae831	0	Melihat Data
40e58353-6bfe-4203-b2d0-d03f01dba41a	5a114aab-28cc-4655-b676-d08075bae831	1	Tambah Data
653d9faf-4a7c-4c47-99ca-2d00bb4f60a4	5a114aab-28cc-4655-b676-d08075bae831	2	Edit Data
439241e4-8aad-4563-ae01-7cfbbcad2674	5a114aab-28cc-4655-b676-d08075bae831	3	Hapus Data
933f45ce-bf98-4a20-b512-9f716c3ec348	6a593127-4efb-4d7e-be38-53894c4828d0	0	Melihat Data
0a482b87-7636-4ad4-b6a4-05b592f91022	6a593127-4efb-4d7e-be38-53894c4828d0	1	Tambah Data
b1ca012a-15e2-41b3-95c0-ca3262e34015	6a593127-4efb-4d7e-be38-53894c4828d0	2	Edit Data
00c3da69-773a-4adc-acbd-215bbba8ede4	6a593127-4efb-4d7e-be38-53894c4828d0	3	Hapus Data
dd2d3e8a-4113-44a2-ade3-39914dbd392a	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	0	Melihat Data
73d4fadb-ea43-42eb-90a3-2828a21669eb	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	1	Tambah Data
0be0e4bc-2ac4-4266-88e5-509bc1b716ca	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	2	Edit Data
9445fd75-ed03-4848-a901-4fddc110f87c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	3	Hapus Data
b8bfb211-314f-462f-bf62-530d06a5037f	942cf428-3e36-48d2-8932-7e55cde20b32	0	Melihat Data
02e6c335-98e4-4f50-9616-ea9dc6c7367e	942cf428-3e36-48d2-8932-7e55cde20b32	1	Tambah Data
fe829c88-ebf5-46db-a3f6-484244debcb3	942cf428-3e36-48d2-8932-7e55cde20b32	2	Edit Data
7f2e8695-42c6-47d1-ab99-03a840e9e696	942cf428-3e36-48d2-8932-7e55cde20b32	3	Hapus Data
bbb3be48-2522-435b-9673-b76ae299acd3	5b99b5c4-91a8-4492-80a2-71cd9b800f00	0	Melihat Data
13835216-f64e-443f-8379-404dfc1d9536	5b99b5c4-91a8-4492-80a2-71cd9b800f00	1	Tambah Data
2fe7ed54-fe09-47da-a7cd-9a11e3414917	5b99b5c4-91a8-4492-80a2-71cd9b800f00	2	Edit Data
b975a20b-95ba-4760-b3b0-c2111abd7ae0	5b99b5c4-91a8-4492-80a2-71cd9b800f00	3	Hapus Data
f748bb4c-157c-4b34-bd15-915180eb08d6	01803718-15d1-4ef4-9574-b9bb161c1638	0	Melihat Data
5d46b875-0d13-434d-bf69-241b8a498aad	01803718-15d1-4ef4-9574-b9bb161c1638	1	Tambah Data
5e8bc06d-a358-4293-8db6-9715d94fa8fc	01803718-15d1-4ef4-9574-b9bb161c1638	2	Edit Data
d1c3a0b4-039d-4726-bdde-b2617f9d10dd	01803718-15d1-4ef4-9574-b9bb161c1638	3	Hapus Data
2f955886-03c6-40bd-af97-e3fc7e8e7450	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	0	Melihat Data
87e413b7-d136-421d-abc8-3b0d2dd01271	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	1	Tambah Data
76c4bd40-4e12-4172-bdca-c9510eeebf57	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	2	Edit Data
5b90db87-7e41-4485-88fd-23198ad2b139	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	3	Hapus Data
ae3dc6c4-e67e-43d7-82bc-3ef5d968b5a4	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	0	Melihat Data
0f350585-53ca-4f1c-95e1-a02b4946a350	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	1	Tambah Data
5a1def48-492c-4438-960d-8e3662902701	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	2	Edit Data
11adf051-48f6-4f61-a89d-c547210dcc23	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	3	Hapus Data
e7f230bf-f7df-44c3-82a1-41c0a21b1813	d62d3352-56e7-4802-973e-32d590febdab	0	Melihat Data
f54944cf-d7c9-4e3c-8d49-1cb264a12852	d62d3352-56e7-4802-973e-32d590febdab	1	Tambah Data
25843563-bc00-4235-813a-b09f74185066	d62d3352-56e7-4802-973e-32d590febdab	2	Edit Data
1ea4681f-5a75-474d-9f4a-6cf11c917745	d62d3352-56e7-4802-973e-32d590febdab	3	Hapus Data
4f1fda44-3780-4c6b-a568-f1bbd83d60eb	986182a1-8b33-457b-9151-38676f0f0869	0	Melihat Data
7b81dff2-64de-43ee-b3d7-172b6ad8bbf4	986182a1-8b33-457b-9151-38676f0f0869	1	Tambah Data
b967d07d-c0c5-4686-a3e2-cd29288c35a9	986182a1-8b33-457b-9151-38676f0f0869	2	Edit Data
74befc13-6931-464f-b021-5a996b999f24	986182a1-8b33-457b-9151-38676f0f0869	3	Hapus Data
e6f0a448-6962-4815-b4c6-c24766b16bf9	5c336652-4465-4b62-8de1-dac26fc696b6	0	Melihat Data
bd6c0115-736d-48a2-b5f3-2552bbfc7580	5c336652-4465-4b62-8de1-dac26fc696b6	1	Tambah Data
39d6330a-23f4-431b-a497-7dab1de4464a	5c336652-4465-4b62-8de1-dac26fc696b6	2	Edit Data
f1407b4b-5f5e-480d-b94a-7440d77688bc	5c336652-4465-4b62-8de1-dac26fc696b6	3	Hapus Data
67bfefed-1ea1-4e9a-ae61-3dd8b0db9e98	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	0	Melihat Data
b36298e7-9bfd-417d-9ce7-aa18966c0394	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	1	Tambah Data
ac60965e-8a2d-4bc6-aab1-bf85eb40409a	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	2	Edit Data
123a1c60-1c56-473f-bc7c-c1f8e76f5615	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	3	Hapus Data
83ecbd41-11ee-497f-b34a-2dda5bcc2c72	8c46f173-f586-402d-b54a-ac2e4ba57f1e	0	Melihat Data
83777d90-22a0-4a63-92f9-5e594d92d03c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	1	Tambah Data
845ca650-9956-4b63-88c4-417628f73c18	8c46f173-f586-402d-b54a-ac2e4ba57f1e	2	Edit Data
a250ef10-430d-4866-a032-98ac65b835e8	8c46f173-f586-402d-b54a-ac2e4ba57f1e	3	Hapus Data
06c6e20f-934a-46c9-a74b-76864cdc7c69	36aabcfa-60bc-48f5-9af6-30aa7600eb5b	2	Edit Data
61e5a064-bd9b-4018-a1be-f0fc65ebe422	0702e90c-cb7c-42a4-a447-478fba5a7443	0	Melihat Data
aff995dc-fd33-4d0d-a5cb-d7b23a9298a9	0702e90c-cb7c-42a4-a447-478fba5a7443	1	Tambah Data
4904e829-b642-4485-96a3-5c415cb5dc7b	0702e90c-cb7c-42a4-a447-478fba5a7443	2	Edit Data
2becf456-45e4-4645-8a40-2cc8525025d7	0702e90c-cb7c-42a4-a447-478fba5a7443	3	Hapus Data
db7e5b95-2f20-4317-aba2-2030a4de822a	e8f83478-a577-4cff-a06f-8d921f9367c7	0	Melihat Data
f62ee5a7-db04-4341-ae60-01d73868226a	e8f83478-a577-4cff-a06f-8d921f9367c7	1	Tambah Data
ff49859c-5c15-4d80-8c62-13e1b1668365	e8f83478-a577-4cff-a06f-8d921f9367c7	2	Edit Data
3b6d8954-39c7-44f8-9ff5-49e477876562	e8f83478-a577-4cff-a06f-8d921f9367c7	3	Hapus Data
\.


--
-- TOC entry 5396 (class 0 OID 24984)
-- Dependencies: 227
-- Data for Name: m_jabatan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_jabatan (jabatan_id, nama_jabatan, keterangan) FROM stdin;
120d3472-ea93-4e29-8abd-5bd7044d26db	Kasir	\N
f1e4ea09-b777-4e56-bb90-db2bf9211468	General Manager	\N
583b27e0-1644-4884-8651-47789e7713e5	Staff Administrasi	\N
edb47227-da98-4d97-bff2-b7ee41ff3400	Owner	Pemilik toko
955d42f3-bd82-4aa7-8c9f-8a6207b0494d	Security	\N
def6e55c-47d4-4381-9a67-4f2cdce1db4d	Sopir	\N
\.


--
-- TOC entry 5397 (class 0 OID 24989)
-- Dependencies: 228
-- Data for Name: m_jenis_pengeluaran; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_jenis_pengeluaran (jenis_pengeluaran_id, nama_jenis_pengeluaran) FROM stdin;
26b062ad-7469-42c4-9326-bb84feeca746	Biaya Listrik
6c262064-6453-4bea-9e0f-5ae1810d0557	Biaya Iklan
cd381cd3-dd95-46c3-aff4-d36d9ae02faa	Biaya Perlengkapan Kantor
b7968f37-5a92-4ea3-bff0-2909aed18d9d	Biaya Penyusutan Peralatan Kantor
184f087f-8bd6-4b2c-9c53-16aeefa1a346	Biaya Sewa Gedung
2cc2ae56-dc3b-4991-af56-7768ae10816a	Biaya SPJ marketing
c2116c49-a940-4385-be94-302470b67b83	Biaya Penyusutan Kendaraan
b0188e31-01cd-4825-9ab8-e1bb433e15df	biaya pengembangan web api
2d921654-2646-4e38-b09c-d691a40469b4	Biaya Alat Tulis Kantor
1619f95e-eac3-40e9-ba8a-af2230d3c470	Biaya Lain Lain Penjualan
a8edb7ee-7807-4dfd-afc0-9ddc6006ca36	Biaya Lain Lain
\.


--
-- TOC entry 5398 (class 0 OID 24994)
-- Dependencies: 229
-- Data for Name: m_kabupaten; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_kabupaten (kabupaten_id, provinsi_id, tipe, nama_kabupaten, kode_pos) FROM stdin;
1	21	Kabupaten	Aceh Barat	23681
2	21	Kabupaten	Aceh Barat Daya	23764
3	21	Kabupaten	Aceh Besar	23951
4	21	Kabupaten	Aceh Jaya	23654
5	21	Kabupaten	Aceh Selatan	23719
6	21	Kabupaten	Aceh Singkil	24785
7	21	Kabupaten	Aceh Tamiang	24476
8	21	Kabupaten	Aceh Tengah	24511
9	21	Kabupaten	Aceh Tenggara	24611
10	21	Kabupaten	Aceh Timur	24454
11	21	Kabupaten	Aceh Utara	24382
12	32	Kabupaten	Agam	26411
13	23	Kabupaten	Alor	85811
14	19	Kota	Ambon	97222
15	34	Kabupaten	Asahan	21214
16	24	Kabupaten	Asmat	99777
17	1	Kabupaten	Badung	80351
18	13	Kabupaten	Balangan	71611
19	15	Kota	Balikpapan	76111
20	21	Kota	Banda Aceh	23238
21	18	Kota	Bandar Lampung	35139
22	9	Kabupaten	Bandung	40311
23	9	Kota	Bandung	40115
24	9	Kabupaten	Bandung Barat	40721
25	29	Kabupaten	Banggai	94711
26	29	Kabupaten	Banggai Kepulauan	94881
27	2	Kabupaten	Bangka	33212
28	2	Kabupaten	Bangka Barat	33315
29	2	Kabupaten	Bangka Selatan	33719
30	2	Kabupaten	Bangka Tengah	33613
31	11	Kabupaten	Bangkalan	69118
32	1	Kabupaten	Bangli	80619
33	13	Kabupaten	Banjar	70619
34	9	Kota	Banjar	46311
35	13	Kota	Banjarbaru	70712
36	13	Kota	Banjarmasin	70117
37	10	Kabupaten	Banjarnegara	53419
38	28	Kabupaten	Bantaeng	92411
39	5	Kabupaten	Bantul	55715
40	33	Kabupaten	Banyuasin	30911
41	10	Kabupaten	Banyumas	53114
42	11	Kabupaten	Banyuwangi	68416
43	13	Kabupaten	Barito Kuala	70511
44	14	Kabupaten	Barito Selatan	73711
45	14	Kabupaten	Barito Timur	73671
46	14	Kabupaten	Barito Utara	73881
47	28	Kabupaten	Barru	90719
48	17	Kota	Batam	29413
49	10	Kabupaten	Batang	51211
50	8	Kabupaten	Batang Hari	36613
51	11	Kota	Batu	65311
52	34	Kabupaten	Batu Bara	21655
53	30	Kota	Bau-Bau	93719
54	9	Kabupaten	Bekasi	17837
55	9	Kota	Bekasi	17121
56	2	Kabupaten	Belitung	33419
57	2	Kabupaten	Belitung Timur	33519
58	23	Kabupaten	Belu	85711
59	21	Kabupaten	Bener Meriah	24581
60	26	Kabupaten	Bengkalis	28719
61	12	Kabupaten	Bengkayang	79213
62	4	Kota	Bengkulu	38229
63	4	Kabupaten	Bengkulu Selatan	38519
64	4	Kabupaten	Bengkulu Tengah	38319
65	4	Kabupaten	Bengkulu Utara	38619
66	15	Kabupaten	Berau	77311
67	24	Kabupaten	Biak Numfor	98119
68	22	Kabupaten	Bima	84171
69	22	Kota	Bima	84139
70	34	Kota	Binjai	20712
71	17	Kabupaten	Bintan	29135
72	21	Kabupaten	Bireuen	24219
73	31	Kota	Bitung	95512
74	11	Kabupaten	Blitar	66171
75	11	Kota	Blitar	66124
76	10	Kabupaten	Blora	58219
77	7	Kabupaten	Boalemo	96319
78	9	Kabupaten	Bogor	16911
79	9	Kota	Bogor	16119
80	11	Kabupaten	Bojonegoro	62119
81	31	Kabupaten	Bolaang Mongondow (Bolmong)	95755
82	31	Kabupaten	Bolaang Mongondow Selatan	95774
83	31	Kabupaten	Bolaang Mongondow Timur	95783
84	31	Kabupaten	Bolaang Mongondow Utara	95765
85	30	Kabupaten	Bombana	93771
86	11	Kabupaten	Bondowoso	68219
87	28	Kabupaten	Bone	92713
88	7	Kabupaten	Bone Bolango	96511
89	15	Kota	Bontang	75313
90	24	Kabupaten	Boven Digoel	99662
91	10	Kabupaten	Boyolali	57312
92	10	Kabupaten	Brebes	52212
93	32	Kota	Bukittinggi	26115
94	1	Kabupaten	Buleleng	81111
95	28	Kabupaten	Bulukumba	92511
96	16	Kabupaten	Bulungan (Bulongan)	77211
97	8	Kabupaten	Bungo	37216
98	29	Kabupaten	Buol	94564
99	19	Kabupaten	Buru	97371
100	19	Kabupaten	Buru Selatan	97351
101	30	Kabupaten	Buton	93754
102	30	Kabupaten	Buton Utara	93745
103	9	Kabupaten	Ciamis	46211
104	9	Kabupaten	Cianjur	43217
105	10	Kabupaten	Cilacap	53211
106	3	Kota	Cilegon	42417
107	9	Kota	Cimahi	40512
108	9	Kabupaten	Cirebon	45611
109	9	Kota	Cirebon	45116
110	34	Kabupaten	Dairi	22211
111	24	Kabupaten	Deiyai (Deliyai)	98784
112	34	Kabupaten	Deli Serdang	20511
113	10	Kabupaten	Demak	59519
114	1	Kota	Denpasar	80227
115	9	Kota	Depok	16416
116	32	Kabupaten	Dharmasraya	27612
117	24	Kabupaten	Dogiyai	98866
118	22	Kabupaten	Dompu	84217
119	29	Kabupaten	Donggala	94341
120	26	Kota	Dumai	28811
121	33	Kabupaten	Empat Lawang	31811
122	23	Kabupaten	Ende	86351
123	28	Kabupaten	Enrekang	91719
124	25	Kabupaten	Fakfak	98651
125	23	Kabupaten	Flores Timur	86213
126	9	Kabupaten	Garut	44126
127	21	Kabupaten	Gayo Lues	24653
128	1	Kabupaten	Gianyar	80519
129	7	Kabupaten	Gorontalo	96218
130	7	Kota	Gorontalo	96115
131	7	Kabupaten	Gorontalo Utara	96611
132	28	Kabupaten	Gowa	92111
133	11	Kabupaten	Gresik	61115
134	10	Kabupaten	Grobogan	58111
135	5	Kabupaten	Gunung Kidul	55812
136	14	Kabupaten	Gunung Mas	74511
137	34	Kota	Gunungsitoli	22813
138	20	Kabupaten	Halmahera Barat	97757
139	20	Kabupaten	Halmahera Selatan	97911
140	20	Kabupaten	Halmahera Tengah	97853
141	20	Kabupaten	Halmahera Timur	97862
142	20	Kabupaten	Halmahera Utara	97762
143	13	Kabupaten	Hulu Sungai Selatan	71212
144	13	Kabupaten	Hulu Sungai Tengah	71313
145	13	Kabupaten	Hulu Sungai Utara	71419
146	34	Kabupaten	Humbang Hasundutan	22457
147	26	Kabupaten	Indragiri Hilir	29212
148	26	Kabupaten	Indragiri Hulu	29319
149	9	Kabupaten	Indramayu	45214
150	24	Kabupaten	Intan Jaya	98771
151	6	Kota	Jakarta Barat	11220
152	6	Kota	Jakarta Pusat	10540
153	6	Kota	Jakarta Selatan	12230
154	6	Kota	Jakarta Timur	13330
155	6	Kota	Jakarta Utara	14140
156	8	Kota	Jambi	36111
157	24	Kabupaten	Jayapura	99352
158	24	Kota	Jayapura	99114
159	24	Kabupaten	Jayawijaya	99511
160	11	Kabupaten	Jember	68113
161	1	Kabupaten	Jembrana	82251
162	28	Kabupaten	Jeneponto	92319
163	10	Kabupaten	Jepara	59419
164	11	Kabupaten	Jombang	61415
165	25	Kabupaten	Kaimana	98671
166	26	Kabupaten	Kampar	28411
167	14	Kabupaten	Kapuas	73583
168	12	Kabupaten	Kapuas Hulu	78719
169	10	Kabupaten	Karanganyar	57718
170	1	Kabupaten	Karangasem	80819
171	9	Kabupaten	Karawang	41311
172	17	Kabupaten	Karimun	29611
173	34	Kabupaten	Karo	22119
174	14	Kabupaten	Katingan	74411
175	4	Kabupaten	Kaur	38911
176	12	Kabupaten	Kayong Utara	78852
177	10	Kabupaten	Kebumen	54319
178	11	Kabupaten	Kediri	64184
179	11	Kota	Kediri	64125
180	24	Kabupaten	Keerom	99461
181	10	Kabupaten	Kendal	51314
182	30	Kota	Kendari	93126
183	4	Kabupaten	Kepahiang	39319
184	17	Kabupaten	Kepulauan Anambas	29991
185	19	Kabupaten	Kepulauan Aru	97681
186	32	Kabupaten	Kepulauan Mentawai	25771
187	26	Kabupaten	Kepulauan Meranti	28791
188	31	Kabupaten	Kepulauan Sangihe	95819
189	6	Kabupaten	Kepulauan Seribu	14550
190	31	Kabupaten	Kepulauan Siau Tagulandang Biaro (Sitaro)	95862
191	20	Kabupaten	Kepulauan Sula	97995
192	31	Kabupaten	Kepulauan Talaud	95885
193	24	Kabupaten	Kepulauan Yapen (Yapen Waropen)	98211
194	8	Kabupaten	Kerinci	37167
195	12	Kabupaten	Ketapang	78874
196	10	Kabupaten	Klaten	57411
197	1	Kabupaten	Klungkung	80719
198	30	Kabupaten	Kolaka	93511
199	30	Kabupaten	Kolaka Utara	93911
200	30	Kabupaten	Konawe	93411
201	30	Kabupaten	Konawe Selatan	93811
202	30	Kabupaten	Konawe Utara	93311
203	13	Kabupaten	Kotabaru	72119
204	31	Kota	Kotamobagu	95711
205	14	Kabupaten	Kotawaringin Barat	74119
206	14	Kabupaten	Kotawaringin Timur	74364
207	26	Kabupaten	Kuantan Singingi	29519
208	12	Kabupaten	Kubu Raya	78311
209	10	Kabupaten	Kudus	59311
210	5	Kabupaten	Kulon Progo	55611
211	9	Kabupaten	Kuningan	45511
212	23	Kabupaten	Kupang	85362
213	23	Kota	Kupang	85119
214	15	Kabupaten	Kutai Barat	75711
215	15	Kabupaten	Kutai Kartanegara	75511
216	15	Kabupaten	Kutai Timur	75611
217	34	Kabupaten	Labuhan Batu	21412
218	34	Kabupaten	Labuhan Batu Selatan	21511
219	34	Kabupaten	Labuhan Batu Utara	21711
220	33	Kabupaten	Lahat	31419
221	14	Kabupaten	Lamandau	74611
222	11	Kabupaten	Lamongan	64125
223	18	Kabupaten	Lampung Barat	34814
224	18	Kabupaten	Lampung Selatan	35511
225	18	Kabupaten	Lampung Tengah	34212
226	18	Kabupaten	Lampung Timur	34319
227	18	Kabupaten	Lampung Utara	34516
228	12	Kabupaten	Landak	78319
229	34	Kabupaten	Langkat	20811
230	21	Kota	Langsa	24412
231	24	Kabupaten	Lanny Jaya	99531
232	3	Kabupaten	Lebak	42319
233	4	Kabupaten	Lebong	39264
234	23	Kabupaten	Lembata	86611
235	21	Kota	Lhokseumawe	24352
236	32	Kabupaten	Lima Puluh Koto/Kota	26671
237	17	Kabupaten	Lingga	29811
238	22	Kabupaten	Lombok Barat	83311
239	22	Kabupaten	Lombok Tengah	83511
240	22	Kabupaten	Lombok Timur	83612
241	22	Kabupaten	Lombok Utara	83711
242	33	Kota	Lubuk Linggau	31614
243	11	Kabupaten	Lumajang	67319
244	28	Kabupaten	Luwu	91994
245	28	Kabupaten	Luwu Timur	92981
246	28	Kabupaten	Luwu Utara	92911
247	11	Kabupaten	Madiun	63153
248	11	Kota	Madiun	63122
249	10	Kabupaten	Magelang	56519
250	10	Kota	Magelang	56133
251	11	Kabupaten	Magetan	63314
252	9	Kabupaten	Majalengka	45412
253	27	Kabupaten	Majene	91411
254	28	Kota	Makassar	90111
255	11	Kabupaten	Malang	65163
256	11	Kota	Malang	65112
257	16	Kabupaten	Malinau	77511
258	19	Kabupaten	Maluku Barat Daya	97451
259	19	Kabupaten	Maluku Tengah	97513
260	19	Kabupaten	Maluku Tenggara	97651
261	19	Kabupaten	Maluku Tenggara Barat	97465
262	27	Kabupaten	Mamasa	91362
263	24	Kabupaten	Mamberamo Raya	99381
264	24	Kabupaten	Mamberamo Tengah	99553
265	27	Kabupaten	Mamuju	91519
266	27	Kabupaten	Mamuju Utara	91571
267	31	Kota	Manado	95247
268	34	Kabupaten	Mandailing Natal	22916
269	23	Kabupaten	Manggarai	86551
270	23	Kabupaten	Manggarai Barat	86711
271	23	Kabupaten	Manggarai Timur	86811
272	25	Kabupaten	Manokwari	98311
273	25	Kabupaten	Manokwari Selatan	98355
274	24	Kabupaten	Mappi	99853
275	28	Kabupaten	Maros	90511
276	22	Kota	Mataram	83131
277	25	Kabupaten	Maybrat	98051
278	34	Kota	Medan	20228
279	12	Kabupaten	Melawi	78619
280	8	Kabupaten	Merangin	37319
281	24	Kabupaten	Merauke	99613
282	18	Kabupaten	Mesuji	34911
283	18	Kota	Metro	34111
284	24	Kabupaten	Mimika	99962
285	31	Kabupaten	Minahasa	95614
286	31	Kabupaten	Minahasa Selatan	95914
287	31	Kabupaten	Minahasa Tenggara	95995
288	31	Kabupaten	Minahasa Utara	95316
289	11	Kabupaten	Mojokerto	61382
290	11	Kota	Mojokerto	61316
291	29	Kabupaten	Morowali	94911
292	33	Kabupaten	Muara Enim	31315
293	8	Kabupaten	Muaro Jambi	36311
294	4	Kabupaten	Muko Muko	38715
295	30	Kabupaten	Muna	93611
296	14	Kabupaten	Murung Raya	73911
297	33	Kabupaten	Musi Banyuasin	30719
298	33	Kabupaten	Musi Rawas	31661
299	24	Kabupaten	Nabire	98816
300	21	Kabupaten	Nagan Raya	23674
301	23	Kabupaten	Nagekeo	86911
302	17	Kabupaten	Natuna	29711
303	24	Kabupaten	Nduga	99541
304	23	Kabupaten	Ngada	86413
305	11	Kabupaten	Nganjuk	64414
306	11	Kabupaten	Ngawi	63219
307	34	Kabupaten	Nias	22876
308	34	Kabupaten	Nias Barat	22895
309	34	Kabupaten	Nias Selatan	22865
310	34	Kabupaten	Nias Utara	22856
311	16	Kabupaten	Nunukan	77421
312	33	Kabupaten	Ogan Ilir	30811
313	33	Kabupaten	Ogan Komering Ilir	30618
314	33	Kabupaten	Ogan Komering Ulu	32112
315	33	Kabupaten	Ogan Komering Ulu Selatan	32211
316	33	Kabupaten	Ogan Komering Ulu Timur	32312
317	11	Kabupaten	Pacitan	63512
318	32	Kota	Padang	25112
319	34	Kabupaten	Padang Lawas	22763
320	34	Kabupaten	Padang Lawas Utara	22753
321	32	Kota	Padang Panjang	27122
322	32	Kabupaten	Padang Pariaman	25583
323	34	Kota	Padang Sidempuan	22727
324	33	Kota	Pagar Alam	31512
325	34	Kabupaten	Pakpak Bharat	22272
326	14	Kota	Palangka Raya	73112
327	33	Kota	Palembang	31512
328	28	Kota	Palopo	91911
329	29	Kota	Palu	94111
330	11	Kabupaten	Pamekasan	69319
331	3	Kabupaten	Pandeglang	42212
332	9	Kabupaten	Pangandaran	46511
333	28	Kabupaten	Pangkajene Kepulauan	90611
334	2	Kota	Pangkal Pinang	33115
335	24	Kabupaten	Paniai	98765
336	28	Kota	Parepare	91123
337	32	Kota	Pariaman	25511
338	29	Kabupaten	Parigi Moutong	94411
339	32	Kabupaten	Pasaman	26318
340	32	Kabupaten	Pasaman Barat	26511
341	15	Kabupaten	Paser	76211
342	11	Kabupaten	Pasuruan	67153
343	11	Kota	Pasuruan	67118
344	10	Kabupaten	Pati	59114
345	32	Kota	Payakumbuh	26213
346	25	Kabupaten	Pegunungan Arfak	98354
347	24	Kabupaten	Pegunungan Bintang	99573
348	10	Kabupaten	Pekalongan	51161
349	10	Kota	Pekalongan	51122
350	26	Kota	Pekanbaru	28112
351	26	Kabupaten	Pelalawan	28311
352	10	Kabupaten	Pemalang	52319
353	34	Kota	Pematang Siantar	21126
354	15	Kabupaten	Penajam Paser Utara	76311
355	18	Kabupaten	Pesawaran	35312
356	18	Kabupaten	Pesisir Barat	35974
357	32	Kabupaten	Pesisir Selatan	25611
358	21	Kabupaten	Pidie	24116
359	21	Kabupaten	Pidie Jaya	24186
360	28	Kabupaten	Pinrang	91251
361	7	Kabupaten	Pohuwato	96419
362	27	Kabupaten	Polewali Mandar	91311
363	11	Kabupaten	Ponorogo	63411
364	12	Kabupaten	Pontianak	78971
365	12	Kota	Pontianak	78112
366	29	Kabupaten	Poso	94615
367	33	Kota	Prabumulih	31121
368	18	Kabupaten	Pringsewu	35719
369	11	Kabupaten	Probolinggo	67282
370	11	Kota	Probolinggo	67215
371	14	Kabupaten	Pulang Pisau	74811
372	20	Kabupaten	Pulau Morotai	97771
373	24	Kabupaten	Puncak	98981
374	24	Kabupaten	Puncak Jaya	98979
375	10	Kabupaten	Purbalingga	53312
376	9	Kabupaten	Purwakarta	41119
377	10	Kabupaten	Purworejo	54111
378	25	Kabupaten	Raja Ampat	98489
379	4	Kabupaten	Rejang Lebong	39112
380	10	Kabupaten	Rembang	59219
381	26	Kabupaten	Rokan Hilir	28992
382	26	Kabupaten	Rokan Hulu	28511
383	23	Kabupaten	Rote Ndao	85982
384	21	Kota	Sabang	23512
385	23	Kabupaten	Sabu Raijua	85391
386	10	Kota	Salatiga	50711
387	15	Kota	Samarinda	75133
388	12	Kabupaten	Sambas	79453
389	34	Kabupaten	Samosir	22392
390	11	Kabupaten	Sampang	69219
391	12	Kabupaten	Sanggau	78557
392	24	Kabupaten	Sarmi	99373
393	8	Kabupaten	Sarolangun	37419
394	32	Kota	Sawah Lunto	27416
395	12	Kabupaten	Sekadau	79583
396	28	Kabupaten	Selayar (Kepulauan Selayar)	92812
397	4	Kabupaten	Seluma	38811
398	10	Kabupaten	Semarang	50511
399	10	Kota	Semarang	50135
400	19	Kabupaten	Seram Bagian Barat	97561
401	19	Kabupaten	Seram Bagian Timur	97581
402	3	Kabupaten	Serang	42182
403	3	Kota	Serang	42111
404	34	Kabupaten	Serdang Bedagai	20915
405	14	Kabupaten	Seruyan	74211
406	26	Kabupaten	Siak	28623
407	34	Kota	Sibolga	22522
408	28	Kabupaten	Sidenreng Rappang/Rapang	91613
409	11	Kabupaten	Sidoarjo	61219
410	29	Kabupaten	Sigi	94364
411	32	Kabupaten	Sijunjung (Sawah Lunto Sijunjung)	27511
412	23	Kabupaten	Sikka	86121
413	34	Kabupaten	Simalungun	21162
414	21	Kabupaten	Simeulue	23891
415	12	Kota	Singkawang	79117
416	28	Kabupaten	Sinjai	92615
417	12	Kabupaten	Sintang	78619
418	11	Kabupaten	Situbondo	68316
419	5	Kabupaten	Sleman	55513
420	32	Kabupaten	Solok	27365
421	32	Kota	Solok	27315
422	32	Kabupaten	Solok Selatan	27779
423	28	Kabupaten	Soppeng	90812
424	25	Kabupaten	Sorong	98431
425	25	Kota	Sorong	98411
426	25	Kabupaten	Sorong Selatan	98454
427	10	Kabupaten	Sragen	57211
428	9	Kabupaten	Subang	41215
429	21	Kota	Subulussalam	24882
430	9	Kabupaten	Sukabumi	43311
431	9	Kota	Sukabumi	43114
432	14	Kabupaten	Sukamara	74712
433	10	Kabupaten	Sukoharjo	57514
434	23	Kabupaten	Sumba Barat	87219
435	23	Kabupaten	Sumba Barat Daya	87453
436	23	Kabupaten	Sumba Tengah	87358
437	23	Kabupaten	Sumba Timur	87112
438	22	Kabupaten	Sumbawa	84315
439	22	Kabupaten	Sumbawa Barat	84419
440	9	Kabupaten	Sumedang	45326
441	11	Kabupaten	Sumenep	69413
442	8	Kota	Sungaipenuh	37113
443	24	Kabupaten	Supiori	98164
444	11	Kota	Surabaya	60119
445	10	Kota	Surakarta (Solo)	57113
446	13	Kabupaten	Tabalong	71513
447	1	Kabupaten	Tabanan	82119
448	28	Kabupaten	Takalar	92212
449	25	Kabupaten	Tambrauw	98475
450	16	Kabupaten	Tana Tidung	77611
451	28	Kabupaten	Tana Toraja	91819
452	13	Kabupaten	Tanah Bumbu	72211
453	32	Kabupaten	Tanah Datar	27211
454	13	Kabupaten	Tanah Laut	70811
455	3	Kabupaten	Tangerang	15914
456	3	Kota	Tangerang	15111
457	3	Kota	Tangerang Selatan	15332
458	18	Kabupaten	Tanggamus	35619
459	34	Kota	Tanjung Balai	21321
460	8	Kabupaten	Tanjung Jabung Barat	36513
461	8	Kabupaten	Tanjung Jabung Timur	36719
462	17	Kota	Tanjung Pinang	29111
463	34	Kabupaten	Tapanuli Selatan	22742
464	34	Kabupaten	Tapanuli Tengah	22611
465	34	Kabupaten	Tapanuli Utara	22414
466	13	Kabupaten	Tapin	71119
467	16	Kota	Tarakan	77114
468	9	Kabupaten	Tasikmalaya	46411
469	9	Kota	Tasikmalaya	46116
470	34	Kota	Tebing Tinggi	20632
471	8	Kabupaten	Tebo	37519
472	10	Kabupaten	Tegal	52419
473	10	Kota	Tegal	52114
474	25	Kabupaten	Teluk Bintuni	98551
475	25	Kabupaten	Teluk Wondama	98591
476	10	Kabupaten	Temanggung	56212
477	20	Kota	Ternate	97714
478	20	Kota	Tidore Kepulauan	97815
479	23	Kabupaten	Timor Tengah Selatan	85562
480	23	Kabupaten	Timor Tengah Utara	85612
481	34	Kabupaten	Toba Samosir	22316
482	29	Kabupaten	Tojo Una-Una	94683
483	29	Kabupaten	Toli-Toli	94542
484	24	Kabupaten	Tolikara	99411
485	31	Kota	Tomohon	95416
486	28	Kabupaten	Toraja Utara	91831
487	11	Kabupaten	Trenggalek	66312
488	19	Kota	Tual	97612
489	11	Kabupaten	Tuban	62319
490	18	Kabupaten	Tulang Bawang	34613
491	18	Kabupaten	Tulang Bawang Barat	34419
492	11	Kabupaten	Tulungagung	66212
493	28	Kabupaten	Wajo	90911
494	30	Kabupaten	Wakatobi	93791
495	24	Kabupaten	Waropen	98269
496	18	Kabupaten	Way Kanan	34711
497	10	Kabupaten	Wonogiri	57619
498	10	Kabupaten	Wonosobo	56311
499	24	Kabupaten	Yahukimo	99041
500	24	Kabupaten	Yalimo	99481
501	5	Kota	Yogyakarta	55222
\.


--
-- TOC entry 5399 (class 0 OID 24999)
-- Dependencies: 230
-- Data for Name: m_kabupaten2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_kabupaten2 (kabupaten_id, provinsi_id, nama_kabupaten) FROM stdin;
1101	11	Kab. Simeulue
1102	11	Kab. Aceh Singkil
1103	11	Kab. Aceh Selatan
1104	11	Kab. Aceh Tenggara
1105	11	Kab. Aceh Timur
1106	11	Kab. Aceh Tengah
1107	11	Kab. Aceh Barat
1108	11	Kab. Aceh Besar
1109	11	Kab. Pidie
1110	11	Kab. Bireuen
1111	11	Kab. Aceh Utara
1112	11	Kab. Aceh Barat Daya
1113	11	Kab. Gayo Lues
1114	11	Kab. Aceh Tamiang
1115	11	Kab. Nagan Raya
1116	11	Kab. Aceh Jaya
1117	11	Kab. Bener Meriah
1118	11	Kab. Pidie Jaya
1171	11	Kota Banda Aceh
1172	11	Kota Sabang
1173	11	Kota Langsa
1174	11	Kota Lhokseumawe
1175	11	Kota Subulussalam
1201	12	Kab. Nias
1202	12	Kab. Mandailing Natal
1203	12	Kab. Tapanuli Selatan
1204	12	Kab. Tapanuli Tengah
1205	12	Kab. Tapanuli Utara
1206	12	Kab. Toba Samosir
1207	12	Kab. Labuhan Batu
1208	12	Kab. Asahan
1209	12	Kab. Simalungun
1210	12	Kab. Dairi
1211	12	Kab. Karo
1212	12	Kab. Deli Serdang
1213	12	Kab. Langkat
1214	12	Kab. Nias Selatan
1215	12	Kab. Humbang Hasundutan
1216	12	Kab. Pakpak Bharat
1217	12	Kab. Samosir
1218	12	Kab. Serdang Bedagai
1219	12	Kab. Batu Bara
1220	12	Kab. Padang Lawas Utara
1221	12	Kab. Padang Lawas
1222	12	Kab. Labuhan Batu Selatan
1223	12	Kab. Labuhan Batu Utara
1224	12	Kab. Nias Utara
1225	12	Kab. Nias Barat
1271	12	Kota Sibolga
1272	12	Kota Tanjung Balai
1273	12	Kota Pematang Siantar
1274	12	Kota Tebing Tinggi
1275	12	Kota Medan
1276	12	Kota Binjai
1277	12	Kota Padangsidimpuan
1278	12	Kota Gunungsitoli
1301	13	Kab. Kepulauan Mentawai
1302	13	Kab. Pesisir Selatan
1303	13	Kab. Solok
1304	13	Kab. Sijunjung
1305	13	Kab. Tanah Datar
1306	13	Kab. Padang Pariaman
1307	13	Kab. Agam
1308	13	Kab. Lima Puluh Kota
1309	13	Kab. Pasaman
1310	13	Kab. Solok Selatan
1311	13	Kab. Dharmasraya
1312	13	Kab. Pasaman Barat
1371	13	Kota Padang
1372	13	Kota Solok
1373	13	Kota Sawah Lunto
1374	13	Kota Padang Panjang
1375	13	Kota Bukittinggi
1376	13	Kota Payakumbuh
1377	13	Kota Pariaman
1401	14	Kab. Kuantan Singingi
1402	14	Kab. Indragiri Hulu
1403	14	Kab. Indragiri Hilir
1404	14	Kab. Pelalawan
1405	14	Kab. S I A K
1406	14	Kab. Kampar
1407	14	Kab. Rokan Hulu
1408	14	Kab. Bengkalis
1409	14	Kab. Rokan Hilir
1410	14	Kab. Kepulauan Meranti
1471	14	Kota Pekanbaru
1473	14	Kota D U M A I
1501	15	Kab. Kerinci
1502	15	Kab. Merangin
1503	15	Kab. Sarolangun
1504	15	Kab. Batang Hari
1505	15	Kab. Muaro Jambi
1506	15	Kab. Tanjung Jabung Timur
1507	15	Kab. Tanjung Jabung Barat
1508	15	Kab. Tebo
1509	15	Kab. Bungo
1571	15	Kota Jambi
1572	15	Kota Sungai Penuh
1601	16	Kab. Ogan Komering Ulu
1602	16	Kab. Ogan Komering Ilir
1603	16	Kab. Muara Enim
1604	16	Kab. Lahat
1605	16	Kab. Musi Rawas
1606	16	Kab. Musi Banyuasin
1607	16	Kab. Banyu Asin
1608	16	Kab. Ogan Komering Ulu Selatan
1609	16	Kab. Ogan Komering Ulu Timur
1610	16	Kab. Ogan Ilir
1611	16	Kab. Empat Lawang
1612	16	Kab. Penukal Abab Lematang Ilir
1613	16	Kab. Musi Rawas Utara
1671	16	Kota Palembang
1672	16	Kota Prabumulih
1673	16	Kota Pagar Alam
1674	16	Kota Lubuklinggau
1701	17	Kab. Bengkulu Selatan
1702	17	Kab. Rejang Lebong
1703	17	Kab. Bengkulu Utara
1704	17	Kab. Kaur
1705	17	Kab. Seluma
1706	17	Kab. Mukomuko
1707	17	Kab. Lebong
1708	17	Kab. Kepahiang
1709	17	Kab. Bengkulu Tengah
1771	17	Kota Bengkulu
1801	18	Kab. Lampung Barat
1802	18	Kab. Tanggamus
1803	18	Kab. Lampung Selatan
1804	18	Kab. Lampung Timur
1805	18	Kab. Lampung Tengah
1806	18	Kab. Lampung Utara
1807	18	Kab. Way Kanan
1808	18	Kab. Tulangbawang
1809	18	Kab. Pesawaran
1810	18	Kab. Pringsewu
1811	18	Kab. Mesuji
1812	18	Kab. Tulang Bawang Barat
1813	18	Kab. Pesisir Barat
1871	18	Kota Bandar Lampung
1872	18	Kota Metro
1901	19	Kab. Bangka
1902	19	Kab. Belitung
1903	19	Kab. Bangka Barat
1904	19	Kab. Bangka Tengah
1905	19	Kab. Bangka Selatan
1906	19	Kab. Belitung Timur
1971	19	Kota Pangkal Pinang
2101	21	Kab. Karimun
2102	21	Kab. Bintan
2103	21	Kab. Natuna
2104	21	Kab. Lingga
2105	21	Kab. Kepulauan Anambas
2171	21	Kota B A T A M
2172	21	Kota Tanjung Pinang
3101	31	Kab. Kepulauan Seribu
3171	31	Kota Jakarta Selatan
3172	31	Kota Jakarta Timur
3173	31	Kota Jakarta Pusat
3174	31	Kota Jakarta Barat
3175	31	Kota Jakarta Utara
3201	32	Kab. Bogor
3202	32	Kab. Sukabumi
3203	32	Kab. Cianjur
3204	32	Kab. Bandung
3205	32	Kab. Garut
3206	32	Kab. Tasikmalaya
3207	32	Kab. Ciamis
3208	32	Kab. Kuningan
3209	32	Kab. Cirebon
3210	32	Kab. Majalengka
3211	32	Kab. Sumedang
3212	32	Kab. Indramayu
3213	32	Kab. Subang
3214	32	Kab. Purwakarta
3215	32	Kab. Karawang
3216	32	Kab. Bekasi
3217	32	Kab. Bandung Barat
3218	32	Kab. Pangandaran
3271	32	Kota Bogor
3272	32	Kota Sukabumi
3273	32	Kota Bandung
3274	32	Kota Cirebon
3275	32	Kota Bekasi
3276	32	Kota Depok
3277	32	Kota Cimahi
3278	32	Kota Tasikmalaya
3279	32	Kota Banjar
3301	33	Kab. Cilacap
3302	33	Kab. Banyumas
3303	33	Kab. Purbalingga
3304	33	Kab. Banjarnegara
3305	33	Kab. Kebumen
3306	33	Kab. Purworejo
3307	33	Kab. Wonosobo
3308	33	Kab. Magelang
3309	33	Kab. Boyolali
3310	33	Kab. Klaten
3311	33	Kab. Sukoharjo
3312	33	Kab. Wonogiri
3313	33	Kab. Karanganyar
3314	33	Kab. Sragen
3315	33	Kab. Grobogan
3316	33	Kab. Blora
3317	33	Kab. Rembang
3318	33	Kab. Pati
3319	33	Kab. Kudus
3320	33	Kab. Jepara
3321	33	Kab. Demak
3322	33	Kab. Semarang
3323	33	Kab. Temanggung
3324	33	Kab. Kendal
3325	33	Kab. Batang
3326	33	Kab. Pekalongan
3327	33	Kab. Pemalang
3328	33	Kab. Tegal
3329	33	Kab. Brebes
3371	33	Kota Magelang
3372	33	Kota Surakarta
3373	33	Kota Salatiga
3374	33	Kota Semarang
3375	33	Kota Pekalongan
3376	33	Kota Tegal
3401	34	Kab. Kulon Progo
3402	34	Kab. Bantul
3403	34	Kab. Gunung Kidul
3404	34	Kab. Sleman
3471	34	Kota Yogyakarta
3501	35	Kab. Pacitan
3502	35	Kab. Ponorogo
3503	35	Kab. Trenggalek
3504	35	Kab. Tulungagung
3505	35	Kab. Blitar
3506	35	Kab. Kediri
3507	35	Kab. Malang
3508	35	Kab. Lumajang
3509	35	Kab. Jember
3510	35	Kab. Banyuwangi
3511	35	Kab. Bondowoso
3512	35	Kab. Situbondo
3513	35	Kab. Probolinggo
3514	35	Kab. Pasuruan
3515	35	Kab. Sidoarjo
3516	35	Kab. Mojokerto
3517	35	Kab. Jombang
3518	35	Kab. Nganjuk
3519	35	Kab. Madiun
3520	35	Kab. Magetan
3521	35	Kab. Ngawi
3522	35	Kab. Bojonegoro
3523	35	Kab. Tuban
3524	35	Kab. Lamongan
3525	35	Kab. Gresik
3526	35	Kab. Bangkalan
3527	35	Kab. Sampang
3528	35	Kab. Pamekasan
3529	35	Kab. Sumenep
3571	35	Kota Kediri
3572	35	Kota Blitar
3573	35	Kota Malang
3574	35	Kota Probolinggo
3575	35	Kota Pasuruan
3576	35	Kota Mojokerto
3577	35	Kota Madiun
3578	35	Kota Surabaya
3579	35	Kota Batu
3601	36	Kab. Pandeglang
3602	36	Kab. Lebak
3603	36	Kab. Tangerang
3604	36	Kab. Serang
3671	36	Kota Tangerang
3672	36	Kota Cilegon
3673	36	Kota Serang
3674	36	Kota Tangerang Selatan
5101	51	Kab. Jembrana
5102	51	Kab. Tabanan
5103	51	Kab. Badung
5104	51	Kab. Gianyar
5105	51	Kab. Klungkung
5106	51	Kab. Bangli
5107	51	Kab. Karang Asem
5108	51	Kab. Buleleng
5171	51	Kota Denpasar
5201	52	Kab. Lombok Barat
5202	52	Kab. Lombok Tengah
5203	52	Kab. Lombok Timur
5204	52	Kab. Sumbawa
5205	52	Kab. Dompu
5206	52	Kab. Bima
5207	52	Kab. Sumbawa Barat
5208	52	Kab. Lombok Utara
5271	52	Kota Mataram
5272	52	Kota Bima
5301	53	Kab. Sumba Barat
5302	53	Kab. Sumba Timur
5303	53	Kab. Kupang
5304	53	Kab. Timor Tengah Selatan
5305	53	Kab. Timor Tengah Utara
5306	53	Kab. Belu
5307	53	Kab. Alor
5308	53	Kab. Lembata
5309	53	Kab. Flores Timur
5310	53	Kab. Sikka
5311	53	Kab. Ende
5312	53	Kab. Ngada
5313	53	Kab. Manggarai
5314	53	Kab. Rote Ndao
5315	53	Kab. Manggarai Barat
5316	53	Kab. Sumba Tengah
5317	53	Kab. Sumba Barat Daya
5318	53	Kab. Nagekeo
5319	53	Kab. Manggarai Timur
5320	53	Kab. Sabu Raijua
5321	53	Kab. Malaka
5371	53	Kota Kupang
6101	61	Kab. Sambas
6102	61	Kab. Bengkayang
6103	61	Kab. Landak
6104	61	Kab. Mempawah
6105	61	Kab. Sanggau
6106	61	Kab. Ketapang
6107	61	Kab. Sintang
6108	61	Kab. Kapuas Hulu
6109	61	Kab. Sekadau
6110	61	Kab. Melawi
6111	61	Kab. Kayong Utara
6112	61	Kab. Kubu Raya
6171	61	Kota Pontianak
6172	61	Kota Singkawang
6201	62	Kab. Kotawaringin Barat
6202	62	Kab. Kotawaringin Timur
6203	62	Kab. Kapuas
6204	62	Kab. Barito Selatan
6205	62	Kab. Barito Utara
6206	62	Kab. Sukamara
6207	62	Kab. Lamandau
6208	62	Kab. Seruyan
6209	62	Kab. Katingan
6210	62	Kab. Pulang Pisau
6211	62	Kab. Gunung Mas
6212	62	Kab. Barito Timur
6213	62	Kab. Murung Raya
6271	62	Kota Palangka Raya
6301	63	Kab. Tanah Laut
6302	63	Kab. Kota Baru
6303	63	Kab. Banjar
6304	63	Kab. Barito Kuala
6305	63	Kab. Tapin
6306	63	Kab. Hulu Sungai Selatan
6307	63	Kab. Hulu Sungai Tengah
6308	63	Kab. Hulu Sungai Utara
6309	63	Kab. Tabalong
6310	63	Kab. Tanah Bumbu
6311	63	Kab. Balangan
6371	63	Kota Banjarmasin
6372	63	Kota Banjar Baru
6401	64	Kab. Paser
6402	64	Kab. Kutai Barat
6403	64	Kab. Kutai Kartanegara
6404	64	Kab. Kutai Timur
6405	64	Kab. Berau
6409	64	Kab. Penajam Paser Utara
6411	64	Kab. Mahakam Hulu
6471	64	Kota Balikpapan
6472	64	Kota Samarinda
6474	64	Kota Bontang
6501	65	Kab. Malinau
6502	65	Kab. Bulungan
6503	65	Kab. Tana Tidung
6504	65	Kab. Nunukan
6571	65	Kota Tarakan
7101	71	Kab. Bolaang Mongondow
7102	71	Kab. Minahasa
7103	71	Kab. Kepulauan Sangihe
7104	71	Kab. Kepulauan Talaud
7105	71	Kab. Minahasa Selatan
7106	71	Kab. Minahasa Utara
7107	71	Kab. Bolaang Mongondow Utara
7108	71	Kab. Siau Tagulandang Biaro
7109	71	Kab. Minahasa Tenggara
7110	71	Kab. Bolaang Mongondow Selatan
7111	71	Kab. Bolaang Mongondow Timur
7171	71	Kota Manado
7172	71	Kota Bitung
7173	71	Kota Tomohon
7174	71	Kota Kotamobagu
7201	72	Kab. Banggai Kepulauan
7202	72	Kab. Banggai
7203	72	Kab. Morowali
7204	72	Kab. Poso
7205	72	Kab. Donggala
7206	72	Kab. Toli-Toli
7207	72	Kab. Buol
7208	72	Kab. Parigi Moutong
7209	72	Kab. Tojo Una-Una
7210	72	Kab. Sigi
7211	72	Kab. Banggai Laut
7212	72	Kab. Morowali Utara
7271	72	Kota Palu
7301	73	Kab. Kepulauan Selayar
7302	73	Kab. Bulukumba
7303	73	Kab. Bantaeng
7304	73	Kab. Jeneponto
7305	73	Kab. Takalar
7306	73	Kab. Gowa
7307	73	Kab. Sinjai
7308	73	Kab. Maros
7309	73	Kab. Pangkajene Dan Kepulauan
7310	73	Kab. Barru
7311	73	Kab. Bone
7312	73	Kab. Soppeng
7313	73	Kab. Wajo
7314	73	Kab. Sidenreng Rappang
7315	73	Kab. Pinrang
7316	73	Kab. Enrekang
7317	73	Kab. Luwu
7318	73	Kab. Tana Toraja
7322	73	Kab. Luwu Utara
7325	73	Kab. Luwu Timur
7326	73	Kab. Toraja Utara
7371	73	Kota Makassar
7372	73	Kota Parepare
7373	73	Kota Palopo
7401	74	Kab. Buton
7402	74	Kab. Muna
7403	74	Kab. Konawe
7404	74	Kab. Kolaka
7405	74	Kab. Konawe Selatan
7406	74	Kab. Bombana
7407	74	Kab. Wakatobi
7408	74	Kab. Kolaka Utara
7409	74	Kab. Buton Utara
7410	74	Kab. Konawe Utara
7411	74	Kab. Kolaka Timur
7412	74	Kab. Konawe Kepulauan
7413	74	Kab. Muna Barat
7414	74	Kab. Buton Tengah
7415	74	Kab. Buton Selatan
7471	74	Kota Kendari
7472	74	Kota Baubau
7501	75	Kab. Boalemo
7502	75	Kab. Gorontalo
7503	75	Kab. Pohuwato
7504	75	Kab. Bone Bolango
7505	75	Kab. Gorontalo Utara
7571	75	Kota Gorontalo
7601	76	Kab. Majene
7602	76	Kab. Polewali Mandar
7603	76	Kab. Mamasa
7604	76	Kab. Mamuju
7605	76	Kab. Mamuju Utara
7606	76	Kab. Mamuju Tengah
8101	81	Kab. Maluku Tenggara Barat
8102	81	Kab. Maluku Tenggara
8103	81	Kab. Maluku Tengah
8104	81	Kab. Buru
8105	81	Kab. Kepulauan Aru
8106	81	Kab. Seram Bagian Barat
8107	81	Kab. Seram Bagian Timur
8108	81	Kab. Maluku Barat Daya
8109	81	Kab. Buru Selatan
8171	81	Kota Ambon
8172	81	Kota Tual
8201	82	Kab. Halmahera Barat
8202	82	Kab. Halmahera Tengah
8203	82	Kab. Kepulauan Sula
8204	82	Kab. Halmahera Selatan
8205	82	Kab. Halmahera Utara
8206	82	Kab. Halmahera Timur
8207	82	Kab. Pulau Morotai
8208	82	Kab. Pulau Taliabu
8271	82	Kota Ternate
8272	82	Kota Tidore Kepulauan
9101	91	Kab. Fakfak
9102	91	Kab. Kaimana
9103	91	Kab. Teluk Wondama
9104	91	Kab. Teluk Bintuni
9105	91	Kab. Manokwari
9106	91	Kab. Sorong Selatan
9107	91	Kab. Sorong
9108	91	Kab. Raja Ampat
9109	91	Kab. Tambrauw
9110	91	Kab. Maybrat
9111	91	Kab. Manokwari Selatan
9112	91	Kab. Pegunungan Arfak
9171	91	Kota Sorong
9401	94	Kab. Merauke
9402	94	Kab. Jayawijaya
9403	94	Kab. Jayapura
9404	94	Kab. Nabire
9408	94	Kab. Kepulauan Yapen
9409	94	Kab. Biak Numfor
9410	94	Kab. Paniai
9411	94	Kab. Puncak Jaya
9412	94	Kab. Mimika
9413	94	Kab. Boven Digoel
9414	94	Kab. Mappi
9415	94	Kab. Asmat
9416	94	Kab. Yahukimo
9417	94	Kab. Pegunungan Bintang
9418	94	Kab. Tolikara
9419	94	Kab. Sarmi
9420	94	Kab. Keerom
9426	94	Kab. Waropen
9427	94	Kab. Supiori
9428	94	Kab. Mamberamo Raya
9429	94	Kab. Nduga
9430	94	Kab. Lanny Jaya
9431	94	Kab. Mamberamo Tengah
9432	94	Kab. Yalimo
9433	94	Kab. Puncak
9434	94	Kab. Dogiyai
9435	94	Kab. Intan Jaya
9436	94	Kab. Deiyai
9471	94	Kota Jayapura
\.


--
-- TOC entry 5400 (class 0 OID 25004)
-- Dependencies: 231
-- Data for Name: m_kartu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_kartu (kartu_id, nama_kartu, is_debit) FROM stdin;
23f39815-30ed-44a0-92ef-95bbebe86857	Debit BNI	t
4939cbfa-0eb2-4f43-89a8-58285573762f	Visa	f
eadb5ebe-aca8-44b3-aa28-34263507c8ad	Debit Mandiri	t
fbf224d1-d109-4280-a465-e3ff04494cc2	Mastercard	f
\.


--
-- TOC entry 5401 (class 0 OID 25009)
-- Dependencies: 232
-- Data for Name: m_karyawan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_karyawan (karyawan_id, jabatan_id, nama_karyawan, alamat, telepon, gaji_pokok, is_active, keterangan, jenis_gajian, gaji_lembur, total_kasbon, total_pembayaran_kasbon) FROM stdin;
\.


--
-- TOC entry 5402 (class 0 OID 25016)
-- Dependencies: 233
-- Data for Name: m_kecamatan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_kecamatan (kecamatan_id, kabupaten_id, nama_kecamatan) FROM stdin;
1101010	1101	Teupah Selatan
1101020	1101	Simeulue Timur
1101021	1101	Teupah Barat
1101022	1101	Teupah Tengah
1101030	1101	Simeulue Tengah
1101031	1101	Teluk Dalam
1101032	1101	Simeulue Cut
1101040	1101	Salang
1101050	1101	Simeulue Barat
1101051	1101	Alafan
1102010	1102	Pulau Banyak
1102011	1102	Pulau Banyak Barat
1102020	1102	Singkil
1102021	1102	Singkil Utara
1102022	1102	Kuala Baru
1102030	1102	Simpang Kanan
1102031	1102	Gunung Meriah
1102032	1102	Danau Paris
1102033	1102	Suro
1102042	1102	Singkohor
1102043	1102	Kota Baharu
1103010	1103	Trumon
1103011	1103	Trumon Timur
1103012	1103	Trumon Tengah
1103020	1103	Bakongan
1103021	1103	Bakongan Timur
1103022	1103	Kota Bahagia
1103030	1103	Kluet Selatan
1103031	1103	Kluet Timur
1103040	1103	Kluet Utara
1103041	1103	Pasie Raja
1103042	1103	Kluet Tengah
1103050	1103	Tapak Tuan
1103060	1103	Sama Dua
1103070	1103	Sawang
1103080	1103	Meukek
1103090	1103	Labuhan Haji
1103091	1103	Labuhan Haji Timur
1103092	1103	Labuhan Haji Barat
\.


--
-- TOC entry 5403 (class 0 OID 25021)
-- Dependencies: 234
-- Data for Name: m_label_nota; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_label_nota (label_nota_id, keterangan, order_number, is_active) FROM stdin;
04fb83d6-f9e8-3dbc-0b1b-a8d3b0b0e765	KR Software	1	t
dfda864a-0019-5386-2ead-8f0f3686eaa4	Jl. Raya Berbah	2	t
add6061c-39be-238b-8c7a-7248f93ca8b6	HP: 0813 8176 9915	3	t
\.


--
-- TOC entry 5404 (class 0 OID 25026)
-- Dependencies: 235
-- Data for Name: m_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_menu (menu_id, nama_menu, judul_menu, parent_id, order_number, is_active, nama_form, is_enabled) FROM stdin;
0a516b56-ed73-dafe-aaa0-332fadd2f088	mnuPengaturanUmum	Pengaturan Umum	593c989d-be87-42bf-a11d-f177afcc2180	2	t	FrmPengaturanUmum	t
8a0ba72f-67d2-481f-9e10-a188f09effa5	mnuProduk	Produk	07b24b4b-cf52-4b3c-ab06-51f7312e4813	3	t	FrmListProduk	t
8a8c6d23-963b-4819-819d-b9cdeaad7718	mnuGolongan	Golongan	07b24b4b-cf52-4b3c-ab06-51f7312e4813	2	t	FrmListGolongan	t
ed926af3-61a5-40e7-8975-de78c90eb784	mnuLapPenjualanPerGolongan	Penjualan Per Golongan	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	9	t	FrmLapPenjualanPerGolongan	t
95e9e230-c4f3-4fbc-9652-78cf4155d7ea	mnuPenyesuaianStok	Penyesuaian Stok	07b24b4b-cf52-4b3c-ab06-51f7312e4813	6	t	FrmListPenyesuaianStok	t
fd48562f-9096-4cec-ad9c-37229fc072a3	mnuSupplier	Supplier	07b24b4b-cf52-4b3c-ab06-51f7312e4813	7	t	FrmListSupplier	t
5ab9c82d-a116-4032-8891-cbfb7b71b8e3	mnuCustomer	Customer	07b24b4b-cf52-4b3c-ab06-51f7312e4813	8	t	FrmListCustomer	t
7c7a2763-ed8b-41a7-a42d-b79233d02e02	mnuDropshipper	Dropshipper	07b24b4b-cf52-4b3c-ab06-51f7312e4813	9	t	FrmListDropshipper	t
f18fbb6e-bd6f-5d21-fa8d-11923327b436	mnuKartu	Kartu	07b24b4b-cf52-4b3c-ab06-51f7312e4813	1	t	FrmListKartu	t
fa7e83ee-9b49-4cda-badd-d68cda7b7a9a	mnuCetakLabelBarcodeProduk	Cetak Label Barcode Produk	07b24b4b-cf52-4b3c-ab06-51f7312e4813	5	t	FrmCetakLabelBarcodeProduk	t
7cca3d24-3fc3-4c64-b361-78c0c7581920	mnuCetakLabelHargaProduk	Cetak Label Harga Produk	07b24b4b-cf52-4b3c-ab06-51f7312e4813	4	t	FrmCetakLabelHargaProduk	t
6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	mnuLapPenjualan	Penjualan	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	18	t	\N	t
a0c6daf8-b0c8-4e9d-9702-7a2bb781580c	mnuLapPemasukanPengeluaran	Pemasukan dan Pengeluaran	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	25	t	FrmLapPemasukanPengeluaran	t
65afc8bf-4df2-486a-b878-e77638ae2688	mnuLapKartuStokProduk	Kartu Stok Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	21	t	FrmLapKartuStokProduk	t
d62d3352-56e7-4802-973e-32d590febdab	mnuLapStokProduk	Stok Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	19	t	FrmLapStokProduk	t
986182a1-8b33-457b-9151-38676f0f0869	mnuLapPenyesuaianStok	Penyesuaian Stok	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	20	t	FrmLapPenyesuaianStok	t
b94a2365-c063-491e-a798-c68dccd2d80b	mnuLapPenjualanProdukFavorit	Penjualan Produk Favorit	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	11	t	FrmLapPenjualanProdukFavorit	t
a1b976fc-99d3-4b5f-89b5-bc7e7fc4c0d2	mnuLapPenjualanPerKasir	Penjualan Per Kasir	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	10	t	FrmLapPenjualanPerKasir	t
33d081b5-8e4d-424b-a00a-eccf1f1a8809	mnuLapCustomerProduk	Customer Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	12	t	FrmLapCustomerProduk	t
5a114aab-28cc-4655-b676-d08075bae831	mnuLapPembelian	Pembelian	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	6	t	\N	t
07b24b4b-cf52-4b3c-ab06-51f7312e4813	mnuReferensi	Referensi	\N	1	t	\N	t
73e32548-da86-4db9-b3f9-f2ecd81ea3c9	mnuTransaksi	Transaksi	\N	2	t	\N	t
d1bd5f93-996c-46a3-b80f-f4f50681a1f9	mnuPengeluaran	Pengeluaran	\N	3	t	\N	t
3a62ea0b-0f48-495c-947b-ad5aa9af77f7	mnuLaporan	Laporan	\N	4	t	\N	t
593c989d-be87-42bf-a11d-f177afcc2180	mnuPengaturan	Pengaturan	\N	5	t	\N	t
a6043b21-18d0-4fcd-9ea9-f146542081d5	mnuPembelianProduk	Pembelian Produk	73e32548-da86-4db9-b3f9-f2ecd81ea3c9	1	t	FrmListPembelianProduk	t
084488a3-092d-4e8c-8bf2-72dcf90262b4	mnuPembayaranHutangPembelianProduk	Pembayaran Hutang Pembelian Produk	73e32548-da86-4db9-b3f9-f2ecd81ea3c9	2	t	FrmListPembayaranHutangPembelianProduk	t
870ec1d3-5b71-47dc-b241-1b0ae933217c	mnuReturPembelianProduk	Retur Pembelian Produk	73e32548-da86-4db9-b3f9-f2ecd81ea3c9	3	t	FrmListReturPembelianProduk	t
b4be7b7c-4587-4af4-af07-fce34df723df	mnuPenjualanProduk	Penjualan Produk	73e32548-da86-4db9-b3f9-f2ecd81ea3c9	4	t	FrmListPenjualanProduk	t
e7be0d85-9f96-4095-be35-1da049028cef	mnuJabatan	Jabatan	07b24b4b-cf52-4b3c-ab06-51f7312e4813	10	t	FrmListJabatan	t
b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	mnuKaryawan	Karyawan	07b24b4b-cf52-4b3c-ab06-51f7312e4813	11	t	FrmListKaryawan	t
99302348-4d3c-48dd-8d67-c422e3061f1c	mnuPembayaranPiutangPenjualanProduk	Pembayaran Piutang Penjualan Produk	73e32548-da86-4db9-b3f9-f2ecd81ea3c9	5	t	FrmListPembayaranPiutangPenjualanProduk	t
576b9f00-c29d-4c2c-9a6b-5a563344de93	mnuReturPenjualanProduk	Retur Penjualan Produk	73e32548-da86-4db9-b3f9-f2ecd81ea3c9	6	t	FrmListReturPenjualanProduk	t
36aabcfa-60bc-48f5-9af6-30aa7600eb5b	mnuProfilPerusahaan	Profil Perusahaan	593c989d-be87-42bf-a11d-f177afcc2180	1	t	FrmProfilPerusahaan	t
295f6ddd-b934-4215-8e44-74905efd2273	mnuLapPembelianProduk	Pembelian Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	1	t	FrmLapPembelianProduk	t
335e115b-8f25-4cad-96cf-22481c98c525	mnuLapHutangPembelianProduk	Hutang Pembelian Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	2	t	FrmLapHutangPembelianProduk	t
42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	mnuLapPembayaranHutangPembelianProduk	Pembayaran Hutang Pembelian Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	3	t	FrmLapPembayaranHutangPembelianProduk	t
b0b538ba-3535-4308-8012-9e2fa0daa0b0	mnuLapKartuHutangPembelianProduk	Kartu Hutang Pembelian Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	4	t	FrmLapKartuHutangPembelianProduk	t
5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	mnuLapReturPembelianProduk	Retur Pembelian Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	5	t	FrmLapReturPembelianProduk	t
6a593127-4efb-4d7e-be38-53894c4828d0	mnuLapPenjualanProduk	Penjualan Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	7	t	FrmLapPenjualanProduk	t
f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	mnuLapPenjualanPerProduk	Penjualan Per Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	8	t	FrmLapPenjualanPerProduk	t
b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	mnuJenisPengeluaran	Jenis Pengeluaran	07b24b4b-cf52-4b3c-ab06-51f7312e4813	12	t	FrmListJenisPengeluaran	t
5c336652-4465-4b62-8de1-dac26fc696b6	mnuLapPengeluaranBiaya	Pengeluaran Biaya	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	22	t	FrmLapPengeluaranBiaya	t
e9e7ff66-d302-49a3-a9e5-8a02ff87e016	mnuLapKasbon	Kasbon	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	23	t	FrmLapKasbon	t
08392673-2e61-4266-a6ae-5cb75fdf42e8	mnuPengeluaranBiaya	Pengeluaran Biaya	d1bd5f93-996c-46a3-b80f-f4f50681a1f9	1	t	FrmListPengeluaranBiaya	t
13b929f3-d349-4686-b803-b350732003c8	mnuKasbon	Kasbon	d1bd5f93-996c-46a3-b80f-f4f50681a1f9	2	t	FrmListKasbon	t
d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	mnuPenggajian	Penggajian Karyawan	d1bd5f93-996c-46a3-b80f-f4f50681a1f9	3	t	FrmListPenggajianKaryawan	t
0702e90c-cb7c-42a4-a447-478fba5a7443	mnuHakAksesAplikasi	Hak Akses Aplikasi	593c989d-be87-42bf-a11d-f177afcc2180	3	t	FrmListHakAkses	t
e8f83478-a577-4cff-a06f-8d921f9367c7	mnuManajemenOperator	Manajemen Operator	593c989d-be87-42bf-a11d-f177afcc2180	4	t	FrmListOperator	t
942cf428-3e36-48d2-8932-7e55cde20b32	mnuLapPiutangPenjualanProduk	Piutang Penjualan Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	13	t	FrmLapPiutangPenjualanProduk	t
5b99b5c4-91a8-4492-80a2-71cd9b800f00	mnuLapPembayaranPiutangPenjualanProduk	Pembayaran Piutang Penjualan Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	14	t	FrmLapPembayaranPiutangPenjualanProduk	t
01803718-15d1-4ef4-9574-b9bb161c1638	mnuLapKartuPiutangPenjualanProduk	Kartu Piutang Penjualan Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	15	t	FrmLapKartuPiutangPenjualanProduk	t
8c46f173-f586-402d-b54a-ac2e4ba57f1e	mnuLapPenggajian	Penggajian Karyawan	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	24	t	FrmLapPenggajianKaryawan	t
948af0c2-5c0d-4887-8d81-4cd42e1b02a0	mnuLapLabaRugiPenjualan	Laba/Rugi Penjualan	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	17	t	FrmLapLabaRugiPenjualan	t
56bd7e72-5e17-4105-bf4d-5f698e94a7fb	mnuLapReturPenjualanProduk	Retur Penjualan Produk	3a62ea0b-0f48-495c-947b-ad5aa9af77f7	16	t	FrmLapReturPenjualanProduk	t
\.


--
-- TOC entry 5405 (class 0 OID 25031)
-- Dependencies: 236
-- Data for Name: m_pengguna; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_pengguna (pengguna_id, role_id, nama_pengguna, pass_pengguna, is_active, status_user, email, cabang_id) FROM stdin;
50c6d67c-d9dd-462a-a118-75ed0b185b14	11dc1faf-2c66-4525-932d-a90e24da8987	aaa	b79f6fe35c28cbb72373b30f726141c7	t	2	admin@gmail.com	\N
00b5acfa-b533-454b-8dfd-e7881edd180f	11dc1faf-2c66-4525-932d-a90e24da8987	admin	74521f341a6473f2bea7fa0ef052e7a8	t	2	\N	UTM
50148d53-e344-41d3-9a79-53fd078b6c5c	42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	nurulrspb	0e96a750cc80abbfbd98ba37f12b9972	t	2	\N	UTM
98281a7b-4d74-4e85-a215-0f8740795588	42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	kasir	e909fb5a829d6824bc4b123c3f0aa6f3	t	2	\N	UTM
c2e3e5ad-717e-4baa-ac15-f80147c1917f	42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	anipano	c5354ba9996a9d5aded57ad54c4b0ae0	t	2	\N	PNR
\.


--
-- TOC entry 5406 (class 0 OID 25037)
-- Dependencies: 237
-- Data for Name: m_prefix_nota; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_prefix_nota (prefix_nota_id, prefix_nota, keterangan) FROM stdin;
\.


--
-- TOC entry 5407 (class 0 OID 25043)
-- Dependencies: 238
-- Data for Name: m_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_produk (produk_id, nama_produk, satuan, stok, harga_beli, harga_jual, kode_produk, golongan_id, minimal_stok, stok_gudang, minimal_stok_gudang, diskon, persentase_keuntungan, is_aktif, last_update) FROM stdin;
edacb471-8c9a-4af6-a518-ab052a9dfb40	mie	pcs	50.00	3000.00	5000.00	202609080001	6c9f2842-7cf5-4715-9830-5e97d6a1801a	0.00	100.00	10.00	0.00	0.00	t	2026-09-08 19:57:22
7e8a956d-cdef-4614-b90f-90ca0b763500	coki	pcs	5.00	5000.00	6000.00	202609080004	6c9f2842-7cf5-4715-9830-5e97d6a1801a	0.00	10.00	2.00	0.00	0.00	t	2026-09-08 21:03:30
941da461-e328-4ab5-8d43-de1fb43ca4d9	beras	karung	10.00	50000.00	100000.00	202609080003	6c9f2842-7cf5-4715-9830-5e97d6a1801a	0.00	268.00	3.00	0.00	0.00	t	2026-09-08 20:59:15
0d27a9e3-052c-4f65-98a5-2524cee1ae67	sarimi	pcs	10.00	3000.00	5000.00	202609080002	6c9f2842-7cf5-4715-9830-5e97d6a1801a	0.00	69.00	2.00	0.00	0.00	t	2026-09-08 20:35:53
\.


--
-- TOC entry 5409 (class 0 OID 25051)
-- Dependencies: 240
-- Data for Name: m_profil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_profil (profil_id, nama_profil, alamat, kota, telepon, email, website, register_id, is_register, hash) FROM stdin;
ced140f5-52f5-4617-b8c0-ebb5cae2c769	KR Software	Jl. Raya Berbah	Yogyakarta	0813 8176 9915	rudi.krsoftware@gmail.com	https://github.com/rudi-krsoftware/open-retail/	\N	f	\N
\.


--
-- TOC entry 5410 (class 0 OID 25057)
-- Dependencies: 241
-- Data for Name: m_provinsi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_provinsi (provinsi_id, nama_provinsi) FROM stdin;
1	Bali
2	Bangka Belitung
3	Banten
4	Bengkulu
5	DI Yogyakarta
6	DKI Jakarta
7	Gorontalo
8	Jambi
9	Jawa Barat
10	Jawa Tengah
11	Jawa Timur
12	Kalimantan Barat
13	Kalimantan Selatan
14	Kalimantan Tengah
15	Kalimantan Timur
16	Kalimantan Utara
17	Kepulauan Riau
18	Lampung
19	Maluku
20	Maluku Utara
21	Nanggroe Aceh Darussalam (NAD)
22	Nusa Tenggara Barat (NTB)
23	Nusa Tenggara Timur (NTT)
24	Papua
25	Papua Barat
26	Riau
27	Sulawesi Barat
28	Sulawesi Selatan
29	Sulawesi Tengah
30	Sulawesi Tenggara
31	Sulawesi Utara
32	Sumatera Barat
33	Sumatera Selatan
34	Sumatera Utara
\.


--
-- TOC entry 5411 (class 0 OID 25062)
-- Dependencies: 242
-- Data for Name: m_provinsi2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_provinsi2 (provinsi_id, nama_provinsi) FROM stdin;
11	Aceh
12	Sumatera Utara
13	Sumatera Barat
14	Riau
15	Jambi
16	Sumatera Selatan
17	Bengkulu
18	Lampung
19	Kepulauan Bangka Belitung
21	Kepulauan Riau
32	Jawa Barat
33	Jawa Tengah
35	Jawa Timur
36	Banten
51	Bali
52	Nusa Tenggara Barat
53	Nusa Tenggara Timur
61	Kalimantan Barat
62	Kalimantan Tengah
63	Kalimantan Selatan
64	Kalimantan Timur
65	Kalimantan Utara
71	Sulawesi Utara
72	Sulawesi Tengah
73	Sulawesi Selatan
74	Sulawesi Tenggara
75	Gorontalo
76	Sulawesi Barat
81	Maluku
82	Maluku Utara
91	Papua Barat
94	Papua
34	DI Yogyakarta
31	DKI Jakarta
\.


--
-- TOC entry 5412 (class 0 OID 25067)
-- Dependencies: 243
-- Data for Name: m_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_role (role_id, nama_role, is_active) FROM stdin;
11dc1faf-2c66-4525-932d-a90e24da8987	Administrator	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	Owner	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	Kasir	t
29656af0-c3f6-44e8-9c74-c3643f38e871	Supervisor	t
\.


--
-- TOC entry 5413 (class 0 OID 25072)
-- Dependencies: 244
-- Data for Name: m_role_privilege; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_role_privilege (role_id, menu_id, grant_id, is_grant) FROM stdin;
11dc1faf-2c66-4525-932d-a90e24da8987	8a8c6d23-963b-4819-819d-b9cdeaad7718	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	fd48562f-9096-4cec-ad9c-37229fc072a3	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	fd48562f-9096-4cec-ad9c-37229fc072a3	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	fd48562f-9096-4cec-ad9c-37229fc072a3	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	fd48562f-9096-4cec-ad9c-37229fc072a3	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	e7be0d85-9f96-4095-be35-1da049028cef	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	e7be0d85-9f96-4095-be35-1da049028cef	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	e7be0d85-9f96-4095-be35-1da049028cef	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	e7be0d85-9f96-4095-be35-1da049028cef	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	a6043b21-18d0-4fcd-9ea9-f146542081d5	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	a6043b21-18d0-4fcd-9ea9-f146542081d5	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	a6043b21-18d0-4fcd-9ea9-f146542081d5	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	a6043b21-18d0-4fcd-9ea9-f146542081d5	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	084488a3-092d-4e8c-8bf2-72dcf90262b4	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	084488a3-092d-4e8c-8bf2-72dcf90262b4	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	084488a3-092d-4e8c-8bf2-72dcf90262b4	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	084488a3-092d-4e8c-8bf2-72dcf90262b4	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	870ec1d3-5b71-47dc-b241-1b0ae933217c	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	870ec1d3-5b71-47dc-b241-1b0ae933217c	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	870ec1d3-5b71-47dc-b241-1b0ae933217c	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	870ec1d3-5b71-47dc-b241-1b0ae933217c	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	b4be7b7c-4587-4af4-af07-fce34df723df	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	b4be7b7c-4587-4af4-af07-fce34df723df	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	b4be7b7c-4587-4af4-af07-fce34df723df	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	b4be7b7c-4587-4af4-af07-fce34df723df	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	99302348-4d3c-48dd-8d67-c422e3061f1c	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	99302348-4d3c-48dd-8d67-c422e3061f1c	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	99302348-4d3c-48dd-8d67-c422e3061f1c	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	99302348-4d3c-48dd-8d67-c422e3061f1c	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	576b9f00-c29d-4c2c-9a6b-5a563344de93	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	576b9f00-c29d-4c2c-9a6b-5a563344de93	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	576b9f00-c29d-4c2c-9a6b-5a563344de93	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	576b9f00-c29d-4c2c-9a6b-5a563344de93	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	08392673-2e61-4266-a6ae-5cb75fdf42e8	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	08392673-2e61-4266-a6ae-5cb75fdf42e8	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	08392673-2e61-4266-a6ae-5cb75fdf42e8	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	08392673-2e61-4266-a6ae-5cb75fdf42e8	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	13b929f3-d349-4686-b803-b350732003c8	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	13b929f3-d349-4686-b803-b350732003c8	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	13b929f3-d349-4686-b803-b350732003c8	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	13b929f3-d349-4686-b803-b350732003c8	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	295f6ddd-b934-4215-8e44-74905efd2273	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	295f6ddd-b934-4215-8e44-74905efd2273	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	295f6ddd-b934-4215-8e44-74905efd2273	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	295f6ddd-b934-4215-8e44-74905efd2273	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	335e115b-8f25-4cad-96cf-22481c98c525	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	335e115b-8f25-4cad-96cf-22481c98c525	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	335e115b-8f25-4cad-96cf-22481c98c525	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	335e115b-8f25-4cad-96cf-22481c98c525	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	b0b538ba-3535-4308-8012-9e2fa0daa0b0	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	b0b538ba-3535-4308-8012-9e2fa0daa0b0	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	b0b538ba-3535-4308-8012-9e2fa0daa0b0	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	b0b538ba-3535-4308-8012-9e2fa0daa0b0	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a114aab-28cc-4655-b676-d08075bae831	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a114aab-28cc-4655-b676-d08075bae831	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a114aab-28cc-4655-b676-d08075bae831	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a114aab-28cc-4655-b676-d08075bae831	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	6a593127-4efb-4d7e-be38-53894c4828d0	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	6a593127-4efb-4d7e-be38-53894c4828d0	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	6a593127-4efb-4d7e-be38-53894c4828d0	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	6a593127-4efb-4d7e-be38-53894c4828d0	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	942cf428-3e36-48d2-8932-7e55cde20b32	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	942cf428-3e36-48d2-8932-7e55cde20b32	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	942cf428-3e36-48d2-8932-7e55cde20b32	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	942cf428-3e36-48d2-8932-7e55cde20b32	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5b99b5c4-91a8-4492-80a2-71cd9b800f00	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5b99b5c4-91a8-4492-80a2-71cd9b800f00	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5b99b5c4-91a8-4492-80a2-71cd9b800f00	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5b99b5c4-91a8-4492-80a2-71cd9b800f00	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	01803718-15d1-4ef4-9574-b9bb161c1638	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	01803718-15d1-4ef4-9574-b9bb161c1638	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	01803718-15d1-4ef4-9574-b9bb161c1638	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	01803718-15d1-4ef4-9574-b9bb161c1638	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	d62d3352-56e7-4802-973e-32d590febdab	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	d62d3352-56e7-4802-973e-32d590febdab	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	d62d3352-56e7-4802-973e-32d590febdab	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	d62d3352-56e7-4802-973e-32d590febdab	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	986182a1-8b33-457b-9151-38676f0f0869	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	986182a1-8b33-457b-9151-38676f0f0869	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	986182a1-8b33-457b-9151-38676f0f0869	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	986182a1-8b33-457b-9151-38676f0f0869	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5c336652-4465-4b62-8de1-dac26fc696b6	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5c336652-4465-4b62-8de1-dac26fc696b6	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5c336652-4465-4b62-8de1-dac26fc696b6	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5c336652-4465-4b62-8de1-dac26fc696b6	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	8c46f173-f586-402d-b54a-ac2e4ba57f1e	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	8c46f173-f586-402d-b54a-ac2e4ba57f1e	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	8c46f173-f586-402d-b54a-ac2e4ba57f1e	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	8c46f173-f586-402d-b54a-ac2e4ba57f1e	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	36aabcfa-60bc-48f5-9af6-30aa7600eb5b	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	0702e90c-cb7c-42a4-a447-478fba5a7443	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	0702e90c-cb7c-42a4-a447-478fba5a7443	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	0702e90c-cb7c-42a4-a447-478fba5a7443	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	0702e90c-cb7c-42a4-a447-478fba5a7443	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	e8f83478-a577-4cff-a06f-8d921f9367c7	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	e8f83478-a577-4cff-a06f-8d921f9367c7	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	e8f83478-a577-4cff-a06f-8d921f9367c7	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	e8f83478-a577-4cff-a06f-8d921f9367c7	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	7cca3d24-3fc3-4c64-b361-78c0c7581920	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	a6043b21-18d0-4fcd-9ea9-f146542081d5	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	a6043b21-18d0-4fcd-9ea9-f146542081d5	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	a6043b21-18d0-4fcd-9ea9-f146542081d5	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	a6043b21-18d0-4fcd-9ea9-f146542081d5	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	084488a3-092d-4e8c-8bf2-72dcf90262b4	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	084488a3-092d-4e8c-8bf2-72dcf90262b4	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	084488a3-092d-4e8c-8bf2-72dcf90262b4	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	084488a3-092d-4e8c-8bf2-72dcf90262b4	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	870ec1d3-5b71-47dc-b241-1b0ae933217c	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	870ec1d3-5b71-47dc-b241-1b0ae933217c	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	870ec1d3-5b71-47dc-b241-1b0ae933217c	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	870ec1d3-5b71-47dc-b241-1b0ae933217c	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b4be7b7c-4587-4af4-af07-fce34df723df	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b4be7b7c-4587-4af4-af07-fce34df723df	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b4be7b7c-4587-4af4-af07-fce34df723df	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b4be7b7c-4587-4af4-af07-fce34df723df	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	99302348-4d3c-48dd-8d67-c422e3061f1c	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	99302348-4d3c-48dd-8d67-c422e3061f1c	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	99302348-4d3c-48dd-8d67-c422e3061f1c	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	99302348-4d3c-48dd-8d67-c422e3061f1c	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	576b9f00-c29d-4c2c-9a6b-5a563344de93	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	576b9f00-c29d-4c2c-9a6b-5a563344de93	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	576b9f00-c29d-4c2c-9a6b-5a563344de93	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	576b9f00-c29d-4c2c-9a6b-5a563344de93	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	08392673-2e61-4266-a6ae-5cb75fdf42e8	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	08392673-2e61-4266-a6ae-5cb75fdf42e8	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	08392673-2e61-4266-a6ae-5cb75fdf42e8	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	08392673-2e61-4266-a6ae-5cb75fdf42e8	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	13b929f3-d349-4686-b803-b350732003c8	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	13b929f3-d349-4686-b803-b350732003c8	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	fd48562f-9096-4cec-ad9c-37229fc072a3	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	fd48562f-9096-4cec-ad9c-37229fc072a3	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e7be0d85-9f96-4095-be35-1da049028cef	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e7be0d85-9f96-4095-be35-1da049028cef	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e7be0d85-9f96-4095-be35-1da049028cef	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e7be0d85-9f96-4095-be35-1da049028cef	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	13b929f3-d349-4686-b803-b350732003c8	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	13b929f3-d349-4686-b803-b350732003c8	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	295f6ddd-b934-4215-8e44-74905efd2273	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	295f6ddd-b934-4215-8e44-74905efd2273	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	295f6ddd-b934-4215-8e44-74905efd2273	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	295f6ddd-b934-4215-8e44-74905efd2273	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	335e115b-8f25-4cad-96cf-22481c98c525	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	335e115b-8f25-4cad-96cf-22481c98c525	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	335e115b-8f25-4cad-96cf-22481c98c525	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	335e115b-8f25-4cad-96cf-22481c98c525	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b0b538ba-3535-4308-8012-9e2fa0daa0b0	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b0b538ba-3535-4308-8012-9e2fa0daa0b0	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b0b538ba-3535-4308-8012-9e2fa0daa0b0	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b0b538ba-3535-4308-8012-9e2fa0daa0b0	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a114aab-28cc-4655-b676-d08075bae831	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a114aab-28cc-4655-b676-d08075bae831	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a114aab-28cc-4655-b676-d08075bae831	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a114aab-28cc-4655-b676-d08075bae831	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6a593127-4efb-4d7e-be38-53894c4828d0	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6a593127-4efb-4d7e-be38-53894c4828d0	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6a593127-4efb-4d7e-be38-53894c4828d0	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6a593127-4efb-4d7e-be38-53894c4828d0	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	942cf428-3e36-48d2-8932-7e55cde20b32	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	942cf428-3e36-48d2-8932-7e55cde20b32	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	942cf428-3e36-48d2-8932-7e55cde20b32	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	942cf428-3e36-48d2-8932-7e55cde20b32	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5b99b5c4-91a8-4492-80a2-71cd9b800f00	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5b99b5c4-91a8-4492-80a2-71cd9b800f00	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5b99b5c4-91a8-4492-80a2-71cd9b800f00	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5b99b5c4-91a8-4492-80a2-71cd9b800f00	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	01803718-15d1-4ef4-9574-b9bb161c1638	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	01803718-15d1-4ef4-9574-b9bb161c1638	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	01803718-15d1-4ef4-9574-b9bb161c1638	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	01803718-15d1-4ef4-9574-b9bb161c1638	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d62d3352-56e7-4802-973e-32d590febdab	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d62d3352-56e7-4802-973e-32d590febdab	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d62d3352-56e7-4802-973e-32d590febdab	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d62d3352-56e7-4802-973e-32d590febdab	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	986182a1-8b33-457b-9151-38676f0f0869	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	986182a1-8b33-457b-9151-38676f0f0869	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	986182a1-8b33-457b-9151-38676f0f0869	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	986182a1-8b33-457b-9151-38676f0f0869	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5c336652-4465-4b62-8de1-dac26fc696b6	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5c336652-4465-4b62-8de1-dac26fc696b6	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5c336652-4465-4b62-8de1-dac26fc696b6	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5c336652-4465-4b62-8de1-dac26fc696b6	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	36aabcfa-60bc-48f5-9af6-30aa7600eb5b	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	0702e90c-cb7c-42a4-a447-478fba5a7443	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	0702e90c-cb7c-42a4-a447-478fba5a7443	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	0702e90c-cb7c-42a4-a447-478fba5a7443	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	0702e90c-cb7c-42a4-a447-478fba5a7443	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e8f83478-a577-4cff-a06f-8d921f9367c7	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e8f83478-a577-4cff-a06f-8d921f9367c7	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e8f83478-a577-4cff-a06f-8d921f9367c7	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e8f83478-a577-4cff-a06f-8d921f9367c7	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a8c6d23-963b-4819-819d-b9cdeaad7718	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	fd48562f-9096-4cec-ad9c-37229fc072a3	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	fd48562f-9096-4cec-ad9c-37229fc072a3	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	fd48562f-9096-4cec-ad9c-37229fc072a3	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	fd48562f-9096-4cec-ad9c-37229fc072a3	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	e7be0d85-9f96-4095-be35-1da049028cef	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	e7be0d85-9f96-4095-be35-1da049028cef	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	e7be0d85-9f96-4095-be35-1da049028cef	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	e7be0d85-9f96-4095-be35-1da049028cef	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	f18fbb6e-bd6f-5d21-fa8d-11923327b436	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	a6043b21-18d0-4fcd-9ea9-f146542081d5	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	a6043b21-18d0-4fcd-9ea9-f146542081d5	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	084488a3-092d-4e8c-8bf2-72dcf90262b4	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	084488a3-092d-4e8c-8bf2-72dcf90262b4	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	084488a3-092d-4e8c-8bf2-72dcf90262b4	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	084488a3-092d-4e8c-8bf2-72dcf90262b4	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	870ec1d3-5b71-47dc-b241-1b0ae933217c	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	870ec1d3-5b71-47dc-b241-1b0ae933217c	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	870ec1d3-5b71-47dc-b241-1b0ae933217c	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	870ec1d3-5b71-47dc-b241-1b0ae933217c	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b4be7b7c-4587-4af4-af07-fce34df723df	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b4be7b7c-4587-4af4-af07-fce34df723df	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b4be7b7c-4587-4af4-af07-fce34df723df	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	99302348-4d3c-48dd-8d67-c422e3061f1c	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	99302348-4d3c-48dd-8d67-c422e3061f1c	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	99302348-4d3c-48dd-8d67-c422e3061f1c	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	99302348-4d3c-48dd-8d67-c422e3061f1c	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	a6043b21-18d0-4fcd-9ea9-f146542081d5	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	948af0c2-5c0d-4887-8d81-4cd42e1b02a0	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e8f83478-a577-4cff-a06f-8d921f9367c7	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	fd48562f-9096-4cec-ad9c-37229fc072a3	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	7c7a2763-ed8b-41a7-a42d-b79233d02e02	0	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	7c7a2763-ed8b-41a7-a42d-b79233d02e02	1	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	7c7a2763-ed8b-41a7-a42d-b79233d02e02	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f18fbb6e-bd6f-5d21-fa8d-11923327b436	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fa7e83ee-9b49-4cda-badd-d68cda7b7a9a	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fd48562f-9096-4cec-ad9c-37229fc072a3	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fd48562f-9096-4cec-ad9c-37229fc072a3	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fd48562f-9096-4cec-ad9c-37229fc072a3	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fd48562f-9096-4cec-ad9c-37229fc072a3	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7c7a2763-ed8b-41a7-a42d-b79233d02e02	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7c7a2763-ed8b-41a7-a42d-b79233d02e02	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7c7a2763-ed8b-41a7-a42d-b79233d02e02	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7c7a2763-ed8b-41a7-a42d-b79233d02e02	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e7be0d85-9f96-4095-be35-1da049028cef	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e7be0d85-9f96-4095-be35-1da049028cef	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e7be0d85-9f96-4095-be35-1da049028cef	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e7be0d85-9f96-4095-be35-1da049028cef	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	f
11dc1faf-2c66-4525-932d-a90e24da8987	0a516b56-ed73-dafe-aaa0-332fadd2f088	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	08392673-2e61-4266-a6ae-5cb75fdf42e8	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	08392673-2e61-4266-a6ae-5cb75fdf42e8	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	08392673-2e61-4266-a6ae-5cb75fdf42e8	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	08392673-2e61-4266-a6ae-5cb75fdf42e8	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	13b929f3-d349-4686-b803-b350732003c8	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f18fbb6e-bd6f-5d21-fa8d-11923327b436	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7cca3d24-3fc3-4c64-b361-78c0c7581920	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f18fbb6e-bd6f-5d21-fa8d-11923327b436	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a8c6d23-963b-4819-819d-b9cdeaad7718	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f18fbb6e-bd6f-5d21-fa8d-11923327b436	0	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f18fbb6e-bd6f-5d21-fa8d-11923327b436	1	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f18fbb6e-bd6f-5d21-fa8d-11923327b436	2	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f18fbb6e-bd6f-5d21-fa8d-11923327b436	3	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a8c6d23-963b-4819-819d-b9cdeaad7718	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	7cca3d24-3fc3-4c64-b361-78c0c7581920	0	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	fa7e83ee-9b49-4cda-badd-d68cda7b7a9a	0	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	fd48562f-9096-4cec-ad9c-37229fc072a3	1	f
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	7c7a2763-ed8b-41a7-a42d-b79233d02e02	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f18fbb6e-bd6f-5d21-fa8d-11923327b436	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	f
11dc1faf-2c66-4525-932d-a90e24da8987	0a516b56-ed73-dafe-aaa0-332fadd2f088	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	0a516b56-ed73-dafe-aaa0-332fadd2f088	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	0a516b56-ed73-dafe-aaa0-332fadd2f088	3	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	13b929f3-d349-4686-b803-b350732003c8	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	13b929f3-d349-4686-b803-b350732003c8	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	13b929f3-d349-4686-b803-b350732003c8	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	295f6ddd-b934-4215-8e44-74905efd2273	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	335e115b-8f25-4cad-96cf-22481c98c525	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b0b538ba-3535-4308-8012-9e2fa0daa0b0	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	6a593127-4efb-4d7e-be38-53894c4828d0	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	ed926af3-61a5-40e7-8975-de78c90eb784	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	a1b976fc-99d3-4b5f-89b5-bc7e7fc4c0d2	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b94a2365-c063-491e-a798-c68dccd2d80b	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	33d081b5-8e4d-424b-a00a-eccf1f1a8809	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	942cf428-3e36-48d2-8932-7e55cde20b32	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5b99b5c4-91a8-4492-80a2-71cd9b800f00	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	01803718-15d1-4ef4-9574-b9bb161c1638	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	948af0c2-5c0d-4887-8d81-4cd42e1b02a0	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	d62d3352-56e7-4802-973e-32d590febdab	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	986182a1-8b33-457b-9151-38676f0f0869	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	65afc8bf-4df2-486a-b878-e77638ae2688	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5c336652-4465-4b62-8de1-dac26fc696b6	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8c46f173-f586-402d-b54a-ac2e4ba57f1e	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	a0c6daf8-b0c8-4e9d-9702-7a2bb781580c	0	f
\.


--
-- TOC entry 5448 (class 0 OID 49219)
-- Dependencies: 279
-- Data for Name: m_role_privilege_backup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_role_privilege_backup (role_id, menu_id, grant_id, is_grant) FROM stdin;
11dc1faf-2c66-4525-932d-a90e24da8987	8a8c6d23-963b-4819-819d-b9cdeaad7718	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	fd48562f-9096-4cec-ad9c-37229fc072a3	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	fd48562f-9096-4cec-ad9c-37229fc072a3	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	fd48562f-9096-4cec-ad9c-37229fc072a3	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	fd48562f-9096-4cec-ad9c-37229fc072a3	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	e7be0d85-9f96-4095-be35-1da049028cef	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	e7be0d85-9f96-4095-be35-1da049028cef	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	e7be0d85-9f96-4095-be35-1da049028cef	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	e7be0d85-9f96-4095-be35-1da049028cef	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	a6043b21-18d0-4fcd-9ea9-f146542081d5	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	a6043b21-18d0-4fcd-9ea9-f146542081d5	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	a6043b21-18d0-4fcd-9ea9-f146542081d5	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	a6043b21-18d0-4fcd-9ea9-f146542081d5	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	084488a3-092d-4e8c-8bf2-72dcf90262b4	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	084488a3-092d-4e8c-8bf2-72dcf90262b4	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	084488a3-092d-4e8c-8bf2-72dcf90262b4	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	084488a3-092d-4e8c-8bf2-72dcf90262b4	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	870ec1d3-5b71-47dc-b241-1b0ae933217c	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	870ec1d3-5b71-47dc-b241-1b0ae933217c	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	870ec1d3-5b71-47dc-b241-1b0ae933217c	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	870ec1d3-5b71-47dc-b241-1b0ae933217c	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	b4be7b7c-4587-4af4-af07-fce34df723df	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	b4be7b7c-4587-4af4-af07-fce34df723df	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	b4be7b7c-4587-4af4-af07-fce34df723df	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	b4be7b7c-4587-4af4-af07-fce34df723df	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	99302348-4d3c-48dd-8d67-c422e3061f1c	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	99302348-4d3c-48dd-8d67-c422e3061f1c	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	99302348-4d3c-48dd-8d67-c422e3061f1c	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	99302348-4d3c-48dd-8d67-c422e3061f1c	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	576b9f00-c29d-4c2c-9a6b-5a563344de93	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	576b9f00-c29d-4c2c-9a6b-5a563344de93	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	576b9f00-c29d-4c2c-9a6b-5a563344de93	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	576b9f00-c29d-4c2c-9a6b-5a563344de93	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	08392673-2e61-4266-a6ae-5cb75fdf42e8	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	08392673-2e61-4266-a6ae-5cb75fdf42e8	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	08392673-2e61-4266-a6ae-5cb75fdf42e8	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	08392673-2e61-4266-a6ae-5cb75fdf42e8	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	13b929f3-d349-4686-b803-b350732003c8	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	13b929f3-d349-4686-b803-b350732003c8	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	13b929f3-d349-4686-b803-b350732003c8	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	13b929f3-d349-4686-b803-b350732003c8	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	295f6ddd-b934-4215-8e44-74905efd2273	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	295f6ddd-b934-4215-8e44-74905efd2273	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	295f6ddd-b934-4215-8e44-74905efd2273	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	295f6ddd-b934-4215-8e44-74905efd2273	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	335e115b-8f25-4cad-96cf-22481c98c525	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	335e115b-8f25-4cad-96cf-22481c98c525	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	335e115b-8f25-4cad-96cf-22481c98c525	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	335e115b-8f25-4cad-96cf-22481c98c525	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	b0b538ba-3535-4308-8012-9e2fa0daa0b0	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	b0b538ba-3535-4308-8012-9e2fa0daa0b0	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	b0b538ba-3535-4308-8012-9e2fa0daa0b0	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	b0b538ba-3535-4308-8012-9e2fa0daa0b0	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a114aab-28cc-4655-b676-d08075bae831	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a114aab-28cc-4655-b676-d08075bae831	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a114aab-28cc-4655-b676-d08075bae831	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5a114aab-28cc-4655-b676-d08075bae831	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	6a593127-4efb-4d7e-be38-53894c4828d0	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	6a593127-4efb-4d7e-be38-53894c4828d0	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	6a593127-4efb-4d7e-be38-53894c4828d0	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	6a593127-4efb-4d7e-be38-53894c4828d0	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	942cf428-3e36-48d2-8932-7e55cde20b32	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	942cf428-3e36-48d2-8932-7e55cde20b32	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	942cf428-3e36-48d2-8932-7e55cde20b32	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	942cf428-3e36-48d2-8932-7e55cde20b32	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5b99b5c4-91a8-4492-80a2-71cd9b800f00	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5b99b5c4-91a8-4492-80a2-71cd9b800f00	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5b99b5c4-91a8-4492-80a2-71cd9b800f00	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5b99b5c4-91a8-4492-80a2-71cd9b800f00	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	01803718-15d1-4ef4-9574-b9bb161c1638	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	01803718-15d1-4ef4-9574-b9bb161c1638	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	01803718-15d1-4ef4-9574-b9bb161c1638	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	01803718-15d1-4ef4-9574-b9bb161c1638	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	d62d3352-56e7-4802-973e-32d590febdab	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	d62d3352-56e7-4802-973e-32d590febdab	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	d62d3352-56e7-4802-973e-32d590febdab	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	d62d3352-56e7-4802-973e-32d590febdab	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	986182a1-8b33-457b-9151-38676f0f0869	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	986182a1-8b33-457b-9151-38676f0f0869	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	986182a1-8b33-457b-9151-38676f0f0869	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	986182a1-8b33-457b-9151-38676f0f0869	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	5c336652-4465-4b62-8de1-dac26fc696b6	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	5c336652-4465-4b62-8de1-dac26fc696b6	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	5c336652-4465-4b62-8de1-dac26fc696b6	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	5c336652-4465-4b62-8de1-dac26fc696b6	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	8c46f173-f586-402d-b54a-ac2e4ba57f1e	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	8c46f173-f586-402d-b54a-ac2e4ba57f1e	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	8c46f173-f586-402d-b54a-ac2e4ba57f1e	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	8c46f173-f586-402d-b54a-ac2e4ba57f1e	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	36aabcfa-60bc-48f5-9af6-30aa7600eb5b	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	0702e90c-cb7c-42a4-a447-478fba5a7443	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	0702e90c-cb7c-42a4-a447-478fba5a7443	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	0702e90c-cb7c-42a4-a447-478fba5a7443	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	0702e90c-cb7c-42a4-a447-478fba5a7443	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	e8f83478-a577-4cff-a06f-8d921f9367c7	0	t
11dc1faf-2c66-4525-932d-a90e24da8987	e8f83478-a577-4cff-a06f-8d921f9367c7	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	e8f83478-a577-4cff-a06f-8d921f9367c7	2	t
11dc1faf-2c66-4525-932d-a90e24da8987	e8f83478-a577-4cff-a06f-8d921f9367c7	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	7cca3d24-3fc3-4c64-b361-78c0c7581920	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	a6043b21-18d0-4fcd-9ea9-f146542081d5	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	a6043b21-18d0-4fcd-9ea9-f146542081d5	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	a6043b21-18d0-4fcd-9ea9-f146542081d5	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	a6043b21-18d0-4fcd-9ea9-f146542081d5	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	084488a3-092d-4e8c-8bf2-72dcf90262b4	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	084488a3-092d-4e8c-8bf2-72dcf90262b4	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	084488a3-092d-4e8c-8bf2-72dcf90262b4	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	084488a3-092d-4e8c-8bf2-72dcf90262b4	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	870ec1d3-5b71-47dc-b241-1b0ae933217c	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	870ec1d3-5b71-47dc-b241-1b0ae933217c	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	870ec1d3-5b71-47dc-b241-1b0ae933217c	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	870ec1d3-5b71-47dc-b241-1b0ae933217c	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b4be7b7c-4587-4af4-af07-fce34df723df	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b4be7b7c-4587-4af4-af07-fce34df723df	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b4be7b7c-4587-4af4-af07-fce34df723df	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b4be7b7c-4587-4af4-af07-fce34df723df	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	99302348-4d3c-48dd-8d67-c422e3061f1c	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	99302348-4d3c-48dd-8d67-c422e3061f1c	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	99302348-4d3c-48dd-8d67-c422e3061f1c	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	99302348-4d3c-48dd-8d67-c422e3061f1c	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	576b9f00-c29d-4c2c-9a6b-5a563344de93	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	576b9f00-c29d-4c2c-9a6b-5a563344de93	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	576b9f00-c29d-4c2c-9a6b-5a563344de93	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	576b9f00-c29d-4c2c-9a6b-5a563344de93	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	08392673-2e61-4266-a6ae-5cb75fdf42e8	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	08392673-2e61-4266-a6ae-5cb75fdf42e8	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	08392673-2e61-4266-a6ae-5cb75fdf42e8	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	08392673-2e61-4266-a6ae-5cb75fdf42e8	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	13b929f3-d349-4686-b803-b350732003c8	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	fd48562f-9096-4cec-ad9c-37229fc072a3	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	fd48562f-9096-4cec-ad9c-37229fc072a3	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	fd48562f-9096-4cec-ad9c-37229fc072a3	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e7be0d85-9f96-4095-be35-1da049028cef	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e7be0d85-9f96-4095-be35-1da049028cef	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e7be0d85-9f96-4095-be35-1da049028cef	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e7be0d85-9f96-4095-be35-1da049028cef	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	13b929f3-d349-4686-b803-b350732003c8	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	13b929f3-d349-4686-b803-b350732003c8	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	13b929f3-d349-4686-b803-b350732003c8	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d5bd3b31-7feb-4c55-9fed-8d67ac18fef4	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	295f6ddd-b934-4215-8e44-74905efd2273	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	295f6ddd-b934-4215-8e44-74905efd2273	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	295f6ddd-b934-4215-8e44-74905efd2273	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	295f6ddd-b934-4215-8e44-74905efd2273	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	335e115b-8f25-4cad-96cf-22481c98c525	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	335e115b-8f25-4cad-96cf-22481c98c525	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	335e115b-8f25-4cad-96cf-22481c98c525	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	335e115b-8f25-4cad-96cf-22481c98c525	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	42a3ffaa-da90-44d8-ae9b-cfcb7a7bdac6	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b0b538ba-3535-4308-8012-9e2fa0daa0b0	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b0b538ba-3535-4308-8012-9e2fa0daa0b0	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b0b538ba-3535-4308-8012-9e2fa0daa0b0	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	b0b538ba-3535-4308-8012-9e2fa0daa0b0	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a4b0eab-0a7b-463a-bcf8-0cca0fbddded	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a114aab-28cc-4655-b676-d08075bae831	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a114aab-28cc-4655-b676-d08075bae831	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a114aab-28cc-4655-b676-d08075bae831	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5a114aab-28cc-4655-b676-d08075bae831	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6a593127-4efb-4d7e-be38-53894c4828d0	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6a593127-4efb-4d7e-be38-53894c4828d0	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6a593127-4efb-4d7e-be38-53894c4828d0	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6a593127-4efb-4d7e-be38-53894c4828d0	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	f87b0496-d9cb-4aef-b9dd-b7fe62ac3a18	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	942cf428-3e36-48d2-8932-7e55cde20b32	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	942cf428-3e36-48d2-8932-7e55cde20b32	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	942cf428-3e36-48d2-8932-7e55cde20b32	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	942cf428-3e36-48d2-8932-7e55cde20b32	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5b99b5c4-91a8-4492-80a2-71cd9b800f00	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5b99b5c4-91a8-4492-80a2-71cd9b800f00	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5b99b5c4-91a8-4492-80a2-71cd9b800f00	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5b99b5c4-91a8-4492-80a2-71cd9b800f00	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	01803718-15d1-4ef4-9574-b9bb161c1638	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	01803718-15d1-4ef4-9574-b9bb161c1638	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	01803718-15d1-4ef4-9574-b9bb161c1638	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	01803718-15d1-4ef4-9574-b9bb161c1638	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	56bd7e72-5e17-4105-bf4d-5f698e94a7fb	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	6f13d6e5-4322-4b4b-8fca-2278b04bd4eb	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d62d3352-56e7-4802-973e-32d590febdab	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d62d3352-56e7-4802-973e-32d590febdab	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d62d3352-56e7-4802-973e-32d590febdab	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	d62d3352-56e7-4802-973e-32d590febdab	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	986182a1-8b33-457b-9151-38676f0f0869	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	986182a1-8b33-457b-9151-38676f0f0869	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	986182a1-8b33-457b-9151-38676f0f0869	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	986182a1-8b33-457b-9151-38676f0f0869	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5c336652-4465-4b62-8de1-dac26fc696b6	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5c336652-4465-4b62-8de1-dac26fc696b6	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5c336652-4465-4b62-8de1-dac26fc696b6	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	5c336652-4465-4b62-8de1-dac26fc696b6	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e9e7ff66-d302-49a3-a9e5-8a02ff87e016	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	8c46f173-f586-402d-b54a-ac2e4ba57f1e	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	36aabcfa-60bc-48f5-9af6-30aa7600eb5b	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	0702e90c-cb7c-42a4-a447-478fba5a7443	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	0702e90c-cb7c-42a4-a447-478fba5a7443	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	0702e90c-cb7c-42a4-a447-478fba5a7443	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	0702e90c-cb7c-42a4-a447-478fba5a7443	3	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e8f83478-a577-4cff-a06f-8d921f9367c7	0	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e8f83478-a577-4cff-a06f-8d921f9367c7	1	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e8f83478-a577-4cff-a06f-8d921f9367c7	2	t
c58ee40a-5ae2-4067-b6ad-8cae9c65913c	e8f83478-a577-4cff-a06f-8d921f9367c7	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a8c6d23-963b-4819-819d-b9cdeaad7718	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	fd48562f-9096-4cec-ad9c-37229fc072a3	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	fd48562f-9096-4cec-ad9c-37229fc072a3	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	fd48562f-9096-4cec-ad9c-37229fc072a3	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	fd48562f-9096-4cec-ad9c-37229fc072a3	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	e7be0d85-9f96-4095-be35-1da049028cef	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	e7be0d85-9f96-4095-be35-1da049028cef	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	e7be0d85-9f96-4095-be35-1da049028cef	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	e7be0d85-9f96-4095-be35-1da049028cef	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	t
29656af0-c3f6-44e8-9c74-c3643f38e871	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	t
11dc1faf-2c66-4525-932d-a90e24da8987	f18fbb6e-bd6f-5d21-fa8d-11923327b436	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	a6043b21-18d0-4fcd-9ea9-f146542081d5	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	a6043b21-18d0-4fcd-9ea9-f146542081d5	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	084488a3-092d-4e8c-8bf2-72dcf90262b4	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	084488a3-092d-4e8c-8bf2-72dcf90262b4	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	084488a3-092d-4e8c-8bf2-72dcf90262b4	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	084488a3-092d-4e8c-8bf2-72dcf90262b4	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	870ec1d3-5b71-47dc-b241-1b0ae933217c	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	870ec1d3-5b71-47dc-b241-1b0ae933217c	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	870ec1d3-5b71-47dc-b241-1b0ae933217c	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	870ec1d3-5b71-47dc-b241-1b0ae933217c	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b4be7b7c-4587-4af4-af07-fce34df723df	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b4be7b7c-4587-4af4-af07-fce34df723df	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b4be7b7c-4587-4af4-af07-fce34df723df	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	99302348-4d3c-48dd-8d67-c422e3061f1c	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	99302348-4d3c-48dd-8d67-c422e3061f1c	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	99302348-4d3c-48dd-8d67-c422e3061f1c	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	99302348-4d3c-48dd-8d67-c422e3061f1c	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	a6043b21-18d0-4fcd-9ea9-f146542081d5	1	t
11dc1faf-2c66-4525-932d-a90e24da8987	948af0c2-5c0d-4887-8d81-4cd42e1b02a0	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e8f83478-a577-4cff-a06f-8d921f9367c7	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a0ba72f-67d2-481f-9e10-a188f09effa5	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7cca3d24-3fc3-4c64-b361-78c0c7581920	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fa7e83ee-9b49-4cda-badd-d68cda7b7a9a	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e7be0d85-9f96-4095-be35-1da049028cef	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e7be0d85-9f96-4095-be35-1da049028cef	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b7ade8cc-22aa-43c8-be9c-af6cb71d11a6	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f18fbb6e-bd6f-5d21-fa8d-11923327b436	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f18fbb6e-bd6f-5d21-fa8d-11923327b436	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f18fbb6e-bd6f-5d21-fa8d-11923327b436	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	f18fbb6e-bd6f-5d21-fa8d-11923327b436	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a8c6d23-963b-4819-819d-b9cdeaad7718	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a8c6d23-963b-4819-819d-b9cdeaad7718	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a8c6d23-963b-4819-819d-b9cdeaad7718	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a8c6d23-963b-4819-819d-b9cdeaad7718	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a0ba72f-67d2-481f-9e10-a188f09effa5	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a0ba72f-67d2-481f-9e10-a188f09effa5	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	8a0ba72f-67d2-481f-9e10-a188f09effa5	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	95e9e230-c4f3-4fbc-9652-78cf4155d7ea	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fd48562f-9096-4cec-ad9c-37229fc072a3	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fd48562f-9096-4cec-ad9c-37229fc072a3	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fd48562f-9096-4cec-ad9c-37229fc072a3	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	fd48562f-9096-4cec-ad9c-37229fc072a3	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	5ab9c82d-a116-4032-8891-cbfb7b71b8e3	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7c7a2763-ed8b-41a7-a42d-b79233d02e02	0	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7c7a2763-ed8b-41a7-a42d-b79233d02e02	1	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7c7a2763-ed8b-41a7-a42d-b79233d02e02	2	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	7c7a2763-ed8b-41a7-a42d-b79233d02e02	3	f
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e7be0d85-9f96-4095-be35-1da049028cef	0	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	e7be0d85-9f96-4095-be35-1da049028cef	1	t
42d0a7b9-2b1a-4ad7-b6ad-b7c8b65ef04a	b52e8eac-3bf6-4ebf-95a0-46ab9e7b0888	1	f
\.


--
-- TOC entry 5414 (class 0 OID 25077)
-- Dependencies: 245
-- Data for Name: m_setting_aplikasi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_setting_aplikasi (setting_aplikasi_id, is_update_harga_jual_master_produk, is_stok_produk_boleh_minus, is_fokus_input_kolom_jumlah, is_tampilkan_keterangan_tambahan_item_jual, keterangan_tambahan_item_jual) FROM stdin;
1ef7cbcb-bf73-44be-aad2-b9d8e1b1a178	f	t	f	f	Keterangan
\.


--
-- TOC entry 5415 (class 0 OID 25082)
-- Dependencies: 246
-- Data for Name: m_shift; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_shift (shift_id, nama_shift, jam_mulai, jam_selesai, is_active) FROM stdin;
id-shift-pagi                       	SHIFT PAGI	2026-01-01 07:00:00	2026-01-01 15:00:00	t
id-shift-sore                       	SHIFT SORE	2026-01-01 15:00:00	2026-01-01 22:00:00	t
id-shift-malam                      	SHIFT MALAM	2026-01-01 22:00:00	2026-01-02 07:00:00	t
\.


--
-- TOC entry 5416 (class 0 OID 25087)
-- Dependencies: 247
-- Data for Name: m_supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.m_supplier (supplier_id, nama_supplier, alamat, kontak, telepon, total_hutang, total_pembayaran_hutang) FROM stdin;
17fe5f26-7128-4518-8559-087e58849e29	abc	balikpapan			10000000.00	0.00
16e582d7-5283-41d3-9c33-7158fe2778d1	ANUGARAH SUMBER GEMILANG	BALIKPAPAN			0.00	0.00
25247549-3e98-4da0-b639-e67b4705b2b3	BITA				0.00	0.00
750affbe-a84c-4a16-b5c0-d576bb94d20d	BORNEO MANDIRI				0.00	0.00
44e7a0f0-ce13-43da-a031-70e215e5f626	DAPUR RSPB				0.00	0.00
ff235581-6b7e-4be7-a76f-ec833528466a	KOPKAR				0.00	0.00
b7c3309f-3758-483b-b5fc-bddce7a8e55d	MPEK MPEK BONTANG	BALIKPAPAN			0.00	0.00
6c79da0a-01db-4f61-b3c6-62ac9f47eb69	PT. ELANG UTAMA KARYA	JL. JEND SUDIRMAN NO. 423 RT.026			0.00	0.00
41e48791-a37f-4200-a230-c54c00162e6f	PURANA PARASINDO	JL IR SUTAMI			0.00	0.00
fdf371a4-e55b-4dc8-a155-e64e14259130	kripik usus nenek				0.00	0.00
e30fa861-4515-4fa1-9ff9-067c3e26bfe0	NK LIL MUHIBBIN				0.00	0.00
ec9bc7cf-7842-4efa-8471-faff231f3a48	PT. CIPTA NIAGA SEMESTA				0.00	0.00
887bccec-070f-422e-9e6e-6783f6e17c05	PT HAS JAYA SENTOSA				0.00	0.00
93fde116-11bb-4f64-8339-fd5596eef20a	KETUPAT				0.00	0.00
c788bf4b-5443-4924-a1e5-602e53c07a4a	DAPUR ENGGOM				0.00	0.00
6a79d40b-5e5f-4f58-8cdd-43e7db117e0c	DAPOER 77				0.00	0.00
d4eaf0f3-cb2b-4e8f-9694-5ec96ae2bfdc	ccod balikpapan				0.00	0.00
bbe8acb5-5bac-4b7a-a752-b31c8a942bd3	nery's cake				0.00	0.00
dc930db8-c38b-43ad-8d63-50c256ab917c	INDOJAYAABADI				0.00	0.00
f6d7dfa3-f149-42d9-bda4-4bc864b61e58	BU PHIA				0.00	0.00
8e1d7aeb-91a9-4567-ab90-a6d2b8c27ad7	RUMAH TEDUH	RUMAH TEDUH			0.00	0.00
da962934-ac4d-46c5-a1ca-d3ef222fbb7d	SNACK FATIH				0.00	0.00
8c25688c-a5a9-431d-b46d-c2d4a1168e76	MAITREYA'S KITCHEN				0.00	0.00
47395be9-1813-46bd-963e-a4d69b8f69a4	DAFFZ.PARFUME				0.00	0.00
7b083656-1e53-43ba-a56a-5eff41321cf4	BIDAN ELY	BALIKPAPAN			0.00	0.00
2fe06b76-a0c2-4c49-aee0-481a0cbc99e4	pelita				0.00	0.00
4fd95fd1-fd8e-46cc-b4db-bd4933173481	UD PELITA INDAH				0.00	0.00
9357830a-a1de-4e6a-91d1-e00a20a75128	UMMU DAF				0.00	0.00
5ac9b540-5815-4797-89e8-0fbbd948928e	JM SNACK				0.00	0.00
f175831e-4713-40af-9221-dec038029f7a	PT. FASTRATA BUANA	JL. PROJAKAL KM.5,5 RT 31 NO. 168, KOTA BALIKPAPAN			0.00	0.00
1605cea7-7a26-4f0f-ba2e-247aebe2404c	TUNAS MEGA KARUNIA				0.00	0.00
6305dce1-e581-41b4-91f1-a151949040b9	MEGA JAYA				0.00	0.00
cef0ef8c-e34d-45c0-be28-b2e34386f857	RISKA FLOWERS				0.00	0.00
e882781d-99f6-4f1d-ae16-7342afff1e9f	PT.BONTING DZAKWANIFOOD				0.00	0.00
71d9d017-ae0e-43e4-9b4a-c74944955e5a	INDOGROSIR				0.00	0.00
6f903aac-7b70-4933-8d07-7880d1a292a8	PT. NIAGAMAS ELOK LESTARI	JL INDRAKILA NO.50 RT.56 GUNUNG SAMARINDA BARU			0.00	0.00
b90f6741-d811-4741-a372-8e337779d091	ABC	BALIKPAPAN			0.00	0.00
3d02ae3d-c50f-4950-9812-a89bda7bd277	ABIMANYU	BALIKPAPAN			0.00	0.00
74596aed-9d45-4637-bb7a-a35ae44635e1	AGAM	BALIKPAPAN			0.00	0.00
738eb0bd-ce7a-4cb8-a609-f92fc1a07fee	ALAKANA	BALIKPAPAN			0.00	0.00
16598b61-ebab-4126-89bc-7dcca28b087e	ALHAQQ FROZEN	BALIKPAPAN			0.00	0.00
a4d3f715-0afe-4730-a6d5-85f38169cc35	AMPLANG BANDENG MAYA	BALIKPAPAN			0.00	0.00
c20f21c9-70cd-4423-b319-0075de8c77f8	ANERA SNACK	BALIKPAPAN			0.00	0.00
de10227d-a2db-4163-b460-c5deba6531eb	ANITA ANACE	BALIKPAPAN			0.00	0.00
38cc63f6-721d-45e8-a015-01e7f8e7eea6	ARAKAY FOOD	BALIKPAPAN			0.00	0.00
e84c80fc-d6f6-42b3-8ece-5cb3f320decd	BAITI	BALIKPAPAN			0.00	0.00
0bab9dda-a43f-4f44-a28f-bac2fdc39e94	BANANA ROSE	BALIKPAPAN			0.00	0.00
cccc665d-9cfa-44c8-94c5-1cbe9ce4f759	BARRA'S KITCHEN	BALIKPAPAN			0.00	0.00
6006bdfe-2382-40ac-bae4-72c02b383942	BAWANG GORENG	BALIKPAPAN			0.00	0.00
9c9aa472-c18f-4cf3-885d-9c56df687c98	BERKAT ABADI	BALIKPAPAN			0.00	0.00
d617a484-55c6-4bef-9401-3de19a589add	BIDAN NISSA PIAH	BALIKPAPAN			0.00	0.00
3dd5060a-12bf-4066-a3f3-42857a5faefb	BINTANG YASA MAKMUR ANUGRAH	BALIKPAPAN			0.00	0.00
6fe35e30-bde0-4267-861b-1fc86c097618	BOLEN	BALIKPAPAN			0.00	0.00
37d54b3a-295f-4b5f-b4ba-fa93d2ed93d7	BONDY	BALIKPAPAN			0.00	0.00
9c6f75b8-a1d4-492f-9c40-e8428bae8fbb	BONLES	BALIKPAPAN			0.00	0.00
a065b92c-dbff-4f70-a0e3-f208b97635a4	BORNEO SNACK	BALIKPAPAN			0.00	0.00
c604de18-5f34-4b4e-815c-ed17ed625537	BROWNIES ANDY ARY	BALIKPAPAN			0.00	0.00
77e9e7f3-821c-4997-9066-30629df74d7f	BU FATMAWATI	BALIKPAPAN			0.00	0.00
c43c4542-cdaa-4eac-9920-8255954d08b4	BU ITA	BALIKPAPAN			0.00	0.00
4a5280e6-95ae-404b-b24a-d92e65926dc9	BU TARI	BALIKPAPAN			0.00	0.00
7bb7a6ed-8083-4efc-ae6c-4bea35e3b13d	BUKET BUNGA	BALIKPAPAN			0.00	0.00
c96e832a-6778-4a2b-957a-617080978aaa	BUKET SNACK	BALIKPAPAN			0.00	0.00
f987111b-3e23-42d5-a1a3-5574e7a3b2c9	BULOK	BALIKPAPAN			0.00	0.00
81ba4995-3c1c-4f63-b573-5f6cee70d377	BUMBU RUJAK KALIASEM	BALIKPAPAN			0.00	0.00
ac47c3eb-891a-4a34-8b8f-5a18bee5cb43	BUNINA	BALIKPAPAN			0.00	0.00
5a85b971-429a-4e42-9d7e-66b52a2abbf5	CAHAYA SETIA UTAMA	BALIKPAPAN			0.00	0.00
fa572124-794a-4066-8f7a-ea92a318c422	CAMILAN BORNEO	BALIKPAPAN			0.00	0.00
cdc7f46f-859d-4802-9996-3bcc22435a9b	CAMILAN BUNDA SHIREN	BALIKPAPAN			0.00	0.00
46daa1b4-1729-4ee9-b4cc-871a0eb32580	CIMI CIMI APRIL	BALIKPAPAN			0.00	0.00
14d8b7ff-dddf-4284-8418-ef3e5a6b77bd	CV ANUGRAH JAYA MANDIRI	BALIKPAPAN			0.00	0.00
cca96f96-b0de-43cd-9d39-cb67fe22f5e0	CV CITRA UTAMA	BALIKPAPAN			0.00	0.00
db3efd2b-ac49-4c32-895a-96fa75a13a5c	CV EVA JAYA BALIKPAPAN	BALIKPAPAN			0.00	0.00
4e7739ea-9152-460c-9ec3-cbea45d89b6c	CV F & J JAYA	BALIKPAPAN			0.00	0.00
2305a17d-265c-452a-8db2-3169f47c13be	CV F & J JAYA	BALIKPAPAN			0.00	0.00
65547128-3adc-4c1e-84ce-5c071dcd30b9	CV HASIL JAYA	BALIKPAPAN			0.00	0.00
beed76d0-1b2a-4942-95cf-85d02391e06c	CV INDAH ANUGERAH SEJAHTERA	BALIKPAPAN			0.00	0.00
b639ebd1-9e6f-43d8-9386-c928d9d56871	CV INDO JAYA ABADI	BALIKPAPAN			0.00	0.00
a1ab3bbb-f243-477c-8d75-b75632dc7236	CV LINTANG ANUGRAH	BALIKPAPAN			0.00	0.00
c6fb87d8-2884-4033-bcf9-4eb16ea4e24e	CV SAMBERS GLOBAL SENTOSA	BALIKPAPAN			0.00	0.00
b86e849b-a65e-49da-991a-543691a36bf7	CV SURYA SAKTI	BALIKPAPAN			0.00	0.00
7f729abb-607a-4c57-80f6-032b9883a73b	CV SWEET SUKSES MAKMUR	BALIKPAPAN			0.00	0.00
5320d5c8-8cb0-435c-bc55-6463a986c663	CV WINNING MULIA	BALIKPAPAN			0.00	0.00
59e027da-c9d2-4f59-83d7-1fc69b3ecfd8	CV.BANJAR PUTERA MANDIRI	BALIKPAPAN			0.00	0.00
92e76b6d-a0c7-4f61-8b65-0e53375fccf7	CV.BINTANG BORNEO	BALIKPAPAN			0.00	0.00
1a5a1d05-4175-4968-9233-2807eeb38211	CV.SEMERU JAYA ABADI	BALIKPAPAN			0.00	0.00
2f54b232-2508-4922-8bdb-0056da15505c	D & D	BALIKPAPAN			0.00	0.00
fc134755-43e6-4152-8289-9f54aa3da289	DAPUR KEYSHA	BALIKPAPAN			0.00	0.00
e59db29a-da79-4916-b7ab-26115694463b	DAPUR MAKCIR	BALIKPAPAN			0.00	0.00
1bff576f-8ed0-428a-8b83-ae169bcb1ce3	DAPUR RABBANI	BALIKPAPAN			0.00	0.00
7b8c6a0d-520d-4634-9717-62fec60cdab2	DEJA BREW COFFEE	BALIKPAPAN			0.00	0.00
64545234-88bb-4b95-a8d1-fa305b821074	DIKROMO SRI REJEKI	BALIKPAPAN			0.00	0.00
af6bb445-8c4d-4798-8e74-f332cbb94faa	DINDA FOOD	BALIKPAPAN			0.00	0.00
d9d1b856-1747-4a78-9bce-f7a53c23cba5	DINI	BALIKPAPAN			0.00	0.00
8ab9c8e8-3bb6-4948-a2b8-7b5bb1d6b664	DOKTER ROTI	BALIKPAPAN			0.00	0.00
601fb134-70cc-451e-ab9e-5c49e679c1ab	DR SILVIA TARIGAN	BALIKPAPAN			0.00	0.00
de817968-b2c6-4bd4-868b-6d4aa30e0317	EDRUSYA	BALIKPAPAN			0.00	0.00
fa7f8023-1282-4983-aeb3-17800569b139	EKA GELANG/STREPHONE	BALIKPAPAN			0.00	0.00
d5f2d557-083e-44eb-b458-bb34d175d8b1	EMPING	BALIKPAPAN			0.00	0.00
0b65a182-6339-43b7-88a2-3f5793b6035a	ESTEEM SUPPLIES	BALIKPAPAN			0.00	0.00
e8e6c70b-1670-487e-b78b-ad303557b349	ESTHER CAKE	BALIKPAPAN			0.00	0.00
c3b069a9-05bf-4a69-ae23-b02684757ecc	EVI	BALIKPAPAN			0.00	0.00
2eca73cc-05ea-49ed-bb92-3b2a52ad9116	FOOD STALL	BALIKPAPAN			0.00	0.00
e7fe91c8-4f0f-482d-81df-f5e4e15ec177	GRIYA TAHU	BALIKPAPAN			0.00	0.00
ed9ee985-8fe5-43d8-a62b-e7fd33a56ce6	GUNUNG BANGUN REZEKI	BALIKPAPAN			0.00	0.00
74070c47-db43-4093-9c88-37cbd51bf783	GUNUNG MAS	BALIKPAPAN			0.00	0.00
a3831bc8-f0c7-4293-ac1f-b3734079864b	HAFOOD ZA	BALIKPAPAN			0.00	0.00
a2b652bc-369d-462a-90b8-1fcd8520c2fa	HAJI SIAM	BALIKPAPAN			0.00	0.00
6f7619c3-5948-4b8d-8946-1782d5f10715	HARTI KREZZ	BALIKPAPAN			0.00	0.00
dfd0f28a-c124-4c85-8cda-8ce961a6bc9d	HOME MADE	BALIKPAPAN			0.00	0.00
02ef7802-83ee-4b03-b0da-a8bc12cc23ca	IBU NORA	BALIKPAPAN			0.00	0.00
e59af265-2a6c-4e1f-9f2d-68d895bc5b73	IMEY SNACK	BALIKPAPAN			0.00	0.00
27082a03-636d-445e-b1fc-0a4cfe3b30f8	ISTANA INDAH	BALIKPAPAN			0.00	0.00
b9fb74c9-4a31-462f-b02d-bde12721c329	ISTANA MADU	BALIKPAPAN			0.00	0.00
1ade95c0-e7f1-47a2-b9b3-1373b2bd7778	ISTIGHARA TULISAN	BALIKPAPAN			0.00	0.00
fa4f575f-9b33-48ce-bd94-05b0cf6138c4	JAYA MAKMUR ( PLASTIK )	BALIKPAPAN			0.00	0.00
2b7174dc-452c-4c0a-8c65-5742b72f1b4d	JAYA MULIA RAYA	BALIKPAPAN			0.00	0.00
a655aa47-77b0-4e87-b134-27e63e7f5035	JAYA RASA	BALIKPAPAN			0.00	0.00
4f6f0f0e-093d-4a71-a8a5-9ad32426d874	KACANG ANDRY	BALIKPAPAN			0.00	0.00
b0085227-a566-4717-8a47-34fcf30e197e	KACANG SEVENT	BALIKPAPAN			0.00	0.00
34738962-4be9-4651-bcaa-25c51906376f	KENTANG KERING	BALIKPAPAN			0.00	0.00
6badddd7-11e8-45e7-b09e-9de24f143248	KERIPIK TEMPE WANI	BALIKPAPAN			0.00	0.00
b8eab984-8271-499e-a65d-b9004956ef3a	KEVIN ROTI	BALIKPAPAN			0.00	0.00
08fd3499-7909-462b-bd41-989bff26179a	KOPI SUSU ANDI	BALIKPAPAN			0.00	0.00
f8340e50-cc48-4559-8b19-c652543fe167	KOPKAR PATRA MEDIKA	BALIKPAPAN			0.00	0.00
e6203bb8-d9c9-4da9-bef6-bbcba455eaee	KRIPIK USUS NENEK	BALIKPAPAN			0.00	0.00
21693c78-e0d8-4615-a84d-16e21020d3e2	KUE MELLENIUM	BALIKPAPAN			0.00	0.00
96c46c31-6e59-450a-9396-efdc0b20ce7f	KUE REMBOELAN	BALIKPAPAN			0.00	0.00
2f9e3381-4a6e-42ed-9108-7d88de9dafee	LALULI BERKAH MULIA	BALIKPAPAN			0.00	0.00
991c9b72-e5f6-4337-a945-4c829146f1a6	LIDAH SAPI	BALIKPAPAN			0.00	0.00
fa30fe55-b74e-43c5-b7c0-0d9cc4f4f958	LISNA	BALIKPAPAN			0.00	0.00
ee78fb0e-e1eb-429a-96e8-9b45aab3c688	MADU HITAM ASLI	BALIKPAPAN			0.00	0.00
8f0aadc9-3d7d-493a-b160-a626b02c2899	MAK MUS	BALIKPAPAN			0.00	0.00
3cc69f71-572b-410a-a199-8e5e92d4d4c9	MAMA MIA	BALIKPAPAN			0.00	0.00
2bb42c38-7f99-455b-a83d-8f40d7f622b7	MBA IKA	BALIKPAPAN			0.00	0.00
42f3a449-866b-434b-aa8c-d84417ce763d	MEGA	BALIKPAPAN			0.00	0.00
3964e5a7-bd06-48c7-b733-40c6b28173a3	MIE YAMIN MERRY	BALIKPAPAN			0.00	0.00
6e5c732d-eb53-492e-b210-419c2fa8b69d	MILLENIUM	BALIKPAPAN			0.00	0.00
f1ab356c-3e5d-4224-99b8-1b05ea83c218	MITRA ANANDA	BALIKPAPAN			0.00	0.00
e54c751f-b001-4934-8dde-9f832e73185b	MYSKINLAB SKINCARE	BALIKPAPAN			0.00	0.00
2b0308ca-eb55-427b-af09-e0e9355c5d9c	NASI KEPAL ANA	BALIKPAPAN			0.00	0.00
8242f065-673a-4b4e-bdc0-c16b5c7f9f78	NERS SNACK	BALIKPAPAN			0.00	0.00
f28f83b6-9183-4630-bf56-249d0a03d601	NITIYA	BALIKPAPAN			0.00	0.00
0d9c0cf0-2b71-4048-82ef-a5de93bde6da	NL LEMON	BALIKPAPAN			0.00	0.00
b923af04-65e6-49d5-ab17-8ad82f93a413	NU SKIN	BALIKPAPAN			0.00	0.00
dac52f1b-e14d-4654-8657-addac71388f3	OEMAH NASTAR	BALIKPAPAN			0.00	0.00
3dde74c2-910a-4e2a-8607-9e3bdb5e5d5f	OM CIHUY	BALIKPAPAN			0.00	0.00
9205bfc0-adb3-40d6-a256-debd8e36c692	PACKPACKER	BALIKPAPAN			0.00	0.00
70bef3b4-9504-4673-bdbd-9f05ce6604ea	PAK HAJI	BALIKPAPAN			0.00	0.00
46ff34c2-08ff-4e0f-81d6-77d2f2507aab	PATRA MEDIKA	BALIKPAPAN			0.00	0.00
9e76ff1f-3b88-4f49-961e-938df3cf78aa	PAWON AMI	BALIKPAPAN			0.00	0.00
d7c02d08-a0d7-471e-8059-9a8b09ed8d84	PEMPEK ZUBAER	BALIKPAPAN			0.00	0.00
347e0ce6-3e21-436c-8042-1dd8ea10aa56	PERDANA GROSIR	BALIKPAPAN			0.00	0.00
e9c26066-25c8-4ac7-80ee-ec812efedc52	PORE JEKA	BALIKPAPAN			0.00	0.00
4ba80554-4d61-47de-8134-6bc2ffe4ed4d	PT	BALIKPAPAN			0.00	0.00
2c660340-692a-44b9-8863-159bb9d7582d	PT AGRINDO MULIA PERSADA	BALIKPAPAN			0.00	0.00
559ccfe4-ba27-4cc9-991a-8be83dc9c4ed	PT ANUGRAH ARGON MEDIKA	BALIKPAPAN			0.00	0.00
89841a1a-2a40-4ef1-bb87-c306ba71d882	PT ANUGRAH CAHYADI	BALIKPAPAN			0.00	0.00
01dc0e60-aeb6-4d28-b828-bbb1c33b9dcd	PT ANUGRAH JAYA MANDIRI	BALIKPAPAN			0.00	0.00
c3ced383-c4e9-46af-b6b5-746e10b369aa	PT APL	BALIKPAPAN			0.00	0.00
6ecd1074-7d31-4f4e-80ac-042aa9e220a1	PT ARTA DWITUNGGAL ABADI	BALIKPAPAN			0.00	0.00
1d12118a-82eb-4f5b-98c7-6f97c5cabcef	PT BARU INDAH	BALIKPAPAN			0.00	0.00
e2f381e2-f905-4e2c-96c5-f1065d330922	PT BELITANG PANEN RAYA	BALIKPAPAN			0.00	0.00
562dd88e-f7f0-42f7-b4be-f0f6dae5b864	PT BINA SAN PRIMA	BALIKPAPAN			0.00	0.00
acf3f60e-728a-43f1-9241-5ce61f2b02d0	PT BINTANGYASA NIAGATAMA	BALIKPAPAN			0.00	0.00
71b013e2-1197-49fd-9a60-ff797eccb356	PT BORNEO INDAH FOKUS	BALIKPAPAN			0.00	0.00
3473254b-ee22-4eda-8320-80179dc59f62	PT BORNEO SUKSES RAYA KALTIM	BALIKPAPAN			0.00	0.00
ce3b9022-fe16-46cf-9ec7-197abcbf0c72	PT BUMI CIPTA RASA	BALIKPAPAN			0.00	0.00
4b6eec2c-7038-43f8-ae0b-9a1a091ec308	PT CAHAYA SETIA UTAMA	BALIKPAPAN			0.00	0.00
7cc62f02-113f-4368-ab64-5a557e82113c	PT CHINTIA AGUNG PRATAMA	BALIKPAPAN			0.00	0.00
eed65e4b-ad23-4ef8-b912-d5f770d0d55e	PT CITRA SURYA PRATAMA	BALIKPAPAN			0.00	0.00
789c58d1-b4cc-4cc4-a006-d87f6a241b61	PT DELTA ANUGRAH SEJATI	BALIKPAPAN			0.00	0.00
57325d97-a67f-425a-b237-8c791e5cfb0b	PT DIFUSI GOLDEN UTAMA	BALIKPAPAN			0.00	0.00
1e08fd27-2743-43ff-92da-53c5e210eda7	PT DOCARE LARAS	BALIKPAPAN			0.00	0.00
27cde5d3-f84d-427c-8534-017040f23ced	PT EAST INDO FAIR TRADING	BALIKPAPAN			0.00	0.00
3107dd18-9e17-4142-91fa-c47cc2e59153	PT EMPAT PUTRA PETIR	BALIKPAPAN			0.00	0.00
5232812f-0635-4788-aa3d-5f7f23c30162	PT ENSEVAL PUTRA MEGANTARA Tbk	BALIKPAPAN			0.00	0.00
b1e79eca-9357-4076-83d0-a701941ef63e	PT FERTOMULIA PRATAMA	BALIKPAPAN			0.00	0.00
9771a19c-5682-4d9c-bb90-b4a523bdc7f0	PT GONUSA PRIMA DISTRIBUSI	BALIKPAPAN			0.00	0.00
c3d0d5a6-708a-4593-b962-fb63f327b711	PT GUNA JAYA NUSANTARA	BALIKPAPAN			0.00	0.00
6e816d99-1c0f-48cf-8622-71d9fe05b95f	PT JEFRINDO EKAPUTRA	BALIKPAPAN			0.00	0.00
d871c54a-6911-48e1-9408-27d87f12967d	PT KARYA PRIMA JAYA	BALIKPAPAN			0.00	0.00
8c0cdb5e-b7b8-4b6d-93b2-c97ea5a6760b	PT KUMALA NIAGATAMA	BALIKPAPAN			0.00	0.00
6871a177-f539-45ba-95de-60c6e33e0995	PT LAUT TIMUR ARDIPRIMA	BALIKPAPAN			0.00	0.00
4e7d6e0c-3f81-4d78-9f54-9bafa9d38822	PT MAKMUR LINTAS BENUA	BALIKPAPAN			0.00	0.00
913b81a0-717e-432f-a105-41d9de5986ab	PT MARGA NUSANTARA JAYA	BALIKPAPAN			0.00	0.00
b70f8730-6c65-4059-aefa-c8972a6712bd	PT MASUYA DISTRA SENTOSA	BALIKPAPAN			0.00	0.00
28dcff83-a57f-4452-b0ae-329ef5de7017	PT OLIVER BAYI ANDALAN	BALIKPAPAN			0.00	0.00
c65477c5-d88e-4bcc-90f9-11b210ef5781	PT PAMBUDI RAYA INDONESIA	BALIKPAPAN			0.00	0.00
48090b43-8eac-4ff7-b7f2-74d45d59f08e	PT PENTA VALENT TBK	BALIKPAPAN			0.00	0.00
33fa0558-423b-46cc-a947-dfe5d9cbd37d	PT PINUS MERAH ABADI	BALIKPAPAN			0.00	0.00
51bd088f-279e-4069-9615-4793a5ca818a	PT PUJI SURYA INDAH	BALIKPAPAN			0.00	0.00
85cd0977-b439-447d-b74a-1d65991a880a	PT PURANA PARASINDO	BALIKPAPAN			0.00	0.00
ae072e77-e4d1-4002-ab83-79f0548506d3	PT RICKY PUTRA GLOBALINDO	BALIKPAPAN			0.00	0.00
73dd2298-7964-424b-b7c2-bbf51c87ad99	PT SINAR NIAGA SEJAHTERA	BALIKPAPAN			0.00	0.00
11d44f76-bac3-4251-b90b-7f879da5b11a	PT SINAR SURYA WIJAYA RAYA	BALIKPAPAN			0.00	0.00
83799dd8-f482-4695-a0c0-473b19274051	PT SINAR TERANG BALIKPAPAN	BALIKPAPAN			0.00	0.00
a752bd7b-769b-4326-81e8-dcfff826a72e	PT SINARMAS DISTRIBUSI NUSANTARA	BALIKPAPAN			0.00	0.00
1a94097f-5901-41e7-b9fa-f9c5119af70b	PT SUKANDA JAYA	BALIKPAPAN			0.00	0.00
5aa55211-ca03-43ed-9e42-f5793060f691	PT SUNGAI BUDIK ROSEBRAND	BALIKPAPAN			0.00	0.00
dcee7d03-be14-4c2c-8e39-54a03f5993e1	PT SURAINDA PANJIJAYA	BALIKPAPAN			0.00	0.00
c05b33e3-4b0a-43a8-aa7e-d24208d9d0e2	PT SURYA ABADI KENCANA	BALIKPAPAN			0.00	0.00
dc8edc84-65a1-4074-8a31-463bdab8c4ea	PT SURYA DAMAI SENTOSA	BALIKPAPAN			0.00	0.00
4af8791d-511e-41d9-bde6-64289f5be8ec	PT TEMPO	BALIKPAPAN			0.00	0.00
34c8c051-8e44-4c58-ba8e-60fe39e5331f	PT TIGARAKSA SATRIA	BALIKPAPAN			0.00	0.00
b2ae5d5f-2ff0-49fb-bd39-ac63ca402614	PT TIRTA HASTA KHENCANA	BALIKPAPAN			0.00	0.00
0d623fe4-d726-414d-b67e-7f790148f5b7	PT TRIJAYA ADHIRAJA ABADI	BALIKPAPAN			0.00	0.00
30a72a2c-0765-4ac2-ba43-67ab1946641f	PT WIRA EKA PERSADATAMA	BALIKPAPAN			0.00	0.00
645feb99-998e-47e0-93a5-fd38f4a73c94	PT.GALAKSI MAS	BALIKPAPAN			0.00	0.00
603c9b1f-1f10-41f9-834a-aae4f59341a9	PT.INDOMARCO ADI PRIMA	BALIKPAPAN			0.00	0.00
681705e9-c426-4db5-a70b-3dbf0d09e3d0	PT.INTERFOOD SUKSES JASINDO	BALIKPAPAN			0.00	0.00
72e071aa-9058-47af-92b9-ecc82f0db876	PT.KARYA PRIMA JAYA	BALIKPAPAN			0.00	0.00
e8501123-7baa-460d-9774-f482a369c56d	PT.SINAR TERANG BALIKPAPAN	BALIKPAPAN			0.00	0.00
c14be140-8ee7-455b-b4c5-d578e983a8ef	PT.UJUNG PANDANG PERKASA	BALIKPAPAN			0.00	0.00
a76c6f3e-eee8-40ef-8bbd-f4a744af7ee4	QQ	BALIKPAPAN			0.00	0.00
f6ec4dfc-aed1-4868-9e66-7123d26f9e5d	RAFA HOMEMADE	BALIKPAPAN			0.00	0.00
ba3bb380-5bd8-4548-bca9-1b6f312e2f11	RAJAWALI NUSINDO	BALIKPAPAN			0.00	0.00
0973fa04-0116-4fa8-a36c-771877a6e0b6	RENGGINANG AL	BALIKPAPAN			0.00	0.00
a54abfbc-4f8b-4e7f-9e9b-1eb645f29fe7	RENGGINANG PAKDE	BALIKPAPAN			0.00	0.00
be33a793-2dbe-4312-a999-82d4f44ceec9	RICE BOWL MAMAKU	BALIKPAPAN			0.00	0.00
03aa2914-982c-4b0b-a0e7-cb79ba435d12	RIKI SNACK	BALIKPAPAN			0.00	0.00
10e82f8a-120b-45c9-a732-8d7e53ee3352	RUMAH DONAT	BALIKPAPAN			0.00	0.00
3ef1c321-6bf7-4f32-8347-964f0eb4d29b	SALE PISANG PRAS	BALIKPAPAN			0.00	0.00
d058300d-35de-4824-ba70-e81355c15721	SARI BUAH	BALIKPAPAN			0.00	0.00
de27ac5c-861f-4e4e-a197-859b645ccae9	SARI BUANA	BALIKPAPAN			0.00	0.00
0674ea22-81ef-4fa0-b19a-73ca6e8c35c4	SARI ECO BANDENGB PRESTO	BALIKPAPAN			0.00	0.00
8bc2a8d3-d6a6-46a4-8685-0bbb972e066e	SARI ROTI	BALIKPAPAN			0.00	0.00
63447c2e-ea8e-45f4-8ac2-1dd818330950	SATYAWIBAWA ( 305 )	BALIKPAPAN			0.00	0.00
d863bd43-7dcb-48ad-8261-ae8e8bcbc7f5	SENTRAL SARI	BALIKPAPAN			0.00	0.00
e05789ce-5983-4704-a44b-1a07c7e420e1	SEPINGGAN LESTARI PRIMA BALKPAPAN	BALIKPAPAN			0.00	0.00
9ecbbe33-79b3-44ed-85b2-6bbbde3fdb0b	SHAFOODZA	BALIKPAPAN			0.00	0.00
44e3041d-2bbf-4721-89fc-ab58a6be1785	SI UMANG	BALIKPAPAN			0.00	0.00
733205f9-cbde-4fb4-a167-09899bbdd552	SIMAR PANGAN BORNEO	BALIKPAPAN			0.00	0.00
b1babb24-d34d-4ed4-829a-a8d9fd8d4dec	SINAR ALAM NABATI	BALIKPAPAN			0.00	0.00
6f458e19-6e80-4d32-adde-7d817b883994	SINAR UTARA	BALIKPAPAN			0.00	0.00
5c563cc0-624b-491e-a950-375c915e7e50	SIOMAY SANTI	BALIKPAPAN			0.00	0.00
addeec0b-be3c-4339-a2ab-b8b1a99a8cae	SNACK BENTOEL	BALIKPAPAN			0.00	0.00
7289a306-9f8a-4f6c-a39d-080bac4b089c	SNACK ORLIN	BALIKPAPAN			0.00	0.00
aca86c3d-92ec-4fa1-87b7-eb642d36b536	SOLEHA	BALIKPAPAN			0.00	0.00
77bc1807-601c-4d11-a429-cf252cb06819	STARLIGHT STORE	BALIKPAPAN			0.00	0.00
ebb9f2aa-13a6-45c9-9b82-96e8e2fb99a1	SUKSES PLASTIK	BALIKPAPAN			0.00	0.00
3eefc04b-e932-437e-bc3f-bee8ef7033e4	sumberservice	BALIKPAPAN			0.00	0.00
accb582d-7821-4bd2-a353-4eb08562bd2c	TAPE BALKIS	BALIKPAPAN			0.00	0.00
5618cc56-5025-4b6e-a1e1-4d400f24e5e0	TELUR	BALIKPAPAN			0.00	0.00
83c8d268-d430-49af-aea2-2e11519311b6	TELUR PROBIOTIK	BALIKPAPAN			0.00	0.00
0382b8b0-47f0-43cf-aaee-e7573c32f725	TELUR RAS	BALIKPAPAN			0.00	0.00
78468da5-2b5c-4bf4-bd75-6c455e302507	TEMPE MEGA	BALIKPAPAN			0.00	0.00
98e97493-b81b-4c44-858a-13ebadc36aff	UD MIAMI	BALIKPAPAN			0.00	0.00
86bfc254-2f5d-4ccc-aeb3-bfc424f14583	UD PANGAN JAYA	BALIKPAPAN			0.00	0.00
e75818ce-a55e-4c26-86e9-24a2f4d1138d	UMKM BERKAH	BALIKPAPAN			0.00	0.00
4be567a1-2876-4bb3-9101-2a5628ddfe8b	UP IBU LISA	BALIKPAPAN			0.00	0.00
76b4ac95-523f-4524-8ff0-263f82d14fce	VITA KANTIN	BALIKPAPAN			0.00	0.00
85161cc7-f634-40a0-92fb-719470f078da	WENAK SNACK	BALIKPAPAN			0.00	0.00
cade82e7-bff2-4541-8e7f-231e20fe892e	WICAKSANA OVERSEAS INTERNATIONAL PT	BALIKPAPAN			0.00	0.00
0d41802e-c85d-463a-919c-1d5fbe3a80f9	YAKULT	BALIKPAPAN			0.00	0.00
aa54809c-2fc3-43f3-b691-25790424ac9d	YANI JAYA	BALIKPAPAN			0.00	0.00
3feb6bdd-9220-4b64-900e-dabd915da5ac	YATI	BALIKPAPAN			0.00	0.00
4cfcc44d-c501-42f9-8c22-76c5231a584b	ZARETTA BAKERY	BALIKPAPAN			0.00	0.00
f0442fd3-0061-439b-b1f2-4a8d09e175ca	Z'ONE PARFUME	BALIKPAPAN			0.00	0.00
1ccfc8c6-1520-4a48-a705-5538a72504dc	WADAI ACIL BAHARI				0.00	0.00
\.


--
-- TOC entry 5417 (class 0 OID 25092)
-- Dependencies: 248
-- Data for Name: t_beli_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_beli_produk (beli_produk_id, pengguna_id, supplier_id, retur_beli_produk_id, nota, tanggal, tanggal_tempo, ppn, diskon, total_nota, total_pelunasan, keterangan, tanggal_sistem) FROM stdin;
13978805-5ca7-451c-950b-c1cc217b227e	00b5acfa-b533-454b-8dfd-e7881edd180f	17fe5f26-7128-4518-8559-087e58849e29	\N	202609090001	2026-09-09	2026-09-09	0.00	0.00	10000000.00	0.00		2026-09-09 05:21:20.291314
\.


--
-- TOC entry 5419 (class 0 OID 25099)
-- Dependencies: 250
-- Data for Name: t_gaji_karyawan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_gaji_karyawan (gaji_karyawan_id, karyawan_id, pengguna_id, bulan, tahun, kehadiran, absen, gaji_pokok, lembur, bonus, potongan, tanggal_sistem, jam, lainnya, keterangan, jumlah_hari, tunjangan, kasbon, tanggal, nota) FROM stdin;
\.


--
-- TOC entry 5421 (class 0 OID 25111)
-- Dependencies: 252
-- Data for Name: t_item_beli_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_item_beli_produk (item_beli_produk_id, beli_produk_id, pengguna_id, produk_id, harga, jumlah, diskon, tanggal_sistem, jumlah_retur) FROM stdin;
856f092c-33ca-4362-843d-6391fdcf88e9	13978805-5ca7-451c-950b-c1cc217b227e	00b5acfa-b533-454b-8dfd-e7881edd180f	941da461-e328-4ab5-8d43-de1fb43ca4d9	50000.00	200.00	0.00	2026-09-09 05:21:20.291314	0.00
\.


--
-- TOC entry 5422 (class 0 OID 25117)
-- Dependencies: 253
-- Data for Name: t_item_jual_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_item_jual_produk (item_jual_id, jual_id, pengguna_id, produk_id, harga_beli, harga_jual, jumlah, diskon, tanggal_sistem, jumlah_retur, keterangan) FROM stdin;
4838526d-9dc6-4cc2-9ab2-2f38a8eadb3f	969864cb-b0d6-4d48-a0c3-ad4d1fd936fd	98281a7b-4d74-4e85-a215-0f8740795588	941da461-e328-4ab5-8d43-de1fb43ca4d9	50000.00	100000.00	1.00	0.00	2026-09-08 21:30:30.281801	0.00	
f4c4cd8f-5fdb-464b-bf98-7c3054c286cd	475cea9d-458c-401e-a4e5-59ffc470aa25	98281a7b-4d74-4e85-a215-0f8740795588	0d27a9e3-052c-4f65-98a5-2524cee1ae67	3000.00	5000.00	10.00	0.00	2026-09-09 05:08:03.229974	0.00	
33dcd3f4-2b56-4ed3-af62-a2e6aa1a86d7	cc72e7a8-6c52-4153-ae53-9608b2658bf7	98281a7b-4d74-4e85-a215-0f8740795588	941da461-e328-4ab5-8d43-de1fb43ca4d9	50000.00	100000.00	1.00	0.00	2026-09-09 05:09:34.654229	0.00	
5de18bb6-a6a8-4100-aac7-b08679ef5d7f	d2311ad7-b259-472b-8f4a-51ee4ebb9eb3	98281a7b-4d74-4e85-a215-0f8740795588	941da461-e328-4ab5-8d43-de1fb43ca4d9	50000.00	100000.00	20.00	0.00	2026-09-09 08:28:44.015147	0.00	
9c8960b8-7d41-4b1c-8e27-6e6eb6633ea9	aadfeaf7-33b0-4871-b0fc-39279af6574e	98281a7b-4d74-4e85-a215-0f8740795588	0d27a9e3-052c-4f65-98a5-2524cee1ae67	3000.00	5000.00	10.00	0.00	2026-09-09 08:29:05.582052	0.00	
db16bd6b-92a8-4edf-8939-eceb66286568	aa637ed6-80f0-4071-9aa5-464005d3684b	98281a7b-4d74-4e85-a215-0f8740795588	941da461-e328-4ab5-8d43-de1fb43ca4d9	50000.00	100000.00	10.00	0.00	2026-09-20 15:14:20.606468	0.00	
487a5e91-430b-4dc1-90d5-57534645d37f	38b9516a-543f-47dd-a192-4caba53dc017	c2e3e5ad-717e-4baa-ac15-f80147c1917f	0d27a9e3-052c-4f65-98a5-2524cee1ae67	3000.00	5000.00	10.00	0.00	2026-09-20 15:15:16.496422	0.00	
c4b5ba50-6d92-4a1c-9d79-d6094568532f	3443f5a6-0190-4b73-8a20-784f37eea0b9	98281a7b-4d74-4e85-a215-0f8740795588	0d27a9e3-052c-4f65-98a5-2524cee1ae67	3000.00	5000.00	1.00	0.00	2026-09-25 16:00:22.377712	0.00	
\.


--
-- TOC entry 5423 (class 0 OID 25123)
-- Dependencies: 254
-- Data for Name: t_item_pembayaran_hutang_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_item_pembayaran_hutang_produk (item_pembayaran_hutang_produk_id, pembayaran_hutang_produk_id, beli_produk_id, nominal, keterangan, tanggal_sistem) FROM stdin;
\.


--
-- TOC entry 5424 (class 0 OID 25129)
-- Dependencies: 255
-- Data for Name: t_item_pembayaran_piutang_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_item_pembayaran_piutang_produk (item_pembayaran_piutang_id, pembayaran_piutang_id, jual_id, nominal, keterangan, tanggal_sistem) FROM stdin;
7d843e12-54fd-4db2-9c92-2c2d3ad0d04c	b34ceb20-9ad5-4f8a-90e2-6e41c108691b	969864cb-b0d6-4d48-a0c3-ad4d1fd936fd	100000.00		2026-09-08 21:30:30.281801
202099aa-a653-4209-86cd-f23a2af551d8	6a0dc8be-1593-4b6d-a355-fdd9c8e61401	475cea9d-458c-401e-a4e5-59ffc470aa25	50000.00		2026-09-09 05:08:03.229974
87e699d6-1ff1-4752-9d5a-50c3f3e3d0f4	215a4b86-c339-41cd-8813-ca57d8c4ff06	d2311ad7-b259-472b-8f4a-51ee4ebb9eb3	2000000.00		2026-09-09 08:28:44.015147
fd7c3471-d023-40a0-a8c4-b02ea6e91f00	2b00a9f3-fbe1-475d-826d-68d979583984	aa637ed6-80f0-4071-9aa5-464005d3684b	1000000.00		2026-09-20 15:14:20.606468
09e22bb7-9cde-4c15-8c01-a689b73be0bc	d97e8c21-95ba-4f6c-94ac-f67ea139e44a	38b9516a-543f-47dd-a192-4caba53dc017	50000.00		2026-09-20 15:15:16.496422
5a996fa5-6a6b-4429-9782-37487ca1605f	88590ee7-8842-4594-acc6-16984d55833c	3443f5a6-0190-4b73-8a20-784f37eea0b9	5000.00		2026-09-25 16:00:22.377712
2a5085ec-10ec-40ea-b841-6efb8178149f	b7ccbf20-59f3-4242-b6c6-852d9af79cdc	cc72e7a8-6c52-4153-ae53-9608b2658bf7	100000.00	pembayaran qris	2026-09-25 16:05:00.783236
\.


--
-- TOC entry 5425 (class 0 OID 25135)
-- Dependencies: 256
-- Data for Name: t_item_pengeluaran_biaya; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_item_pengeluaran_biaya (item_pengeluaran_id, pengeluaran_id, pengguna_id, jumlah, harga, tanggal_sistem, jenis_pengeluaran_id) FROM stdin;
679e3488-9108-4e82-a68b-82c7d9d1b051	f32fc240-749a-453c-9539-b2a159271769	00b5acfa-b533-454b-8dfd-e7881edd180f	1.00	200000.00	2026-09-09 05:19:01.606265	1619f95e-eac3-40e9-ba8a-af2230d3c470
\.


--
-- TOC entry 5426 (class 0 OID 25141)
-- Dependencies: 257
-- Data for Name: t_item_retur_beli_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_item_retur_beli_produk (item_retur_beli_produk_id, retur_beli_produk_id, pengguna_id, produk_id, harga, jumlah, tanggal_sistem, jumlah_retur, item_beli_id) FROM stdin;
\.


--
-- TOC entry 5427 (class 0 OID 25147)
-- Dependencies: 258
-- Data for Name: t_item_retur_jual_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_item_retur_jual_produk (item_retur_jual_id, retur_jual_id, pengguna_id, produk_id, harga_jual, jumlah, tanggal_sistem, jumlah_retur, item_jual_id) FROM stdin;
\.


--
-- TOC entry 5428 (class 0 OID 25153)
-- Dependencies: 259
-- Data for Name: t_jual_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_jual_produk (jual_id, pengguna_id, customer_id, nota, tanggal, tanggal_tempo, ppn, diskon, total_nota, total_pelunasan, keterangan, tanggal_sistem, retur_jual_id, shift_id, is_sdac, kirim_kecamatan, kirim_kelurahan, kirim_kota, kirim_kode_pos, kirim_kepada, kirim_alamat, kirim_telepon, ongkos_kirim, label_dari1, label_dari2, label_dari3, label_dari4, label_kepada1, label_kepada2, label_kepada3, label_kepada4, kurir, is_dropship, kirim_desa, kirim_kabupaten, mesin_id, bayar_tunai, bayar_kartu, kartu_id, nomor_kartu, dropshipper_id) FROM stdin;
969864cb-b0d6-4d48-a0c3-ad4d1fd936fd	98281a7b-4d74-4e85-a215-0f8740795588	\N	202609080002	2026-09-08	\N	0.00	0.00	100000.00	100000.00	\N	2026-09-08 21:30:30.281801	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	8d77769f-8ce8-488d-8fd2-cb96707e90f2	0.00	100000.00	23f39815-30ed-44a0-92ef-95bbebe86857		\N
475cea9d-458c-401e-a4e5-59ffc470aa25	98281a7b-4d74-4e85-a215-0f8740795588	\N	202609090005	2026-09-09	\N	0.00	0.00	50000.00	50000.00	\N	2026-09-09 05:08:03.229974	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	9a81a0f3-bbf6-4e99-a661-a3e9c070f10e	0.00	50000.00	23f39815-30ed-44a0-92ef-95bbebe86857		\N
d2311ad7-b259-472b-8f4a-51ee4ebb9eb3	98281a7b-4d74-4e85-a215-0f8740795588	\N	202609090008	2026-09-09	\N	0.00	0.00	2000000.00	2000000.00	\N	2026-09-09 08:28:44.015147	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	152d3abc-4083-425a-b9dd-10fdf6460e41	2000000.00	0.00	\N	\N	\N
aadfeaf7-33b0-4871-b0fc-39279af6574e	98281a7b-4d74-4e85-a215-0f8740795588	40d0dad9-bb58-447e-8187-147d61b78362	202609090009	2026-09-09	2026-10-09	0.00	0.00	50000.00	0.00	\N	2026-09-09 08:29:05.582052	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	152d3abc-4083-425a-b9dd-10fdf6460e41	0.00	0.00	\N	\N	\N
aa637ed6-80f0-4071-9aa5-464005d3684b	98281a7b-4d74-4e85-a215-0f8740795588	\N	202609200013	2026-09-20	\N	0.00	0.00	1000000.00	1000000.00	\N	2026-09-20 15:14:20.606468	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	fd3ac68e-ca1e-43ba-a2d3-123a66486baa	1000000.00	0.00	\N	\N	\N
38b9516a-543f-47dd-a192-4caba53dc017	c2e3e5ad-717e-4baa-ac15-f80147c1917f	\N	202609200015	2026-09-20	\N	0.00	0.00	50000.00	50000.00	\N	2026-09-20 15:15:16.496422	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	7796d177-74f3-4503-a561-d5b1ce5b91be	50000.00	0.00	\N	\N	\N
3443f5a6-0190-4b73-8a20-784f37eea0b9	98281a7b-4d74-4e85-a215-0f8740795588	40d0dad9-bb58-447e-8187-147d61b78362	202609250017	2026-09-25	\N	0.00	0.00	5000.00	5000.00	\N	2026-09-25 16:00:22.377712	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	13bc02d7-bb1c-4dd3-9d61-aaa1eeabe3db	5000.00	0.00	\N	\N	\N
cc72e7a8-6c52-4153-ae53-9608b2658bf7	98281a7b-4d74-4e85-a215-0f8740795588	40d0dad9-bb58-447e-8187-147d61b78362	202609090006	2026-09-09	2026-10-09	0.00	0.00	100000.00	100000.00	\N	2026-09-09 05:09:34.654229	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	0.00	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	9a81a0f3-bbf6-4e99-a661-a3e9c070f10e	0.00	0.00	\N	\N	\N
\.


--
-- TOC entry 5430 (class 0 OID 25160)
-- Dependencies: 261
-- Data for Name: t_kasbon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_kasbon (kasbon_id, karyawan_id, pengguna_id, nota, tanggal, nominal, keterangan, tanggal_sistem, total_pelunasan) FROM stdin;
\.


--
-- TOC entry 5432 (class 0 OID 25168)
-- Dependencies: 263
-- Data for Name: t_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_logs (log_id, level, class_name, method_name, message, new_value, old_value, exception, created_by, log_date) FROM stdin;
1	INFO	OpenRetail.Repository.Service.PembayaranPiutangProdukRepository	Save	Tambah data	{"pembayaran_piutang_id":"b34ceb20-9ad5-4f8a-90e2-6e41c108691b","customer_id":null,"Customer":null,"pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","tanggal":"2026-09-08T00:00:00+08:00","keterangan":"Penjualan tunai produk","nota":"202609080001","is_tunai":true,"total_pembayaran":0.0,"item_pembayaran_piutang":[{"item_pembayaran_piutang_id":"7d843e12-54fd-4db2-9c92-2c2d3ad0d04c","pembayaran_piutang_id":"b34ceb20-9ad5-4f8a-90e2-6e41c108691b","jual_id":"969864cb-b0d6-4d48-a0c3-ad4d1fd936fd","JualProduk":{"jual_id":"969864cb-b0d6-4d48-a0c3-ad4d1fd936fd","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":null,"Customer":null,"nota":"202609080002","tanggal":"2026-09-08T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":100000.0,"total_pelunasan":0.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":100000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"8d77769f-8ce8-488d-8fd2-cb96707e90f2","kartu_id":"23f39815-30ed-44a0-92ef-95bbebe86857","dropshipper_id":null,"nomor_kartu":"","is_tunai":true,"total_pelunasan_old":0.0,"grand_total":100000.0,"sisa_nota":100000.0,"item_jual":[{"item_jual_id":"4838526d-9dc6-4cc2-9ab2-2f38a8eadb3f","jual_id":"969864cb-b0d6-4d48-a0c3-ad4d1fd936fd","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":10.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":100.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":110.0,"minimal_stok_gudang":3.0,"asset":11000000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:59:15"},"keterangan":"","harga_beli":50000.0,"harga_jual":100000.0,"old_jumlah":0.0,"jumlah":1.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":100000.0,"sub_total":100000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null},"nominal":100000.0,"keterangan":"","entity_state":1}],"item_pembayaran_piutang_deleted":[]}			kasir	2026-09-08 21:30:31
2	INFO	OpenRetail.Repository.Service.JualProdukRepository	Save	Tambah data	{"jual_id":"969864cb-b0d6-4d48-a0c3-ad4d1fd936fd","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":null,"Customer":null,"nota":"202609080002","tanggal":"2026-09-08T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":100000.0,"total_pelunasan":100000.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":100000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"8d77769f-8ce8-488d-8fd2-cb96707e90f2","kartu_id":"23f39815-30ed-44a0-92ef-95bbebe86857","dropshipper_id":null,"nomor_kartu":"","is_tunai":true,"total_pelunasan_old":0.0,"grand_total":100000.0,"sisa_nota":0.0,"item_jual":[{"item_jual_id":"4838526d-9dc6-4cc2-9ab2-2f38a8eadb3f","jual_id":"969864cb-b0d6-4d48-a0c3-ad4d1fd936fd","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":10.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":100.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":110.0,"minimal_stok_gudang":3.0,"asset":11000000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:59:15"},"keterangan":"","harga_beli":50000.0,"harga_jual":100000.0,"old_jumlah":0.0,"jumlah":1.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":100000.0,"sub_total":100000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null}			kasir	2026-09-08 21:30:31
3	INFO	OpenRetail.Repository.Service.PembayaranPiutangProdukRepository	Save	Tambah data	{"pembayaran_piutang_id":"6a0dc8be-1593-4b6d-a355-fdd9c8e61401","customer_id":null,"Customer":null,"pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","tanggal":"2026-09-09T00:00:00+08:00","keterangan":"Penjualan tunai produk","nota":"202609090002","is_tunai":true,"total_pembayaran":0.0,"item_pembayaran_piutang":[{"item_pembayaran_piutang_id":"202099aa-a653-4209-86cd-f23a2af551d8","pembayaran_piutang_id":"6a0dc8be-1593-4b6d-a355-fdd9c8e61401","jual_id":"475cea9d-458c-401e-a4e5-59ffc470aa25","JualProduk":{"jual_id":"475cea9d-458c-401e-a4e5-59ffc470aa25","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":null,"Customer":null,"nota":"202609090005","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":50000.0,"total_pelunasan":0.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":50000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"9a81a0f3-bbf6-4e99-a661-a3e9c070f10e","kartu_id":"23f39815-30ed-44a0-92ef-95bbebe86857","dropshipper_id":null,"nomor_kartu":"","is_tunai":true,"total_pelunasan_old":0.0,"grand_total":50000.0,"sisa_nota":50000.0,"item_jual":[{"item_jual_id":"f4c4cd8f-5fdb-464b-bf98-7c3054c286cd","jual_id":"475cea9d-458c-401e-a4e5-59ffc470aa25","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","Produk":{"list_of_satuan":null,"produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","nama_produk":"sarimi","satuan":"pcs","stok":10.0,"harga_beli":3000.0,"harga_jual":5000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080002","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":100.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":110.0,"minimal_stok_gudang":2.0,"asset":550000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:35:53"},"keterangan":"","harga_beli":3000.0,"harga_jual":5000.0,"old_jumlah":0.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":5000.0,"sub_total":50000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null},"nominal":50000.0,"keterangan":"","entity_state":1}],"item_pembayaran_piutang_deleted":[]}			kasir	2026-09-09 05:08:04
4	INFO	OpenRetail.Repository.Service.JualProdukRepository	Save	Tambah data	{"jual_id":"475cea9d-458c-401e-a4e5-59ffc470aa25","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":null,"Customer":null,"nota":"202609090005","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":50000.0,"total_pelunasan":50000.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":50000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"9a81a0f3-bbf6-4e99-a661-a3e9c070f10e","kartu_id":"23f39815-30ed-44a0-92ef-95bbebe86857","dropshipper_id":null,"nomor_kartu":"","is_tunai":true,"total_pelunasan_old":0.0,"grand_total":50000.0,"sisa_nota":0.0,"item_jual":[{"item_jual_id":"f4c4cd8f-5fdb-464b-bf98-7c3054c286cd","jual_id":"475cea9d-458c-401e-a4e5-59ffc470aa25","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","Produk":{"list_of_satuan":null,"produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","nama_produk":"sarimi","satuan":"pcs","stok":10.0,"harga_beli":3000.0,"harga_jual":5000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080002","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":100.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":110.0,"minimal_stok_gudang":2.0,"asset":550000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:35:53"},"keterangan":"","harga_beli":3000.0,"harga_jual":5000.0,"old_jumlah":0.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":5000.0,"sub_total":50000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null}			kasir	2026-09-09 05:08:04
5	INFO	OpenRetail.Repository.Service.JualProdukRepository	Save	Tambah data	{"jual_id":"cc72e7a8-6c52-4153-ae53-9608b2658bf7","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","Customer":{"customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","nama_customer":"muhammad deden","provinsi_id":"11","Provinsi":{"provinsi_id":"11","nama_provinsi":"Aceh"},"kabupaten_id":"1103","kabupaten_old":"","Kabupaten":{"kabupaten_id":"1103","provinsi_id":null,"Provinsi":null,"nama_kabupaten":"Kab. Aceh Selatan"},"kecamatan_id":"1103021","kecamatan_old":null,"Kecamatan":{"kecamatan_id":"1103021","kabupaten_id":null,"Kabupaten":null,"nama_kecamatan":"Bakongan Timur"},"alamat":"","desa":null,"kelurahan":null,"kota":null,"kode_pos":"","kontak":"","telepon":"","diskon":0.0,"plafon_piutang":1500000.0,"total_piutang":0.0,"total_pembayaran_piutang":0.0,"sisa_piutang":0.0},"nota":"202609090006","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":"2026-10-09T00:00:00+08:00","ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":100000.0,"total_pelunasan":0.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":0.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"9a81a0f3-bbf6-4e99-a661-a3e9c070f10e","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":100000.0,"sisa_nota":100000.0,"item_jual":[{"item_jual_id":"33dcd3f4-2b56-4ed3-af62-a2e6aa1a86d7","jual_id":"cc72e7a8-6c52-4153-ae53-9608b2658bf7","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":10.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":99.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":109.0,"minimal_stok_gudang":3.0,"asset":10900000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:59:15"},"keterangan":"","harga_beli":50000.0,"harga_jual":100000.0,"old_jumlah":0.0,"jumlah":1.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":100000.0,"sub_total":100000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null}			kasir	2026-09-09 05:09:35
6	INFO	OpenRetail.Repository.Service.PengeluaranBiayaRepository	Save	Tambah data	{"pengeluaran_id":"f32fc240-749a-453c-9539-b2a159271769","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","nota":"202609090001","tanggal":"2026-09-09T00:00:00+08:00","total":200000.0,"keterangan":"","item_pengeluaran_biaya":[{"item_pengeluaran_id":"679e3488-9108-4e82-a68b-82c7d9d1b051","pengeluaran_id":"f32fc240-749a-453c-9539-b2a159271769","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","jumlah":1.0,"harga":200000.0,"jenis_pengeluaran_id":"1619f95e-eac3-40e9-ba8a-af2230d3c470","JenisPengeluaran":{"jenis_pengeluaran_id":"1619f95e-eac3-40e9-ba8a-af2230d3c470","nama_jenis_pengeluaran":"Biaya Lain Lain Penjualan"},"entity_state":1}],"item_pengeluaran_biaya_deleted":[]}			admin	2026-09-09 05:19:03
7	INFO	OpenRetail.Repository.Service.BeliProdukRepository	Save	Tambah data	{"beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","Supplier":{"supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","nama_supplier":"abc","alamat":"balikpapan","kontak":"","telepon":"","total_hutang":0.0,"total_pembayaran_hutang":0.0},"retur_beli_produk_id":null,"nota":"202609090001","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":"2026-09-09T00:00:00+08:00","ppn":0.0,"diskon":0.0,"total_nota":500000.0,"total_pelunasan":0.0,"keterangan":"","total_pelunasan_old":0.0,"grand_total":500000.0,"sisa_nota":500000.0,"is_tunai":false,"item_beli":[{"item_beli_produk_id":"856f092c-33ca-4362-843d-6391fdcf88e9","beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":10.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":98.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":108.0,"minimal_stok_gudang":3.0,"asset":10800000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:59:15"},"harga":50000.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":50000.0,"sub_total":500000.0,"entity_state":1}],"item_beli_deleted":[]}			admin	2026-09-09 05:21:20
8	INFO	OpenRetail.Repository.Service.BeliProdukRepository	Update	Update data	{"beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","Supplier":{"supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","nama_supplier":"abc","alamat":"balikpapan","kontak":"","telepon":"","total_hutang":0.0,"total_pembayaran_hutang":0.0},"retur_beli_produk_id":null,"nota":"202609090001","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":"2026-09-09T00:00:00+08:00","ppn":0.0,"diskon":0.0,"total_nota":5000000.0,"total_pelunasan":0.0,"keterangan":"","total_pelunasan_old":0.0,"grand_total":5000000.0,"sisa_nota":5000000.0,"is_tunai":false,"item_beli":[{"item_beli_produk_id":"856f092c-33ca-4362-843d-6391fdcf88e9","beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":0.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":null,"Golongan":null,"minimal_stok":0.0,"stok_gudang":0.0,"is_aktif":false,"is_stok_minus":true,"sisa_stok":0.0,"minimal_stok_gudang":0.0,"asset":0.0,"list_of_harga_grosir":[],"last_update":null},"harga":50000.0,"jumlah":100.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":50000.0,"sub_total":5000000.0,"entity_state":1}],"item_beli_deleted":[]}	{"beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","Supplier":{"supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","nama_supplier":"abc","alamat":"balikpapan","kontak":"","telepon":"","total_hutang":0.0,"total_pembayaran_hutang":0.0},"retur_beli_produk_id":null,"nota":"202609090001","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":"2026-09-09T00:00:00+08:00","ppn":0.0,"diskon":0.0,"total_nota":500000.0,"total_pelunasan":0.0,"keterangan":"","total_pelunasan_old":0.0,"grand_total":500000.0,"sisa_nota":500000.0,"is_tunai":false,"item_beli":[{"item_beli_produk_id":"856f092c-33ca-4362-843d-6391fdcf88e9","beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":0.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":null,"Golongan":null,"minimal_stok":0.0,"stok_gudang":0.0,"is_aktif":false,"is_stok_minus":true,"sisa_stok":0.0,"minimal_stok_gudang":0.0,"asset":0.0,"list_of_harga_grosir":[],"last_update":null},"harga":50000.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":50000.0,"sub_total":500000.0,"entity_state":1}],"item_beli_deleted":[]}		admin	2026-09-09 05:22:13
9	INFO	OpenRetail.Repository.Service.BeliProdukRepository	Update	Update data	{"beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","Supplier":{"supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","nama_supplier":"abc","alamat":"balikpapan","kontak":null,"telepon":null,"total_hutang":0.0,"total_pembayaran_hutang":0.0},"retur_beli_produk_id":null,"nota":"202609090001","tanggal":"2026-09-09T00:00:00","tanggal_tempo":"2026-09-09T00:00:00","ppn":0.0,"diskon":0.0,"total_nota":10000000.0,"total_pelunasan":0.0,"keterangan":"","total_pelunasan_old":0.0,"grand_total":10000000.0,"sisa_nota":10000000.0,"is_tunai":false,"item_beli":[{"item_beli_produk_id":"856f092c-33ca-4362-843d-6391fdcf88e9","beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":0.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":null,"Golongan":null,"minimal_stok":0.0,"stok_gudang":0.0,"is_aktif":false,"is_stok_minus":true,"sisa_stok":0.0,"minimal_stok_gudang":0.0,"asset":0.0,"list_of_harga_grosir":[],"last_update":null},"harga":50000.0,"jumlah":200.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":50000.0,"sub_total":10000000.0,"entity_state":1}],"item_beli_deleted":[]}	{"beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","Supplier":{"supplier_id":"17fe5f26-7128-4518-8559-087e58849e29","nama_supplier":"abc","alamat":"balikpapan","kontak":null,"telepon":null,"total_hutang":0.0,"total_pembayaran_hutang":0.0},"retur_beli_produk_id":null,"nota":"202609090001","tanggal":"2026-09-09T00:00:00","tanggal_tempo":"2026-09-09T00:00:00","ppn":0.0,"diskon":0.0,"total_nota":5000000.0,"total_pelunasan":0.0,"keterangan":"","total_pelunasan_old":0.0,"grand_total":5000000.0,"sisa_nota":5000000.0,"is_tunai":false,"item_beli":[{"item_beli_produk_id":"856f092c-33ca-4362-843d-6391fdcf88e9","beli_produk_id":"13978805-5ca7-451c-950b-c1cc217b227e","pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":0.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":null,"Golongan":null,"minimal_stok":0.0,"stok_gudang":0.0,"is_aktif":false,"is_stok_minus":true,"sisa_stok":0.0,"minimal_stok_gudang":0.0,"asset":0.0,"list_of_harga_grosir":[],"last_update":null},"harga":50000.0,"jumlah":100.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":50000.0,"sub_total":5000000.0,"entity_state":1}],"item_beli_deleted":[]}		admin	2026-09-09 05:23:03
10	INFO	OpenRetail.Repository.Service.PembayaranPiutangProdukRepository	Save	Tambah data	{"pembayaran_piutang_id":"215a4b86-c339-41cd-8813-ca57d8c4ff06","customer_id":null,"Customer":null,"pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","tanggal":"2026-09-09T00:00:00+08:00","keterangan":"Penjualan tunai produk","nota":"202609090003","is_tunai":true,"total_pembayaran":0.0,"item_pembayaran_piutang":[{"item_pembayaran_piutang_id":"87e699d6-1ff1-4752-9d5a-50c3f3e3d0f4","pembayaran_piutang_id":"215a4b86-c339-41cd-8813-ca57d8c4ff06","jual_id":"d2311ad7-b259-472b-8f4a-51ee4ebb9eb3","JualProduk":{"jual_id":"d2311ad7-b259-472b-8f4a-51ee4ebb9eb3","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":null,"Customer":null,"nota":"202609090008","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":2000000.0,"total_pelunasan":0.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":2000000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"152d3abc-4083-425a-b9dd-10fdf6460e41","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":2000000.0,"sisa_nota":2000000.0,"item_jual":[{"item_jual_id":"5de18bb6-a6a8-4100-aac7-b08679ef5d7f","jual_id":"d2311ad7-b259-472b-8f4a-51ee4ebb9eb3","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":10.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":298.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":308.0,"minimal_stok_gudang":3.0,"asset":30800000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:59:15"},"keterangan":"","harga_beli":50000.0,"harga_jual":100000.0,"old_jumlah":0.0,"jumlah":20.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":100000.0,"sub_total":2000000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null},"nominal":2000000.0,"keterangan":"","entity_state":1}],"item_pembayaran_piutang_deleted":[]}			kasir	2026-09-09 08:28:45
11	INFO	OpenRetail.Repository.Service.JualProdukRepository	Save	Tambah data	{"jual_id":"d2311ad7-b259-472b-8f4a-51ee4ebb9eb3","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":null,"Customer":null,"nota":"202609090008","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":2000000.0,"total_pelunasan":2000000.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":2000000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"152d3abc-4083-425a-b9dd-10fdf6460e41","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":2000000.0,"sisa_nota":0.0,"item_jual":[{"item_jual_id":"5de18bb6-a6a8-4100-aac7-b08679ef5d7f","jual_id":"d2311ad7-b259-472b-8f4a-51ee4ebb9eb3","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":10.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":298.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":308.0,"minimal_stok_gudang":3.0,"asset":30800000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:59:15"},"keterangan":"","harga_beli":50000.0,"harga_jual":100000.0,"old_jumlah":0.0,"jumlah":20.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":100000.0,"sub_total":2000000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null}			kasir	2026-09-09 08:28:45
12	INFO	OpenRetail.Repository.Service.JualProdukRepository	Save	Tambah data	{"jual_id":"aadfeaf7-33b0-4871-b0fc-39279af6574e","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","Customer":{"customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","nama_customer":"muhammad deden","provinsi_id":"11","Provinsi":{"provinsi_id":"11","nama_provinsi":"Aceh"},"kabupaten_id":"1103","kabupaten_old":"","Kabupaten":{"kabupaten_id":"1103","provinsi_id":null,"Provinsi":null,"nama_kabupaten":"Kab. Aceh Selatan"},"kecamatan_id":"1103021","kecamatan_old":null,"Kecamatan":{"kecamatan_id":"1103021","kabupaten_id":null,"Kabupaten":null,"nama_kecamatan":"Bakongan Timur"},"alamat":"","desa":null,"kelurahan":null,"kota":null,"kode_pos":"","kontak":"","telepon":"","diskon":0.0,"plafon_piutang":1500000.0,"total_piutang":100000.0,"total_pembayaran_piutang":0.0,"sisa_piutang":100000.0},"nota":"202609090009","tanggal":"2026-09-09T00:00:00+08:00","tanggal_tempo":"2026-10-09T00:00:00+08:00","ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":50000.0,"total_pelunasan":0.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":0.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"152d3abc-4083-425a-b9dd-10fdf6460e41","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":50000.0,"sisa_nota":50000.0,"item_jual":[{"item_jual_id":"9c8960b8-7d41-4b1c-8e27-6e6eb6633ea9","jual_id":"aadfeaf7-33b0-4871-b0fc-39279af6574e","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","Produk":{"list_of_satuan":null,"produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","nama_produk":"sarimi","satuan":"pcs","stok":10.0,"harga_beli":3000.0,"harga_jual":5000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080002","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":90.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":100.0,"minimal_stok_gudang":2.0,"asset":500000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:35:53"},"keterangan":"","harga_beli":3000.0,"harga_jual":5000.0,"old_jumlah":0.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":5000.0,"sub_total":50000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null}			kasir	2026-09-09 08:29:06
13	ERROR	OpenRetail.Repository.Service.CustomerRepository	Save	Error:			Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint "uq_m_customer_kode_customer"\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.<>c__DisplayClass41_0.<<ReadMessage>g__ReadMessageSequential|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlDataReader.<NextResult>d__44.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.NextResult()\r\n   at Npgsql.NpgsqlCommand.<ExecuteReaderAsync>d__97.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(CommandBehavior behavior)\r\n   at Dapper.SqlMapper.ExecuteReaderWithFlagsFallback(IDbCommand cmd, Boolean wasClosed, CommandBehavior behavior)\r\n   at Dapper.SqlMapper.<QueryImpl>d__125`1.MoveNext()\r\n   at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)\r\n   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)\r\n   at Dapper.SqlMapper.Query[T](IDbConnection cnn, String sql, Object param, IDbTransaction transaction, Boolean buffered, Nullable`1 commandTimeout, Nullable`1 commandType)\r\n   at PostgresAdapter.Insert(IDbConnection connection, IDbTransaction transaction, Nullable`1 commandTimeout, String tableName, String columnList, String parameterList, IEnumerable`1 keyProperties, Object entityToInsert)\r\n   at Dapper.Contrib.Extensions.SqlMapperExtensions.Insert[T](IDbConnection connection, T entityToInsert, IDbTransaction transaction, Nullable`1 commandTimeout)\r\n   at OpenRetail.Repository.Service.CustomerRepository.Save(Customer obj) in D:\\project desktop\\open retail\\open-retail-master\\src\\OpenRetail.Repository.Service\\Referensi\\CustomerRepository.cs:line 203\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint "uq_m_customer_kode_customer"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify 'Include Error Detail' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: m_customer\r\n    ConstraintName: uq_m_customer_kode_customer\r\n    File: nbtinsert.c\r\n    Line: 673\r\n    Routine: _bt_check_unique	admin	2026-09-19 19:47:39
14	ERROR	OpenRetail.Repository.Service.CustomerRepository	Save	Error:			Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint "uq_m_customer_kode_customer"\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.<>c__DisplayClass41_0.<<ReadMessage>g__ReadMessageSequential|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlDataReader.<NextResult>d__44.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.NextResult()\r\n   at Npgsql.NpgsqlCommand.<ExecuteReaderAsync>d__97.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(CommandBehavior behavior)\r\n   at Dapper.SqlMapper.ExecuteReaderWithFlagsFallback(IDbCommand cmd, Boolean wasClosed, CommandBehavior behavior)\r\n   at Dapper.SqlMapper.<QueryImpl>d__125`1.MoveNext()\r\n   at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)\r\n   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)\r\n   at Dapper.SqlMapper.Query[T](IDbConnection cnn, String sql, Object param, IDbTransaction transaction, Boolean buffered, Nullable`1 commandTimeout, Nullable`1 commandType)\r\n   at PostgresAdapter.Insert(IDbConnection connection, IDbTransaction transaction, Nullable`1 commandTimeout, String tableName, String columnList, String parameterList, IEnumerable`1 keyProperties, Object entityToInsert)\r\n   at Dapper.Contrib.Extensions.SqlMapperExtensions.Insert[T](IDbConnection connection, T entityToInsert, IDbTransaction transaction, Nullable`1 commandTimeout)\r\n   at OpenRetail.Repository.Service.CustomerRepository.Save(Customer obj) in D:\\project desktop\\open retail\\open-retail-master\\src\\OpenRetail.Repository.Service\\Referensi\\CustomerRepository.cs:line 203\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint "uq_m_customer_kode_customer"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify 'Include Error Detail' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: m_customer\r\n    ConstraintName: uq_m_customer_kode_customer\r\n    File: nbtinsert.c\r\n    Line: 673\r\n    Routine: _bt_check_unique	admin	2026-09-19 19:47:39
15	ERROR	OpenRetail.Repository.Service.CustomerRepository	Save	Error:			Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint "uq_m_customer_kode_customer"\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.<>c__DisplayClass41_0.<<ReadMessage>g__ReadMessageSequential|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlDataReader.<NextResult>d__44.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.NextResult()\r\n   at Npgsql.NpgsqlCommand.<ExecuteReaderAsync>d__97.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(CommandBehavior behavior)\r\n   at Dapper.SqlMapper.ExecuteReaderWithFlagsFallback(IDbCommand cmd, Boolean wasClosed, CommandBehavior behavior)\r\n   at Dapper.SqlMapper.<QueryImpl>d__125`1.MoveNext()\r\n   at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)\r\n   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)\r\n   at Dapper.SqlMapper.Query[T](IDbConnection cnn, String sql, Object param, IDbTransaction transaction, Boolean buffered, Nullable`1 commandTimeout, Nullable`1 commandType)\r\n   at PostgresAdapter.Insert(IDbConnection connection, IDbTransaction transaction, Nullable`1 commandTimeout, String tableName, String columnList, String parameterList, IEnumerable`1 keyProperties, Object entityToInsert)\r\n   at Dapper.Contrib.Extensions.SqlMapperExtensions.Insert[T](IDbConnection connection, T entityToInsert, IDbTransaction transaction, Nullable`1 commandTimeout)\r\n   at OpenRetail.Repository.Service.CustomerRepository.Save(Customer obj) in D:\\project desktop\\open retail\\open-retail-master\\src\\OpenRetail.Repository.Service\\Referensi\\CustomerRepository.cs:line 203\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint "uq_m_customer_kode_customer"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify 'Include Error Detail' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: m_customer\r\n    ConstraintName: uq_m_customer_kode_customer\r\n    File: nbtinsert.c\r\n    Line: 673\r\n    Routine: _bt_check_unique	admin	2026-09-19 19:47:39
16	ERROR	OpenRetail.Repository.Service.CustomerRepository	Save	Error:			Npgsql.PostgresException (0x80004005): 23502: null value in column "kode_customer" of relation "m_customer" violates not-null constraint\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.<>c__DisplayClass41_0.<<ReadMessage>g__ReadMessageSequential|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlDataReader.<NextResult>d__44.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.NextResult()\r\n   at Npgsql.NpgsqlCommand.<ExecuteReaderAsync>d__97.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(CommandBehavior behavior)\r\n   at Dapper.SqlMapper.ExecuteReaderWithFlagsFallback(IDbCommand cmd, Boolean wasClosed, CommandBehavior behavior)\r\n   at Dapper.SqlMapper.<QueryImpl>d__125`1.MoveNext()\r\n   at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)\r\n   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)\r\n   at Dapper.SqlMapper.Query[T](IDbConnection cnn, String sql, Object param, IDbTransaction transaction, Boolean buffered, Nullable`1 commandTimeout, Nullable`1 commandType)\r\n   at PostgresAdapter.Insert(IDbConnection connection, IDbTransaction transaction, Nullable`1 commandTimeout, String tableName, String columnList, String parameterList, IEnumerable`1 keyProperties, Object entityToInsert)\r\n   at Dapper.Contrib.Extensions.SqlMapperExtensions.Insert[T](IDbConnection connection, T entityToInsert, IDbTransaction transaction, Nullable`1 commandTimeout)\r\n   at OpenRetail.Repository.Service.CustomerRepository.Save(Customer obj) in D:\\project desktop\\open retail\\open-retail-master\\src\\OpenRetail.Repository.Service\\Referensi\\CustomerRepository.cs:line 203\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23502\r\n    MessageText: null value in column "kode_customer" of relation "m_customer" violates not-null constraint\r\n    Detail: Detail redacted as it may contain sensitive data. Specify 'Include Error Detail' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: m_customer\r\n    ColumnName: kode_customer\r\n    File: execMain.c\r\n    Line: 2028\r\n    Routine: ExecConstraints	admin	2026-09-19 20:03:18
17	ERROR	OpenRetail.Repository.Service.CustomerRepository	Save	Error:			Npgsql.PostgresException (0x80004005): 23502: null value in column "kode_customer" of relation "m_customer" violates not-null constraint\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlConnector.<>c__DisplayClass158_0.<<DoReadMessage>g__ReadMessageLong|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.<>c__DisplayClass41_0.<<ReadMessage>g__ReadMessageSequential|0>d.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at Npgsql.NpgsqlDataReader.<NextResult>d__44.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlDataReader.NextResult()\r\n   at Npgsql.NpgsqlCommand.<ExecuteReaderAsync>d__97.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(CommandBehavior behavior)\r\n   at Dapper.SqlMapper.ExecuteReaderWithFlagsFallback(IDbCommand cmd, Boolean wasClosed, CommandBehavior behavior)\r\n   at Dapper.SqlMapper.<QueryImpl>d__125`1.MoveNext()\r\n   at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)\r\n   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)\r\n   at Dapper.SqlMapper.Query[T](IDbConnection cnn, String sql, Object param, IDbTransaction transaction, Boolean buffered, Nullable`1 commandTimeout, Nullable`1 commandType)\r\n   at PostgresAdapter.Insert(IDbConnection connection, IDbTransaction transaction, Nullable`1 commandTimeout, String tableName, String columnList, String parameterList, IEnumerable`1 keyProperties, Object entityToInsert)\r\n   at Dapper.Contrib.Extensions.SqlMapperExtensions.Insert[T](IDbConnection connection, T entityToInsert, IDbTransaction transaction, Nullable`1 commandTimeout)\r\n   at OpenRetail.Repository.Service.CustomerRepository.Save(Customer obj) in D:\\project desktop\\open retail\\open-retail-master\\src\\OpenRetail.Repository.Service\\Referensi\\CustomerRepository.cs:line 203\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23502\r\n    MessageText: null value in column "kode_customer" of relation "m_customer" violates not-null constraint\r\n    Detail: Detail redacted as it may contain sensitive data. Specify 'Include Error Detail' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: m_customer\r\n    ColumnName: kode_customer\r\n    File: execMain.c\r\n    Line: 2028\r\n    Routine: ExecConstraints	admin	2026-09-19 20:03:32
18	INFO	OpenRetail.Repository.Service.PembayaranPiutangProdukRepository	Save	Tambah data	{"pembayaran_piutang_id":"2b00a9f3-fbe1-475d-826d-68d979583984","customer_id":null,"Customer":null,"pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","tanggal":"2026-09-20T00:00:00+08:00","keterangan":"Penjualan tunai produk","nota":"202609200004","is_tunai":true,"total_pembayaran":0.0,"item_pembayaran_piutang":[{"item_pembayaran_piutang_id":"fd7c3471-d023-40a0-a8c4-b02ea6e91f00","pembayaran_piutang_id":"2b00a9f3-fbe1-475d-826d-68d979583984","jual_id":"aa637ed6-80f0-4071-9aa5-464005d3684b","JualProduk":{"jual_id":"aa637ed6-80f0-4071-9aa5-464005d3684b","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":null,"Customer":null,"nota":"202609200013","tanggal":"2026-09-20T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":1000000.0,"total_pelunasan":0.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":1000000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"fd3ac68e-ca1e-43ba-a2d3-123a66486baa","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":1000000.0,"sisa_nota":1000000.0,"item_jual":[{"item_jual_id":"db16bd6b-92a8-4edf-8939-eceb66286568","jual_id":"aa637ed6-80f0-4071-9aa5-464005d3684b","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":10.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":278.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":288.0,"minimal_stok_gudang":3.0,"asset":28800000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:59:15"},"keterangan":"","harga_beli":50000.0,"harga_jual":100000.0,"old_jumlah":0.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":100000.0,"sub_total":1000000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null},"nominal":1000000.0,"keterangan":"","entity_state":1}],"item_pembayaran_piutang_deleted":[]}			kasir	2026-09-20 15:14:21
19	INFO	OpenRetail.Repository.Service.JualProdukRepository	Save	Tambah data	{"jual_id":"aa637ed6-80f0-4071-9aa5-464005d3684b","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":null,"Customer":null,"nota":"202609200013","tanggal":"2026-09-20T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":1000000.0,"total_pelunasan":1000000.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":1000000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"fd3ac68e-ca1e-43ba-a2d3-123a66486baa","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":1000000.0,"sisa_nota":0.0,"item_jual":[{"item_jual_id":"db16bd6b-92a8-4edf-8939-eceb66286568","jual_id":"aa637ed6-80f0-4071-9aa5-464005d3684b","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","Produk":{"list_of_satuan":null,"produk_id":"941da461-e328-4ab5-8d43-de1fb43ca4d9","nama_produk":"beras","satuan":"karung","stok":10.0,"harga_beli":50000.0,"harga_jual":100000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080003","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":278.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":288.0,"minimal_stok_gudang":3.0,"asset":28800000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:59:15"},"keterangan":"","harga_beli":50000.0,"harga_jual":100000.0,"old_jumlah":0.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":100000.0,"sub_total":1000000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null}			kasir	2026-09-20 15:14:21
20	INFO	OpenRetail.Repository.Service.PembayaranPiutangProdukRepository	Save	Tambah data	{"pembayaran_piutang_id":"d97e8c21-95ba-4f6c-94ac-f67ea139e44a","customer_id":null,"Customer":null,"pengguna_id":"c2e3e5ad-717e-4baa-ac15-f80147c1917f","tanggal":"2026-09-20T00:00:00+08:00","keterangan":"Penjualan tunai produk","nota":"202609200005","is_tunai":true,"total_pembayaran":0.0,"item_pembayaran_piutang":[{"item_pembayaran_piutang_id":"09e22bb7-9cde-4c15-8c01-a689b73be0bc","pembayaran_piutang_id":"d97e8c21-95ba-4f6c-94ac-f67ea139e44a","jual_id":"38b9516a-543f-47dd-a192-4caba53dc017","JualProduk":{"jual_id":"38b9516a-543f-47dd-a192-4caba53dc017","pengguna_id":"c2e3e5ad-717e-4baa-ac15-f80147c1917f","customer_id":null,"Customer":null,"nota":"202609200015","tanggal":"2026-09-20T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":50000.0,"total_pelunasan":0.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":50000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"7796d177-74f3-4503-a561-d5b1ce5b91be","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":50000.0,"sisa_nota":50000.0,"item_jual":[{"item_jual_id":"487a5e91-430b-4dc1-90d5-57534645d37f","jual_id":"38b9516a-543f-47dd-a192-4caba53dc017","pengguna_id":"c2e3e5ad-717e-4baa-ac15-f80147c1917f","produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","Produk":{"list_of_satuan":null,"produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","nama_produk":"sarimi","satuan":"pcs","stok":10.0,"harga_beli":3000.0,"harga_jual":5000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080002","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":80.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":90.0,"minimal_stok_gudang":2.0,"asset":450000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:35:53"},"keterangan":"","harga_beli":3000.0,"harga_jual":5000.0,"old_jumlah":0.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":5000.0,"sub_total":50000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null},"nominal":50000.0,"keterangan":"","entity_state":1}],"item_pembayaran_piutang_deleted":[]}			anipano	2026-09-20 15:15:17
21	INFO	OpenRetail.Repository.Service.JualProdukRepository	Save	Tambah data	{"jual_id":"38b9516a-543f-47dd-a192-4caba53dc017","pengguna_id":"c2e3e5ad-717e-4baa-ac15-f80147c1917f","customer_id":null,"Customer":null,"nota":"202609200015","tanggal":"2026-09-20T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":50000.0,"total_pelunasan":50000.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":50000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"7796d177-74f3-4503-a561-d5b1ce5b91be","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":50000.0,"sisa_nota":0.0,"item_jual":[{"item_jual_id":"487a5e91-430b-4dc1-90d5-57534645d37f","jual_id":"38b9516a-543f-47dd-a192-4caba53dc017","pengguna_id":"c2e3e5ad-717e-4baa-ac15-f80147c1917f","produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","Produk":{"list_of_satuan":null,"produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","nama_produk":"sarimi","satuan":"pcs","stok":10.0,"harga_beli":3000.0,"harga_jual":5000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080002","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":80.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":90.0,"minimal_stok_gudang":2.0,"asset":450000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:35:53"},"keterangan":"","harga_beli":3000.0,"harga_jual":5000.0,"old_jumlah":0.0,"jumlah":10.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":5000.0,"sub_total":50000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null}			anipano	2026-09-20 15:15:17
22	ERROR	OpenRetail.Bll.Service.ImportExportDataCustomerBll	Import	Error:			System.Exception: Kode Customer KOP000001 sudah terdaftar.\r\n   at OpenRetail.Bll.Service.ImportExportDataCustomerBll.Import(String workSheetName, Int32& rowCount) in D:\\project desktop\\open retail\\open-retail-master\\src\\OpenRetail.Bll.Service\\Referensi\\ImportExportDataCustomerBll.cs:line 215	admin	2026-09-24 10:48:28
23	ERROR	OpenRetail.Bll.Service.ImportExportDataCustomerBll	Import	Error:			System.Exception: Kode Customer KOP000001 sudah terdaftar.\r\n   at OpenRetail.Bll.Service.ImportExportDataCustomerBll.Import(String workSheetName, Int32& rowCount) in D:\\project desktop\\open retail\\open-retail-master\\src\\OpenRetail.Bll.Service\\Referensi\\ImportExportDataCustomerBll.cs:line 215	admin	2026-09-24 10:48:33
24	INFO	OpenRetail.Repository.Service.PembayaranPiutangProdukRepository	Save	Tambah data	{"pembayaran_piutang_id":"88590ee7-8842-4594-acc6-16984d55833c","customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","Customer":null,"pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","tanggal":"2026-09-25T00:00:00+08:00","keterangan":"Penjualan tunai produk","nota":"202609250007","is_tunai":true,"total_pembayaran":0.0,"item_pembayaran_piutang":[{"item_pembayaran_piutang_id":"5a996fa5-6a6b-4429-9782-37487ca1605f","pembayaran_piutang_id":"88590ee7-8842-4594-acc6-16984d55833c","jual_id":"3443f5a6-0190-4b73-8a20-784f37eea0b9","JualProduk":{"jual_id":"3443f5a6-0190-4b73-8a20-784f37eea0b9","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","Customer":{"customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","kode_customer":"KOP000002","nama_customer":"muhammad deden","provinsi_id":"11","Provinsi":{"provinsi_id":"11","nama_provinsi":"Aceh"},"kabupaten_id":"1103","kabupaten_old":"","Kabupaten":{"kabupaten_id":"1103","provinsi_id":null,"Provinsi":null,"nama_kabupaten":"Kab. Aceh Selatan"},"kecamatan_id":"1103021","kecamatan_old":null,"Kecamatan":{"kecamatan_id":"1103021","kabupaten_id":null,"Kabupaten":null,"nama_kecamatan":"Bakongan Timur"},"alamat":"balikpapan","desa":null,"kelurahan":null,"kota":null,"kode_pos":"","kontak":"","telepon":"08115965955","pin":"009988","last_login":"2026-09-25T05:22:14","diskon":0.0,"plafon_piutang":1500000.0,"total_piutang":150000.0,"total_pembayaran_piutang":0.0,"sisa_piutang":150000.0},"nota":"202609250017","tanggal":"2026-09-25T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":5000.0,"total_pelunasan":0.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":5000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"13bc02d7-bb1c-4dd3-9d61-aaa1eeabe3db","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":5000.0,"sisa_nota":5000.0,"item_jual":[{"item_jual_id":"c4b5ba50-6d92-4a1c-9d79-d6094568532f","jual_id":"3443f5a6-0190-4b73-8a20-784f37eea0b9","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","Produk":{"list_of_satuan":null,"produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","nama_produk":"sarimi","satuan":"pcs","stok":10.0,"harga_beli":3000.0,"harga_jual":5000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080002","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":70.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":80.0,"minimal_stok_gudang":2.0,"asset":400000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:35:53"},"keterangan":"","harga_beli":3000.0,"harga_jual":5000.0,"old_jumlah":0.0,"jumlah":1.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":5000.0,"sub_total":5000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null},"nominal":5000.0,"keterangan":"","entity_state":1}],"item_pembayaran_piutang_deleted":[]}			kasir	2026-09-25 16:00:23
25	INFO	OpenRetail.Repository.Service.JualProdukRepository	Save	Tambah data	{"jual_id":"3443f5a6-0190-4b73-8a20-784f37eea0b9","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","Customer":{"customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","kode_customer":"KOP000002","nama_customer":"muhammad deden","provinsi_id":"11","Provinsi":{"provinsi_id":"11","nama_provinsi":"Aceh"},"kabupaten_id":"1103","kabupaten_old":"","Kabupaten":{"kabupaten_id":"1103","provinsi_id":null,"Provinsi":null,"nama_kabupaten":"Kab. Aceh Selatan"},"kecamatan_id":"1103021","kecamatan_old":null,"Kecamatan":{"kecamatan_id":"1103021","kabupaten_id":null,"Kabupaten":null,"nama_kecamatan":"Bakongan Timur"},"alamat":"balikpapan","desa":null,"kelurahan":null,"kota":null,"kode_pos":"","kontak":"","telepon":"08115965955","pin":"009988","last_login":"2026-09-25T05:22:14","diskon":0.0,"plafon_piutang":1500000.0,"total_piutang":150000.0,"total_pembayaran_piutang":0.0,"sisa_piutang":150000.0},"nota":"202609250017","tanggal":"2026-09-25T00:00:00+08:00","tanggal_tempo":null,"ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":5000.0,"total_pelunasan":5000.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":5000.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"13bc02d7-bb1c-4dd3-9d61-aaa1eeabe3db","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":true,"total_pelunasan_old":0.0,"grand_total":5000.0,"sisa_nota":0.0,"item_jual":[{"item_jual_id":"c4b5ba50-6d92-4a1c-9d79-d6094568532f","jual_id":"3443f5a6-0190-4b73-8a20-784f37eea0b9","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","Produk":{"list_of_satuan":null,"produk_id":"0d27a9e3-052c-4f65-98a5-2524cee1ae67","nama_produk":"sarimi","satuan":"pcs","stok":10.0,"harga_beli":3000.0,"harga_jual":5000.0,"diskon":0.0,"persentase_keuntungan":0.0,"kode_produk":"202609080002","kode_produk_old":null,"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","Golongan":{"golongan_id":"6c9f2842-7cf5-4715-9830-5e97d6a1801a","nama_golongan":"makanan","diskon":0.0,"persentase_keuntungan":0.0},"minimal_stok":0.0,"stok_gudang":70.0,"is_aktif":true,"is_stok_minus":false,"sisa_stok":80.0,"minimal_stok_gudang":2.0,"asset":400000.0,"list_of_harga_grosir":[],"last_update":"2026-09-08T20:35:53"},"keterangan":"","harga_beli":3000.0,"harga_jual":5000.0,"old_jumlah":0.0,"jumlah":1.0,"diskon":0.0,"jumlah_retur":0.0,"diskon_rupiah":0.0,"harga_setelah_diskon":5000.0,"sub_total":5000.0,"entity_state":1}],"item_jual_deleted":[],"nama_kartu":null}			kasir	2026-09-25 16:00:23
26	INFO	OpenRetail.Repository.Service.PembayaranPiutangProdukRepository	Save	Tambah data	{"pembayaran_piutang_id":"b7ccbf20-59f3-4242-b6c6-852d9af79cdc","customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","Customer":{"customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","kode_customer":"KOP000002","nama_customer":"muhammad deden","provinsi_id":"11","Provinsi":{"provinsi_id":"11","nama_provinsi":"Aceh"},"kabupaten_id":"1103","kabupaten_old":"","Kabupaten":{"kabupaten_id":"1103","provinsi_id":null,"Provinsi":null,"nama_kabupaten":"Kab. Aceh Selatan"},"kecamatan_id":"1103021","kecamatan_old":null,"Kecamatan":{"kecamatan_id":"1103021","kabupaten_id":null,"Kabupaten":null,"nama_kecamatan":"Bakongan Timur"},"alamat":"balikpapan","desa":null,"kelurahan":null,"kota":null,"kode_pos":"","kontak":"","telepon":"08115965955","pin":"009988","last_login":"2026-09-25T05:22:14","diskon":0.0,"plafon_piutang":1500000.0,"total_piutang":150000.0,"total_pembayaran_piutang":0.0,"sisa_piutang":150000.0},"pengguna_id":"00b5acfa-b533-454b-8dfd-e7881edd180f","tanggal":"2026-09-25T00:00:00+08:00","keterangan":"","nota":"202609250008","is_tunai":false,"total_pembayaran":0.0,"item_pembayaran_piutang":[{"item_pembayaran_piutang_id":"2a5085ec-10ec-40ea-b841-6efb8178149f","pembayaran_piutang_id":"b7ccbf20-59f3-4242-b6c6-852d9af79cdc","jual_id":"cc72e7a8-6c52-4153-ae53-9608b2658bf7","JualProduk":{"jual_id":"cc72e7a8-6c52-4153-ae53-9608b2658bf7","pengguna_id":"98281a7b-4d74-4e85-a215-0f8740795588","customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","Customer":{"customer_id":"40d0dad9-bb58-447e-8187-147d61b78362","kode_customer":null,"nama_customer":"muhammad deden","provinsi_id":"11","Provinsi":null,"kabupaten_id":"1103","kabupaten_old":null,"Kabupaten":null,"kecamatan_id":"1103021","kecamatan_old":null,"Kecamatan":null,"alamat":"balikpapan","desa":null,"kelurahan":null,"kota":null,"kode_pos":"","kontak":null,"telepon":"08115965955","pin":null,"last_login":null,"diskon":0.0,"plafon_piutang":1500000.0,"total_piutang":0.0,"total_pembayaran_piutang":0.0,"sisa_piutang":0.0},"nota":"202609090006","tanggal":"2026-09-09T00:00:00","tanggal_tempo":"2026-10-09T00:00:00","ppn":0.0,"diskon":0.0,"kurir":null,"ongkos_kirim":0.0,"total_nota":100000.0,"total_pelunasan":100000.0,"keterangan":null,"is_sdac":true,"is_dropship":false,"kirim_kepada":null,"kirim_alamat":null,"kirim_desa":null,"kirim_kelurahan":null,"kirim_kecamatan":null,"kirim_kota":null,"kirim_kabupaten":null,"kirim_kode_pos":null,"kirim_telepon":null,"label_dari1":null,"label_dari2":null,"label_dari3":null,"label_dari4":null,"label_kepada1":null,"label_kepada2":null,"label_kepada3":null,"label_kepada4":null,"jumlah_bayar":0.0,"retur_jual_id":null,"shift_id":null,"mesin_id":"9a81a0f3-bbf6-4e99-a661-a3e9c070f10e","kartu_id":null,"dropshipper_id":null,"nomor_kartu":null,"is_tunai":false,"total_pelunasan_old":0.0,"grand_total":100000.0,"sisa_nota":0.0,"item_jual":[],"item_jual_deleted":[],"nama_kartu":null},"nominal":100000.0,"keterangan":"pembayaran qris","entity_state":1}],"item_pembayaran_piutang_deleted":[]}			admin	2026-09-25 16:05:01
\.


--
-- TOC entry 5434 (class 0 OID 25176)
-- Dependencies: 265
-- Data for Name: t_mesin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_mesin (mesin_id, pengguna_id, tanggal, saldo_awal, uang_masuk, tanggal_sistem, shift_id, uang_keluar) FROM stdin;
1b11ea08-b87b-440c-b360-7cc9553a945f	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-08	500000.00	0.00	2026-09-08 19:54:37.638648	id-shift-malam                      	0.00
8d77769f-8ce8-488d-8fd2-cb96707e90f2	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-08	500000.00	0.00	2026-09-08 21:29:16.884072	id-shift-malam                      	0.00
05f5f6c8-0e76-44ac-bd35-f3c490a45127	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	500000.00	0.00	2026-09-09 00:22:37.882514	id-shift-malam                      	0.00
9a81a0f3-bbf6-4e99-a661-a3e9c070f10e	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	500000.00	0.00	2026-09-09 05:06:53.53573	cd0c46ea-64f2-4737-8fcd-40b5963a5543	0.00
ffbb4422-6109-4388-a0f1-adb3354e0e56	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	5.00	0.00	2026-09-09 06:55:38.190298	id-shift-pagi                       	0.00
b021fde0-93d0-4aac-a948-fd6e99944698	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	500000.00	0.00	2026-09-09 06:56:27.130624	id-shift-pagi                       	0.00
7fbe49c4-5f35-4673-ad30-06f4d9428498	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	500000.00	0.00	2026-09-09 06:58:36.851387	id-shift-malam                      	0.00
7965f9b5-9a67-4f7c-bfb0-9a95a5918905	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	500000.00	0.00	2026-09-09 08:28:02.739929	id-shift-pagi                       	0.00
152d3abc-4083-425a-b9dd-10fdf6460e41	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	500000.00	0.00	2026-09-09 08:28:21.294831	id-shift-pagi                       	0.00
ed1699c8-d936-4c26-b48b-6b9088e1627d	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 09:33:05.771029	cd0c46ea-64f2-4737-8fcd-40b5963a5543	0.00
7a2eb663-8a27-4a71-82df-c2ae7b337567	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 09:49:29.730752	id-shift-pagi                       	0.00
5ec902f0-4008-47db-ae06-dd6e7075aea1	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 10:00:31.632478	id-shift-pagi                       	0.00
bbdbbf6a-d645-4739-877a-eb4251e4698f	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 10:07:58.959052	id-shift-pagi                       	0.00
6c0f6f71-19aa-43ee-8ce0-ccd21a33cbd5	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 10:15:34.373143	id-shift-pagi                       	0.00
46522b6f-057c-43d5-9635-1da96c1b5cfb	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 10:40:35.211984	id-shift-pagi                       	0.00
aa078ab3-eb22-43a6-8b86-ab288b947d1b	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 10:59:39.890989	id-shift-pagi                       	0.00
1931ca72-26f1-43e7-8305-35666380ba38	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 11:41:23.152563	id-shift-pagi                       	0.00
0513ef28-fe65-49da-91b9-5d78ed50d815	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 11:44:20.291606	id-shift-pagi                       	0.00
a9ddc9c8-06a4-4114-baa8-fb126857ed81	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-14	500000.00	0.00	2026-09-14 12:59:06.262729	id-shift-pagi                       	0.00
8a1b6f97-3b0b-4ad9-be3d-44f5e8fbcb13	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-19	500000.00	0.00	2026-09-19 06:06:18.08693	cd0c46ea-64f2-4737-8fcd-40b5963a5543	0.00
3d16eaf8-50f0-408d-ab6c-2b5ffb3e2a48	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-19	500000.00	0.00	2026-09-19 08:09:31.704878	id-shift-pagi                       	0.00
6648d2b5-6d9a-4a23-9f14-1986c78a3c9c	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-19	500000.00	0.00	2026-09-19 08:15:45.444989	id-shift-pagi                       	0.00
cfa9601a-1b00-4ff7-8382-0f38b276885d	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-19	500000.00	0.00	2026-09-19 18:21:57.724503	id-shift-pagi                       	0.00
84b290ed-27ac-45f8-977e-5eb1afe6ee2f	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-19	500000.00	0.00	2026-09-19 18:30:12.164193	id-shift-pagi                       	0.00
82c23f51-b939-48f6-a211-53f934684128	00b5acfa-b533-454b-8dfd-e7881edd180f	2026-09-20	0.00	0.00	2026-09-20 14:05:35.946484	id-shift-pagi                       	0.00
fd3ac68e-ca1e-43ba-a2d3-123a66486baa	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-20	500000.00	0.00	2026-09-20 15:13:26.02218	id-shift-pagi                       	0.00
7796d177-74f3-4503-a561-d5b1ce5b91be	c2e3e5ad-717e-4baa-ac15-f80147c1917f	2026-09-20	500000.00	0.00	2026-09-20 15:14:52.08746	id-shift-pagi                       	0.00
13bc02d7-bb1c-4dd3-9d61-aaa1eeabe3db	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-25	500000.00	0.00	2026-09-25 15:59:54.195381	id-shift-pagi                       	0.00
\.


--
-- TOC entry 5435 (class 0 OID 25183)
-- Dependencies: 266
-- Data for Name: t_pembayaran_hutang_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_pembayaran_hutang_produk (pembayaran_hutang_produk_id, supplier_id, pengguna_id, tanggal, keterangan, tanggal_sistem, nota, is_tunai) FROM stdin;
\.


--
-- TOC entry 5437 (class 0 OID 25190)
-- Dependencies: 268
-- Data for Name: t_pembayaran_kasbon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_pembayaran_kasbon (pembayaran_kasbon_id, kasbon_id, gaji_karyawan_id, tanggal, nominal, keterangan, tanggal_sistem, nota, pengguna_id) FROM stdin;
\.


--
-- TOC entry 5439 (class 0 OID 25197)
-- Dependencies: 270
-- Data for Name: t_pembayaran_piutang_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_pembayaran_piutang_produk (pembayaran_piutang_id, customer_id, pengguna_id, tanggal, keterangan, tanggal_sistem, nota, is_tunai) FROM stdin;
b34ceb20-9ad5-4f8a-90e2-6e41c108691b	\N	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-08	Penjualan tunai produk	2026-09-08 21:30:30.281801	202609080001	t
6a0dc8be-1593-4b6d-a355-fdd9c8e61401	\N	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	Penjualan tunai produk	2026-09-09 05:08:03.229974	202609090002	t
215a4b86-c339-41cd-8813-ca57d8c4ff06	\N	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-09	Penjualan tunai produk	2026-09-09 08:28:44.015147	202609090003	t
2b00a9f3-fbe1-475d-826d-68d979583984	\N	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-20	Penjualan tunai produk	2026-09-20 15:14:20.606468	202609200004	t
d97e8c21-95ba-4f6c-94ac-f67ea139e44a	\N	c2e3e5ad-717e-4baa-ac15-f80147c1917f	2026-09-20	Penjualan tunai produk	2026-09-20 15:15:16.496422	202609200005	t
88590ee7-8842-4594-acc6-16984d55833c	40d0dad9-bb58-447e-8187-147d61b78362	98281a7b-4d74-4e85-a215-0f8740795588	2026-09-25	Penjualan tunai produk	2026-09-25 16:00:22.377712	202609250007	t
b7ccbf20-59f3-4242-b6c6-852d9af79cdc	40d0dad9-bb58-447e-8187-147d61b78362	00b5acfa-b533-454b-8dfd-e7881edd180f	2026-09-25		2026-09-25 16:05:00.783236	202609250008	f
\.


--
-- TOC entry 5441 (class 0 OID 25204)
-- Dependencies: 272
-- Data for Name: t_pengeluaran_biaya; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_pengeluaran_biaya (pengeluaran_id, pengguna_id, nota, tanggal, total, keterangan, tanggal_sistem) FROM stdin;
f32fc240-749a-453c-9539-b2a159271769	00b5acfa-b533-454b-8dfd-e7881edd180f	202609090001	2026-09-09	200000.00		2026-09-09 05:19:01.606265
\.


--
-- TOC entry 5443 (class 0 OID 25211)
-- Dependencies: 274
-- Data for Name: t_penyesuaian_stok; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_penyesuaian_stok (penyesuaian_stok_id, produk_id, alasan_penyesuaian_id, tanggal, penambahan_stok, pengurangan_stok, keterangan, tanggal_sistem, penambahan_stok_gudang, pengurangan_stok_gudang) FROM stdin;
\.


--
-- TOC entry 5444 (class 0 OID 25217)
-- Dependencies: 275
-- Data for Name: t_retur_beli_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_retur_beli_produk (retur_beli_produk_id, beli_produk_id, pengguna_id, supplier_id, nota, tanggal, keterangan, tanggal_sistem, total_nota) FROM stdin;
\.


--
-- TOC entry 5446 (class 0 OID 25224)
-- Dependencies: 277
-- Data for Name: t_retur_jual_produk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_retur_jual_produk (retur_jual_id, jual_id, pengguna_id, customer_id, nota, tanggal, keterangan, tanggal_sistem, total_nota) FROM stdin;
\.


--
-- TOC entry 5461 (class 0 OID 0)
-- Dependencies: 239
-- Name: m_produk_produk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.m_produk_produk_id_seq', 4, true);


--
-- TOC entry 5462 (class 0 OID 0)
-- Dependencies: 249
-- Name: t_beli_produk_beli_produk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_beli_produk_beli_produk_id_seq', 2, true);


--
-- TOC entry 5463 (class 0 OID 0)
-- Dependencies: 251
-- Name: t_gaji_karyawan_gaji_karyawan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_gaji_karyawan_gaji_karyawan_id_seq', 1, false);


--
-- TOC entry 5464 (class 0 OID 0)
-- Dependencies: 260
-- Name: t_jual_produk_jual_produk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_jual_produk_jual_produk_id_seq', 18, true);


--
-- TOC entry 5465 (class 0 OID 0)
-- Dependencies: 262
-- Name: t_kasbon_kasbon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_kasbon_kasbon_id_seq', 1, false);


--
-- TOC entry 5466 (class 0 OID 0)
-- Dependencies: 264
-- Name: t_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_logs_log_id_seq', 26, true);


--
-- TOC entry 5467 (class 0 OID 0)
-- Dependencies: 267
-- Name: t_pembayaran_hutang_produk_pembayaran_hutang_produk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_pembayaran_hutang_produk_pembayaran_hutang_produk_id_seq', 4, true);


--
-- TOC entry 5468 (class 0 OID 0)
-- Dependencies: 269
-- Name: t_pembayaran_kasbon_pembayaran_kasbon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_pembayaran_kasbon_pembayaran_kasbon_id_seq', 1, false);


--
-- TOC entry 5469 (class 0 OID 0)
-- Dependencies: 271
-- Name: t_pembayaran_piutang_produk_pembayaran_piutang_produk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_pembayaran_piutang_produk_pembayaran_piutang_produk_id_seq', 8, true);


--
-- TOC entry 5470 (class 0 OID 0)
-- Dependencies: 273
-- Name: t_pengeluaran_biaya_pengeluaran_biaya_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_pengeluaran_biaya_pengeluaran_biaya_id_seq', 3, true);


--
-- TOC entry 5471 (class 0 OID 0)
-- Dependencies: 276
-- Name: t_retur_beli_produk_retur_beli_produk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_retur_beli_produk_retur_beli_produk_id_seq', 1, false);


--
-- TOC entry 5472 (class 0 OID 0)
-- Dependencies: 278
-- Name: t_retur_jual_produk_retur_jual_produk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.t_retur_jual_produk_retur_jual_produk_id_seq', 1, false);


--
-- TOC entry 5013 (class 2606 OID 25232)
-- Name: m_alasan_penyesuaian_stok m_alasan_penyesuaian_stok_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_alasan_penyesuaian_stok
    ADD CONSTRAINT m_alasan_penyesuaian_stok_pkey PRIMARY KEY (alasan_penyesuaian_stok_id);


--
-- TOC entry 5160 (class 2606 OID 57930)
-- Name: m_cabang m_cabang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_cabang
    ADD CONSTRAINT m_cabang_pkey PRIMARY KEY (cabang_id);


--
-- TOC entry 5016 (class 2606 OID 25234)
-- Name: m_customer m_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_customer
    ADD CONSTRAINT m_customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 5020 (class 2606 OID 25236)
-- Name: m_database_version m_database_version_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_database_version
    ADD CONSTRAINT m_database_version_pkey PRIMARY KEY (version_number);


--
-- TOC entry 5022 (class 2606 OID 25238)
-- Name: m_dropshipper m_dropshipper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_dropshipper
    ADD CONSTRAINT m_dropshipper_pkey PRIMARY KEY (dropshipper_id);


--
-- TOC entry 5024 (class 2606 OID 25240)
-- Name: m_footer_nota_mini_pos m_footer_nota_mini_pos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_footer_nota_mini_pos
    ADD CONSTRAINT m_footer_nota_mini_pos_pkey PRIMARY KEY (footer_nota_id);


--
-- TOC entry 5026 (class 2606 OID 25242)
-- Name: m_golongan m_golongan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_golongan
    ADD CONSTRAINT m_golongan_pkey PRIMARY KEY (golongan_id);


--
-- TOC entry 5028 (class 2606 OID 25244)
-- Name: m_harga_grosir m_harga_grosir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_harga_grosir
    ADD CONSTRAINT m_harga_grosir_pkey PRIMARY KEY (harga_grosir_id);


--
-- TOC entry 5032 (class 2606 OID 25246)
-- Name: m_header_nota_mini_pos m_header_nota_mini_pos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_header_nota_mini_pos
    ADD CONSTRAINT m_header_nota_mini_pos_pkey PRIMARY KEY (header_nota_id);


--
-- TOC entry 5030 (class 2606 OID 25248)
-- Name: m_header_nota m_header_nota_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_header_nota
    ADD CONSTRAINT m_header_nota_pkey PRIMARY KEY (header_nota_id);


--
-- TOC entry 5034 (class 2606 OID 25250)
-- Name: m_item_menu m_item_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_item_menu
    ADD CONSTRAINT m_item_menu_pkey PRIMARY KEY (item_menu_id);


--
-- TOC entry 5036 (class 2606 OID 25252)
-- Name: m_jabatan m_jabatan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_jabatan
    ADD CONSTRAINT m_jabatan_pkey PRIMARY KEY (jabatan_id);


--
-- TOC entry 5038 (class 2606 OID 25254)
-- Name: m_jenis_pengeluaran m_jenis_pengeluaran_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_jenis_pengeluaran
    ADD CONSTRAINT m_jenis_pengeluaran_pkey PRIMARY KEY (jenis_pengeluaran_id);


--
-- TOC entry 5045 (class 2606 OID 25256)
-- Name: m_kabupaten2 m_kabupaten2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_kabupaten2
    ADD CONSTRAINT m_kabupaten2_pkey PRIMARY KEY (kabupaten_id);


--
-- TOC entry 5041 (class 2606 OID 25258)
-- Name: m_kabupaten m_kabupaten_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_kabupaten
    ADD CONSTRAINT m_kabupaten_pkey PRIMARY KEY (kabupaten_id);


--
-- TOC entry 5047 (class 2606 OID 25260)
-- Name: m_kartu m_kartu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_kartu
    ADD CONSTRAINT m_kartu_pkey PRIMARY KEY (kartu_id);


--
-- TOC entry 5049 (class 2606 OID 25262)
-- Name: m_karyawan m_karyawan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_karyawan
    ADD CONSTRAINT m_karyawan_pkey PRIMARY KEY (karyawan_id);


--
-- TOC entry 5053 (class 2606 OID 25264)
-- Name: m_kecamatan m_kecamatan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_kecamatan
    ADD CONSTRAINT m_kecamatan_pkey PRIMARY KEY (kecamatan_id);


--
-- TOC entry 5055 (class 2606 OID 25266)
-- Name: m_label_nota m_label_nota_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_label_nota
    ADD CONSTRAINT m_label_nota_pkey PRIMARY KEY (label_nota_id);


--
-- TOC entry 5057 (class 2606 OID 25268)
-- Name: m_menu m_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_menu
    ADD CONSTRAINT m_menu_pkey PRIMARY KEY (menu_id);


--
-- TOC entry 5059 (class 2606 OID 25270)
-- Name: m_pengguna m_pengguna_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_pengguna
    ADD CONSTRAINT m_pengguna_pkey PRIMARY KEY (pengguna_id);


--
-- TOC entry 5061 (class 2606 OID 25272)
-- Name: m_prefix_nota m_prefix_nota_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_prefix_nota
    ADD CONSTRAINT m_prefix_nota_pkey PRIMARY KEY (prefix_nota_id);


--
-- TOC entry 5067 (class 2606 OID 25274)
-- Name: m_produk m_produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_produk
    ADD CONSTRAINT m_produk_pkey PRIMARY KEY (produk_id);


--
-- TOC entry 5069 (class 2606 OID 25276)
-- Name: m_profil m_profil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_profil
    ADD CONSTRAINT m_profil_pkey PRIMARY KEY (profil_id);


--
-- TOC entry 5075 (class 2606 OID 25278)
-- Name: m_provinsi2 m_provinsi2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_provinsi2
    ADD CONSTRAINT m_provinsi2_pkey PRIMARY KEY (provinsi_id);


--
-- TOC entry 5072 (class 2606 OID 25280)
-- Name: m_provinsi m_provinsi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_provinsi
    ADD CONSTRAINT m_provinsi_pkey PRIMARY KEY (provinsi_id);


--
-- TOC entry 5077 (class 2606 OID 25282)
-- Name: m_role m_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_role
    ADD CONSTRAINT m_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 5079 (class 2606 OID 25284)
-- Name: m_role_privilege m_role_privilege_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_role_privilege
    ADD CONSTRAINT m_role_privilege_pkey PRIMARY KEY (role_id, menu_id, grant_id);


--
-- TOC entry 5081 (class 2606 OID 25286)
-- Name: m_setting_aplikasi m_setting_aplikasi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_setting_aplikasi
    ADD CONSTRAINT m_setting_aplikasi_pkey PRIMARY KEY (setting_aplikasi_id);


--
-- TOC entry 5083 (class 2606 OID 25288)
-- Name: m_shift m_shift_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_shift
    ADD CONSTRAINT m_shift_pkey PRIMARY KEY (shift_id);


--
-- TOC entry 5086 (class 2606 OID 25290)
-- Name: m_supplier m_supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_supplier
    ADD CONSTRAINT m_supplier_pkey PRIMARY KEY (supplier_id);


--
-- TOC entry 5093 (class 2606 OID 25292)
-- Name: t_beli_produk t_beli_produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_beli_produk
    ADD CONSTRAINT t_beli_produk_pkey PRIMARY KEY (beli_produk_id);


--
-- TOC entry 5098 (class 2606 OID 25294)
-- Name: t_gaji_karyawan t_gaji_karyawan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_gaji_karyawan
    ADD CONSTRAINT t_gaji_karyawan_pkey PRIMARY KEY (gaji_karyawan_id);


--
-- TOC entry 5100 (class 2606 OID 25296)
-- Name: t_item_beli_produk t_item_beli_produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_beli_produk
    ADD CONSTRAINT t_item_beli_produk_pkey PRIMARY KEY (item_beli_produk_id);


--
-- TOC entry 5102 (class 2606 OID 25298)
-- Name: t_item_jual_produk t_item_jual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_jual_produk
    ADD CONSTRAINT t_item_jual_pkey PRIMARY KEY (item_jual_id);


--
-- TOC entry 5104 (class 2606 OID 25300)
-- Name: t_item_pembayaran_hutang_produk t_item_pembayaran_hutang_produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pembayaran_hutang_produk
    ADD CONSTRAINT t_item_pembayaran_hutang_produk_pkey PRIMARY KEY (item_pembayaran_hutang_produk_id);


--
-- TOC entry 5106 (class 2606 OID 25302)
-- Name: t_item_pembayaran_piutang_produk t_item_pembayaran_piutang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pembayaran_piutang_produk
    ADD CONSTRAINT t_item_pembayaran_piutang_pkey PRIMARY KEY (item_pembayaran_piutang_id);


--
-- TOC entry 5108 (class 2606 OID 25304)
-- Name: t_item_pengeluaran_biaya t_item_pengeluaran_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pengeluaran_biaya
    ADD CONSTRAINT t_item_pengeluaran_pkey PRIMARY KEY (item_pengeluaran_id);


--
-- TOC entry 5110 (class 2606 OID 25306)
-- Name: t_item_retur_beli_produk t_item_retur_beli_produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_beli_produk
    ADD CONSTRAINT t_item_retur_beli_produk_pkey PRIMARY KEY (item_retur_beli_produk_id);


--
-- TOC entry 5112 (class 2606 OID 25308)
-- Name: t_item_retur_jual_produk t_item_retur_jual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_jual_produk
    ADD CONSTRAINT t_item_retur_jual_pkey PRIMARY KEY (item_retur_jual_id);


--
-- TOC entry 5114 (class 2606 OID 25310)
-- Name: t_jual_produk t_jual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_jual_produk
    ADD CONSTRAINT t_jual_pkey PRIMARY KEY (jual_id);


--
-- TOC entry 5123 (class 2606 OID 25312)
-- Name: t_kasbon t_kasbon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_kasbon
    ADD CONSTRAINT t_kasbon_pkey PRIMARY KEY (kasbon_id);


--
-- TOC entry 5125 (class 2606 OID 25314)
-- Name: t_logs t_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_logs
    ADD CONSTRAINT t_logs_pkey PRIMARY KEY (log_id);


--
-- TOC entry 5129 (class 2606 OID 25316)
-- Name: t_mesin t_mesin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_mesin
    ADD CONSTRAINT t_mesin_pkey PRIMARY KEY (mesin_id);


--
-- TOC entry 5136 (class 2606 OID 25318)
-- Name: t_pembayaran_kasbon t_pembayaran_bon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_kasbon
    ADD CONSTRAINT t_pembayaran_bon_pkey PRIMARY KEY (pembayaran_kasbon_id);


--
-- TOC entry 5134 (class 2606 OID 25320)
-- Name: t_pembayaran_hutang_produk t_pembayaran_hutang_produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_hutang_produk
    ADD CONSTRAINT t_pembayaran_hutang_produk_pkey PRIMARY KEY (pembayaran_hutang_produk_id);


--
-- TOC entry 5140 (class 2606 OID 25322)
-- Name: t_pembayaran_piutang_produk t_pembayaran_piutang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_piutang_produk
    ADD CONSTRAINT t_pembayaran_piutang_pkey PRIMARY KEY (pembayaran_piutang_id);


--
-- TOC entry 5147 (class 2606 OID 25324)
-- Name: t_pengeluaran_biaya t_pengeluaran_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pengeluaran_biaya
    ADD CONSTRAINT t_pengeluaran_pkey PRIMARY KEY (pengeluaran_id);


--
-- TOC entry 5150 (class 2606 OID 25326)
-- Name: t_penyesuaian_stok t_penyesuaian_stok_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_penyesuaian_stok
    ADD CONSTRAINT t_penyesuaian_stok_pkey PRIMARY KEY (penyesuaian_stok_id);


--
-- TOC entry 5154 (class 2606 OID 25328)
-- Name: t_retur_beli_produk t_retur_beli_produk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_retur_beli_produk
    ADD CONSTRAINT t_retur_beli_produk_pkey PRIMARY KEY (retur_beli_produk_id);


--
-- TOC entry 5156 (class 2606 OID 25330)
-- Name: t_retur_jual_produk t_retur_jual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_retur_jual_produk
    ADD CONSTRAINT t_retur_jual_pkey PRIMARY KEY (retur_jual_id);


--
-- TOC entry 5018 (class 2606 OID 57925)
-- Name: m_customer uq_m_customer_kode_customer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_customer
    ADD CONSTRAINT uq_m_customer_kode_customer UNIQUE (kode_customer);


--
-- TOC entry 5014 (class 1259 OID 25331)
-- Name: m_customer_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_customer_idx ON public.m_customer USING btree (nama_customer);


--
-- TOC entry 5042 (class 1259 OID 25332)
-- Name: m_kabupaten2_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_kabupaten2_idx ON public.m_kabupaten2 USING btree (provinsi_id);


--
-- TOC entry 5043 (class 1259 OID 25333)
-- Name: m_kabupaten2_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_kabupaten2_idx1 ON public.m_kabupaten2 USING btree (nama_kabupaten);


--
-- TOC entry 5039 (class 1259 OID 25334)
-- Name: m_kabupaten_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_kabupaten_idx ON public.m_kabupaten USING btree (nama_kabupaten);


--
-- TOC entry 5050 (class 1259 OID 25335)
-- Name: m_kecamatan_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_kecamatan_idx ON public.m_kecamatan USING btree (kabupaten_id);


--
-- TOC entry 5051 (class 1259 OID 25336)
-- Name: m_kecamatan_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_kecamatan_idx1 ON public.m_kecamatan USING btree (nama_kecamatan);


--
-- TOC entry 5062 (class 1259 OID 25337)
-- Name: m_produk_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_produk_idx ON public.m_produk USING btree (nama_produk);


--
-- TOC entry 5063 (class 1259 OID 25338)
-- Name: m_produk_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_produk_idx1 ON public.m_produk USING btree (kode_produk);


--
-- TOC entry 5064 (class 1259 OID 25339)
-- Name: m_produk_idx2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_produk_idx2 ON public.m_produk USING btree (golongan_id);


--
-- TOC entry 5065 (class 1259 OID 25340)
-- Name: m_produk_idx3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_produk_idx3 ON public.m_produk USING btree (is_aktif);


--
-- TOC entry 5073 (class 1259 OID 25341)
-- Name: m_provinsi2_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_provinsi2_idx ON public.m_provinsi2 USING btree (nama_provinsi);


--
-- TOC entry 5070 (class 1259 OID 25342)
-- Name: m_provinsi_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_provinsi_idx ON public.m_provinsi USING btree (nama_provinsi);


--
-- TOC entry 5084 (class 1259 OID 25343)
-- Name: m_supplier_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX m_supplier_idx ON public.m_supplier USING btree (nama_supplier);


--
-- TOC entry 5087 (class 1259 OID 25344)
-- Name: t_beli_produk_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_beli_produk_idx ON public.t_beli_produk USING btree (tanggal);


--
-- TOC entry 5088 (class 1259 OID 25345)
-- Name: t_beli_produk_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_beli_produk_idx1 ON public.t_beli_produk USING btree (nota);


--
-- TOC entry 5089 (class 1259 OID 25346)
-- Name: t_beli_produk_idx2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_beli_produk_idx2 ON public.t_beli_produk USING btree (tanggal_tempo);


--
-- TOC entry 5090 (class 1259 OID 25347)
-- Name: t_beli_produk_idx3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_beli_produk_idx3 ON public.t_beli_produk USING btree (supplier_id);


--
-- TOC entry 5091 (class 1259 OID 25348)
-- Name: t_beli_produk_idx4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_beli_produk_idx4 ON public.t_beli_produk USING btree (pengguna_id);


--
-- TOC entry 5094 (class 1259 OID 25349)
-- Name: t_gaji_karyawan_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_gaji_karyawan_idx ON public.t_gaji_karyawan USING btree (bulan, tahun);


--
-- TOC entry 5095 (class 1259 OID 25350)
-- Name: t_gaji_karyawan_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_gaji_karyawan_idx1 ON public.t_gaji_karyawan USING btree (tanggal);


--
-- TOC entry 5096 (class 1259 OID 25351)
-- Name: t_gaji_karyawan_idx2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_gaji_karyawan_idx2 ON public.t_gaji_karyawan USING btree (nota);


--
-- TOC entry 5115 (class 1259 OID 25352)
-- Name: t_jual_produk_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_jual_produk_idx ON public.t_jual_produk USING btree (nota);


--
-- TOC entry 5116 (class 1259 OID 25353)
-- Name: t_jual_produk_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_jual_produk_idx1 ON public.t_jual_produk USING btree (tanggal);


--
-- TOC entry 5117 (class 1259 OID 25354)
-- Name: t_jual_produk_idx2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_jual_produk_idx2 ON public.t_jual_produk USING btree (tanggal_tempo);


--
-- TOC entry 5118 (class 1259 OID 25355)
-- Name: t_jual_produk_idx3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_jual_produk_idx3 ON public.t_jual_produk USING btree (customer_id);


--
-- TOC entry 5119 (class 1259 OID 25356)
-- Name: t_jual_produk_idx4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_jual_produk_idx4 ON public.t_jual_produk USING btree (pengguna_id);


--
-- TOC entry 5120 (class 1259 OID 25357)
-- Name: t_kasbon_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_kasbon_idx ON public.t_kasbon USING btree (tanggal);


--
-- TOC entry 5121 (class 1259 OID 25358)
-- Name: t_kasbon_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_kasbon_idx1 ON public.t_kasbon USING btree (nota);


--
-- TOC entry 5126 (class 1259 OID 25359)
-- Name: t_mesin_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_mesin_idx ON public.t_mesin USING btree (tanggal);


--
-- TOC entry 5127 (class 1259 OID 25360)
-- Name: t_mesin_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_mesin_idx1 ON public.t_mesin USING btree (pengguna_id);


--
-- TOC entry 5130 (class 1259 OID 25361)
-- Name: t_pembayaran_hutang_produk_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pembayaran_hutang_produk_idx ON public.t_pembayaran_hutang_produk USING btree (tanggal);


--
-- TOC entry 5131 (class 1259 OID 25362)
-- Name: t_pembayaran_hutang_produk_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pembayaran_hutang_produk_idx1 ON public.t_pembayaran_hutang_produk USING btree (nota);


--
-- TOC entry 5132 (class 1259 OID 25363)
-- Name: t_pembayaran_hutang_produk_idx2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pembayaran_hutang_produk_idx2 ON public.t_pembayaran_hutang_produk USING btree (supplier_id);


--
-- TOC entry 5137 (class 1259 OID 25364)
-- Name: t_pembayaran_kasbon_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pembayaran_kasbon_idx ON public.t_pembayaran_kasbon USING btree (tanggal);


--
-- TOC entry 5138 (class 1259 OID 25365)
-- Name: t_pembayaran_kasbon_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pembayaran_kasbon_idx1 ON public.t_pembayaran_kasbon USING btree (nota);


--
-- TOC entry 5141 (class 1259 OID 25366)
-- Name: t_pembayaran_piutang_produk_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pembayaran_piutang_produk_idx ON public.t_pembayaran_piutang_produk USING btree (tanggal);


--
-- TOC entry 5142 (class 1259 OID 25367)
-- Name: t_pembayaran_piutang_produk_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pembayaran_piutang_produk_idx1 ON public.t_pembayaran_piutang_produk USING btree (nota);


--
-- TOC entry 5143 (class 1259 OID 25368)
-- Name: t_pembayaran_piutang_produk_idx2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pembayaran_piutang_produk_idx2 ON public.t_pembayaran_piutang_produk USING btree (customer_id);


--
-- TOC entry 5144 (class 1259 OID 25369)
-- Name: t_pengeluaran_biaya_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pengeluaran_biaya_idx ON public.t_pengeluaran_biaya USING btree (tanggal);


--
-- TOC entry 5145 (class 1259 OID 25370)
-- Name: t_pengeluaran_biaya_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_pengeluaran_biaya_idx1 ON public.t_pengeluaran_biaya USING btree (nota);


--
-- TOC entry 5148 (class 1259 OID 25371)
-- Name: t_penyesuaian_stok_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_penyesuaian_stok_idx ON public.t_penyesuaian_stok USING btree (tanggal);


--
-- TOC entry 5151 (class 1259 OID 25372)
-- Name: t_retur_beli_produk_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_retur_beli_produk_idx ON public.t_retur_beli_produk USING btree (tanggal);


--
-- TOC entry 5152 (class 1259 OID 25373)
-- Name: t_retur_beli_produk_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_retur_beli_produk_idx1 ON public.t_retur_beli_produk USING btree (nota);


--
-- TOC entry 5157 (class 1259 OID 25374)
-- Name: t_retur_jual_produk_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_retur_jual_produk_idx ON public.t_retur_jual_produk USING btree (tanggal);


--
-- TOC entry 5158 (class 1259 OID 25375)
-- Name: t_retur_jual_produk_idx1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX t_retur_jual_produk_idx1 ON public.t_retur_jual_produk USING btree (nota);


--
-- TOC entry 5228 (class 2620 OID 25376)
-- Name: t_item_pembayaran_hutang_produk tr_hapus_header_ad; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_hapus_header_ad AFTER DELETE ON public.t_item_pembayaran_hutang_produk FOR EACH ROW EXECUTE FUNCTION public.f_hapus_header_bayar_hutang_produk();


--
-- TOC entry 5230 (class 2620 OID 25377)
-- Name: t_item_pembayaran_piutang_produk tr_hapus_header_ad; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_hapus_header_ad AFTER DELETE ON public.t_item_pembayaran_piutang_produk FOR EACH ROW EXECUTE FUNCTION public.f_hapus_header_bayar_piutang_produk();


--
-- TOC entry 5222 (class 2620 OID 25378)
-- Name: m_produk tr_log_last_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_log_last_update AFTER UPDATE OF harga_jual ON public.m_produk FOR EACH ROW EXECUTE FUNCTION public.fn_log_last_update();


--
-- TOC entry 5240 (class 2620 OID 25379)
-- Name: t_penyesuaian_stok tr_penyesuaian_stok_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_penyesuaian_stok_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_penyesuaian_stok FOR EACH ROW EXECUTE FUNCTION public.f_penyesuaian_stok_aiud();


--
-- TOC entry 5233 (class 2620 OID 25380)
-- Name: t_item_retur_beli_produk tr_update_jumlah_retur_beli; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_jumlah_retur_beli AFTER INSERT OR DELETE OR UPDATE ON public.t_item_retur_beli_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_jumlah_retur_beli();


--
-- TOC entry 5235 (class 2620 OID 25381)
-- Name: t_item_retur_jual_produk tr_update_jumlah_retur_jual; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_jumlah_retur_jual AFTER INSERT OR DELETE OR UPDATE ON public.t_item_retur_jual_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_jumlah_retur_jual();


--
-- TOC entry 5229 (class 2620 OID 25382)
-- Name: t_item_pembayaran_hutang_produk tr_update_pelunasan_beli_produk_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_pelunasan_beli_produk_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_pembayaran_hutang_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_pelunasan_beli_produk();


--
-- TOC entry 5231 (class 2620 OID 25383)
-- Name: t_item_pembayaran_piutang_produk tr_update_pelunasan_jual_produk_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_pelunasan_jual_produk_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_pembayaran_piutang_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_pelunasan_jual_produk();


--
-- TOC entry 5239 (class 2620 OID 25384)
-- Name: t_pembayaran_kasbon tr_update_pelunasan_kasbon_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_pelunasan_kasbon_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_pembayaran_kasbon FOR EACH ROW EXECUTE FUNCTION public.f_update_pelunasan_kasbon();


--
-- TOC entry 5224 (class 2620 OID 25385)
-- Name: t_item_beli_produk tr_update_stok_produk_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_stok_produk_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_beli_produk FOR EACH ROW EXECUTE FUNCTION public.f_tambah_stok_produk();


--
-- TOC entry 5226 (class 2620 OID 25386)
-- Name: t_item_jual_produk tr_update_stok_produk_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_stok_produk_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_jual_produk FOR EACH ROW EXECUTE FUNCTION public.f_kurangi_stok_produk();


--
-- TOC entry 5225 (class 2620 OID 25387)
-- Name: t_item_beli_produk tr_update_total_beli_produk_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_total_beli_produk_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_beli_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_total_beli_produk();


--
-- TOC entry 5223 (class 2620 OID 25388)
-- Name: t_beli_produk tr_update_total_hutang_produk_supplier; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_total_hutang_produk_supplier AFTER INSERT OR DELETE OR UPDATE ON public.t_beli_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_total_hutang_supplier();


--
-- TOC entry 5227 (class 2620 OID 25389)
-- Name: t_item_jual_produk tr_update_total_jual_produk_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_total_jual_produk_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_jual_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_total_jual_produk();


--
-- TOC entry 5238 (class 2620 OID 25390)
-- Name: t_kasbon tr_update_total_kasbon_karyawan; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_total_kasbon_karyawan AFTER INSERT OR DELETE OR UPDATE ON public.t_kasbon FOR EACH ROW EXECUTE FUNCTION public.f_update_total_kasbon_karyawan();


--
-- TOC entry 5232 (class 2620 OID 25391)
-- Name: t_item_pengeluaran_biaya tr_update_total_pengeluaran_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_total_pengeluaran_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_pengeluaran_biaya FOR EACH ROW EXECUTE FUNCTION public.f_update_total_pengeluaran();


--
-- TOC entry 5237 (class 2620 OID 25392)
-- Name: t_jual_produk tr_update_total_piutang_customer; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_total_piutang_customer AFTER INSERT OR DELETE OR UPDATE ON public.t_jual_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_total_piutang_customer();


--
-- TOC entry 5234 (class 2620 OID 25393)
-- Name: t_item_retur_beli_produk tr_update_total_retur_beli_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_total_retur_beli_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_retur_beli_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_total_retur_beli_aiud();


--
-- TOC entry 5236 (class 2620 OID 25394)
-- Name: t_item_retur_jual_produk tr_update_total_retur_produk_aiud; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr_update_total_retur_produk_aiud AFTER INSERT OR DELETE OR UPDATE ON public.t_item_retur_jual_produk FOR EACH ROW EXECUTE FUNCTION public.f_update_total_retur_produk_aiud();


--
-- TOC entry 5161 (class 2606 OID 25395)
-- Name: m_harga_grosir m_harga_grosir_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_harga_grosir
    ADD CONSTRAINT m_harga_grosir_fk FOREIGN KEY (produk_id) REFERENCES public.m_produk(produk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5162 (class 2606 OID 25400)
-- Name: m_item_menu m_item_menu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_item_menu
    ADD CONSTRAINT m_item_menu_fk FOREIGN KEY (menu_id) REFERENCES public.m_menu(menu_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5164 (class 2606 OID 25405)
-- Name: m_kabupaten2 m_kabupaten2_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_kabupaten2
    ADD CONSTRAINT m_kabupaten2_fk FOREIGN KEY (provinsi_id) REFERENCES public.m_provinsi2(provinsi_id) ON UPDATE CASCADE;


--
-- TOC entry 5163 (class 2606 OID 25410)
-- Name: m_kabupaten m_kabupaten_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_kabupaten
    ADD CONSTRAINT m_kabupaten_fk FOREIGN KEY (provinsi_id) REFERENCES public.m_provinsi(provinsi_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5165 (class 2606 OID 25415)
-- Name: m_karyawan m_karyawan_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_karyawan
    ADD CONSTRAINT m_karyawan_fk FOREIGN KEY (jabatan_id) REFERENCES public.m_jabatan(jabatan_id) ON UPDATE CASCADE;


--
-- TOC entry 5166 (class 2606 OID 25420)
-- Name: m_kecamatan m_kecamatan_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_kecamatan
    ADD CONSTRAINT m_kecamatan_fk FOREIGN KEY (kabupaten_id) REFERENCES public.m_kabupaten2(kabupaten_id) ON UPDATE CASCADE;


--
-- TOC entry 5167 (class 2606 OID 25425)
-- Name: m_pengguna m_pengguna_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_pengguna
    ADD CONSTRAINT m_pengguna_fk FOREIGN KEY (role_id) REFERENCES public.m_role(role_id) ON UPDATE CASCADE;


--
-- TOC entry 5168 (class 2606 OID 25430)
-- Name: m_produk m_produk_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_produk
    ADD CONSTRAINT m_produk_fk FOREIGN KEY (golongan_id) REFERENCES public.m_golongan(golongan_id) ON UPDATE CASCADE;


--
-- TOC entry 5169 (class 2606 OID 25435)
-- Name: m_role_privilege m_role_privilege_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_role_privilege
    ADD CONSTRAINT m_role_privilege_fk FOREIGN KEY (menu_id) REFERENCES public.m_menu(menu_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5170 (class 2606 OID 25440)
-- Name: m_role_privilege m_role_privilege_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.m_role_privilege
    ADD CONSTRAINT m_role_privilege_fk1 FOREIGN KEY (role_id) REFERENCES public.m_role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5171 (class 2606 OID 25445)
-- Name: t_beli_produk t_beli_produk_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_beli_produk
    ADD CONSTRAINT t_beli_produk_fk FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5172 (class 2606 OID 25450)
-- Name: t_beli_produk t_beli_produk_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_beli_produk
    ADD CONSTRAINT t_beli_produk_fk1 FOREIGN KEY (supplier_id) REFERENCES public.m_supplier(supplier_id) ON UPDATE CASCADE;


--
-- TOC entry 5173 (class 2606 OID 25455)
-- Name: t_beli_produk t_beli_produk_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_beli_produk
    ADD CONSTRAINT t_beli_produk_fk2 FOREIGN KEY (retur_beli_produk_id) REFERENCES public.t_retur_beli_produk(retur_beli_produk_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5203 (class 2606 OID 25460)
-- Name: t_kasbon t_bon_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_kasbon
    ADD CONSTRAINT t_bon_fk FOREIGN KEY (karyawan_id) REFERENCES public.m_karyawan(karyawan_id) ON UPDATE CASCADE;


--
-- TOC entry 5204 (class 2606 OID 25465)
-- Name: t_kasbon t_bon_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_kasbon
    ADD CONSTRAINT t_bon_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5174 (class 2606 OID 25470)
-- Name: t_gaji_karyawan t_gaji_karyawan_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_gaji_karyawan
    ADD CONSTRAINT t_gaji_karyawan_fk FOREIGN KEY (karyawan_id) REFERENCES public.m_karyawan(karyawan_id) ON UPDATE CASCADE;


--
-- TOC entry 5175 (class 2606 OID 25475)
-- Name: t_gaji_karyawan t_gaji_karyawan_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_gaji_karyawan
    ADD CONSTRAINT t_gaji_karyawan_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5176 (class 2606 OID 25480)
-- Name: t_item_beli_produk t_item_beli_produk_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_beli_produk
    ADD CONSTRAINT t_item_beli_produk_fk FOREIGN KEY (beli_produk_id) REFERENCES public.t_beli_produk(beli_produk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5177 (class 2606 OID 25485)
-- Name: t_item_beli_produk t_item_beli_produk_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_beli_produk
    ADD CONSTRAINT t_item_beli_produk_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5178 (class 2606 OID 25490)
-- Name: t_item_beli_produk t_item_beli_produk_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_beli_produk
    ADD CONSTRAINT t_item_beli_produk_fk2 FOREIGN KEY (produk_id) REFERENCES public.m_produk(produk_id) ON UPDATE CASCADE;


--
-- TOC entry 5179 (class 2606 OID 25495)
-- Name: t_item_jual_produk t_item_jual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_jual_produk
    ADD CONSTRAINT t_item_jual_fk FOREIGN KEY (jual_id) REFERENCES public.t_jual_produk(jual_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5180 (class 2606 OID 25500)
-- Name: t_item_jual_produk t_item_jual_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_jual_produk
    ADD CONSTRAINT t_item_jual_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5181 (class 2606 OID 25505)
-- Name: t_item_jual_produk t_item_jual_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_jual_produk
    ADD CONSTRAINT t_item_jual_fk2 FOREIGN KEY (produk_id) REFERENCES public.m_produk(produk_id) ON UPDATE CASCADE;


--
-- TOC entry 5182 (class 2606 OID 25510)
-- Name: t_item_pembayaran_hutang_produk t_item_pembayaran_hutang_produk_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pembayaran_hutang_produk
    ADD CONSTRAINT t_item_pembayaran_hutang_produk_fk FOREIGN KEY (pembayaran_hutang_produk_id) REFERENCES public.t_pembayaran_hutang_produk(pembayaran_hutang_produk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5183 (class 2606 OID 25515)
-- Name: t_item_pembayaran_hutang_produk t_item_pembayaran_hutang_produk_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pembayaran_hutang_produk
    ADD CONSTRAINT t_item_pembayaran_hutang_produk_fk1 FOREIGN KEY (beli_produk_id) REFERENCES public.t_beli_produk(beli_produk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5184 (class 2606 OID 25520)
-- Name: t_item_pembayaran_piutang_produk t_item_pembayaran_piutang_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pembayaran_piutang_produk
    ADD CONSTRAINT t_item_pembayaran_piutang_fk FOREIGN KEY (pembayaran_piutang_id) REFERENCES public.t_pembayaran_piutang_produk(pembayaran_piutang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5185 (class 2606 OID 25525)
-- Name: t_item_pembayaran_piutang_produk t_item_pembayaran_piutang_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pembayaran_piutang_produk
    ADD CONSTRAINT t_item_pembayaran_piutang_fk1 FOREIGN KEY (jual_id) REFERENCES public.t_jual_produk(jual_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5186 (class 2606 OID 25530)
-- Name: t_item_pengeluaran_biaya t_item_pengeluaran_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pengeluaran_biaya
    ADD CONSTRAINT t_item_pengeluaran_fk FOREIGN KEY (pengeluaran_id) REFERENCES public.t_pengeluaran_biaya(pengeluaran_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5187 (class 2606 OID 25535)
-- Name: t_item_pengeluaran_biaya t_item_pengeluaran_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pengeluaran_biaya
    ADD CONSTRAINT t_item_pengeluaran_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5188 (class 2606 OID 25540)
-- Name: t_item_pengeluaran_biaya t_item_pengeluaran_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_pengeluaran_biaya
    ADD CONSTRAINT t_item_pengeluaran_fk2 FOREIGN KEY (jenis_pengeluaran_id) REFERENCES public.m_jenis_pengeluaran(jenis_pengeluaran_id) ON UPDATE CASCADE;


--
-- TOC entry 5189 (class 2606 OID 25545)
-- Name: t_item_retur_beli_produk t_item_retur_beli_produk_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_beli_produk
    ADD CONSTRAINT t_item_retur_beli_produk_fk FOREIGN KEY (retur_beli_produk_id) REFERENCES public.t_retur_beli_produk(retur_beli_produk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5190 (class 2606 OID 25550)
-- Name: t_item_retur_beli_produk t_item_retur_beli_produk_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_beli_produk
    ADD CONSTRAINT t_item_retur_beli_produk_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5191 (class 2606 OID 25555)
-- Name: t_item_retur_beli_produk t_item_retur_beli_produk_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_beli_produk
    ADD CONSTRAINT t_item_retur_beli_produk_fk2 FOREIGN KEY (produk_id) REFERENCES public.m_produk(produk_id) ON UPDATE CASCADE;


--
-- TOC entry 5192 (class 2606 OID 25560)
-- Name: t_item_retur_beli_produk t_item_retur_beli_produk_fk3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_beli_produk
    ADD CONSTRAINT t_item_retur_beli_produk_fk3 FOREIGN KEY (item_beli_id) REFERENCES public.t_item_beli_produk(item_beli_produk_id) ON UPDATE CASCADE;


--
-- TOC entry 5193 (class 2606 OID 25565)
-- Name: t_item_retur_jual_produk t_item_retur_jual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_jual_produk
    ADD CONSTRAINT t_item_retur_jual_fk FOREIGN KEY (retur_jual_id) REFERENCES public.t_retur_jual_produk(retur_jual_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5194 (class 2606 OID 25570)
-- Name: t_item_retur_jual_produk t_item_retur_jual_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_jual_produk
    ADD CONSTRAINT t_item_retur_jual_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5195 (class 2606 OID 25575)
-- Name: t_item_retur_jual_produk t_item_retur_jual_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_jual_produk
    ADD CONSTRAINT t_item_retur_jual_fk2 FOREIGN KEY (produk_id) REFERENCES public.m_produk(produk_id) ON UPDATE CASCADE;


--
-- TOC entry 5196 (class 2606 OID 25580)
-- Name: t_item_retur_jual_produk t_item_retur_jual_fk3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_item_retur_jual_produk
    ADD CONSTRAINT t_item_retur_jual_fk3 FOREIGN KEY (item_jual_id) REFERENCES public.t_item_jual_produk(item_jual_id) ON UPDATE CASCADE;


--
-- TOC entry 5197 (class 2606 OID 25585)
-- Name: t_jual_produk t_jual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_jual_produk
    ADD CONSTRAINT t_jual_fk FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5198 (class 2606 OID 25590)
-- Name: t_jual_produk t_jual_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_jual_produk
    ADD CONSTRAINT t_jual_fk1 FOREIGN KEY (customer_id) REFERENCES public.m_customer(customer_id) ON UPDATE CASCADE;


--
-- TOC entry 5199 (class 2606 OID 25595)
-- Name: t_jual_produk t_jual_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_jual_produk
    ADD CONSTRAINT t_jual_fk2 FOREIGN KEY (retur_jual_id) REFERENCES public.t_retur_jual_produk(retur_jual_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5200 (class 2606 OID 25600)
-- Name: t_jual_produk t_jual_fk3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_jual_produk
    ADD CONSTRAINT t_jual_fk3 FOREIGN KEY (shift_id) REFERENCES public.m_shift(shift_id) ON UPDATE CASCADE;


--
-- TOC entry 5201 (class 2606 OID 25605)
-- Name: t_jual_produk t_jual_fk4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_jual_produk
    ADD CONSTRAINT t_jual_fk4 FOREIGN KEY (dropshipper_id) REFERENCES public.m_dropshipper(dropshipper_id) ON UPDATE CASCADE;


--
-- TOC entry 5202 (class 2606 OID 25610)
-- Name: t_jual_produk t_jual_fk5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_jual_produk
    ADD CONSTRAINT t_jual_fk5 FOREIGN KEY (kartu_id) REFERENCES public.m_kartu(kartu_id) ON UPDATE CASCADE;


--
-- TOC entry 5205 (class 2606 OID 25615)
-- Name: t_mesin t_mesin_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_mesin
    ADD CONSTRAINT t_mesin_fk FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5208 (class 2606 OID 25620)
-- Name: t_pembayaran_kasbon t_pembayaran_bon_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_kasbon
    ADD CONSTRAINT t_pembayaran_bon_fk1 FOREIGN KEY (gaji_karyawan_id) REFERENCES public.t_gaji_karyawan(gaji_karyawan_id) ON UPDATE CASCADE;


--
-- TOC entry 5209 (class 2606 OID 25625)
-- Name: t_pembayaran_kasbon t_pembayaran_bon_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_kasbon
    ADD CONSTRAINT t_pembayaran_bon_fk2 FOREIGN KEY (kasbon_id) REFERENCES public.t_kasbon(kasbon_id) ON UPDATE CASCADE;


--
-- TOC entry 5206 (class 2606 OID 25630)
-- Name: t_pembayaran_hutang_produk t_pembayaran_hutang_produk_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_hutang_produk
    ADD CONSTRAINT t_pembayaran_hutang_produk_fk FOREIGN KEY (supplier_id) REFERENCES public.m_supplier(supplier_id) ON UPDATE CASCADE;


--
-- TOC entry 5207 (class 2606 OID 25635)
-- Name: t_pembayaran_hutang_produk t_pembayaran_hutang_produk_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_hutang_produk
    ADD CONSTRAINT t_pembayaran_hutang_produk_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5210 (class 2606 OID 25640)
-- Name: t_pembayaran_kasbon t_pembayaran_kasbon_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_kasbon
    ADD CONSTRAINT t_pembayaran_kasbon_fk FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5211 (class 2606 OID 25645)
-- Name: t_pembayaran_piutang_produk t_pembayaran_piutang_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_piutang_produk
    ADD CONSTRAINT t_pembayaran_piutang_fk FOREIGN KEY (customer_id) REFERENCES public.m_customer(customer_id) ON UPDATE CASCADE;


--
-- TOC entry 5212 (class 2606 OID 25650)
-- Name: t_pembayaran_piutang_produk t_pembayaran_piutang_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pembayaran_piutang_produk
    ADD CONSTRAINT t_pembayaran_piutang_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5213 (class 2606 OID 25655)
-- Name: t_pengeluaran_biaya t_pengeluaran_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_pengeluaran_biaya
    ADD CONSTRAINT t_pengeluaran_fk FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5214 (class 2606 OID 25660)
-- Name: t_penyesuaian_stok t_penyesuaian_stok_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_penyesuaian_stok
    ADD CONSTRAINT t_penyesuaian_stok_fk FOREIGN KEY (produk_id) REFERENCES public.m_produk(produk_id) ON UPDATE CASCADE;


--
-- TOC entry 5215 (class 2606 OID 25665)
-- Name: t_penyesuaian_stok t_penyesuaian_stok_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_penyesuaian_stok
    ADD CONSTRAINT t_penyesuaian_stok_fk1 FOREIGN KEY (alasan_penyesuaian_id) REFERENCES public.m_alasan_penyesuaian_stok(alasan_penyesuaian_stok_id) ON UPDATE CASCADE;


--
-- TOC entry 5216 (class 2606 OID 25670)
-- Name: t_retur_beli_produk t_retur_beli_produk_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_retur_beli_produk
    ADD CONSTRAINT t_retur_beli_produk_fk FOREIGN KEY (beli_produk_id) REFERENCES public.t_beli_produk(beli_produk_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5217 (class 2606 OID 25675)
-- Name: t_retur_beli_produk t_retur_beli_produk_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_retur_beli_produk
    ADD CONSTRAINT t_retur_beli_produk_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5218 (class 2606 OID 25680)
-- Name: t_retur_beli_produk t_retur_beli_produk_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_retur_beli_produk
    ADD CONSTRAINT t_retur_beli_produk_fk2 FOREIGN KEY (supplier_id) REFERENCES public.m_supplier(supplier_id) ON UPDATE CASCADE;


--
-- TOC entry 5219 (class 2606 OID 25685)
-- Name: t_retur_jual_produk t_retur_jual_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_retur_jual_produk
    ADD CONSTRAINT t_retur_jual_fk FOREIGN KEY (jual_id) REFERENCES public.t_jual_produk(jual_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5220 (class 2606 OID 25690)
-- Name: t_retur_jual_produk t_retur_jual_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_retur_jual_produk
    ADD CONSTRAINT t_retur_jual_fk1 FOREIGN KEY (pengguna_id) REFERENCES public.m_pengguna(pengguna_id) ON UPDATE CASCADE;


--
-- TOC entry 5221 (class 2606 OID 25695)
-- Name: t_retur_jual_produk t_retur_jual_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_retur_jual_produk
    ADD CONSTRAINT t_retur_jual_fk2 FOREIGN KEY (customer_id) REFERENCES public.m_customer(customer_id) ON UPDATE CASCADE;


--
-- TOC entry 5455 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2026-09-25 19:46:49

--
-- PostgreSQL database dump complete
--

\unrestrict QTQkcbFV109ROHvh9hm4dgfrdW1s9ConC05ipg2hmNGTktsdcjyEdvSDYRySa9O

