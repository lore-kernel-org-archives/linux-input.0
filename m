From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/10] mfd / platform: cros_ec: Reorganize platform and
 mfd includes
Date: Wed, 5 Jun 2019 11:02:20 +0100
Message-ID: <20190605100220.GN2456@sirena.org.uk>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-7-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnxXMyWEPIZsopkG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604152019.16100-7-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, Lee Jones <lee.jones@linaro.org>, kernel@collabora.com, dtor@chromium.org, Mauro Carvalho Chehab <mchehab@kernel.org>, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, linux-iio@vger.kernel.org, Fabien Lahoudere <fabien.lahoudere@collabora.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, linux-rtc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Sebastian Reichel <sre@kernel.org>, Rushikesh
List-Id: linux-input@vger.kernel.org


--RnxXMyWEPIZsopkG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2019 at 05:20:15PM +0200, Enric Balletbo i Serra wrote:
> There is a bit of mess between cros-ec mfd includes and platform
> includes. For example, we have a linux/mfd/cros_ec.h include that
> exports the interface implemented in platform/chrome/cros_ec_proto.c. Or

Acked-by: Mark Brown <broonie@kernel.org>

--RnxXMyWEPIZsopkG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz3kysACgkQJNaLcl1U
h9BVMAf+I/I3bNW13EZ789wBAFxmn5KXFbH0t6CdJDgbILW9HMsGSKGbJXJRTRDG
GGeIfMEYK0lv5boeQbArMfoX/kkuVYHVj/71aQVsgC53JIBFFxHS2zEfzrFzgN+R
sNsvROQYmO1T5gOySrMN+AsqPwnu3CR2LgMPRqsvguCPduIfXzEM3afJQuRh2lAW
a5Im4U6GQX5cez1MGDHB3/Mk8fH194coSUTUtH134gpeA5LWemALrlDCRsfdSbw2
G2oeM++LQIDx2VcKfRKWfqvKhC1Ajp5FdiZw6Z7lo6+BXFHKSVupSjKAhtIdT4gj
RVhPy7IzR78PM8sLvDnqD6CyTHtuXQ==
=7p/R
-----END PGP SIGNATURE-----

--RnxXMyWEPIZsopkG--
