From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 0/3] gpio-keys: Add support for specifying wakeup interrupt trigger type
Date: Fri,  9 Feb 2018 19:55:07 +0800
Message-ID: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com, dtor@google.com, dianders@google.com, Jeffy Chen <jeffy.chen@rock-chips.com>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Emil Renner Berthing <kernel@esmil.dk>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.


Jeffy Chen (3):
  Input: gpio-keys - add support for wakeup interrupt trigger type
  Input: gpio-keys - allow setting wakeup interrupt trigger type in DT
  arm64: dts: rockchip: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt          |  9 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts    |  2 ++
 drivers/input/keyboard/gpio_keys.c                   | 20 ++++++++++++++++++--
 include/linux/gpio_keys.h                            |  2 ++
 4 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.11.0
