From: =?UTF-8?q?Istv=C3=A1n=20V=C3=A1radi?= <ivaradi@varadiistvan.hu>
Subject: [PATCH 2/2] HID: quirks: Set the INCREMENT_USAGE_ON_DUPLICATE quirk on Saitek X52
Date: Wed, 24 Jul 2019 20:09:18 +0200
Message-ID: <20190724180918.5987-1-ivaradi@varadiistvan.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: =?UTF-8?q?Istv=C3=A1n=20V=C3=A1radi?= <ivaradi@varadiistvan.hu>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Saitek X52 joystick has a pair of axes that are originally
(by the Windows driver) used as mouse pointer controls. The corresponding
usage->hid values are 0x50024 and 0x50026. Thus they are handled
as unknown axes and both get mapped to ABS_MISC. The quirk makes
the second axis to be mapped to ABS_MISC1 and thus made available
separately.

Signed-off-by: István Váradi <ivaradi@varadiistvan.hu>
---
 drivers/hid/hid-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 185a577c46f6..7b18adb4922f 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -141,6 +141,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RETROUSB, USB_DEVICE_ID_RETROUSB_SNES_RETROPAD), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RETROUSB, USB_DEVICE_ID_RETROUSB_SNES_RETROPORT), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
-- 
2.20.1
