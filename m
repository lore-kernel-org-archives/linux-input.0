From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [trivial] HID: Typo s/to back 0/back to 0/
Date: Mon, 27 May 2019 14:25:32 +0200
Message-ID: <20190527122532.6084-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

Fix a silly word ordering typo.

Fixes: 42337b9d4d958daa ("HID: add driver for U2F Zero built-in LED and RNG")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c3c390ca369022f0..735223f90035b2bf 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1028,7 +1028,7 @@ config HID_U2FZERO
 
 	  U2F Zero only supports blinking its LED, so this driver doesn't
 	  allow setting the brightness to anything but 1, which will
-	  trigger a single blink and immediately reset to back 0.
+	  trigger a single blink and immediately reset back to 0.
 
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
-- 
2.17.1
