From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 24/35] Input: mouse: use dev_get_platdata()
Date: Tue, 30 Jul 2013 17:15:10 +0900
Message-ID: <005301ce8cfc$e8c0a6b0$ba41f410$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45044 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab3G3IPL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 04:15:11 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQQ001SFPLAQDU0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Tue, 30 Jul 2013 17:15:10 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/mouse/gpio_mouse.c     |    2 +-
 drivers/input/mouse/pxa930_trkball.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 6b44413..6810a46 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -48,7 +48,7 @@ static void gpio_mouse_scan(struct input_polled_dev *dev)
 
 static int gpio_mouse_probe(struct platform_device *pdev)
 {
-	struct gpio_mouse_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_mouse_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct input_polled_dev *input_poll;
 	struct input_dev *input;
 	int pin, i;
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index 0ecb9e7..d20d2ae 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -166,7 +166,7 @@ static int pxa930_trkball_probe(struct platform_device *pdev)
 	if (!trkball)
 		return -ENOMEM;
 
-	trkball->pdata = pdev->dev.platform_data;
+	trkball->pdata = dev_get_platdata(&pdev->dev);
 	if (!trkball->pdata) {
 		dev_err(&pdev->dev, "no platform data defined\n");
 		error = -EINVAL;
-- 
1.7.10.4


