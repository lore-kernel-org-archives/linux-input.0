From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RESEND PATCH v4 0/4] Set name of regmap_config
Date: Fri,  9 Mar 2018 16:43:47 +0800
Message-ID: <20180309084351.32009-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, broonie@kernel.org, alexandre.belloni@bootlin.com
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Emil Renner Berthing <kernel@esmil.dk>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-arm-ke
List-Id: linux-input@vger.kernel.org


After 9b947a13e7f6 ("regmap: use debugfs even when no device"), we are
allowing regmap to create debugfs without a valid device. Some of them
would end up using "dummy*" as debugfs name.

This series try to set names in some regmap_config to avoid that.


Changes in v4:
Not to use rtc dev to init regmap, the gpbr is not directly related to
the rtc.

Changes in v3:
Modify commit message.

Jeffy Chen (4):
  mfd: syscon: Set name of regmap_config
  rtc: at91sam9: Set name of regmap_config
  clk: lpc32xx: Set name of regmap_config
  ARM: rockchip: Set name of regmap_config

 arch/arm/mach-rockchip/platsmp.c | 1 +
 drivers/clk/nxp/clk-lpc32xx.c    | 1 +
 drivers/mfd/syscon.c             | 1 +
 drivers/rtc/rtc-at91sam9.c       | 1 +
 4 files changed, 4 insertions(+)

-- 
2.11.0
