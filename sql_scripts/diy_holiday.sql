/*
COURSE CODE: UCCD2303
PROGRAMME (IA/IB/CS)/DE): CS
GROUP NUMBER: G064
GROUP LEADER NAME & EMAIL: Leow Hui Yu & l.huiyu19@1utar.my
MEMBER 2 NAME: Boon Jia Xuan
MEMBER 3 NAME: Lee Jia Xuan
MEMBER 4 NAME: Tan Yi Hui 
Submission date and time (DD-MON-YY): 24-04-2026 4pm
*/

Rem
Rem    NAME
Rem      diy_holiday.sql - Create data objects for DIY Holiday schema
Rem
Rem    DESCRIPTION
Rem      This script creates 21 tables, associated constraints,
Rem      inserts sample data and applies terminal display formatting.
Rem

REM Before creating the tables
REM drop all tables first

-- Children first, Parents last
DROP TABLE ticket CASCADE CONSTRAINTS;
DROP TABLE flight_reservation CASCADE CONSTRAINTS;
DROP TABLE hotel_reservation CASCADE CONSTRAINTS;
DROP TABLE transport_reservation CASCADE CONSTRAINTS;
DROP TABLE transport CASCADE CONSTRAINTS;
DROP TABLE hotel CASCADE CONSTRAINTS;
DROP TABLE flight CASCADE CONSTRAINTS;
DROP TABLE package_service CASCADE CONSTRAINTS;
DROP TABLE package_guide CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE reservation CASCADE CONSTRAINTS;
DROP TABLE booking CASCADE CONSTRAINTS;
DROP TABLE service CASCADE CONSTRAINTS;
DROP TABLE itinerary CASCADE CONSTRAINTS;
DROP TABLE airline CASCADE CONSTRAINTS;
DROP TABLE hotel_provider CASCADE CONSTRAINTS;
DROP TABLE transport_provider CASCADE CONSTRAINTS;
DROP TABLE tour_guide CASCADE CONSTRAINTS;
DROP TABLE tour_package CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE supplier CASCADE CONSTRAINTS;

SET DEFINE OFF;

REM ********************************************************************
REM Apply Terminal Display Formatting (For neat SELECT/DESCRIBE outputs)
REM ********************************************************************
SET LINESIZE 138;
SET PAGESIZE 100;
SET WRAP ON;

ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'DD-MON-RR HH24:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

-- COMMON IDS
COLUMN customer_id FORMAT A12;
COLUMN package_id FORMAT A10;
COLUMN guide_id FORMAT A10;
COLUMN service_id FORMAT A10;
COLUMN supplier_id FORMAT A12;
COLUMN booking_id FORMAT A10;
COLUMN reservation_id FORMAT A14;
COLUMN payment_id FORMAT A10;
COLUMN ticket_id FORMAT A10;

-- CUSTOMER
COLUMN first_name FORMAT A15;
COLUMN last_name FORMAT A15;
COLUMN email FORMAT A30;
COLUMN address FORMAT A30;
COLUMN phone_no FORMAT A15;
COLUMN passport_no FORMAT A15;

-- TOUR GUIDE
COLUMN staff_first_name FORMAT A15;
COLUMN staff_last_name FORMAT A15;
COLUMN staff_contact_no FORMAT A15;
COLUMN language FORMAT A25;

-- TOUR PACKAGE
COLUMN package_type FORMAT A15;
COLUMN package_price FORMAT 999,999.00;
COLUMN package_description FORMAT A40;
COLUMN duration FORMAT A20;

-- PACKAGE GUIDE
COLUMN assignment_role FORMAT A20;
COLUMN start_date FORMAT A12;
COLUMN end_date FORMAT A12;

-- PAYMENT
COLUMN payment_amount FORMAT 999,999.00;
COLUMN payment_method FORMAT A20;
COLUMN payment_datetime FORMAT A20;
COLUMN payment_status FORMAT A12;

-- TICKET
COLUMN ticket_no FORMAT A15;
COLUMN seat_no FORMAT A8;
COLUMN issue_date FORMAT A12;
COLUMN ticket_status FORMAT A12;

-- SUPPLIER
COLUMN supplier_name FORMAT A25;
COLUMN company_name FORMAT A25;
COLUMN supplier_contact_no FORMAT A20;
COLUMN email FORMAT A35;

-- SERVICE
COLUMN service_name FORMAT A25;
COLUMN service_price FORMAT 999,999.00;
COLUMN custom_price FORMAT 999,999.00;

-- AIRLINE
COLUMN airline_name FORMAT A25;
COLUMN iata_code FORMAT A8;

-- FLIGHT
COLUMN flight_number FORMAT A10;
COLUMN departure_airport FORMAT A10;
COLUMN arrival_airport FORMAT A10;
COLUMN departure_time FORMAT A20;
COLUMN arrival_time FORMAT A20;
COLUMN duration FORMAT A10;
COLUMN boarding_gate FORMAT A8;

-- HOTEL
COLUMN hotel_name FORMAT A25;
COLUMN location FORMAT A25;
COLUMN room_type FORMAT A20;
COLUMN price_per_night FORMAT 999,999.00;

-- TRANSPORT
COLUMN vehicle_type FORMAT A20;
COLUMN capacity FORMAT A25;
COLUMN base_location FORMAT A25;

-- TRANSPORT RESERVATION
COLUMN pick_up_location FORMAT A20;
COLUMN drop_off_location FORMAT A25;
COLUMN pick_up_datetime FORMAT A20;
COLUMN drop_off_datetime FORMAT A20;

-- BOOKING 
COLUMN booking_date FORMAT A20;
COLUMN total_price FORMAT 999,999.00;
COLUMN booking_status FORMAT A15;

-- RESERVATION
COLUMN reservation_date FORMAT A15;
COLUMN reservation_status FORMAT A20;

-- ITINERARY
COLUMN activity FORMAT A35;
COLUMN time FORMAT A10;
COLUMN location FORMAT A30;

-- STAR RATING
COLUMN star_rating FORMAT 9.9;

REM ********************************************************************
REM Create the CUSTOMER table 

