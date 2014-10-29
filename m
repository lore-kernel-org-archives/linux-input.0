From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] Input: mouse - Use __maybe_unused instead of ifdef around
 suspend/resume
Date: Wed, 29 Oct 2014 14:19:23 +0900
Message-ID: <000601cff337$e67d5cc0$b3781640$%han@samsung.com>
References: <000501cff337$c5f23750$51d6a5f0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8327 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaJ2FTD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2014 01:19:03 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NE60094DXFPPB80@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Wed, 29 Oct 2014 14:19:01 +0900 (KST)
In-reply-to: <000501cff337$c5f23750$51d6a5f0$%han@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use __maybe_unused instead of ifdef guards around suspend/resume
functions, in order to increase build coverage and fix build warnings.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/mouse/cyapa.c         |    6 ++----
 drivers/input/mouse/navpoint.c      |    6 ++----
 drivers/input/mouse/synaptics_i2c.c |    6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index b409c3d..1d978c7 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -905,8 +905,7 @@ static int cyapa_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cyapa_suspend(struct device *dev)
+static int __maybe_unused cyapa_suspend(struct device *dev)
 {
 	int ret;
 	u8 power_mode;
@@ -929,7 +928,7 @@ static int cyapa_suspend(struct device *dev)
 	return 0;
 }
 
-static int cyapa_resume(struct device *dev)
+static int __maybe_unused cyapa_resume(struct device *dev)
 {
 	int ret;
 	struct cyapa *cyapa = dev_get_drvdata(dev);
@@ -944,7 +943,6 @@ static int cyapa_resume(struct device *dev)
 	enable_irq(cyapa->irq);
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(cyapa_pm_ops, cyapa_suspend, cyapa_resume);
 
diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index 1ccc88a..6901727 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -318,8 +318,7 @@ static int navpoint_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int navpoint_suspend(struct device *dev)
+static int __maybe_unused navpoint_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct navpoint *navpoint = platform_get_drvdata(pdev);
@@ -333,7 +332,7 @@ static int navpoint_suspend(struct device *dev)
 	return 0;
 }
 
-static int navpoint_resume(struct device *dev)
+static int __maybe_unused navpoint_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct navpoint *navpoint = platform_get_drvdata(pdev);
@@ -346,7 +345,6 @@ static int navpoint_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(navpoint_pm_ops, navpoint_suspend, navpoint_resume);
 
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index ad82260..878f184 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -614,8 +614,7 @@ static int synaptics_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int synaptics_i2c_suspend(struct device *dev)
+static int __maybe_unused synaptics_i2c_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
@@ -628,7 +627,7 @@ static int synaptics_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int synaptics_i2c_resume(struct device *dev)
+static int __maybe_unused synaptics_i2c_resume(struct device *dev)
 {
 	int ret;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -643,7 +642,6 @@ static int synaptics_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(synaptics_i2c_pm, synaptics_i2c_suspend,
 			 synaptics_i2c_resume);
-- 
1.7.9.5


