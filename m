From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 6/12] pxa: use device resources for I/O memory mapping and IRQ
Date: Wed, 23 Jan 2008 15:32:11 +0800
Message-ID: <f17812d70801222332y2b8bec17o2c46214f1b6e9b42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:2022 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYAWHcO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:32:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4887563wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:32:11 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Sorry, this should be 6/12, and the original 6/12, 7/12 should be 7/12, 8/12.

>From 744421369deaab3b861db83b4919577efab75bbc Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 11:58:12 +0800
Subject: [PATCH] pxa: use device resources for I/O memory mapping and IRQ

1. use ioremap() for registers access, this improves the portability
   of the driver (e.g. same IP on different processor with different
   I/O memory range), and make it possible to remove those registers
   definition in pxa-regs.h as PXA is undergoing a clean-up of that
   header file

2. use device specific IRQ instead of hardcoded IRQ_KEYPAD, same
   reason as above

3. clean up the error handling path in _probe()

4. remove DRIVER_NAME and use pdev->name when necessary, we don't
   actually need a constant string literals

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c |  158 +++++++++++++++++++++++++-------
 1 files changed, 124 insertions(+), 34 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c
b/drivers/input/keyboard/pxa27x_keypad.c
index cd25b34..ceaf1e0 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -31,25 +31,71 @@
 #include <asm/mach/map.h>

 #include <asm/arch/hardware.h>
-#include <asm/arch/pxa-regs.h>
-#include <asm/arch/irqs.h>
 #include <asm/arch/pxa27x_keypad.h>

-#define DRIVER_NAME		"pxa27x-keypad"
-
+/*
+ * Keypad Controller registers
+ */
+#define KPC             0x0000 /* Keypad Control register */
+#define KPDK            0x0008 /* Keypad Direct Key register */
+#define KPREC           0x0010 /* Keypad Rotary Encoder register */
+#define KPMK            0x0018 /* Keypad Matrix Key register */
+#define KPAS            0x0020 /* Keypad Automatic Scan register */
+
+/* Keypad Automatic Scan Multiple Key Presser register 0-3 */
+#define KPASMKP0        0x0028
+#define KPASMKP1        0x0030
+#define KPASMKP2        0x0038
+#define KPASMKP3        0x0040
+#define KPKDI           0x0048
+
+/* bit definitions */
 #define KPC_MKRN(n)	((((n) & 0x7) - 1) << 26) /* matrix key row number */
 #define KPC_MKCN(n)	((((n) & 0x7) - 1) << 23) /* matrix key column number */
 #define KPC_DKN(n)	((((n) & 0x7) - 1) << 6)  /* direct key number */

+#define KPC_AS          (0x1 << 30)  /* Automatic Scan bit */
+#define KPC_ASACT       (0x1 << 29)  /* Automatic Scan on Activity */
+#define KPC_MI          (0x1 << 22)  /* Matrix interrupt bit */
+#define KPC_IMKP        (0x1 << 21)  /* Ignore Multiple Key Press */
+
+#define KPC_MS(n)	(0x1 << (13 + (n)))	/* Matrix scan line 'n' */
+#define KPC_MS_ALL      (0xff << 13)
+
+#define KPC_ME          (0x1 << 12)  /* Matrix Keypad Enable */
+#define KPC_MIE         (0x1 << 11)  /* Matrix Interrupt Enable */
+#define KPC_DK_DEB_SEL	(0x1 <<  9)  /* Direct Keypad Debounce Select */
+#define KPC_DI          (0x1 <<  5)  /* Direct key interrupt bit */
+#define KPC_RE_ZERO_DEB (0x1 <<  4)  /* Rotary Encoder Zero Debounce */
+#define KPC_REE1        (0x1 <<  3)  /* Rotary Encoder1 Enable */
+#define KPC_REE0        (0x1 <<  2)  /* Rotary Encoder0 Enable */
+#define KPC_DE          (0x1 <<  1)  /* Direct Keypad Enable */
+#define KPC_DIE         (0x1 <<  0)  /* Direct Keypad interrupt Enable */
+
 #define KPDK_DKP        (0x1 << 31)
 #define KPDK_DK(n)	((n) & 0xff)

