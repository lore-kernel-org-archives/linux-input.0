From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [RFC] [BUG?] Sixaxis Value Ranges
Date: Tue, 20 Sep 2011 12:57:18 +0200
Message-ID: <20110920125718.3243876084828c926b7e10dc@studenti.unina.it>
References: <CAEvUa7=KWnSFhWeOYf7wagRLODMNNKmdN_tpOnD1fuiwxN7aEg@mail.gmail.com>
	<376b78c42d77683e0d9a03e4e392e5e2.squirrel@host171.canaca.com>
	<CAEvUa7mtD1+ciKRn-S4gX9jWwFnecpDf_8w_NS+U55MdSxez4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__20_Sep_2011_12_57_18_+0200_+TpzEuxrmsnN6fRP"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:38162 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251Ab1ITK5d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 06:57:33 -0400
In-Reply-To: <CAEvUa7mtD1+ciKRn-S4gX9jWwFnecpDf_8w_NS+U55MdSxez4w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Michael <fedora.dm0@gmail.com>
Cc: simon@mungewell.org, linux-input@vger.kernel.org

--Signature=_Tue__20_Sep_2011_12_57_18_+0200_+TpzEuxrmsnN6fRP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Sep 2011 10:05:10 -0400
David Michael <fedora.dm0@gmail.com> wrote:

> Hi,
>=20
> On Wed, Sep 7, 2011 at 2:48 PM,  <simon@mungewell.org> wrote:
> > Are you sure that the dead zone is being applied in the device itself, =
and
> > not by the '/dev/input/js0' system?
>=20
> Sorry if I wasn't clear; it is /dev/input/jsX that loses data.
> Reading /dev/hidrawX gives results across the entire 0x000-0x3FF range
> as I would expect.
>=20
> I had actually been reading /dev/hidrawX to get at this data without
> issue until a few weeks ago when support was added to /dev/input/jsX.
> This dead zone became apparent in my applications immediately after I
> tried to switch.
>

Long delay to look at that, sorry.

I verified the input event system was OK too with:
	$ evtest /dev/input/event7 | egrep 'code (59|60|61)'
All values up to 1023 are received.

> > You could also try to completely disable the 'dead zone' on the joystick
> > sub-system.
>=20
> Are you referring to the JSIOCSCORR ioctl operation here?  Perhaps I
> could use this directly in my applications to ensure the
> accelerometers' values are more precise whenever they are run.  I
> still think too much information is lost with the default setting and
> new js_corr values should be considered for these axes, but the ioctl
> call should solve the issue in my case.
>=20

So David, did you solve this way?
I read in Documentation/input/joystick-api.txt that JSIOCSCORR should
not be used in a normal programs, only in calibration software.
Then I tried jstest-gtk and I was able to get all the values via the
joystick device too setting minimum and maximum values respectively to
0 and 1023.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__20_Sep_2011_12_57_18_+0200_+TpzEuxrmsnN6fRP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk54cY4ACgkQ5xr2akVTsAG/ugCfa6zXdG29bhcRCfioAZCIToNh
FlEAn3eZhyRUoAYRt2FJYPPK2yLgtIsF
=VZRi
-----END PGP SIGNATURE-----

--Signature=_Tue__20_Sep_2011_12_57_18_+0200_+TpzEuxrmsnN6fRP--
