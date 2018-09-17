From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [RFC/PATCH 2/5] device property: introduce notion of subnodes for legacy boards
Date: Mon, 17 Sep 2018 11:16:00 -0700
Message-ID: <20180917181603.125492-3-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Several drivers rely on having notion of sub-nodes when describing
hardware, let's allow static board-defined properties also have it.

The board files will then attach properties to devices in the following
fashion:

	device_add_properties(&board_platform_device.dev,
			      main_device_props);
	device_add_child_properties(&board_platform_device.dev,
				    dev_fwnode(&board_platform_device.dev),
				    child1_device_props);
	device_add_child_properties(&board_platform_device.dev,
				    dev_fwnode(&board_platform_device.dev),
				    child2_device_props);
	...
	platform_device_register(&board_platform_device.dev);

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/pset_property.c | 110 +++++++++++++++++++++++++++++++----
 include/linux/property.h     |   4 ++
 2 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
index 08ecc13080ae..63f2377aefe8 100644
--- a/drivers/base/pset_property.c
+++ b/drivers/base/pset_property.c
@@ -18,6 +18,11 @@ struct property_set {
 	struct device *dev;
 	struct fwnode_handle fwnode;
 	const struct property_entry *properties;
+
+	struct property_set *parent;
+	/* Entry in parent->children list */
+	struct list_head child_node;
+	struct list_head children;
 };
 
 static const struct fwnode_operations pset_fwnode_ops;
@@ -283,10 +288,47 @@ pset_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 					   val, nval);
 }
 
+struct fwnode_handle *pset_fwnode_get_parent(const struct fwnode_handle *fwnode)
+{
+	struct property_set *pset = to_pset_node(fwnode);
+
+	return pset ? &pset->parent->fwnode : NULL;
+}
+
+struct fwnode_handle *
+pset_fwnode_get_next_subnode(const struct fwnode_handle *fwnode,
+			     struct fwnode_handle *child)
+{
+	const struct property_set *pset = to_pset_node(fwnode);
+	struct property_set *first_child;
+	struct property_set *next;
+
+	if (!pset)
+		return NULL;
+
+	if (list_empty(&pset->children))
+		return NULL;
+
+	first_child = list_first_entry(&pset->children, struct property_set,
+				       child_node);
+
+	if (child) {
+		next = list_next_entry(to_pset_node(child), child_node);
+		if (next == first_child)
+			return NULL;
+	} else {
+		next = first_child;
+	}
+
+	return &next->fwnode;
+}
+
 static const struct fwnode_operations pset_fwnode_ops = {
 	.property_present = pset_fwnode_property_present,
 	.property_read_int_array = pset_fwnode_read_int_array,
 	.property_read_string_array = pset_fwnode_property_read_string_array,
+	.get_parent = pset_fwnode_get_parent,
+	.get_next_child_node = pset_fwnode_get_next_subnode,
 };
 
 static void property_entry_free_data(const struct property_entry *p)
@@ -439,24 +481,31 @@ EXPORT_SYMBOL_GPL(property_entries_free);
  */
 static void pset_free_set(struct property_set *pset)
 {
+	struct property_set *child, *next;
+
 	if (!pset)
 		return;
 
+	list_for_each_entry_safe(child, next, &pset->children, child_node) {
+		list_del(&child->child_node);
+		pset_free_set(child);
+	}
+
 	property_entries_free(pset->properties);
 	kfree(pset);
 }
 
 /**
- * pset_copy_set - copies property set
- * @pset: Property set to copy
+ * pset_create_set - creates property set.
+ * @src: property entries for the set.
  *
- * This function takes a deep copy of the given property set and returns
- * pointer to the copy. Call device_free_property_set() to free resources
- * allocated in this function.
+ * This function takes a deep copy of the given property entries and creates
+ * property set. Call pset_free_set() to free resources allocated in this
+ * function.
  *
  * Return: Pointer to the new property set or error pointer.
  */
-static struct property_set *pset_copy_set(const struct property_set *pset)
+static struct property_set *pset_create_set(const struct property_entry *src)
 {
 	struct property_entry *properties;
 	struct property_set *p;
@@ -465,7 +514,11 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-	properties = property_entries_dup(pset->properties);
+	INIT_LIST_HEAD(&p->child_node);
+	INIT_LIST_HEAD(&p->children);
+	p->fwnode.ops = &pset_fwnode_ops;
+
+	properties = property_entries_dup(src);
 	if (IS_ERR(properties)) {
 		kfree(p);
 		return ERR_CAST(properties);
@@ -521,20 +574,53 @@ EXPORT_SYMBOL_GPL(device_remove_properties);
 int device_add_properties(struct device *dev,
 			  const struct property_entry *properties)
 {
-	struct property_set *p, pset;
+	struct property_set *p;
 
 	if (!properties)
 		return -EINVAL;
 
-	pset.properties = properties;
-
-	p = pset_copy_set(&pset);
+	p = pset_create_set(properties);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
 
-	p->fwnode.ops = &pset_fwnode_ops;
 	set_secondary_fwnode(dev, &p->fwnode);
 	p->dev = dev;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(device_add_properties);
+
+/**
+ * device_add_child_properties - Add a collection of properties to a device object.
+ * @dev: Device to add properties to.
+ * @properties: Collection of properties to add.
+ *
+ * Associate a collection of device properties represented by @properties as a
+ * child of given @parent firmware node.  The function takes a copy of
+ * @properties.
+ */
+struct fwnode_handle *
+device_add_child_properties(struct device *dev,
+			    struct fwnode_handle *parent,
+			    const struct property_entry *properties)
+{
+	struct property_set *p;
+	struct property_set *parent_pset;
+
+	if (!properties)
+		return ERR_PTR(-EINVAL);
+
+	parent_pset = to_pset_node(parent);
+	if (!parent_pset)
+		return ERR_PTR(-EINVAL);
+
+	p = pset_create_set(properties);
+	if (IS_ERR(p))
+		return ERR_CAST(p);
+
+	p->dev = dev;
+	p->parent = parent_pset;
+	list_add_tail(&p->child_node, &parent_pset->children);
+
+	return &p->fwnode;
+}
+EXPORT_SYMBOL_GPL(device_add_child_properties);
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..bb1cf4f30770 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -275,6 +275,10 @@ void property_entries_free(const struct property_entry *properties);
 
 int device_add_properties(struct device *dev,
 			  const struct property_entry *properties);
+struct fwnode_handle *
+device_add_child_properties(struct device *dev,
+			    struct fwnode_handle *parent,
+			    const struct property_entry *properties);
 void device_remove_properties(struct device *dev);
 
 bool device_dma_supported(struct device *dev);
-- 
2.19.0.397.gdd90340f6a-goog
