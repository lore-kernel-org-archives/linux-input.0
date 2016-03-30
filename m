From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 00/46] pwm: add support for atomic update
Date: Wed, 30 Mar 2016 22:18:43 +0200
Message-ID: <20160330221843.45f2abf7@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCIPJ6FA2QLBBMHJ6C3QKGQEGUIWJFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-fbdev@vge
List-Id: linux-input@vger.kernel.org

+Doug (sorry, I forgot to add you in to the recipient list)

On Wed, 30 Mar 2016 22:03:23 +0200
Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hello,
>=20
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.
>=20
> It also adds support for initial PWM state retrieval (or hardware readout=
),
> which should allow smooth handover between the bootloader and Linux. For
> example, critical PWM users (like critical regulators controlled by a PWM=
)
> can query the current PWM state, and adapt the PWM config without having
> to disable/enable the PWM, or abruptly change the period/dutycyle/polarit=
y
> config.
>=20
> Thierry, I hope this version meets your expectations, if that's not the
> case, could you let me know quickly so I can adjust the implementation
> accordingly (I'd really like to get most of those changes in 4.7).

Oh, I forgot to mention that I'm not necessarily expecting all those
patches to be taken in one go. We only need patches 1 to 31 for the
problem exposed by Doug. Patch 32 is deprecating the non-atomic APIs and
patches 33 to 46 are switching all PWM users to the atomic APIs to avoid
compilation warnings.
It's up to you to decide which you'd like to take.

>=20
> Best Regards,
>=20
> Boris
>=20
> Changes since v4:
> - introduce pwm_args to expose per-board/platform config
> - deprecate non-atomic APIs
> - implement non-atomic functions as wrappers around atomic ones
> - patch all PWM users to use the atomic API
> - rename the ->reset_state() hook into ->get_state()
> - drop most acks
> - rework PWM config in the pwm-regulator driver
> - patch sun4i and sti PWM drivers to support HW readout
>=20
> Changes since v3:
> - rebased on pwm/for-next after pulling 4.4-rc1
> - replace direct access to pwm fields by pwm_get/set_xxx() helpers, thus
>   fixing some build errors
> - split changes to allow each maintainer to review/ack or take the
>   modification through its subsystem
>=20
> Changes since v2:
> - rebased on top of 4.3-rc2
> - reintroduced pwm-regulator patches
>=20
> Changes since v1:
> - dropped applied patches
> - squashed Heiko's fixes into the rockchip driver changes
> - made a few cosmetic changes
> - added kerneldoc comments
> - added Heiko's patch to display more information in debugfs
> - dropped pwm-regulator patches (should be submitted separately)
>=20
> *** BLURB HERE ***
>=20
> Boris Brezillon (45):
>   pwm: rcar: make use of pwm_is_enabled()
>   backlight: pwm_bl: remove useless call to pwm_set_period()
>   backlight: lm3630a_bl: stop messing with the pwm->period field
>   pwm: get rid of pwm->lock
>   pwm: introduce the pwm_args concept
>   pwm: use pwm_get/set_xxx() helpers where appropriate
>   clk: pwm: use pwm_get_args() where appropriate
>   hwmon: pwm-fan: use pwm_get_args() where appropriate
>   misc: max77693-haptic: use pwm_get_args() where appropriate
>   leds: pwm: use pwm_get_args() where appropriate
>   regulator: pwm: use pwm_get_args() where appropriate
>   fbdev: ssd1307fb: use pwm_get_args() where appropriate
>   backlight: pwm_bl: use pwm_get_args() where appropriate
>   pwm: keep PWM state in sync with hardware state
>   pwm: introduce the pwm_state concept
>   pwm: move the enabled/disabled info into pwm_state
>   pwm: add the PWM initial state retrieval infra
>   pwm: add the core infrastructure to allow atomic update
>   pwm: switch to the atomic API
>   pwm: rockchip: add initial state retrieval
>   pwm: rockchip: avoid glitches on already running PWMs
>   pwm: rockchip: add support for atomic update
>   pwm: sti: add support for initial state retrieval
>   pwm: sti: avoid glitches on already running PWMs
>   pwm: sun4i: implement hardware readout
>   regulator: pwm: adjust PWM config at probe time
>   regulator: pwm: swith to the atomic PWM API
>   regulator: pwm: properly initialize the ->state field
>   regulator: pwm: retrieve correct voltage
>   pwm: update documentation
>   pwm: deprecate pwm_config(), pwm_enable() and pwm_disable()
>   pwm: replace pwm_disable() by pwm_apply_state()
>   clk: pwm: switch to the atomic API
>   hwmon: pwm-fan: switch to the atomic API
>   input: misc: max77693: switch to the atomic API
>   input: misc: max8997: switch to the atomic PWM API
>   input: misc: pwm-beeper: switch to the atomic PWM API
>   leds: pwm: switch to the atomic PWM API
>   backlight: lm3630a: switch to the atomic PWM API
>   backlight: lp855x: switch to the atomic PWM API
>   backlight: lp8788: switch to the atomic PWM API
>   backlight: pwm_bl: switch to the atomic PWM API
>   video: ssd1307fb: switch to the atomic PWM API
>   drm: i915: switch to the atomic PWM API
>   ARM: s3c24xx: rx1950: switch to the atomic PWM API
>=20
> Heiko St=C3=BCbner (1):
>   pwm: add information about polarity, duty cycle and period to debugfs
>=20
>  Documentation/pwm.txt                |  27 +++-
>  arch/arm/mach-s3c24xx/mach-rx1950.c  |  17 +-
>  drivers/clk/clk-pwm.c                |  36 ++++-
>  drivers/gpu/drm/i915/intel_panel.c   |  39 +++--
>  drivers/hwmon/pwm-fan.c              |  88 ++++++----
>  drivers/input/misc/max77693-haptic.c |  28 +++-
>  drivers/input/misc/max8997_haptic.c  |  23 ++-
>  drivers/input/misc/pwm-beeper.c      |  46 ++++--
>  drivers/leds/leds-pwm.c              |  15 +-
>  drivers/pwm/core.c                   | 186 ++++++++++-----------
>  drivers/pwm/pwm-clps711x.c           |   2 +-
>  drivers/pwm/pwm-crc.c                |   2 +-
>  drivers/pwm/pwm-lpc18xx-sct.c        |   9 +-
>  drivers/pwm/pwm-lpc32xx.c            |   9 +-
>  drivers/pwm/pwm-omap-dmtimer.c       |   2 +-
>  drivers/pwm/pwm-pxa.c                |   2 +-
>  drivers/pwm/pwm-rcar.c               |   2 +-
>  drivers/pwm/pwm-rockchip.c           | 156 +++++++++++++++---
>  drivers/pwm/pwm-spear.c              |   9 +-
>  drivers/pwm/pwm-sti.c                |  67 +++++++-
>  drivers/pwm/pwm-sun4i.c              |  73 ++++++---
>  drivers/pwm/sysfs.c                  |  98 ++++++++---
>  drivers/regulator/pwm-regulator.c    | 151 ++++++++++++++---
>  drivers/video/backlight/lm3630a_bl.c |  15 +-
>  drivers/video/backlight/lp855x_bl.c  |  15 +-
>  drivers/video/backlight/lp8788_bl.c  |  17 +-
>  drivers/video/backlight/pwm_bl.c     |  51 +++---
>  drivers/video/fbdev/ssd1307fb.c      |  28 +++-
>  include/linux/pwm.h                  | 303 ++++++++++++++++++++++++++---=
------
>  29 files changed, 1096 insertions(+), 420 deletions(-)
>=20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
