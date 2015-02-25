From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 2/3] HID: rmi: disable dribble packets on Synaptics touchpads
Date: Tue, 24 Feb 2015 17:36:49 -0800
Message-ID: <1424828210-18972-2-git-send-email-aduggan@synaptics.com>
References: <1424828210-18972-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424828210-18972-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-input@vger.kernel.org

When a finger is lifted from a Synaptics touchpad the firmware will continue
to interrupts for up to a second. These additional interrupts are know and
dribble interrupts. Since the data read from the touchpad does not change
the input subsystem only reports a single event. This makes the servicing of
dribble interrupts on Linux unnecessary. This patch simply disables dribble
interupts when configuring the touchpad.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/hid/hid-rmi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index e2a43a1..6e74eae 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -751,6 +751,7 @@ static int rmi_populate_f11(struct hid_device *hdev)
 	bool has_gestures;
 	bool has_rel;
 	bool has_data40 = false;
+	bool has_dribble = false;
 	unsigned x_size, y_size;
 	u16 query_offset;
 
@@ -792,6 +793,14 @@ static int rmi_populate_f11(struct hid_device *hdev)
 	has_rel = !!(buf[0] & BIT(3));
 	has_gestures = !!(buf[0] & BIT(5));
 
+	ret = rmi_read(hdev, data->f11.query_base_addr + 5, buf);
+	if (ret) {
+		hid_err(hdev, "can not get absolute data sources: %d.\n", ret);
+		return ret;
+	}
+
+	has_dribble = !!(buf[0] & BIT(4));
+
 	/*
 	 * At least 4 queries are guaranteed to be present in F11
 	 * +1 for query 5 which is present since absolute events are
@@ -908,6 +917,16 @@ static int rmi_populate_f11(struct hid_device *hdev)
 	data->max_x = buf[6] | (buf[7] << 8);
 	data->max_y = buf[8] | (buf[9] << 8);
 
+	if (has_dribble) {
+		buf[0] = buf[0] & ~BIT(6);
+		ret = rmi_write(hdev, data->f11.control_base_addr, buf);
+		if (ret) {
+			hid_err(hdev, "can not write to control reg 0: %d.\n",
+				ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.1.0
