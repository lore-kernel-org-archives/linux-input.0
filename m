From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 13/29] drivers/input/keyboard/tegra-kbc.c: simplify use of devm_ioremap_resource
Date: Wed, 14 Aug 2013 11:11:17 +0200
Message-ID: <1376471493-22215-14-git-send-email-Julia.Lawall@lip6.fr>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Remove unneeded error handling on the result of a call to
platform_get_resource when the value is passed to devm_ioremap_resource.

Move the call to platform_get_resource adjacent to the call to
devm_ioremap_resource to make the connection between them more clear.

A simplified version of the semantic patch that makes this change is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression pdev,res,n,e,e1;
expression ret != 0;
identifier l;
@@

- res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  ... when != res
- if (res == NULL) { ... \(goto l;\|return ret;\) }
  ... when != res
+ res = platform_get_resource(pdev, IORESOURCE_MEM, n);
  e = devm_ioremap_resource(e1, res);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/input/keyboard/tegra-kbc.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index b46142f..9cd20e6 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -638,12 +638,6 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	if (!tegra_kbc_check_pin_cfg(kbc, &num_rows))
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
-	}
-
 	kbc->irq = platform_get_irq(pdev, 0);
 	if (kbc->irq < 0) {
 		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
@@ -658,6 +652,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 
 	setup_timer(&kbc->timer, tegra_kbc_keypress_timer, (unsigned long)kbc);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	kbc->mmio = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(kbc->mmio))
 		return PTR_ERR(kbc->mmio);

