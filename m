From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/5] AM437x SK: Add power-button support
Date: Fri, 26 Dec 2014 13:28:19 -0600
Message-ID: <1419622104-25812-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-input@vger.kernel.org

Hi,

the following patches add tps65218 power button support and
make it usable with AM437x SK.

Developed and tested on top of v3.19-rc1. Logs at [1]

[1] http://hastebin.com/ecopenuqot

Felipe Balbi (5):
  mfd: tps65218: make INT[12] and STATUS registers volatile
  mfd: tps65218: make INT1 our status_base register
  input: misc: add tps65218 power button driver
  arm: boot: dts: am437x-sk: add power button binding
  arm: omap2plus_defconfig: enable TPS65218 power button

 arch/arm/boot/dts/am437x-sk-evm.dts     |   5 ++
 arch/arm/configs/omap2plus_defconfig    |   1 +
 drivers/input/misc/Kconfig              |  10 +++
 drivers/input/misc/Makefile             |   1 +
 drivers/input/misc/tps65218-pwrbutton.c | 135 ++++++++++++++++++++++++++++++++
 drivers/mfd/tps65218.c                  |  12 +++
 6 files changed, 164 insertions(+)
 create mode 100644 drivers/input/misc/tps65218-pwrbutton.c

-- 
2.2.0

