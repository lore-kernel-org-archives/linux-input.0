From: Michael Hennerich <dmitry.torokhov@gmail.com>
Subject: [PATCH 35/37] Input: bf54x-keys - add infrastructure for keypad wakeups
Date: Fri, 18 Apr 2008 00:25:00 -0400
Message-ID: <3c3b51ee4321c0b25e5fbc31355a82be73641fdf.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:15846 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760144AbYDUNTS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:18 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1005565ywb.1
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:17 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/bf54x-keys.c |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index d87ac33..54ed8e2 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -312,6 +312,8 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 
 	bfin_write_KPAD_CTL(bfin_read_KPAD_CTL() | KPAD_EN);
 
+	device_init_wakeup(&pdev->dev, 1);
+
 	printk(KERN_ERR DRV_NAME
 		": Blackfin BF54x Keypad registered IRQ %d\n", bf54x_kpad->irq);
 
@@ -354,13 +356,40 @@ static int __devexit bfin_kpad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int bfin_kpad_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct bf54x_kpad *bf54x_kpad = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(bf54x_kpad->irq);
+
+	return 0;
+}
+
+static int bfin_kpad_resume(struct platform_device *pdev)
+{
+	struct bf54x_kpad *bf54x_kpad = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(bf54x_kpad->irq);
+
+	return 0;
+}
+#else
+# define bfin_kpad_suspend NULL
+# define bfin_kpad_resume  NULL
+#endif
+
 struct platform_driver bfin_kpad_device_driver = {
-	.probe		= bfin_kpad_probe,
-	.remove		= __devexit_p(bfin_kpad_remove),
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
-	}
+	},
+	.probe		= bfin_kpad_probe,
+	.remove		= __devexit_p(bfin_kpad_remove),
+	.suspend	= bfin_kpad_suspend,
+	.resume		= bfin_kpad_resume,
 };
 
 static int __init bfin_kpad_init(void)
-- 
1.5.5.rc2.6.gf58d


