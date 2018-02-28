From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 05/10] pwm: add PWM mode to pwm_config()
Date: Wed, 28 Feb 2018 20:44:30 +0100
Message-ID: <20180228194429.GD22932@mithrandir>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0117355413=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1519300881-8136-6-git-send-email-claudiu.beznea@microchip.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: mark.rutland@arm.com, milo.kim@ti.com, linux-fbdev@vger.kernel.org, sean@mess.org, devicetree@vger.kernel.org, airlied@linux.ie, mturquette@baylibre.com, kamil@wypas.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, pavel@ucw.cz, lee.jones@linaro.org, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, daniel.thompson@linaro.org, linux-samsung-soc@vger.kernel.org, shc_work@mail.ru, corbet@lwn.net, linux-doc@vger.kernel.org, linux@armlinux.org.uk, krzk@kernel.org, kgene@kernel.org, linux-input@vger.kernel.org, linux@roeck-us.net, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, jdelvare@suse.com, b.zolnierkie@samsung.com, intel-gfx@lists.freedesktop.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, rodrigo.vivi@intel.com, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.or
List-Id: linux-input@vger.kernel.org


--===============0117355413==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 02:01:16PM +0200, Claudiu Beznea wrote:
> Add PWM mode to pwm_config() function. The drivers which uses pwm_config()
> were adapted to this change.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-s3c24xx/mach-rx1950.c  | 11 +++++++++--
>  drivers/bus/ts-nbus.c                |  2 +-
>  drivers/clk/clk-pwm.c                |  3 ++-
>  drivers/gpu/drm/i915/intel_panel.c   | 17 ++++++++++++++---
>  drivers/hwmon/pwm-fan.c              |  2 +-
>  drivers/input/misc/max77693-haptic.c |  2 +-
>  drivers/input/misc/max8997_haptic.c  |  6 +++++-
>  drivers/leds/leds-pwm.c              |  5 ++++-
>  drivers/media/rc/ir-rx51.c           |  5 ++++-
>  drivers/media/rc/pwm-ir-tx.c         |  5 ++++-
>  drivers/video/backlight/lm3630a_bl.c |  4 +++-
>  drivers/video/backlight/lp855x_bl.c  |  4 +++-
>  drivers/video/backlight/lp8788_bl.c  |  5 ++++-
>  drivers/video/backlight/pwm_bl.c     | 11 +++++++++--
>  drivers/video/fbdev/ssd1307fb.c      |  3 ++-
>  include/linux/pwm.h                  |  6 ++++--
>  16 files changed, 70 insertions(+), 21 deletions(-)

I don't think it makes sense to leak mode support into the legacy API.
The pwm_config() function is considered legacy and should eventually go
away. As such it doesn't make sense to integrate a new feature such as
PWM modes into it. All users of pwm_config() assume normal mode, and
that's what pwm_config() should provide.

Anyone that needs something other than normal mode should use the new
atomic PWM API.

Thierry

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqXBpoACgkQ3SOs138+
s6GLrhAAuRLaoghLArJWd7JYjdi7JlVWdIer5OiGaY3qO2G2OnJBxBWctd+VJ/t+
uTtC29oNgm7jzgwf7JiGUm3yVMx/S2rW6+s0JbeVp0xXBO7Lhd6EMZbSzOC3BBHB
0RyqgEGoZRfaI++4LM9L6sMvHQ5lEt0PimKAug9MsXsxWOW88slB4Ll9Z/APl/Wr
mCWW1qN2fs2F1hQdFAhE3ujMogEfRuW0/KwFkHa223ud/i1LJNe0jkIMnEYgWsCX
x1my31QvhyMRxYQwp1FA3eAqHGnWo3yTXZYOYGBc3nJdm0UVQL59XX0UXduCVVPo
YDwxSRZn04DADA5nBXplNIpG7qsELxrLUXcnB84D6Jstz17m4NSDknnHh/XkHgS7
Q0SM/+jDqLzHHlhnCWmAJ9SBbvvrUDnXlCoMzmDoTzGN7fp74wFT1flIXILA91Lh
AF/x1TWs5HV78+fowFUWVK2Fhc0zyNGYmDd7wQ2jlKjxETDcmXH+IoRHn48bcuio
FphZkj4Un2o5X9O7jSRi5vHuJcmlHT30NsWgMduK9dWzq0wXih6zH/TTQk8N2rHM
2+eijd/BDQum2RuK8mg2klvye5jrXp7f+iT305hUYoz4fmmMddqFiybi1nUHkTkA
UG05BweYZ6hjEkpavMW0zeGEvWuZWwZZNHzKaOpJ/aRseA7Jpb0=
=zbqh
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--

--===============0117355413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0117355413==--
