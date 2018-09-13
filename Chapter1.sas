/*에너지 자료 표 1.2*/

DATA ENERGY;       
LENGTH STATE $2;                                                 /*State변수의 문자는 2개만 표시*/
INPUT REGION DIVISION STATE $ TYPE EXPENDITURES @@; 
DATALINES;
1 1 ME 1 708 1 1 ME 2 379 1 1 NH 1 597 1 1 NH 2 301 1 1 VT 1 353 1 1 VT 2 188
1 1 MA 1 3264 1 1 MA 2 2498 1 1 RI 1 531 1 1 RI 2 358 1 1 CT 1 2024 1 1 CT 2 1405
1 2 NY 1 8786 1 2 NY 2 7825 1 2 NJ 1 4115 1 2 NJ 2 3558 1 2 PA 1 6478 1 2 PA 2 3695
4 3 MT 1 322 4 3 MT 2 232 4 3 ID 1 392 4 3 ID 2 298 4 3 WY 1 194 4 3 WY 2 184
4 3 CO 1 1215 4 3 CO 2 1173 4 3 NM 1 545 4 3 NM 2 578 4 3 AZ 1 1694 4 3 AZ 2 1448
4 3 UT 1 621 4 3 UT 2 438 4 3 NV 1 493 4 3 NV 2 378 4 4 WA 1 1680 4 4 WA 2 1122
4 4 OR 1 1014 4 4 OR 2 756 4 4 CA 1 10643 4 4 CA 2 10114 4 4 AK 1 349
4 4 AK 2 329 4 4 HI 1 273 4 4 HI 2 298
;
PROC PRINT DATA=ENERGY(OBS=10);                                  /*10개 관찰점만 출력*/ 
RUN;


/*FORMAT 프로시저를 이용한 변숫값의 의미 지정 표 1.4 */

PROC FORMAT;                                                    /*변수 포맷을 통한 의미지지정*/
VALUE REGFMT 1='NORTHEAST'                                      /*Region 변수의 의미지정*/
2='SOUTH'
3='MIDWEST'
4='WEST';
VALUE DIVFMT 1='NEW ENGLAND'                                    /*Dvision 변수의 의미지정*/
2='MIDDLE ATLANTIC'
3='MOUNTAIN'
4='PACIFIC';
VALUE USETYPE 1='RESIDENTIAL CUSTOMERS'                        /*Type 변수의 의미지정*/
2='BUSINESS CUSTOMERS';
RUN;
PROC PRINT DATA=ENERGY (OBS=10);                               /*10개 관찰점만 출력*/
FORMAT REGION REGFMT. DIVISION DIVFMT. TYPE USETYPE.;          /*Region, Division, Type변수를 지정한 포맷으로 사용, 지정한 포맷에 꼭 dot 찍기*/
RUN;

/* PROC TABULATE를 이용한 테이블 만들기 표 1.6 */

PROC TABULATE DATA=ENERGY(WHERE=(TYPE=1));                     /*각 Division마다 2번 출력(Type정보 포함)따라서, 주거용(1)만 사용*/
FORMAT DIVISION DIVFMT.; 
CLASS DIVISION;                                                /*범주형 변수임을 선언*/
TABLE DIVISION;                                                /*어떤 변수로 테이블 만들 것인지 선언*/
RUN;

/* 여러 범주형 변수와 연속형 변수 분석을 위한 교차분포표 만들기 코드 표 1.8*/

PROC TABULATE DATA=ENERGY FORMAT=DOLLAR12.;                    /*숫자를 달러 기호가 포함된 형식으로 출력*/
CLASS REGION DIVISION TYPE; 
VAR EXPENDITURES;                                              /*숫자형 변수*/
TABLE REGION*DIVISION,                                         /*행 변수*/
           TYPE*EXPENDITURES/ RTS=25;                          /*열 변수, RTS=; 행 label  출력 간격 조정*/
FORMAT REGION REGFMT. DIVISION DIVFMT. TYPE USETYPE.; 
TITLE 'ENERGY EXPENDITURES FOR EACH REGION';
TITLE2 '(MILLIONS OF DOLLARS)';
RUN;

/* 숫자형 변수에 대한 다양한 통계분석 표 1.10*/

PROC TABULATE DATA=ENERGY;
CLASS REGION DIVISION TYPE;
VAR EXPENDITURES;
TABLE REGION*DIVISION,
           TYPE="고객유형"*EXPENDITURES=" "* (N MEAN STD)         /*빈도, 평균, 표준편차*/
		   /RTS=25; 
FORMAT REGION REGFMT. DIVISION DIVFMT. TYPE USETYPE.;
TITLE 'ENERGY EXPENDITURES FOR EACH REGION';
TITLE2 '(MILLIONS OF DOLLARS)';
RUN;

/* 행 및 열 변수의 종합 결과를 구하기 위한 코드 표 1.13*/

PROC TABULATE DATA=ENERGY OUT=RESULT;                             /*분석결과를 RESULT라는 SAS 데이터셋 형태로 저장*/
CLASS REGION DIVISION TYPE;
VAR EXPENDITURES;
TABLE (REGION*DIVISION ALL), 
           (TYPE="고객유형"*EXPENDITURES=" "* (N MEAN STD) 
		   ALL*EXPENDITURES*(N MEAN STD))/ RTS=25;
FORMAT REGION REGFMT. DIVISION DIVFMT. TYPE USETYPE.;
TITLE 'ENERGY EXPENDITURES FOR EACH REGION';
TITLE2 '(MILLIONS OF DOLLARS)';
RUN;

/* TABULATE 프로시저를 이용한 교차표 만들기 예제 표 1.16*/

PROC TABULATE DATA=ENERGY OUT=RESULT; 
CLASS REGION DIVISION TYPE;
VAR EXPENDITURES;
TABLE (REGION*DIVISION ALL), 
           (TYPE="고객유형"*EXPENDITURES=" "*
		   (SUM COLPCTSUM ROWPCTSUM REPPCTSUM)                         /*숫자형 변수의 열합에 대한 백분율 값, 행합에 대한 백분율, 전체 합에 대한 백분율*/
		   ALL*EXPENDITURES*SUM=" ")/ RTS=25;
FORMAT REGION REGFMT. DIVISION DIVFMT. TYPE USETYPE.;
TITLE 'ENERGY EXPENDITURES FOR EACH REGION';
TITLE2 '(MILLIONS OF DOLLARS)';
RUN;

/* DOT 그림 그리기 표 1.18*/

PROC SGPLOT DATA=ENERGY;
DOT DIVISION;
RUN;
