From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 02/10] mfd / platform: cros_ec: Move
 cros-ec core driver out from MFD
Date: Wed, 5 Jun 2019 10:31:30 +0200
Message-ID: <20190605083130.GC10944@ulmo>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9163445621879607833=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190604152019.16100-3-enric.balletbo@collabora.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: gwendal@chromium.org, Banajit Goswami <bgoswami@codeaurora.org>, Vignesh R <vigneshr@ti.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Juergen Fitschen <jfi@ssv-embedded.de>, alsa-devel@alsa-project.org, Stefan Agner <stefan@agner.ch>, Sebastian Reichel <sre@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Guenter Roeck <groeck@chromium.org>, kernel@collabora.com, dtor@chromium.org, Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <jdelvare@suse.de>, Jacky Bai <ping.bai@nxp.com>, linux-rtc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sean
List-Id: linux-input@vger.kernel.org


--===============9163445621879607833==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 05:20:11PM +0200, Enric Balletbo i Serra wrote:
> Now, the ChromeOS EC core driver has nothing related to an MFD device, so
> move that driver from the MFD subsystem to the platform/chrome subsystem.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
>  drivers/extcon/Kconfig                     |  2 +-
>  drivers/hid/Kconfig                        |  2 +-
>  drivers/i2c/busses/Kconfig                 |  2 +-
>  drivers/iio/common/cros_ec_sensors/Kconfig |  2 +-
>  drivers/input/keyboard/Kconfig             |  2 +-
>  drivers/media/platform/Kconfig             |  3 +--
>  drivers/mfd/Kconfig                        | 14 +-------------
>  drivers/mfd/Makefile                       |  2 --
>  drivers/platform/chrome/Kconfig            | 21 +++++++++++++++++----
>  drivers/platform/chrome/Makefile           |  1 +
>  drivers/{mfd =3D> platform/chrome}/cros_ec.c |  0
>  drivers/power/supply/Kconfig               |  2 +-
>  drivers/pwm/Kconfig                        |  2 +-
>  drivers/rtc/Kconfig                        |  2 +-
>  sound/soc/qcom/Kconfig                     |  2 +-
>  15 files changed, 29 insertions(+), 30 deletions(-)
>  rename drivers/{mfd =3D> platform/chrome}/cros_ec.c (100%)
[...]
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index dff5a93f7daa..99946e1bcc73 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -145,7 +145,7 @@ config PWM_CRC
> =20
>  config PWM_CROS_EC
>  	tristate "ChromeOS EC PWM driver"
> -	depends on MFD_CROS_EC
> +	depends on CROS_EC
>  	help
>  	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
>  	  Controller.

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz3feIACgkQ3SOs138+
s6Gy8BAAkwnYWSW1eAUYvq+hgX/m5frnbMQpHfgHuzP1fIoXXZAIP2aZmQ8jzens
bbiMtRR63rGaYjCMdalUKbxtH6ogZFHx+aiH/cZVHNr+rW198oW3/nGoWG05uVBq
WH0mlDsfAQ3/sR1hcUUhvCiPh+oExShLhOYz8zTJKHIHwtSDt8ep0yIOKPVKwknW
mIT7n2RFSSRvXaJ7RnuG61YPKk+BoJZ2X7BKkYKynAsBAQgyFSHOqOSLl6+JiNRZ
6pKL0uxqbf/x7b0FxrbToI0h8KzTi6kzccBznW/wgs92Ta/rxHx//7NZmFlNMuIR
c6nAIXY2msir5vVnflr2wn5tdzaQN35lWchGOEyiIiBgJntYAlR1AOPpdCSpkcUU
6BBH6YfFfvsBmioBshMFiFM7gVYRMvE1FSPJjfqWXe4qjyTZN2Yi/oaD6FkB9HoW
T8p9ORKVUKsRCt11RF1tt6AnpZoSXBYMZOaENDTIsS+PDyXdYJNLqPHWo6S1C5qh
Mb8zCBwgoxRek4DUsvi5l4QFiJ/I28zrwDq5cyMqVn8IJCNfGezRIgLpvN4E6LHn
tIWlBwUiVzsoCRy0OpQ5xPLn4H2ExNgVN+tc8P83kAmw9wPyo5agzN24dywWGvEI
kDcf6Sw7cyd0yyR7XTjglPxQHb5t2UX/HHXEoSeXY7TBfGU1YgY=
=oUZw
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

--===============9163445621879607833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9163445621879607833==--
