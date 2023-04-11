%% PROBLEMA #14. 
% Vamos a ir transformando nuestro programa en una tarea de "dot probe" completa. 
% Usaremos los Tiempos de Respuesta (TR) para medir cómo se distribuye la atención visual cuando presentamos nuestra 
% dot probe en el cuadrado (ensayo congruente o frecuente) o en el círculo (ensayo incongruente o poco frecuente). 
% Para eso tenemos que saber para cada ensayo si: 
% -(1) El ensayo era congruente o incongruente. 
% -(2) Si la respuesta fue correcta o incorrecta y 
% -(3) el TR. 

% Empieza creando una matriz con tantas filas como ensayos tiene tu experimento y tantas columnas como datos 
% queramos guardar (3 en este caso). Puedes llamar a esta matriz "DATOS".

%% 
clear all
n = 6; %definir numero de ensayos %

%% define parámetros:
Screen ('Preference','SkipSyncTests', 1); %% just when debbuging
[wPtr, Rect] = Screen('OpenWindow', 1, [180 180 180]);%%------------------->>cambiar a 0
Screen('Flip', wPtr); WaitSecs(1);
ListenChar(2);
[KeyIsDown, endrt, KeyCode]=KbCheck;
% parametros pantalla:
W = Rect(RectRight); H = RectHeight(Rect); [X,Y] = RectCenter(Rect); a= (X+W/8)- (X-W/8);
left_screen= [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8];
right_screen= [X+W/8 Y-H/8 X+W/8+a Y+H/8];
[right_dotX,right_dotY] = RectCenter (right_screen);
[left_dotX,left_dotY] = RectCenter (left_screen);

%% Matriz de respuesta:
% crea una matriz con tantas filas como ensayos el expto y tantas columnas como datos a guardar
DATOS= NaN(n, 3) % Columnas: (1) ensayo congruente/incongruente, (2) respuesta correcta/incorrecta (3) TR
%% define el tipo de ensayo:
tipo_trial = zeros (2,n);% primero, creamos una matriz llena de zeros
tipo_trial (1, 1:n/2)=1; 
tipo_trial (1, (n/2+1):end)=2; %Ahora haz que la mitad de los valores de tipo_trial, en la primera fila, sean un 1 y la otra mitad un 2 
tipo_trial (2, 1:n/3)= 1; % en 1/3 de los ensayos (n), el dot probe aparace en el círculo; 1= circulo
tipo_trial (2, (n/3*2-1):end)=2; % en 2/3 de los ensayos (n),  el dot probe aparece en el cuadrado (congruente); 2= cuadrado.

random_order = randperm(n); % creamos un orden aleatorio con el total de ensayos (n), y lo aplicamos a las filas de la matriz
tipo_trial(1,:)= tipo_trial(1,random_order);
tipo_trial(2,:)= tipo_trial(2,random_order);

KbName('UnifyKeyNames');
right_key=KbName('RightArrow'); 
left_key=KbName('LeftArrow');