-#define KPAS_MUKP(n)		(((n) >> 26) & 0x1f)
-#define KPAS_RP(n)		(((n) >> 4) & 0xf)
-#define KPAS_CP(n)		((n) & 0xf)
+#define KPREC_OF1       (0x1 << 31)
+#define kPREC_UF1       (0x1 << 30)
+#define KPREC_OF0       (0x1 << 15)
+#define KPREC_UF0       (0x1 << 14)
+
+#define KPREC_RECOUNT0(n)	((n) & 0xff)
+#define KPREC_RECOUNT1(n)	(((n) >> 16) & 0xff)
+
+#define KPMK_MKP        (0x1 << 31)
+#define KPAS_SO         (0x1 << 31)
+#define KPASMKPx_SO     (0x1 << 31)
+
+#define KPAS_MUKP(n)	(((n) >> 26) & 0x1f)
+#define KPAS_RP(n)	(((n) >> 4) & 0xf)
+#define KPAS_CP(n)	((n) & 0xf)

 #define KPASMKP_MKC_MASK	(0xff)

+#define keypad_readl(off)	__raw_readl(keypad->mmio_base + (off))
+#define keypad_writel(off, v)	__raw_writel((v), keypad->mmio_base + (off))
+
 #define MAX_MATRIX_KEY_NUM	(8 * 8)

 struct pxa27x_keypad {
@@ -57,6 +103,7 @@ struct pxa27x_keypad {

 	struct clk *clk;
 	struct input_dev *input_dev;
+	void __iomem *mmio_base;

 	/* matrix key code map */
 	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
@@ -120,7 +167,7 @@ static void pxa27x_keypad_scan_matrix(struct
pxa27x_keypad *keypad)
 	struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
 	int row, col, num_keys_pressed = 0;
 	uint32_t new_state[MAX_MATRIX_KEY_COLS];
-	uint32_t kpas = KPAS;
+	uint32_t kpas = keypad_readl(KPAS);

 	num_keys_pressed = KPAS_MUKP(kpas);

@@ -143,10 +190,10 @@ static void pxa27x_keypad_scan_matrix(struct
pxa27x_keypad *keypad)
 	}

 	if (num_keys_pressed > 1) {
-		uint32_t kpasmkp0 = KPASMKP0;
-		uint32_t kpasmkp1 = KPASMKP1;
-		uint32_t kpasmkp2 = KPASMKP2;
-		uint32_t kpasmkp3 = KPASMKP3;
+		uint32_t kpasmkp0 = keypad_readl(KPASMKP0);
+		uint32_t kpasmkp1 = keypad_readl(KPASMKP1);
+		uint32_t kpasmkp2 = keypad_readl(KPASMKP2);
+		uint32_t kpasmkp3 = keypad_readl(KPASMKP3);

 		new_state[0] = kpasmkp0 & KPASMKP_MKC_MASK;
 		new_state[1] = (kpasmkp0 >> 16) & KPASMKP_MKC_MASK;
@@ -218,8 +265,8 @@ static void pxa27x_keypad_scan_rotary(struct
pxa27x_keypad *keypad)
 	uint32_t kprec;

 	/* read and reset to default count value */
-	kprec = KPREC;
-	KPREC = DEFAULT_KPREC;
+	kprec = keypad_readl(KPREC);
+	keypad_writel(KPREC, DEFAULT_KPREC);

 	if (pdata->enable_rotary0)
 		report_rotary_event(keypad, 0, rotary_delta(kprec));
@@ -235,7 +282,7 @@ static void pxa27x_keypad_scan_direct(struct
pxa27x_keypad *keypad)
 	uint32_t kpdk, bits_changed;
 	int i;

-	kpdk = KPDK;
+	kpdk = keypad_readl(KPDK);

 	if (pdata->enable_rotary0 || pdata->enable_rotary1)
 		pxa27x_keypad_scan_rotary(keypad);
@@ -262,7 +309,7 @@ static void pxa27x_keypad_scan_direct(struct
pxa27x_keypad *keypad)
 static irqreturn_t pxa27x_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct pxa27x_keypad *keypad = dev_id;
-	unsigned long kpc = KPC;
+	unsigned long kpc = keypad_readl(KPC);

 	if (kpc & KPC_DI)
 		pxa27x_keypad_scan_direct(keypad);
@@ -308,8 +355,8 @@ static void pxa27x_keypad_config(struct
pxa27x_keypad *keypad)
 	if (direct_key_num)
 		kpc |= KPC_DE | KPC_DIE | KPC_DKN(direct_key_num);

-	KPC = kpc | KPC_RE_ZERO_DEB;
-	KPREC = DEFAULT_KPREC;
+	keypad_writel(KPC, kpc | KPC_RE_ZERO_DEB);
+	keypad_writel(KPREC, DEFAULT_KPREC);
 }

 static int pxa27x_keypad_open(struct input_dev *dev)
@@ -362,11 +409,14 @@ static int pxa27x_keypad_resume(struct
platform_device *pdev)
 #define pxa27x_keypad_resume	NULL
 #endif

+#define res_size(res)	((res)->end - (res)->start + 1)
+
 static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
 {
 	struct pxa27x_keypad *keypad;
 	struct input_dev *input_dev;
-	int error;
+	struct resource *res;
+	int irq, error;

 	keypad = kzalloc(sizeof(struct pxa27x_keypad), GFP_KERNEL);
 	if (keypad == NULL) {
@@ -381,11 +431,39 @@ static int __devinit pxa27x_keypad_probe(struct
platform_device *pdev)
 		goto failed_free;
 	}

+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get keypad irq\n");
+		error = -ENXIO;
+		goto failed_free;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		error = -ENXIO;
+		goto failed_free;
+	}
+
+	res = request_mem_region(res->start, res_size(res), pdev->name);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to request I/O memory\n");
+		error = -EBUSY;
+		goto failed_free;
+	}
+
+	keypad->mmio_base = ioremap(res->start, res_size(res));
+	if (keypad->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		error = -ENXIO;
+		goto failed_free_mem;
+	}
+
 	keypad->clk = clk_get(&pdev->dev, "KBDCLK");
 	if (IS_ERR(keypad->clk)) {
 		dev_err(&pdev->dev, "failed to get keypad clock\n");
 		error = PTR_ERR(keypad->clk);
-		goto failed_free;
+		goto failed_free_io;
 	}

 	/* Create and register the input driver. */
