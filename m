From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: [PATCH 2/3] leds-clevo-mail: hw accelerated LED blink extension
Date: Tue, 17 Jul 2007 12:18:34 +0200
Message-ID: <469C977A.8000908@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932697AbXGQKTH@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Rodrigo Pereira <rodripe@gmail.com>
List-Id: linux-input@vger.kernel.org

=46rom: M=E1rton N=E9meth <nm127@freemail.hu>

Extends the leds subsystem with a blink_set() callback function which c=
an
optionally implemented by a LED driver. If implemented, the driver can =
use the
hardware acceleration for blinking a LED.

Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>
---
diff -uprN linux-2.6.22.orig/Documentation/leds-class.txt linux-2.6.22/=
Documentation/leds-class.txt
--- linux-2.6.22.orig/Documentation/leds-class.txt	2007-07-09 01:32:17.=
000000000 +0200
+++ linux-2.6.22/Documentation/leds-class.txt	2007-07-16 20:53:38.00000=
0000 +0200
@@ -47,6 +47,17 @@ overhead, I suggest these become part of
  above leaves scope for further attributes should they be needed.


+Hardware accelerated blink of LEDs
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Some LEDs can be programmed to blink without any CPU interaction. To
+support this feature, a LED driver can optionally implement the
+blink_set() function (see <linux/leds.h>). If implemeted, the
+ledtrig-timer tries to use it. The blink_set() function should return
+1 if the blink setting is supported, or 0 otherwise, which means that
+the LED will be turned on and off from software.
+
+
  Known Issues
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

@@ -55,10 +66,6 @@ would cause nightmare dependency issues.
  compared to the benefits the simple trigger functionality brings. The
  rest of the LED subsystem can be modular.

-Some leds can be programmed to flash in hardware. As this isn't a gene=
ric
-LED device property, this should be exported as a device specific sysf=
s
-attribute rather than part of the class if this functionality is requi=
red.
-

  Future Development
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -uprN linux-2.6.22.orig/drivers/leds/ledtrig-timer.c linux-2.6.22/=
drivers/leds/ledtrig-timer.c
--- linux-2.6.22.orig/drivers/leds/ledtrig-timer.c	2007-07-09 01:32:17.=
000000000 +0200
+++ linux-2.6.22/drivers/leds/ledtrig-timer.c	2007-07-17 09:43:20.00000=
0000 +0200
@@ -76,8 +76,21 @@ static ssize_t led_delay_on_store(struct
  		count++;

  	if (count =3D=3D size) {
-		timer_data->delay_on =3D state;
-		mod_timer(&timer_data->timer, jiffies + 1);
+		if (timer_data->delay_on !=3D state) {
+			/* the new value differs from the previous */
+			timer_data->delay_on =3D state;
+
+			/* deactivate previous settings */
+			del_timer_sync(&timer_data->timer);
+
+			/* try to activate hardware acceleration, if any */
+			if (!led_cdev->blink_set ||
+			    !led_cdev->blink_set(led_cdev,
+				timer_data->delay_on, timer_data->delay_off)) {
+				/* no hardware acceleration, blink via timer */
+				mod_timer(&timer_data->timer, jiffies + 1);
+			}
+		}
  		ret =3D count;
  	}

@@ -108,8 +121,21 @@ static ssize_t led_delay_off_store(struc
  		count++;

  	if (count =3D=3D size) {
-		timer_data->delay_off =3D state;
-		mod_timer(&timer_data->timer, jiffies + 1);
+		if (timer_data->delay_off !=3D state) {
+			/* the new value differs from the previous */
+			timer_data->delay_off =3D state;
+
+			/* deactivate previous settings */
+			del_timer_sync(&timer_data->timer);
+
+			/* try to activate hardware acceleration, if any */
+			if (!led_cdev->blink_set ||
+			    !led_cdev->blink_set(led_cdev,
+				timer_data->delay_on, timer_data->delay_off)) {
+				/* no hardware acceleration, blink via timer */
+				mod_timer(&timer_data->timer, jiffies + 1);
+			}
+		}
  		ret =3D count;
  	}

diff -uprN linux-2.6.22.orig/include/linux/leds.h linux-2.6.22/include/=
linux/leds.h
--- linux-2.6.22.orig/include/linux/leds.h	2007-07-09 01:32:17.00000000=
0 +0200
+++ linux-2.6.22/include/linux/leds.h	2007-07-16 20:53:38.000000000 +02=
00
@@ -38,6 +38,11 @@ struct led_classdev {
  	void		(*brightness_set)(struct led_classdev *led_cdev,
  					  enum led_brightness brightness);

+	/* Activate hardware accelerated blink */
+	int		(*blink_set)(struct led_classdev *led_cdev,
+				     int delay_on, int delay_off);
+
+
  	struct class_device	*class_dev;
  	struct list_head	 node;			/* LED Device list */
  	char			*default_trigger;	/* Trigger to use */
