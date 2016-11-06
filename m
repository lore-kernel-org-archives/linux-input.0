From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Fix TrackStick support for SS5 hardware
Date: Sun, 6 Nov 2016 20:57:49 +0100
Message-ID: <201611062057.52517@pali>
References: <20161024210122.GA2919@TopQuark.net> <20161101093507.GE3081@pali> <20161105163047.GE2927@TopQuark.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1749483.M6VmA2XnQD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35120 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbcKFT5z (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 6 Nov 2016 14:57:55 -0500
Received: by mail-wm0-f43.google.com with SMTP id a197so145616008wmd.0
        for <linux-input@vger.kernel.org>; Sun, 06 Nov 2016 11:57:54 -0800 (PST)
In-Reply-To: <20161105163047.GE2927@TopQuark.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@paulsd.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

--nextPart1749483.M6VmA2XnQD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 05 November 2016 17:30:47 Paul Donohue wrote:
> I was trying to avoid duplicating the detection logic (that is
> already implemented in alps_get_pkt_id_ss4_v2(), but yes, it is
> possible to implement the detection the same way as the other
> devices.

Ah... I see. alps_get_pkt_id_ss4_v2() should returns enum SS4_PACKET_ID=20
but for some reasons it is unsigned char...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1749483.M6VmA2XnQD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgfi0AACgkQi/DJPQPkQ1KH7ACeLPE6EP7lpPhoPdVVv/eIvWKL
lIcAmwVAjQ2TsfdPSEZbM106LpHTQqfj
=IWIr
-----END PGP SIGNATURE-----

--nextPart1749483.M6VmA2XnQD--
