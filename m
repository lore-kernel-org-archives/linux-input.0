From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] HID: hid-sony, override usbhid_output_raw_report for Sixaxis
Date: Tue, 19 Oct 2010 16:13:10 +0200
Message-ID: <1287497590-10818-1-git-send-email-ospite@studenti.unina.it>
References: <4CB71D2D.90200@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:45362 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586Ab0JSONq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Oct 2010 10:13:46 -0400
In-Reply-To: <4CB71D2D.90200@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Alan Ott <alan@signal11.us>, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, falktx@gmail.com

Override usbhid_output_raw_report in order to force output reports (sent
via hidraw_write, for instance) on the control endpoint.

The Sony Sixaxis (PS3 Controller) accepts output reports only on the
control endpoint, it silently discards them when they arrive over the
interrupt endpoint where usbhid would normally deliver them.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Note to the interested people, this makes setting leds via hidraw finally
work. I can send the userspace code for that in a follow-up if you want me
to.

Thanks,
   Antonio Ospite
   http://ao2.it

 drivers/hid/hid-sony.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d61f268..0c164b3 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -46,6 +46,25 @@ static void sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	}
 }
 
+static int sixaxis_usb_output_raw_report(struct hid_device *hid, __u8 *buf,
+		size_t count, unsigned char report_type)
+{
+	struct usb_interface *intf = to_usb_interface(hid->dev.parent);
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct usb_host_interface *interface = intf->cur_altsetting;
+	int report_id = buf[0];
+	int ret;
+
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+		HID_REQ_SET_REPORT,
+		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+		((report_type + 1) << 8) | report_id,
+		interface->desc.bInterfaceNumber, buf, count,
+		USB_CTRL_SET_TIMEOUT);
+
+	return ret;
+}
+
 /*
  * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
  * to "operational".  Without this, the ps3 controller will not report any
@@ -110,8 +129,10 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
-	if (sc->quirks & SIXAXIS_CONTROLLER_USB)
+	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
+	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
 	else
-- 
1.7.2.3

