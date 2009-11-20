From: Pavel Machek <pavel@ucw.cz>
Subject: ads7846 touchscreen: fix pressure
Date: Fri, 20 Nov 2009 19:22:39 +0100
Message-ID: <20091120182238.GA1344@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34881 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbZKTSW4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 13:22:56 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>


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
