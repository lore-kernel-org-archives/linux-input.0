From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] of: Add Semtech Corp. vendor prefix
Date: Thu, 14 Jun 2012 07:39:29 +0200
Message-ID: <20120614053929.GA19140@avionic-0098.mockup.avionic-design.de>
References: <1334229613-678-1-git-send-email-thierry.reding@avionic-design.de>
 <4FD8DC95.1020404@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53654 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab2FNGTp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jun 2012 02:19:45 -0400
Content-Disposition: inline
In-Reply-To: <4FD8DC95.1020404@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2012 at 01:31:49PM -0500, Rob Herring wrote:
> On 04/12/2012 06:20 AM, Thierry Reding wrote:
> > This commit adds a device tree vendor prefix for Semtech Corp.
> >=20
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: devicetree-discuss@lists.ozlabs.org
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Do=
cumentation/devicetree/bindings/vendor-prefixes.txt
> > index 6b6e465..19af408 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -44,6 +44,7 @@ simtek
> >  sirf	SiRF Technology, Inc.
> >  st	STMicroelectronics
> >  stericsson	ST-Ericsson
> > +sx	Semtech Corp.
>=20
> This should be smtc to match stock ticker.

Okay.

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/ZeREACgkQZ+BJyKLjJp/NZACcDsRKm9bNypJx9/Ve5TOjWAjj
75oAoI6w8Rt9ThWlmK26fyhGTM9sHeb0
=hY7/
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
