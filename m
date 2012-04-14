From: Roland Stigge <stigge@antcom.de>
Subject: [PATCH 0/4] Second patchset for LPC32xx device tree conversion
Date: Sat, 14 Apr 2012 12:53:06 +0200
Message-ID: <1334400790-10892-1-git-send-email-stigge@antcom.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, axel.lin@gmail.com, broonie@opensource.wolfsonmicro.com, marek.vasut@gmail.com, thierry.reding@avionic-design.de, devel@driverdev.osuosl.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com
Cc: Roland Stigge <stigge@antcom.de>
List-Id: linux-input@vger.kernel.org

This is the second patch set for device tree conversion of mach-lpc32xx. It
builds upon and requires the previously posted first set of 8 plus the GPIO
patch.

It touches different subsystems (USB/OHCI, input/touchscreen, iio/adc and
mach-lpc32) to be picked by the respective subsystem maintainer and probably
applied separately. (?)

You can also pull from

  git://git.antcom.de/linux-2.6 lpc32xx/dt2

Signed-off-by: Roland Stigge <stigge@antcom.de>

--

Applies to v3.4-rc2

Roland Stigge (4):
 ohci-nxp: Device tree support
 input: Device tree support for LPC32xx touchscreen
 iio: lpc32xx-adc: Remove driver conflict due to device tree
 ARM: LPC32xx: Device tree support

 Documentation/devicetree/bindings/arm/lpc32xx-mic.txt               |   39 +
 Documentation/devicetree/bindings/arm/lpc32xx.txt                   |    8 
 Documentation/devicetree/bindings/input/touchscreen/lpc32xx-tsc.txt |   16 
 Documentation/devicetree/bindings/usb/ohci-nxp.txt                  |   16 
 arch/arm/Kconfig                                                    |    1 
 arch/arm/boot/dts/lpc32xx.dtsi                                      |  303 ++++++++++
 arch/arm/boot/dts/phy3250.dts                                       |  108 +++
 arch/arm/mach-lpc32xx/Kconfig                                       |   26 
 arch/arm/mach-lpc32xx/clock.c                                       |   77 +-
 arch/arm/mach-lpc32xx/common.c                                      |  192 ------
 arch/arm/mach-lpc32xx/common.h                                      |   14 
 arch/arm/mach-lpc32xx/irq.c                                         |   78 +-
 arch/arm/mach-lpc32xx/phy3250.c                                     |  146 ++--
 drivers/input/touchscreen/lpc32xx_ts.c                              |   10 
 drivers/staging/iio/adc/Kconfig                                     |    8 
 drivers/usb/host/ohci-nxp.c                                         |   68 +-
 16 files changed, 709 insertions(+), 401 deletions(-)
