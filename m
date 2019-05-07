From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] hid: fix hid-logitech-dj build error
Date: Mon, 6 May 2019 18:12:33 -0700
Message-ID: <e2154a13-0ec5-d39c-52cf-db98867b0496@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, kbuild test robot <lkp@intel.com>
List-Id: linux-input@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error in hid-logitech-dj by making it depend on
USB_HID, like several other HID drivers do.

Fixes this build error:

ERROR: "usb_hid_driver" [drivers/hid/hid-logitech-dj.ko] undefined!

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/hid/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2019-0425-1630.orig/drivers/hid/Kconfig
+++ mmotm-2019-0425-1630/drivers/hid/Kconfig
@@ -522,6 +522,7 @@ config HID_LOGITECH
 config HID_LOGITECH_DJ
 	tristate "Logitech Unifying receivers full support"
 	depends on HIDRAW
+	depends on USB_HID
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
 	---help---
