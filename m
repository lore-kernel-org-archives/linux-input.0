From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/PATCH 3/5] device property: export property_set structure
Date: Mon, 17 Sep 2018 11:16:01 -0700
Message-ID: <20180917181603.125492-4-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Future gpiolib will need to handle property sets properly, and this we
need to export property_set, is_pset_node() and to_pset_node().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/pset_property.c | 31 ++-----------------------------
 include/linux/property.h     | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
index 63f2377aefe8..7118528816a4 100644
--- a/drivers/base/pset_property.c
+++ b/drivers/base/pset_property.c
@@ -14,34 +14,6 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-struct property_set {
-	struct device *dev;
-	struct fwnode_handle fwnode;
-	const struct property_entry *properties;
-
-	struct property_set *parent;
-	/* Entry in parent->children list */
-	struct list_head child_node;
-	struct list_head children;
-};
-
-static const struct fwnode_operations pset_fwnode_ops;
-
-static inline bool is_pset_node(const struct fwnode_handle *fwnode)
-{
-	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
-}
-
-#define to_pset_node(__fwnode)						\
-	({								\
-		typeof(__fwnode) __to_pset_node_fwnode = __fwnode;	\
-									\
-		is_pset_node(__to_pset_node_fwnode) ?			\
-			container_of(__to_pset_node_fwnode,		\
-				     struct property_set, fwnode) :	\
-			NULL;						\
-	})
-
 static const struct property_entry *
 pset_prop_get(const struct property_set *pset, const char *name)
 {
@@ -323,13 +295,14 @@ pset_fwnode_get_next_subnode(const struct fwnode_handle *fwnode,
 	return &next->fwnode;
 }
 
-static const struct fwnode_operations pset_fwnode_ops = {
+const struct fwnode_operations pset_fwnode_ops = {
 	.property_present = pset_fwnode_property_present,
 	.property_read_int_array = pset_fwnode_read_int_array,
 	.property_read_string_array = pset_fwnode_property_read_string_array,
 	.get_parent = pset_fwnode_get_parent,
 	.get_next_child_node = pset_fwnode_get_next_subnode,
 };
+EXPORT_SYMBOL_GPL(pset_fwnode_ops);
 
 static void property_entry_free_data(const struct property_entry *p)
 {
diff --git a/include/linux/property.h b/include/linux/property.h
index bb1cf4f30770..957f75d10cf9 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -13,6 +13,7 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/err.h>
 #include <linux/fwnode.h>
 #include <linux/types.h>
 
@@ -281,6 +282,34 @@ device_add_child_properties(struct device *dev,
 			    const struct property_entry *properties);
 void device_remove_properties(struct device *dev);
 
+struct property_set {
+	struct device *dev;
+	struct fwnode_handle fwnode;
+	const struct property_entry *properties;
+
+	struct property_set *parent;
+	/* Entry in parent->children list */
+	struct list_head child_node;
+	struct list_head children;
+};
+
+extern const struct fwnode_operations pset_fwnode_ops;
+
+static inline bool is_pset_node(const struct fwnode_handle *fwnode)
+{
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
+}
+
+#define to_pset_node(__fwnode)						\
+	({								\
+		typeof(__fwnode) __to_pset_node_fwnode = __fwnode;	\
+									\
+		is_pset_node(__to_pset_node_fwnode) ?			\
+			container_of(__to_pset_node_fwnode,		\
+				     struct property_set, fwnode) :	\
+			NULL;						\
+	})
+
 bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
-- 
2.19.0.397.gdd90340f6a-goog
