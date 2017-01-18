From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/33] Input: sh_keysc - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:28 -0800
Message-ID: <1484761614-12225-8-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Error messages after memory allocation failures are unnecessary and
can be dropped.

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop unnecessary braces around conditional return statements
- Drop error message after devm_kzalloc() failure
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/keyboard/sh_keysc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index 7abf03b4cc9c..63ea707df193 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -172,29 +172,25 @@ static int sh_keysc_probe(struct platform_device *pdev)
 
 	if (!dev_get_platdata(&pdev->dev)) {
 		dev_err(&pdev->dev, "no platform data defined\n");
-		error = -EINVAL;
-		goto err0;
+		return -EINVAL;
 	}
 
 	error = -ENXIO;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		goto err0;
+		return error;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get irq\n");
-		goto err0;
+		return error;
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (priv == NULL) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
-		error = -ENOMEM;
-		goto err0;
-	}
+	if (priv == NULL)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, priv);
 	memcpy(&priv->pdata, dev_get_platdata(&pdev->dev), sizeof(priv->pdata));
@@ -266,7 +262,6 @@ static int sh_keysc_probe(struct platform_device *pdev)
 	iounmap(priv->iomem_base);
  err1:
 	kfree(priv);
- err0:
 	return error;
 }
 
-- 
2.7.4
