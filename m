From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 02/10] HID: intel-ish-hid: Hide members of struct ishtp_cl_device
Date: Mon, 18 Mar 2019 12:14:20 -0700
Message-ID: <20190318191428.6527-3-srinivas.pandruvada@linux.intel.com>
References: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

ISH clients don't need to access any field of struct ishtp_cl_device. To
avoid this create an interface functions instead where it is required.
In the case of ishtp_cl_allocate(), modify the parameters so that the
clients don't have to dereference.
Clients can also use tracing, here a new interface is added to get the
common trace function pointer, instead of direct call.
The new interface functions defined in one external header file, named
intel-ish-client-if.h. This is the only header files all ISHTP clients
must include.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 56 +++++++++++---------
 drivers/hid/intel-ish-hid/ishtp-hid.c        |  4 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h        |  2 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c        | 27 ++++++++++
 drivers/hid/intel-ish-hid/ishtp/client.c     |  4 +-
 drivers/hid/intel-ish-hid/ishtp/client.h     |  2 +-
 include/linux/intel-ish-client-if.h          | 18 +++++++
 7 files changed, 84 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/intel-ish-client-if.h

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index b86290611a5f..17d5bd4f52c1 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -15,6 +15,7 @@
 
 #include <linux/module.h>
 #include <linux/hid.h>
+#include <linux/intel-ish-client-if.h>
 #include <linux/sched.h>
 #include "ishtp/ishtp-dev.h"
 #include "ishtp/client.h"
@@ -24,6 +25,8 @@
 #define HID_CL_RX_RING_SIZE	32
 #define HID_CL_TX_RING_SIZE	16
 
