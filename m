From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] input/keyboard: Introduce the use of the managed version of
 kzalloc
Date: Thu, 22 May 2014 21:22:41 +0530
Message-ID: <20140522155241.GA8976@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: linux-input@vger.kernel.org

This patch moves data allocated using kzalloc to managed data allocated
using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
functions. The input_allocate_device is replaced by the corresponding
devm version and error handling code is cleaned up. Also, label err and
err1 no longer required are removed. Also, linux/device.h include is
added to make sure the devm_*() routine declarations are unambiguously
available.

The following Coccinelle semantic patch was used for making a part of
the change:

@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@prb@
identifier platform.probefn, pdev;
expression e, e1, e2;
@@
probefn(struct platform_device *pdev, ...) {
  <+...
- e = kzalloc(e1, e2)
+ e = devm_kzalloc(&pdev->dev, e1, e2)
  ...
?-kfree(e);
  ...+>
}

@rem depends on prb@
identifier platform.removefn;
expression e;
@@
removefn(...) {
  <...
- kfree(e);
  ...>
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
 drivers/input/keyboard/adp5520-keys.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
index 4cc14c2..fdd6bdc 100644
--- a/drivers/input/keyboard/adp5520-keys.c
+++ b/drivers/input/keyboard/adp5520-keys.c
@@ -12,6 +12,7 @@
 #include <linux/input.h>
 #include <linux/mfd/adp5520.h>
 #include <linux/slab.h>
+#include <linux/device.h>
 
 struct adp5520_keys {
 	struct input_dev *input;
@@ -89,17 +90,15 @@ static int adp5520_keys_probe(struct platform_device *pdev)
 	if (!(pdata->rows_en_mask && pdata->cols_en_mask))
 		return -EINVAL;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL) {
 		dev_err(&pdev->dev, "failed to alloc memory\n");
 		return -ENOMEM;
 	}
 
-	input = input_allocate_device();
-	if (!input) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return -ENOMEM;
 
 	dev->master = pdev->dev.parent;
 	dev->input = input;
@@ -135,7 +134,7 @@ static int adp5520_keys_probe(struct platform_device *pdev)
 	ret = input_register_device(input);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register input device\n");
-		goto err;
+		return ret;
 	}
 
 	en_mask = pdata->rows_en_mask | pdata->cols_en_mask;
@@ -157,8 +156,7 @@ static int adp5520_keys_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(&pdev->dev, "failed to write\n");
-		ret = -EIO;
-		goto err1;
+		return -EIO;
 	}
 
 	dev->notifier.notifier_call = adp5520_keys_notifier;
@@ -166,19 +164,11 @@ static int adp5520_keys_probe(struct platform_device *pdev)
 			ADP5520_KP_IEN | ADP5520_KR_IEN);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register notifier\n");
-		goto err1;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, dev);
 	return 0;
-
-err1:
-	input_unregister_device(input);
-	input = NULL;
-err:
-	input_free_device(input);
-	kfree(dev);
-	return ret;
 }
 
 static int adp5520_keys_remove(struct platform_device *pdev)
@@ -188,8 +178,6 @@ static int adp5520_keys_remove(struct platform_device *pdev)
 	adp5520_unregister_notifier(dev->master, &dev->notifier,
 				ADP5520_KP_IEN | ADP5520_KR_IEN);
 
-	input_unregister_device(dev->input);
-	kfree(dev);
 	return 0;
 }
 
-- 
1.9.1
