From: "Karl Pickett" <karl.pickett@gmail.com>
Subject: [PATCH] Make ati_remote button repeat sensitivity soft-configurable
Date: Tue, 3 Apr 2007 20:34:17 -0400
Message-ID: <f9be06770704031734k11ec894fpdf1afe385108aece@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

The ati_remote driver is a little too sensitive for my wife... if you
do anything but barely tap the button you can get multiple events
reported.  We prefer a more conservative no-repeat setting.  This is a
pretty trivial patch which just makes one hard coded value soft
configurable and does not change the default.

--- linux-source-2.6.20/drivers/usb/input/ati_remote.c.kjp
2006-12-07 22:50:56.000000000 -0500
+++ linux-source-2.6.20/drivers/usb/input/ati_remote.c  2007-04-03
20:19:24.000000000 -0400
@@ -119,7 +119,9 @@
  * and we have to take this into account for an accurate repeat
  * behaviour.
  */
-#define FILTER_TIME    60 /* msec */
+#define FILTER_TIME    60 /* millisec between each repeat */
+
+#define FILTER_MAX     5 /* number of repeats to ignore */

 static unsigned long channel_mask;
 module_param(channel_mask, ulong, 0644);
@@ -133,6 +135,11 @@
 module_param(repeat_filter, int, 0644);
 MODULE_PARM_DESC(repeat_filter, "Repeat filter time, default =3D 60 msec")=
;

+static int repeat_filter_max =3D FILTER_MAX;
+module_param(repeat_filter_max, int, 0644);
+MODULE_PARM_DESC(repeat_filter_max,
+       "Number of repeats to ignore, default =3D 5");
+
 #define dbginfo(dev, format, arg...) do { if (debug) dev_info(dev ,
format , ## arg); } while (0)
 #undef err
 #define err(format, arg...) printk(KERN_ERR format , ## arg)
@@ -515,7 +522,7 @@
                ati_remote->old_jiffies =3D jiffies;

                if (ati_remote->repeat_count > 0 &&
-                   ati_remote->repeat_count < 5)
+                   ati_remote->repeat_count < repeat_filter_max)
                        return;




--=20
Karl Pickett
The most wasted of all days is one without laughter.=97E.E. Cummings
