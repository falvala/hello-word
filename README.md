# hello-world
just another repository


[wPtr, Rect] = Screen('OpenWindow', 1, [180 180 180]);
Screen('TextSize', wPtr , 30);
Screen('TextFont', wPtr , 'Helvetica');
Screen('TextStyle', wPtr , 64);
Screen('DrawText', wPtr , 'Hello world!!', 100, 100, [255 128 255]);
Screen('Flip', wPtr);
WaitSecs(5);
Screen ('CloseAll')
