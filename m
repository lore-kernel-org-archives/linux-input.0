From: chris@cnpbagwell.com
Subject: [PATCH 2/4] input: wacom - move Bamboo Touch irq to own function
Date: Wed,  8 Sep 2010 23:02:30 -0500
Message-ID: <1284004952-12701-3-git-send-email-chris@cnpbagwell.com>
References: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39639 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab0IIECo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 00:02:44 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so442073gyd.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 21:02:44 -0700 (PDT)
In-Reply-To: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pingc@wacom.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

This is in preparation of pen support in same irq handler.

Chris

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom_wac.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 2f4411a..2f7ed9a 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -855,7 +855,7 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 	return retval;
 }
 
-static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
+static int wacom_bpt_touch(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
 	struct input_dev *input = wacom->input;
@@ -863,9 +863,6 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 	int sp = 0, sx = 0, sy = 0, count = 0;
 	int i;
 
-	if (len != WACOM_PKGLEN_BBTOUCH)
-		return 0;
-
 	for (i = 0; i < 2; i++) {
 		int p = data[9 * i + 2];
 		input_mt_slot(input, i);
@@ -907,6 +904,14 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 	return 0;
 }
 
+static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
+{
+	if (len == WACOM_PKGLEN_BBTOUCH)
+		return wacom_bpt_touch(wacom);
+
+	return 0;
+}
+
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 {
 	bool sync;
-- 
1.7.2.2

