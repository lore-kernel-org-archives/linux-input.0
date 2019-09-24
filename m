From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] input: keyboard: imx_keypad: Use 'dev' instead of dereferencing it repeatedly
Date: Tue, 24 Sep 2019 17:04:19 +0800
Message-ID: <1569315859-7046-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, swboyd@chromium.org, mojha@codeaurora.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Add helper variable dev = &pdev->dev to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/imx_keypad.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 5a46d11..3024d2a 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -418,14 +418,15 @@ MODULE_DEVICE_TABLE(of, imx_keypad_of_match);
 
 static int imx_keypad_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct matrix_keymap_data *keymap_data =
-			dev_get_platdata(&pdev->dev);
+			dev_get_platdata(dev);
 	struct imx_keypad *keypad;
 	struct input_dev *input_dev;
 	int irq, error, i, row, col;
 
-	if (!keymap_data && !pdev->dev.of_node) {
-		dev_err(&pdev->dev, "no keymap defined\n");
+	if (!keymap_data && !dev->of_node) {
+		dev_err(dev, "no keymap defined\n");
 		return -EINVAL;
 	}
 
@@ -433,15 +434,15 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	input_dev = devm_input_allocate_device(&pdev->dev);
+	input_dev = devm_input_allocate_device(dev);
 	if (!input_dev) {
-		dev_err(&pdev->dev, "failed to allocate the input device\n");
+		dev_err(dev, "failed to allocate the input device\n");
 		return -ENOMEM;
 	}
 
-	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
+	keypad = devm_kzalloc(dev, sizeof(*keypad), GFP_KERNEL);
 	if (!keypad) {
-		dev_err(&pdev->dev, "not enough memory for driver data\n");
+		dev_err(dev, "not enough memory for driver data\n");
 		return -ENOMEM;
 	}
 
@@ -456,16 +457,16 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
 
-	keypad->clk = devm_clk_get(&pdev->dev, NULL);
+	keypad->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(keypad->clk)) {
-		dev_err(&pdev->dev, "failed to get keypad clock\n");
+		dev_err(dev, "failed to get keypad clock\n");
 		return PTR_ERR(keypad->clk);
 	}
 
 	/* Init the Input device */
 	input_dev->name = pdev->name;
 	input_dev->id.bustype = BUS_HOST;
-	input_dev->dev.parent = &pdev->dev;
+	input_dev->dev.parent = dev;
 	input_dev->open = imx_keypad_open;
 	input_dev->close = imx_keypad_close;
 
@@ -474,7 +475,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
 					   MAX_MATRIX_KEY_COLS,
 					   keypad->keycodes, input_dev);
 	if (error) {
-		dev_err(&pdev->dev, "failed to build keymap\n");
+		dev_err(dev, "failed to build keymap\n");
 		return error;
 	}
 
@@ -488,8 +489,8 @@ static int imx_keypad_probe(struct platform_device *pdev)
 			}
 		}
 	}
-	dev_dbg(&pdev->dev, "enabled rows mask: %x\n", keypad->rows_en_mask);
-	dev_dbg(&pdev->dev, "enabled cols mask: %x\n", keypad->cols_en_mask);
+	dev_dbg(dev, "enabled rows mask: %x\n", keypad->rows_en_mask);
+	dev_dbg(dev, "enabled cols mask: %x\n", keypad->cols_en_mask);
 
 	__set_bit(EV_REP, input_dev->evbit);
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
@@ -502,22 +503,22 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	imx_keypad_inhibit(keypad);
 	clk_disable_unprepare(keypad->clk);
 
-	error = devm_request_irq(&pdev->dev, irq, imx_keypad_irq_handler, 0,
+	error = devm_request_irq(dev, irq, imx_keypad_irq_handler, 0,
 			    pdev->name, keypad);
 	if (error) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
+		dev_err(dev, "failed to request IRQ\n");
 		return error;
 	}
 
 	/* Register the input device */
 	error = input_register_device(input_dev);
 	if (error) {
-		dev_err(&pdev->dev, "failed to register input device\n");
+		dev_err(dev, "failed to register input device\n");
 		return error;
 	}
 
 	platform_set_drvdata(pdev, keypad);
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(dev, 1);
 
 	return 0;
 }
-- 
2.7.4
