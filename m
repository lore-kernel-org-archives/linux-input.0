From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] Input: atmel-wm97xx: Use
 module_platform_driver_probe macro
Date: Tue, 5 Mar 2013 11:51:26 +0800
Message-ID: <20130305035121.GD9391@opensource.wolfsonmicro.com>
References: <1362453827-18129-1-git-send-email-sachin.kamat@linaro.org>
 <1362453827-18129-8-git-send-email-sachin.kamat@linaro.org>
 <20130305033606.GC9391@opensource.wolfsonmicro.com>
 <CAK9yfHx-v0B=QXvTzGUndDMroQg3nD8artGFOxfXCKf7u_P+8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36925 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932566Ab3CEDv6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Mar 2013 22:51:58 -0500
Content-Disposition: inline
In-Reply-To: <CAK9yfHx-v0B=QXvTzGUndDMroQg3nD8artGFOxfXCKf7u_P+8w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2013 at 09:17:27AM +0530, Sachin Kamat wrote:
> On 5 March 2013 09:06, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> >I know the existing code does this, it's not
> > clear to me that that's a good idea either.

> However, if your question is why return platform_driver_probe() at all
> instead of platform_driver_register() in the first place, then I am
> sorry I do not have much idea about it.

Yes, I'm questioning if this is the right cleanup to do.

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNWuYAAoJELSic+t+oim9vnwP/2g8IkC1RYBf9JPysA089My1
+Ku3+fiYxhSuipKEUMu7oj0GS3v7wSyfikktBQD3+fyCCR3NsFAOJXv/iW+VRSnW
RqRFpRzvRbdksI7R2utMZlwhvnU+BKsqnlEWMxog97KTMRsaA1cKh0+i2ycAh7l6
+oz0xirtMKIvsVk8vJpFglVes0XAHMcCw59ysLLNqjrSyYUjwhJZxPbb8yvpcf5M
F3Lei8xDrIAIaMj2km7ggeuGvhAweOsgA9EU1DdkGp7gdagXJkzoi6El79Vn7+ga
KOyWgVdBXkBzUhqldfNAdPJ6p0lpPx1Ipt+u5jUnvEGq+NRFNHElduK7ngqIRGr4
obYNAqR2UE+n3gdRCNBh1Z0qvy91mvbwr0q1ilCMCkQ2V+w25rNDy9gwAluYCk8M
QQUutSceqY48nPcj9raRzpXbP5oZDnjTtz48RnBLozHI4Bt8XLe5KXDKhnx2YN6J
AhizNoXK0x4ZOtuHX0uuDhitazLAHt/6BsIkNoTa9LQfAUylS3pSBTRdg39uRORj
csMyPGCcUUjY8FjTMTUvMM/WVsQQryiW8wGXylwej6esrSb2+en22fKUmh4vZyJR
xxTz+gelyIhtbvOLTDtK2d8d+TMxPK/FhwQ3eixZg4KZLjyeoPG4i3RT3uWsHhOy
SXd5YGmZMZckXEypSm7N
=E5Hg
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
