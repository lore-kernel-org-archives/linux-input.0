From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 0/3] platform/chrome: mfd: Move cros-ec transport drivers to
 drivers/platform
Date: Mon,  2 Jul 2018 12:21:58 +0200
Message-ID: <20180702102201.13461-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Cc: Gwendal Grignou <gwendal@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Tony Lindgren <tony@atomide.com>, Stefan Agner <stefan@agner.ch>, Bjorn Andersson <bjorn.andersson@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, kernel@collabora.com, Shuah Khan <shuah@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Guenter Roeck <groeck@google.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Wei Xu <xuwei5@hisilicon.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-input@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Simon Horman <horms+renesas@verge.net.au>, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Anand Moon <linux.amoon@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi,

The cros-ec transport drivers are placed in two subsystems, in MFD and
in platform/chrome. As far as I know there is no reason for this, so,
move the I2C and the SPI cros-ec transport driver from the MFD subsystem
to the platform/chrome. The series also removes the MFD_ prefix for the
Kconfig symbols, modifies the defconfigs that used these symbols and
fixes the KEYBOARD_CROS_EC Kconfig help.

Best regards,
 Enric

Enric Balletbo i Serra (3):
  platform/chrome: Move cros-ec transport drivers to drivers/platform.
  arm/arm64: configs: Remove the MFD_ prefix for MFD_CROS_EC_I2C/SPI
    symbols.
  Input: keyboard: Fix ChromeOS EC keyboard help message.

 arch/arm/configs/exynos_defconfig             |  4 ++--
 arch/arm/configs/multi_v7_defconfig           |  4 ++--
 arch/arm/configs/pxa_defconfig                |  4 ++--
 arch/arm64/configs/defconfig                  |  4 ++--
 drivers/input/keyboard/Kconfig                |  2 +-
 drivers/mfd/Kconfig                           | 20 -------------------
 drivers/mfd/Makefile                          |  2 --
 drivers/platform/chrome/Kconfig               | 20 +++++++++++++++++++
 drivers/platform/chrome/Makefile              |  2 ++
 .../{mfd => platform/chrome}/cros_ec_i2c.c    |  0
 .../{mfd => platform/chrome}/cros_ec_spi.c    |  0
 11 files changed, 31 insertions(+), 31 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec_i2c.c (100%)
 rename drivers/{mfd => platform/chrome}/cros_ec_spi.c (100%)

-- 
2.18.0
