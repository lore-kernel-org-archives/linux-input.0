From: chris@cnpbagwell.com
Subject: [PATCH 4/4] input: wacom - disable Bamboo touchpad when pen is being used.
Date: Wed,  8 Sep 2010 23:02:32 -0500
Message-ID: <1284004952-12701-5-git-send-email-chris@cnpbagwell.com>
References: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39639 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0IIECq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 00:02:46 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so442073gyd.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 21:02:46 -0700 (PDT)
In-Reply-To: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pingc@wacom.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom_wac.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9cc0cf0..bae67e8 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -866,7 +866,12 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 	for (i = 0; i < 2; i++) {
 		int p = data[9 * i + 2];
 		input_mt_slot(input, i);
-		if (p) {
+		/* Touch events need to be disabled while stylus is
+		 * in proximity because user's hand is resting on touchpad
+		 * and sending unwanted events.  User expects tablet buttons
+		 * to continue working though.
+		 */
+		if (p && !wacom->shared->stylus_in_proximity) {
 			int x = get_unaligned_be16(&data[9 * i + 3]) & 0x7ff;
 			int y = get_unaligned_be16(&data[9 * i + 5]) & 0x7ff;
 			if (features->quirks & WACOM_QUIRK_BBTOUCH_LOWRES) {
-- 
1.7.2.2

