From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 9/9] HID: intel-ish-hid: Use the new interface functions in HID ish client
Date: Sun,  3 Mar 2019 08:46:54 -0800
Message-ID: <20190303164654.29400-10-srinivas.pandruvada@linux.intel.com>
References: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Only include intel-ish-client-if.h, which has all interfaces required to
implment ISHTP client. There is no longer any direct field access from
core ISHTP only include files.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 68 +++++++++-----------
 drivers/hid/intel-ish-hid/ishtp-hid.c        |  2 -
 drivers/hid/intel-ish-hid/ishtp-hid.h        |  6 +-
 3 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 9084fea4c247..5b98e36e3a81 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -17,8 +17,6 @@
 #include <linux/hid.h>
 #include <linux/intel-ish-client-if.h>
 #include <linux/sched.h>
-#include "ishtp/ishtp-dev.h"
-#include "ishtp/client.h"
 #include "ishtp-hid.h"
 
 /* Rx ring buffer pool size */
@@ -40,7 +38,7 @@ static void report_bad_packet(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			      size_t cur_pos,  size_t payload_len)
 {
 	struct hostif_msg *recv_msg = recv_buf;
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 
 	dev_err(cl_data_to_dev(client_data), "[hid-ish]: BAD packet %02X\n"
 		"total_bad=%u cur_pos=%u\n"
@@ -77,7 +75,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 	struct report_list *reports_list;
 	char *reports;
 	size_t report_len;
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 	int curr_hid_dev = client_data->cur_hid_dev;
 
 	payload = recv_buf + sizeof(struct hostif_msg_hdr);
@@ -91,7 +89,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				(unsigned int)data_len,
 				(unsigned int)sizeof(struct hostif_msg_hdr));
 			++client_data->bad_recv_cnt;
-			ish_hw_reset(hid_ishtp_cl->dev);
+			ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 			break;
 		}
 
@@ -104,7 +102,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			++client_data->bad_recv_cnt;
 			report_bad_packet(hid_ishtp_cl, recv_msg, cur_pos,
 					  payload_len);
-			ish_hw_reset(hid_ishtp_cl->dev);
+			ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 			break;
 		}
 
@@ -119,7 +117,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				report_bad_packet(hid_ishtp_cl, recv_msg,
 						  cur_pos,
 						  payload_len);
-				ish_hw_reset(hid_ishtp_cl->dev);
+				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
 			client_data->hid_dev_count = (unsigned int)*payload;
@@ -168,7 +166,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				report_bad_packet(hid_ishtp_cl, recv_msg,
 						  cur_pos,
 						  payload_len);
-				ish_hw_reset(hid_ishtp_cl->dev);
+				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
 			if (!client_data->hid_descr[curr_hid_dev])
@@ -193,7 +191,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				report_bad_packet(hid_ishtp_cl, recv_msg,
 						  cur_pos,
 						  payload_len);
-				ish_hw_reset(hid_ishtp_cl->dev);
+				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 				break;
 			}
 			if (!client_data->report_descr[curr_hid_dev])
@@ -298,7 +296,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 			++client_data->bad_recv_cnt;
 			report_bad_packet(hid_ishtp_cl, recv_msg, cur_pos,
 					  payload_len);
-			ish_hw_reset(hid_ishtp_cl->dev);
+			ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
 			break;
 
 		}
@@ -478,7 +476,7 @@ int ishtp_hid_link_ready_wait(struct ishtp_cl_data *client_data)
 static int ishtp_enum_enum_devices(struct ishtp_cl *hid_ishtp_cl)
 {
 	struct hostif_msg msg;
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 	int retry_count;
 	int rv;
 
@@ -515,7 +513,7 @@ static int ishtp_enum_enum_devices(struct ishtp_cl *hid_ishtp_cl)
 	}
 
 	client_data->num_hid_devices = client_data->hid_dev_count;
