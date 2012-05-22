From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/2] of: Add Semtech Corp. vendor prefix
Date: Tue, 22 May 2012 15:47:44 +0200
Message-ID: <20120522134744.GB21187@avionic-0098.mockup.avionic-design.de>
References: <1334229613-678-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54840 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab2EVNr6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 May 2012 09:47:58 -0400
Content-Disposition: inline
In-Reply-To: <1334229613-678-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thierry Reding wrote:
> This commit adds a device tree vendor prefix for Semtech Corp.
>=20
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docu=
mentation/devicetree/bindings/vendor-prefixes.txt
> index 6b6e465..19af408 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -44,6 +44,7 @@ simtek
>  sirf	SiRF Technology, Inc.
>  st	STMicroelectronics
>  stericsson	ST-Ericsson
> +sx	Semtech Corp.
>  ti	Texas Instruments
>  wlf	Wolfson Microelectronics
>  xlnx	Xilinx

Does this patch need any more work or can it go in?

Thierry

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+7mQAACgkQZ+BJyKLjJp+16gCgoJajRHLrYb5uYFNpb0R5HmA+
xBsAmQGxqNqJ+8+9lUvRZDfz3Fk2zHPt
=gK0A
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
