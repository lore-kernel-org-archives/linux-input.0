From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/3] Input: wacom - allow both MT and pen data to be reported
Date: Tue,  2 Nov 2010 16:37:59 -0700
Message-ID: <1288741079-4993-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56213 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab0KBXht (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Nov 2010 19:37:49 -0400
Received: by gxk23 with SMTP id 23so16710gxk.19
        for <linux-input@vger.kernel.org>; Tue, 02 Nov 2010 16:37:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, chris@cnpbagwell.com, Ping Cheng <pingc@wacom.com>

It was suggested by app and X server developers that both MT and pen data
should be reported to the userland if the data is valid. Bamboo series are
among these devices that both data are valid from the hardware perspective.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index b3252ef..b9534a1 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -868,13 +868,14 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	for (i = 0; i < 2; i++) {
 		int p = data[9 * i + 2];
 		input_mt_slot(input, i);
-		/*
-		 * Touch events need to be disabled while stylus is
-		 * in proximity because user's hand is resting on touchpad
-		 * and sending unwanted events.  User expects tablet buttons
-		 * to continue working though.
+
+		/* We send touch events even a stylus is in proximity. Apps or
+		 * userland clients have the opportunity to arbitrate these events
+		 * when pen is in proximity.
+		 * Wacom X server driver arbitrates the events for all apps that
+		 * are based on X server.
 		 */
-		if (p && !wacom->shared->stylus_in_proximity) {
+		if (p) {
 			int x = get_unaligned_be16(&data[9 * i + 3]) & 0x7ff;
 			int y = get_unaligned_be16(&data[9 * i + 5]) & 0x7ff;
 			if (features->quirks & WACOM_QUIRK_BBTOUCH_LOWRES) {
-- 
1.7.2.3

