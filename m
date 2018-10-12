From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: alps: allow incoming reports when only the trackstick is opened
Date: Fri, 12 Oct 2018 16:05:25 +0200
Message-ID: <20181012140525.24799-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

If userspace only reads the trackstick node, and no one is listening to
the touchpad nor the hidraw node then, the device is not powered on.

Add open/close callbacks to allow users to disable the touchpad in Gnome
while keeping the trackstick active.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1559632
Link: https://gitlab.gnome.org/GNOME/mutter/issues/128
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-alps.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index aec253b44156..3cd7229b6e54 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -660,6 +660,20 @@ static int T4_init(struct hid_device *hdev, struct alps_dev *pri_data)
 	return ret;
 }
 
+static int alps_sp_open(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	return hid_hw_open(hid);
+}
+
+static void alps_sp_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	hid_hw_close(hid);
+}
+
 static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct alps_dev *data = hid_get_drvdata(hdev);
@@ -733,6 +747,10 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		input2->id.version = input->id.version;
 		input2->dev.parent = input->dev.parent;
 
+		input_set_drvdata(input2, hdev);
+		input2->open = alps_sp_open;
+		input2->close = alps_sp_close;
+
 		__set_bit(EV_KEY, input2->evbit);
 		data->sp_btn_cnt = (data->sp_btn_info & 0x0F);
 		for (i = 0; i < data->sp_btn_cnt; i++)
-- 
2.14.3
