From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 5/6] Input: ALPS - fix trackstick detection on some Dell Latitudes
Date: Mon, 2 Feb 2015 11:51:13 +0100
Message-ID: <201502021151.13134@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <201501171126.50081@pali> <20150202053408.GA20333@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1998389.u2Id10T5ZH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:59746 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbBBKvQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 05:51:16 -0500
Received: by mail-wi0-f169.google.com with SMTP id h11so14772188wiw.0
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2015 02:51:14 -0800 (PST)
In-Reply-To: <20150202053408.GA20333@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

--nextPart1998389.u2Id10T5ZH
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 February 2015 06:34:08 Dmitry Torokhov wrote:
> On Sat, Jan 17, 2015 at 11:26:50AM +0100, Pali Roh=C3=A1r wrote:
> > On Wednesday 14 January 2015 23:55:53 Dmitry Torokhov wrote:
> > > On some Dell Latitudes we fail to identify presence of
> > > trackstick unless we reset the device. The issue is quite
> > > benign as we do perform reset in alps_init(), so the
> > > trackstick ends up working, but mouse name reported to
> > > userspace is not accurate.
> > >=20
> > > In order to fix the issue while avoiding the additional
> > > lengthy reset we move the resrt to alps_detect() and keep
> > > the discovered state to be used later in alps_init().
> > >=20
> > > Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >=20
> > This patch is not enough. ALPS_DUALPOINT flag can be removed
> > also in function alps_hw_init_rushmore_v3() which is called
> > from alps_init() but not from alps_detect(). So this patch
> > does not have to set correct name in alps_detect() based on
> > ALPS_DUALPOINT flag. My original patch set name in
> > alps_init() after hw_init() which handled also this
> > problem...
>=20
> Hmm, I think if we are still seeing these after somewhat
> recent addition of full reset in detect procedure we need to
> fix our detection instead of tweaking capabilities after
> initialization phase fails. So I will just remove that bit
> from alps_hw_init_rushmore_v3(). FWIW I did a quick search on
> Google and do not seem to find dmesgs with message
> "trackstick E7 report failed".
>=20
> Thanks.

Ok, in this case kernel just register redundant input device=20
which does not send any events to userspace.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1998389.u2Id10T5ZH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTPVqEACgkQi/DJPQPkQ1IvPQCgs0XT+Ktsx5G/3LEjAe1knMjc
9hoAnikXueQSyYc4veu2CZTGiFoD28oT
=Q/1s
-----END PGP SIGNATURE-----

--nextPart1998389.u2Id10T5ZH--
