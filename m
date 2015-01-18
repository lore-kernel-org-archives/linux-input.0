From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 6/6] Input: ALPS - mix trackstick and external PS/2 mouse data
Date: Sun, 18 Jan 2015 10:45:25 +0100
Message-ID: <201501181045.25411@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <1421276154-8689-7-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1706069.XiS22latRr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:43803 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbARJp2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 04:45:28 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so27022390wgg.12
        for <linux-input@vger.kernel.org>; Sun, 18 Jan 2015 01:45:27 -0800 (PST)
In-Reply-To: <1421276154-8689-7-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

--nextPart1706069.XiS22latRr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 14 January 2015 23:55:54 Dmitry Torokhov wrote:
> +       dev3 =3D input_allocate_device();
> +       if (!dev3) {
> +               psmouse_err(psmouse, "failed to alolocate secondary devic=
e\n");

                                                  allocate

> +               error =3D -ENOMEM;
> +               goto out;
> +       }

=2E..

>         if (priv->flags & ALPS_DUALPOINT) {
> +               struct input_dev *dev2;
> +
> +               dev2 =3D input_allocate_device();
> +               if (!dev2) {
> +                       psmouse_err(psmouse,
> +                                   "failed to allocate  trackstick devic=
e\n");

                                                         ^^ 2x space

> +                       error =3D -ENOMEM;
> +                       goto init_fail;
> +               }

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1706069.XiS22latRr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS7gLUACgkQi/DJPQPkQ1JZTgCfeT+o4RwX4Xj8vd2NM5dsfY4W
Ep0AoJplZJ3dqFhNfiZvOh8vPEy5qLkH
=j1hJ
-----END PGP SIGNATURE-----

--nextPart1706069.XiS22latRr--
