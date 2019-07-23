From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: Apple SPI keyboard needs CRC16
Date: Tue, 23 Jul 2019 13:58:45 +0200
Message-ID: <20190723115905.2092687-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In some rare randconfig builds, CRC16 is disabled, which leads
to a link error:

drivers/input/keyboard/applespi.o: In function `applespi_send_cmd_msg':
applespi.c:(.text+0x449f): undefined reference to `crc16'
drivers/input/keyboard/applespi.o: In function `applespi_verify_crc':
applespi.c:(.text+0x7538): undefined reference to `crc16'

This symbol is meant to be selected for each user in Kconfig,
so do that here as well.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 8e9c3ea9d5e7..ebb19e21473e 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -76,6 +76,7 @@ config KEYBOARD_APPLESPI
 	depends on ACPI && EFI
 	depends on SPI
 	depends on X86 || COMPILE_TEST
+	select CRC16
 	help
 	  Say Y here if you are running Linux on any Apple MacBook8,1 or later,
 	  or any MacBookPro13,* or MacBookPro14,*.
-- 
2.20.0
