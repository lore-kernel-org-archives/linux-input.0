From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 09/14] iio: inkern: triggers: create helpers for OF trigger retrieval
Date: Fri, 22 Dec 2017 17:07:16 +0200
Message-ID: <1513955241-10985-10-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Create helper API to get trigger information from OF regarding
trigger producer/consumer for iio triggers.
The functions will search for matching trigger by name, similar
with channel retrieval

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/inkern.c                 | 91 ++++++++++++++++++++++++++++++++++++
 include/linux/iio/trigger_consumer.h |  1 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 069defc..58bd18d 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -14,9 +14,13 @@
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
+#include "iio_core_trigger.h"
 #include <linux/iio/machine.h>
 #include <linux/iio/driver.h>
 #include <linux/iio/consumer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+
 
 struct iio_map_internal {
 	struct iio_dev *indio_dev;
@@ -262,6 +266,39 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 	return ERR_PTR(ret);
 }
 
+#ifdef CONFIG_IIO_TRIGGER
+
+static struct iio_trigger *of_iio_trigger_get(struct device_node *np, int index)
+{
+	struct device *idev;
+	struct iio_dev *indio_dev;
+	int err;
+	struct of_phandle_args iiospec;
+	struct iio_trigger *trig;
+
+	err = of_parse_phandle_with_args(np, "io-triggers",
+					 "#io-trigger-cells",
+					 index, &iiospec);
+	if (err)
+		return ERR_PTR(err);
+
+	idev = bus_find_device(&iio_bus_type, NULL, iiospec.np,
+			       iio_dev_node_match);
+	of_node_put(iiospec.np);
+	if (!idev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	indio_dev = dev_to_iio_dev(idev);
+
+	trig = iio_trigger_find_from_device(indio_dev, iiospec.args[0]);
+
+	if (!trig)
+		return ERR_PTR(-ENODEV);
+
+	return trig;
+}
+#endif /* CONFIG_IIO_TRIGGER */
+
 #else /* CONFIG_OF */
 
 static inline struct iio_channel *
@@ -275,6 +312,12 @@ static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
 	return NULL;
 }
 
+static inline struct iio_trigger *of_iio_trigger_get(struct device_node *np,
+						     int index)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_OF */
 
 static struct iio_channel *iio_channel_get_sys(const char *name,
@@ -927,3 +970,51 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
 			       chan->channel, buf, len);
 }
 EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
+
+#ifdef CONFIG_IIO_TRIGGER
+struct iio_trigger *iio_trigger_find(struct device *dev, char *name)
+{
+	struct device_node *np = dev->of_node;
+	struct iio_trigger *trig = NULL;
+
+	/* Walk up the tree of devices looking for a matching iio trigger */
+	while (np) {
+		int index = 0;
+
+		/*
+		 * For named iio triggers, first look up the name in the
+		 * "io-trigger-names" property.  If it cannot be found, the
+		 * index will be an error code, and of_iio_trigger_get()
+		 * will fail.
+		 */
+		if (name)
+			index = of_property_match_string(np, "io-trigger-names",
+							 name);
+		trig = of_iio_trigger_get(np, index);
+		if (!IS_ERR(trig) || PTR_ERR(trig) == -EPROBE_DEFER) {
+			break;
+		} else if (name && index >= 0) {
+			pr_err("ERROR: could not get IIO trigger %pOF:%s(%i)\n",
+			       np, name ? name : "", index);
+			return trig;
+		}
+
+		/*
+		 * No matching IIO trigger found on this node.
+		 * If the parent node has a "io-trigger-ranges" property,
+		 * then we can try one of its channels.
+		 */
+		np = np->parent;
+		if (np && !of_get_property(np, "io-trigger-ranges", NULL))
+			return trig;
+	}
+
+	if (!trig || (IS_ERR(trig) && PTR_ERR(trig) != -EPROBE_DEFER))
+		dev_dbg(dev, "error retrieving trigger information\n");
+	else
+		dev_dbg(dev, "trigger found: %s\n", name);
+
+	return trig;
+}
+EXPORT_SYMBOL_GPL(iio_trigger_find);
+#endif /* CONFIG_IIO_TRIGGER */
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index 13be595..b2fc485 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -62,6 +62,7 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p);
 
 void iio_trigger_notify_done(struct iio_trigger *trig);
 
+struct iio_trigger *iio_trigger_find(struct device *dev, char *name);
 /*
  * Two functions for common case where all that happens is a pollfunc
  * is attached and detached from a trigger
-- 
2.7.4
