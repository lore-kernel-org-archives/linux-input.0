From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 2/2] hid: sony: Update file header and correct comments
Date: Sun, 14 Sep 2014 11:56:39 -0400
Message-ID: <1410710199-14383-2-git-send-email-frank.praznik@oh.rr.com>
References: <1410710199-14383-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:35854 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752732AbaINP4v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Sep 2014 11:56:51 -0400
In-Reply-To: <1410710199-14383-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Update the file header and correct an outdated comment block.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 75da56d..96a8ec5 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1,5 +1,5 @@
 /*
- *  HID driver for Sony / PS2 / PS3 BD devices.
+ *  HID driver for Sony / PS2 / PS3 / PS4 BD devices.
  *
  *  Copyright (c) 1999 Andreas Gal
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
@@ -8,6 +8,7 @@
  *  Copyright (c) 2012 David Dillow <dave@thedillows.org>
  *  Copyright (c) 2006-2013 Jiri Kosina
  *  Copyright (c) 2013 Colin Leitner <colin.leitner@gmail.com>
+ *  Copyright (c) 2014 Frank Praznik <frank.praznik@gmail.com>
  */
 
 /*
@@ -395,11 +396,11 @@ static u8 dualshock4_usb_rdesc[] = {
 
 /*
  * The default behavior of the Dualshock 4 is to send reports using report
- * type 1 when running over Bluetooth. However, as soon as it receives a
- * report of type 17 to set the LEDs or rumble it starts returning it's state
- * in report 17 instead of 1.  Since report 17 is undefined in the default HID
+ * type 1 when running over Bluetooth. However, when feature report 2 is
+ * requested during the controller initialization it starts sending input
+ * reports in report 17.  Since report 17 is undefined in the default HID
  * descriptor the button and axis definitions must be moved to report 17 or
- * the HID layer won't process the received input once a report is sent.
+ * the HID layer won't process the received input.
  */
 static u8 dualshock4_bt_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
-- 
2.1.0

