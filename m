From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 05/13] Input: gpio-beeper - Make of_device_id array const
Date: Wed, 07 May 2014 18:18:37 +0900
Message-ID: <023201cf69d5$542e1350$fc8a39f0$%han@samsung.com>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26390 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbaEGJSj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2014 05:18:39 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5700ISB5V28I70@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 07 May 2014 18:18:38 +0900 (KST)
In-reply-to: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Alexander Shiyan' <shc_work@mail.ru>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/gpio-beeper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio-beeper.c
index 5be291d..66c152c 100644
--- a/drivers/input/misc/gpio-beeper.c
+++ b/drivers/input/misc/gpio-beeper.c
@@ -104,7 +104,7 @@ static int gpio_beeper_probe(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id gpio_beeper_of_match[] = {
+static const struct of_device_id gpio_beeper_of_match[] = {
 	{ .compatible = BEEPER_MODNAME, },
 	{ }
 };
-- 
1.7.10.4