%% Ciclo de ensayos
%comienzan los ensayos (n veces)
for i= 1:n
    %% Secuencia ensayo:
    %% 0.- parametros tiempo
    time= 0.250; %tiempo de
    timedot=1.750; %tiempo de presentación del estímulo
    timefix= 0.2 + (0.5-0.2).*rand; %% elige un numero aleatorio entre 0.2 y 0.5
    %% 1.- punto de fijación:
    FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; %dibuja dos barras de ancho 1*20, con distinta orientación, forma una "+"
    Screen('FillRect', wPtr, [255,255,255], FixCross');
    Screen('Flip', wPtr);
    WaitSecs(timefix);
    %% 2.- estimulos; muestra los ee durante "time" antes que aparezca el dot.    
    if tipo_trial (1,i) == 1 % cuadrado en la parte izquierda de la pantalla/circulo en la derecha
        Screen ('FillRect', wPtr, [250 0 0], left_screen);
        Screen('FillOval', wPtr, [0 250 0], right_screen);
        Screen('Flip', wPtr); WaitSecs(time);
    elseif tipo_trial (1,i) == 2 % cuadrado en la parte derecha de la pantalla/ circulo en la izquierda
        Screen ('FillRect', wPtr, [250 0 0], right_screen);
        Screen('FillOval', wPtr, [0 250 0], left_screen);
        Screen('Flip', wPtr); WaitSecs(time);
    end    
    %% 3.- estimulos + dot
    if tipo_trial (1,i) == 1
        Screen ('FillRect', wPtr, [250 0 0], left_screen);
        Screen('FillOval', wPtr, [0 250 0], right_screen);
        if tipo_trial (2,i) == 1 
            Screen ('FillRect', wPtr, [250 250 250], [right_dotX-25,right_dotY-25, right_dotX+25,right_dotY+25]); %dot
        elseif tipo_trial (2,i) == 2
            Screen ('FillRect', wPtr, [250 250 250], [left_dotX-25,left_dotY-25, left_dotX+25,left_dotY+25]); %dot
        end
        Screen('Flip', wPtr);  %WaitSecs(timedot);
        % teclas de respuesta:
        if tipo_trial(1,i)== tipo_trial (2,i)
            while KeyCode (right_key)==0
                [KeyIsDown, endrt, KeyCode]=KbCheck; WaitSecs(0.1); 
            end
        elseif tipo_trial(1,i)~= tipo_trial (2,i)
            while KeyCode (left_key)==0
                [KeyIsDown, endrt, KeyCode]=KbCheck; WaitSecs(0.1);
            end
        end
        KeyCode (right_key)=0; KeyCode (left_key)=0;
 %%       
    elseif tipo_trial (1,i) == 2
        Screen ('FillRect', wPtr, [250 0 0], right_screen);
        Screen('FillOval', wPtr, [0 250 0], left_screen);
        if tipo_trial (2,i) == 1
            Screen ('FillRect', wPtr, [250 250 250], [left_dotX-25,left_dotY-25, left_dotX+25,left_dotY+25]); %dot
        elseif tipo_trial (2,i) == 2
            Screen ('FillRect', wPtr, [250 250 250], [right_dotX-25,right_dotY-25, right_dotX+25,right_dotY+25]); %dot
        end
        Screen('Flip', wPtr); %WaitSecs(timedot);
        % teclas de respuesta:
        if tipo_trial(1,i)== tipo_trial (2,i)
            while KeyCode (right_key)==0
                [KeyIsDown, endrt, KeyCode]=KbCheck;WaitSecs(0.1);
            end
        elseif tipo_trial(1,i)~= tipo_trial (2,i)
            while KeyCode (left_key)==0
                [KeyIsDown, endrt, KeyCode]=KbCheck;WaitSecs(0.1);
            end
        end
        KeyCode (right_key)=0; KeyCode (left_key)=0;
    end
    % 4.pantalla vacía
    Screen('FillRect', wPtr, [180 180 180]);
    Screen('Flip', wPtr); WaitSecs(0.5);
    
end
Screen ('CloseAll')
%%
%% PROBLEMA #15. 
% Escribe en la primera columna de DATOS, para cada ensayo, si el ensayo fue congruente (escribe 1) o incongruente (2). 
% En la segunda columna, si la respuesta fue correcta (1) o incorrecta (0) en ese ensayo.

%% 
clear all
n = 6; %definir numero de ensayos 

%% define parámetros:
Screen ('Preference','SkipSyncTests', 1); %% just when debbuging
[wPtr, Rect] = Screen('OpenWindow', 1, [180 180 180]);%%------------------->>cambiar a 0
Screen('Flip', wPtr); WaitSecs(1);
ListenChar(2);
[KeyIsDown, endrt, KeyCode]=KbCheck;

% parametros estimulos:
W = Rect(RectRight); H = RectHeight(Rect); [X,Y] = RectCenter(Rect); a= (X+W/8)- (X-W/8);
left_screen= [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8];
right_screen= [X+W/8 Y-H/8 X+W/8+a Y+H/8];
[right_dotX,right_dotY] = RectCenter (right_screen);
[left_dotX,left_dotY] = RectCenter (left_screen);

dot_right= [right_dotX-25,right_dotY-25, right_dotX+25,right_dotY+25];
dot_left= [left_dotX-25,left_dotY-25, left_dotX+25,left_dotY+25];

FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; %dibuja dos barras de ancho 1*20, con distinta orientación, forma una "+"
%% Matriz de respuesta:
% crea una matriz con tantas filas como ensayos tiene el expto y tantas columnas como datos a guardar
DATOS= NaN(n, 3); % Columnas: (1) ensayo congruente/incongruente, (2) respuesta correcta/incorrecta (3) TR

%% define el tipo de ensayo:
tipo_trial = zeros (2,n);% primero, creamos una matriz llena de zeros
tipo_trial (1, 1:n/2)=1; 
tipo_trial (1, (n/2+1):end)=2; %Ahora haz que la mitad de los valores de tipo_trial, en la primera fila, sean un 1 y la otra mitad un 2 
tipo_trial (2, 1:n/3)= 1; % en 1/3 de los ensayos (n), el dot probe aparace en el círculo; 1= circulo
tipo_trial (2, (n/3*2-1):end)=2; % en 2/3 de los ensayos (n),  el dot probe aparece en el cuadrado (congruente); 2= cuadrado.
 
random_order = randperm(n); % creamos un orden aleatorio con el total de ensayos (n), y lo aplicamos a las filas de la matriz
tipo_trial(1,:)= tipo_trial(1,random_order);
tipo_trial(2,:)= tipo_trial(2,random_order);

KbName('UnifyKeyNames');
right_key=KbName('RightArrow'); 
left_key=KbName('LeftArrow');

%% Ciclo de ensayos
for i= 1:n %comienzan los ensayos (n veces)
    %% Secuencia ensayo:
    %% 0.- parametros tiempo
    time= 0.250; %tiempo de
    timedot=1.750; %tiempo de presentación del estímulo
    timefix= 0.2 + (0.5-0.2).*rand; %% elige un numero aleatorio entre 0.2 y 0.5
    %% 1.- punto de fijación:
    Screen('FillRect', wPtr, [255,255,255], FixCross');
    Screen('Flip', wPtr);
    WaitSecs(timefix);
    %% 2.- estimulos; muestra los ee durante "time" antes que aparezca el dot.    
    if tipo_trial (1,i) == 1 % cuadrado en la parte izquierda de la pantalla/circulo en la derecha
        Screen ('FillRect', wPtr, [250 0 0], left_screen);
        Screen('FillOval', wPtr, [0 250 0], right_screen);
        Screen('Flip', wPtr); WaitSecs(time);
    elseif tipo_trial (1,i) == 2 % cuadrado en la parte derecha de la pantalla/ cuadrado en la izquierda
        Screen ('FillRect', wPtr, [250 0 0], right_screen);
        Screen('FillOval', wPtr, [0 250 0], left_screen);
        Screen('Flip', wPtr); WaitSecs(time);
    end    
    %% 3.- estimulos + dot
    if tipo_trial (1,i) == 1 % izq= cuadrado; dch= circulo
        Screen ('FillRect', wPtr, [250 0 0], left_screen);
        Screen('FillOval', wPtr, [0 250 0], right_screen);
        if tipo_trial (2,i) == 1
            Screen ('FillRect', wPtr, [250 250 250], dot_right); % dot en circulo
            DATOS (i,1)= 2; % ensayo incongruente
        elseif tipo_trial (2,i) == 2
            Screen ('FillRect', wPtr, [250 250 250], dot_left); % dot en cuadrado
            DATOS (i,1)= 1; % ensayo congruente
        end
        Screen('Flip', wPtr); %WaitSecs(timedot);
        % teclas de respuesta:
        if tipo_trial(1,i)== tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown ==0
                [KeyIsDown,~,KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,right_key) == 1
                    DATOS (i,2)= 1;
                elseif KeyCode (1,left_key)== 1 
                    DATOS (i,2)= 0;

                end
            end
        elseif tipo_trial(1,i)~= tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~,KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,left_key)== 1 
                    DATOS (i,2)= 1;
                elseif KeyCode(1,right_key)== 1 
                    DATOS (i,2)= 0;

                end
            end           
            
        end
        KeyCode (right_key)=0; KeyCode (left_key)=0;
        
        %%
    elseif tipo_trial (1,i) == 2 % izq= circulo; dch= cuadrado
        Screen ('FillRect', wPtr, [250 0 0], right_screen);
        Screen('FillOval', wPtr, [0 250 0], left_screen);
        if tipo_trial (2,i) == 1
            Screen ('FillRect', wPtr, [250 250 250], dot_left); % dot en circulo
            DATOS (i,1)= 2; % ensayo incongruente
        elseif tipo_trial (2,i) == 2
            Screen ('FillRect', wPtr, [250 250 250], dot_right); %dot en cuadrado
            DATOS (i,1)= 1; % ensayo congruente
        end
        Screen('Flip', wPtr); %WaitSecs(timedot);
        % teclas de respuesta:
        if tipo_trial(1,i)== tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~, KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,right_key)== 1
                    DATOS (i,2)= 1;
                elseif KeyCode(1,left_key)== 1 
                    DATOS (i,2)= 0;

                end
            end
        elseif tipo_trial(1,i)~= tipo_trial (2,i)
            [KeyIsDown,~,~] =KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~, KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,left_key)== 1
                    DATOS (i,2)= 1;
                elseif KeyCode(1,right_key)== 1 
                    DATOS (i,2)= 0;

                end
            end          
            
        end
        KeyCode (right_key)=0; KeyCode (left_key)=0; 
        
    end
    
    % 4.pantalla vacía
    Screen('FillRect', wPtr, [180 180 180]);
    Screen('Flip', wPtr); WaitSecs(0.5);
    
