From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 01/13] Input: clps711x-keypad - Make of_device_id array const
Date: Wed, 07 May 2014 18:11:52 +0900
Message-ID: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:24283 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbaEGJLy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:11:54 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700HZG5JTEL70@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:11:53 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Alexander Shiyan' <shc_work@mail.ru>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/keyboard/clps711x-keypad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/keyboard/clps711x-keypad.c
index 3955aec..552b65c 100644
--- a/drivers/input/keyboard/clps711x-keypad.c
+++ b/drivers/input/keyboard/clps711x-keypad.c
@@ -185,7 +185,7 @@ static int clps711x_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id clps711x_keypad_of_match[] = {
+static const struct of_device_id clps711x_keypad_of_match[] = {
 	{ .compatible = "cirrus,clps711x-keypad", },
 	{ }
 };
-- 
1.7.10.4


