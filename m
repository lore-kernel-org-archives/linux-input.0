From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 00/24] pwm: add support for atomic update
Date: Mon, 16 Nov 2015 09:56:23 +0100
Message-ID: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBU5UU2ZAKGQEDBIINNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>linu
List-Id: linux-input@vger.kernel.org

Hello,

This series adds support for atomic PWM update, or IOW, the capability
to update all the parameters of a PWM device (enabled/disabled, period,
duty and polarity) in one go.

Best Regards,

Boris

Changes since v3:
- rebased on pwm/for-next after pulling 4.4-rc1
- replace direct access to pwm fields by pwm_get/set_xxx() helpers, thus
  fixing some build errors
- split changes to allow each maintainer to review/ack or take the
  modification through its subsystem

Changes since v2:
- rebased on top of 4.3-rc2
- reintroduced pwm-regulator patches

Changes since v1:
- dropped applied patches
- squashed Heiko's fixes into the rockchip driver changes
- made a few cosmetic changes
- added kerneldoc comments
- added Heiko's patch to display more information in debugfs
- dropped pwm-regulator patches (should be submitted separately)

Boris Brezillon (23):
  pwm: rcar: make use of pwm_is_enabled()
  pwm: use pwm_get_xxx() helpers where appropriate
  clk: pwm: use pwm_get_xxx() helpers where appropriate
  hwmon: pwm-fan: use pwm_get_xxx() helpers where appropriate
  misc: max77693-haptic: use pwm_get_xxx() helpers where appropriate
  pwm: introduce default period and polarity concepts
  pwm: use pwm_get/set_default_xxx() helpers where appropriate
  leds: pwm: use pwm_get/set_default_xxx() helpers where appropriate
  regulator: pwm: use pwm_get/set_default_xxx() helpers where
    appropriate
  backlight: pwm: use pwm_get/set_default_xxx() helpers where
    appropriate
  fbdev: use pwm_get/set_default_xxx() helpers where appropriate
  misc: max77693: use pwm_get/set_default_xxx() helpers where
    appropriate
  hwmon: pwm-fan: use pwm_get/set_default_xxx() helpers where
    appropriate
  clk: pwm: use pwm_get/set_default_xxx() helpers where appropriate
  pwm: define a new pwm_state struct
  pwm: move the enabled/disabled info to pwm_state struct
  backlight: pwm_bl: remove useless call to pwm_set_period
  pwm: declare a default PWM state
  pwm: add the PWM initial state retrieval infra
  pwm: add the core infrastructure to allow atomic update
  pwm: rockchip: add initial state retrieval
  pwm: rockchip: add support for atomic update
  regulator: pwm: properly initialize the ->state field

Heiko St=C3=BCbner (1):
  pwm: add information about polarity, duty cycle and period to debugfs

 drivers/clk/clk-pwm.c                |  11 +--
 drivers/hwmon/pwm-fan.c              |  16 ++--
 drivers/input/misc/max77693-haptic.c |   9 +-
 drivers/leds/leds-pwm.c              |   2 +-
 drivers/pwm/core.c                   | 169 +++++++++++++++++++++++++++++++=
----
 drivers/pwm/pwm-crc.c                |   2 +-
 drivers/pwm/pwm-lpc18xx-sct.c        |   2 +-
 drivers/pwm/pwm-pxa.c                |   2 +-
 drivers/pwm/pwm-rcar.c               |   2 +-
 drivers/pwm/pwm-rockchip.c           | 119 +++++++++++++++++++-----
 drivers/pwm/pwm-sun4i.c              |   3 +-
 drivers/regulator/pwm-regulator.c    |  30 ++++++-
 drivers/video/backlight/lm3630a_bl.c |   4 +-
 drivers/video/backlight/pwm_bl.c     |  10 ++-
 drivers/video/fbdev/ssd1307fb.c      |   2 +-
 include/linux/pwm.h                  |  89 +++++++++++++++---
 16 files changed, 386 insertions(+), 86 deletions(-)

--=20
2.1.4

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
