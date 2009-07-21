From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Support for synaptic touchscreen in HTC dream
Date: Tue, 21 Jul 2009 12:40:15 +0200
Message-ID: <20090721104015.GI4133@elf.ucw.cz>
References: <20090714100634.GA4054@elf.ucw.cz> <5d5443650907140320w334864f4uc1ee13ed32fdb874@mail.gmail.com> <20090715133627.GA2538@elf.ucw.cz> <d6200be20907151433q2f1ddc61m13c258c06ca4fd76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755245AbZGUKlP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d6200be20907151433q2f1ddc61m13c258c06ca4fd76@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, Andrew Morton <akpm@osdl.org>, linux-i2c@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi!

> >> > +static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
> >> > +{
> >>
> >> some documentation about this logic would be great.
> >
> > Arve, can you help here?
> 
> This sensor sends two 6-byte absolute finger reports, an optional
> 2-byte relative report followed by a status byte
> (http://www.synaptics.com/sites/default/files/511_000099_01F.pdf).
> This function reads the two finger reports and transforms the
> coordinates according the platform data so they can be aligned with
> the lcd behind the touchscreen. typically we flip the y-axis since the
> sensor uses the bottom left corner as the origin, but if the sensor is
> mounted upside down the platform data will request that the x-axis
> should be flipped instead. The snap to inactive edge border are used
> to allow tapping the edges of the screen on the G1. The active area of
> the touchscreen is smaller than the lcd. When the finger gets close
> the edge of the screen we snap it to the edge. This allows ui elements
> at the edge of the screen to be hit, and it prevents hitting ui
> elements that are not at the edge of the screen when the finger is
> touching the edge.

Thanks. I added it like this:

diff --git a/drivers/input/touchscreen/synaptics_i2c_rmi.c b/drivers/input/touchscreen/synaptics_i2c_rmi.c
index 771b710..3ff62b1 100644
--- a/drivers/input/touchscreen/synaptics_i2c_rmi.c
+++ b/drivers/input/touchscreen/synaptics_i2c_rmi.c
@@ -13,6 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
+ * http://www.synaptics.com/sites/default/files/511_000099_01F.pdf
  */
 
 #include <linux/module.h>
@@ -87,6 +87,22 @@ static int synaptics_init_panel(struct synaptics_ts_data *ts)
 
 static void decode_report(struct synaptics_ts_data *ts, u8 *buf)
 {
+/* 
+ * This sensor sends two 6-byte absolute finger reports, an optional
+ * 2-byte relative report followed by a status byte. This function
+ * reads the two finger reports and transforms the coordinates
+ * according the platform data so they can be aligned with the lcd
+ * behind the touchscreen. Typically we flip the y-axis since the
+ * sensor uses the bottom left corner as the origin, but if the sensor
+ * is mounted upside down the platform data will request that the
+ * x-axis should be flipped instead. The snap to inactive edge border
+ * are used to allow tapping the edges of the screen on the G1. The
+ * active area of the touchscreen is smaller than the lcd. When the
+ * finger gets close the edge of the screen we snap it to the
+ * edge. This allows ui elements at the edge of the screen to be hit,
+ * and it prevents hitting ui elements that are not at the edge of the
+ * screen when the finger is touching the edge.
+ */
 	int pos[2][2];
 	int f, a;
 	int base = 2;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
