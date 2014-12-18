From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 18 Dec 2014 09:21:51 +0100
Message-ID: <20141218082151.GA1038@katana>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>
List-Id: linux-input@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2014 at 04:15:23AM +0200, Laurent Pinchart wrote:
> The I2C subsystem can match devices without explicit OF support based on
> the part of their compatible property after the comma. However, this
> mechanism uses the first compatible value only. For adxl34x OF device
> nodes the compatible property should list the more specific
> "adi,adxl345" or "adi,adxl346" value first and the "adi,adxl34x"
> fallback value second. This prevents the device node from being matched
> with the adxl34x driver.
>=20
> Fix this by adding an OF match table with an "adi,adxl34x" compatible
> entry.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---
>  drivers/input/misc/adxl34x-i2c.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> Another option would have been to add "adxl325" and "adxl326" entries to =
the
> adxl34x_id I2C match table, but it would have had the drawback of requiri=
ng a
> driver update for every new device.

AFAIK this is even required for compatible entries, to be as specific as
possible. I think this makes sense. With platform_ids, we already had
the problem that pca954x was too generic and was used for both GPIO
extenders and I2C muxers (IIRC).


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUko6fAAoJEBQN5MwUoCm2BWYP/jwC1h2tKVqqNxYFfqXXimcs
OwIi0PGlVDn9eVL+yfF6MxgkiGXuPyX2et2BA2hYdWgrtj3ass65f1eJ358FMZLg
SDB/6X/9qSO9z1LDI1B97iOE3eBOLnOvcy9h/54PIIsySAP794/oFzmva8q2Is/G
O1JBA9XhQ7vip183evIqCHSB4XhvtNV0fnB4q0rJwC7JSGCXCconLfTw8nX8Y3iS
JhH1JfQMnf9vkkpak8zT2DLTp3Wzh79R22jjhuaZYJ4rWCTymNQYLY00suOlsJc5
bV7HDT4rGCGWduio2dkQG181XWQnrpvyObNfvjsDeoEKZqaZEPPSQZXOnicUCU8O
fjRqoNMg7fjUdSrimJnRM2g65bVMRP1Sxsb5wHajLwg+hRFj5dbCIGw9M46oSJ9U
jlQQGdefBaLxm3zUKndA0vFQkXDbxj26zKIGBmK+UtzEjkc7SHE9eUNU3mbUVw6T
esF5Q9+UE7trl2B4DmvhAJgViAMx1LasbzPzyssDU/P8ZkMI1nTHxJrk38RrB8uE
XQS19zT9quouv6JUcL4gG8V6TxA0J95W1ocpj1VA9Q6bxw/tEa2HxF+ohngxx6Qf
Raqq8hmWRcbvsjU+p5RsTx2j5ycQNTxGxPr0UQEPlI6obkDZax524rJTN4XKnBfE
BEMNbDC5RL2brVe3rrRo
=45um
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
