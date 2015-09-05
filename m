From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: walkera0701 - fix abs() calculations on 64 bit values
Date: Sat, 5 Sep 2015 10:25:43 -0700
Message-ID: <20150905172543.GA23438@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32870 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbIERZr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2015 13:25:47 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, John Stultz <john.stultz@linaro.org>, Peter Popovec <popovec@oko.fei.tuke.sk>, linux-kernel@vger.kernel.org

abs() function can not be used with 64 bit values, so let's switch to
abs64(). From include/linux/kernel.h:

/*
 * abs() handles unsigned and signed longs, ints, shorts and chars.
 * For all input types abs() returns a signed long.
 * abs() should not be used for 64-bit types (s64, u64, long long)
 * - use abs64() for those.
 */

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/walkera0701.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index b76ac58..a8bc2fe 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -150,7 +150,7 @@ static void walkera0701_irq_handler(void *handler_data)
 		if (w->counter == 24) {	/* full frame */
 			walkera0701_parse_frame(w);
 			w->counter = NO_SYNC;
-			if (abs(pulse_time - SYNC_PULSE) < RESERVE)	/* new frame sync */
+			if (abs64(pulse_time - SYNC_PULSE) < RESERVE)	/* new frame sync */
 				w->counter = 0;
 		} else {
 			if ((pulse_time > (ANALOG_MIN_PULSE - RESERVE)
@@ -161,7 +161,7 @@ static void walkera0701_irq_handler(void *handler_data)
 			} else
 				w->counter = NO_SYNC;
 		}
-	} else if (abs(pulse_time - SYNC_PULSE - BIN0_PULSE) <
+	} else if (abs64(pulse_time - SYNC_PULSE - BIN0_PULSE) <
 				RESERVE + BIN1_PULSE - BIN0_PULSE)	/* frame sync .. */
 		w->counter = 0;
 
-- 
2.5.0.457.gab17608


-- 
Dmitry
