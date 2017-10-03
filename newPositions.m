function [f1x, f1y, f2x, f2y, size, scr, isTouching] = newPositions(hObject, handles)

isTouching = false;
pause(.1);

if handles.snake(1, 1) == handles.food(1) && handles.snake(1, 2) == handles.food(2)
    isTouching = true;
    size = handles.snakeSize + 1;
    scr = handles.scoreNum + 1;
    f1x = randi(18);
    f1y = randi(18);
    f2x = handles.food(3);
    f2y = handles.food(4);

end

if handles.snake(1, 1) == handles.food(3) && handles.snake(1, 2) == handles.food(4)
    isTouching = true;
    size = handles.snakeSize + 1;
    scr = handles.scoreNum + 1;
    f2x = randi(18);
    f2y = randi(18);
    f1x = handles.food(1);
    f1y = handles.food(2);
end

if isTouching ~= true
    f2x = handles.food(3);
    f2y = handles.food(4);
    scr = handles.scoreNum;
    isTouching = false;
    f1x = handles.food(1);
    f1y = handles.food(2);
    size = handles.snakeSize;
end

guidata(hObject, handles);
end