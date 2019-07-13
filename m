From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] gpiolib: add support for fetching descriptors from static properties
Date: Sat, 13 Jul 2019 00:52:59 -0700
Message-ID: <20190713075259.243565-3-dmitry.torokhov@gmail.com>
References: <20190713075259.243565-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190713075259.243565-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Now that static device properties understand notion of child nodes, let's
teach gpiolib to tie such children and machine GPIO descriptor tables.
We will continue using a single table for entire device, but instead of
using connection ID as a lookup key in the GPIO descriptor table directly,
we will perform additional translation: fwnode_get_named_gpiod() when
dealing with property_set-backed fwnodes will try parsing string property
with name matching connection ID and use result of the lookup as the key in
the table:

static const struct property_entry dev_child1_props[] __initconst = {
	...
	PROPERTY_ENTRY_STRING("gpios",		"child-1-gpios"),
	{ }
};

static struct gpiod_lookup_table dev_gpiod_table = {
	.dev_id = "some-device",
	.table = {
		...
		GPIO_LOOKUP_IDX("B", 1, "child-1-gpios", 1, GPIO_ACTIVE_LOW),
		...
	},
};

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib.c | 108 ++++++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e013d417a936..b6574febe2b8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4307,39 +4307,44 @@ struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
 }
 EXPORT_SYMBOL(gpiod_get_from_of_node);
 
-/**
- * fwnode_get_named_gpiod - obtain a GPIO from firmware node
- * @fwnode:	handle of the firmware node
- * @propname:	name of the firmware property representing the GPIO
- * @index:	index of the GPIO to obtain for the consumer
- * @dflags:	GPIO initialization flags
- * @label:	label to attach to the requested GPIO
- *
- * This function can be used for drivers that get their configuration
- * from opaque firmware.
- *
- * The function properly finds the corresponding GPIO using whatever is the
- * underlying firmware interface and then makes sure that the GPIO
- * descriptor is requested before it is returned to the caller.
- *
- * Returns:
- * On successful request the GPIO pin is configured in accordance with
- * provided @dflags.
- *
- * In case of error an ERR_PTR() is returned.
- */
-struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label)
+static struct gpio_desc *
+software_node_get_gpiod(struct fwnode_handle *fwnode,
+			const char *propname, int index, unsigned long *flags)
+{
+	struct device *dev;
+	const char *con_id;
+
+	dev = software_node_get_linked_device(fwnode);
+	if (IS_ERR_OR_NULL(dev))
+		return ERR_PTR(-EINVAL);
+
+	if (fwnode_property_read_string(fwnode, propname, &con_id)) {
+		/*
+		 * We could not find string mapping property name to
+		 * entry in gpio lookup table. Let's see if we are
+		 * dealing with firmware node corresponding to the
+		 * device (and not a child node): for such nodes we can
+		 * try doing lookup directly with property name.
+		 */
+		if (fwnode_get_parent(fwnode))
+			return ERR_PTR(-ENOENT);
+
+		con_id = propname;
+	}
+
+	return gpiod_find(dev, con_id, index, flags);
+}
+
+static struct gpio_desc *__fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
+						  const char *propname,
+						  int index,
+						  enum gpiod_flags dflags,
+						  const char *label)
 {
 	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
 	struct gpio_desc *desc = ERR_PTR(-ENODEV);
 	int ret;
 
-	if (!fwnode)
-		return ERR_PTR(-EINVAL);
-
 	if (is_of_node(fwnode)) {
 		desc = gpiod_get_from_of_node(to_of_node(fwnode),
 					      propname, index,
@@ -4355,9 +4360,13 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
 		acpi_gpio_update_gpiod_flags(&dflags, &info);
 		acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
+	} else if (is_software_node(fwnode)) {
+		desc = software_node_get_gpiod(fwnode, propname, index,
+					       &lflags);
+		if (IS_ERR(desc))
+			return desc;
 	}
 
-	/* Currently only ACPI takes this path */
 	ret = gpiod_request(desc, label);
 	if (ret)
 		return ERR_PTR(ret);
@@ -4370,6 +4379,47 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
 	return desc;
 }
+
+/**
+ * fwnode_get_named_gpiod - obtain a GPIO from firmware node
+ * @fwnode:	handle of the firmware node
+ * @propname:	name of the firmware property representing the GPIO
+ * @index:	index of the GPIO to obtain for the consumer
+ * @dflags:	GPIO initialization flags
+ * @label:	label to attach to the requested GPIO
+ *
+ * This function can be used for drivers that get their configuration
+ * from opaque firmware.
+ *
+ * The function properly finds the corresponding GPIO using whatever is the
+ * underlying firmware interface and then makes sure that the GPIO
+ * descriptor is requested before it is returned to the caller.
+ *
+ * Returns:
+ * On successful request the GPIO pin is configured in accordance with
+ * provided @dflags.
+ *
+ * In case of error an ERR_PTR() is returned.
+ */
+struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label)
+{
+	struct gpio_desc *desc;
+
+	if (!fwnode)
+		return ERR_PTR(-EINVAL);
+
+	desc = __fwnode_get_named_gpiod(fwnode, propname, index, dflags, label);
+	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT &&
+	    !IS_ERR_OR_NULL(fwnode->secondary)) {
+		desc = __fwnode_get_named_gpiod(fwnode->secondary,
+						propname, index, dflags, label);
+	}
+
+	return desc;
+}
 EXPORT_SYMBOL_GPL(fwnode_get_named_gpiod);
 
 /**
-- 
2.22.0.510.g264f2c817a-goog
