From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 02/10] mfd / platform: cros_ec: Move
 cros-ec core driver out from MFD
Date: Wed, 5 Jun 2019 16:19:29 +0200
Message-ID: <20190605141929.GB962@kunai>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1580713667080741966=="
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
Cc: gwendal@chromium.org, Banajit Goswami <bgoswami@codeaurora.org>, Vignesh R <vigneshr@ti.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Juergen Fitschen <jfi@ssv-embedded.de>, alsa-devel@alsa-project.org, Stefan Agner <stefan@agner.ch>, Sebastian Reichel <sre@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Guenter Roeck <groeck@chromium.org>, kernel@collabora.com, dtor@chromium.org, Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <jdelvare@suse.de>, Jacky Bai <ping.bai@nxp.com>, linux-rtc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sean
List-Id: linux-input@vger.kernel.org


--===============1580713667080741966==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 05:20:11PM +0200, Enric Balletbo i Serra wrote:
> Now, the ChromeOS EC core driver has nothing related to an MFD device, so
> move that driver from the MFD subsystem to the platform/chrome subsystem.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de> (for the I2C part)


--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlz3z3EACgkQFA3kzBSg
KbZZyQ/+NucR0y9tJ8dEUHBDWwezaDGRJY6gdHekCBkaeWPUn6g0FnICbkRctxDs
9xGiFSqBOVjaLKRvv1Heb9CmS6v6OQ/6+DUkESSpBhO5grk7oTOsg13G0W87qNmz
Qdm9ZSj4DZchkw0cLBd4tZ9QISp6/rNnUWbK8P6DBBhLp43iwErSGqYNKkopgUmW
ggCpgWYAgsV+rUTNAWbywT0mil0qXZ1fcAdkmktp3sTzsJk9JGuUrx/1CLtyDd/R
pJwCV0fJRKD54dc2C3iFaLbVb0TqXxtryqVK9ByNXxOWxQh5TROhUNFwve5vSTqg
Cxpsu3ET+0MYtjV/eEZYz5J9A/EFK1XcyiJYtA4Zvw2p2Q7Ab6Y3XpsRXGJM5UhV
I/gLzzr0DUqwOcyE82MES3JNvbHec1fVB0WXXW2QesC7TmY/5VKKIG6WX+ZSNmXa
HGDgEVsH/cienRasI6yYB5nRigLNJVC+ZGLccKmFtEGMyHMA3gJLx46jfdXZ81OU
mzmhhkilii5Rjp+WpzBnreMMQJ7XpfLa5ZBGWU0T9fpFuBf818l+qp61T5qT3XKV
AKDLZsZWvjzjuS/NA9GV1P8/Aau4H2k9FvTdT/YY0EMFCFasHkIZ4pSaHCmR0YtJ
7/Pr6PkYT2dpI8BX5fCwTvSIC5wNeTuoeX7ue//WHQTEDKLdmqE=
=yI8A
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

--===============1580713667080741966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1580713667080741966==--
