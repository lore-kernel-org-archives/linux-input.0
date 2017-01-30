From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 2/2] gpio: Add the devm_fwnode_get_index_gpiod_from_child() helper
Date: Mon, 30 Jan 2017 16:41:49 +0100
Message-ID: <1485790909-2915-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-input@vger.kernel.org

devm_fwnode_get_gpiod_from_child() currently allows GPIO users to
request a GPIO that is defined in a child fwnode instead of directly in
the device fwnode.
Extend this API by adding the devm_fwnode_get_index_gpiod_from_child()
helper which does the same except you can also specify an index in case
the 'xx-gpios' property describe several GPIOs.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpio/devres.c         | 15 ++++++++-------
 drivers/gpio/gpiolib.c        |  9 +++++----
 include/linux/gpio/consumer.h | 21 +++++++++++++++------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
index dfbbd92d21b6..be5f947570db 100644
--- a/drivers/gpio/devres.c
+++ b/drivers/gpio/devres.c
@@ -123,18 +123,19 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
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
  *
  * GPIO descriptors returned from this function are automatically disposed on
  * driver detach.
  */
-struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
-						   const char *con_id,
-						   struct fwnode_handle *child)
+struct gpio_desc *devm_fwnode_get_index_gpiod_from_child(struct device *dev,
+						const char *con_id, int index,
+						struct fwnode_handle *child)
 {
 	static const char * const suffixes[] = { "gpios", "gpio" };
 	char prop_name[32]; /* 32 is max size of property name */
@@ -155,7 +156,7 @@ struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
 			snprintf(prop_name, sizeof(prop_name), "%s",
 							       suffixes[i]);
 
-		desc = fwnode_get_named_gpiod(child, prop_name);
+		desc = fwnode_get_named_gpiod(child, prop_name, index);
 		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
 			break;
 	}
@@ -169,7 +170,7 @@ struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
 
 	return desc;
 }
-EXPORT_SYMBOL(devm_fwnode_get_gpiod_from_child);
+EXPORT_SYMBOL(devm_fwnode_get_index_gpiod_from_child);
 
 /**
  * devm_gpiod_get_index_optional - Resource-managed gpiod_get_index_optional()
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 86bf3b84ada5..9b7a7734e742 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3309,6 +3309,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * fwnode_get_named_gpiod - obtain a GPIO from firmware node
  * @fwnode:	handle of the firmware node
  * @propname:	name of the firmware property representing the GPIO
+ * @index:	index of the GPIO to obtain in the consumer
  *
  * This function can be used for drivers that get their configuration
  * from firmware.
@@ -3320,7 +3321,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * In case of error an ERR_PTR() is returned.
  */
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname)
+					 const char *propname, int index)
 {
 	struct gpio_desc *desc = ERR_PTR(-ENODEV);
 	bool active_low = false;
@@ -3333,8 +3334,8 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	if (is_of_node(fwnode)) {
 		enum of_gpio_flags flags;
 
-		desc = of_get_named_gpiod_flags(to_of_node(fwnode), propname, 0,
-						&flags);
+		desc = of_get_named_gpiod_flags(to_of_node(fwnode), propname,
+						index, &flags);
 		if (!IS_ERR(desc)) {
 			active_low = flags & OF_GPIO_ACTIVE_LOW;
 			single_ended = flags & OF_GPIO_SINGLE_ENDED;
@@ -3342,7 +3343,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	} else if (is_acpi_node(fwnode)) {
 		struct acpi_gpio_info info;
 
-		desc = acpi_node_get_gpiod(fwnode, propname, 0, &info);
+		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
 		if (!IS_ERR(desc))
 			active_low = info.polarity == GPIO_ACTIVE_LOW;
 	}
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 2ce4bc164735..5d1125198fd7 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -135,10 +135,11 @@ int desc_to_gpio(const struct gpio_desc *desc);
 struct fwnode_handle;
 
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname);
-struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
-						const char *con_id,
+					 const char *propname, int index);
+struct gpio_desc *devm_fwnode_get_index_gpiod_from_child(struct device *dev,
+						const char *con_id, int index,
 						struct fwnode_handle *child);
+
 #else /* CONFIG_GPIOLIB */
 
 static inline int gpiod_count(struct device *dev, const char *con_id)
@@ -412,19 +413,27 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
 struct fwnode_handle;
 
 static inline struct gpio_desc *fwnode_get_named_gpiod(
-	struct fwnode_handle *fwnode, const char *propname)
+	struct fwnode_handle *fwnode, const char *propname, int index)
 {
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline struct gpio_desc *devm_fwnode_get_gpiod_from_child(
-	struct device *dev, const char *con_id, struct fwnode_handle *child)
+static inline struct gpio_desc *devm_fwnode_get_index_gpiod_from_child(
+	struct device *dev, const char *con_id, int index,
+	struct fwnode_handle *child)
 {
 	return ERR_PTR(-ENOSYS);
 }
 
 #endif /* CONFIG_GPIOLIB */
 
+static inline struct gpio_desc *
+devm_fwnode_get_gpiod_from_child(struct device *dev, const char *con_id,
+				 struct fwnode_handle *child)
+{
+	return devm_fwnode_get_index_gpiod_from_child(dev, con_id, 0, child);
+}
+
 #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_GPIO_SYSFS)
 
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change);
-- 
2.7.4