@@ -396,7 +474,7 @@ static int __devinit pxa27x_keypad_probe(struct
platform_device *pdev)
 		goto failed_put_clk;
 	}

-	input_dev->name = DRIVER_NAME;
+	input_dev->name = pdev->name;
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->open = pxa27x_keypad_open;
 	input_dev->close = pxa27x_keypad_close;
@@ -409,30 +487,35 @@ static int __devinit pxa27x_keypad_probe(struct
platform_device *pdev)
 		BIT_MASK(EV_REL);

 	pxa27x_keypad_build_keycode(keypad);
+	platform_set_drvdata(pdev, keypad);

-	error = request_irq(IRQ_KEYPAD, pxa27x_keypad_irq_handler, IRQF_DISABLED,
-			    DRIVER_NAME, keypad);
+	error = request_irq(irq, pxa27x_keypad_irq_handler, IRQF_DISABLED,
+			    pdev->name, keypad);
 	if (error) {
-		printk(KERN_ERR "Cannot request keypad IRQ\n");
-		goto err_free_dev;
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto failed_free_dev;
 	}

-	platform_set_drvdata(pdev, keypad);
-
 	/* Register the input device */
 	error = input_register_device(input_dev);
-	if (error)
-		goto err_free_irq;
+	if (error) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto failed_free_irq;
+	}

 	return 0;

- err_free_irq:
+failed_free_irq:
+	free_irq(irq, pdev);
 	platform_set_drvdata(pdev, NULL);
-	free_irq(IRQ_KEYPAD, pdev);
- err_free_dev:
+failed_free_dev:
 	input_free_device(input_dev);
 failed_put_clk:
 	clk_put(keypad->clk);
+failed_free_io:
+	iounmap(keypad->mmio_base);
+failed_free_mem:
+	release_mem_region(res->start, res_size(res));
 failed_free:
 	kfree(keypad);
 	return error;
@@ -441,13 +524,20 @@ failed_free:
 static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
 {
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
+	struct resource *res;

-	free_irq(IRQ_KEYPAD, pdev);
+	free_irq(platform_get_irq(pdev, 0), pdev);

 	clk_disable(keypad->clk);
 	clk_put(keypad->clk);

 	input_unregister_device(keypad->input_dev);
+	input_free_device(keypad->input_dev);
+
+	iounmap(keypad->mmio_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res_size(res));

 	platform_set_drvdata(pdev, NULL);
 	kfree(keypad);
@@ -460,7 +550,7 @@ static struct platform_driver pxa27x_keypad_driver = {
 	.suspend	= pxa27x_keypad_suspend,
 	.resume		= pxa27x_keypad_resume,
 	.driver		= {
-		.name	= DRIVER_NAME,
+		.name	= "pxa27x-keypad",
 	},
 };

-- 
1.5.2.5.GIT



-- 
Cheers
- eric
