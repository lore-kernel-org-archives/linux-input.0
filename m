From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] input: touchscreen: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:25:52 +0900
Message-ID: <002701ce579f$e7237400$b56a5c00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36276 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757918Ab3EWKZy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 May 2013 06:25:54 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MN800DE9YB5VO80@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 23 May 2013 19:25:53 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Josh Wu' <josh.wu@atmel.com>

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/touchscreen/88pm860x-ts.c  |    2 +-
 drivers/input/touchscreen/atmel_tsadcc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index e8d4572..f7de14a 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -237,7 +237,7 @@ static int pm860x_touch_probe(struct platform_device *pdev)
 	touch = kzalloc(sizeof(struct pm860x_touch), GFP_KERNEL);
 	if (touch == NULL)
 		return -ENOMEM;
-	dev_set_drvdata(&pdev->dev, touch);
+	platform_set_drvdata(pdev, touch);
 
 	touch->idev = input_allocate_device();
 	if (touch->idev == NULL) {
diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
index 95f6785..75a0693 100644
--- a/drivers/input/touchscreen/atmel_tsadcc.c
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -325,7 +325,7 @@ err_free_mem:
 
 static int atmel_tsadcc_remove(struct platform_device *pdev)
 {
-	struct atmel_tsadcc *ts_dev = dev_get_drvdata(&pdev->dev);
+	struct atmel_tsadcc *ts_dev = platform_get_drvdata(pdev);
 	struct resource *res;
 
 	free_irq(ts_dev->irq, ts_dev);
-- 
1.7.10.4


