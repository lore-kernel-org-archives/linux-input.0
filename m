From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 05/46] pwm: introduce the pwm_args concept
Date: Tue, 12 Apr 2016 15:15:03 +0200
Message-ID: <20160412131503.GR18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-6-git-send-email-boris.brezillon@free-electrons.com>
 <20160412113912.GK18882@ulmo.ba.sec>
 <20160412150627.7084665d@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1250989285=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20160412150627.7084665d@bbrezillon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org, Jean-Christophe
List-Id: linux-input@vger.kernel.org


--===============1250989285==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TDVcAd+kFgbLxwBe"
Content-Disposition: inline


--TDVcAd+kFgbLxwBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 03:06:27PM +0200, Boris Brezillon wrote:
> On Tue, 12 Apr 2016 13:39:12 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Mar 30, 2016 at 10:03:28PM +0200, Boris Brezillon wrote:
> > > Currently the PWM core mixes the current PWM state with the per-platf=
orm
> > > reference config (specified through the PWM lookup table, DT definiti=
on or
> > > directly hardcoded in PWM drivers).
> > >=20
> > > Create a pwm_args struct to store this reference config, so that PWM =
users
> > > can differentiate the current config from the reference one.
> > >=20
> > > Patch all places where pwm->args should be initialized. We keep the
> > > pwm_set_polarity/period() calls until all PWM users are patched to
> > > use pwm_args instead of pwm_get_period/polarity().
> >=20
> > Perhaps a helper would be useful? Something like:
> >=20
> > 	static inline void
> > 	pwm_apply_args(struct pwm_device *pwm, const struct pwm_args *args)
> > 	{
> > 		pwm_set_duty_cycle(pwm, args->duty_cycle);
> > 		pwm_set_period(pwm, args->period);
> > 	}
> >=20
> > ? That would make it slightly easier to get rid of it again after all
> > clients have been converted.
> >=20
> > With the exception of pwm-clps711x all of these args are set at of_xlate
> > time (for DT) or from the lookup table in pwm_get() (for non-DT), so it
> > might even be possible to move this call to the core, so that removal of
> > it will be a one-liner.
>=20
> Okay, I think I misunderstood your suggestion. I thought you wanted
> this helper to set the reference config, but you actually want to apply
> a new state based on the PWM reference values.
>=20
> Except that pwm_args does not contain all the required information to
> apply a full config (args->duty_cycle and args->enable do not exist).
>=20
> This being said, in my v6 I moved the content of
> pwm_regulator_adjust_pwm_config() (patch 27) into a generic helper
> (pwm_adjust_config()). This helper is doing pretty much what you're
> suggesting here (but again, I'm not sure I correctly understood your
> suggestion :-/).

I'm not suggesting that pwm_apply_args() apply any state. I think we
both agreed earlier that the initial state (represented by pwm_args) was
never to be automatically applied.

What I was suggesting is that we move all the calls to pwm_set_period()
and pwm_set_duty_cycle() into a central location to make it easier to
remove them later in the series. This is really only temporary, so I
don't mind if we leave the calls sprinkled all over the place. At least
that way I hope we'll avoid confusion about what we're talking about =3D)

Thierry

--TDVcAd+kFgbLxwBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDPTXAAoJEN0jrNd/PrOh43wP/RW8nWeST0v0826zi4V45N1E
+TYv38nqsVYDmlhydRpEmUUzDp+i8P+jXS+FD48OsEByyvLzF6NOdtbD7H2no8zb
7o4G2twqZSwmNTKGcVVnDnvxqsTLRbB/zsSGqPO9NJ3Zu0wBS+0Xg5Vjqk6PmIRR
LSmzUQc5Cd6Mvb9aQqois5iJ0ivNQlB2YlJ8DYUXfPakj0cc5DpQg1D71c+jCsVL
REicaT6lu64/oaO2Jkth+9sGtJ3Z4mCoKCRtiAUKSLFojHnhX+ZbPS1U+vgip5UD
5h3NPaZytj2T/8TdmNceNF2uzpSq5+pc8N37CFpIxcmvhgb3DU24dVsOJyEW5PAk
QzYA5LDTmAQMsWDSDcoU1pUbxdfIRrIJ6q9kUgIX+aPIcKY8FIJ08XnX5k05Eyve
4qr29sV/0csHazKsdL94LhfxpmP87DNaLZP3CBXQt8R5PkYFpFY4tAVsYyiRdV0M
mo9yGfddFafGvqJbLSi19GhXW7tGoFsItMJB843opLZ77mE3VgpLHMCCr6MRGgjK
ZWWETRUpY2iF72dZc5eJH2cTacw4eAhkkwmi8xHy2aS2tvvzwUnMSagOF1S0NdSP
lAKl9Y1DcwSrlYNuDkeKIcMULMqC74RB+qM8kdpLiiH08xsBGEKftUt7NGeRg/nx
DCr+t7SdbH+cClDjpBxu
=AuFt
-----END PGP SIGNATURE-----

--TDVcAd+kFgbLxwBe--

--===============1250989285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1250989285==--
