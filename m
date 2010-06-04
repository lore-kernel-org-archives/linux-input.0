From: Dan Carpenter <error27@gmail.com>
Subject: [patch] input: off by one in pcf8574_kp_irq_handler()
Date: Sat, 5 Jun 2010 01:19:39 +0200
Message-ID: <20100604231939.GJ5483@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f223.google.com ([209.85.219.223]:41219 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757065Ab0FDXT4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Jun 2010 19:19:56 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>, Richard Purdie <rpurdie@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

If nextstate == ARRAY_SIZE(lp->btncode), then we read one past the end of
the array on the next line.

This fixes a smatch warning:
drivers/input/misc/pcf8574_keypad.c +74 pcf8574_kp_irq_handler(8)
	error: buffer overflow 'lp->btncode' 17 <= 17

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
index 0ac47d2..4b42ffc 100644
--- a/drivers/input/misc/pcf8574_keypad.c
+++ b/drivers/input/misc/pcf8574_keypad.c
@@ -69,7 +69,7 @@ static irqreturn_t pcf8574_kp_irq_handler(int irq, void *dev_id)
 	unsigned char nextstate = read_state(lp);
 
 	if (lp->laststate != nextstate) {
-		int key_down = nextstate <= ARRAY_SIZE(lp->btncode);
+		int key_down = nextstate < ARRAY_SIZE(lp->btncode);
 		unsigned short keycode = key_down ?
 			lp->btncode[nextstate] : lp->btncode[lp->laststate];
 
