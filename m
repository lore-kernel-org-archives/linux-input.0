From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH] HID: logitech-dj: Fix build error without CONFIG_USB_HID
Date: Thu, 25 Apr 2019 15:39:42 +0800
Message-ID: <20190425073942.36980-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

During randconfig builds, I occasionally run into an invalid configuration

drivers/hid/hid-logitech-dj.o: In function `logi_dj_probe':
hid-logitech-dj.c:(.text+0x32dc): undefined reference to `usb_hid_driver'

This is because CONFIG_USB_HID is not set, So this
patch selects it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: da12b224b7d5 ("HID: logitech-dj: deal with some KVMs adding an extra interface to the usbdev")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 76d8206..c3c390c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -521,6 +521,7 @@ config HID_LOGITECH
 
 config HID_LOGITECH_DJ
 	tristate "Logitech Unifying receivers full support"
+	depends on USB_HID
 	depends on HIDRAW
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
-- 
2.7.4
