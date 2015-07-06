From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: rmi: Disable scanning if the device is not a wake source
Date: Mon, 6 Jul 2015 16:48:31 -0700
Message-ID: <1436226511-13138-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:11604 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756910AbbGFXsh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 19:48:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>

Some touchpads are configured with firmware which continues to scan for
fingers at a minimal scan rate even after receiving the HID power sleep
command. This allows a finger touching the touchpad to genrate a wake
event. This patch ensures that scanning is disabled if the touchpad is
not a wake source and ensures scanning is enabled on resume.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-rmi.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 4cf80bb..af191a2 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -33,6 +33,9 @@
 #define RMI_READ_DATA_PENDING		1
 #define RMI_STARTED			2
 
+#define RMI_SLEEP_NORMAL		0x0
+#define RMI_SLEEP_DEEP_SLEEP		0x1
+
 /* device flags */
 #define RMI_DEVICE			BIT(0)
 #define RMI_DEVICE_HAS_PHYS_BUTTONS	BIT(1)
@@ -126,6 +129,8 @@ struct rmi_data {
 
 	unsigned long device_flags;
 	unsigned long firmware_id;
+
+	u8 f01_ctrl0;
 };
 
 #define RMI_PAGE(addr) (((addr) >> 8) & 0xff)
@@ -532,9 +537,51 @@ static int rmi_event(struct hid_device *hdev, struct hid_field *field,
 }
 
 #ifdef CONFIG_PM
+static int rmi_set_sleep_mode(struct hid_device *hdev, int sleep_mode)
+{
+	struct rmi_data *data = hid_get_drvdata(hdev);
+	int ret;
+	u8 f01_ctrl0;
+
+	f01_ctrl0 = (data->f01_ctrl0 & ~0x3) | sleep_mode;
+
+	ret = rmi_write(hdev, data->f01.control_base_addr,
+			&f01_ctrl0);
+	if (ret) {
+		hid_err(hdev, "can not write sleep mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	if (!device_may_wakeup(hdev->dev.parent))
+		return rmi_set_sleep_mode(hdev, RMI_SLEEP_DEEP_SLEEP);
+
+	return 0;
+}
+
 static int rmi_post_reset(struct hid_device *hdev)
 {
-	return rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
+	int ret;
+
+	ret = rmi_set_mode(hdev, RMI_MODE_ATTN_REPORTS);
+	if (ret) {
+		hid_err(hdev, "can not set rmi mode\n");
+		return ret;
+	}
+
+	if (!device_may_wakeup(hdev->dev.parent)) {
+		ret = rmi_set_sleep_mode(hdev, RMI_SLEEP_NORMAL);
+		if (ret) {
+			hid_err(hdev, "can not write sleep mode\n");
+			return ret;
+		}
+	}
+
+	return ret;
 }
 
 static int rmi_post_resume(struct hid_device *hdev)
@@ -732,6 +779,12 @@ static int rmi_populate_f01(struct hid_device *hdev)
 		data->firmware_id += info[2] * 65536;
 	}
 
+	ret = rmi_read(hdev, data->f01.control_base_addr, &data->f01_ctrl0);
+
+	if (ret) {
+		hid_err(hdev, "can not read f01 ctrl0\n");
+		return ret;
+	}
 	return 0;
 }
 
@@ -1273,6 +1326,7 @@ static struct hid_driver rmi_driver = {
 	.input_mapping		= rmi_input_mapping,
 	.input_configured	= rmi_input_configured,
 #ifdef CONFIG_PM
+	.suspend		= rmi_suspend,
 	.resume			= rmi_post_resume,
 	.reset_resume		= rmi_post_reset,
 #endif
-- 
2.1.4

