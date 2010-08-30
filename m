From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 6/6] HID: magicmouse: Adjust major / minor axes to scale
Date: Mon, 30 Aug 2010 13:20:58 -0400
Message-ID: <1283188858-4839-6-git-send-email-chase.douglas@canonical.com>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57978 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536Ab0H3RVN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 13:21:13 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Oq82g-0007Ek-Uk
	for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 18:21:11 +0100
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1Oq82g-0006Dz-MR
	for linux-input@vger.kernel.org; Mon, 30 Aug 2010 18:21:10 +0100
In-Reply-To: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Henrik Rydberg <rydberg@euromail.se>

By visual inspection, the reported touch_major and touch_minor axes
are roughly a factor of four too small. The factor is approximate,
since the protocol is not known and the HID report encodes touch size
with fewer bits than positions. This patch scales the reported values
by a factor of four.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-magicmouse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 687dde4..b051f7d 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -253,8 +253,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	/* Generate the input events for this touch. */
 	if (report_touches && down) {
 		input_report_abs(input, ABS_MT_TRACKING_ID, id);
-		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major);
-		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor);
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major << 2);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor << 2);
 		input_report_abs(input, ABS_MT_ORIENTATION, orientation);
 		input_report_abs(input, ABS_MT_POSITION_X, x);
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
-- 
1.7.1

