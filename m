From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/2] hid: sony: Corrections for the DualShock 4 HID descriptor
Date: Sun, 14 Sep 2014 11:56:38 -0400
Message-ID: <1410710199-14383-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:35854 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752697AbaINP4v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Sep 2014 11:56:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Fix a few minor issues in the HID descriptor:
 - A 6 bit entry had a logical maximum of 255 when the largest it can be is 63.
 - A logical max value was incorrectly being set to -1 instead of 255.
 - Set the min/max of the gyroscopes to -8192/8191 as that is the range of
   values which represent the true controller orientation.  Any values beyond
   those extents are just noise.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ecc6616..75da56d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -176,7 +176,7 @@ static u8 dualshock4_usb_rdesc[] = {
 	0x75, 0x06,         /*      Report Size (6),                */
 	0x95, 0x01,         /*      Report Count (1),               */
 	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x25, 0x7F,         /*      Logical Maximum (127),          */
+	0x25, 0x3F,         /*      Logical Maximum (63),           */
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x05, 0x01,         /*      Usage Page (Desktop),           */
 	0x09, 0x33,         /*      Usage (Rx),                     */
@@ -200,14 +200,14 @@ static u8 dualshock4_usb_rdesc[] = {
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x19, 0x43,         /*      Usage Minimum (43h),            */
 	0x29, 0x45,         /*      Usage Maximum (45h),            */
-	0x16, 0xFF, 0xBF,   /*      Logical Minimum (-16385),       */
-	0x26, 0x00, 0x40,   /*      Logical Maximum (16384),        */
+	0x16, 0x00, 0xE0,   /*      Logical Minimum (-8192),        */
+	0x26, 0xFF, 0x1F,   /*      Logical Maximum (8191),         */
 	0x95, 0x03,         /*      Report Count (3),               */
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
 	0x09, 0x21,         /*      Usage (21h),                    */
 	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x25, 0xFF,         /*      Logical Maximum (255),          */
+	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
 	0x75, 0x08,         /*      Report Size (8),                */
 	0x95, 0x27,         /*      Report Count (39),              */
 	0x81, 0x02,         /*      Input (Variable),               */
@@ -509,8 +509,8 @@ static u8 dualshock4_bt_rdesc[] = {
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x19, 0x43,         /*      Usage Minimum (43h),            */
 	0x29, 0x45,         /*      Usage Maximum (45h),            */
-	0x16, 0xFF, 0xBF,   /*      Logical Minimum (-16385),       */
-	0x26, 0x00, 0x40,   /*      Logical Maximum (16384),        */
+	0x16, 0x00, 0xE0,   /*      Logical Minimum (-8192),        */
+	0x26, 0xFF, 0x1F,   /*      Logical Maximum (8191),         */
 	0x95, 0x03,         /*      Report Count (3),               */
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
-- 
2.1.0

