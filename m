From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 2/4] input: keyboard: tegra: use devm_* for resource
 allocation
Date: Sat, 5 Jan 2013 17:11:49 +0530
Message-ID: <1357386111-19971-3-git-send-email-ldewangan@nvidia.com>
References: <1357386111-19971-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1357386111-19971-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Use devm_* for memory, clock, input device allocation. This reduces
code for freeing these resources.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes from V1: None
Changes from V2:
- remove the error checks changes from original.
- return -EBUSY when reg mapping fail.
- remove unregister_input_device() devm_* version is used.
- Pass correct argument in free_irq.

 drivers/input/keyboard/tegra-kbc.c |   92 +++++++++++-------------------------
 1 files changed, 27 insertions(+), 65 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index f1d3ba0..e2fdf9d 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -618,7 +618,7 @@ static struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
 	if (!np)
 		return NULL;
 
-	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
@@ -700,33 +700,36 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	if (!pdata)
 		pdata = tegra_kbc_dt_parse_pdata(pdev);
 
-	if (!pdata)
+	if (!pdata) {
+		dev_err(&pdev->dev, "Platform data missing\n");
 		return -EINVAL;
-
-	if (!tegra_kbc_check_pin_cfg(pdata, &pdev->dev, &num_rows)) {
-		err = -EINVAL;
-		goto err_free_pdata;
 	}
 
+	if (!tegra_kbc_check_pin_cfg(pdata, &pdev->dev, &num_rows))
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		err = -ENXIO;
-		goto err_free_pdata;
+		return -ENXIO;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
-		err = -ENXIO;
-		goto err_free_pdata;
+		return -ENXIO;
+	}
+
+	kbc = devm_kzalloc(&pdev->dev, sizeof(*kbc), GFP_KERNEL);
+	if (!kbc) {
+		dev_err(&pdev->dev, "failed to alloc memory for kbc\n");
+		return -ENOMEM;
 	}
 
-	kbc = kzalloc(sizeof(*kbc), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!kbc || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev) {
+		dev_err(&pdev->dev, "failed to allocate input device\n");
+		return -ENOMEM;
 	}
 
 	kbc->pdata = pdata;
@@ -735,25 +738,16 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	spin_lock_init(&kbc->lock);
 	setup_timer(&kbc->timer, tegra_kbc_keypress_timer, (unsigned long)kbc);
 
-	res = request_mem_region(res->start, resource_size(res), pdev->name);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to request I/O memory\n");
-		err = -EBUSY;
-		goto err_free_mem;
-	}
-
-	kbc->mmio = ioremap(res->start, resource_size(res));
+	kbc->mmio = devm_request_and_ioremap(&pdev->dev, res);
 	if (!kbc->mmio) {
-		dev_err(&pdev->dev, "failed to remap I/O memory\n");
-		err = -ENXIO;
-		goto err_free_mem_region;
+		dev_err(&pdev->dev, "Cannot request memregion/iomap address\n");
+		return -EBUSY;
 	}
 
-	kbc->clk = clk_get(&pdev->dev, NULL);
+	kbc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(kbc->clk)) {
 		dev_err(&pdev->dev, "failed to get keyboard clock\n");
-		err = PTR_ERR(kbc->clk);
-		goto err_iounmap;
+		return PTR_ERR(kbc->clk);
 	}
 
 	/*
@@ -780,7 +774,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	err = tegra_kbd_setup_keymap(kbc);
 	if (err) {
 		dev_err(&pdev->dev, "failed to setup keymap\n");
-		goto err_put_clk;
+		return err;
 	}
 
 	__set_bit(EV_REP, input_dev->evbit);
@@ -792,7 +786,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 			  IRQF_NO_SUSPEND | IRQF_TRIGGER_HIGH, pdev->name, kbc);
 	if (err) {
 		dev_err(&pdev->dev, "failed to request keyboard IRQ\n");
-		goto err_put_clk;
+		return err;
 	}
 
 	disable_irq(kbc->irq);
@@ -809,47 +803,15 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_irq:
-	free_irq(kbc->irq, pdev);
-err_put_clk:
-	clk_put(kbc->clk);
-err_iounmap:
-	iounmap(kbc->mmio);
-err_free_mem_region:
-	release_mem_region(res->start, resource_size(res));
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(kbc);
-err_free_pdata:
-	if (!pdev->dev.platform_data)
-		kfree(pdata);
-
+	free_irq(kbc->irq, kbc);
 	return err;
 }
 
 static int tegra_kbc_remove(struct platform_device *pdev)
 {
 	struct tegra_kbc *kbc = platform_get_drvdata(pdev);
-	struct resource *res;
-
-	platform_set_drvdata(pdev, NULL);
-
-	free_irq(kbc->irq, pdev);
-	clk_put(kbc->clk);
-
-	input_unregister_device(kbc->idev);
-	iounmap(kbc->mmio);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
-	/*
-	 * If we do not have platform data attached to the device we
-	 * allocated it ourselves and thus need to free it.
-	 */
-	if (!pdev->dev.platform_data)
-		kfree(kbc->pdata);
-
-	kfree(kbc);
 
+	free_irq(kbc->irq, kbc);
 	return 0;
 }
 
-- 
1.7.1.1
