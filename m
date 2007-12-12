From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH] Fujitsu application panel led value
Date: Wed, 12 Dec 2007 15:21:43 -0700
Message-ID: <20071212152143.04c83e93@shemminger-laptop>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net>
	<200709140130.59732.dtor@insightbb.com>
	<20070916215516.2934abad@oldman.hemminger.net>
	<200709161623.00286.dtor@insightbb.com>
	<20071023125555.38d63567@shemminger-laptop>
	<d120d5000712120610m30c054f5w596c29a1700211f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757429AbXLLWWq@vger.kernel.org>
In-Reply-To: <d120d5000712120610m30c054f5w596c29a1700211f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use proper encoding for LED values.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

---
Note: earlier code worked because hardware only checks for zero.

--- a/drivers/input/misc/apanel.c	2007-12-12 13:07:03.000000000 -0700
+++ b/drivers/input/misc/apanel.c	2007-12-12 14:42:09.000000000 -0700
@@ -132,11 +132,11 @@ static void mail_led_set(struct led_clas
 			 enum led_brightness value)
 {
 	struct apanel *ap = container_of(led, struct apanel, mail_led);
-	if (value)
+
+	if (value != LED_OFF)
 		ap->led_bits |= 0x8000;
 	else
 		ap->led_bits &= ~0x8000;
-	ap->led_bits = value;
 	schedule_work(&ap->led_work);
 }
 
