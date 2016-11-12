From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v5 0/3] Input: ALPS - Bug fix and cleanup for SS5 hardware
Date: Sat, 12 Nov 2016 13:29:25 +0100
Message-ID: <201611121329.26484@pali>
References: <20161110151942.GA3969@pali> <201611120203.44330@pali> <20161112010640.GA37875@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1803173.IHDnYaEtZl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33199 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936990AbcKLM33 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 07:29:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so3062703wmu.0
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 04:29:28 -0800 (PST)
In-Reply-To: <20161112010640.GA37875@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Donohue <linux-kernel@paulsd.com>, linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

--nextPart1803173.IHDnYaEtZl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 12 November 2016 02:06:40 Dmitry Torokhov wrote:
> On Sat, Nov 12, 2016 at 02:03:42AM +0100, Pali Roh=C3=A1r wrote:
> > On Saturday 12 November 2016 01:56:21 Dmitry Torokhov wrote:
> > > On Fri, Nov 11, 2016 at 02:59:09PM +0100, Pali Roh=C3=A1r wrote:
> > > > On Thursday 10 November 2016 17:44:43 Paul Donohue wrote:
> > > > > This series includes a bug fix and assorted cleanup for the
> > > > > Alps SS5 (SS4 v2) code.
> > > > >=20
> > > > > Changes in v5:
> > > > > * Moved TrackStick decoding logic to
> > > > > alps_process_packet_ss4_v2() to
> > > > >=20
> > > > >   make the code more consistent with other protocol versions
> > > > >   (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
> > > > >=20
> > > > > Changes in v4:
> > > > > * Fixed patch formatting issues
> > > > > * Correct casting issues in macros added in v3
> > > > >=20
> > > > > Changes in v3:
> > > > > * Added additional code cleanup to make the code easier to
> > > > > understand
> > > > >=20
> > > > >   (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
> > > > >=20
> > > > > Changes in v2:
> > > > > * For consistency with other Alps functions, check packet
> > > > > bytes for
> > > > >=20
> > > > >   packet type rather than adding a flag to alps_fields for
> > > > >   packet
> > > > >=20
> > > > > type. (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
> > > > >=20
> > > > > Paul Donohue (3):
> > > > >   Input: ALPS - Fix TrackStick support for SS5 hardware
> > > > >   Input: ALPS - Clean up TrackStick handling for SS5 hardware
> > > > >   Input: ALPS - Clean up code for SS5 hardware
> > > > > =20
> > > > >  drivers/input/mouse/alps.c | 59
> > > > >=20
> > > > > +++++++++++++++++++++++++---------------------
> > > > > drivers/input/mouse/alps.h | 22 ++++++++++++++++-
> > > > >=20
> > > > >  2 files changed, 53 insertions(+), 28 deletions(-)
> > > >=20
> > > > Whole patch series looks fine.
> > > > You can add my Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > >=20
> > > FYI: I do not see a dingle email from Paul, only your replies.
> >=20
> > Patches were sent to linux-input@vger.kernel.org ML. Maybe some
> > spam filter ate emails? Btw I added you to receivers of my last
> > sent email.
>=20
> Yes, I looked there as well and did not see anything but you replies.
>=20
> Thanks.

Do you need to resend patches? Or have you already found them?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1803173.IHDnYaEtZl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgnCyYACgkQi/DJPQPkQ1JhdwCgumvBL2ZrZ2BL25DK9fMJBGeO
e8sAmwc2C7TfaclaSkE52fFP2obE+4EA
=+wou
-----END PGP SIGNATURE-----

--nextPart1803173.IHDnYaEtZl--
