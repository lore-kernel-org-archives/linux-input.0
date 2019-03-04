From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: raspberrypi-ts: select CONFIG_INPUT_POLLDEV
Date: Mon,  4 Mar 2019 20:57:53 +0100
Message-ID: <20190304195845.1096214-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Zhu Yi <yi.zhu5@cn.bosch.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When CONFIG_INPUT_POLLDEV is disabled, we get a link error:

drivers/input/touchscreen/raspberrypi-ts.o: In function `rpi_ts_probe':
raspberrypi-ts.c:(.text+0xec): undefined reference to `devm_input_allocate_polled_device'
raspberrypi-ts.c:(.text+0xec): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `devm_input_allocate_polled_device'
raspberrypi-ts.c:(.text+0x19c): undefined reference to `input_register_polled_device'
raspberrypi-ts.c:(.text+0x19c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `input_register_polled_device'

Select that symbol like we do from the other similar drivers.

Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 7c597a49c265..7a4884ad198b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -699,6 +699,7 @@ config TOUCHSCREEN_EDT_FT5X06
 config TOUCHSCREEN_RASPBERRYPI_FW
 	tristate "Raspberry Pi's firmware base touch screen support"
 	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n && COMPILE_TEST)
+	select INPUT_POLLDEV
 	help
 	  Say Y here if you have the official Raspberry Pi 7 inch screen on
 	  your system.
-- 
2.20.0
