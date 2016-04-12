From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 02/46] backlight: pwm_bl: remove useless
 call to pwm_set_period()
Date: Tue, 12 Apr 2016 13:03:50 +0200
Message-ID: <20160412110350.GH18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1269682818=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
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


--===============1269682818==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:03:25PM +0200, Boris Brezillon wrote:
> The PWM period will be set when calling pwm_config. Remove this useless
> call to pwm_set_period(), which might mess up with the internal PWM state.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDNYWAAoJEN0jrNd/PrOhi/wQALBmuyKE4RytME0ICIXFzQsQ
jGXlqKggBvhkFVyrU+QtjfimQZjUhgRSntTt1KajJATlQ0lXrZvLIQUgBH4hQZkr
TBSN8zXMJGj7HOcHLa+lgOVQFcGYUIDU1rBW9SnI2thj0IQn3Zaya2KTDKizoGKT
dgSREYXCwtPaf7s8Paqe6T0jkrWfUc4Y/GA+H8uNpTo7FVf/n7KNaCTUzBPwekqE
UTD41WhqxgpfJaanIyWyspVyk7P3YKwPip++wpHTTXLM0MfQThliq2t7e/PxkT1C
rGe6rTdMmmwUy7BULhWBzntaTTnJtlodLkaKr0I/n0nhi8whqBVSj+JH6KPdivCB
tYSf8V5tA9Dl7yA4E8Jw0kvxvQGpFzDzCiwF4dxV5nysKy4wyrOdznAOeA4gZMje
z9g4XYPATKxkge2WCROg96iE5WlX4FWV3PyK5fhANgFD2lWLYL9S2g6z43rXjkRY
CzQopq6dn7WvIa4IigxbppZMzrRxGs1ZGWSlqU3RRiGqSAl4s5snSsZBZnjLIaiw
p5Fc15lG9MBkck/V5d8R7LwqqKYYmKCfTjOIXDNIhbFr3AKl+OrIx69fNJ8fVPh+
z1eiYWmkP5hOXUVFZFZuwp4ErzP32Zmk7ntPZ/1IkHXaVg1UCHqmM9AmXWSJWxXc
rU52OTaDF3TxRqKcXwAb
=iDpn
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--

--===============1269682818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1269682818==--
