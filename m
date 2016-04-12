From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 03/46] backlight: lm3630a_bl: stop
 messing with the pwm->period field
Date: Tue, 12 Apr 2016 13:08:09 +0200
Message-ID: <20160412110809.GI18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1815492811=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
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


--===============1815492811==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:03:26PM +0200, Boris Brezillon wrote:
> pwm->period field is not supposed to be changed by PWM users. The only
> ones authorized to change it are the PWM core and PWM drivers.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Thierry

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDNcZAAoJEN0jrNd/PrOhTYQQAJIra7IMWwqrg+lUp7EqOQZY
eV/VGRUmo6g3HLR3dTRbwKUjKeOyq9hqA+tvfaM+XsB1/2Ts2hVQZLs/XfC7/WgE
3D0UifQLJgh0NwAg0LBYe0DIbTHKtNBsiga91l6LQV50hZWJeDXlgyY9y+kAnZEP
FTIZbgfnCfI6yuHMf8RFIOFEOnr+6pNXK3C47kFky1V9VoPTqS7rjtJ6uyu7HSYw
gtJWDXlu9UceaCWP8VUI6xaAxoh5II+oFzUUePTrssff1feTueIMNRGr4e4jY8e8
Sp97XG/YMUY06CYQNsPC7EEnL4moGDbavsegDYOl0IgdKGP14soC++Vf5jwYMZ/p
hIxv771iBUD0nhXzxMyL+mXenEnNqFhAn5GaJuFv3NpIRbDwhxageXibLRlGfUDJ
G9nJywOwN4JIhBslQFFuelx+lLhWRVOdIArviNFYy+RcgyMcQ5MHVfPaJA56Z36V
D/axa/U7ONgs4atxdcNXHhDxiGd3ts4/2YPlSFieP7AE6fyToKwvBTzLLKaXxiNG
F1PrDU+ybLuiTJOXYu7dH7/vA+X2sbMxeIqm14wI9Kp5usguogRbayx/pBFmRHVy
qs+Jz3p01xbvfTEpevyF/aWMSa6nmv+njc1kFfUXrv858Y3ztkmF8pYhyVkvQV1+
MKYEQnJf9T0KJwmjgGKM
=BxVW
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--

--===============1815492811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1815492811==--
