From: chris@cnpbagwell.com
Subject: [PATCH] Input: wacom - fix touch on newer Bamboo's
Date: Sun,  4 Sep 2011 21:44:21 -0500
Message-ID: <1315190661-7133-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37367 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab1IECo2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Sep 2011 22:44:28 -0400
Received: by gwaa12 with SMTP id a12so2619211gwa.19
        for <linux-input@vger.kernel.org>; Sun, 04 Sep 2011 19:44:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Bamboo's with Product ID's > 0xD4 return values unrelated to pressure
in touch 1 pressure field.  They also report touch 2's X/Y values
shifted down 1 byte (where pressure was).  This results in jumpy
1 finger touch and totally invalid 2nd finger data.

For touch detection, switch to a Touch Present single bit that
all versions of Bamboo support.

For touch 2 offset, calculate offset based on a bit that is set
different between the two packet layouts.

Since touch pressure reports were removed from driver, there was
no need to be reading pressure any more.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom_wac.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 2d88316..651f109 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -800,20 +800,23 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	int i;
 
 	for (i = 0; i < 2; i++) {
-		int p = data[9 * i + 2];
-		bool touch = p && !wacom->shared->stylus_in_proximity;
+		int offset = (data[1] & 0x80) ? (8 * i) : (9 * i);
+		bool touch = data[offset + 3] & 0x80;
 
-		input_mt_slot(input, i);
-		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
 		/*
 		 * Touch events need to be disabled while stylus is
 		 * in proximity because user's hand is resting on touchpad
 		 * and sending unwanted events.  User expects tablet buttons
 		 * to continue working though.
 		 */
+		if (wacom->shared->stylus_in_proximity)
+			touch = 0;
+
+		input_mt_slot(input, i);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
 		if (touch) {
-			int x = get_unaligned_be16(&data[9 * i + 3]) & 0x7ff;
-			int y = get_unaligned_be16(&data[9 * i + 5]) & 0x7ff;
+			int x = get_unaligned_be16(&data[offset + 3]) & 0x7ff;
+			int y = get_unaligned_be16(&data[offset + 5]) & 0x7ff;
 			if (features->quirks & WACOM_QUIRK_BBTOUCH_LOWRES) {
 				x <<= 5;
 				y <<= 5;
-- 
1.7.6

