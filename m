From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 0/2] input: touchscreen: atmel_mxt_ts: Add Device Tree support
Date: Thu, 04 Apr 2013 18:14:24 +0200
Message-ID: <1365092066-31753-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com, kyungmin.park@samsung.com, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-input@vger.kernel.org

This series is an attempt to add Device Tree support to Atmel maXtouch
touchscreen driver.

First patch adds support for VDD voltage regulator to get operating voltage
using regulator API instead of a driver specific field in platform data.

Second patch implements Device Tree bindings for the driver and adds
respective documentation.

Tested on Universal C210 board.

Tomasz Figa (2):
  input: touchscreen: atmel_mxt_ts: Add support for voltage regulator
  input: touchscreen: atmel_mxt_ts: Add support for Device Tree

 .../bindings/input/touchscreen/atmel_mxt_ts.txt    | 51 ++++++++++++
 arch/arm/mach-exynos/mach-nuri.c                   | 29 ++++++-
 arch/arm/mach-exynos/mach-universal_c210.c         | 29 ++++++-
 arch/arm/mach-s5pv210/mach-goni.c                  | 28 ++++++-
 drivers/input/touchscreen/atmel_mxt_ts.c           | 97 ++++++++++++++++++++--
 include/linux/i2c/atmel_mxt_ts.h                   |  1 -
 6 files changed, 226 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/atmel_mxt_ts.txt

-- 
1.8.1.5
