From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Fix V8 device information issue
Date: Fri, 10 Mar 2017 19:46:40 +0100
Message-ID: <201703101946.40504@pali>
References: <20170310064147.10992-1-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2416241.pv7ilt2DlX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36755 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933136AbdCJSqp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 13:46:45 -0500
In-Reply-To: <20170310064147.10992-1-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-kernel@paulsd.com, nick.m.fletcher@gmail.com, joseph.salisbury@canonical.com, ben@smart-cactus.org, mhocko@suse.com, rydberg@bitmath.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

--nextPart2416241.pv7ilt2DlX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi! I have just two notes:

On Friday 10 March 2017 07:41:47 Masaki Ota wrote:
=2E..
> +		x_phys =3D x_pitch * (num_x_electrode - 1); /* In 0.1 mm units */
> +		y_phys =3D y_pitch * (num_y_electrode - 1); /* In 0.1 mm units */
=2E..
> +		priv->x_res =3D priv->x_max * 10 / x_phys; /* units / mm */
> +		priv->y_res =3D priv->y_max * 10 / y_phys; /* units / mm */
> +
> +	} else {
=2E..
> +		x_phys =3D x_pitch * (num_x_electrode - 1); /* In 0.1 mm units */
> +		y_phys =3D y_pitch * (num_y_electrode - 1); /* In 0.1 mm units */
> +
> +		priv->x_res =3D priv->x_max * 10 / x_phys; /* units / mm */
> +		priv->y_res =3D priv->y_max * 10 / y_phys; /* units / mm */

Looks like above 4 lines are same in both if { } and else { } blocks.
So it can be moved outside of if blocks.

> +	}
>  	return 0;
>  }
> =20
> @@ -2490,7 +2515,10 @@ static int alps_update_btn_info_ss4_v2(unsigned ch=
ar otp[][4],
>  {
>  	unsigned char is_btnless;
> =20
> -	is_btnless =3D (otp[1][1] >> 3) & 0x01;
> +	if (priv->dev_id[2] =3D=3D 0x28)

This check "dev_id[2] =3D=3D 0x28" is used on more places. What about
introducing some flag or some boolean macro? Check "dev_id[2] =3D=3D 0x28"
is magical does not say anything what it is doing...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2416241.pv7ilt2DlX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAljC9JAACgkQi/DJPQPkQ1IhXgCeKdPT3YEJEZtB2LDTSPNRc3Te
m5wAn2yuRrswyyZ5fIbbeeABEmKpP7Gj
=edyU
-----END PGP SIGNATURE-----

--nextPart2416241.pv7ilt2DlX--
