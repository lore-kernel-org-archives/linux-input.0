From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/5] Input: alps - cleanup
Date: Mon, 20 Jun 2016 19:49:56 +0200
Message-ID: <201606201949.56334@pali>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com> <b938b267-6d6e-4397-3af2-c76deaae1f38@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3069801.LtRCNeqyKX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35779 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbcFTSUz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 14:20:55 -0400
In-Reply-To: <b938b267-6d6e-4397-3af2-c76deaae1f38@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart3069801.LtRCNeqyKX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 06 June 2016 13:32:31 Hans de Goede wrote:
> Hi,
>=20
> On 06-06-16 13:23, Pali Roh=C3=A1r wrote:
> > This patch series cleanup usage of alps_model_data table.
> >=20
> > Pali Roh=C3=A1r (5):
> >   Input: alps - move ALPS_PROTO_V6 out of alps_model_data table
> >   Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
> >   Input: alps - move ALPS_PROTO_V1 out of alps_model_data table
> >   Input: alps - warn about unsupported ALPS V9 touchpad
> >   Input: alps - cleanup ALPS_PROTO_V2 detection
> > =20
> >  drivers/input/mouse/alps.c |   99
> >  ++++++++++++++++++++++++++------------------
> >  drivers/input/mouse/alps.h |   10 ++---
> >  2 files changed, 62 insertions(+), 47 deletions(-)
>=20
> Series looks good to me:
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Thanks & Regards,
>=20
> Hans

Dmitry, can you take this series? Or is there some issue?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3069801.LtRCNeqyKX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldoLMQACgkQi/DJPQPkQ1JpuACgsP2X37ylngPm8FRDSFsZ9Vws
jzUAn2fOFpY6/+uTIvvqoK+3w4XoRMY8
=F6je
-----END PGP SIGNATURE-----

--nextPart3069801.LtRCNeqyKX--
