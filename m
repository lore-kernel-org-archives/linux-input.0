From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] Input: ALPS - Fix TrackStick support for SS5 hardware
Date: Sun, 6 Nov 2016 20:59:34 +0100
Message-ID: <201611062059.35358@pali>
References: <20161024210122.GA2919@TopQuark.net> <20161105163047.GE2927@TopQuark.net> <20161105164458.GF2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2091292.Dzi8IghX64";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32988 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbcKGAYJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 6 Nov 2016 19:24:09 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so13832507wmu.0
        for <linux-input@vger.kernel.org>; Sun, 06 Nov 2016 16:23:22 -0800 (PST)
In-Reply-To: <20161105164458.GF2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@paulsd.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

--nextPart2091292.Dzi8IghX64
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 05 November 2016 17:44:58 Paul Donohue wrote:
> The current Alps SS5 (SS4 v2) code generates bogus TouchPad events when=20
> TrackStick packets are processed.
>=20
> This causes the xorg synaptics driver to print=20
> "unable to find touch point 0" and=20
> "BUG: triggered 'if (priv->num_active_touches > priv->num_slots)'"=20
> messages.  It also causes unexpected TouchPad button release and reclick=
=20
> event sequences if the TrackStick is moved while holding a TouchPad=20
> button.
>=20
> This commit corrects the problem by adjusting
> alps_process_packet_ss4_v2() so that it only sends TrackStick reports
> when processing TrackStick packets.
>=20
> Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 6d7de9b..1d0302b 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1279,6 +1279,8 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
>                         input_report_rel(priv->dev2, REL_Y, -y);
>                         input_report_abs(priv->dev2, ABS_PRESSURE, pressu=
re);
>                 }
> +               f->first_mp =3D 0;
> +               f->is_mp =3D 0;
>                 break;
> =20
>         case SS4_PACKET_ID_IDLE:
> @@ -1346,18 +1348,18 @@ static void alps_process_packet_ss4_v2(struct psm=
ouse *psmouse)
> =20
>         priv->multi_packet =3D 0;
> =20
> -       alps_report_mt_data(psmouse, (f->fingers <=3D 4) ? f->fingers : 4=
);
> +       if ((packet[3] & 0x30) !=3D 0x20) {

Ideally adds comment that this is test for SS4_PACKET_ID_STICK.

> +               alps_report_mt_data(psmouse, (f->fingers <=3D 4) ? f->fin=
gers : 4);
> =20
> -       input_mt_report_finger_count(dev, f->fingers);
> +               input_mt_report_finger_count(dev, f->fingers);
> =20
> -       input_report_key(dev, BTN_LEFT, f->left);
> -       input_report_key(dev, BTN_RIGHT, f->right);
> -       input_report_key(dev, BTN_MIDDLE, f->middle);
> +               input_report_key(dev, BTN_LEFT, f->left);
> +               input_report_key(dev, BTN_RIGHT, f->right);
> +               input_report_key(dev, BTN_MIDDLE, f->middle);
> =20
> -       input_report_abs(dev, ABS_PRESSURE, f->pressure);
> -       input_sync(dev);
> -
> -       if (priv->flags & ALPS_DUALPOINT) {
> +               input_report_abs(dev, ABS_PRESSURE, f->pressure);
> +               input_sync(dev);
> +       } else if (priv->flags & ALPS_DUALPOINT) {
>                 input_report_key(dev2, BTN_LEFT, f->ts_left);
>                 input_report_key(dev2, BTN_RIGHT, f->ts_right);
>                 input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
>=20

Otherwise this patch looks OK.

Anyway, I looked into alps.c source code and I see there another
problem with ss4 devices. Function alps_decode_ss4_v2() calls
input_report_*() functions without input_sync(). But all those
input_report_*() should be in alps_process_packet_ss4_v2().

Would you like to fix this problem?

I think due to this problem, original code contains that BUG reported
by you...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2091292.Dzi8IghX64
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgfi6cACgkQi/DJPQPkQ1ICZACfXlL/6b1PuftHg33AGc7hX80l
3asAnjpsClC+vRidCoJKSjVaFCmbY8AK
=oZfB
-----END PGP SIGNATURE-----

--nextPart2091292.Dzi8IghX64--
