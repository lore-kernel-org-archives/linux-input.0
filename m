From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: logitech-hidpp: remove support for the G700 over USB
Date: Tue, 13 Aug 2019 15:38:07 +0200
Message-ID: <20190813133807.12384-3-benjamin.tissoires@redhat.com>
References: <20190813133807.12384-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190813133807.12384-1-benjamin.tissoires@redhat.com>
Sender: stable-owner@vger.kernel.org
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The G700 suffers from the same issue than the G502:
when plugging it in, the driver tries to contact it but it fails.

This timeout is problematic as it introduce a delay in the boot,
and having only the mouse event node means that the hardware
macros keys can not be relayed to the userspace.

Link: https://github.com/libratbag/libratbag/issues/797
Fixes: 91cf9a98ae41 ("HID: logitech-hidpp: make .probe usbhid capable")
Cc: stable@vger.kernel.org # v5.2
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 343052b117a9..0179f7ed77e5 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3751,8 +3751,6 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ /* Logitech G403 Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
-	{ /* Logitech G700 Gaming Mouse over USB */
-	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC06B) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.19.2
