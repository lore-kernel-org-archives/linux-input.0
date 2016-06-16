From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/5] Input: alps - cleanup
Date: Thu, 16 Jun 2016 22:24:57 +0200
Message-ID: <201606162224.57932@pali>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1586745.lGX5kKoCob";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37255 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbcFPUZC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2016 16:25:02 -0400
In-Reply-To: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1586745.lGX5kKoCob
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 06 June 2016 13:23:56 Pali Roh=C3=A1r wrote:
> This patch series cleanup usage of alps_model_data table.
>=20
> Pali Roh=C3=A1r (5):
>   Input: alps - move ALPS_PROTO_V6 out of alps_model_data table
>   Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
>   Input: alps - move ALPS_PROTO_V1 out of alps_model_data table
>   Input: alps - warn about unsupported ALPS V9 touchpad
>   Input: alps - cleanup ALPS_PROTO_V2 detection
>=20
>  drivers/input/mouse/alps.c |   99
> ++++++++++++++++++++++++++------------------
> drivers/input/mouse/alps.h |   10 ++---
>  2 files changed, 62 insertions(+), 47 deletions(-)

Dmitry, can you look at this series?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1586745.lGX5kKoCob
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldjCxkACgkQi/DJPQPkQ1LHMQCgganc88uGGFeByrBTxF4BtIRf
ZkEAn3QYuegQSPtMQBh6NCaJlRA5QOqa
=Q9wp
-----END PGP SIGNATURE-----

--nextPart1586745.lGX5kKoCob--