Prompt ****** Creating CUSTOMER table ....

CREATE TABLE customer
    ( customer_id    CHAR(7) 
    , first_name     VARCHAR2(50) 
        CONSTRAINT cust_fname_nn NOT NULL 
    , last_name      VARCHAR2(50) 
        CONSTRAINT cust_lname_nn NOT NULL 
    , email          VARCHAR2(100)
    , address        VARCHAR2(225) 
    , phone_no       VARCHAR2(15) 
	CONSTRAINT cust_phone_no_nn NOT NULL
    , passport_no    VARCHAR2(20)
	CONSTRAINT cust_passport_no_nn NOT NULL
    ) ;

ALTER TABLE customer
ADD ( CONSTRAINT cust_id_pk
                 PRIMARY KEY (customer_id)
    , CONSTRAINT cust_email_uk 
		 UNIQUE (email)
    , CONSTRAINT cust_passport_no_uk
		 UNIQUE (passport_no)
    ) ;

REM ********************************************************************
REM Create the TOUR_PACKAGE table 

Prompt ****** Creating TOUR_PACKAGE table ....

CREATE TABLE tour_package
    ( package_id          CHAR(6) 
    , package_type        VARCHAR2(50) 
	CONSTRAINT pkg_type_nn NOT NULL
    , package_description VARCHAR2(200)
    , duration            VARCHAR2(50)
	CONSTRAINT pkg_duration_nn NOT NULL
    , package_price       NUMBER(8, 2) 
        CONSTRAINT pkg_price_nn NOT NULL 
    ) ;

ALTER TABLE tour_package
ADD ( CONSTRAINT pkg_id_pk
                 PRIMARY KEY (package_id)
    ) ;

REM ********************************************************************
REM Create the SUPPLIER table (Supertype)

Prompt ****** Creating SUPPLIER table ....

CREATE TABLE supplier
    ( supplier_id         CHAR(6) 
    , supplier_name       VARCHAR2(100) 
        CONSTRAINT supp_name_nn NOT NULL 
    , supplier_contact_no VARCHAR2(15) 
    , email               VARCHAR2(50) 
    ) ;

ALTER TABLE supplier
ADD ( CONSTRAINT supp_id_pk
                 PRIMARY KEY (supplier_id)
    , CONSTRAINT supp_name_uk 
		 UNIQUE (supplier_name)
    , CONSTRAINT supp_email_uk 
		 UNIQUE (email)
    ) ;

REM ********************************************************************
REM Create the TOUR_GUIDE table 

Prompt ****** Creating TOUR_GUIDE table ....

CREATE TABLE tour_guide
    ( guide_id           CHAR(6) 
    , staff_first_name   VARCHAR2(100) 
	CONSTRAINT staff_fname_nn NOT NULL 
    , staff_last_name    VARCHAR2(100) 
        CONSTRAINT staff_lname_nn NOT NULL 
    , staff_contact_no   VARCHAR2(15) 
	CONSTRAINT staff_contact_nn NOT NULL 
    , language           VARCHAR2(100) 
    ) ;

ALTER TABLE tour_guide
ADD ( CONSTRAINT tguide_id_pk
                 PRIMARY KEY (guide_id)
    ) ;

REM ********************************************************************
REM Create the AIRLINE table (Subtype of Supplier)

Prompt ****** Creating AIRLINE table ....

CREATE TABLE airline
    ( supplier_id  CHAR(6) 
    , airline_name VARCHAR2(100) 
        CONSTRAINT air_name_nn NOT NULL 
    , iata_code    CHAR(2) 
	CONSTRAINT iata_code_nn NOT NULL 
    ) ;

ALTER TABLE airline
ADD ( CONSTRAINT airline_id_pk
                 PRIMARY KEY (supplier_id)
    , CONSTRAINT airline_supp_fk
                 FOREIGN KEY (supplier_id)
                  REFERENCES supplier (supplier_id)
    , CONSTRAINT air_iata_uk 
		 UNIQUE (iata_code)
    ) ;

REM ********************************************************************
REM Create the HOTEL_PROVIDER table (Subtype of Supplier)

Prompt ****** Creating HOTEL_PROVIDER table ....

CREATE TABLE hotel_provider
    ( supplier_id CHAR(6) 
    , hotel_name  VARCHAR2(100) 
        CONSTRAINT hprov_name_nn NOT NULL 
    , star_rating NUMBER(2, 1) 
    ) ;

ALTER TABLE hotel_provider
ADD ( CONSTRAINT hprov_id_pk
                 PRIMARY KEY (supplier_id)
    , CONSTRAINT hprov_supp_fk
                 FOREIGN KEY (supplier_id)
                  REFERENCES supplier (supplier_id)
    ) ;

REM ********************************************************************
REM Create the TRANSPORT_PROVIDER table (Subtype of Supplier)

Prompt ****** Creating TRANSPORT_PROVIDER table ....

CREATE TABLE transport_provider
    ( supplier_id  CHAR(6) 
    , company_name VARCHAR2(100) 
        CONSTRAINT tprov_name_nn NOT NULL 
    ) ;

ALTER TABLE transport_provider
ADD ( CONSTRAINT tprov_id_pk
                 PRIMARY KEY (supplier_id)
    , CONSTRAINT tprov_supp_fk
                 FOREIGN KEY (supplier_id)
                  REFERENCES supplier (supplier_id)
    ) ;

REM ********************************************************************
REM Create the SERVICE table (Supertype)

Prompt ****** Creating SERVICE table ....

CREATE TABLE service
    ( service_id    CHAR(6) 
    , supplier_id   CHAR(6) 
        CONSTRAINT srv_supp_nn NOT NULL 
    , service_name  VARCHAR2(100) 
	CONSTRAINT srv_name_nn NOT NULL
    , service_price NUMBER(8, 2) 
	CONSTRAINT srv_price_nn NOT NULL
    ) ;

ALTER TABLE service
ADD ( CONSTRAINT srv_id_pk
                 PRIMARY KEY (service_id)
    , CONSTRAINT srv_supp_fk
                 FOREIGN KEY (supplier_id)
                  REFERENCES supplier (supplier_id)
    ) ;

