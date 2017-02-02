From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 2/2] gpio: Add the devm_fwnode_get_index_gpiod_from_child() helper
Date: Thu,  2 Feb 2017 14:53:11 +0100
Message-ID: <1486043591-6278-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1486043591-6278-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1486043591-6278-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-input@vger.kernel.org

devm_fwnode_get_gpiod_from_child() currently allows GPIO users to
request a GPIO that is defined in a child fwnode instead of directly in
the device fwnode.
Extend this API by adding the devm_fwnode_get_index_gpiod_from_child()
helper which does the same except you can also specify an index in case
the 'xx-gpios' property describe several GPIOs.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpio/devres.c         | 20 +++++++++++---------
 drivers/gpio/gpiolib.c        |  9 +++++----
 include/linux/gpio/consumer.h | 31 +++++++++++++++++++++----------
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
index cd1bd1c3d2c0..b2bbcaae6a1f 100644
--- a/drivers/gpio/devres.c
+++ b/drivers/gpio/devres.c
@@ -123,10 +123,11 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 EXPORT_SYMBOL(devm_gpiod_get_index);
 
 /**
- * devm_fwnode_get_gpiod_from_child - get a GPIO descriptor from a device's
- *				      child node
+ * devm_fwnode_get_index_gpiod_from_child - get a GPIO descriptor from a
+ *					    device's child node
  * @dev:	GPIO consumer
  * @con_id:	function within the GPIO consumer
+ * @index:	index of the GPIO to obtain in the consumer
  * @child:	firmware node (child of @dev)
  * @flags:	GPIO initialization flags
  *
@@ -136,11 +137,11 @@ EXPORT_SYMBOL(devm_gpiod_get_index);
  * On successfull request the GPIO pin is configured in accordance with
  * provided @flags.
  */
-struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
-						   const char *con_id,
-						   struct fwnode_handle *child,
-						   enum gpiod_flags flags,
-						   const char *label)
+struct gpio_desc *devm_fwnode_get_index_gpiod_from_child(struct device *dev,
+						const char *con_id, int index,
+						struct fwnode_handle *child,
+						enum gpiod_flags flags,
+						const char *label)
 {
 	static const char * const suffixes[] = { "gpios", "gpio" };
 	char prop_name[32]; /* 32 is max size of property name */
@@ -161,7 +162,8 @@ struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
 			snprintf(prop_name, sizeof(prop_name), "%s",
 							       suffixes[i]);
 
-		desc = fwnode_get_named_gpiod(child, prop_name, flags, label);
+		desc = fwnode_get_named_gpiod(child, prop_name, index, flags,
+					      label);
 		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
 			break;
 	}
@@ -175,7 +177,7 @@ struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
 
 	return desc;
 }
-EXPORT_SYMBOL(devm_fwnode_get_gpiod_from_child);
+EXPORT_SYMBOL(devm_fwnode_get_index_gpiod_from_child);
 
 /**
  * devm_gpiod_get_index_optional - Resource-managed gpiod_get_index_optional()
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 20c6c51cbe10..5e5d48c3512c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3309,6 +3309,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * fwnode_get_named_gpiod - obtain a GPIO from firmware node
  * @fwnode:	handle of the firmware node
  * @propname:	name of the firmware property representing the GPIO
+ * @index:	index of the GPIO to obtain in the consumer
  * @dflags:	GPIO initialization flags
  *
  * This function can be used for drivers that get their configuration
@@ -3324,7 +3325,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * In case of error an ERR_PTR() is returned.
  */
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname,
+					 const char *propname, int index,
 					 enum gpiod_flags dflags,
 					 const char *label)
 {
@@ -3340,8 +3341,8 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	if (is_of_node(fwnode)) {
 		enum of_gpio_flags flags;
 
-		desc = of_get_named_gpiod_flags(to_of_node(fwnode), propname, 0,
-						&flags);
+		desc = of_get_named_gpiod_flags(to_of_node(fwnode), propname,
+						index, &flags);
 		if (!IS_ERR(desc)) {
 			active_low = flags & OF_GPIO_ACTIVE_LOW;
 			single_ended = flags & OF_GPIO_SINGLE_ENDED;
@@ -3349,7 +3350,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	} else if (is_acpi_node(fwnode)) {
 		struct acpi_gpio_info info;
 
-		desc = acpi_node_get_gpiod(fwnode, propname, 0, &info);
+		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
 		if (!IS_ERR(desc))
 			active_low = info.polarity == GPIO_ACTIVE_LOW;
 	}
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index f32f49e96c0b..ea9b01d40017 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -135,14 +135,14 @@ int desc_to_gpio(const struct gpio_desc *desc);
 struct fwnode_handle;
 
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname,
+					 const char *propname, int index,
 					 enum gpiod_flags dflags,
 					 const char *label);
-struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
-						   const char *con_id,
-						   struct fwnode_handle *child,
-						   enum gpiod_flags flags,
-						   const char *label);
+struct gpio_desc *devm_fwnode_get_index_gpiod_from_child(struct device *dev,
+						const char *con_id, int index,
+						struct fwnode_handle *child,
+						enum gpiod_flags flags,
+						const char *label);
 #else /* CONFIG_GPIOLIB */
 
 static inline int gpiod_count(struct device *dev, const char *con_id)
@@ -417,7 +417,7 @@ struct fwnode_handle;
 
 static inline
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname,
+					 const char *propname, int index,
 					 enum gpiod_flags dflags,
 					 const char *label)
 {
@@ -425,17 +425,28 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 }
 
 static inline
+struct gpio_desc *devm_fwnode_get_index_gpiod_from_child(struct device *dev,
+						const char *con_id, int index,
+						struct fwnode_handle *child,
+						enum gpiod_flags flags,
+						const char *label)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+#endif /* CONFIG_GPIOLIB */
+
+static inline
 struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
 						   const char *con_id,
 						   struct fwnode_handle *child,
 						   enum gpiod_flags flags,
 						   const char *label)
 {
-	return ERR_PTR(-ENOSYS);
+	return devm_fwnode_get_index_gpiod_from_child(dev, con_id, 0, child,
+						      flags, label);
 }
 
-#endif /* CONFIG_GPIOLIB */
-
 #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_GPIO_SYSFS)
 
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change);
-- 
2.7.4

