From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 02/13] Input: gpio_keys - Make of_device_id array const
Date: Wed, 07 May 2014 18:15:13 +0900
Message-ID: <022f01cf69d4$dabd0e40$90372ac0$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18892 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbaEGJPP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:15:15 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700K9C5PEAX60@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:15:14 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Philippe Langlais' <philippe.langlais@linaro.org>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/keyboard/gpio_keys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 52dc872..af85218 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -646,7 +646,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	return pdata;
 }
 
-static struct of_device_id gpio_keys_of_match[] = {
+static const struct of_device_id gpio_keys_of_match[] = {
 	{ .compatible = "gpio-keys", },
 	{ },
 };
-- 
1.7.10.4


