From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: A few changes to pxa27x_keypad
Date: Thu, 23 Jul 2009 00:28:02 -0700
Message-ID: <20090723072802.GB3997@dtor-d630.eng.vmware.com>
References: <20090721080845.GD10168@dtor-d630.eng.vmware.com> <4A659C28.3040305@compulab.co.il> <20090723063044.GD2782@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:51410 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbZGWH2F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2009 03:28:05 -0400
Received: by rv-out-0506.google.com with SMTP id f6so214352rvb.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2009 00:28:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090723063044.GD2782@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-input@vger.kernel.org

On Wed, Jul 22, 2009 at 11:30:44PM -0700, Dmitry Torokhov wrote:
> On Tue, Jul 21, 2009 at 01:44:56PM +0300, Mike Rapoport wrote:
> > Hi Dmitry,
> > 
> > Dmitry Torokhov wrote:
> > > Hi Eric,
> > > 
> > > I made a few adjustments to the pxa27x_keypad driver and was wondering
> > > if you would be able to give it a sping and check if I broke it or not.
> > 
> > Apparently not :)
> > Tested-by: Mike Rapoport <mike@compulab.co.il>
> > 
> 
> Cool, thanks for testing. I have another one for you then ;)
> 
> TIA!
> 

Umm.. this one is hopefully better...

Input: pxa27x_keypad - switch to using dev_pm_ops

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/pxa27x_keypad.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)


diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 0943238..c987cc7 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -389,8 +389,9 @@ static void pxa27x_keypad_close(struct input_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int pxa27x_keypad_suspend(struct platform_device *pdev, pm_message_t state)
+static int pxa27x_keypad_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 
 	clk_disable(keypad->clk);
@@ -401,8 +402,9 @@ static int pxa27x_keypad_suspend(struct platform_device *pdev, pm_message_t stat
 	return 0;
 }
 
-static int pxa27x_keypad_resume(struct platform_device *pdev)
+static int pxa27x_keypad_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = keypad->input_dev;
 
@@ -421,9 +423,11 @@ static int pxa27x_keypad_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define pxa27x_keypad_suspend	NULL
-#define pxa27x_keypad_resume	NULL
+
+static const struct dev_pm_ops pxa27x_keypad_pm_ops = {
+	.suspend	= pxa27x_keypad_suspend,
+	.resume		= pxa27x_keypad_resume,
+};
 #endif
 
 static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
@@ -572,11 +576,12 @@ MODULE_ALIAS("platform:pxa27x-keypad");
 static struct platform_driver pxa27x_keypad_driver = {
 	.probe		= pxa27x_keypad_probe,
 	.remove		= __devexit_p(pxa27x_keypad_remove),
-	.suspend	= pxa27x_keypad_suspend,
-	.resume		= pxa27x_keypad_resume,
 	.driver		= {
 		.name	= "pxa27x-keypad",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &pxa27x_keypad_pm_ops,
+#endif
 	},
 };
 
