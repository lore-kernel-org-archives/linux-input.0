From: Alec Moskvin <alecmn@gmail.com>
Subject: [PATCH 1/1] hid_wiimote: add INPUT_FF_MEMLESS dependency
Date: Sat, 24 Dec 2011 11:42:06 -0500
Message-ID: <1324744926-24793-1-git-send-email-alecmn@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alec Moskvin <alecmn@gmail.com>
List-Id: linux-input@vger.kernel.org

This fixes build error:
...
CRC 17a7c33e
Kernel: arch/x86/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST 7 modules
ERROR: "input_ff_create_memless" [drivers/hid/hid-wiimote.ko]
undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Alec Moskvin <alecmn@gmail.com>
---
 drivers/hid/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 22a4a05..332c22a 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -620,6 +620,7 @@ config HID_WIIMOTE
 	depends on BT_HIDP
 	depends on LEDS_CLASS
 	select POWER_SUPPLY
+	select INPUT_FF_MEMLESS
 	---help---
 	Support for the Nintendo Wii Remote bluetooth device.
 
-- 
1.7.8.1
