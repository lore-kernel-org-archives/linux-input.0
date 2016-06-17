From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 1/4] i2c: add a protocol parameter to the alert
 callback
Date: Fri, 17 Jun 2016 13:26:19 +0200
Message-ID: <20160617112619.GA6876@tetsubishi>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465484030-28838-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 04:53:47PM +0200, Benjamin Tissoires wrote:
> .alert() is meant to be generic, but there is currently no way
> for the device driver to know which protocol generated the alert.
> Add a parameter in .alert() to help the device driver to understand
> what is given in data.
>=20
> This patch is required to have the support of SMBus Host Notify protocol
> through .alert().
>=20
> Tested-by: Andrew Duggan <aduggan@synaptics.com>
> For hwmon:
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> For IPMI:
> Acked-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-next, thanks!


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXY95aAAoJEBQN5MwUoCm2VJAP/iLoGNDIBCSY3DgImiv4oFPT
uc/n3DngOTFVgH6EHFyzEc6FLFHYtZqadpRo/YNRTj5dI5tLpO/xr+INaTSGDVkH
QSCFlyKIDNfeDIpzhZnnLSQMpmBhyx7GH4jBeby2M5Jj6tskaRkN5NmTt6dySAaw
lCAVPd4KIBhJZUUMBSJisbtiVrceiEv8sdJu8RIrQTm8gv9P1q2e4oHiQI5Kkx30
yxyVN+kQfVMATO6ZSTnpBKXhFfbTMDUGa02ZrOBEzISRuZS+ekDEyvi1+XSHby/J
e6IqSoJQBRj2F4yDI7zXupy6Bb6qBD3r0Fi20eO6sHOBXStaSP6x7lB14JFVrYeZ
2u+7yLLdUQYKJlaypa0MC7/NcZitftzYxgJAAu8SHhLgRyJLOiNEgBzsur84HjZi
+2CoH//9rhVyKUo9lQ6kQ/TblgZARWFiLnzm49+JRfOyhEhvy8jrb1IjHXjgSBCC
1B+KFE2c2fipybkcBkKRUsTY8g6iQrjMnQpgpuZ36F4ZyMzBeL0s9dFTS2ATSAqk
ppWrZw/Sol4cVjoovzZvbAErf9qsCpxQV69P+fQiP80C9QMQsu1rtugyiNzQ/iH/
6JNYwS8s5HWi8v3uTTu++1BO8Z5/bSfe2KWKV08n9BwzJe7HeMIT7GaWZycVnRoW
pL2Nbt6V6xkxQ6fPwRJU
=+M+A
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
