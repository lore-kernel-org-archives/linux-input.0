From: Pavel Machek <pavel@ucw.cz>
Subject: ads7846 touchscreen: fix pressure
Date: Tue, 6 Oct 2009 21:54:13 +0200
Message-ID: <20091006195413.GA1469@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752085AbZJGVIa@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-input@vger.kernel.org


On Zaurus, pressure is reported inverted -- the lighter the pressure,
the bigger numerical value. This should fix it.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- linux-rc/drivers/input.ofic/touchscreen/ads7846.c	2009-10-06 13:49:56.000000000 +0200
+++ linux-rc/drivers/input/touchscreen/ads7846.c	2009-10-06 21:18:25.000000000 +0200
@@ -608,12 +609,12 @@
 
 		input_report_abs(input, ABS_X, x);
 		input_report_abs(input, ABS_Y, y);
-		input_report_abs(input, ABS_PRESSURE, Rt);
+		input_report_abs(input, ABS_PRESSURE, ts->pressure_max-Rt);
 
 		input_sync(input);
 #ifdef VERBOSE
 		dev_dbg(&ts->spi->dev, "%4d/%4d/%4d\n", x, y, Rt);
 #endif
 	}
 
 	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
