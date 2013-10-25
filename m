From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] Input: add regulator haptic driver
Date: Fri, 25 Oct 2013 09:29:44 +0100
Message-ID: <20131025082944.GK18506@sirena.org.uk>
References: <000101cec628$aaff69a0$00fe3ce0$%kim@samsung.com>
 <20131024133836.GG18506@sirena.org.uk>
 <002601ced14b$9c412330$d4c36990$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36113 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab3JYIaU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Oct 2013 04:30:20 -0400
Content-Disposition: inline
In-Reply-To: <002601ced14b$9c412330$d4c36990$%kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hyunhee Kim <hyunhee.kim@samsung.com>
Cc: dmitry.torokhov@gmail.com, peter.ujfalusi@ti.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, kyungmin.park@samsung.com


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2013 at 03:29:51PM +0900, Hyunhee Kim wrote:
> From: Hyunhee Kim <hyunhee.kim@samsung.com>
> Date: Wed, 9 Oct 2013 16:21:36 +0900
> Subject: [PATCH] Input: add regulator haptic driver

This is OK from a regulator point of view though there's still a lot of
use of regulator devm_ and input devm_ that could happen - it wasn't
just the kzalloc(), it was most of the allocations in the driver.

You also have some word wrapping in your e-mail so the patch probably
won't apply.

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaiv0AAoJELSic+t+oim9j3AP/irkpPAqOH6Mf1xklvWGl6/p
2aEY1MS4g6syu0UPkNMTcGdgr/ex5qjjgM56+eJb9blgcJdRLcnWLD1uCVd5ePX4
Dfg8+R/M2higJpNK6LagEqfigXGHHNysWoi9eLNW1aoZArZ4JAJGTjVHgxzHxZ2h
w19dsvDDmGPD/OcVDNwM5jCbeVIjtOAQC5LmrqvRi31Z1uTmgObH0E/Z9y0AYB9y
jG2oLVCRzFqss7nbGrJ7ttRjMJtsdLsOaxvXuXTJhhoGU6eA3sEbxHOB429VjPi3
kEl2nhG5bg9n9dAEHKaiL1vLnVt8wKv8vBwSK2NKeIwp10fVBWrCjPuI5NToMDnP
9KzleikCkEcgyDnR6HuerOFrLMIXasDm1coE9twlNN1HuVvjvKBZ1MAmP9BjcQnf
0WMspTqzpVppURcE4/yhcAiNDufSfhbD316ugJ5DP7YaRsfNoQOY82rlqAv8ByNG
zQNMcXsTqIPKdUmvgosLqbZbmwrJz871HD0aE9ZflnKZ8MeCwaf7QwMLsbYmlgg2
V6pEevkfadlZr3/uQEf8xUsHbJtj30naLYnClcQUq5eEr5OoUYE1aRSEoUCdDE9e
a5iJjHYtbQNzEzYoAwrAE23IRZLVAcd3ii30dLfSCFGIOkgJJgb3YbOQpLvPAqBg
5dk9CXq+59F8qO3B+767
=uhLj
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
