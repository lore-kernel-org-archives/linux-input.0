From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] Input: atmel-wm97xx: Use
 module_platform_driver_probe macro
Date: Tue, 5 Mar 2013 11:36:10 +0800
Message-ID: <20130305033606.GC9391@opensource.wolfsonmicro.com>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
 <1362453827-18129-8-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40603 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932472Ab3CEDgv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Mar 2013 22:36:51 -0500
Content-Disposition: inline
In-Reply-To: <1362453827-18129-8-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2013 at 08:53:47AM +0530, Sachin Kamat wrote:
> module_platform_driver_probe() eliminates the boilerplate and simplifies
> the code.

Is there really any great reason to use this as opposed to
module_platform_driver()?  I know the existing code does this, it's not
clear to me that that's a good idea either.

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNWgKAAoJELSic+t+oim94k4P/3UC/dOY6fr7+Q25A27x2QNl
Bo+b9jSRRFoSVzBwaF1vVIJa/YOaGab0GfYv/CBAntuIYQcJKt2snQGRAjQUomQX
M1USMkNAIUQdqbLO8AQbZ5X0INYuHCh791AO6s/hKGtC2o4wj8KT/wCQVEbG2H8w
nZivIcpJx+gtxid7dvSpJs4Ru8tHFCopqo6G7uwndC27u2YmJrDWrdK0zqzizxlT
nc8F5M0muY1hFaqkYTBxf9O9iRCVZ1cXuCKkKkeVAlqz5532iKy8746WhVX9rwYn
uYxVk1091glKBIiSJuTIA6GkGtvcsnMdBXsCQxDQFp1+ELQIIYBMTswARJ6+FRvy
KUyYbRG+RV9W29twCDpiqbu9oUmJxGBJB7vR51HcDKsEf68GPHZYQc3Wo0qzQcM4
SCc+Ip1/oiSB18WdLq6jbxfXqtwafUow0lR/XGK2S60RZW1Q8D/7+7CUTfH6gl7H
vueKOBipwEs0MF1dyATRFc443Zg2KHtr0kHkcbl6RkDTTkIh9Tiro2Ojj3GDGBRz
sY/dvoIdjuvSWf5/Q03pMoPuZVROSbzpwQYUCfVndxylCvzH7gR9ALhE6sQc6r69
GHy5+xZETK2VYDZvFrvX3xcGU964J1yznMqZCE1S9cM2db5DGK27BwMxP7suKFHL
YHf+n0MkMsH9Nd07h+El
=fm5V
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
