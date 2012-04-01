From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH V3 2/4] Input: pxa27x_keypad bug fix for direct_key_mask
Date: Sun,  1 Apr 2012 10:08:02 +0800
Message-ID: <1333246084-14110-2-git-send-email-chao.xie@marvell.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:52165 "HELO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753984Ab2DACIp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 22:08:45 -0400
In-Reply-To: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, haojian.zhuang@marvell.com

When direcct_key_num is 0, the mask should be 0.
When direcct_key_num is 1, the mask should be 0b1.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index b07771e..5d71720 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -383,7 +383,7 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 	if (pdata->direct_key_num > direct_key_num)
 		direct_key_num = pdata->direct_key_num;
 
-	keypad->direct_key_mask = ((2 << direct_key_num) - 1) & ~mask;
+	keypad->direct_key_mask = ((1 << direct_key_num) - 1) & ~mask;
 
 	/* enable direct key */
 	if (direct_key_num)
-- 
1.7.0.4

