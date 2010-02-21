From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Sun, 21 Feb 2010 12:33:08 +0200
Message-ID: <201002211233.11842.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com> <201002211210.12306.anarsoul@gmail.com> <20100221102807.GE18298@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4098448.41dJHHZJFK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:59221 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab0BUKdb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Feb 2010 05:33:31 -0500
Received: by bwz1 with SMTP id 1so1009145bwz.21
        for <linux-input@vger.kernel.org>; Sun, 21 Feb 2010 02:33:30 -0800 (PST)
In-Reply-To: <20100221102807.GE18298@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

--nextPart4098448.41dJHHZJFK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
21 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 12:28:07 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Dmitry Torokhov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> While flooding does it report BTN_TOUCH as up or down? I might have messed
> s3c24xx_ts_check_pen_down()...

Nope, it reports coordinates, here's part of evtest output.

Regards,
Vasily

Event: time 1254477272.320125, type 3 (Absolute), code 0 (X), value 515
Event: time 1254477272.320158, type 3 (Absolute), code 1 (Y), value 496
Event: time 1254477272.320179, -------------- Report Sync ------------=20
Event: time 1254477272.333973, type 3 (Absolute), code 1 (Y), value 497
Event: time 1254477272.334012, -------------- Report Sync ------------=20
Event: time 1254477272.374775, type 3 (Absolute), code 0 (X), value 516
Event: time 1254477272.374824, -------------- Report Sync ------------=20
Event: time 1254477272.388559, type 3 (Absolute), code 0 (X), value 515
Event: time 1254477272.388591, type 3 (Absolute), code 1 (Y), value 498
Event: time 1254477272.388612, -------------- Report Sync ------------=20
Event: time 1254477272.402415, type 3 (Absolute), code 1 (Y), value 497
Event: time 1254477272.402456, -------------- Report Sync ------------=20
Event: time 1254477272.456858, type 3 (Absolute), code 1 (Y), value 496
Event: time 1254477272.456901, -------------- Report Sync ------------=20
Event: time 1254477272.470573, type 3 (Absolute), code 1 (Y), value 497
Event: time 1254477272.470615, -------------- Report Sync ------------=20
Event: time 1254477272.484288, type 3 (Absolute), code 1 (Y), value 498
Event: time 1254477272.484330, -------------- Report Sync ------------

--nextPart4098448.41dJHHZJFK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuBC+cACgkQRM6pQpltKE4CHQCfV9T7OOYadQAG8VUIs2QL/ESg
NBQAoLEGx/WpQzowZbL5QXKmnnrjOrZU
=nWmb
-----END PGP SIGNATURE-----

--nextPart4098448.41dJHHZJFK--