REM ********************************************************************
REM Create the BOOKING table 

Prompt ****** Creating BOOKING table ....

CREATE TABLE booking
    ( booking_id     CHAR(6) 
    , customer_id    CHAR(7) 
        CONSTRAINT bkg_cust_nn NOT NULL 
    , package_id     CHAR(6) 
	CONSTRAINT pkg_pac_nn NOT NULL
    , booking_date   DATE DEFAULT SYSDATE 
	CONSTRAINT bk_date_nn NOT NULL
    , booking_status VARCHAR2(20) 
	CONSTRAINT bkg_status_nn NOT NULL
    , total_price    NUMBER(8, 2) 
	CONSTRAINT bkg_price_nn NOT NULL
    ) ;

ALTER TABLE booking
ADD ( CONSTRAINT bkg_id_pk
                 PRIMARY KEY (booking_id)
    , CONSTRAINT bkg_cust_fk
                 FOREIGN KEY (customer_id)
                  REFERENCES customer (customer_id)
    , CONSTRAINT bkg_pkg_fk
                 FOREIGN KEY (package_id)
                  REFERENCES tour_package (package_id)
    , CONSTRAINT bkg_status_ck 
		 CHECK (booking_status IN ('Confirmed','Pending','Cancelled'))
    ) ;

REM ********************************************************************
REM Create the ITINERARY table 

Prompt ****** Creating ITINERARY table ....

CREATE TABLE itinerary
    ( itinerary_id CHAR(6) 
    , package_id   CHAR(6) 
        CONSTRAINT itin_pkg_nn NOT NULL 
    , day_no       NUMBER(2) 
    , activity     VARCHAR2(200) 
    , location     VARCHAR2(200) 
    , time         VARCHAR2(8) 
    ) ;

ALTER TABLE itinerary
ADD ( CONSTRAINT itin_id_pk
                 PRIMARY KEY (itinerary_id)
    , CONSTRAINT itin_pkg_fk
                 FOREIGN KEY (package_id)
                  REFERENCES tour_package (package_id)
    , CONSTRAINT day_min 
		 CHECK (day_no > 0)
    ) ;

REM ********************************************************************
REM Create the FLIGHT table (Subtype of Service)

Prompt ****** Creating FLIGHT table ....

CREATE TABLE flight
    ( service_id        CHAR(6) 
    , flight_number     VARCHAR2(10) 
	CONSTRAINT flight_num_nn NOT NULL
    , departure_airport VARCHAR2(10) 
	CONSTRAINT dept_airport_nn NOT NULL 
    , arrival_airport   VARCHAR2(10) 
	CONSTRAINT arr_airport_nn NOT NULL 
    , departure_time    TIMESTAMP 
	CONSTRAINT dept_time_nn NOT NULL 
    , arrival_time      TIMESTAMP 
	CONSTRAINT arr_time_nn NOT NULL 
    , duration          VARCHAR2(20) 
	CONSTRAINT duration_nn NOT NULL 
    , boarding_gate     VARCHAR2(3) 
	CONSTRAINT board_gate_nn NOT NULL 
    ) ;

ALTER TABLE flight
ADD ( CONSTRAINT flight_id_pk
                 PRIMARY KEY (service_id)
    , CONSTRAINT flight_srv_fk
                 FOREIGN KEY (service_id)
                  REFERENCES service (service_id)
    , CONSTRAINT flight_no_uk 
		 UNIQUE (flight_number)
    ) ;

REM ********************************************************************
REM Create the HOTEL table (Subtype of Service)

Prompt ****** Creating HOTEL table ....

CREATE TABLE hotel
    ( service_id      CHAR(6) 
    , hotel_name      VARCHAR2(100) 
	CONSTRAINT htl_name_nn NOT NULL 
    , location        VARCHAR2(100) 
	CONSTRAINT location_nn NOT NULL 
    , room_type       VARCHAR2(50) 
	CONSTRAINT rm_type_nn NOT NULL 
    , price_per_night NUMBER(8, 2) 
	CONSTRAINT price_per_night_nn NOT NULL 
    ) ;

ALTER TABLE hotel
ADD ( CONSTRAINT hotel_id_pk
                 PRIMARY KEY (service_id)
    , CONSTRAINT hotel_srv_fk
                 FOREIGN KEY (service_id)
                  REFERENCES service (service_id)
    ) ;

REM ********************************************************************
REM Create the TRANSPORT table (Subtype of Service)

Prompt ****** Creating TRANSPORT table ....

CREATE TABLE transport
    ( service_id    CHAR(6) 
    , vehicle_type  VARCHAR2(50)
	CONSTRAINT vhcle_type_nn NOT NULL 
    , capacity      NUMBER(4) 
	CONSTRAINT capacity_nn NOT NULL 
    , base_location VARCHAR2(100) 
	CONSTRAINT base_loc_nn NOT NULL 
    ) ;

ALTER TABLE transport
ADD ( CONSTRAINT transp_id_pk
                 PRIMARY KEY (service_id)
    , CONSTRAINT transp_srv_fk
                 FOREIGN KEY (service_id)
                  REFERENCES service (service_id)
    ) ;

REM ********************************************************************
REM Create the PACKAGE_SERVICE table (Associative Entity)

Prompt ****** Creating PACKAGE_SERVICE table ....

CREATE TABLE package_service
    ( package_id         CHAR(6)
    , service_id         CHAR(6) 
    , custom_price       NUMBER(8, 2) 
	CONSTRAINT custom_price_nn NOT NULL
    , sequence_no        NUMBER(3) 
	CONSTRAINT seq_no_nn NOT NULL
    ) ;

ALTER TABLE package_service
ADD ( CONSTRAINT pkg_srv_pk
                 PRIMARY KEY ( package_id, service_id)
    , CONSTRAINT pkg_srv_pkg_fk
                 FOREIGN KEY (package_id)
                  REFERENCES tour_package (package_id)
    , CONSTRAINT pkg_srv_srv_fk
                 FOREIGN KEY (service_id)
                  REFERENCES service (service_id)
    ) ;

