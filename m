From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] drivers: base: swnode: link devices to software nodes
Date: Sat, 13 Jul 2019 00:52:58 -0700
Message-ID: <20190713075259.243565-2-dmitry.torokhov@gmail.com>
References: <20190713075259.243565-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190713075259.243565-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-input@vger.kernel.org

It is helpful to know what device, if any, a software node is tied to, so
let's store a pointer to the device in software node structure. Note that
children software nodes will inherit their parent's device pointer, so we
do not have to traverse hierarchy to see what device the [sub]tree belongs
to.

We will be using the device pointer to locate GPIO lookup tables for
devices with static properties.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/property.c  |  1 +
 drivers/base/swnode.c    | 35 ++++++++++++++++++++++++++++++++++-
 include/linux/property.h |  5 +++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 348b37e64944..3bc93d4b35c4 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -527,6 +527,7 @@ int device_add_properties(struct device *dev,
 	if (IS_ERR(fwnode))
 		return PTR_ERR(fwnode);
 
+	software_node_link_device(fwnode, dev);
 	set_secondary_fwnode(dev, fwnode);
 	return 0;
 }
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 7fc5a18e02ad..fd12eea539b6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -24,6 +24,9 @@ struct software_node {
 
 	/* properties */
 	const struct property_entry *properties;
+
+	/* device this node is associated with */
+	struct device *dev;
 };
 
 static DEFINE_IDA(swnode_root_ids);
@@ -607,8 +610,14 @@ fwnode_create_software_node(const struct property_entry *properties,
 	INIT_LIST_HEAD(&swnode->children);
 	swnode->parent = p;
 
-	if (p)
+	if (p) {
 		list_add_tail(&swnode->entry, &p->children);
+		/*
+		 * We want to maintain the same association as the parent node,
+		 * so we can easily locate corresponding device.
+		 */
+		swnode->dev = p->dev;
+	}
 
 	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
 				   p ? &p->kobj : NULL, "node%d", swnode->id);
@@ -639,6 +648,30 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
 
+int software_node_link_device(struct fwnode_handle *fwnode, struct device *dev)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+
+	if (!swnode)
+		return -EINVAL;
+
+	swnode->dev = dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(software_node_link_device);
+
+struct device *
+software_node_get_linked_device(const struct fwnode_handle *fwnode)
+{
+	const struct software_node *swnode = to_software_node(fwnode);
+
+	if (!swnode)
+		return ERR_PTR(-EINVAL);
+
+	return swnode->dev;
+}
+EXPORT_SYMBOL_GPL(software_node_get_linked_device);
+
 int software_node_notify(struct device *dev, unsigned long action)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
diff --git a/include/linux/property.h b/include/linux/property.h
index e9caa290cda5..754188cfd9db 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -338,4 +338,9 @@ fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);
 void fwnode_remove_software_node(struct fwnode_handle *fwnode);
 
+int software_node_link_device(struct fwnode_handle *fwnode,
+			      struct device *device);
+struct device *
+software_node_get_linked_device(const struct fwnode_handle *fwnode);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.22.0.510.g264f2c817a-goog
