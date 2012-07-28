From: Yann Cantin <yann.cantin@laposte.net>
Subject: [RFC ebeam PATCH 2/3] hid: hid-core.c: Blackist eBeam classic device.
Date: Sat, 28 Jul 2012 02:02:33 +0200
Message-ID: <1343433754-3887-3-git-send-email-yann.cantin@laposte.net>
References: <1343433754-3887-1-git-send-email-yann.cantin@laposte.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343433754-3887-1-git-send-email-yann.cantin@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, Yann Cantin <yann.cantin@laposte.net>
List-Id: linux-input@vger.kernel.org


Signed-off-by: Yann Cantin <yann.cantin@laposte.net>
---
 drivers/hid/hid-core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 500844f..1c03586 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1908,6 +1908,9 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
+#if defined(CONFIG_INPUT_EBEAM_USB_CLASSIC)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_EFI, USB_DEVICE_ID_EFI_CLASSIC) },
+#endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
-- 
1.7.10
