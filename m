From: chris@cnpbagwell.com
Subject: [PATCH v2 4/4] input: wacom - disable Bamboo touchpad when pen is being used.
Date: Sat, 11 Sep 2010 13:30:38 -0500
Message-ID: <1284229838-2852-5-git-send-email-chris@cnpbagwell.com>
References: <1284229838-2852-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59895 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab0IKSa5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Sep 2010 14:30:57 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so1588791gxk.19
        for <linux-input@vger.kernel.org>; Sat, 11 Sep 2010 11:30:57 -0700 (PDT)
In-Reply-To: <1284229838-2852-1-git-send-email-chris@cnpbagwell.com>
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
index 3943ddf..3f89e1e 100644
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

