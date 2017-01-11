From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/5] Input: mpr121 - remove unused field in struct mpr121_touchkey
Date: Thu, 12 Jan 2017 02:42:25 +0900
Message-ID: <1484156549-26585-2-git-send-email-akinobu.mita@gmail.com>
References: <1484156549-26585-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36160 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966087AbdAKRmu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2017 12:42:50 -0500
In-Reply-To: <1484156549-26585-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Remove unused key_val field in struct mpr121_touchkey.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/input/keyboard/mpr121_touchkey.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 0fd612d..d40e0d1 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -59,7 +59,6 @@
 struct mpr121_touchkey {
 	struct i2c_client	*client;
 	struct input_dev	*input_dev;
-	unsigned int		key_val;
 	unsigned int		statusbits;
 	unsigned int		keycount;
 	u16			keycodes[MPR121_MAX_KEY_COUNT];
-- 
2.7.4

