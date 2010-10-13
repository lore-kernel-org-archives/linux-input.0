From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [RFC, PATCH] HID: hid-sony, override usbhid_output_raw_report for Sixaxis
Date: Thu, 14 Oct 2010 00:54:40 +0200
Message-ID: <1287010481-8356-1-git-send-email-ospite@studenti.unina.it>
References: <4CB62F69.1070809@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:57487 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503Ab0JMWzL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 18:55:11 -0400
In-Reply-To: <4CB62F69.1070809@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, =?UTF-8?q?Mikko=20Virkkil=C3=A4?= <mvirkkil@cc.hut.fi>, falktx@gmail.com

Sony Sixaxis wants output reports on the control endpoint rather than
interrupt endpoint, so override usbhid_output_raw_report in order to
force this behaviour.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

This works indeed but there is obviously quite some code duplication with
usbhid_output_raw_report, if a change would be made there it had to be ported
here too. I still like the quirk approach better, but I am open to
suggestions.

Patch is on top of the previous series.

Thanks,
   Antonio

 drivers/hid/hid-sony.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 7b0c70a..d1007f4 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -46,6 +46,38 @@ static void sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	}
 }
 
+static int sixaxis_usb_output_raw_report(struct hid_device *hid, __u8 *buf,
+		size_t count, unsigned char report_type)
+{
+	struct usb_interface *intf = to_usb_interface(hid->dev.parent);
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct usb_host_interface *interface = intf->cur_altsetting;
+
+	int ret;
+	int skipped_report_id = 0;
+	int report_id = buf[0];
+
+	printk(KERN_DEBUG "%s: Overriding usbhid_output_raw_report\n", __func__);
+
+	if (buf[0] == 0x0) {
+		/* Don't send the Report ID */
+		buf++;
+		count--;
+		skipped_report_id = 1;
+	}
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+		HID_REQ_SET_REPORT,
+		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+		((report_type + 1) << 8) | report_id,
+		interface->desc.bInterfaceNumber, buf, count,
+		USB_CTRL_SET_TIMEOUT);
+	/* count also the report id, if this was a numbered report. */
+	if (ret > 0 && skipped_report_id)
+		ret++;
+
+	return ret;
+}
+
 /*
  * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
  * to "operational".  Without this, the ps3 controller will not report any
@@ -111,8 +143,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
-		hdev->quirks |= HID_QUIRK_FORCE_OUT_CONTROL_EP;
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
-- 
1.7.1

