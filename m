From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/2] Input: DaVinci Keypad Driver
Date: Mon, 12 Oct 2009 22:46:44 -0700
Message-ID: <20091013054644.GF2887@core.coreip.homeip.net>
References: <1255109225-6833-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:9914 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389AbZJMFr4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 01:47:56 -0400
Received: by qw-out-2122.google.com with SMTP id 9so778789qwb.37
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2009 22:46:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1255109225-6833-1-git-send-email-miguel.aguilar@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

Hi Miguel,

On Fri, Oct 09, 2009 at 11:27:05AM -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
> Adds the driver for enabling keypad support for DaVinci platforms.
> 
> DM365 is the only platform that uses this driver at the moment.
> 

Looks pretty good, I have one question:

> +static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
> +{
> +	u32 base = (u32)davinci_ks->base;
> +
> +	__raw_writel(val,(u32 *)(base + addr));
> +}

Do you really need these casts? I'd think that bare __raw_writel would
work just fine.

> +
> +static u32 davinci_ks_read(struct davinci_ks *davinci_ks, u32 addr)
> +{
> +	u32 base = (u32)davinci_ks->base;
> +
> +	return __raw_readl((u32 *)(base + addr));
> +}

Could you also please try the patch below and let me know if it breaks
things. Also iof you coulr run sparse over the driver that would be
nice.

Thanks!

-- 
Dmitry


Input: davinci_keyscan - miscellaneous fixes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/davinci_keyscan.c |  107 +++++++++++++++++-------------
 1 files changed, 60 insertions(+), 47 deletions(-)


diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index 7b7424b..b80f078 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -79,7 +79,7 @@ static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
 {
 	u32 base = (u32)davinci_ks->base;
 
-	__raw_writel(val,(u32 *)(base + addr));
+	__raw_writel(val, (u32 *)(base + addr));
 }
 
 static u32 davinci_ks_read(struct davinci_ks *davinci_ks, u32 addr)
@@ -90,33 +90,46 @@ static u32 davinci_ks_read(struct davinci_ks *davinci_ks, u32 addr)
 }
 
 /* Initializing the kp Module */
-static int davinci_ks_initialize(struct davinci_ks *davinci_ks)
+static int __init davinci_ks_initialize(struct davinci_ks *davinci_ks)
 {
 	struct device *dev = &davinci_ks->input->dev;
-	u8 strobe = davinci_ks->pdata->strobe;
-	u8 interval = davinci_ks->pdata->interval;
-	u8 matrix_type = davinci_ks->pdata->matrix_type;
+	struct davinci_ks_platform_data *pdata = davinci_ks->pdata;
+	u32 matrix_ctrl;
 
 	/* Enable all interrupts */
-	davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL, DAVINCI_KEYSCAN_INTENA);
+	davinci_ks_write(davinci_ks,
+			 DAVINCI_KEYSCAN_INT_ALL, DAVINCI_KEYSCAN_INTENA);
 
 	/* Clear interrupts if any */
-	davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL, DAVINCI_KEYSCAN_INTCLR);
+	davinci_ks_write(davinci_ks,
+			 DAVINCI_KEYSCAN_INT_ALL, DAVINCI_KEYSCAN_INTCLR);
 
 	/* Setup the scan period = strobe + interval */
-	davinci_ks_write(davinci_ks, strobe, DAVINCI_KEYSCAN_STRBWIDTH);
-	davinci_ks_write(davinci_ks, interval, DAVINCI_KEYSCAN_INTERVAL);
+	davinci_ks_write(davinci_ks,
+			 pdata->strobe, DAVINCI_KEYSCAN_STRBWIDTH);
+	davinci_ks_write(davinci_ks,
+			 pdata->interval, DAVINCI_KEYSCAN_INTERVAL);
 	davinci_ks_write(davinci_ks, 0x01, DAVINCI_KEYSCAN_CONTTIME);
 
 	/* Define matrix type */
-	if ((matrix_type != 0) && (matrix_type != 1)) {
+	switch (pdata->matrix_type) {
+	case DAVINCI_KEYSCAN_MATRIX_4X4:
+		matrix_ctrl = 0;
+		break;
+
+	case DAVINCI_KEYSCAN_MATRIX_5X3:
+		matrix_ctrl = (1 << 6);
+		break;
+
+	default:
 		dev_err(dev->parent, "wrong matrix type\n");
 		return -EINVAL;
 	}
 
 	/* Enable key scan module and set matrix type */
-	davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_AUTODET | DAVINCI_KEYSCAN_KEYEN
-			    | (matrix_type << 6), DAVINCI_KEYSCAN_KEYCTRL);
+	davinci_ks_write(davinci_ks,
+		DAVINCI_KEYSCAN_AUTODET | DAVINCI_KEYSCAN_KEYEN | matrix_ctrl,
+		DAVINCI_KEYSCAN_KEYCTRL);
 
 	return 0;
 }
@@ -140,26 +153,25 @@ static irqreturn_t davinci_ks_interrupt(int irq, void *dev_id)
 	new_status = davinci_ks_read(davinci_ks, DAVINCI_KEYSCAN_CURRENTST);
 
 	changed = prev_status ^ new_status;
