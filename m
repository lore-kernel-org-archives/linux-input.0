From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH 13/33] Input: Make static
Date: Tue, 09 Dec 2008 19:44:41 +0100
Message-ID: <493EBC99.8050702@gmail.com>
References: <493EA286.7080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:60576 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbYLISon (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Dec 2008 13:44:43 -0500
Received: by ug-out-1314.google.com with SMTP id 39so37547ugf.37
        for <linux-input@vger.kernel.org>; Tue, 09 Dec 2008 10:44:41 -0800 (PST)
In-Reply-To: <493EA286.7080500@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Sparse asked whether these could be static.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/input/mouse/gpio_mouse.c |    2 +-
 drivers/input/tablet/wacom_wac.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 72cf5e3..0db8d16 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -173,7 +173,7 @@ static int __devexit gpio_mouse_remove(struct platform_device *pdev)
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:gpio_mouse");
 
-struct platform_driver gpio_mouse_device_driver = {
+static struct platform_driver gpio_mouse_device_driver = {
 	.remove		= __devexit_p(gpio_mouse_remove),
 	.driver		= {
 		.name	= "gpio_mouse",
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 8dc8d1e..2638811 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -535,7 +535,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom, void *wcombo)
 	return 1;
 }
 
-int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
+static int wacom_tpc_irq(struct wacom_wac *wacom, void *wcombo)
 {
 	char *data = wacom->data;
 	int prox = 0, pressure;

