From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Canonical has own Ubuntu driver for ALPS 73 03 28 devices
Date: Mon, 20 Jun 2016 19:47:58 +0200
Message-ID: <201606201947.58860@pali>
References: <201606190143.46444@pali> <CAE7LaDDBOqAaZP38tX4kuzd2108np+0xb0BgtcAoKFfo9QmikQ@mail.gmail.com> <20160620173757.GB22426@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7767297.iE3A2aoeYO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38326 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346AbcFTRsS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 13:48:18 -0400
In-Reply-To: <20160620173757.GB22426@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anthony Wong <anthony.wong@canonical.com>, Christoph Hellwig <hch@infradead.org>, Ben Gamari <ben@smart-cactus.org>, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Ben Morgan <Ben_Morgan@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart7767297.iE3A2aoeYO
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 20 June 2016 19:37:57 Dmitry Torokhov wrote:
> On Tue, Jun 21, 2016 at 01:29:41AM +0800, Anthony Wong wrote:
> > On 20 June 2016 at 18:20, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote:
> > > On Monday 20 June 2016 03:16:36 Christoph Hellwig wrote:
> > > > On Sun, Jun 19, 2016 at 01:43:46AM +0200, Pali Roh??r wrote:
> > > > > I do not understand it... Why Canonical is hidden and don't
> > > > > communicate with rest of world? Otherwise touchpads could
> > > > > work out-of-box on non Ubuntu systems too with mainline
> > > > > kernel.
> > >=20
> > > It must be really frustrating for Ben and other people (me too)
> > > who in last months working on ALPS patches to support that
> > > touchpad as we know that Canonical already had some working code
> > > for that touchpad...
> >=20
> > Hi Pali,
> >=20
> > The fix in the DKMS package you referenced was not written by
> > Canonical but by ALPS, as it came from them I think it is
> > reasonable they send it to upstream, isn't it? As you can see the
> > patch is non-trivial.
> >=20
> > After we got the patch from ALPS, we had follow-up conversation a
> > few times with our contacts at Taiwan and asked if they would
> > upstream it, but unfortunately to no avail. I am as desperate as
> > you if the fix cannot land in mainline, which means many Linux
> > users will not benefit from it.  We also had opened this bug [1]
> > for this particular issue, there is nothing to hide. If there is
> > any code written by us, we happily submit them upstream.
>=20
> Why couldn't you guys send it upstream yourselves?

=46or ALPS 73 03 28 touchpad it is probably too late now, see:
http://thread.gmane.org/gmane.linux.kernel.input/49651

> > [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1571530
> >=20
> > > On Monday 20 June 2016 03:16:36 Christoph Hellwig wrote:
> > > > Because Canonical doesn't collaborate with the upstream
> > > > community in any meaninful way.  They've been a bad player
> > > > since day 1 and will always be.
> >=20
> > This reminded me of this old thread [2]. How hard is it to run this
> > command in your kernel git tree?
> >=20
> >     $ git log --pretty=3Doneline --author=3Dcanonical
> >=20
> > [2] https://www.spinics.net/lists/linux-bluetooth/msg47286.html
> >=20
> > Thanks,
> > Anthony

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart7767297.iE3A2aoeYO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldoLE4ACgkQi/DJPQPkQ1KllQCeJLuFSSLPPGZiQWitBgkjf8pj
TlQAnR3kNR+dd9VU6wid9rZ50C6eQ0y6
=7suR
-----END PGP SIGNATURE-----

--nextPart7767297.iE3A2aoeYO--
