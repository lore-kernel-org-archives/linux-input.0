From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 1/2] HID: sony: Adjust value range for motion sensors
Date: Wed,  5 Oct 2016 19:18:54 -0700
Message-ID: <1475720335-17447-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:36690 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933867AbcJFCUD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2016 22:20:03 -0400
Received: by mail-yb0-f179.google.com with SMTP id 191so961298ybv.3
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2016 19:20:03 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The motion sensor values are 16-bit, so make the value range match.
It is hard to reach the upper values, but they can be reached. At
least the current accelerometer value of 8192 is very easy to pass.

It is still not nice that the motion sensors live in no man's land
in between ABS_MISC and ABS_MT_SLOT, but that's something for another
time, which the proposed ABS_ACCEL_*/ABS_GYRO_* were meant for.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2387aaf..c9916cc 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -405,14 +405,14 @@ static u8 dualshock4_usb_rdesc[] = {
 	0x19, 0x40,         /*      Usage Minimum (40h),            */
 	0x29, 0x42,         /*      Usage Maximum (42h),            */
 	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
-	0x26, 0x00, 0x7F,   /*      Logical Maximum (32767),        */
+	0x26, 0xFF, 0x7F,   /*      Logical Maximum (32767),        */
 	0x75, 0x10,         /*      Report Size (16),               */
 	0x95, 0x03,         /*      Report Count (3),               */
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x19, 0x43,         /*      Usage Minimum (43h),            */
 	0x29, 0x45,         /*      Usage Maximum (45h),            */
-	0x16, 0x00, 0xE0,   /*      Logical Minimum (-8192),        */
-	0x26, 0xFF, 0x1F,   /*      Logical Maximum (8191),         */
+	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
+	0x26, 0xFF, 0x7F,   /*      Logical Maximum (32767),        */
 	0x95, 0x03,         /*      Report Count (3),               */
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
@@ -714,14 +714,14 @@ static u8 dualshock4_bt_rdesc[] = {
 	0x19, 0x40,         /*      Usage Minimum (40h),            */
 	0x29, 0x42,         /*      Usage Maximum (42h),            */
 	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
-	0x26, 0x00, 0x7F,   /*      Logical Maximum (32767),        */
+	0x26, 0xFF, 0x7F,   /*      Logical Maximum (32767),        */
 	0x75, 0x10,         /*      Report Size (16),               */
 	0x95, 0x03,         /*      Report Count (3),               */
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x19, 0x43,         /*      Usage Minimum (43h),            */
 	0x29, 0x45,         /*      Usage Maximum (45h),            */
-	0x16, 0x00, 0xE0,   /*      Logical Minimum (-8192),        */
-	0x26, 0xFF, 0x1F,   /*      Logical Maximum (8191),         */
+	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
+	0x26, 0xFF, 0x7F,   /*      Logical Maximum (32767),        */
 	0x95, 0x03,         /*      Report Count (3),               */
 	0x81, 0x02,         /*      Input (Variable),               */
 	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
-- 
2.7.4

