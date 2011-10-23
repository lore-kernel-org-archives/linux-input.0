From: chris@cnpbagwell.com
Subject: [PATCH v3 4/6] Input: wacom - relax Bamboo stylus ID check
Date: Sun, 23 Oct 2011 17:28:58 -0500
Message-ID: <1319408940-2345-5-git-send-email-chris@cnpbagwell.com>
References: <1319408940-2345-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58252 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab1JWW3S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Oct 2011 18:29:18 -0400
Received: by mail-gx0-f174.google.com with SMTP id b1so5195119ggn.19
        for <linux-input@vger.kernel.org>; Sun, 23 Oct 2011 15:29:18 -0700 (PDT)
In-Reply-To: <1319408940-2345-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com, rydberg@euromail.se
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Bit 0x02 always means tip versus eraser. Bit 0x01 is something related
to version of stylus and different values are starting to be used.

Relaxing proximity check is required to be used with 3rd generation Bamboo
Pen and Touch tablets.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
Acked-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 7fefd93..d1ced32 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -842,12 +842,7 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
 
-	/*
-	 * Similar to Graphire protocol, data[1] & 0x20 is proximity and
-	 * data[1] & 0x18 is tool ID.  0x30 is safety check to ignore
-	 * 2 unused tool ID's.
-	 */
-	prox = (data[1] & 0x30) == 0x30;
+	prox = (data[1] & 0x20) == 0x20;
 
 	/*
 	 * All reports shared between PEN and RUBBER tool must be
-- 
1.7.6.4

