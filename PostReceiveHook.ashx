<%@ WebHandler Language="C#" Class="PostReceiveHook" %>

using System;
using System.Web;
using System.Threading ;
using System.Configuration;
using System.Diagnostics;
using System.ServiceProcess;



public class PostReceiveHook : IHttpHandler {

    public Logger Log {
        get;
        set;
    }

    public void ProcessRequest(HttpContext context) {
        Log = new Logger(context.Server.MapPath("~/log.txt"));
        var req = context.Request;
        Log.Log("pull request received");
        Deploy();
          
        context.Response.ContentType = "text/plain";
        context.Response.Write("pull request submitted");
        Log.Dispose();
    }

    private void Deploy() {
        ExecuteCommandSync("");
    }
    
    public void ExecuteCommandSync(object command) {
        try {
            
            Log.Log("begin deploy");
            string fileNameWithPath = @"C:\Windows\system32\cmd";
            ProcessStartInfo startInfo = new ProcessStartInfo();
            startInfo.Arguments = @"/C cd C:\iisdeploy\ && echo push > hasnewpush.txt";
            startInfo.CreateNoWindow = true;
            startInfo.UseShellExecute = true;

            startInfo.WorkingDirectory = "C:\\iisdeploy\\";
            startInfo.FileName = fileNameWithPath;
            Process exeProcess = Process.Start(startInfo);

            Log.Log("end deploy");
        } catch (Exception exp) {
            Log.LogError("EXP:"+exp.Message);
              Log.Dispose();
        }
    }

    public void ExecuteCommandAsync(string command) {
        try {
            var thread = new Thread(new ParameterizedThreadStart(ExecuteCommandSync));
            thread.IsBackground = true;
            thread.Priority = ThreadPriority.AboveNormal;
            thread.Start(command);
        } catch (ThreadStartException exp) {
        } catch (ThreadAbortException exp) {
        } catch (Exception exp) {
        }
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}