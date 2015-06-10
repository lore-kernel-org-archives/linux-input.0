From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 4/4] HID: hid-sony: PS Move fix report descriptor
Date: Tue,  9 Jun 2015 21:27:07 -0600
Message-ID: <1433906827-11146-4-git-send-email-simon@mungewell.org>
References: <1433906827-11146-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:49075 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758AbbFJD11 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 23:27:27 -0400
In-Reply-To: <1433906827-11146-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Frank Praznik <frank.praznik@oh.rr.com>, Simon Wood <simon@mungewell.org>

Fix the report descriptor so that the buttons and trigger are correctly reported.

The format of the input report is described here:
https://github.com/nitsch/moveonpc/wiki/Input-report

The Accelerometers and Gyros (1st frame only) are also reported as axis, but
the Magnetometers are NOT as 'fixing' their byte order would break user-space
drivers such as PSMoveAPI.

It is hoped to resolve this at a future time.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 69 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 51cb1ac..2ce0295 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -153,52 +153,71 @@ static __u8 motion_rdesc[] = {
 	0xA1, 0x01,         /*  Collection (Application),           */
 	0xA1, 0x02,         /*      Collection (Logical),           */
 	0x85, 0x01,         /*          Report ID (1),              */
-	0x75, 0x08,         /*          Report Size (8),            */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0x15, 0x00,         /*          Logical Minimum (0),        */
-	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
-	0x81, 0x03,         /*          Input (Constant, Variable), */
 	0x75, 0x01,         /*          Report Size (1),            */
-	0x95, 0x13,         /*          Report Count (19),          */
+	0x95, 0x15,         /*          Report Count (21),          */
 	0x15, 0x00,         /*          Logical Minimum (0),        */
 	0x25, 0x01,         /*          Logical Maximum (1),        */
 	0x35, 0x00,         /*          Physical Minimum (0),       */
 	0x45, 0x01,         /*          Physical Maximum (1),       */
 	0x05, 0x09,         /*          Usage Page (Button),        */
 	0x19, 0x01,         /*          Usage Minimum (01h),        */
-	0x29, 0x13,         /*          Usage Maximum (13h),        */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x75, 0x01,         /*          Report Size (1),            */
-	0x95, 0x0D,         /*          Report Count (13),          */
+	0x29, 0x15,         /*          Usage Maximum (15h),        */
+	0x81, 0x02,         /*          Input (Variable),           * Buttons */
+	0x95, 0x0B,         /*          Report Count (11),          */
 	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
-	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x81, 0x03,         /*          Input (Constant, Variable), * Padding */
 	0x15, 0x00,         /*          Logical Minimum (0),        */
 	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
 	0x05, 0x01,         /*          Usage Page (Desktop),       */
-	0x09, 0x01,         /*          Usage (Pointer),            */
 	0xA1, 0x00,         /*          Collection (Physical),      */
 	0x75, 0x08,         /*              Report Size (8),        */
-	0x95, 0x04,         /*              Report Count (4),       */
+	0x95, 0x01,         /*              Report Count (1),       */
 	0x35, 0x00,         /*              Physical Minimum (0),   */
 	0x46, 0xFF, 0x00,   /*              Physical Maximum (255), */
 	0x09, 0x30,         /*              Usage (X),              */
-	0x09, 0x31,         /*              Usage (Y),              */
-	0x09, 0x32,         /*              Usage (Z),              */
-	0x09, 0x35,         /*              Usage (Rz),             */
-	0x81, 0x02,         /*              Input (Variable),       */
+	0x81, 0x02,         /*              Input (Variable),       * Trigger */
 	0xC0,               /*          End Collection,             */
-	0x05, 0x01,         /*          Usage Page (Desktop),       */
-	0x95, 0x13,         /*          Report Count (19),          */
-	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x07,         /*          Report Count (7),           * skip 7 bytes */
 	0x81, 0x02,         /*          Input (Variable),           */
-	0x95, 0x0C,         /*          Report Count (12),          */
-	0x81, 0x01,         /*          Input (Constant),           */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
 	0x75, 0x10,         /*          Report Size (16),           */
-	0x95, 0x04,         /*          Report Count (4),           */
-	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
-	0x46, 0xFF, 0x03,   /*          Physical Maximum (1023),    */
+	0x46, 0xFF, 0xFF,   /*          Physical Maximum (65535),   */
+	0x27, 0xFF, 0xFF, 0x00, 0x00, /*      Logical Maximum (65535),    */
+	0x95, 0x03,         /*          Report Count (3),           * 3x Accels */
+	0x09, 0x33,         /*              Usage (rX),             */
+	0x09, 0x34,         /*              Usage (rY),             */
+	0x09, 0x35,         /*              Usage (rZ),             */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+	0x95, 0x03,         /*          Report Count (3),           * Skip Accels 2nd frame */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
 	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x95, 0x03,         /*          Report Count (3),           * 3x Gyros */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+	0x95, 0x03,         /*          Report Count (3),           * Skip Gyros 2nd frame */
 	0x81, 0x02,         /*          Input (Variable),           */
+	0x75, 0x0C,         /*          Report Size (12),           */
+	0x46, 0xFF, 0x0F,   /*          Physical Maximum (4095),    */
+	0x26, 0xFF, 0x0F,   /*          Logical Maximum (4095),     */
+	0x95, 0x04,         /*          Report Count (4),           * Skip Temp and Magnetometers */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x46, 0xFF, 0x00,   /*          Physical Maximum (255),     */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
+	0x95, 0x06,         /*          Report Count (6),           * Skip Timestamp and Extension Bytes */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x91, 0x02,         /*          Output (Variable),          */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xB1, 0x02,         /*          Feature (Variable),         */
 	0xC0,               /*      End Collection,                 */
 	0xA1, 0x02,         /*      Collection (Logical),           */
 	0x85, 0x02,         /*          Report ID (2),              */
-- 
2.1.4

