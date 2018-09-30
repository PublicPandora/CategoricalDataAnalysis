/*로지스틱 확률분포와 정규 확률분포*/
DATA LOGDIST;
PI=CONSTANT('PI');
DO E=-5 TO 5 BY 0.001;
fX=EXP(E)/(1+EXP(E))**2;
NORMAL=PDF("NORMAL",E,0, PI/SQRT(3));
CDF=EXP(E)/(1+EXP(E));
OUTPUT;
END;
RUN;

PROC SGPLOT DATA=LOGDIST;
SERIES X=E Y=FX/MARKERATTRS=(SYMBOL=CIRCLE COLOR=RED SIZE=1MM) SMOOTHCONNECT CURVELABEL="로지스틱 확률변수";
SERIES X=E Y=NORMAL/CURVELABEL="정규분포" CURVELABELPOS=MIN LINEATTRS=(PATTERN=SHORTDASH);
ODS GRAPHICS/ LINEPATTERNOBSMAX=10100; 
YAXIS LABEL="f(X)";
RUN;

PROC SGPLOT DATA=LOGDIST;
SERIES X=E Y=CDF/SMOOTHCONNECT CURVELABEL="로지스틱 함수";
YAXIS LABEL="F(X)";
XAXIS LABEL="epsilon";
REFLINE 0 /AXIS=X LINEATTRS=(THICKNESS=1 COLOR=BLACK);
REFLINE 0.5 /AXIS=Y LINEATTRS=(THICKNESS=1 COLOR=BLACK);
RUN;
