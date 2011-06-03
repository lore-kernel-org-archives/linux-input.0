From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 3.0-rc1] Input: omap-keypad: add missing input_sync()
Date: Fri, 3 Jun 2011 22:26:40 +0200
Message-ID: <201106032226.44976.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:59920 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab1FCU4G (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Jun 2011 16:56:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Otherwise the updated evdev driver (commit 
cdda911c34006f1089f3c87b1a1f31ab3a4722f2, "Input: evdev - only signal 
polls on full packets") no longer works on top of omap-keypad.

Tested on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 drivers/input/keyboard/omap-keypad.c |    4 ++++
 1 file changed, 4 insertions(+)

--- git/drivers/input/keyboard/omap-keypad.c.orig	2011-05-30 22:16:50.000000000 +0200
+++ git/drivers/input/keyboard/omap-keypad.c	2011-06-03 22:22:18.000000000 +0200
@@ -169,6 +169,7 @@ static void omap_kp_tasklet(unsigned lon
 	unsigned char new_state[8], changed, key_down = 0;
 	int col, row;
 	int spurious = 0;
+	bool need_sync = false;
 
 	/* check for any changes */
 	omap_kp_scan_keypad(omap_kp_data, new_state);
@@ -206,9 +207,12 @@ static void omap_kp_tasklet(unsigned lon
 			kp_cur_group = key & GROUP_MASK;
 			input_report_key(omap_kp_data->input, key & ~GROUP_MASK,
 					 new_state[col] & (1 << row));
+			need_sync = true;
 #endif
 		}
 	}
+	if (need_sync)
+		input_sync(omap_kp_data->input);
 	memcpy(keypad_state, new_state, sizeof(keypad_state));
 
 	if (key_down) {
