From: Simon Wood <simon@mungewell.org>
Subject: [PATCH] HID: hid-sony: Navigator Axis for L1 button
Date: Fri, 10 Jul 2015 00:10:21 -0600
Message-ID: <1436508621-1856-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:53288 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbbGJGKe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 02:10:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, frank.praznik@oh.rr.com, Simon Wood <simon@mungewell.org>

Patch HID report descriptor to add joystick axis for the L1 button (previously missing).

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ed2f008..69586b3 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -296,7 +296,14 @@ static __u8 navigation_rdesc[] = {
 	0x09, 0x01,         /*          Usage (Pointer),            */
 	0x81, 0x02,         /*          Input (Variable),           */
 	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
-	0x95, 0x20,         /*          Report Count (26),          */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+	0x95, 0x1E,         /*          Report Count (24),          */
 	0x81, 0x02,         /*          Input (Variable),           */
 	0x75, 0x08,         /*          Report Size (8),            */
 	0x95, 0x30,         /*          Report Count (48),          */
-- 
2.1.4

