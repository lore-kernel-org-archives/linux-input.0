From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 02/17] Input: tsc2005 - convert to using dev_pm_ops
Date: Wed, 16 Mar 2011 00:18:09 -0700
Message-ID: <20110316071809.25664.81719.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63651 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1CPHSO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:18:14 -0400
Received: by ywj3 with SMTP id 3so546365ywj.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:18:14 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Newer code should not be using legacy suspend/resume methods but
rather supply dev_pm_ops structure as it allows better control
over power management.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 5dad30a..109efbf 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -27,6 +27,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/pm.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc2005.h>
 
@@ -661,8 +662,8 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int tsc2005_suspend(struct spi_device *spi, pm_message_t mesg)
+#ifdef CONFIG_PM_SLEEP
+static int tsc2005_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct tsc2005 *ts = spi_get_drvdata(spi);
@@ -674,7 +675,7 @@ static int tsc2005_suspend(struct spi_device *spi, pm_message_t mesg)
 	return 0;
 }
 
-static int tsc2005_resume(struct spi_device *spi)
+static int tsc2005_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct tsc2005 *ts = spi_get_drvdata(spi);
@@ -687,17 +688,16 @@ static int tsc2005_resume(struct spi_device *spi)
 }
 #endif
 
+static SIMPLE_DEV_PM_OPS(tsc2005_pm_ops, tsc2005_suspend, tsc2005_resume);
+
 static struct spi_driver tsc2005_driver = {
-	.driver = {
-		.name = "tsc2005",
-		.owner = THIS_MODULE,
+	.driver	= {
+		.name	= "tsc2005",
+		.owner	= THIS_MODULE,
+		.pm	= &tsc2005_pm_ops,
 	},
-#ifdef CONFIG_PM
-	.suspend = tsc2005_suspend,
-	.resume = tsc2005_resume,
-#endif
-	.probe = tsc2005_probe,
-	.remove = __devexit_p(tsc2005_remove),
+	.probe	= tsc2005_probe,
+	.remove	= __devexit_p(tsc2005_remove),
 };
 
 static int __init tsc2005_init(void)

