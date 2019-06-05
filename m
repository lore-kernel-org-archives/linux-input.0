From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/10] mfd / platform: cros_ec: Move
 cros-ec core driver out from MFD
Date: Wed, 5 Jun 2019 11:02:00 +0100
Message-ID: <20190605100200.GM2456@sirena.org.uk>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1990195313740297711=="
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
Cc: gwendal@chromium.org, Banajit Goswami <bgoswami@codeaurora.org>, Vignesh R <vigneshr@ti.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Juergen Fitschen <jfi@ssv-embedded.de>, alsa-devel@alsa-project.org, Stefan Agner <stefan@agner.ch>, Sebastian Reichel <sre@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Guenter Roeck <groeck@chromium.org>, kernel@collabora.com, dtor@chromium.org, Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <jdelvare@suse.de>, Jacky Bai <ping.bai@nxp.com>, linux-rtc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sean Young <sean@mess.org>, Lee Jones <lee.jo>
List-Id: linux-input@vger.kernel.org


--===============1990195313740297711==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bYB/dvygrOI2NuBf"
Content-Disposition: inline


--bYB/dvygrOI2NuBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2019 at 05:20:11PM +0200, Enric Balletbo i Serra wrote:
> Now, the ChromeOS EC core driver has nothing related to an MFD device, so
> move that driver from the MFD subsystem to the platform/chrome subsystem.

Acked-by: Mark Brown <broonie@kernel.org>

--bYB/dvygrOI2NuBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz3kxcACgkQJNaLcl1U
h9CFeQf9GtlWPL5nPJEfjyt5RFlWSTaL2w0eqOd5qmO7mWY5Dlc1UODDtZlVSWnY
KodqSRI26I31iGe1HLT5CM5c1d7vsTXlIXfijgAh5N2ZOWS/+Aq+ImCUBT72Jn10
qEY+lr42Iy7mR3Vb0oYO0AgrDkDou8AVIzLzlIh4O4BYEd80SIzJ0+F2ps/dibS+
ktDkdxVkwbBisDXBNnMV0qW3CZSKMP21JxDMc31FB9l0yuleTXrH4pSrJ2EprxXH
s0UvMJoaouQn8eZWz1ObnYmEEdIflu80Ha7A20fp29RXnyqonXVXd7u1fUxeAECF
NyjQ+pJ9C2bFNiy+zI/kCJingPzVcQ==
=Obx+
-----END PGP SIGNATURE-----

--bYB/dvygrOI2NuBf--

--===============1990195313740297711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1990195313740297711==--
