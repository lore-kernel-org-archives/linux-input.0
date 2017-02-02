From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Thu,  2 Feb 2017 14:53:10 +0100
Message-ID: <1486043591-6278-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1486043591-6278-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1486043591-6278-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-input@vger.kernel.org

Rename devm_get_gpiod_from_child() into
devm_fwnode_get_gpiod_from_child() to reflect the fact that this
function is operating on a fwnode object.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/devres.c                     | 15 ++++++++-------
 drivers/input/keyboard/gpio_keys.c        |  6 ++++--
 drivers/input/keyboard/gpio_keys_polled.c |  8 ++++----
 drivers/leds/leds-gpio.c                  |  5 +++--
 drivers/video/fbdev/amba-clcd-nomadik.c   | 16 ++++++++--------
 include/linux/gpio/consumer.h             | 20 ++++++++++----------
 6 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
index 89969e887e5d..cd1bd1c3d2c0 100644
--- a/drivers/gpio/devres.c
+++ b/drivers/gpio/devres.c
@@ -123,7 +123,8 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 EXPORT_SYMBOL(devm_gpiod_get_index);
 
 /**
- * devm_get_gpiod_from_child - get a GPIO descriptor from a device's child node
+ * devm_fwnode_get_gpiod_from_child - get a GPIO descriptor from a device's
+ *				      child node
  * @dev:	GPIO consumer
  * @con_id:	function within the GPIO consumer
  * @child:	firmware node (child of @dev)
@@ -135,11 +136,11 @@ EXPORT_SYMBOL(devm_gpiod_get_index);
  * On successfull request the GPIO pin is configured in accordance with
  * provided @flags.
  */
-struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
-					    const char *con_id,
-					    struct fwnode_handle *child,
-					    enum gpiod_flags flags,
-					    const char *label)
+struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
+						   const char *con_id,
+						   struct fwnode_handle *child,
+						   enum gpiod_flags flags,
+						   const char *label)
 {
 	static const char * const suffixes[] = { "gpios", "gpio" };
 	char prop_name[32]; /* 32 is max size of property name */
@@ -174,7 +175,7 @@ struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
 
 	return desc;
 }
-EXPORT_SYMBOL(devm_get_gpiod_from_child);
+EXPORT_SYMBOL(devm_fwnode_get_gpiod_from_child);
 
 /**
  * devm_gpiod_get_index_optional - Resource-managed gpiod_get_index_optional()
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2ec74d90ef78..13372782dffe 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -481,8 +481,10 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	spin_lock_init(&bdata->lock);
 
 	if (child) {
-		bdata->gpiod = devm_get_gpiod_from_child(dev, NULL, child,
-							 GPIOD_IN, desc);
+		bdata->gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL,
+								child,
+								GPIOD_IN,
+								desc);
 		if (IS_ERR(bdata->gpiod)) {
 			error = PTR_ERR(bdata->gpiod);
 			if (error == -ENOENT) {
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 5e35c565e341..b3c8d5e7985c 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -303,10 +303,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 				return -EINVAL;
 			}
 
-			bdata->gpiod = devm_get_gpiod_from_child(dev, NULL,
-								 child,
-								 GPIOD_IN,
-								 button->desc);
+			bdata->gpiod = devm_fwnode_get_gpiod_from_child(dev,
+								NULL, child,
+								GPIOD_IN,
+								button->desc);
 			if (IS_ERR(bdata->gpiod)) {
 				error = PTR_ERR(bdata->gpiod);
 				if (error != -EPROBE_DEFER)
diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 6c4825d96693..066fc7590729 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -182,8 +182,9 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 			return ERR_PTR(-EINVAL);
 		}
 
-		led.gpiod = devm_get_gpiod_from_child(dev, NULL, child,
-						      GPIOD_ASIS, led.name);
+		led.gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL, child,
+							     GPIOD_ASIS,
+							     led.name);
 		if (IS_ERR(led.gpiod)) {
 			fwnode_handle_put(child);
 			return ERR_CAST(led.gpiod);
diff --git a/drivers/video/fbdev/amba-clcd-nomadik.c b/drivers/video/fbdev/amba-clcd-nomadik.c
index 9175ad9034e1..476ff3f4d466 100644
--- a/drivers/video/fbdev/amba-clcd-nomadik.c
+++ b/drivers/video/fbdev/amba-clcd-nomadik.c
@@ -185,26 +185,26 @@ static void tpg110_init(struct device *dev, struct device_node *np,
 	dev_info(dev, "TPG110 display init\n");
 
 	/* This asserts the GRESTB signal, putting the display into reset */
-	grestb = devm_get_gpiod_from_child(dev, "grestb", &np->fwnode,
-					   GPIOD_OUT_HIGH, "grestb");
+	grestb = devm_fwnode_get_gpiod_from_child(dev, "grestb", &np->fwnode,
+						  GPIOD_OUT_HIGH, "grestb");
 	if (IS_ERR(grestb)) {
 		dev_err(dev, "no GRESTB GPIO\n");
 		return;
 	}
-	scen = devm_get_gpiod_from_child(dev, "scen", &np->fwnode,
-					 GPIOD_OUT_LOW, "scen");
+	scen = devm_fwnode_get_gpiod_from_child(dev, "scen", &np->fwnode,
+						GPIOD_OUT_LOW, "scen");
 	if (IS_ERR(scen)) {
 		dev_err(dev, "no SCEN GPIO\n");
 		return;
 	}
-	scl = devm_get_gpiod_from_child(dev, "scl", &np->fwnode, GPIOD_OUT_LOW,
-					"scl");
+	scl = devm_fwnode_get_gpiod_from_child(dev, "scl", &np->fwnode,
+					       GPIOD_OUT_LOW, "scl");
 	if (IS_ERR(scl)) {
 		dev_err(dev, "no SCL GPIO\n");
 		return;
 	}
-	sda = devm_get_gpiod_from_child(dev, "sda", &np->fwnode, GPIOD_OUT_LOW,
-					"sda");
+	sda = devm_fwnode_get_gpiod_from_child(dev, "sda", &np->fwnode,
+					       GPIOD_OUT_LOW, "sda");
 	if (IS_ERR(sda)) {
 		dev_err(dev, "no SDA GPIO\n");
 		return;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 80bad7ebde04..f32f49e96c0b 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -138,11 +138,11 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 					 const char *propname,
 					 enum gpiod_flags dflags,
 					 const char *label);
-struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
-					    const char *con_id,
-					    struct fwnode_handle *child,
-					    enum gpiod_flags flags,
-					    const char *label);
+struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
+						   const char *con_id,
+						   struct fwnode_handle *child,
+						   enum gpiod_flags flags,
+						   const char *label);
 #else /* CONFIG_GPIOLIB */
 
 static inline int gpiod_count(struct device *dev, const char *con_id)
@@ -425,11 +425,11 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 }
 
 static inline
-struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
-					    const char *con_id,
-					    struct fwnode_handle *child,
-					    enum gpiod_flags flags,
-					    const char *label)
+struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
+						   const char *con_id,
+						   struct fwnode_handle *child,
+						   enum gpiod_flags flags,
+						   const char *label)
 {
 	return ERR_PTR(-ENOSYS);
 }
-- 
2.7.4
