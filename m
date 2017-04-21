From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2 0/5] Introduce the Atmel PTC subsystem
Date: Fri, 21 Apr 2017 10:39:19 +0200
Message-ID: <20170421083924.15096-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-input@vger.kernel.org

Hi,

The Atmel Peripheral touch controller subsystem offers built-in hardware for
capacitive touch measurement on sensors that function as buttons, sliders and
wheels. It is available on SAMA5D2.

A firmware and a configuration file describing the topology and the parameters
of the sensor are loaded when probing the driver.

Changes:
- v2:
  - reorder patches to get the bindings documentation in first
  - remove the header from the uapi since it may change in the future. Declare
  only the few structures needed in the driver.
  - add this driver to the sama5_defconfig

Ludovic Desroches (5):
  dt-bindings: input: Add Atmel PTC subsystem bindings
  input: misc: introduce Atmel PTC driver
  MAINTAINERS: add Atmel PTC entries
  ARM: dts: at91: sama5d2: add PTC subsystem device
  ARM: at91/defconfig: add PTC driver to sama5_defconfig

 .../devicetree/bindings/input/atmel,ptc.txt        |  67 ++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  16 +
 arch/arm/configs/sama5_defconfig                   |   2 +
 drivers/input/misc/Kconfig                         |  12 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/atmel_ptc.c                     | 723 +++++++++++++++++++++
 7 files changed, 828 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/atmel,ptc.txt
 create mode 100644 drivers/input/misc/atmel_ptc.c

-- 
2.9.0
