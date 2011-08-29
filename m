From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] input: fix misc/twl6040-vibra.c warning
Date: Mon, 29 Aug 2011 12:50:17 -0700
Message-ID: <20110829125017.9337299c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:43149 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754722Ab1H2TuX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 15:50:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix warning from Geert's build summary emails by changing "if" to
"ifdef".  Also handle the case of CONFIG_PM_SLEEP not enabled.

drivers/input/misc/twl6040-vibra.c:231:5: warning: "CONFIG_PM_SLEEP" is not defined

Builds cleanly with CONFIG_PM_SLEEP enabled or disabled.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/input/misc/twl6040-vibra.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- linux-next-20110829.orig/drivers/input/misc/twl6040-vibra.c
+++ linux-next-20110829/drivers/input/misc/twl6040-vibra.c
@@ -228,7 +228,7 @@ static void twl6040_vibra_close(struct i
 	mutex_unlock(&info->mutex);
 }
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 static int twl6040_vibra_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -244,10 +244,13 @@ static int twl6040_vibra_suspend(struct 
 	return 0;
 }
 
-#endif
-
 static SIMPLE_DEV_PM_OPS(twl6040_vibra_pm_ops, twl6040_vibra_suspend, NULL);
 
+#define TWL6040_VIBRA_PM_OPS	(&twl6040_vibra_pm_ops)
+#else
+#define TWL6040_VIBRA_PM_OPS	NULL
+#endif
+
 static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
 {
 	struct twl4030_vibra_data *pdata = pdev->dev.platform_data;
@@ -400,7 +403,7 @@ static struct platform_driver twl6040_vi
 	.driver		= {
 		.name	= "twl6040-vibra",
 		.owner	= THIS_MODULE,
-		.pm	= &twl6040_vibra_pm_ops,
+		.pm	= TWL6040_VIBRA_PM_OPS,
 	},
 };
 
