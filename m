From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: rmi: Print the firmware id of the touchpad
Date: Tue, 10 Feb 2015 12:36:55 -0800
Message-ID: <1423600615-615-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:24276 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751154AbbBJUjq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2015 15:39:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Knowing the firmware id is extremely useful when debugging issues related to
the touchpad. It can be used to determine the hardware, firmware version,
and configuation of the touchpad. This patch queries the firmware id and
prints it as the touchpad is starting so that it will show up in the dmesg
output included in bug reports.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-rmi.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 49d4fe4..28579d7 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -104,6 +104,7 @@ struct rmi_data {
 
 	unsigned long flags;
 
+	struct rmi_function f01;
 	struct rmi_function f11;
 	struct rmi_function f30;
 
@@ -124,6 +125,7 @@ struct rmi_data {
 	struct hid_device *hdev;
 
 	unsigned long device_flags;
+	unsigned long firmware_id;
 };
 
 #define RMI_PAGE(addr) (((addr) >> 8) & 0xff)
@@ -532,6 +534,9 @@ static void rmi_register_function(struct rmi_data *data,
 	u16 page_base = page << 8;
 
 	switch (pdt_entry->function_number) {
+	case 0x01:
+		f = &data->f01;
+		break;
 	case 0x11:
 		f = &data->f11;
 		break;
@@ -604,6 +609,92 @@ error_exit:
 	return retval;
 }
 
+#define RMI_DEVICE_F01_BASIC_QUERY_LEN	11
+
+static int rmi_populate_f01(struct hid_device *hdev)
+{
+	struct rmi_data *data = hid_get_drvdata(hdev);
+	u8 basic_queries[RMI_DEVICE_F01_BASIC_QUERY_LEN];
+	u8 info[3];
+	int ret;
+	bool has_query42;
+	bool has_lts;
+	bool has_sensor_id;
+	bool has_ds4_queries = false;
+	bool has_build_id_query = false;
+	bool has_package_id_query = false;
+	u16 query_offset = data->f01.query_base_addr;
+	u16 prod_info_addr;
+	u8 ds4_query_len;
+
+	ret = rmi_read_block(hdev, query_offset, basic_queries,
+				RMI_DEVICE_F01_BASIC_QUERY_LEN);
+	if (ret) {
+		hid_err(hdev, "Can not read basic queries from Function 0x1.\n");
+		return ret;
+	}
+
+	has_lts = !!(basic_queries[0] & BIT(2));
+	has_sensor_id = !!(basic_queries[1] & BIT(3));
+	has_query42 = !!(basic_queries[1] & BIT(7));
+
+	query_offset += 11;
+	prod_info_addr = query_offset + 6;
+	query_offset += 10;
+
+	if (has_lts)
+		query_offset += 20;
+
+	if (has_sensor_id)
+		query_offset++;
+
+	if (has_query42) {
+		ret = rmi_read(hdev, query_offset, info);
+		if (ret) {
+			hid_err(hdev, "Can not read query42.\n");
+			return ret;
+		}
+		has_ds4_queries = !!(info[0] & BIT(0));
+		query_offset++;
+	}
+
+	if (has_ds4_queries) {
+		ret = rmi_read(hdev, query_offset, &ds4_query_len);
+		if (ret) {
+			hid_err(hdev, "Can not read DS4 Query length.\n");
+			return ret;
+		}
+		query_offset++;
+
+		if (ds4_query_len > 0) {
+			ret = rmi_read(hdev, query_offset, info);
+			if (ret) {
+				hid_err(hdev, "Can not read DS4 query.\n");
+				return ret;
+			}
+
+			has_package_id_query = !!(info[0] & BIT(0));
+			has_build_id_query = !!(info[0] & BIT(1));
+		}
+	}
+
+	if (has_package_id_query)
+		prod_info_addr++;
+
+	if (has_build_id_query) {
+		ret = rmi_read_block(hdev, prod_info_addr, info, 3);
+		if (ret) {
+			hid_err(hdev, "Can not read product info.\n");
+			return ret;
+		}
+
+		data->firmware_id = info[1] << 8 | info[0];
+		data->firmware_id += info[2] * 65536;
+	}
+
+	return 0;
+}
+
 static int rmi_populate_f11(struct hid_device *hdev)
 {
 	struct rmi_data *data = hid_get_drvdata(hdev);
@@ -858,6 +949,12 @@ static int rmi_populate(struct hid_device *hdev)
 		return ret;
 	}
 
+	ret = rmi_populate_f01(hdev);
+	if (ret) {
+		hid_err(hdev, "Error while initializing F01 (%d).\n", ret);
+		return ret;
+	}
+
 	ret = rmi_populate_f11(hdev);
 	if (ret) {
 		hid_err(hdev, "Error while initializing F11 (%d).\n", ret);
@@ -907,6 +1004,8 @@ static void rmi_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	if (ret)
 		goto exit;
 
+	hid_info(hdev, "firmware id: %ld\n", data->firmware_id);
+
 	__set_bit(EV_ABS, input->evbit);
 	input_set_abs_params(input, ABS_MT_POSITION_X, 1, data->max_x, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_Y, 1, data->max_y, 0, 0);
-- 
2.1.0

