From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH 0/5] Add imx6ul touch screen controller support
Date: Mon, 27 Jul 2015 19:26:42 +0800
Message-ID: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, hans.verkuil@cisco.com, hadess@hadess.net, mchehab@osg.samsung.com, mamlinav@gmail.com, arnd@arndb.de, jonathar@broadcom.com, hdegoede@redhat.com, christian.gmeiner@gmail.com, scott.liu@emc.com.tw, geert@linux-m68k.org, benjamin.tissoires@redhat.com, sebastien.szymanski@armadeus.com, sbranden@broadcom.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

i.MX6UL contains a touch screen controller. This patch set add 
imx6ul touch screen controller driver support. 

Haibo Chen (5):
  input: touchscreen: add imx6ul_tsc driver support
  Documentation: Detail permitted DT properties for the imx6ul_tsc
  ARM: imx_v6_v7_defconfig: enable imx6ul_tsc
  ARM: dts: imx6ul.dtsi: add TSC support
  ARM: dts: imx6ul-14x14-evk.dts: add tsc support

 .../bindings/input/touchscreen/imx6ul_tsc.txt      |  14 +
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  18 +
 arch/arm/boot/dts/imx6ul.dtsi                      |  11 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/imx6ul_tsc.c             | 510 +++++++++++++++++++++
 7 files changed, 567 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
 create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c

-- 
1.9.1
