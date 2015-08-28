From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH v3 0/5] Add imx6ul touch screen controller support
Date: Fri, 28 Aug 2015 17:09:31 +0800
Message-ID: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
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
To: dmitry.torokhov@gmail.com, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, haibo.chen@freescale.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mpa@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

i.MX6UL contains a touch screen controller. This patch set add imx6ul
touch screen controller driver support.

Changes for v3:
-change GPIO xnur to active low.
-Add open and close API, and delete remove API.
-Use devm functions to allocate resource.
-Use gpiod method to request GPIO.

Changes for v2:
-Add property in devicetree documentation.
-Add tsc disable code in tsc_remove function.
-Remove some redundant code.

Haibo Chen (5):
  input: touchscreen: add imx6ul_tsc driver support
  Documentation: Detail permitted DT properties for the imx6ul_tsc
  ARM: imx_v6_v7_defconfig: enable imx6ul_tsc
  ARM: dts: imx6ul.dtsi: add TSC support
  ARM: dts: imx6ul-14x14-evk.dts: add tsc support

 .../bindings/input/touchscreen/imx6ul_tsc.txt      |  36 ++
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  18 +
 arch/arm/boot/dts/imx6ul.dtsi                      |  11 +
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/imx6ul_tsc.c             | 524 +++++++++++++++++++++
 7 files changed, 603 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
 create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c

-- 
1.9.1
