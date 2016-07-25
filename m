From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH] Input: cros_ec_keyb - cleanup use of dev
Date: Mon, 25 Jul 2016 11:43:48 -0700
Message-ID: <1469472228-58912-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

In cros_ec_keyb we stored "dev" in "struct cros_ec_keyb", but this was
the EC's dev pointer and not the keyboard's.  Let's clean this up to
make it the keyboard's dev pointer.  This could be useful in future
patches but also has the nice effect of changing a few printouts to
include the name of the keyboard device instead of the EC device, which
seems more technically correct.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 6e48616a3a88..ab1b50152b86 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -186,7 +186,7 @@ static irqreturn_t cros_ec_keyb_irq(int irq, void *data)
 	if (ret >= 0)
 		cros_ec_keyb_process(ckdev, kb_state, ret);
 	else
-		dev_err(ec->dev, "failed to get keyboard state: %d\n", ret);
+		dev_err(ckdev->dev, "failed to get keyboard state: %d\n", ret);
 
 	return IRQ_HANDLED;
 }
@@ -236,7 +236,7 @@ static void cros_ec_keyb_compute_valid_keys(struct cros_ec_keyb *ckdev)
 static int cros_ec_keyb_probe(struct platform_device *pdev)
 {
 	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
-	struct device *dev = ec->dev;
+	struct device *dev = &pdev->dev;
 	struct cros_ec_keyb *ckdev;
 	struct input_dev *idev;
 	struct device_node *np;
@@ -246,23 +246,22 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENODEV;
 
-	ckdev = devm_kzalloc(&pdev->dev, sizeof(*ckdev), GFP_KERNEL);
+	ckdev = devm_kzalloc(dev, sizeof(*ckdev), GFP_KERNEL);
 	if (!ckdev)
 		return -ENOMEM;
-	err = matrix_keypad_parse_of_params(&pdev->dev, &ckdev->rows,
-					    &ckdev->cols);
+	err = matrix_keypad_parse_of_params(dev, &ckdev->rows, &ckdev->cols);
 	if (err)
 		return err;
 
-	ckdev->valid_keys = devm_kzalloc(&pdev->dev, ckdev->cols, GFP_KERNEL);
+	ckdev->valid_keys = devm_kzalloc(dev, ckdev->cols, GFP_KERNEL);
 	if (!ckdev->valid_keys)
 		return -ENOMEM;
 
-	ckdev->old_kb_state = devm_kzalloc(&pdev->dev, ckdev->cols, GFP_KERNEL);
+	ckdev->old_kb_state = devm_kzalloc(dev, ckdev->cols, GFP_KERNEL);
 	if (!ckdev->old_kb_state)
 		return -ENOMEM;
 
-	idev = devm_input_allocate_device(&pdev->dev);
+	idev = devm_input_allocate_device(dev);
 	if (!idev)
 		return -ENOMEM;
 
@@ -273,7 +272,7 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 
 	ckdev->ec = ec;
 	ckdev->dev = dev;
-	dev_set_drvdata(&pdev->dev, ckdev);
+	dev_set_drvdata(dev, ckdev);
 
 	idev->name = CROS_EC_DEV_NAME;
 	idev->phys = ec->phys_name;
@@ -282,7 +281,7 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 	idev->id.bustype = BUS_VIRTUAL;
 	idev->id.version = 1;
 	idev->id.product = 0;
-	idev->dev.parent = &pdev->dev;
+	idev->dev.parent = dev;
 	idev->open = cros_ec_keyb_open;
 	idev->close = cros_ec_keyb_close;
 
-- 
2.8.0.rc3.226.g39d4020
