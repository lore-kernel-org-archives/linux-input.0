From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/6] Input: ALPS - fix trackstick detection on some Dell Latitudes
Date: Thu, 15 Jan 2015 21:21:34 +0100
Message-ID: <201501152121.35052@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <1421276154-8689-6-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3016928.kvzPItxGu1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:56099 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbbAOUVi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 15:21:38 -0500
Received: by mail-wi0-f181.google.com with SMTP id hi2so20336285wib.2
        for <linux-input@vger.kernel.org>; Thu, 15 Jan 2015 12:21:37 -0800 (PST)
In-Reply-To: <1421276154-8689-6-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

--nextPart3016928.kvzPItxGu1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 14 January 2015 23:55:53 Dmitry Torokhov wrote:
> +	/*
> +	 * Reset the device to make sure it is fully operational:
> +	 * on some laptops, like certain Dell Latitudes, we may
> +	 * fail to properly detect presence of trackstick if device
> +	 * has not been reset.
> +	 */
> +	psmouse_reset(psmouse);
> +
> +	priv =3D kzalloc(sizeof(struct alps_data), GFP_KERNEL);
> +	if (priv)

if (!priv)

> +		return -ENOMEM;
> +

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3016928.kvzPItxGu1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS4IU8ACgkQi/DJPQPkQ1LGCwCeIMQdxYUtlZTWMIuaXkcK2Kpi
fesAn24xTEBv0dJC08E+gWxqiHcmHwyI
=c5FE
-----END PGP SIGNATURE-----

--nextPart3016928.kvzPItxGu1--
