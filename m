From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 1/3] HID: rmi: Add functions for writing to registers
Date: Tue, 24 Feb 2015 17:36:48 -0800
Message-ID: <1424828210-18972-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:49633 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752769AbbBYBj5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 20:39:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>

Writing to registers is needed for setting configuration parameters.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-rmi.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 28579d7..e2a43a1 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -274,6 +274,46 @@ static inline int rmi_read(struct hid_device *hdev, u16 addr, void *buf)
 	return rmi_read_block(hdev, addr, buf, 1);
 }
 
+static int rmi_write_block(struct hid_device *hdev, u16 addr, void *buf,
+		const int len)
+{
+	struct rmi_data *data = hid_get_drvdata(hdev);
+	int ret;
+
+	mutex_lock(&data->page_mutex);
+
+	if (RMI_PAGE(addr) != data->page) {
+		ret = rmi_set_page(hdev, RMI_PAGE(addr));
+		if (ret < 0)
+			goto exit;
+	}
+
+	data->writeReport[0] = RMI_WRITE_REPORT_ID;
+	data->writeReport[1] = len;
+	data->writeReport[2] = addr & 0xFF;
+	data->writeReport[3] = (addr >> 8) & 0xFF;
+	memcpy(&data->writeReport[4], buf, len);
+
+	ret = rmi_write_report(hdev, data->writeReport,
+					data->output_report_size);
+	if (ret < 0) {
+		dev_err(&hdev->dev,
+			"failed to write request output report (%d)\n",
+			ret);
+		goto exit;
+	}
+	ret = 0;
+
+exit:
+	mutex_unlock(&data->page_mutex);
+	return ret;
+}
+
+static inline int rmi_write(struct hid_device *hdev, u16 addr, void *buf)
+{
+	return rmi_write_block(hdev, addr, buf, 1);
+}
+
 static void rmi_f11_process_touch(struct rmi_data *hdata, int slot,
 		u8 finger_state, u8 *touch_data)
 {
-- 
2.1.0

