From: Nick Crews <ncrews@chromium.org>
Subject: [PATCH v4 9/9] platform/chrome: Add binary telemetry attributes
Date: Wed, 23 Jan 2019 11:33:25 -0700
Message-ID: <20190123183325.92946-10-ncrews@chromium.org>
References: <20190123183325.92946-1-ncrews@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123183325.92946-1-ncrews@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: sjg@chromium.org, dmitry.torokhov@gmail.com, sre@kernel.org, linux-input@vger.kernel.org, groeck@chromium.org, dlaurie@chromium.org, Nick Crews <ncrews@google.com>, Nick Crews <ncrews@chromium.org>, Duncan Laurie <dlaurie@google.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Benson Leung <bleung@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Nick Crews <ncrews@google.com>

The Wilco Embedded Controller is able to send telemetry data
which is useful for enterprise applications. A daemon running on
the OS sends a command (possibly with args) to the EC via
this sysfs interface, and the EC responds over the sysfs interface
with the response. Both the request and the response are in an opaque
binary format so that information which is proprietary to the
enterprise service provider is secure.

At this point, the Wilco EC does not implement this telemetry
functionality, so any request using the WILCO_EC_MSG_TELEMETRY
command returns an error. This is just an initial change for
comments, until the EC code is implemented.

Signed-off-by: Nick Crews <ncrews@google.com>
Signed-off-by: Nick Crews <ncrews@chromium.org>
---

Changes in v4: None
Changes in v3:
- add err check on returned data size
- add check on read request offset and size

Changes in v2: None

 drivers/platform/chrome/wilco_ec/Makefile    |  3 +-
 drivers/platform/chrome/wilco_ec/sysfs.c     |  7 ++
 drivers/platform/chrome/wilco_ec/telemetry.c | 73 ++++++++++++++++++++
 drivers/platform/chrome/wilco_ec/telemetry.h | 41 +++++++++++
 4 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.h

diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 7be99a5bfb02..26e740c1d3d4 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 wilco_ec-objs				:= core.o mailbox.o sysfs.o legacy.o \
-					   event.o properties.o adv_power.o
+					   event.o properties.o adv_power.o \
+					   telemetry.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 83de0daef265..f01d782b4c96 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -17,6 +17,7 @@
 #include "legacy.h"
 #include "properties.h"
 #include "adv_power.h"
+#include "telemetry.h"
 
 #define WILCO_EC_ATTR_RO(_name)						\
 __ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
@@ -42,8 +43,14 @@ static struct attribute *wilco_ec_toplevel_attrs[] = {
 	&stealth_attr.attr,
 	NULL
 };
+static struct bin_attribute telem_attr = TELEMETRY_BIN_ATTR(telemetry);
+static struct bin_attribute *telem_attrs[] = {
+	&telem_attr,
+	NULL
+};
 static const struct attribute_group wilco_ec_toplevel_group = {
 	.attrs = wilco_ec_toplevel_attrs,
+	.bin_attrs = telem_attrs,
 };
 static const struct attribute_group *wilco_ec_toplevel_groups[] = {
 	&wilco_ec_toplevel_group,
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
new file mode 100644
index 000000000000..b577a22654cf
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Telemetry sysfs attributes for Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ *
+ * The Wilco Embedded Controller is able to send telemetry data
+ * which is useful for enterprise applications. A daemon running on
+ * the OS sends a command (possibly with args) to the EC via
+ * this sysfs interface, and the EC responds over the sysfs interface
+ * with the response. Both the request and the response are in an opaque
+ * binary format so that information which is proprietary to the
+ * enterprise service provider is secure.
+ */
+
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include "util.h"
+
+/* Data buffer for holding EC's response for telemtry data */
+static u8 telemetry_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
+
+ssize_t wilco_ec_telem_write(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *attr, char *buf, loff_t loff,
+			     size_t count)
+{
+	struct wilco_ec_message msg;
+	int ret;
+	struct device *dev = device_from_kobject(kobj);
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+
+	if (count < 1 || count > EC_MAILBOX_DATA_SIZE_EXTENDED)
+		return -EINVAL;
+
+	/* Clear response data buffer */
+	memset(telemetry_data, 0, EC_MAILBOX_DATA_SIZE_EXTENDED);
+
+	msg.type = WILCO_EC_MSG_TELEMETRY;
+	msg.flags = WILCO_EC_FLAG_RAW | WILCO_EC_FLAG_EXTENDED_DATA;
+	msg.command = buf[0];
+	msg.request_data = buf + 1;
+	msg.request_size = EC_MAILBOX_DATA_SIZE;
+	msg.response_data = &telemetry_data;
+	msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
+
+	/* Send the requested command + data as raw transaction */
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+	if (ret != EC_MAILBOX_DATA_SIZE_EXTENDED)
+		return -EBADMSG;
+
+	return count;
+}
+
+ssize_t wilco_ec_telem_read(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *attr, char *buf, loff_t off,
+			    size_t count)
+{
+	if (off)
+		return -EINVAL;
+	if (count != EC_MAILBOX_DATA_SIZE_EXTENDED)
+		return -EINVAL;
+
+	memcpy(buf, telemetry_data, count);
+
+	return count;
+}
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.h b/drivers/platform/chrome/wilco_ec/telemetry.h
new file mode 100644
index 000000000000..d68cc067b97a
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/telemetry.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Telemetry sysfs attributes for Wilco EC
+ *
+ * Copyright 2018 Google LLC
+ *
+ * The Wilco Embedded Controller is able to send telemetry data
+ * which is useful for enterprise applications. A daemon running on
+ * the OS sends a command (possibly with args) to the EC via
+ * this sysfs interface, and the EC responds over the sysfs interface
+ * with the response. Both the request and the response are in an opaque
+ * binary format so that information which is proprietary to the
+ * enterprise service provider is secure.
+ */
+
+#ifndef WILCO_EC_TELEMETRY_H
+#define WILCO_EC_TELEMETRY_H
+
+#include <linux/fs.h>
+#include <linux/kobject.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+ssize_t wilco_ec_telem_write(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *attr, char *buf, loff_t loff,
+			     size_t count);
+
+ssize_t wilco_ec_telem_read(struct file *filp, struct kobject *kobj,
+			    struct bin_attribute *attr, char *buf, loff_t off,
+			    size_t count);
+
+#define TELEMETRY_BIN_ATTR(_name) {					\
+	.attr = {.name = __stringify(_name),				\
+		 .mode = VERIFY_OCTAL_PERMISSIONS(0644) },		\
+	.size = EC_MAILBOX_DATA_SIZE_EXTENDED,				\
+	.read = wilco_ec_telem_read,					\
+	.write = wilco_ec_telem_write,					\
+}
+
+#endif /* WILCO_EC_TELEMETRY_H */
-- 
2.20.1.321.g9e740568ce-goog
