From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 01/46] pwm: rcar: make use of
	pwm_is_enabled()
Date: Tue, 12 Apr 2016 13:01:52 +0200
Message-ID: <20160412110152.GG18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2081931328=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1459368249-13241-2-git-send-email-boris.brezillon@free-electrons.com>
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


--===============2081931328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:03:24PM +0200, Boris Brezillon wrote:
> Commit 5c31252c4a86 ("pwm: Add the pwm_is_enabled() helper") introduced a
> new function to test whether a PWM device is enabled or not without
> manipulating PWM internal fields.
> Hiding this is necessary if we want to smoothly move to the atomic PWM
> config approach without impacting PWM drivers.
> Fix this driver to use pwm_is_enabled() instead of directly accessing the
> ->flags field.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDNWfAAoJEN0jrNd/PrOhoj8QAK4UAz8ugmWPS9xJCHiJvCsZ
cz4yyDzOQVaVTNHNEruFT+v1XMvaogalyvNxUR0z8fXpRzAj9vZyGm3VXD2CJcam
/FvxqFKAodcSy5PjYSLoD/0bpeYpAiILFhxPTkKGFaR8vRnvY8HL7BWWM8ReXly+
m+bPRy/JtAMpsFfYTgNGtXV101lkn8ZIvhJSCNwDwCWHAPN1q/c+XxikTuonrKiX
p0f9SB74YUtq7gh5HE1vfrSFs2ozDXFDBfEbgTk9vfEL2O0E2gUkVF8yyLWHGUSu
lfQB/A65nYFzn8tAqd97/RzMXeHMB9u+/FI7bwfvxK+hnRys3sxaS/5knlSe+Nzc
EAnnoG0VEibaNctVC5ACumPP5eqS9ejMVYmenKiq7TyAM/3DhI4ZISsm/NUrmkke
HhWUJs8U38hUK9pVHp94i63vQzLX9MWsAHXxXuTeCgkPgkklou+87nnPpcW3PWbq
m6Bgpqijcx1OAW4ooJMpt4vls578/yFbguAGJzdm3QbB9jKMa/w4iGbuRfYiCowL
cHLWFPSIGZrX3SXVfVNqSAHIhA1Jkaj1Ipku8+mz+SI/ai5Iitcnwe9QMBX1ttIh
lQ5RaQmxpp6U0cxZno9Tb1lI7GEmxa0MaZnU2wmgcbDYleyg1Hp0W0eVVeIKcFi+
5NcgYEiaLV56dufi0Vhm
=gjRe
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--

--===============2081931328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============2081931328==--
