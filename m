From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RFC PATCH v3 0/6] Report wakeup events in cros_ec_keyb and make cros-ec-spi wakeup optional
Date: Wed, 21 Jun 2017 18:01:47 +0800
Message-ID: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Vic Yang <victoryang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-arm-kerne
List-Id: linux-input@vger.kernel.org


We are enabling wakeup unconditionally for cros-ec-spi, it would be good to make it optional.

And we also need to enable wakeup for cros_ec_keyb, so the userspace could disable keyboard wakeup along with other cros-ec sub devices.


Changes in v3:
Use wakeup-source property to enable wakeup.
  Suggested by Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>.

Jeffy Chen (6):
  spi: core: add support for wakeup-source dts property
  dt-bindings: spi/core: add wakeup-source optional property
  ARM/arm64: dts: enable wakeup for cros-ec-spi devices
  mfd: cros ec: spi: remove unconditionally wakeup enable
  input: cros_ec_keyb: report wakeup events
  ARM: dts: cros-ec-keyboard: enable as wakeup source

 Documentation/devicetree/bindings/spi/spi-bus.txt |  1 +
 arch/arm/boot/dts/cros-ec-keyboard.dtsi           |  1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts        |  1 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts         |  1 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi   |  1 +
 arch/arm/boot/dts/tegra124-nyan.dtsi              |  1 +
 arch/arm/boot/dts/tegra124-venice2.dts            |  1 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts    |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      |  1 +
 drivers/input/keyboard/cros_ec_keyb.c             |  8 ++++++++
 drivers/mfd/cros_ec_spi.c                         |  2 --
 drivers/spi/spi.c                                 | 15 +++++++++++----
 12 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.1.4