REM ********************************************************************
REM Create the PACKAGE_GUIDE table 

Prompt ****** Creating PACKAGE_GUIDE table ....

CREATE TABLE package_guide
    ( package_id       CHAR(6) 
    , guide_id         CHAR(6) 
    , assignment_role  VARCHAR2(50) 
	CONSTRAINT asgm_role_nn NOT NULL 
    , start_date       DATE 
	CONSTRAINT start_dt_nn NOT NULL 
    , end_date         DATE 
	CONSTRAINT end_dt_nn NOT NULL 
    ) ;

ALTER TABLE package_guide
ADD ( CONSTRAINT pkgguide_pk
                 PRIMARY KEY (package_id, guide_id)
    , CONSTRAINT pkgguide_pkg_fk
                 FOREIGN KEY (package_id)
                  REFERENCES tour_package (package_id)
    , CONSTRAINT pkgguide_guide_fk
                 FOREIGN KEY (guide_id)
                  REFERENCES tour_guide (guide_id)
    , CONSTRAINT pkgguide_date_ck
		 CHECK (end_date >= start_date)
    ) ;

REM ********************************************************************
REM Create the PAYMENT table 

Prompt ****** Creating PAYMENT table ....

CREATE TABLE payment
    ( payment_id       CHAR(6) 
    , booking_id       CHAR(6) 
        CONSTRAINT pay_bkg_nn NOT NULL 
    , payment_amount   NUMBER(8, 2) 
        CONSTRAINT pay_amt_nn NOT NULL 
    , payment_method   VARCHAR2(30) 
	CONSTRAINT pay_method_nn NOT NULL
    , payment_datetime TIMESTAMP DEFAULT SYSDATE 
    , payment_status   VARCHAR2(20) 
	CONSTRAINT pay_status_nn NOT NULL
    ) ;

ALTER TABLE payment
ADD ( CONSTRAINT pay_id_pk
                 PRIMARY KEY (payment_id)
    , CONSTRAINT pay_bkg_fk
                 FOREIGN KEY (booking_id)
                  REFERENCES booking (booking_id)
    , CONSTRAINT pay_method_ck 
		 CHECK (payment_method IN ('Credit Card','Online Banking','E-Wallet'))
    , CONSTRAINT pay_status_ck 
		 CHECK (payment_status IN ('Success','Pending','Refunded'))
    , CONSTRAINT pay_amt_ck
		 CHECK (payment_amount >= 0)
    ) ;

REM ********************************************************************
REM Create the RESERVATION table (Supertype)

Prompt ****** Creating RESERVATION table ....

CREATE TABLE reservation
    ( reservation_id     CHAR(6) 
    , booking_id         CHAR(6) 
        CONSTRAINT res_bkg_nn NOT NULL 
    , reservation_date   DATE DEFAULT SYSDATE 
    , reservation_status VARCHAR2(20) 
	CONSTRAINT res_status_nn NOT NULL
    ) ;

ALTER TABLE reservation
ADD ( CONSTRAINT res_id_pk
                 PRIMARY KEY (reservation_id)
    , CONSTRAINT res_bkg_fk
                 FOREIGN KEY (booking_id)
                  REFERENCES booking (booking_id)
    , CONSTRAINT res_status_ck 
		 CHECK (reservation_status IN ('Confirmed','Pending','Cancelled'))
    ) ;

REM ********************************************************************
REM Create the FLIGHT_RESERVATION table (Subtype of Reservation)

Prompt ****** Creating FLIGHT_RESERVATION table ....

CREATE TABLE flight_reservation
    ( reservation_id CHAR(6) 
    , service_id     CHAR(6) 
        CONSTRAINT fres_srv_nn NOT NULL 
    , seat_class     VARCHAR2(20) 
	CONSTRAINT seat_cls_nn NOT NULL
    ) ;

ALTER TABLE flight_reservation
ADD ( CONSTRAINT fres_id_pk
                 PRIMARY KEY (reservation_id)
    , CONSTRAINT fres_res_fk
                 FOREIGN KEY (reservation_id)
                  REFERENCES reservation (reservation_id)
    , CONSTRAINT fres_srv_fk
                 FOREIGN KEY (service_id)
                  REFERENCES flight (service_id)
    , CONSTRAINT seat_cls_ck 
		 CHECK (seat_class IN ('Economy','Business','First Class'))
    ) ;

REM ********************************************************************
REM Create the TICKET table 

Prompt ****** Creating TICKET table ....

CREATE TABLE ticket
    ( ticket_id      CHAR(6)
    , reservation_id CHAR(6)
        CONSTRAINT ticket_res_nn NOT NULL
    , ticket_no      CHAR(11)
        CONSTRAINT ticket_no_nn NOT NULL
    , seat_no        VARCHAR2(5) 
	CONSTRAINT seat_no_nn NOT NULL
    , issue_date     DATE DEFAULT SYSDATE
    , ticket_status  VARCHAR2(20)
    );

ALTER TABLE ticket
ADD ( CONSTRAINT ticket_id_pk
                 PRIMARY KEY (ticket_id)
    , CONSTRAINT ticket_res_fk
                 FOREIGN KEY (reservation_id)
                  REFERENCES flight_reservation (reservation_id)
    , CONSTRAINT ticket_no_uk 
                 UNIQUE (ticket_no)
    , CONSTRAINT ticket_status_ck
                 CHECK (ticket_status IN ('Issued', 'Used', 'Cancelled'))
    );

REM ********************************************************************
REM Create the HOTEL_RESERVATION table (Subtype of Reservation)

Prompt ****** Creating HOTEL_RESERVATION table ....

CREATE TABLE hotel_reservation
    ( reservation_id CHAR(6) 
    , service_id     CHAR(6) 
    , check_in_date  DATE 
	CONSTRAINT check_in_nn NOT NULL 
    , check_out_date DATE 
	CONSTRAINT check_out_nn NOT NULL 
    , num_of_rooms   NUMBER(2) 
	CONSTRAINT num_of_rm_nn NOT NULL 
    ) ;

