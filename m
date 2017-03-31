From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 0/4] Introduce the Atmel PTC subsystem
Date: Fri, 31 Mar 2017 17:22:46 +0200
Message-ID: <20170331152250.12758-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-input@vger.kernel.org

Hi,

The Atmel Peripheral touch controller subsystem offers built-in hardware for
capacitive touch measurment on sensors that function as buttons, sliders and
wheels. It is available on SAMA5D2.

A firmware and a configuration file describing the topology and the parameters
of the sensor are loaded when probing the driver.

Ludovic Desroches (4):
  input: misc: introduce Atmel PTC driver
  ARM: dts: at91: sama5d2: add PTC subsystem device
  MAINTAINERS: add Atmel PTC entries
  dt-bindings: input: Add Atmel PTC subsystem bindings

 .../devicetree/bindings/input/atmel,ptc.txt        |  67 +++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  16 +
 drivers/input/misc/Kconfig                         |  12 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/atmel_ptc.c                     | 651 +++++++++++++++++++++
 include/uapi/linux/atmel_ptc.h                     | 355 +++++++++++
 7 files changed, 1109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/atmel,ptc.txt
 create mode 100644 drivers/input/misc/atmel_ptc.c
 create mode 100644 include/uapi/linux/atmel_ptc.h

-- 
2.9.0