+#define cl_data_to_dev(client_data) ishtp_device(client_data->cl_device)
+
 /**
  * report_bad_packets() - Report bad packets
  * @hid_ishtp_cl:	Client instance to get stats
@@ -39,7 +42,7 @@ static void report_bad_packet(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 	struct hostif_msg *recv_msg = recv_buf;
 	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
 
-	dev_err(&client_data->cl_device->dev, "[hid-ish]: BAD packet %02X\n"
+	dev_err(cl_data_to_dev(client_data), "[hid-ish]: BAD packet %02X\n"
 		"total_bad=%u cur_pos=%u\n"
 		"[%02X %02X %02X %02X]\n"
 		"payload_len=%u\n"
@@ -85,7 +88,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 
 	do {
 		if (cur_pos + sizeof(struct hostif_msg) > total_len) {
-			dev_err(&client_data->cl_device->dev,
+			dev_err(cl_data_to_dev(client_data),
 				"[hid-ish]: error, received %u which is less than data header %u\n",
 				(unsigned int)data_len,
 				(unsigned int)sizeof(struct hostif_msg_hdr));
@@ -124,12 +127,12 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			client_data->hid_dev_count = (unsigned int)*payload;
 			if (!client_data->hid_devices)
 				client_data->hid_devices = devm_kcalloc(
-						&client_data->cl_device->dev,
+						cl_data_to_dev(client_data),
 						client_data->hid_dev_count,
 						sizeof(struct device_info),
 						GFP_KERNEL);
 			if (!client_data->hid_devices) {
-				dev_err(&client_data->cl_device->dev,
+				dev_err(cl_data_to_dev(client_data),
 				"Mem alloc failed for hid device info\n");
 				wake_up_interruptible(&client_data->init_wait);
 				break;
@@ -137,7 +140,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			for (i = 0; i < client_data->hid_dev_count; ++i) {
 				if (1 + sizeof(struct device_info) * i >=
 						payload_len) {
-					dev_err(&client_data->cl_device->dev,
+					dev_err(cl_data_to_dev(client_data),
 						"[hid-ish]: [ENUM_DEVICES]: content size %zu is bigger than payload_len %zu\n",
 						1 + sizeof(struct device_info)
 						* i, payload_len);
@@ -172,7 +175,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			}
 			if (!client_data->hid_descr[curr_hid_dev])
 				client_data->hid_descr[curr_hid_dev] =
-				devm_kmalloc(&client_data->cl_device->dev,
+				devm_kmalloc(cl_data_to_dev(client_data),
 					     payload_len, GFP_KERNEL);
 			if (client_data->hid_descr[curr_hid_dev]) {
 				memcpy(client_data->hid_descr[curr_hid_dev],
@@ -197,7 +200,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			}
 			if (!client_data->report_descr[curr_hid_dev])
 				client_data->report_descr[curr_hid_dev] =
-				devm_kmalloc(&client_data->cl_device->dev,
+				devm_kmalloc(cl_data_to_dev(client_data),
 					     payload_len, GFP_KERNEL);
 			if (client_data->report_descr[curr_hid_dev])  {
 				memcpy(client_data->report_descr[curr_hid_dev],
@@ -516,12 +519,12 @@ static int ishtp_enum_enum_devices(struct ishtp_cl *hid_ishtp_cl)
 					   sizeof(struct hostif_msg));
 	}
 	if (!client_data->enum_devices_done) {
-		dev_err(&client_data->cl_device->dev,
+		dev_err(cl_data_to_dev(client_data),
 			"[hid-ish]: timed out waiting for enum_devices\n");
 		return -ETIMEDOUT;
 	}
 	if (!client_data->hid_devices) {
-		dev_err(&client_data->cl_device->dev,
+		dev_err(cl_data_to_dev(client_data),
 			"[hid-ish]: failed to allocate HID dev structures\n");
 		return -ENOMEM;
 	}
@@ -564,13 +567,13 @@ static int ishtp_get_hid_descriptor(struct ishtp_cl *hid_ishtp_cl, int index)
 						 client_data->hid_descr_done,
 						 3 * HZ);
 		if (!client_data->hid_descr_done) {
-			dev_err(&client_data->cl_device->dev,
+			dev_err(cl_data_to_dev(client_data),
 				"[hid-ish]: timed out for hid_descr_done\n");
 			return -EIO;
 		}
 
 		if (!client_data->hid_descr[index]) {
-			dev_err(&client_data->cl_device->dev,
+			dev_err(cl_data_to_dev(client_data),
 				"[hid-ish]: allocation HID desc fail\n");
 			return -ENOMEM;
 		}
@@ -611,12 +614,12 @@ static int ishtp_get_report_descriptor(struct ishtp_cl *hid_ishtp_cl,
 					 client_data->report_descr_done,
 					 3 * HZ);
 	if (!client_data->report_descr_done) {
-		dev_err(&client_data->cl_device->dev,
+		dev_err(cl_data_to_dev(client_data),
 				"[hid-ish]: timed out for report descr\n");
 		return -EIO;
 	}
 	if (!client_data->report_descr[index]) {
-		dev_err(&client_data->cl_device->dev,
+		dev_err(cl_data_to_dev(client_data),
 			"[hid-ish]: failed to alloc report descr\n");
 		return -ENOMEM;
 	}
@@ -646,12 +649,12 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 	int i;
 	int rv;
 
-	dev_dbg(&client_data->cl_device->dev, "%s\n", __func__);
+	dev_dbg(cl_data_to_dev(client_data), "%s\n", __func__);
 	hid_ishtp_trace(client_data,  "%s reset flag: %d\n", __func__, reset);
 
 	rv = ishtp_cl_link(hid_ishtp_cl, ISHTP_HOST_CLIENT_ID_ANY);
 	if (rv) {
-		dev_err(&client_data->cl_device->dev,
+		dev_err(cl_data_to_dev(client_data),
 			"ishtp_cl_link failed\n");
 		return	-ENOMEM;
 	}
@@ -666,7 +669,7 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 
 	fw_client = ishtp_fw_cl_get_client(dev, &hid_ishtp_guid);
 	if (!fw_client) {
-		dev_err(&client_data->cl_device->dev,
+		dev_err(cl_data_to_dev(client_data),
 			"ish client uuid not found\n");
 		return -ENOENT;
 	}
@@ -676,7 +679,7 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 
 	rv = ishtp_cl_connect(hid_ishtp_cl);
 	if (rv) {
-		dev_err(&client_data->cl_device->dev,
+		dev_err(cl_data_to_dev(client_data),
 			"client connect fail\n");
 		goto err_cl_unlink;
 	}
@@ -707,7 +710,7 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 		if (!reset) {
 			rv = ishtp_hid_probe(i, client_data);
 			if (rv) {
-				dev_err(&client_data->cl_device->dev,
+				dev_err(cl_data_to_dev(client_data),
 				"[hid-ish]: HID probe for #%u failed: %d\n",
 				i, rv);
 				goto err_cl_disconnect;
@@ -763,7 +766,7 @@ static void hid_ishtp_cl_reset_handler(struct work_struct *work)
 
 	hid_ishtp_cl_deinit(hid_ishtp_cl);
 
-	hid_ishtp_cl = ishtp_cl_allocate(cl_device->ishtp_dev);
+	hid_ishtp_cl = ishtp_cl_allocate(cl_device);
 	if (!hid_ishtp_cl)
 		return;
 
@@ -777,15 +780,17 @@ static void hid_ishtp_cl_reset_handler(struct work_struct *work)
 		rv = hid_ishtp_cl_init(hid_ishtp_cl, 1);
 		if (!rv)
 			break;
-		dev_err(&client_data->cl_device->dev, "Retry reset init\n");
+		dev_err(cl_data_to_dev(client_data), "Retry reset init\n");
 	}
 	if (rv) {
-		dev_err(&client_data->cl_device->dev, "Reset Failed\n");
+		dev_err(cl_data_to_dev(client_data), "Reset Failed\n");
 		hid_ishtp_trace(client_data, "%s Failed hid_ishtp_cl %p\n",
 				__func__, hid_ishtp_cl);
 	}
 }
 
+void (*hid_print_trace)(void *dev, const char *format, ...);
+
 /**
  * hid_ishtp_cl_probe() - ISHTP client driver probe
  * @cl_device:		ISHTP client device instance
@@ -803,12 +808,13 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 	if (!cl_device)
 		return	-ENODEV;
 
-	client_data = devm_kzalloc(&cl_device->dev, sizeof(*client_data),
+	client_data = devm_kzalloc(ishtp_device(cl_device),
+				   sizeof(*client_data),
 				   GFP_KERNEL);
 	if (!client_data)
 		return -ENOMEM;
 
-	hid_ishtp_cl = ishtp_cl_allocate(cl_device->ishtp_dev);
+	hid_ishtp_cl = ishtp_cl_allocate(cl_device);
 	if (!hid_ishtp_cl)
 		return -ENOMEM;
 
@@ -822,6 +828,8 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 
 	INIT_WORK(&client_data->work, hid_ishtp_cl_reset_handler);
 
+	hid_print_trace = ishtp_trace_callback(cl_device);
+
 	rv = hid_ishtp_cl_init(hid_ishtp_cl, 0);
 	if (rv) {
 		ishtp_cl_free(hid_ishtp_cl);
@@ -848,7 +856,7 @@ static int hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
 			hid_ishtp_cl);
 
-	dev_dbg(&cl_device->dev, "%s\n", __func__);
+	dev_dbg(ishtp_device(cl_device), "%s\n", __func__);
 	hid_ishtp_cl->state = ISHTP_CL_DISCONNECTING;
 	ishtp_cl_disconnect(hid_ishtp_cl);
 	ishtp_put_device(cl_device);
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 5c7e127b0483..95a5b87d9105 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/hid.h>
+#include <linux/intel-ish-client-if.h>
 #include <uapi/linux/input.h>
 #include "ishtp/client.h"
 #include "ishtp-hid.h"
@@ -241,7 +242,8 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 
 	hid->ll_driver = &ishtp_hid_ll_driver;
 	hid->bus = BUS_INTEL_ISHTP;
-	hid->dev.parent = &client_data->cl_device->dev;
+	hid->dev.parent = ishtp_device(client_data->cl_device);
+
 	hid->version = le16_to_cpu(ISH_HID_VERSION);
 	hid->vendor = le16_to_cpu(client_data->hid_devices[cur_hid_dev].vid);
 	hid->product = le16_to_cpu(client_data->hid_devices[cur_hid_dev].pid);
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h b/drivers/hid/intel-ish-hid/ishtp-hid.h
index 40663639e43b..8af44e855a49 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.h
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
@@ -24,7 +24,7 @@
 #define	IS_RESPONSE	0x80
 
 /* Used to dump to Linux trace buffer, if enabled */
