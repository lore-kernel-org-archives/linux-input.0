From: chris@cnpbagwell.com
Subject: [PATCH v2] Input: wacom - fix touch on newer Bamboo's
Date: Tue,  6 Sep 2011 18:56:46 -0500
Message-ID: <1315353406-8564-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64009 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414Ab1IFX44 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Sep 2011 19:56:56 -0400
Received: by yie30 with SMTP id 30so4467154yie.19
        for <linux-input@vger.kernel.org>; Tue, 06 Sep 2011 16:56:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pinglinux@gmail.com, rydberg@euromail.se
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
Reviewed-by: Ping Cheng <pinglinux@gmail.com>
---

New in v2: Converted stylus_in_proximity from if() back to an && operation to
match original flow; as suggested by Ping.

 drivers/input/tablet/wacom_wac.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 2d88316..6f3bd61 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -800,20 +800,22 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
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
+		touch = touch && wacom->shared->stylus_in_proximity;
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

