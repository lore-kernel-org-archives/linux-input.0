From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/3] Input: keyboard: Fix ChromeOS EC keyboard help message.
Date: Mon,  2 Jul 2018 12:22:01 +0200
Message-ID: <20180702102201.13461-4-enric.balletbo@collabora.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702102201.13461-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Cc: Gwendal Grignou <gwendal@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kernel@collabora.com, Guenter Roeck <groeck@google.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The cros-ec I2C and SPI transport drivers have been moved from MFD
subsystem to platform/chrome, at the same time, the config symbol
has been renamed and lost the MFD_ prefix So, update the help message
accordingly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 6bd97ffee761..4713957b0cbb 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -721,7 +721,7 @@ config KEYBOARD_CROS_EC
 	help
 	  Say Y here to enable the matrix keyboard used by ChromeOS devices
 	  and implemented on the ChromeOS EC. You must enable one bus option
-	  (MFD_CROS_EC_I2C or MFD_CROS_EC_SPI) to use this.
+	  (CROS_EC_I2C or CROS_EC_SPI) to use this.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_keyb.
-- 
2.18.0
