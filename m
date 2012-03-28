From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH 4/4] Input: pxa27x_keypad add choice to set direct_key_mask
Date: Wed, 28 Mar 2012 13:08:44 +0800
Message-ID: <1332911324-9840-4-git-send-email-chao.xie@marvell.com>
References: <1332911324-9840-1-git-send-email-chao.xie@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43355 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750720Ab2C1Ezw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 00:55:52 -0400
In-Reply-To: <1332911324-9840-1-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, eric.y.miao@gmail.com, haojian.zhuang@marvell.com, linux-arm-kernel@lists.infradead.org

Direct keys usage may not start from KP_DKIN0, add a msk option
to configure the specifics for platforms that can skip some keys.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/plat-pxa/include/plat/pxa27x_keypad.h |    2 ++
 drivers/input/keyboard/pxa27x_keypad.c         |    7 ++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
index 7ffb16b..5ce8d5e 100644
--- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
+++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
@@ -46,6 +46,8 @@ struct pxa27x_keypad_platform_data {
 	unsigned int	direct_key_map[MAX_DIRECT_KEY_NUM];
 	/* the key output may be low active */
 	int		direct_key_low_active;
+	/* give board a chance to choose the start direct key */
+	unsigned int	direct_key_mask;
 
 	/* rotary encoders 0 */
 	int		enable_rotary0;
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index b41ebda..661892b 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -391,7 +391,12 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 	if (pdata->direct_key_num > direct_key_num)
 		direct_key_num = pdata->direct_key_num;
 
-	keypad->direct_key_mask = ((1 << direct_key_num) - 1) & ~mask;
+	/* Direct keys usage may not start from KP_DKIN0, check the platfrom
+	 * msk data to config the specific */
+	if (pdata->direct_key_mask)
+		keypad->direct_key_mask = pdata->direct_key_mask;
+	else
+		keypad->direct_key_mask = ((1 << direct_key_num) - 1) & ~mask;
 
 	/* enable direct key */
 	if (direct_key_num)
-- 
1.7.0.4