ALTER TABLE hotel_reservation
ADD ( CONSTRAINT hres_id_pk
                 PRIMARY KEY (reservation_id)
    , CONSTRAINT hres_res_fk
                 FOREIGN KEY (reservation_id)
                  REFERENCES reservation (reservation_id)
    , CONSTRAINT hres_srv_fk
                 FOREIGN KEY (service_id)
                  REFERENCES hotel (service_id)
    , CONSTRAINT hres_date_ck 
		 CHECK (check_out_date >= check_in_date)
    ) ;

REM ********************************************************************
REM Create the TRANSPORT_RESERVATION table (Subtype of Reservation)

Prompt ****** Creating TRANSPORT_RESERVATION table ....

CREATE TABLE transport_reservation
    ( reservation_id    CHAR(6) 
    , service_id        CHAR(6) 
        CONSTRAINT tres_srv_nn NOT NULL 
    , pick_up_location  VARCHAR2(100) 
	CONSTRAINT pick_loc_nn NOT NULL 
    , drop_off_location VARCHAR2(100) 
	CONSTRAINT drop_loc_nn NOT NULL 
    , pick_up_datetime  TIMESTAMP 
	CONSTRAINT pick_date_nn NOT NULL 
    , drop_off_datetime TIMESTAMP 
	CONSTRAINT drop_date_nn NOT NULL 
    ) ;

ALTER TABLE transport_reservation
ADD ( CONSTRAINT tres_id_pk
                 PRIMARY KEY (reservation_id)
    , CONSTRAINT tres_res_fk
                 FOREIGN KEY (reservation_id)
                  REFERENCES reservation (reservation_id)
    , CONSTRAINT tres_srv_fk
                 FOREIGN KEY (service_id)
                  REFERENCES transport (service_id)
    ) ;


REM ***************************insert data into the CUSTOMER table

Prompt ****** Populating CUSTOMER table ....

INSERT INTO customer VALUES ( 'CUST001', 'Alice', 'Johnson', 'alice.j@email.com', '123 Jalan Ampang', '012-3456789', 'A12345678');
INSERT INTO customer VALUES ( 'CUST002', 'Bernard', 'Lee', 'bernard.l@email.com', '45 Jalan Penang', '013-4567890', 'B23456789');
INSERT INTO customer VALUES ( 'CUST003', 'Chloe', 'Tan', 'chloe.t@email.com', '88 Jalan Gaya', '014-5678901', 'C34567890');
INSERT INTO customer VALUES ( 'CUST004', 'David', 'Raju', 'david.r@email.com', '12 Jalan JB', '015-6789012', 'D45678901');
INSERT INTO customer VALUES ( 'CUST005', 'Eva', 'Wong', 'eva.w@email.com', '99 Jalan Kuching', '016-7890123', 'E56789012');


REM ***************************insert data into the TOUR_PACKAGE table

Prompt ****** Populating TOUR_PACKAGE table ....

INSERT INTO tour_package VALUES ( 'PKG001', 'Adventure', 'Mount Kinabalu Hiking Expedition', '4 Days 3 Nights', 1500.00 );
INSERT INTO tour_package VALUES ( 'PKG002', 'Relaxation', 'Langkawi Beach Retreat', '3 Days 2 Nights', 850.00 );
INSERT INTO tour_package VALUES ( 'PKG003', 'Cultural', 'Penang Heritage Walk & Food Tour', '2 Days 1 Nights', 450.00 );
INSERT INTO tour_package VALUES ( 'PKG004', 'Nature', 'Taman Negara Rainforest Exploration', '5 Days 4 Nights', 1200.00 );
INSERT INTO tour_package VALUES ( 'PKG005', 'City', 'Kuala Lumpur Metropolis Tour', '3 Days 2 Nights', 600.00 );


REM ***************************insert data into the SUPPLIER table

Prompt ****** Populating SUPPLIER table ....

INSERT INTO supplier VALUES ( 'SUP001', 'Malaysia Airlines', '1-300-88-3000', 'mh@airline.com' );
INSERT INTO supplier VALUES ( 'SUP002', 'AirAsia', '1-300-88-9933', 'support@airasia.com' );
INSERT INTO supplier VALUES ( 'SUP003', 'Batik Air', '03-7841-5388', 'info@batikair.com' );
INSERT INTO supplier VALUES ( 'SUP004', 'Firefly', '03-7845-4543', 'customer@fireflyz.com' );
INSERT INTO supplier VALUES ( 'SUP005', 'Singapore Airlines', '1-800-80-3333', 'contact@singaporeair.com' );
INSERT INTO supplier VALUES ( 'SUP006', 'Shangri-La Hotels', '03-2032-2388', 'reservations@shangri-la.com' );
INSERT INTO supplier VALUES ( 'SUP007', 'Hilton Worldwide', '03-2264-2264', 'info@hilton.com' );
INSERT INTO supplier VALUES ( 'SUP008', 'Marriott International', '03-2715-9000', 'booking@marriott.com' );
INSERT INTO supplier VALUES ( 'SUP009', 'Tune Hotels', '03-2082-5600', 'hello@tunehotels.com' );
INSERT INTO supplier VALUES ( 'SUP010', 'Banyan Tree', '103-2113-1888', 'kl@banyantree.com' );
INSERT INTO supplier VALUES ( 'SUP011', 'Aeroline', '03-6258-8800', 'enquiry@aeroline.com.my' );
INSERT INTO supplier VALUES ( 'SUP012', 'Plusliner', '03-2072-8888', 'customercare@plusliner.com' );
INSERT INTO supplier VALUES ( 'SUP013', 'Transnasional', '1-300-88-8582', 'info@transnasional.com' );
INSERT INTO supplier VALUES ( 'SUP014', 'KLIA Ekspres', '03-2267-8000', 'customerenquiry@kliaekspres.com' );
INSERT INTO supplier VALUES ( 'SUP015', 'RapidKL Bus Services', '03-7885-2585', 'suggest@rapidkl.com.my' );


REM ***************************insert data into the TOUR_GUIDE table

Prompt ****** Populating TOUR_GUIDE table ....

