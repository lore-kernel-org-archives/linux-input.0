From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/5] Input: alps - cleanup
Date: Sat, 9 Jul 2016 11:58:03 +0200
Message-ID: <201607091158.04008@pali>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com> <20160707114101.GS29844@pali> <20160708213754.GF28589@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5267896.Qy6z5HGKYM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36307 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbcGIJ6I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jul 2016 05:58:08 -0400
In-Reply-To: <20160708213754.GF28589@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart5267896.Qy6z5HGKYM
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 08 July 2016 23:37:54 Dmitry Torokhov wrote:
> On Thu, Jul 07, 2016 at 01:41:01PM +0200, Pali Roh=C3=A1r wrote:
> > On Tuesday 21 June 2016 13:27:30 Pali Roh=C3=A1r wrote:
> > > On Monday 20 June 2016 17:31:13 Dmitry Torokhov wrote:
> > > > Hi Pali,
> > > >=20
> > > > On Mon, Jun 06, 2016 at 01:23:56PM +0200, Pali Roh=C3=A1r wrote:
> > > > > This patch series cleanup usage of alps_model_data table.
> > > > >=20
> > > > > Pali Roh=C3=A1r (5):
> > > > >   Input: alps - move ALPS_PROTO_V6 out of alps_model_data
> > > > >   table Input: alps - move ALPS_PROTO_V4 out of
> > > > >   alps_model_data table Input: alps - move ALPS_PROTO_V1 out
> > > > >   of alps_model_data table Input: alps - warn about
> > > > >   unsupported ALPS V9 touchpad Input: alps - cleanup
> > > > >   ALPS_PROTO_V2 detection
> > > >=20
> > > > Frankly, I do not quite like this series. The rule of thumb we
> > > > had: if we can use e7 data to identify the device it should go
> > > > into table, if we need to have more elaborate logic - then
> > > > implement it in __alps_indentify(). I would understand if we
> > > > got rid of the table completely, but we didn't.
> > >=20
> > > Hans and me agreed that alps_model_data array is for old
> > > touchpads defined as quirks table. So in this patch series I'm
> > > trying to eliminate using that array. And it is possible for V1,
> > > V4 and V6 touchpads because each protocol has only one entry in
> > > table. And last user is just V2 protocol which is I think
> > > better...
> > >=20
> > > So this is my motivation for this patch series.
> >=20
> > Any suggestion how to rework it? And any agreement if we should
> > remove V1/V4/V6 from alps_model_date or let it stay here?
>=20
> As I mentioned below I am happy with removing ALPS_PROTO_V4 and
> subsequently command_mode_resp from alps_model_info, while leaving
> the rest in the table.

Now I'm not fully understand what you mean. This patch series does not=20
remove ALPS_PROTO_V4 support. Just move ALPS_PROTO_V4 out of=20
alps_model_info table structure (same as for V1 and V6). Field=20
command_mode_resp is removed from alps_model_info, but that can be done=20
only because command_mode_resp is used by ALPS_PROTO_V4 (which is moved=20
out of alps_model_info).

So I do not understand why do you think moving ALPS_PROTO_V4 out of=20
alps_model_info is good, but ALPS_PROTO_V6 or ALPS_PROTO_V1 not.

> Thanks.
>=20
> > > > I think the patch removing ALPS_PROTO_V4 and subsequent patch
> > > > removing command_mode_resp from alps_model_info are good, the
> > > > rest are not so much.
> > > >=20
> > > > Thanks.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5267896.Qy6z5HGKYM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAleAyqsACgkQi/DJPQPkQ1I+LQCffOUL7qRS/Vj/v5s3ZdA63Jif
ZWkAoItm+VTHo3qDH1sO9XvT7G4xcMTc
=I/F/
-----END PGP SIGNATURE-----

--nextPart5267896.Qy6z5HGKYM--