end
Screen ('CloseAll')
%%
%% PROBLEMA #16. Vamos a grabar los tiempos de respuesta en la tercera columna de DATOS.

% TIP: GetSecs arroja el tiempo actual con mucha precisión. Si lo grabas en una variable, podrás usar ese valor para calcular los Tiempos de Respuesta. Por ejemplo:
% "tStart" = GetSecs;  --------------- % si pones este código justo cuando dibujas el dot probe tendrás el tiempo en ese momento exacto.
% aqui va el código relacionado con responder
% "tEnd" = GetSecs; -------------------% justo después de haberse emitido la respuesta, grabas el tiempo de nuevo, en otra variable.
% "rt" = tEnd - tStart; ---------------% restando las dos variables ya tienes el tiempo transcurrido desde que apareció el dot probe hasta que se emitió la respuesta.

% No se te olvide salvar DATOS! (usando "save").

%% 
clear all
n = 6; %definir numero de ensayos 

%% define parámetros:
Screen ('Preference','SkipSyncTests', 1); %% just when debbuging
[wPtr, Rect] = Screen('OpenWindow', 1, [180 180 180]);%%------------------->>cambiar a 0
Screen('Flip', wPtr); WaitSecs(1);
ListenChar(2);
[KeyIsDown, endrt, KeyCode]=KbCheck;