INSERT INTO tour_guide VALUES ( 'GDE001', 'Ahmad', 'Faizal', '019-1112222', 'English, Malay' );
INSERT INTO tour_guide VALUES ( 'GDE002', 'Sarah', 'Lim', '012-3334444', 'English, Mandarin' );
INSERT INTO tour_guide VALUES ( 'GDE003', 'Muthu', 'Kumar', '017-5556666', 'English, Tamil' );
INSERT INTO tour_guide VALUES ( 'GDE004', 'Diana', 'Rose', '016-7778888', 'English, French' );
INSERT INTO tour_guide VALUES ( 'GDE005', 'Kenji', 'Sato', '014-9990000', 'English, Japanese' );


REM ***************************insert data into the AIRLINE table

Prompt ****** Populating AIRLINE table ....

INSERT INTO airline VALUES ( 'SUP001', 'Malaysia Airlines', 'MH' );
INSERT INTO airline VALUES ( 'SUP002', 'AirAsia', 'AK' );
INSERT INTO airline VALUES ( 'SUP003', 'Batik Air', 'OD' );
INSERT INTO airline VALUES ( 'SUP004', 'Firefly', 'FY' );
INSERT INTO airline VALUES ( 'SUP005', 'Singapore Airlines', 'SQ' );


REM ***************************insert data into the HOTEL_PROVIDER table

Prompt ****** Populating HOTEL_PROVIDER table ....

INSERT INTO hotel_provider VALUES ( 'SUP006', 'Shangri-La Kuala Lumpur', 5.0 );
INSERT INTO hotel_provider VALUES ( 'SUP007', 'Hilton Petaling Jaya', 4.5 );
INSERT INTO hotel_provider VALUES ( 'SUP008', 'JW Marriott KL', 5.0 );
INSERT INTO hotel_provider VALUES ( 'SUP009', 'Tune Hotel KLIA2', 3.0 );
INSERT INTO hotel_provider VALUES ( 'SUP010', 'Banyan Tree KL', 5.0 );


REM ***************************insert data into the TRANSPORT_PROVIDER table

Prompt ****** Populating TRANSPORT_PROVIDER table ....

INSERT INTO transport_provider VALUES ( 'SUP011', 'Aeroline');
INSERT INTO transport_provider VALUES ( 'SUP012', 'Plusliner');
INSERT INTO transport_provider VALUES ( 'SUP013', 'Transnasional');
INSERT INTO transport_provider VALUES ( 'SUP014', 'KLIA Ekspres');
INSERT INTO transport_provider VALUES ( 'SUP015', 'RapidKL');


REM ***************************insert data into the SERVICE table

Prompt ****** Populating SERVICE table ....

INSERT INTO service VALUES ( 'SRV001', 'SUP001', 'Flight KUL-BKI', 400.00 );
INSERT INTO service VALUES ( 'SRV002', 'SUP002', 'Flight KUL-LGK', 150.00 );
INSERT INTO service VALUES ( 'SRV003', 'SUP003', 'Flight KUL-PEN', 120.00 );
INSERT INTO service VALUES ( 'SRV004', 'SUP004', 'Flight SZB-KBR', 180.00 );
INSERT INTO service VALUES ( 'SRV005', 'SUP005', 'Flight KUL-SIN', 500.00 );
INSERT INTO service VALUES ( 'SRV006', 'SUP006', 'Deluxe Stay', 550.00 );
INSERT INTO service VALUES ( 'SRV007', 'SUP007', 'Exec Stay', 650.00 );
INSERT INTO service VALUES ( 'SRV008', 'SUP008', 'Standard Stay', 480.00 );
INSERT INTO service VALUES ( 'SRV009', 'SUP009', 'Budget Stay', 150.00 );
INSERT INTO service VALUES ( 'SRV010', 'SUP010', 'Suite Stay', 1200.00 );
INSERT INTO service VALUES ( 'SRV011', 'SUP011', 'Coach Transfer KL', 80.00 );
INSERT INTO service VALUES ( 'SRV012', 'SUP012', 'Bus Transfer Penang', 40.00 );
INSERT INTO service VALUES ( 'SRV013', 'SUP013', 'Express Bus JB', 45.00 );
INSERT INTO service VALUES ( 'SRV014', 'SUP014', 'Airport Train', 55.00 );
INSERT INTO service VALUES ( 'SRV015', 'SUP015', 'City Bus Pass', 10.00 );


REM ***************************insert data into the BOOKING table

Prompt ****** Populating BOOKING table ....

INSERT INTO booking VALUES ( 'BKG001', 'CUST001', 'PKG001', TO_DATE('10-MAY-2025', 'dd-MON-yyyy'), 'Confirmed', 1500.00 );
INSERT INTO booking VALUES ( 'BKG002', 'CUST002', 'PKG002', TO_DATE('12-MAY-2025', 'dd-MON-yyyy'), 'Confirmed', 850.00 );
INSERT INTO booking VALUES ( 'BKG003', 'CUST003', 'PKG003', TO_DATE('15-MAY-2025', 'dd-MON-yyyy'), 'Pending', 450.00 );
INSERT INTO booking VALUES ( 'BKG004', 'CUST004', 'PKG004', TO_DATE('18-MAY-2025', 'dd-MON-yyyy'), 'Confirmed', 1200.00 );
INSERT INTO booking VALUES ( 'BKG005', 'CUST005', 'PKG005', TO_DATE('20-MAY-2025', 'dd-MON-yyyy'), 'Cancelled', 600.00 );


REM ***************************insert data into the ITINERARY table

Prompt ****** Populating ITINERARY table ....

INSERT INTO itinerary VALUES ( 'ITN001', 'PKG001', 1, 'Arrival and Base Camp Briefing', 'Kinabalu Park HQ', '14:00' );
INSERT INTO itinerary VALUES ( 'ITN002', 'PKG001', 2, 'Ascent to Panalaban', 'Mount Kinabalu Trail', '08:00' );
INSERT INTO itinerary VALUES ( 'ITN003', 'PKG002', 1, 'Island Hopping', 'Langkawi Archipelago', '09:00' );
INSERT INTO itinerary VALUES ( 'ITN004', 'PKG003', 1, 'Street Art Walk', 'Georgetown, Penang', '10:30' );
INSERT INTO itinerary VALUES ( 'ITN005', 'PKG005', 2, 'Petronas Twin Towers Visit', 'KLCC', '11:00' );


