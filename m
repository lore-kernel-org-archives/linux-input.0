From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: at32psif - convert to dev_pm_ops
Date: Tue, 10 Jan 2012 23:33:12 -0800
Message-ID: <20120111073312.18812.71134.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:43291 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754634Ab2AKHkU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 02:40:20 -0500
Received: by obbup16 with SMTP id up16so476580obb.19
        for <linux-input@vger.kernel.org>; Tue, 10 Jan 2012 23:40:20 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Cc: linux-input@vger.kernel.org

Convert driver to use dev_pm_ops instead of legacy PM infrastructure.
Also make 'open' a bool since it is really a boolean.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/at32psif.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
index 95280f9..36e799c 100644
--- a/drivers/input/serio/at32psif.c
+++ b/drivers/input/serio/at32psif.c
@@ -98,9 +98,9 @@ struct psif {
 	struct serio		*io;
 	void __iomem		*regs;
 	unsigned int		irq;
-	unsigned int		open;
 	/* Prevent concurrent writes to PSIF THR. */
 	spinlock_t		lock;
+	bool			open;
 };
 
 static irqreturn_t psif_interrupt(int irq, void *_ptr)
@@ -164,7 +164,7 @@ static int psif_open(struct serio *io)
 	psif_writel(psif, CR, PSIF_BIT(CR_TXEN) | PSIF_BIT(CR_RXEN));
 	psif_writel(psif, IER, PSIF_BIT(RXRDY));
 
-	psif->open = 1;
+	psif->open = true;
 out:
 	return retval;
 }
@@ -173,7 +173,7 @@ static void psif_close(struct serio *io)
 {
 	struct psif *psif = io->port_data;
 
-	psif->open = 0;
+	psif->open = false;
 
 	psif_writel(psif, IDR, ~0UL);
 	psif_writel(psif, CR, PSIF_BIT(CR_TXDIS) | PSIF_BIT(CR_RXDIS));
@@ -319,9 +319,10 @@ static int __exit psif_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int psif_suspend(struct platform_device *pdev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int psif_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct psif *psif = platform_get_drvdata(pdev);
 
 	if (psif->open) {
@@ -332,8 +333,9 @@ static int psif_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int psif_resume(struct platform_device *pdev)
+static int psif_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct psif *psif = platform_get_drvdata(pdev);
 
 	if (psif->open) {
@@ -344,19 +346,17 @@ static int psif_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define psif_suspend	NULL
-#define psif_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(psif_pm_ops, psif_suspend, psif_resume);
+
 static struct platform_driver psif_driver = {
 	.remove		= __exit_p(psif_remove),
 	.driver		= {
 		.name	= "atmel_psif",
 		.owner	= THIS_MODULE,
+		.pm	= &psif_pm_ops,
 	},
-	.suspend	= psif_suspend,
-	.resume		= psif_resume,
 };
 
 static int __init psif_init(void)