% parametros estimulos:
W = Rect(RectRight); H = RectHeight(Rect); [X,Y] = RectCenter(Rect); a= (X+W/8)- (X-W/8);
left_screen= [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8];
right_screen= [X+W/8 Y-H/8 X+W/8+a Y+H/8];
[right_dotX,right_dotY] = RectCenter (right_screen);
[left_dotX,left_dotY] = RectCenter (left_screen);

dot_right= [right_dotX-25,right_dotY-25, right_dotX+25,right_dotY+25];
dot_left= [left_dotX-25,left_dotY-25, left_dotX+25,left_dotY+25];

FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; %dibuja dos barras de ancho 1*20, con distinta orientación, forma una "+"
%% Matriz de respuesta:
% crea una matriz con tantas filas como ensayos tiene el expto y tantas columnas como datos a guardar
DATOS= NaN(n, 3); % Columnas: (1) ensayo congruente/incongruente, (2) respuesta correcta/incorrecta (3) TR

%% define el tipo de ensayo:
tipo_trial = zeros (2,n);% primero, creamos una matriz llena de zeros
tipo_trial (1, 1:n/2)=1; 
tipo_trial (1, (n/2+1):end)=2; %Ahora haz que la mitad de los valores de tipo_trial, en la primera fila, sean un 1 y la otra mitad un 2 
tipo_trial (2, 1:n/3)= 1; % en 1/3 de los ensayos (n), el dot probe aparace en el círculo; 1= circulo
tipo_trial (2, (n/3*2-1):end)=2; % en 2/3 de los ensayos (n),  el dot probe aparece en el cuadrado (congruente); 2= cuadrado.
 
random_order = randperm(n); % creamos un orden aleatorio con el total de ensayos (n), y lo aplicamos a las filas de la matriz
tipo_trial(1,:)= tipo_trial(1,random_order);
tipo_trial(2,:)= tipo_trial(2,random_order);

KbName('UnifyKeyNames');
right_key=KbName('RightArrow'); 
left_key=KbName('LeftArrow');