REM ***************************insert data into the FLIGHT table

Prompt ****** Populating FLIGHT table ....

INSERT INTO flight VALUES ( 'SRV001', 'MH2604', 'KUL', 'BKI', TIMESTAMP '2025-06-01 08:00:00', TIMESTAMP '2025-06-01 10:30:00', '2h 30m', 'G1' );
INSERT INTO flight VALUES ( 'SRV002', 'AK6112', 'KUL', 'LGK', TIMESTAMP '2025-06-02 09:15:00', TIMESTAMP '2025-06-02 10:15:00', '1h 00m', 'H4' );
INSERT INTO flight VALUES ( 'SRV003', 'OD2103', 'KUL', 'PEN', TIMESTAMP '2025-06-03 14:00:00', TIMESTAMP '2025-06-03 15:00:00', '1h 00m', 'K2' );
INSERT INTO flight VALUES ( 'SRV004', 'FY1002', 'SZB', 'KBR', TIMESTAMP '2025-06-04 11:30:00', TIMESTAMP '2025-06-04 12:45:00', '1h 15m', 'A1' );
INSERT INTO flight VALUES ( 'SRV005', 'SQ107',  'KUL', 'SIN', TIMESTAMP '2025-06-05 18:45:00', TIMESTAMP '2025-06-05 19:45:00', '1h 00m', 'C3' );


REM ***************************insert data into the HOTEL table

Prompt ****** Populating HOTEL table ....

INSERT INTO hotel VALUES ( 'SRV006', 'Shangri-La KL', 'Kuala Lumpur', 'Deluxe Room', 550.00 );
INSERT INTO hotel VALUES ( 'SRV007', 'Hilton PJ', 'Petaling Jaya', 'Executive Suite', 650.00 );
INSERT INTO hotel VALUES ( 'SRV008', 'JW Marriott', 'Bukit Bintang', 'Standard Room', 480.00 );
INSERT INTO hotel VALUES ( 'SRV009', 'Tune Hotel', 'KLIA2', 'Twin Room', 150.00 );
INSERT INTO hotel VALUES ( 'SRV010', 'Banyan Tree', 'KLCC', 'Signature Suite', 1200.00 );


REM ***************************insert data into the TRANSPORT table

Prompt ****** Populating TRANSPORT table ....

INSERT INTO transport VALUES ( 'SRV011', 'Luxury Coach', 30, 'Corus Hotel KL' );
INSERT INTO transport VALUES ( 'SRV012', 'Express Bus', 40, 'TBS KL' );
INSERT INTO transport VALUES ( 'SRV013', 'Express Bus', 44, 'Penang Sentral' );
INSERT INTO transport VALUES ( 'SRV014', 'Train', 200, 'KL Sentral' );
INSERT INTO transport VALUES ( 'SRV015', 'City Bus', 60, 'Pasar Seni Bus Hub' );

REM ***************************insert data into the PACKAGE_SERVICE table

Prompt ****** Populating PACKAGE_SERVICE table ....

INSERT INTO package_service VALUES ('PKG001', 'SRV001', 350.00, 1 );
INSERT INTO package_service VALUES ('PKG001', 'SRV006', 500.00, 2 );
INSERT INTO package_service VALUES ('PKG002', 'SRV002', 120.00, 1 );
INSERT INTO package_service VALUES ('PKG002', 'SRV009', 130.00, 2 );
INSERT INTO package_service VALUES ('PKG003', 'SRV012', 35.00, 1 );


REM ***************************insert data into the PACKAGE_GUIDE table

Prompt ****** Populating PACKAGE_GUIDE table ....

INSERT INTO package_guide VALUES ( 'PKG001', 'GDE001', 'Lead Guide', TO_DATE('01-JUN-2025', 'dd-MON-yyyy'), TO_DATE('04-JUN-2025', 'dd-MON-yyyy') );
INSERT INTO package_guide VALUES ( 'PKG002', 'GDE002', 'Local Escort', TO_DATE('02-JUN-2025', 'dd-MON-yyyy'), TO_DATE('04-JUN-2025', 'dd-MON-yyyy') );
INSERT INTO package_guide VALUES ( 'PKG003', 'GDE003', 'Heritage Specialist', TO_DATE('03-JUN-2025', 'dd-MON-yyyy'), TO_DATE('04-JUN-2025', 'dd-MON-yyyy') );
INSERT INTO package_guide VALUES ( 'PKG004', 'GDE004', 'Nature Guide', TO_DATE('04-JUN-2025', 'dd-MON-yyyy'), TO_DATE('08-JUN-2025', 'dd-MON-yyyy') );
INSERT INTO package_guide VALUES ( 'PKG005', 'GDE005', 'City Translator', TO_DATE('05-JUN-2025', 'dd-MON-yyyy'), TO_DATE('07-JUN-2025', 'dd-MON-yyyy') );


REM ***************************insert data into the PAYMENT table

Prompt ****** Populating PAYMENT table ....

INSERT INTO payment VALUES ( 'PAY001', 'BKG001', 1500.00, 'Credit Card', TIMESTAMP '2025-05-10 10:30:00', 'Success' );
INSERT INTO payment VALUES ( 'PAY002', 'BKG002', 850.00, 'Online Banking', TIMESTAMP '2025-05-12 14:15:00', 'Success' );
INSERT INTO payment VALUES ( 'PAY003', 'BKG003', 450.00, 'E-Wallet', TIMESTAMP '2025-05-15 09:00:00', 'Pending' );
INSERT INTO payment VALUES ( 'PAY004', 'BKG004', 1200.00, 'Credit Card', TIMESTAMP '2025-05-18 16:45:00', 'Success' );
INSERT INTO payment VALUES ( 'PAY005', 'BKG005', 600.00, 'Online Banking', TIMESTAMP '2025-05-20 11:20:00', 'Refunded' );


REM ***************************insert data into the RESERVATION table

