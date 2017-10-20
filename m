From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 0/5] Introduce the Atmel PTC subsystem
Date: Fri, 20 Oct 2017 15:31:16 +0200
Message-ID: <20171020133121.7992-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:18546 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdJTNcX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Oct 2017 09:32:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>

Hi,

The Atmel Peripheral touch controller subsystem offers built-in hardware for
capacitive touch measurement on sensors that function as buttons, sliders and
wheels. It is available on SAMA5D2. Public documentation will be available
soon.

A firmware and a configuration file describing the topology and the parameters
of the sensor are loaded when probing the driver.

Changes:
- v3:
  - fix MAINTAINERS entry
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
  ARM: configs: at91: add PTC driver to sama5_defconfig

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
2.12.2