%% Ciclo de ensayos
for i= 1:n %comienzan los ensayos (n veces)
    %% Secuencia ensayo:
    %% 0.- parametros tiempo
    time= 0.250; %tiempo de
    timedot=1.750; %tiempo de presentación del estímulo
    timefix= 0.2 + (0.5-0.2).*rand; %% elige un numero aleatorio entre 0.2 y 0.5
    %% 1.- punto de fijación:
    Screen('FillRect', wPtr, [255,255,255], FixCross');
    Screen('Flip', wPtr);
    WaitSecs(timefix);
    %% 2.- estimulos; muestra los ee durante "time" antes que aparezca el dot.
    if tipo_trial (1,i) == 1 % cuadrado en la parte izquierda de la pantalla/circulo en la derecha
        Screen ('FillRect', wPtr, [250 0 0], left_screen);
        Screen('FillOval', wPtr, [0 250 0], right_screen);
        Screen('Flip', wPtr); WaitSecs(time);
    elseif tipo_trial (1,i) == 2 % cuadrado en la parte derecha de la pantalla/ cuadrado en la izquierda
        Screen ('FillRect', wPtr, [250 0 0], right_screen);
        Screen('FillOval', wPtr, [0 250 0], left_screen);
        Screen('Flip', wPtr); WaitSecs(time);
    end
    %% 3.- estimulos + dot
    if tipo_trial (1,i) == 1 % izq= cuadrado; dch= circulo
        Screen ('FillRect', wPtr, [250 0 0], left_screen);
        Screen('FillOval', wPtr, [0 250 0], right_screen);
        if tipo_trial (2,i) == 1
            Screen ('FillRect', wPtr, [250 250 250], dot_right); % dot en circulo
            DATOS (i,1)= 2; % ensayo incongruente
        elseif tipo_trial (2,i) == 2
            Screen ('FillRect', wPtr, [250 250 250], dot_left); % dot en cuadrado
            DATOS (i,1)= 1; % ensayo congruente
        end
        Screen('Flip', wPtr);
        tStart = GetSecs; % 
        % teclas de respuesta:
        if tipo_trial(1,i)== tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown ==0
                [KeyIsDown,~,KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,right_key) == 1
                    DATOS (i,2)= 1;
                elseif KeyCode (1,left_key)== 1
                    DATOS (i,2)= 0;
                end
            end
        elseif tipo_trial(1,i)~= tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~,KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,left_key)== 1
                    DATOS (i,2)= 1;
                elseif KeyCode(1,right_key)== 1
                    DATOS (i,2)= 0;
                end
            end
        end
        tEnd = GetSecs; 
        rt = tEnd - tStart;
        DATOS (i,3)= rt;
        KeyCode (right_key)=0; KeyCode (left_key)=0; rt=0;
        
        %%
    elseif tipo_trial (1,i) == 2 % izq= circulo; dch= cuadrado
        Screen ('FillRect', wPtr, [250 0 0], right_screen);
        Screen('FillOval', wPtr, [0 250 0], left_screen);
        if tipo_trial (2,i) == 1
            Screen ('FillRect', wPtr, [250 250 250], dot_left); % dot en circulo
            DATOS (i,1)= 2; % ensayo incongruente
        elseif tipo_trial (2,i) == 2
            Screen ('FillRect', wPtr, [250 250 250], dot_right); %dot en cuadrado
            DATOS (i,1)= 1; % ensayo congruente
        end
        Screen('Flip', wPtr);
        tStart = GetSecs; 
        % teclas de respuesta:
        if tipo_trial(1,i)== tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~, KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,right_key)== 1
                    DATOS (i,2)= 1;
                elseif KeyCode(1,left_key)== 1
                    DATOS (i,2)= 0;
                end
            end
        elseif tipo_trial(1,i)~= tipo_trial (2,i)
            [KeyIsDown,~,~] =KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~, KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,left_key)== 1
                    DATOS (i,2)= 1;
                elseif KeyCode(1,right_key)== 1
                    DATOS (i,2)= 0;
                end
            end
            
        end
        tEnd = GetSecs; 
        rt = tEnd - tStart;
        DATOS (i,3)= rt;
        KeyCode (right_key)=0; KeyCode (left_key)=0; rt=0;
    end
    
    % 4.pantalla vacía
    Screen('FillRect', wPtr, [180 180 180]);
    Screen('Flip', wPtr); WaitSecs(0.5);
    
