From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] Input: tsc2005 - Add support for tsc2004
Date: Fri, 30 Oct 2015 09:39:05 +0900
Message-ID: <20151030003905.GL28319@sirena.org.uk>
References: <1446077554-19684-1-git-send-email-mwelling@ieee.org>
 <201510291514.OprNyiZf%fengguang.wu@intel.com>
 <20151029142237.GA11531@qwerty.qwertyembedded>
 <4152426.STHOuGxqsW@wuerfel>
 <20151029215353.GA10355@deathstar>
 <20151029222331.GA1419@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PFhoI1KhOsYPpkJR"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40894 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820AbbJ3AjZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2015 20:39:25 -0400
Content-Disposition: inline
In-Reply-To: <20151029222331.GA1419@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


--PFhoI1KhOsYPpkJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2015 at 03:23:31PM -0700, Dmitry Torokhov wrote:

> However, you have regmap in the driver core already. Mark, is it
> possible to have regmap API also allow doing raw underlying protocol
> transfer so that consumers could issue command requests without needing
> to know if they need to do it over i2c or spi or whatever. Or we need a
> notion of command registers in regmap...

I don't think it's a good idea to break the encapsulation of the regmap
and export the raw I/O functionality directly, there seem to be more bad
ways of using that than good.  The driver must at some point know what
bus it is dealing with and be able to manage this itself.

I don't know what "command registers" are.

--PFhoI1KhOsYPpkJR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMrwiAAoJECTWi3JdVIfQMIoH+wYQaCD2rz9fJeDE69Loe0CE
GbgoX2VB4SxOVJS9RYQE/Jp4hQfQs6kPemSJKql+bWr9ljgvZ/bYYim8ibX7nAF8
yOZ95jQr5CUeoMH5QPKSw2YEfwb47tGf1wui3pRMn1Ay55IA1bRjpGNrTBmg72o9
5BVJJmAERcZ2kpWlvXWJbSZzbGqKYh1ad9SbxPTnVdw9NvVxO4CVnG7JQkTf8yW3
n0DjBozzpMm3lABWXmI7yJl+RY9c9x9JnLHnvkp41V9XDNqe/+CEnWMvZo6Cg/JN
yYcO07rGhYhcXmPw5KG0RowYp5dRt7wL0s07pScCrNqXnphC6w5MOQLRX7ekgR4=
=ej40
-----END PGP SIGNATURE-----

--PFhoI1KhOsYPpkJR--
