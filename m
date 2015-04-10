From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Sat, 11 Apr 2015 00:39:40 +0200
Message-ID: <201504110039.40761@pali>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <54EE1917.4020805@dell.com> <201502252145.22577@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2348476.tcmEe9vnz9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35974 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbDJWjo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 18:39:44 -0400
In-Reply-To: <201502252145.22577@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>

--nextPart2348476.tcmEe9vnz9
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 February 2015 21:45:22 Pali Roh=C3=A1r wrote:
> On Wednesday 25 February 2015 19:48:55 Mario Limonciello wrote:
> > On 02/20/2015 02:41 PM, Pali Roh=C3=A1r wrote:
> > > On Friday 20 February 2015 20:56:23 Mario Limonciello
> > > wrote:
> > >=20
> > > resetafter=3D0 means to never reset (even if driver receive
> > > e.g thousand invalid packets). I think this is very
> > > dangerous if there will be other bugs either in linux
> > > driver or some other HW problems.
> > >=20
> > > For ALPS issue I added resetafter =3D pktsize * 2 (Allow 2
> > > invalid packets without resetting device). Cannot you find
> > > something similar for synaptics touchpads on XPS? (pktsize
> > > for ALPS is 6, no idea how big are synaptics packets).
> >=20
> > Pali,
> >=20
> > I've done some experimentation with increasing the size to
> > resetafter to up to pktsize * 4.  It will decrease the
> > number of occurrences of this problem, but the problem
> > still occurs eventually.  pktsize for synaptics is 6 as
> > well.  Would you recommend to continue to go higher than
> > that?  Since out_of_sync_cnt is reset when a full packet
> > gets received, some arbitrarily high number should likely
> > fix it to.
> >=20
> > That being said, if you try to more closely follow what
> > Windows does for the mouse, it's not issuing a reconnect no
> > matter how much bad data is received.
>=20
> I believe problem is similar to one as with ALPS devices.
> Driver always receive 6 bytes packet of data (no new byte is
> inserted and no byte is never lost), just one byte in packet
> is incorrect (does not match specification).
>=20
> Setting resetafter to > 0 prevent problems when driver enters
> into undefined state (either by bug in driver of other SW/HW
> problem). So I think setting resetafter to 0 is not good idea.
>=20
> But if we know that setting resetafter to 4*pktsize is not
> enough (e.g. with experimenting you saw that driver received
> more then 4 invalid packets consecutively), set it to higher
> value.
>=20
> I think it is still good idea to ignore maximally as many
> packets which can be received in time which is equal to
> resetting device.
>=20
> E.g. when period of time in which we are dropping all packets
> is higher then time needed to reset touchpad, we should stop
> dropping packets and immediately reset touchpad. In this case
> we could hit maybe problem in driver (there can be bugs) or
> touchpad is in some bad state and out-of-sync...
>=20
> So if your tests show that there are never invalid 10 packets
> consecutively, then set resetafter to 10 packets. Value 10 is
> still not high and if it fix problem with touchpad I think it
> is acceptable. But rather ask Dmitry what he thinks about it.
> This is just my opinion.

Hello Mario,
have you patched synaptics driver with some resetafter parameter?=20
And have some team in dell found reason for invalid packets?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2348476.tcmEe9vnz9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUoUSwACgkQi/DJPQPkQ1Ka9ACgrUKS3jSeNQG7+hCh9GlS/6U+
CXcAn2W5b8ka4oaXr0zRFuAX3SbjRXmt
=YlgB
-----END PGP SIGNATURE-----

--nextPart2348476.tcmEe9vnz9--