end
save DATOS
Screen ('CloseAll')
%%
%% PROBLEMA #17. Haz que tu experimento tenga 60 ensayos. 
% Busca a una amiga o amigo y que lo haga entero, en un ambiente tranquilo y sin distracciones. 
% Haz la media de los TR de todos los ensayos congruentes e incongruentes por separado. No incluyas los ensayos
% que sean errores. La media debería de ser mayor para los ensayos incongruentes. ¿Te ha salido bien el experimento? :-)

% TIP: No hagas las medias "a mano"!! Debes usar un programa como MATLAB o Excel. Por ejemplo, en Excel puedes usar "PROMEDIO.SI.CONJUNTO".
%%
clear all
n = 60; %definir numero de ensayos 

%% define parámetros:
Screen ('Preference','SkipSyncTests', 1); %% just when debbuging
[wPtr, Rect] = Screen('OpenWindow', 1, [180 180 180]);%%------------------->>cambiar a 0
Screen('Flip', wPtr); WaitSecs(1);
ListenChar(2);
[KeyIsDown, endrt, KeyCode]=KbCheck;

% parametros estimulos:
W = Rect(RectRight); H = RectHeight(Rect); [X,Y] = RectCenter(Rect); a= W/4; b= (H/4)/2;
left_screen = [a-b Y-b a+b Y+b];
right_screen = [a*3-b Y-b a*3+b Y+b];
[right_dotX,right_dotY] = RectCenter (right_screen);
[left_dotX,left_dotY] = RectCenter (left_screen);

dot_right= [right_dotX-25,right_dotY-25, right_dotX+25,right_dotY+25];
dot_left= [left_dotX-25,left_dotY-25, left_dotX+25,left_dotY+25];

FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; %dibuja dos barras de ancho 1*20, con distinta orientación, forma una "+"
%% Matriz de respuesta:
% crea una matriz con tantas filas como ensayos tiene el expto y tantas columnas como datos a guardar
DATOS= NaN(n, 3); % Columnas: (1) ensayo congruente/incongruente, (2) respuesta correcta/incorrecta (3) TR

%% define el tipo de ensayo:
tipo_trial = zeros (2,n)
tipo_trial (1, 1:n/2)=1; 
tipo_trial (1, (n/2+1):end)=2; %Ahora haz que la mitad de los valores de tipo_trial, en la primera fila, sean un 1 y la otra mitad un 2 
tipo_trial (2, 1:n/3)= 1; % en 1/3 de los ensayos (n), el dot probe aparace en el círculo; 1= circulo
tipo_trial (2, (n/3+1):end)=2; % en 2/3 de los ensayos (n),  el dot probe aparece en el cuadrado (congruente); 2= cuadrado.
 
random_order = randperm(n); % creamos un orden aleatorio con el total de ensayos (n), y lo aplicamos a las filas de la matriz
tipo_trial(1,:)= tipo_trial(1,random_order);
tipo_trial(2,:)= tipo_trial(2,random_order);

KbName('UnifyKeyNames');
right_key=KbName('RightArrow'); 
left_key=KbName('LeftArrow');