-#define hid_ishtp_trace(client, ...)	\
+#define hid_ishtp_trace(client, ...)   \
 	client->cl_device->ishtp_dev->print_log(\
 		client->cl_device->ishtp_dev, __VA_ARGS__)
 
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 6348fee8aadc..308853eab91c 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -827,6 +827,33 @@ int ishtp_use_dma_transfer(void)
 	return ishtp_use_dma;
 }
 
+/**
+ * ishtp_device() - Return device pointer
+ *
+ * This interface is used to return device pointer from ishtp_cl_device
+ * instance.
+ *
+ * Return: device *.
+ */
+struct device *ishtp_device(struct ishtp_cl_device *device)
+{
+	return &device->dev;
+}
+EXPORT_SYMBOL(ishtp_device);
+
+/**
+ * ishtp_trace_callback() - Return trace callback
+ *
+ * This interface is used to return trace callback function pointer.
+ *
+ * Return: void *.
+ */
+void *ishtp_trace_callback(struct ishtp_cl_device *cl_device)
+{
+	return cl_device->ishtp_dev->print_log;
+}
+EXPORT_SYMBOL(ishtp_trace_callback);
+
 /**
  * ishtp_bus_register() - Function to register bus
  *
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index faeccdb1475b..760e48a368a8 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -126,7 +126,7 @@ static void ishtp_cl_init(struct ishtp_cl *cl, struct ishtp_device *dev)
  *
  * Return: The allocated client instance or NULL on failure
  */
