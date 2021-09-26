**Problem: Auto deploy changes from github repo to production web server**  

Production Server Information
- Server Engine: IIS
- Has 3 Servers 

1. Web Server
2. File Server
3. DB Server

**Problem Statements**

1. I can confirm that you can create a batch file that will pull from the origin repository, and run it **manually --means double clicking the file** .
2. You can run a batch file via ASP.NET, but running a git pull won't proceed, but a cmd process file can be seen on taskmgr.
3. I already did trying a git pull by using psexec with administrator password via batch file, still no avail, [it works if you run it directly via cmd ]. [ Please take note, if this succeed on your end, dont do this, this is a security flaw if you will still proceed. ] 
4. Already tried creating a window process and run a batch file, but it still didnt work.
5. MSSQL JOB? Still dont work, since my DB Server is outside Web Server.

**Solution**

1. Clone this repository
2. Deploy this repository on your IIS
3. Run the web system and ensure that your PostReceiveHook is publicly available ( means anyone on the web can access ) .
4. Open github > your target repository > go to settings > webhooks > add weebhook 

- Put the PostReceiveHook url in Payload URL
- Content Type - JSON
- Attach your secret key 
- Select "JUST PUSH EVENT"
- Check "ACTIVE"
- Click ADD WEBHOOK

5. Now , on your local repository, change anything then commit and push.
6. Check your webhook event if it's successful
7. Now on your WEBSERVER
8. Edit hasnewpush.txt, ensure that there are no value on this file. This is the file that the bat will check if there are new push events.
9. Edit checkpush.bat > ensure that your repository is pointed
10. Run the checkpush.bat -- this batch file check if there are push events every 10 seconds, you can change it by editing "timeout /t **10** /nobreak > NUL"  .
10. If this has been all set, open the PostReceiveHook on your browser
11.  You will notice that the batch file will now pull on your repository

Notes:
If your repository is private, run first a pull on cmd ensure that you cache your credentials/token

Thanks to @tshwanng [ https://github.com/tshwangq/IISDeploy ] for the help. 

Goodluck all!