-	dev_info(&hid_ishtp_cl->device->dev,
+	dev_info(ishtp_device(client_data->cl_device),
 		"[hid-ish]: enum_devices_done OK, num_hid_devices=%d\n",
 		client_data->num_hid_devices);
 
@@ -534,7 +532,7 @@ static int ishtp_enum_enum_devices(struct ishtp_cl *hid_ishtp_cl)
 static int ishtp_get_hid_descriptor(struct ishtp_cl *hid_ishtp_cl, int index)
 {
 	struct hostif_msg msg;
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 	int rv;
 
 	/* Get HID descriptor */
@@ -581,7 +579,7 @@ static int ishtp_get_report_descriptor(struct ishtp_cl *hid_ishtp_cl,
 				       int index)
 {
 	struct hostif_msg msg;
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 	int rv;
 
 	/* Get report descriptor */
@@ -629,7 +627,7 @@ static int ishtp_get_report_descriptor(struct ishtp_cl *hid_ishtp_cl,
 static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 {
 	struct ishtp_device *dev;
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 	struct ishtp_fw_client *fw_client;
 	int i;
 	int rv;
@@ -646,11 +644,11 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 
 	client_data->init_done = 0;
 
-	dev = hid_ishtp_cl->dev;
+	dev = ishtp_get_ishtp_device(hid_ishtp_cl);
 
 	/* Connect to FW client */
-	hid_ishtp_cl->rx_ring_size = HID_CL_RX_RING_SIZE;
-	hid_ishtp_cl->tx_ring_size = HID_CL_TX_RING_SIZE;
+	ishtp_set_tx_ring_size(hid_ishtp_cl, HID_CL_TX_RING_SIZE);
+	ishtp_set_rx_ring_size(hid_ishtp_cl, HID_CL_RX_RING_SIZE);
 
 	fw_client = ishtp_fw_cl_get_client(dev, &hid_ishtp_guid);
 	if (!fw_client) {
@@ -658,9 +656,9 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 			"ish client uuid not found\n");
 		return -ENOENT;
 	}
-
-	hid_ishtp_cl->fw_client_id = fw_client->client_id;
-	hid_ishtp_cl->state = ISHTP_CL_CONNECTING;
+	ishtp_cl_set_fw_client_id(hid_ishtp_cl,
+				  ishtp_get_fw_client_id(fw_client));
+	ishtp_set_connection_state(hid_ishtp_cl, ISHTP_CL_CONNECTING);
 
 	rv = ishtp_cl_connect(hid_ishtp_cl);
 	if (rv) {
@@ -672,7 +670,7 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 	hid_ishtp_trace(client_data,  "%s client connected\n", __func__);
 
 	/* Register read callback */
-	ishtp_register_event_cb(hid_ishtp_cl->device, ish_cl_event_cb);
+	ishtp_register_event_cb(client_data->cl_device, ish_cl_event_cb);
 
 	rv = ishtp_enum_enum_devices(hid_ishtp_cl);
 	if (rv)
@@ -710,7 +708,7 @@ static int hid_ishtp_cl_init(struct ishtp_cl *hid_ishtp_cl, int reset)
 	return 0;
 
 err_cl_disconnect:
-	hid_ishtp_cl->state = ISHTP_CL_DISCONNECTING;
+	ishtp_set_connection_state(hid_ishtp_cl, ISHTP_CL_DISCONNECTING);
 	ishtp_cl_disconnect(hid_ishtp_cl);
 err_cl_unlink:
 	ishtp_cl_unlink(hid_ishtp_cl);
@@ -747,7 +745,7 @@ static void hid_ishtp_cl_reset_handler(struct work_struct *work)
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
 			hid_ishtp_cl);
-	dev_dbg(&cl_device->dev, "%s\n", __func__);
+	dev_dbg(ishtp_device(client_data->cl_device), "%s\n", __func__);
 
 	hid_ishtp_cl_deinit(hid_ishtp_cl);
 
@@ -756,7 +754,7 @@ static void hid_ishtp_cl_reset_handler(struct work_struct *work)
 		return;
 
 	ishtp_set_drvdata(cl_device, hid_ishtp_cl);
-	hid_ishtp_cl->client_data = client_data;
+	ishtp_set_client_data(hid_ishtp_cl, client_data);
 	client_data->hid_ishtp_cl = hid_ishtp_cl;
 
 	client_data->num_hid_devices = 0;
@@ -774,7 +772,7 @@ static void hid_ishtp_cl_reset_handler(struct work_struct *work)
 	}
 }
 
-void (*hid_print_trace)(void *dev, const char *format, ...);
+void (*hid_print_trace)(void *unused, const char *format, ...);
 
 /**
  * hid_ishtp_cl_probe() - ISHTP client driver probe
@@ -804,7 +802,7 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 		return -ENOMEM;
 
 	ishtp_set_drvdata(cl_device, hid_ishtp_cl);
-	hid_ishtp_cl->client_data = client_data;
+	ishtp_set_client_data(hid_ishtp_cl, client_data);
 	client_data->hid_ishtp_cl = hid_ishtp_cl;
 	client_data->cl_device = cl_device;
 
@@ -836,13 +834,13 @@ static int hid_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
 static int hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
 {
 	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
 			hid_ishtp_cl);
 
 	dev_dbg(ishtp_device(cl_device), "%s\n", __func__);
-	hid_ishtp_cl->state = ISHTP_CL_DISCONNECTING;
+	ishtp_set_connection_state(hid_ishtp_cl, ISHTP_CL_DISCONNECTING);
 	ishtp_cl_disconnect(hid_ishtp_cl);
 	ishtp_put_device(cl_device);
 	ishtp_hid_remove(client_data);
@@ -866,7 +864,7 @@ static int hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
 static int hid_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
 {
 	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
 			hid_ishtp_cl);
@@ -876,8 +874,6 @@ static int hid_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
 	return 0;
 }
 
-#define to_ishtp_cl_device(d) container_of(d, struct ishtp_cl_device, dev)
-
 /**
  * hid_ishtp_cl_suspend() - ISHTP client driver suspend
  * @device:	device instance
@@ -888,9 +884,9 @@ static int hid_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
  */
 static int hid_ishtp_cl_suspend(struct device *device)
 {
-	struct ishtp_cl_device *cl_device = to_ishtp_cl_device(device);
+	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
 	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
 			hid_ishtp_cl);
@@ -909,9 +905,9 @@ static int hid_ishtp_cl_suspend(struct device *device)
  */
 static int hid_ishtp_cl_resume(struct device *device)
 {
-	struct ishtp_cl_device *cl_device = to_ishtp_cl_device(device);
+	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
 	struct ishtp_cl *hid_ishtp_cl = ishtp_get_drvdata(cl_device);
-	struct ishtp_cl_data *client_data = hid_ishtp_cl->client_data;
+	struct ishtp_cl_data *client_data = ishtp_get_client_data(hid_ishtp_cl);
 
 	hid_ishtp_trace(client_data, "%s hid_ishtp_cl %p\n", __func__,
 			hid_ishtp_cl);
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index cb71ad43ea3b..7fac8fa593b9 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -16,7 +16,6 @@
 #include <linux/hid.h>
 #include <linux/intel-ish-client-if.h>
 #include <uapi/linux/input.h>
-#include "ishtp/client.h"
 #include "ishtp-hid.h"
 
 /**
@@ -117,7 +116,6 @@ static void ishtp_hid_request(struct hid_device *hid, struct hid_report *rep,
 static int ishtp_wait_for_response(struct hid_device *hid)
 {
 	struct ishtp_hid_data *hid_data =  hid->driver_data;
-	struct ishtp_cl_data *client_data = hid_data->client_data;
 	int rv;
 
 	hid_ishtp_trace(client_data,  "%s hid %p\n", __func__, hid);
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h b/drivers/hid/intel-ish-hid/ishtp-hid.h
index e1b00f5125c7..5e38345e5ee6 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.h
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
@@ -24,9 +24,9 @@
 #define	IS_RESPONSE	0x80
 
 /* Used to dump to Linux trace buffer, if enabled */
-#define hid_ishtp_trace(client, ...)   \
-	client->cl_device->ishtp_dev->print_log(\
-		client->cl_device->ishtp_dev, __VA_ARGS__)
+extern void (*hid_print_trace)(void *unused, const char *format, ...);
+#define hid_ishtp_trace(client, ...) \
+		(hid_print_trace)(NULL, __VA_ARGS__)
 
 /* ISH Transport protocol (ISHTP in short) GUID */
 static const guid_t hid_ishtp_guid =
-- 
2.17.2
