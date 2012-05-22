From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/2] input: Add support for the Semtech SX8634 controller
Date: Tue, 22 May 2012 15:48:34 +0200
Message-ID: <20120522134834.GC21187@avionic-0098.mockup.avionic-design.de>
References: <1334229613-678-1-git-send-email-thierry.reding@avionic-design.de>
 <1334229613-678-2-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55901 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab2EVNsj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 May 2012 09:48:39 -0400
Content-Disposition: inline
In-Reply-To: <1334229613-678-2-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thierry Reding wrote:
> This commit adds support for the Semtech SX8634 Capacitive Button and
> Slider Touch controller.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  Documentation/devicetree/bindings/input/sx8634.txt |   58 ++
>  drivers/input/misc/Kconfig                         |   10 +
>  drivers/input/misc/Makefile                        |    1 +
>  drivers/input/misc/sx8634.c                        |  745 ++++++++++++++=
++++++
>  include/linux/input/sx8634.h                       |   32 +
>  5 files changed, 846 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/sx8634.txt
>  create mode 100644 drivers/input/misc/sx8634.c
>  create mode 100644 include/linux/input/sx8634.h

Any comments on this one?

Thierry

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+7mTIACgkQZ+BJyKLjJp/XkwCgqk+qi56/XRxlB5OSNpXfp3jQ
OHQAn1oQpVBdkhMdzZBzqqKHae9l02uH
=yQbt
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
