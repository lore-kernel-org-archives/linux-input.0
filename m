From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Input: wm9712: Fix returncode for wrong sample
Date: Sat, 9 Mar 2013 01:17:48 +0800
Message-ID: <20130308171746.GB26088@opensource.wolfsonmicro.com>
References: <1362759309-18782-1-git-send-email-mpa@pengutronix.de>
 <1362759309-18782-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47922 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759809Ab3CHRR6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Mar 2013 12:17:58 -0500
Content-Disposition: inline
In-Reply-To: <1362759309-18782-3-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de, Teresa =?iso-8859-1?Q?G=E1mez?= <t.gamez@phytec.de>, Christian Hemp <c.hemp@phytec.de>, stable@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2013 at 05:15:07PM +0100, Markus Pargmann wrote:
> Instead of interpreting a wrong measurement as pen up, we should try to read
> again.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROh0fAAoJELSic+t+oim9c4wQAJIJn69kYVdTLa/D3lbuefdZ
2966UgiZV7PrQ5EqnzMuRXceAbPVgnkoDVjwHNzaO4rtHP5kVRUhWhbS2PjisHcP
FHPGoWeb7ZqGUDx5epwgFo7+SfAN7Oi/5F9/iNJYJlADvLdAjkyHVVarLsgT5oh8
AylQED0xXZrjByjfaVGT2oFBvxiGZKef0dobcM39PZOR5pgl+1gD6Bwe0RMKoEs8
XopFnzLdregk2UOu9k/n4S2H/Zj0ExfueseKiGSUqISJGjxGTdPHfFDdwxkTCIUk
D4SEQC0Pn/zBtwkAzxYx1A2/SjSm11UDThlxx0BlGAXIo5scaEvczQ1GAitVlBTM
+TlQItrnWM0FMU0KfZDzRf0LmtCEajpj+A/TUzRki8kHdDU9WTzAQqCngvXUrQXD
gErSBqyt/eC3+wCbCuDqWjO8A6bdrVCO+g1Q0WoVw59qYVXfNnCEi//61ZOwlEAA
aGnYRA56n7b2xmI5mdhQE80KTpA1TQSpyXUxGxYTD8gm03ALPTqEL430tX8KHVX6
lqrdKbegMtA+wqyzJfrsOQwIEcji7Gb0lV8I7FuyxjAoYAJO9LNWAGVwrR5Rf0Bo
2XklOfdU8/v0J1Y0ZfYK3kQCYcS25aPMZryjKXMxHZkNnGobbbkjV+8snnwANLHt
8LKx/Tb7HLFTV5cuiOrq
=S8kZ
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