%% Ciclo de ensayos
for i= 1:n %comienzan los ensayos (n veces)
    %% Secuencia ensayo:
    %% 0.- parametros tiempo
    time= 0.250; %tiempo de
    timedot=1.750; %tiempo de presentación del estímulo
    timefix= 0.2 + (0.5-0.2).*rand; %% elige un numero aleatorio entre 0.2 y 0.5
    %% 1.- punto de fijación:
    Screen('FillRect', wPtr, [255,255,255], FixCross');
    Screen('Flip', wPtr);
    WaitSecs(timefix);
    %% 2.- estimulos; muestra los ee durante "time" antes que aparezca el dot.
    if tipo_trial (1,i) == 1 % cuadrado en la parte izquierda de la pantalla/circulo en la derecha
        Screen ('FillRect', wPtr, [250 0 0], left_screen);
        Screen('FillOval', wPtr, [0 250 0], right_screen);
        Screen('Flip', wPtr); WaitSecs(time);
    elseif tipo_trial (1,i) == 2 % cuadrado en la parte derecha de la pantalla/ cuadrado en la izquierda
        Screen ('FillRect', wPtr, [250 0 0], right_screen);
        Screen('FillOval', wPtr, [0 250 0], left_screen);
        Screen('Flip', wPtr); WaitSecs(time);
    end
    %% 3.- estimulos + dot
    if tipo_trial (1,i) == 1 % izq= cuadrado; dch= circulo
        Screen ('FillRect', wPtr, [250 0 0], left_screen);
        Screen('FillOval', wPtr, [0 250 0], right_screen);
        if tipo_trial (2,i) == 1
            Screen ('FillRect', wPtr, [250 250 250], dot_right); % dot en circulo
            DATOS (i,1)= 2; % ensayo incongruente
        elseif tipo_trial (2,i) == 2
            Screen ('FillRect', wPtr, [250 250 250], dot_left); % dot en cuadrado
            DATOS (i,1)= 1; % ensayo congruente
        end
        Screen('Flip', wPtr);
        tStart = GetSecs; 
        % teclas de respuesta:
        if tipo_trial(1,i)== tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown ==0
                [KeyIsDown,~,KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,right_key) == 1
                    DATOS (i,2)= 1;
                elseif KeyCode (1,left_key)== 1
                    DATOS (i,2)= 0;
                end
            end
        elseif tipo_trial(1,i)~= tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~,KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,left_key)== 1
                    DATOS (i,2)= 1;
                elseif KeyCode(1,right_key)== 1
                    DATOS (i,2)= 0;
                end
            end
        end
        tEnd = GetSecs; 
        rt = tEnd - tStart;
        DATOS (i,3)= rt;
        KeyCode (right_key)=0; KeyCode (left_key)=0; rt=0;
        
        %%
    elseif tipo_trial (1,i) == 2 % izq= circulo; dch= cuadrado
        Screen ('FillRect', wPtr, [250 0 0], right_screen);
        Screen('FillOval', wPtr, [0 250 0], left_screen);
        if tipo_trial (2,i) == 1
            Screen ('FillRect', wPtr, [250 250 250], dot_left); % dot en circulo
            DATOS (i,1)= 2; % ensayo incongruente
        elseif tipo_trial (2,i) == 2
            Screen ('FillRect', wPtr, [250 250 250], dot_right); %dot en cuadrado
            DATOS (i,1)= 1; % ensayo congruente
        end
        Screen('Flip', wPtr);
        tStart = GetSecs; 
        % teclas de respuesta:
        if tipo_trial(1,i)== tipo_trial (2,i)
            [KeyIsDown,~,~]=KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~, KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,right_key)== 1
                    DATOS (i,2)= 1;
                elseif KeyCode(1,left_key)== 1
                    DATOS (i,2)= 0;
                end
            end
        elseif tipo_trial(1,i)~= tipo_trial (2,i)
            [KeyIsDown,~,~] =KbCheck;
            while KeyIsDown==0
                [KeyIsDown,~, KeyCode]=KbCheck; WaitSecs(0.1);
                if KeyCode(1,left_key)== 1
                    DATOS (i,2)= 1;
                elseif KeyCode(1,right_key)== 1
                    DATOS (i,2)= 0;
                end
            end
            
        end
        tEnd = GetSecs; 
        rt = tEnd - tStart;
        DATOS (i,3)= rt;
        KeyCode (right_key)=0; KeyCode (left_key)=0; rt=0;
    end
    
    % 4.pantalla vacía
    Screen('FillRect', wPtr, [180 180 180]);
    Screen('Flip', wPtr); WaitSecs(0.5);
    
end
save DATOS
Screen ('CloseAll')

%% Hacer la media de los ensayos congruentes e incongruentes por separado, no incluir los ensayos que sean errores.
congruente= [];
incongruente= [];
for i= 1:n
    if DATOS (i, 1)==1 && DATOS (i,2)== 1        % ensayos congruentes
        congruente= [congruente, DATOS(i, 3)];
    elseif DATOS (i, 1)==2 && DATOS (i,2)== 1    % ensayos incongruentes
        incongruente= [incongruente, DATOS(i, 3)];
    end
end
media_congruente = mean(congruente);
media_incongruente = mean(incongruente);

fprintf ('\nLa media del tiempo de reaccion en los ensayos congruentes es %d\n',media_congruente);
fprintf ('La media del tiempo de reaccion en los ensayos incongruentes es %d\n',media_incongruente);

%% Some feedback
if media_congruente < media_incongruente
    fprintf('Enhorabuena! :)\n');
    load handel; 
    sound(y, Fs);
else 
    fprintf ('Algo no ha salido bien con tus datos :( \n');
end

