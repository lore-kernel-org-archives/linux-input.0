From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 1/5] of/device: Add of_device_link_add function
Date: Wed, 15 May 2019 15:11:50 +0200
Message-ID: <20190515131154.18373-2-benjamin.gaignard@st.com>
References: <20190515131154.18373-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515131154.18373-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, hadess@hadess.net, frowand.list@gmail.com, m.felsch@pengutronix.de, agx@sigxcpu.org, arnd@arndb.de
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-input@vger.kernel.org

Use 'suspend-dependencies' property from device node to ensure that
the listed devices will suspended after it and resumed before it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
version 2:
- only keep of_device_links_add() and use 
  DL_FLAG_PM_RUNTIME and DL_FLAG_AUTOREMOVE_CONSUMER flags to follow Rafael
  advices
- reword function description
- try to use a more explicit property name
  
 drivers/of/device.c       | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/of_device.h |  7 +++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3717f2a20d0d..44ec84eee310 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -336,3 +336,40 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
+
+/**
+ * of_device_links_add - Create links between a consumer device
+ * and it listed dependencies from device tree data
+ *
+ * @consumer: consumer device
+ *
+ * Ensure that consumer's dependencies will be suspended after it
+ * and resumed before it.
+ *
+ * Returns 0 on success, < 0 on failure.
+ */
+int of_device_links_add(struct device *consumer)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	int i = 0;
+
+	np = of_parse_phandle(consumer->of_node, "suspend-dependencies", i++);
+	while (np) {
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!pdev)
+			return -EINVAL;
+
+		device_link_add(consumer, &pdev->dev,
+				DL_FLAG_PM_RUNTIME |
+				DL_FLAG_AUTOREMOVE_CONSUMER);
+		platform_device_put(pdev);
+
+		np = of_parse_phandle(consumer->of_node, "suspend-dependencies",
+				      i++);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_device_links_add);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8d31e39dd564..83f24c386d51 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -41,6 +41,8 @@ extern int of_device_request_module(struct device *dev);
 extern void of_device_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env);
 
+extern int of_device_links_add(struct device *consumer);
+
 static inline void of_device_node_put(struct device *dev)
 {
 	of_node_put(dev->of_node);
@@ -91,6 +93,11 @@ static inline int of_device_uevent_modalias(struct device *dev,
 	return -ENODEV;
 }
 
+static int of_device_links_add(struct device *consumer)
+{
+	return 0;
+}
+
 static inline void of_device_node_put(struct device *dev) { }
 
 static inline const struct of_device_id *__of_match_device(
-- 
2.15.0
