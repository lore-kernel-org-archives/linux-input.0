From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: mms114 - Fix regulator enable and disable paths
Date: Sat, 2 Mar 2013 16:18:48 +0800
Message-ID: <20130302081846.GA12379@opensource.wolfsonmicro.com>
References: <1362207641-25152-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <5131B414.1080204@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35067 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750756Ab3CBIT0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Mar 2013 03:19:26 -0500
Content-Disposition: inline
In-Reply-To: <5131B414.1080204@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 02, 2013 at 05:11:00PM +0900, Joonyoung Shim wrote:
> On 03/02/2013 04:00 PM, Mark Brown wrote:

> >  	mdelay(MMS114_POWERON_DELAY);
> >  	error = mms114_setup_regs(data);

> If error, we will have to disable regulators here.

That's a preexisting error, of course...

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMbW0AAoJELSic+t+oim9IgcP/RAnkudCry39QbWnS9+61p9W
ehHCbie5VI3g2DP9UDJkgxR/2et+5VO2dxy4ZRCRu6Oz2SBJJonRK0c9wkFtoriB
VdQMHoSbBY8ibuiEtQnk0RcSW16Jk2fLuJDPSZ5VZyWJw8202bSQtQEhT/8ht56L
Ec/NmkAediNHq3YEkDu0FWuQAg/ieLfh9EfCwGma3162HT87W2hxXMMisvFCi42l
/H3F3aJwc089qUfe8x3sJawY5LcjXRMU8hWlb7eQSLM+EEk7cTc6wPCGHF/GYhss
yR7i0MNRQ4gmripgOUU28VeHCSHDL7yiBq3Ob8jFKiloIHLYzeJyksaTxiJTFxKd
PHGihvzKq93XE3iYCZn3ZGSE1HoAWtepTJtvttPIAdpvWtaoVOdTzw1TiYljq7KV
icXckgQR9CuV3i8/l3OVmWCuNC4D2QO9zlpPd4FA6FEpcJc2csyRcllDzxNhNnuo
X4tuGj2EdojOxzPgGyAdERj8F9oC+LpHUhklLz6HC3logNMtmX9HkO/+neow2NJl
RRE3BQPszzFzyffMvUMDj7hTPQNWpKKuQ6bOZkZlp93VY+Xb7J7w8sMLDdrWlqmq
EM0Y3jTP4rPs0ODJEEFsHhauhLKpIsR4i3dJdHYHk2Cn0jHBgo3UIyiN/iR3GqtX
3A7xTVFHuaJJ6aGonE5Y
=7T6z
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