Prompt ****** Populating RESERVATION table ....

INSERT INTO reservation VALUES ( 'RES001', 'BKG001', TO_DATE('10-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES002', 'BKG002', TO_DATE('12-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES003', 'BKG003', TO_DATE('15-MAY-2025', 'dd-MON-yyyy'), 'Pending' );
INSERT INTO reservation VALUES ( 'RES004', 'BKG004', TO_DATE('18-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES005', 'BKG005', TO_DATE('20-MAY-2025', 'dd-MON-yyyy'), 'Cancelled' );
INSERT INTO reservation VALUES ( 'RES006', 'BKG001', TO_DATE('10-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES007', 'BKG002', TO_DATE('12-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES008', 'BKG003', TO_DATE('15-MAY-2025', 'dd-MON-yyyy'), 'Pending' );
INSERT INTO reservation VALUES ( 'RES009', 'BKG004', TO_DATE('18-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES010', 'BKG005', TO_DATE('20-MAY-2025', 'dd-MON-yyyy'), 'Cancelled' );
INSERT INTO reservation VALUES ( 'RES011', 'BKG001', TO_DATE('10-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES012', 'BKG002', TO_DATE('12-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES013', 'BKG003', TO_DATE('15-MAY-2025', 'dd-MON-yyyy'), 'Pending' );
INSERT INTO reservation VALUES ( 'RES014', 'BKG004', TO_DATE('18-MAY-2025', 'dd-MON-yyyy'), 'Confirmed' );
INSERT INTO reservation VALUES ( 'RES015', 'BKG005', TO_DATE('20-MAY-2025', 'dd-MON-yyyy'), 'Cancelled' );


REM ***************************insert data into the FLIGHT_RESERVATION table

Prompt ****** Populating FLIGHT_RESERVATION table ....

INSERT INTO flight_reservation VALUES ( 'RES001', 'SRV001', 'Economy');
INSERT INTO flight_reservation VALUES ( 'RES002', 'SRV002', 'Economy');
INSERT INTO flight_reservation VALUES ( 'RES003', 'SRV003', 'Business');
INSERT INTO flight_reservation VALUES ( 'RES004', 'SRV004', 'Economy');
INSERT INTO flight_reservation VALUES ( 'RES005', 'SRV005', 'First Class');


REM ***************************insert data into the TICKET table

Prompt ****** Populating TICKET table ....

INSERT INTO ticket VALUES ('TCK001', 'RES001', 'ETKT-990122', '12A', TO_DATE('11-MAY-2025', 'DD-MON-YYYY'), 'Issued');
INSERT INTO ticket VALUES ('TCK002', 'RES002', 'ETKT-990123', '14C', TO_DATE('13-MAY-2025', 'DD-MON-YYYY'), 'Issued');
INSERT INTO ticket VALUES ('TCK003', 'RES003', 'ETKT-990124', '2B',  TO_DATE('16-MAY-2025', 'DD-MON-YYYY'), 'Issued');
INSERT INTO ticket VALUES ('TCK004', 'RES004', 'ETKT-990125', '8F',  TO_DATE('19-MAY-2025', 'DD-MON-YYYY'), 'Issued');
INSERT INTO ticket VALUES ('TCK005', 'RES005', 'ETKT-990126', '1A',  TO_DATE('21-MAY-2025', 'DD-MON-YYYY'), 'Cancelled');


REM ***************************insert data into the HOTEL_RESERVATION table

Prompt ****** Populating HOTEL_RESERVATION table ....

INSERT INTO hotel_reservation VALUES ( 'RES006', 'SRV006', TO_DATE('01-JUN-2025', 'dd-MON-yyyy'), TO_DATE('04-JUN-2025', 'dd-MON-yyyy'), 1 );
INSERT INTO hotel_reservation VALUES ( 'RES007', 'SRV007', TO_DATE('02-JUN-2025', 'dd-MON-yyyy'), TO_DATE('04-JUN-2025', 'dd-MON-yyyy'), 2 );
INSERT INTO hotel_reservation VALUES ( 'RES008', 'SRV008', TO_DATE('03-JUN-2025', 'dd-MON-yyyy'), TO_DATE('04-JUN-2025', 'dd-MON-yyyy'), 1 );
INSERT INTO hotel_reservation VALUES ( 'RES009', 'SRV009', TO_DATE('04-JUN-2025', 'dd-MON-yyyy'), TO_DATE('08-JUN-2025', 'dd-MON-yyyy'), 3 );
INSERT INTO hotel_reservation VALUES ( 'RES010', 'SRV010', TO_DATE('05-JUN-2025', 'dd-MON-yyyy'), TO_DATE('07-JUN-2025', 'dd-MON-yyyy'), 1 );


REM ***************************insert data into the TRANSPORT_RESERVATION table

Prompt ****** Populating TRANSPORT_RESERVATION table ....

INSERT INTO transport_reservation VALUES ( 'RES011', 'SRV011', 'KL Sentral', 'Mount Kinabalu Base', TIMESTAMP '2025-06-01 08:00:00', TIMESTAMP '2025-06-01 12:00:00' );
INSERT INTO transport_reservation VALUES ( 'RES012', 'SRV012', 'Penang Airport', 'Langkawi Jetty', TIMESTAMP '2025-06-02 09:00:00', TIMESTAMP '2025-06-02 11:00:00' );
INSERT INTO transport_reservation VALUES ( 'RES013', 'SRV013', 'Hotel Lobby', 'Heritage Zone', TIMESTAMP '2025-06-03 10:00:00', TIMESTAMP '2025-06-03 18:00:00' );
INSERT INTO transport_reservation VALUES ( 'RES014', 'SRV014', 'KLIA', 'Taman Negara', TIMESTAMP '2025-06-04 14:00:00', TIMESTAMP '2025-06-04 17:00:00' );
INSERT INTO transport_reservation VALUES ( 'RES015', 'SRV015', 'Bukit Bintang', 'Batu Caves', TIMESTAMP '2025-06-05 08:30:00', TIMESTAMP '2025-06-05 13:00:00' );


COMMIT;