-
-	if(changed) {
+	if (changed) {
 		/*
-		 * It goes go through all bits in changed to ensure
+		 * It goes through all bits in 'changed' to ensure
 		 * that no key changes are being missed
 		 */
-		for(i = 0 ; i < keymapsize; i++) {
-			if((changed>>i) & 0x1) {
+		for (i = 0 ; i < keymapsize; i++) {
+			if ((changed >> i) & 0x1) {
 				keycode = keymap[i];
 				release = (new_status >> i) & 0x1;
 				dev_dbg(dev->parent, "key %d %s\n", keycode,
-					    release ? "released" : "pressed");
+					release ? "released" : "pressed");
 				input_report_key(davinci_ks->input, keycode,
-						    !release);
+						 !release);
 				input_sync(davinci_ks->input);
 			}
 		}
 		/* Clearing interrupt */
 		davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL,
-				    DAVINCI_KEYSCAN_INTCLR);
+				 DAVINCI_KEYSCAN_INTCLR);
 	}
 
 	/* Enable interrupts */
@@ -173,9 +185,9 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 	struct davinci_ks *davinci_ks;
 	struct input_dev *key_dev;
 	struct resource *res, *mem;
-	struct device * dev = &pdev->dev;
+	struct device *dev = &pdev->dev;
 	struct davinci_ks_platform_data *pdata = pdev->dev.platform_data;
-	int ret, i;
+	int error, i;
 
 	if (!pdata->keymap) {
 		dev_dbg(dev, "no keymap from pdata\n");
@@ -184,54 +196,53 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 
 	davinci_ks = kzalloc(sizeof(struct davinci_ks) +
 		sizeof(unsigned short) * pdata->keymapsize, GFP_KERNEL);
-	if(!davinci_ks) {
+	if (!davinci_ks) {
 		dev_dbg(dev, "could not allocate memory for private data\n");
 		return -ENOMEM;
 	}
 
 	memcpy(davinci_ks->keymap, pdata->keymap,
-		    sizeof(unsigned short) * pdata->keymapsize);
+		sizeof(unsigned short) * pdata->keymapsize);
 
 	key_dev = input_allocate_device();
 	if (!key_dev) {
 		dev_dbg(dev, "could not allocate input device\n");
-		ret = -ENOMEM;
+		error = -ENOMEM;
 		goto fail1;
 	}
 
-	platform_set_drvdata(pdev, davinci_ks);
-
 	davinci_ks->input = key_dev;
 
 	davinci_ks->irq = platform_get_irq(pdev, 0);
 	if (davinci_ks->irq < 0) {
 		dev_err(dev, "no key scan irq\n");
-		ret = davinci_ks->irq;
+		error = davinci_ks->irq;
 		goto fail2;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "no mem resource\n");
-		ret = -EINVAL;
+		error = -EINVAL;
 		goto fail2;
 	}
 
 	davinci_ks->pbase = res->start;
 	davinci_ks->base_size = resource_size(res);
 
-	mem = request_mem_region(davinci_ks->pbase, davinci_ks->base_size, pdev->name);
+	mem = request_mem_region(davinci_ks->pbase, davinci_ks->base_size,
+				 pdev->name);
 	if (!mem) {
 		dev_err(dev, "key scan registers at %08x are not free\n",
 			davinci_ks->pbase);
-		ret = -EBUSY;
+		error = -EBUSY;
 		goto fail2;
 	}
 
 	davinci_ks->base = ioremap(davinci_ks->pbase, davinci_ks->base_size);
 	if (!davinci_ks->base) {
 		dev_err(dev, "can't ioremap MEM resource.\n");
-		ret = -ENOMEM;
+		error = -ENOMEM;
 		goto fail3;
 	}
 
@@ -259,27 +270,30 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 	key_dev->keycodesize = sizeof(davinci_ks->keymap[0]);
 	key_dev->keycodemax = davinci_ks->pdata->keymapsize;
 
-	ret = input_register_device(davinci_ks->input);
-	if (ret < 0) {
+	error = input_register_device(davinci_ks->input);
+	if (error < 0) {
 		dev_err(dev, "unable to register davinci key scan device\n");
 		goto fail4;
 	}
 
-	ret = request_irq(davinci_ks->irq, davinci_ks_interrupt, IRQF_DISABLED,
-                         "davinci_keyscan", davinci_ks);
-	if (ret < 0) {
+	error = request_irq(davinci_ks->irq, davinci_ks_interrupt,
+			    IRQF_DISABLED, pdev->name, davinci_ks);
+	if (error < 0) {
 		dev_err(dev, "unable to register davinci key scan interrupt\n");
 		goto fail5;
 	}
 
-	ret = davinci_ks_initialize(davinci_ks);
-	if (ret < 0) {
+	error = davinci_ks_initialize(davinci_ks);
+	if (error < 0) {
 		dev_err(dev, "unable to initialize davinci key scan device\n");
-		goto fail5;
+		goto fail6;
 	}
 
+	platform_set_drvdata(pdev, davinci_ks);
 	return 0;
 
+fail6:
+	free_irq(davinci_ks->irq);
 fail5:
 	input_unregister_device(davinci_ks->input);
 	key_dev = NULL;
@@ -291,8 +305,7 @@ fail2:
 	input_free_device(key_dev);
 fail1:
 	kfree(davinci_ks);
-
-	return ret;
+	return error;
 }
 
 static int __devexit davinci_ks_remove(struct platform_device *pdev)
@@ -314,11 +327,11 @@ static int __devexit davinci_ks_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver davinci_ks_driver = {
-	.driver = {
-			.name = "davinci_keyscan",
-			.owner = THIS_MODULE,
-		},
-	.remove = __devexit_p(davinci_ks_remove),
+	.driver	= {
+		.name	= "davinci_keyscan",
+		.owner	= THIS_MODULE,
+	},
+	.remove	= __devexit_p(davinci_ks_remove),
 };
 
 static int __init davinci_ks_init(void)
