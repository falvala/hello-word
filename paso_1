%%  PROBLEMA #1.

[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
WaitSecs(5);
Screen ('CloseAll')
W = Rect(RectRight); % ancho
H = RectHeight(Rect) % alto

%% PROBLEMA #2.

[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(2);
W = Rect(RectRight); % ancho
H = RectHeight(Rect) % alto
Screen ('FillRect', wPtr, [250 0 0], [W/2-200 H/2-200 W/2+200 H/2+200])
Screen('Flip', wPtr); WaitSecs(2);
Screen ('FillRect', wPtr, [180 180 180])
Screen('Flip', wPtr); WaitSecs(1);
Screen ('FillRect', wPtr, [250 0 0], [W/2-600 H/2-200 W/2-200 H/2+200])
Screen('Flip', wPtr); WaitSecs(2);
Screen ('CloseAll')

%% PROBLEMA #3.

[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(2);
W = Rect(RectRight); % ancho
H = RectHeight(Rect) % alto
Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8 H/2-H/8 W/2+W/8 H/2+H/8])
a= (W/2+W/8)- (W/2-W/8);
Screen('Flip', wPtr); WaitSecs(2);
Screen ('FillRect', wPtr, [180 180 180])
Screen('Flip', wPtr); WaitSecs(1);
Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8])
Screen('Flip', wPtr); WaitSecs(2);
Screen ('CloseAll')

%% PROBLEMA #4. 

clear all
pseudoal= [3:7];
election= randperm (4);
time= pseudoal (election (1))
clear pseudoal election

[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(2);
W = Rect(RectRight); % ancho
H = RectHeight(Rect); % alto
[X,Y] = RectCenter(Rect);
Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8 H/2-H/8 W/2+W/8 H/2+H/8])
a= (W/2+W/8)- (W/2-W/8);
Screen('Flip', wPtr); WaitSecs(time);
Screen ('FillRect', wPtr, [180 180 180])
Screen('Flip', wPtr); WaitSecs(1);
Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8])
Screen('Flip', wPtr); WaitSecs(time);
Screen ('CloseAll')

%% PROBLEMA #5. 
clear all
pseudoal= [3:7]; election= randperm (4);
time= pseudoal (election (1))
clear pseudoal election
timefix= 0.2 + (0.5-0.2).*rand %% elige un numero aleatorio entre 0.2 y 0.5
  %pseudoal= [0.2 : 0.1 : 0.5]; election= randperm (4);
  %timefix= pseudoal (election (1))
clear pseudoal election

%presenta la pantalla
Screen ('Preference','SkipSyncTests', 1);
[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(2);

%parametros pantalla:
W = Rect(RectRight); % ancho total 
H = RectHeight(Rect); % alto total
[X,Y] = RectCenter(Rect);

% punto de fijación:
FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; %dibuja dos barras de ancho 1*20, con distinta orientación, forma una "+"
Screen('FillRect', wPtr, [255,255,255], FixCross');
Screen('Flip', wPtr);
WaitSecs(timefix);

% cuadrado en el centro de la pantalla:
Screen ('FillRect', wPtr, [250 0 0], [X-W/8 Y-H/8 X+W/8 Y+H/8])
a= (X+W/8)- (X-W/8);
Screen('Flip', wPtr); WaitSecs(time);

%punto de fijación
FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1];
Screen('FillRect', wPtr, [255,255,255], FixCross');
Screen('Flip', wPtr);
WaitSecs(timefix);

%cuadrado a la derecha de la pantalla
Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8])
Screen('Flip', wPtr); WaitSecs(time);
Screen ('CloseAll')

%% PROBLEMA #6.

time=2
timefix= 0.2 + (0.5-0.2).*rand %% elige un numero aleatorio entre 0.2 y 0.5
  %pseudoal= [0.2 : 0.1 : 0.5]; election= randperm (4);
  %timefix= pseudoal (election (1))
clear pseudoal election

%presenta la pantalla
Screen ('Preference','SkipSyncTests', 1);
[wPtr, Rect] = Screen('OpenWindow', 0, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(1);

%parametros pantalla:
W = Rect(RectRight); % ancho total 
H = RectHeight(Rect); % alto total
[X,Y] = RectCenter(Rect);
a= (X+W/8)- (X-W/8);

% punto de fijación:
FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1]; %dibuja dos barras de ancho 1*20, con distinta orientación, forma una "+"
Screen('FillRect', wPtr, [255,255,255], FixCross');
Screen('Flip', wPtr);
WaitSecs(timefix);

%cuadrado a la izquierda de la pantalla/circulo a la derecha
Screen ('FillRect', wPtr, [250 0 0], [W/2-W/8-a H/2-H/8 W/2-W/8 H/2+H/8]);
Screen('FillOval', wPtr, [0 250 0], [X+W/8 Y-H/8 X+W/8+a Y+H/8]); 
Screen('Flip', wPtr); WaitSecs(time);
Screen('FillRect', wPtr, [180 180 180]);
Screen('Flip', wPtr); WaitSecs(1);
Screen ('CloseAll')

