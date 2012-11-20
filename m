From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 230/493] input: remove use of __devinit
Date: Tue, 20 Nov 2012 15:45:18 +0900
Message-ID: <20121120064517.GM10560@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-230-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+utxuhC6KVTvgNz"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39091 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952Ab2KTGpj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Nov 2012 01:45:39 -0500
Content-Disposition: inline
In-Reply-To: <1353349642-3677-230-git-send-email-wfp5p@virginia.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, device-drivers-devel@blackfin.uclinux.org, Wan ZongShun <mcuos.com@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, Miloslav Trmac <mitr@volny.cz>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-arm-kernel@lists.infradead.org


--m+utxuhC6KVTvgNz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 01:22:59PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--m+utxuhC6KVTvgNz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqyboAAoJELSic+t+oim9uY8QAIudRmqeL40YM2LC2yVLZKLt
rvC0Q1e0GPgpMiFkNxMUKqybssFO8ns7gfQJTfBT+aJluqpiwjylwsNcNNDWBl+m
11gHGBL7TzKQQsNLgoArwwyn3YFOO9vv4Fvtqidak16EAegD7Hj06OZ9j78amsFW
ztaaQXcKo+RL1yo1/1EyHlAw5E/IB3nxjF5ABwTTUWb5luoySFC3KbD/h+MYFWYK
ZccJ80MeDfR+1HaQ0kWKs3ajLhRqoeRpYzzIXAwSXoZLRjEvjhmUoDLgRKgeRVh1
1gOOLdILngXNncLH/YHd8iQdE5lu2eZGDYlZXgQQH1sqtKGxqguXt80ePK89SbPV
hKdPryz3DbzLJgDbTY7C60ypkIkWBKcu0wy+EQ3YXmJ5Toum7/TNiCwtuLWIecpJ
ZtiwqcIK43ALgpn+qA1Ene2BWvSasPaurDbiTpQhlbXJwBYOGMk2GIHJLg+BVvOL
7yDCyYoeO0Y1Oae8LPXCbJqY/Y6TTFUtW4yIBf5xHV5P32Y7G2+sqOQu+gGtvExY
McpVuJJyn9k+MNYYyswvKBmNh2JO4YuUztL9wTsl+IH/VjOmvuwAUGt0MMkLCobD
nCdx2IPm2kZrne0szI2/+nXJ6JB/JVulgS2RzvoLtc0dafPTEpcJBa2HSrj3Hs0h
Sv4whMoCV1RSoHdd5nfD
=pa+/
-----END PGP SIGNATURE-----

--m+utxuhC6KVTvgNz--
