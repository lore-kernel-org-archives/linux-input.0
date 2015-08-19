From: John Sung <penmount.touch@gmail.com>
Subject: [PATCH 2/3] HID: hid-penmount shows device version
Date: Wed, 19 Aug 2015 15:29:58 +0800
Message-ID: <1439969399-11469-2-git-send-email-penmount.touch@gmail.com>
References: <1439969399-11469-1-git-send-email-penmount.touch@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439969399-11469-1-git-send-email-penmount.touch@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penmount.touch@gmail.com
List-Id: linux-input@vger.kernel.org

Let hid-penmount retrieve the device version using feature report.

Signed-off-by: John Sung <penmount.touch@gmail.com>
---
 drivers/hid/hid-penmount.c |  112 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
index 68c5721..4fd14c8 100644
--- a/drivers/hid/hid-penmount.c
+++ b/drivers/hid/hid-penmount.c
@@ -24,6 +24,8 @@
 #define PM_MAX_CONTACT		10
 #define PM_DEF_CONTACT_PCI	5
 #define PM_DEF_CONTACT_6000	1
+#define PM_HID_REPORT_SIZE	5
+#define PM_HID_REPORT_ID	0x00
 
 struct mt_slot {
 	unsigned char id;
@@ -39,8 +41,117 @@ struct penmount {
 	unsigned char maxcontacts;
 	struct mt_slot slots[PM_MAX_CONTACT];
 	struct mt_slot curdata;
+	char version[32];
 };
 
+static int penmount_hid_setreport(struct penmount *pm, unsigned char *cmd)
+{
+
+	int ret = 0;
+	unsigned char report[PM_HID_REPORT_SIZE+1] = { PM_HID_REPORT_ID,
+		cmd[0], cmd[1], cmd[2], cmd[3], cmd[4] };
+
+	ret = hid_hw_raw_request(pm->hid, PM_HID_REPORT_ID, report,
+		PM_HID_REPORT_SIZE+1, HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	if (ret < 0)
+		hid_err(pm->hid, "Failed to set feature report !\n");
+
+	return ret;
+}
+
+static int penmount_hid_getreport(struct penmount *pm, unsigned char *ack)
+{
+	int ret = 0;
+	int i = 0;
+	unsigned char report[PM_HID_REPORT_SIZE+1] = { PM_HID_REPORT_ID,
+		0, 0, 0, 0, 0 };
+
+	ret = hid_hw_raw_request(pm->hid, PM_HID_REPORT_ID, report,
+		PM_HID_REPORT_SIZE+1, HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		hid_err(pm->hid, "Failed to get feature report !\n");
+		return ret;
+	}
+
+	for (i = 0; i < PM_HID_REPORT_SIZE; i++)
+		ack[i] = report[i+1];
+
+	return ret;
+}
+
+static int penmount_get_version(struct penmount *pm)
+{
+	int ret = 0;
+	unsigned short product_version = 0;
+	unsigned char major_version = 0;
+	unsigned char minor_version = 0;
+	unsigned char build_version = 0;
+	unsigned char odm_version = 0;
+	unsigned char cmd[PM_HID_REPORT_SIZE] = { 0xEE, 0, 0, 0, 0 };
+	unsigned char ack[PM_HID_REPORT_SIZE] = { 0, 0, 0, 0, 0 };
+
+	ret = penmount_hid_setreport(pm, cmd);
+	if (ret < 0) {
+		hid_warn(pm->hid, "Failed to get firmware version !");
+		return ret;
+	}
+
+	ret = penmount_hid_getreport(pm, ack);
+	if (ret < 0) {
+		hid_warn(pm->hid, "Failed to get firmware version !");
+		return ret;
+	}
+
+	switch (pm->model) {
+	case USB_DEVICE_ID_PENMOUNT_PCI:
+		product_version = (ack[2] * 256 + ack[1]) & 0x7FFF;
+		major_version = ack[3];
+		break;
+	case USB_DEVICE_ID_PENMOUNT_6000:
+		product_version = ack[1] * 256 + ack[2];
+		major_version = ack[4];
+		break;
+	}
+
+	cmd[0] = 0xED;
+	ret = penmount_hid_setreport(pm, cmd);
+	if (ret < 0) {
+		hid_warn(pm->hid, "Failed to get firmware version !");
+		return ret;
+	}
+
+	ret = penmount_hid_getreport(pm, ack);
+	if (ret < 0) {
+		hid_warn(pm->hid, "Failed to get firmware version !");
+		return ret;
+	}
+
+	switch (pm->model) {
+	case USB_DEVICE_ID_PENMOUNT_PCI:
+		minor_version = ack[1];
+		odm_version = ack[2];
+		build_version = ack[3];
+		break;
+	case USB_DEVICE_ID_PENMOUNT_6000:
+		minor_version = ack[2];
+		build_version = ack[4];
+		break;
+	}
+
+	if (!odm_version) {
+		sprintf(pm->version, "%d.%d.%d.%d", product_version,
+			major_version, minor_version, build_version);
+	} else {
+		sprintf(pm->version, "%d.D%02X.%d.%d.%d", product_version,
+			odm_version, major_version, minor_version,
+			build_version);
+	}
+
+	hid_info(pm->hid, "Firmware version %s\n", pm->version);
+
+	return ret;
+}
+
 static void penmount_send_event(struct penmount *pm)
 {
 	int i;
@@ -245,6 +356,7 @@ static int penmount_probe(struct hid_device *hdev,
 		set_bit(INPUT_PROP_DIRECT, hidinput->input->propbit);
 	}
 
+	penmount_get_version(pm);
 	hid_info(hdev, "Device supports %d touch contacts !\n",
 		pm->maxcontacts);
 	return ret;
-- 
1.7.9.5
