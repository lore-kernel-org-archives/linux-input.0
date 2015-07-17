From: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2] input: snvs_pwrkey: use "wakeup-source" as deivce tree property name
Date: Fri, 17 Jul 2015 12:02:17 +0800
Message-ID: <1437105737-16899-1-git-send-email-shawnguo@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46390 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbbGQEHE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 00:07:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.Li@freescale.com>, Shawn Guo <shawnguo@kernel.org>

Instead of inventing a new property name, let's use "wakeup-source" to
be consistent with other driver and subsystem bindings.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
Changes since v1:
 - Use "wakeup-source" rather than "linux,wakeup"

This is a fixup for Frank's patch which is queued on i.MX tree, so I
will apply it to the same branch.

Shawn

 Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 2 +-
 drivers/input/keyboard/snvs_pwrkey.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index 71a39c5bd486..f16bbd6644b8 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -408,7 +408,7 @@ System ON/OFF key driver
       Value type: <int>
       Definition: Keycode to emit, KEY_POWER by default.
 
-  - wakeup:
+  - wakeup-source:
       Usage: option
       Value type: <boo>
       Definition: Button can wake-up the system.
diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 512a1fc2a864..78fd24ca3813 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -122,7 +122,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
 	}
 
-	pdata->wakeup = of_property_read_bool(np, "wakeup");
+	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
 
 	pdata->irq = platform_get_irq(pdev, 0);
 	if (pdata->irq < 0) {
-- 
1.9.1

