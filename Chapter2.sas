/* 투표의향과 거주지역 간의 연관성 분석 코드 표 2.2*/

DATA VOTE;
INPUT VOTE$ COMMUNITY$ COUNT;
CARDS;
YES URBAN 8
YES SUB 17
YES RURAL 7
NO URBAN 6
NO SUB 8
NO RURAL 15
UNDEC URBAN 19
UNDEC SUB 7
UNDEC RURAL 11
;
RUN;
PROC FREQ DATA=VOTE ORDER=DATA; 
WEIGHT COUNT;
TABLE VOTE*COMMUNITY/NOPCT NOROW NOCOL;                          /*투표의향과 거주지역의 교차분포표*/
RUN;


/* FREQ 프로시저를 이용한 범주형 변수의 연관성 검정 표 2.5*/

PROC FREQ DATA=VOTE ORDER=DATA;                                  /*오름차순이 아닌, 자료에 입력된 범주의 순서*/
WEIGHT COUNT;
TABLE VOTE*COMMUNITY/ CHISQ EXPECTED MEASURES CL NOPCT 
NOROW NOCOL;                                                     /*행변수, 열변수 순서대로 지정, 카이제곱 연관성 검정, 기대빈도, 다양한 연관성 통계량 출력*/
RUN;


/* 복지정책 유형과 성별에 따른 정책선호의 피셔의 정확검정 코드 표 2.12*/

DATA SMALL;
INPUT WELFARE$ GENDER$ COUNT;
CARDS;
PLURAL M 12
PLURAL F 3
FLEXIBLE M 3
FLEXIBLE F 14
;
RUN;
PROC FREQ DATA=SMALL ORDER=DATA;
WEIGHT COUNT;
TABLE WELFARE*GENDER / CHISQ FISHER NOCOL NOROW NOPCT;
RUN;
