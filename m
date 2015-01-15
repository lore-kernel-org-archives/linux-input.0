From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] input: adxl34x: Add OF match support
Date: Thu, 15 Jan 2015 17:55:56 +0100
Message-ID: <20150115165556.GA6272@katana>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1421333655-31029-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43714 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbbAOQz7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 11:55:59 -0500
Content-Disposition: inline
In-Reply-To: <1421333655-31029-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2015 at 04:54:15PM +0200, Laurent Pinchart wrote:
> The I2C subsystem can match devices without explicit OF support based on
> the part of their compatible property after the comma. However, this
> mechanism uses the first compatible value only. For adxl34x OF device
> nodes the compatible property will contain the more specific
> "adi,adxl345" or "adi,adxl346" value first. This prevents the device
> node from being matched with the adxl34x driver.
>=20
> Fix this by adding an OF match table with an "adi,adxl345" compatible
> entry. There's no need to add the "adi,adxl346" entry as the ADXL346 is
> backward-compatible with the ADXL345 with differences handled by runtime
> detection of the device model.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt/EcAAoJEBQN5MwUoCm2eWoP+gO6Zxvw1DPp+xEhLtIi2+BA
KIyvUV6z/d1dkm1WBwL2HlG9FI2/ah9HlAQRW9CXtchrxOPxqViQVeb8G7GYppE2
Z4u6zWFZya7wDdQtFu1hiNNsoCBgkRQZf7zvjXy7DJMUXirCZhRtoCXa6o4/dfKn
2YvnNBmIo2BNfttJsoYDESXtJOlIS4dP+u1wz2mZPNYTj4Ps6ArVA73dDX/oLyOM
+t4TS7uYlvBol/FmC1XtsnFY0unry1iJnk1Po41aU/Hm9Y7UR3TWGsuyxSbnjNXo
6dfk9wknW44U0GzsPrJHxR8zZM5q8H4bqPlJtktAYWFHV7AKOClJEdsk2dAi6ULL
WGy23EQcTUkiv+7km8GZFXv6s1HsaszygKe/ehTQ5ekGWVsH1yvhZRFAf0UN2g27
ns91oSlhUeu2Y0Yqh5gRCdo6gqKClpEVPgrdoCutg6YBUDLwTXt2v5VEhTt4EzhW
xx7WnpSrnM9rf/yx/MBfdZ7WiNb+6sd/IpOtZsJGRHHQvVrCw4yeo6j9xTWWwLQV
6veLfDV08b9e7SsykalA477Aw9Nc1SFZ9bj0nuGxZCBZ7X2xm6VZgf4moJKGIqi0
ZojurhYDL1rEIEAFxRriVh5XdGLS/9TA0oys9LPBIkpX21GSDGwmL+1w7Ilf4rPb
3qMOaj+qNV+xwmsqOOIK
=ZRzw
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
