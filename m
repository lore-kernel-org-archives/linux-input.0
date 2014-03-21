From: Yufeng Shen <miletus@chromium.org>
Subject: [PATCH] Add quirk HID_QUIRK_NO_INIT_REPORTS for RNDPLUS touchscreen
Date: Fri, 21 Mar 2014 15:39:58 -0400
Message-ID: <1395430798-25606-1-git-send-email-miletus@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f73.google.com ([209.85.220.73]:33615 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbaCUTkP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2014 15:40:15 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so348643pab.2
        for <linux-input@vger.kernel.org>; Fri, 21 Mar 2014 12:40:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Yufeng Shen <miletus@chromium.org>, adlr@chromium.org

There is timeout error during initialization:
kernel: [   14.167086] hid-multitouch 0003:2512:5003.0001: usb_submit_urb(ctrl) failed: -1
kernel: [   14.167135] hid-multitouch 0003:2512:5003.0001: timeout initializing reports
kernel: [   14.167407] input: RNDPLUS Co., LTD   PULSEIR TSR4601 as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3:1.0/input/input14
kernel: [   14.167975] cpufreq_interactive: monitoring input on RNDPLUS Co., LTD   PULSEIR TSR4601
kernel: [   14.168266] hid-multitouch 0003:2512:5003.0001: input,hiddev0,hidraw1: USB HID v1.10 Mouse [RNDPLUS Co., LTD   PULSEIR TSR4601] on usb-0000:00:1d.0-1.3/input0

Adding quirk HID_QUIRK_NO_INIT_REPORTS can solve the problem.

Signed-off-by: Yufeng Shen <miletus@chromium.org>
---
 drivers/hid/hid-ids.h           | 5 +++++
 drivers/hid/usbhid/hid-quirks.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f9304cb..772f937 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -442,6 +442,11 @@
 #define USB_DEVICE_ID_IDEACOM_IDC6650	0x6650
 #define USB_DEVICE_ID_IDEACOM_IDC6651	0x6651
 
+#define USB_VENDOR_ID_IDSPULSE          0x2512
+#define USB_DEVICE_ID_IDSPULSE_EVIR1    0x5003
+#define USB_DEVICE_ID_IDSPULSE_EVIR2    0x5004
+#define USB_DEVICE_ID_IDSPULSE_EVIR3    0x5005
+
 #define USB_VENDOR_ID_ILITEK		0x222a
 #define USB_DEVICE_ID_ILITEK_MULTITOUCH	0x0001
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 0db9a67..e59ad07 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -72,6 +72,9 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_IDSPULSE, USB_DEVICE_ID_IDSPULSE_EVIR1, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_IDSPULSE, USB_DEVICE_ID_IDSPULSE_EVIR2, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_IDSPULSE, USB_DEVICE_ID_IDSPULSE_EVIR3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GX680R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },
-- 
1.9.1.423.g4596e3a

