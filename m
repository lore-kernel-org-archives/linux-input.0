From: "Karl Pickett" <karl.pickett@gmail.com>
Subject: [PATCH] Make ati_remote button repeat sensitivity soft-configurable (V2)
Date: Thu, 5 Apr 2007 10:23:28 -0400
Message-ID: <f9be06770704050723p1a01f9adyae8fc671c91edb7c@mail.gmail.com>
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
To: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Cc: Vincent Vanackere <vincent.vanackere@gmail.com>
List-Id: linux-input@vger.kernel.org

Dmitry, please use this instead of my previous patch.  Thanks to
Vincent for the code review , fixes, and testing.

ati_remote causes repeats after only .23 seconds with my remote and
makes it hard to use comfortably.  Make a precise way of setting the
repeat delay time in milliseconds and default it to 500ms.  The old
behavior can be had by setting repeat_delay =3D 0.

Signed-off-by: Karl Pickett <karl.pickett@gmail.com>
Signed-off-by: Vincent Vanackere <vincent.vanackere@gmail.com>

 --- drivers/usb/input/ati_remote.c.orig=092007-04-04 22:05:10.000000000 +0=
200
+++ drivers/usb/input/ati_remote.c=092007-04-04 22:35:59.000000000 +0200
@@ -120,6 +120,7 @@
  * behaviour.
  */
 #define FILTER_TIME=0960 /* msec */
+#define REPEAT_DELAY=09500 /* msec */

 static unsigned long channel_mask;
 module_param(channel_mask, ulong, 0644);
@@ -133,6 +134,10 @@
 module_param(repeat_filter, int, 0644);
 MODULE_PARM_DESC(repeat_filter, "Repeat filter time, default =3D 60 msec")=
;

+static int repeat_delay =3D REPEAT_DELAY;
+module_param(repeat_delay, int, 0644);
+MODULE_PARM_DESC(repeat_delay, "Delay before sending repeats, default
=3D 500 msec");
+
 #define dbginfo(dev, format, arg...) do { if (debug) dev_info(dev ,
format , ## arg); } while (0)
 #undef err
 #define err(format, arg...) printk(KERN_ERR format , ## arg)
@@ -174,6 +179,8 @@
 =09unsigned char old_data[2];  /* Detect duplicate events */
 =09unsigned long old_jiffies;
 =09unsigned long acc_jiffies;  /* handle acceleration */
+=09unsigned long first_jiffies;
+
 =09unsigned int repeat_count;

 =09char name[NAME_BUFSIZE];
@@ -501,21 +508,31 @@
 =09}

 =09if (ati_remote_tbl[index].kind =3D=3D KIND_FILTERED) {
+=09=09unsigned long now =3D jiffies;
+
 =09=09/* Filter duplicate events which happen "too close" together. */
 =09=09if (ati_remote->old_data[0] =3D=3D data[1] &&
 =09=09    ati_remote->old_data[1] =3D=3D data[2] &&
-=09=09    time_before(jiffies, ati_remote->old_jiffies +
msecs_to_jiffies(repeat_filter))) {
+=09=09    time_before(now, ati_remote->old_jiffies +
+=09=09=09=09     msecs_to_jiffies(repeat_filter))) {
 =09=09=09ati_remote->repeat_count++;
 =09=09} else {
 =09=09=09ati_remote->repeat_count =3D 0;
+=09=09=09ati_remote->first_jiffies =3D now;
 =09=09}

 =09=09ati_remote->old_data[0] =3D data[1];
 =09=09ati_remote->old_data[1] =3D data[2];
-=09=09ati_remote->old_jiffies =3D jiffies;
+=09=09ati_remote->old_jiffies =3D now;

+=09=09/* Ensure we skip at least the 4 first duplicate events (generated
+=09=09 * by a single keypress), and continue skipping until repeat_delay
+=09=09 * msecs have passed
+=09=09 */
 =09=09if (ati_remote->repeat_count > 0 &&
-=09=09    ati_remote->repeat_count < 5)
+=09=09    (ati_remote->repeat_count < 5 ||
+=09=09     time_before(now, ati_remote->first_jiffies +
+=09=09=09=09      msecs_to_jiffies(repeat_delay))))
 =09=09=09return;




--=20
Karl Pickett
The most wasted of all days is one without laughter.=97E.E. Cummings
