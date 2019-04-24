From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/5] of/device: Add of_ functions for device_link_{add,remove}
Date: Wed, 24 Apr 2019 12:19:09 +0200
Message-ID: <20190424101913.1534-2-benjamin.gaignard@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424101913.1534-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com, m.felsch@pengutronix.de, agx@sigxcpu.org, yannick.fertre@st.com, arnd@arndb.de
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-input@vger.kernel.org

Allows to create and remove links between consumer and suppliers from 
device-tree data. Use 'links-add' property from consumer node to setup
a link with a list of suppliers.
Consumers will be suspend before their suppliers and resume after them.

Add devm_of_device_links_add() to automatically remove the links
when the device is unbound from the bus.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/of/device.c       | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_device.h |  20 +++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3717f2a20d0d..011ba9bf7642 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -336,3 +336,106 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
+
+/**
+ * of_device_links_add - Create links between consumer and suppliers from
+ * device tree data
+ *
+ * @consumer: consumer device
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+int of_device_links_add(struct device *consumer)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	int i = 0;
+
+	np = of_parse_phandle(consumer->of_node, "links-add", i++);
+	while (np) {
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!pdev)
+			return -EINVAL;
+
+		device_link_add(consumer, &pdev->dev, DL_FLAG_STATELESS);
+		platform_device_put(pdev);
+
+		np = of_parse_phandle(consumer->of_node, "links-add", i++);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_device_links_add);
+
+/**
+ * of_device_links_remove - Remove links between consumer and suppliers from
+ * device tree data
+ *
+ * @consumer: consumer device
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+int of_device_links_remove(struct device *consumer)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	int i = 0;
+
+	np = of_parse_phandle(consumer->of_node, "links-add", i++);
+	while (np) {
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!pdev)
+			return -EINVAL;
+
+		device_link_remove(consumer, &pdev->dev);
+		platform_device_put(pdev);
+
+		np = of_parse_phandle(consumer->of_node, "links-add", i++);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_device_links_remove);
+
+static void devm_of_device_links_remove(struct device *dev, void *res)
+{
+	of_device_links_remove(*(struct device **)res);
+}
+
+/**
+ * devm_of_device_links_add - Create links between consumer and suppliers
+ * from device tree data
+ *
+ * @consumer: consumer device
+ *
+ * Returns 0 on success, < 0 on failure.
+ *
+ * Similar to of_device_links_add(), but will automatically call
+ * of_device_links_remove() when the device is unbound from the bus.
+ */
+int devm_of_device_links_add(struct device *consumer)
+{
+		struct device **ptr;
+	int ret;
+
+	if (!consumer)
+		return -EINVAL;
+
+	ptr = devres_alloc(devm_of_device_links_remove,
+			   sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = of_device_links_add(consumer);
+	if (ret < 0) {
+		devres_free(ptr);
+	} else {
+		*ptr = consumer;
+		devres_add(consumer, ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_device_links_add);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8d31e39dd564..ad01db6828e8 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -41,6 +41,11 @@ extern int of_device_request_module(struct device *dev);
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
 
+
+extern int of_device_links_add(struct device *consumer);
+extern int of_device_links_remove(struct device *consumer);
+extern int devm_of_device_links_add(struct device *consumer);
+
 static inline void of_device_node_put(struct device *dev)
 {
 	of_node_put(dev->of_node);
@@ -91,6 +96,21 @@ static inline int of_device_uevent_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static int of_device_links_add(struct device *consumer)
+{
+	return 0;
+}
+
+static int of_device_links_remove(struct device *consumer)
+{
+	return 0;
+}
+
+static int devm_of_device_links_add(struct device *consumer)
+{
+	return 0;
+}
+
 static inline void of_device_node_put(struct device *dev) { }
 
 static inline const struct of_device_id *__of_match_device(
-- 
2.15.0
