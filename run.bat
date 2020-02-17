start redis-server.exe
node server.js
pause
taskkill /F /IM "redis-server.exe" /T
taskkill /F /IM "cmd.exe" /T