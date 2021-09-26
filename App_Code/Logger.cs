using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

    public class Logger : IDisposable {
        private StreamWriter sw;

        public Logger(string filePath) {
            sw = new StreamWriter(filePath, true);
        }
        public void Log(string text) {
            sw.WriteLine(string.Format("[{0}] {1}", DateTime.Now, text));
            sw.Flush();
        }
        public void LogError(string text) {
            sw.WriteLine(string.Format("[{0}] [error] {1}", DateTime.Now, text));
            sw.Flush();
        }
        #region IDisposable Members

        public void Dispose() {
            sw.Flush();
            sw.Close();
            sw.Dispose();
        }

        #endregion
    }
 