From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: fix format string in elo driver
Date: Thu, 30 Oct 2008 11:55:06 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0810301154170.12928@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:50374 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753798AbYJ3KzI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2008 06:55:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Fix typo in format string.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

Resent, as I can't see it in input tree, so it probably got lost 
somewhere. Thanks.

diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
index d20689c..8f38c5e 100644
--- a/drivers/input/touchscreen/elo.c
+++ b/drivers/input/touchscreen/elo.c
@@ -262,7 +262,7 @@ static int elo_setup_10(struct elo *elo)
 		input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
 
 	printk(KERN_INFO "elo: %sTouch touchscreen, fw: %02x.%02x, "
-		"features: %x02x, controller: 0x%02x\n",
+		"features: 0x%02x, controller: 0x%02x\n",
 		elo_types[(packet[1] -'0') & 0x03],
 		packet[5], packet[4], packet[3], packet[7]);
 

