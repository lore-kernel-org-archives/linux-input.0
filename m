From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/PATCH 4/5] gpiolib: add support for fetching descriptors from static properties
Date: Mon, 17 Sep 2018 11:16:02 -0700
Message-ID: <20180917181603.125492-5-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpiolib.c | 109 +++++++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e11a3bb03820..f0e51d34a1c1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3959,39 +3959,44 @@ struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
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
+static struct gpio_desc *pset_node_get_gpiod(struct fwnode_handle *fwnode,
+					     const char *propname, int index,
+					     enum gpio_lookup_flags *flags)
 {
-	struct gpio_desc *desc = ERR_PTR(-ENODEV);
-	unsigned long lflags = 0;
-	int ret;
+	struct property_set *pset;
+	const char *con_id;
 
-	if (!fwnode)
+	pset = to_pset_node(fwnode);
+	if (!pset)
 		return ERR_PTR(-EINVAL);
 
+	if (fwnode_property_read_string(fwnode, propname, &con_id)) {
+		/*
+		 * We could not find string mapping property name to
+		 * entry in gpio lookup table. Let's see if we are
+		 * dealing with firmware node corresponding to the
+		 * device (and not a child node): for such nodes we can
+		 * try doing lookup directly with property name.
+		 */
+		if (pset->parent)
+			return ERR_PTR(-ENOENT);
+
+		con_id = propname;
+	}
+
+	return gpiod_find(pset->dev, con_id, index, flags);
+}
+
+static struct gpio_desc *__fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
+						  const char *propname,
+						  int index,
+						  enum gpiod_flags dflags,
+						  const char *label)
+{
+	struct gpio_desc *desc = ERR_PTR(-ENODEV);
+	enum gpio_lookup_flags lflags = 0;
+	int ret;
+
 	if (is_of_node(fwnode)) {
 		desc = gpiod_get_from_of_node(to_of_node(fwnode),
 					      propname, index,
@@ -4009,9 +4014,12 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
 		if (info.polarity == GPIO_ACTIVE_LOW)
 			lflags |= GPIO_ACTIVE_LOW;
+	} else if (is_pset_node(fwnode)) {
+		desc = pset_node_get_gpiod(fwnode, propname, index, &lflags);
+		if (IS_ERR(desc))
+			return desc;
 	}
 
-	/* Currently only ACPI takes this path */
 	ret = gpiod_request(desc, label);
 	if (ret)
 		return ERR_PTR(ret);
@@ -4024,6 +4032,47 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
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
2.19.0.397.gdd90340f6a-goog
