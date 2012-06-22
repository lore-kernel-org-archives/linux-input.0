From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] HID: Fix the Kconfig option for generic device handling
Date: Fri, 22 Jun 2012 11:13:10 +0200
Message-ID: <1340356390-4614-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jan Beulich <jbeulich@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

The generic HID driver is obviously not a special driver, so move
it outside of the special drivers menu. Explain the usage and make
the default follow the HID setting. This should simplify migration
from older kernels.

Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Jiri,

As pointed out by Jan Beulich, the generic hid driver Kconfig option
is confusing. This patch ought to fix most of the concerns. For 3.5.

Thanks,
Henrik

 drivers/hid/Kconfig |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 034c80a..fabf817 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -61,21 +61,22 @@ config HIDRAW
 
 source "drivers/hid/usbhid/Kconfig"
 
-menu "Special HID drivers"
-	depends on HID
-
 config HID_GENERIC
 	tristate "Generic HID driver"
 	depends on HID
-	default y
+	default HID
 	---help---
-	Support for generic HID devices.
+	Support for generic devices on the HID bus. This includes most
+	keyboards and mice, joysticks, tablets and digitizers.
 
 	To compile this driver as a module, choose M here: the module
 	will be called hid-generic.
 
 	If unsure, say Y.
 
+menu "Special HID drivers"
+	depends on HID
+
 config HID_A4TECH
 	tristate "A4 tech mice" if EXPERT
 	depends on USB_HID
-- 
1.7.10.4
