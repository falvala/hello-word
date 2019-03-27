%% PROBLEMAS RELACIONADOS CON (1) CREAR UN "LOOP" QUE SE REPITE (CADA ITERACIÓN DEL LOOP SERÁ UN ENSAYO) Y (2) USAR EL if PARA (3) ESTABLECER QUÉ PASA EN CADA ENSAYO MEDIANTE UNA VARIABLE:

%% PROBLEMA #7. Añade una pantalla vacía (fondo gris) que seguiría a la presentación de los estímulos 
% durante 0.5 segundos. La secuencia ahora debe ser: Cruz de fijación-->Estímulos-->Pantalla vacía. 
% Esta secuencia la llamaremos "ensayo".

clear all
pseudoal= [3:7]; election= randperm (4);
time= pseudoal (election (1))
clear pseudoal election

time=2
timefix= 0.2 + (0.5-0.2).*rand 

%presenta la pantalla
[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(1);

%parametros pantalla:
W = Rect(RectRight); % ancho total 
H = RectHeight(Rect); % alto total
[X,Y] = RectCenter(Rect);
a= (X+W/8)- (X-W/8);
%ENSAYO
% 1.punto de fijación:
FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; 
Screen('FillRect', wPtr, [255,255,255], FixCross');
Screen('Flip', wPtr);
WaitSecs(timefix);
% 2.estimulos
Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8]);
Screen('FillOval', wPtr, [0 250 0], [X+W/8 Y-H/8 X+W/8+a Y+H/8]);  
Screen('Flip', wPtr); WaitSecs(time);
% 3.pantalla vacía
Screen('FillRect', wPtr, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(0.5);
Screen ('CloseAll')

%% %% PROBLEMA #8. Haz que se repitan 6 ensayos. No copies y peges el código de un ensayo 6 veces! 

clear all
% definir numero de ensayos
n= 6

[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(1);

%parametros pantalla:
W = Rect(RectRight); H = RectHeight(Rect); [X,Y] = RectCenter(Rect); a= (X+W/8)- (X-W/8);

%comiensan los ensayos (n veces)
for i= 1:n 
    %secuencia ensayo:
    % 0.parametros tiempo
    time=2 %tiempo de presentación del estímulo
    timefix= 0.2 + (0.5-0.2).*rand 
    %% 1.punto de fijación:
    FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; 
    Screen('FillRect', wPtr, [255,255,255], FixCross');
    Screen('Flip', wPtr);
    WaitSecs(timefix);
    % 2.estimulos
    Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8]);
    Screen('FillOval', wPtr, [0 250 0], [X+W/8 Y-H/8 X+W/8+a Y+H/8]);  
    Screen('Flip', wPtr); WaitSecs(time);
    % 3.pantalla vacía
    Screen('FillRect', wPtr, [180 180 180]);
    Screen('Flip', wPtr); WaitSecs(0.5);
    
end
Screen ('CloseAll')

%% PROBLEMA #9: Cambia el código de modo que en la mitad de los ensayos el cuadrado esté a la izquierda y el circulo a la derecha, y en la otra mitad al contrario.
% (TIP: Crea una variable [por ejemplo <tipo_trial>]. Esta variable debe contener tantos elementos (columnas) como número de ensayos. Por ahora tendrá solo una fila.

clear all

n= 6                                % definir numero de ensayos

[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(1);

%parametros pantalla:
W = Rect(RectRight); H = RectHeight(Rect); [X,Y] = RectCenter(Rect); a= (X+W/8)- (X-W/8);

%define el tipo de ensayo:
tipo_trial = zeros (1,n);           % la creamos llena de zeros
tipo_trial (1, 1:n/2)=1
tipo_trial (1, (n/2+1):end)=2       %Ahora haz que la mitad de los valores de tipo_trial sean un 1 y la otra mitad un 2. 


%comienzan los ensayos (n veces)
for i= 1:n 
    %secuencia ensayo:
    % 0.parametros tiempo
    time=2 %tiempo de presentación del estímulo
    timefix= 0.2 + (0.5-0.2).*rand %% elige un numero aleatorio entre 0.2 y 0.5
    %% 1.punto de fijación:
    FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; 
    Screen('FillRect', wPtr, [255,255,255], FixCross');
    Screen('Flip', wPtr);
    WaitSecs(timefix);
    % 2.estimulos
    if tipo_trial (1,i) == 1
    Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8]);
    Screen('FillOval', wPtr, [0 250 0], [X+W/8 Y-H/8 X+W/8+a Y+H/8]); 
    Screen('Flip', wPtr); WaitSecs(time);
    elseif tipo_trial (1,i) == 2
    Screen ('FillRect', wPtr, [250 0 0], [X+W/8 Y-H/8 X+W/8+a Y+H/8]);
    Screen('FillOval', wPtr, [0 250 0], [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8]);
    Screen('Flip', wPtr); WaitSecs(time);
    end
    % 3.pantalla vacía
    Screen('FillRect', wPtr, [180 180 180]);
    Screen('Flip', wPtr); WaitSecs(0.5);
    
end
Screen ('CloseAll')
