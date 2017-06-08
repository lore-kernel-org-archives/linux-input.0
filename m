From: Yueyao Zhu <yueyao.zhu@gmail.com>
Subject: [PATCH 2/3] HID: usbhid: enable autosuspend for devices whose ...
Date: Thu,  8 Jun 2017 14:58:27 -0700
Message-ID: <20170608215828.130455-3-yueyao.zhu@gmail.com>
References: <20170608215828.130455-1-yueyao.zhu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608215828.130455-1-yueyao.zhu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, Badhri Jagan Sridharan <badhri@google.com>, Dmitry Torokhov <dtor@google.com>, Yueyao Zhu <yueyao@google.com>
List-Id: linux-input@vger.kernel.org

From: Yueyao Zhu <yueyao@google.com>

usage pages only points to CONSUMER. This allows autosuspend
to be enabled and thus power saved on CONSUMER hid devices.
Yet hid devices use other usage pages are not affected, e.g.
keyboard, mouse.

Signed-off-by: Yueyao Zhu <yueyao@google.com>
---
 drivers/hid/usbhid/hid-core.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 83772fa7d92a..f2696b4098b5 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1270,6 +1270,31 @@ static struct hid_ll_driver usb_hid_driver = {
 	.idle = usbhid_idle,
 };
 
+static bool usbhid_usage_is_consumer(struct hid_device *hid)
+{
+	int i;
+	struct hid_report_enum *input_report_enum =
+			hid->report_enum + HID_INPUT_REPORT;
+	struct list_head *report_list = &input_report_enum->report_list;
+	struct hid_report *report;
+	unsigned int usage_page;
+
+	if (list_empty(report_list))
+		return false;
+
+	list_for_each_entry(report, report_list, list) {
+		for (i = 0; i < report->maxfield; i++) {
+			/* only checks Application field */
+			usage_page =
+				report->field[i]->application & HID_USAGE_PAGE;
+			if (usage_page != HID_UP_CONSUMER)
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_host_interface *interface = intf->cur_altsetting;
@@ -1363,6 +1388,18 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 		goto err_free;
 	}
 
+	/*
+	 * Autosuspend interfaces which have only consumer usage page inputs.
+	 * This allows autosuspending devices which adhere to the Android USB
+	 * headset spec while not autosuspending general keyboards, mice, and
+	 * joysticks which may misbehave.
+	 */
+	if (usbhid_usage_is_consumer(hid)) {
+		intf->needs_remote_wakeup = true;
+		usb_allow_interface_autosuspend(intf);
+		hid_info(hid, "autosuspend enabled on the hid interface\n");
+	}
+
 	return 0;
 err_free:
 	kfree(usbhid);
-- 
2.13.0.506.g27d5fe0cd-goog
