From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/6] Input: edt-ft5x06 - do not hardcode interrupt trigger type
Date: Sat, 12 Sep 2015 10:45:50 -0700
Message-ID: <3b89cb3ec897a05e8170ea1e736d3e969c1f8419.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-input@vger.kernel.org

Instead of hardcoding IRQ trigger type to IRQF_TRIGGER_FALLING, let's
respect settings specified in device tree. To be compatible with older
DTSes, if trigger type is not set up in DTS we'll set it to default
(falling edge).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/edt-ft5x06.txt     |  2 +-
 drivers/input/touchscreen/edt-ft5x06.c                       | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index 9330d4d..bedd7dd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -49,7 +49,7 @@ Example:
 		pinctrl-names = "default";
 		pinctrl-0 = <&edt_ft5x06_pins>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <5 0>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ef8a7cd..7239c31 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -27,6 +27,7 @@
 
 #include <linux/module.h>
 #include <linux/ratelimit.h>
+#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/i2c.h>
@@ -874,6 +875,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 {
 	struct edt_ft5x06_ts_data *tsdata;
 	struct input_dev *input;
+	unsigned long irq_flags;
 	int error;
 	char fw_version[EDT_NAME_LEN];
 
@@ -959,9 +961,13 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input_set_drvdata(input, tsdata);
 	i2c_set_clientdata(client, tsdata);
 
-	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					edt_ft5x06_ts_isr,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+	irq_flags = irq_get_trigger_type(client->irq);
+	if (irq_flags == IRQF_TRIGGER_NONE)
+		irq_flags = IRQF_TRIGGER_FALLING;
+	irq_flags |= IRQF_ONESHOT;
+
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, edt_ft5x06_ts_isr, irq_flags,
 					client->name, tsdata);
 	if (error) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
-- 
2.6.0.rc0.131.gf624c3d
