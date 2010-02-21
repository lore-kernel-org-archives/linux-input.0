From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Sun, 21 Feb 2010 12:10:08 +0200
Message-ID: <201002211210.12306.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com> <201002211105.30079.anarsoul@gmail.com> <20100221094151.GC18298@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart84461963.7bLeuGJkm9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:41078 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab0BUKKc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Feb 2010 05:10:32 -0500
Received: by bwz1 with SMTP id 1so1003573bwz.21
        for <linux-input@vger.kernel.org>; Sun, 21 Feb 2010 02:10:30 -0800 (PST)
In-Reply-To: <20100221094151.GC18298@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

--nextPart84461963.7bLeuGJkm9
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
21 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 11:41:51 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Dmitry Torokhov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> > Timer is used to avoid reporting input events in interrupt context
> > (select callback is called from s3c_adc_try and from s3c_adc_irq),
> ??? This is quite a novel concept for me...

I think so, as I don't see any other reasons to use timer :)

> > Anyway, driver
> > doesn't work for me with this patch (it works as mouse, but it doesn't =
as
> > touchscreen through tslib)
>=20
> Hmm, does evtest utility report all expected events?

evtest shows that driver starts event flood on first touch, i.e. it doesn't=
=20
stop to emit event when stylus is up.

Regards
Vasily

--nextPart84461963.7bLeuGJkm9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkuBBoQACgkQRM6pQpltKE7jGQCgrMya7GVZiR6wKrEZ6Pdb3q4A
kxoAoMoRtrGcGIEoR9QrAEDvTISMywWe
=D6CG
-----END PGP SIGNATURE-----

--nextPart84461963.7bLeuGJkm9--
