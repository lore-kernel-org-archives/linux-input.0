From: Roland Stigge <stigge@antcom.de>
Subject: [PATCH v5 0/10] Second patchset for LPC32xx device tree conversion
Date: Sat, 21 Apr 2012 11:34:18 +0200
Message-ID: <1335000868-21974-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: arm@kernel.org, thierry.reding@avionic-design.de, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, axel.lin@gmail.com, broonie@opensource.wolfsonmicro.com, marek.vasut@gmail.com, devel@driverdev.osuosl.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com
Cc: Roland Stigge <stigge@antcom.de>
List-Id: linux-input@vger.kernel.org

This is the second patch set for device tree conversion of mach-lpc32xx. It
builds upon and requires the previously posted first set of 8 plus the GPIO
patch.

It touches different subsystems (USB/OHCI, input/touchscreen, iio/adc and
mach-lpc32xx) to be picked by the respective subsystem maintainer and applied
separately.

Signed-off-by: Roland Stigge <stigge@antcom.de>

--

Applies to v3.4-rc3

Changes since v4:
* phy3250.dts: Changed clock-frequency to decimal
* common.c/i2c: Rebased on changes in first patch set
* lpc32xx.dtsi: Adjusted compatible strings to non-wildcard versions

Roland Stigge (10):
ohci-nxp: Driver cleanup
ohci-nxp: Device tree support
ARM: LPC32xx: clock.c cleanup
ARM: LPC32xx: clock.c dma adjustment
ARM: LPC32xx: Remove obsolete platform Kconfig
input: Device tree support for LPC32xx touchscreen
iio: lpc32xx-adc: Remove driver conflict due to device tree
ARM: LPC32xx: DTS files for device tree conversion
ARM: LPC32xx: Device tree support
ARM: LPC32xx: Move common code to common.c

 Documentation/devicetree/bindings/arm/lpc32xx-mic.txt               |   38 +
 Documentation/devicetree/bindings/arm/lpc32xx.txt                   |    8 
 Documentation/devicetree/bindings/input/touchscreen/lpc32xx-tsc.txt |   16 
 Documentation/devicetree/bindings/usb/ohci-nxp.txt                  |   16 
 arch/arm/Kconfig                                                    |    1 
 arch/arm/boot/dts/lpc32xx.dtsi                                      |  303 ++++++++++
 arch/arm/boot/dts/phy3250.dts                                       |  115 +++
 arch/arm/mach-lpc32xx/Kconfig                                       |   26 
 arch/arm/mach-lpc32xx/clock.c                                       |   77 +-
 arch/arm/mach-lpc32xx/common.c                                      |  192 ------
 arch/arm/mach-lpc32xx/common.h                                      |   14 
 arch/arm/mach-lpc32xx/irq.c                                         |   78 +-
 arch/arm/mach-lpc32xx/phy3250.c                                     |  146 ++--
 drivers/input/touchscreen/lpc32xx_ts.c                              |   10 
 drivers/staging/iio/adc/Kconfig                                     |    8 
 drivers/usb/host/ohci-nxp.c                                         |   55 +
 16 files changed, 704 insertions(+), 399 deletions(-)