-struct ishtp_cl *ishtp_cl_allocate(struct ishtp_device *dev)
+struct ishtp_cl *ishtp_cl_allocate(struct ishtp_cl_device *cl_device)
 {
 	struct ishtp_cl *cl;
 
@@ -134,7 +134,7 @@ struct ishtp_cl *ishtp_cl_allocate(struct ishtp_device *dev)
 	if (!cl)
 		return NULL;
 
-	ishtp_cl_init(cl, dev);
+	ishtp_cl_init(cl, cl_device->ishtp_dev);
 	return cl;
 }
 EXPORT_SYMBOL(ishtp_cl_allocate);
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.h b/drivers/hid/intel-ish-hid/ishtp/client.h
index e0df3eb611e6..992625891a6c 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.h
+++ b/drivers/hid/intel-ish-hid/ishtp/client.h
@@ -170,7 +170,7 @@ static inline bool ishtp_cl_cmp_id(const struct ishtp_cl *cl1,
 }
 
 /* exported functions from ISHTP under client management scope */
-struct ishtp_cl	*ishtp_cl_allocate(struct ishtp_device *dev);
+struct ishtp_cl *ishtp_cl_allocate(struct ishtp_cl_device *cl_device);
 void ishtp_cl_free(struct ishtp_cl *cl);
 int ishtp_cl_link(struct ishtp_cl *cl, int id);
 void ishtp_cl_unlink(struct ishtp_cl *cl);
diff --git a/include/linux/intel-ish-client-if.h b/include/linux/intel-ish-client-if.h
new file mode 100644
index 000000000000..11e285172735
--- /dev/null
+++ b/include/linux/intel-ish-client-if.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel ISH client Interface definitions
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ */
+
+#ifndef _INTEL_ISH_CLIENT_IF_H_
+#define _INTEL_ISH_CLIENT_IF_H_
+
+struct ishtp_cl_device;
+
+/* Get the device * from ishtp device instance */
+struct device *ishtp_device(struct ishtp_cl_device *cl_device);
+/* Trace interface for clients */
+void *ishtp_trace_callback(struct ishtp_cl_device *cl_device);
+
+#endif /* _INTEL_ISH_CLIENT_IF_H_ */
-- 
2.17.2
