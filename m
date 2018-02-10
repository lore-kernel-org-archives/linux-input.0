From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v2 0/3] gpio-keys: Add support for specifying wakeup event action
Date: Sat, 10 Feb 2018 19:09:04 +0800
Message-ID: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com, dtor@google.com, dianders@google.com, Jeffy Chen <jeffy.chen@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Emil Renner Berthing <kernel@esmil.dk>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@lin>
List-Id: linux-input@vger.kernel.org


On chromebook kevin, we are using gpio-keys for pen insert event. But
we only want it to wakeup the system when ejecting the pen.

So we may need to change the interrupt trigger type during suspending.

Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

Jeffy Chen (3):
  Input: gpio-keys - add support for wakeup event action
  Input: gpio-keys - allow setting wakeup event action in DT
  arm64: dts: rockchip: Avoid wakeup when inserting the pen

 .../devicetree/bindings/input/gpio-keys.txt        |  8 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  2 ++
 drivers/input/keyboard/gpio_keys.c                 | 27 ++++++++++++++++++++++
 include/linux/gpio_keys.h                          |  2 ++
 include/uapi/linux/input-event-codes.h             |  9 ++++++++
 5 files changed, 48 insertions(+)

-- 
2.11.0
