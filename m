From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 20:24:20 +0100
Message-ID: <201502202024.20741@pali>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <54E62893.1060806@dell.com> <20150220184717.GC20060@dtor-glaptop>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6572830.EZzUI7F2E1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35703 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbBTTYY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 14:24:24 -0500
In-Reply-To: <20150220184717.GC20060@dtor-glaptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario Limonciello <mario_limonciello@dell.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--nextPart6572830.EZzUI7F2E1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 20 February 2015 19:47:17 Dmitry Torokhov wrote:
> Hi Mario,
>=20
> On Thu, Feb 19, 2015 at 12:16:51PM -0600, Mario Limonciello=20
wrote:
> > Hi Dmitry,
> >=20
> > On 02/19/2015 11:16 AM, Dmitry Torokhov wrote:
> > >What kind of glitch is this? Is there a certain pattern to
> > >it? Even if we do not reset the mouse the logs will be
> > >full of error messages.
> > >
> > >Thanks.
> >=20
> > From waveform capture data leaving the touchpad is valid,
> > but when it is resent through the EC it's getting
> > corrupted.  This isn't exclusive to Linux setting it up
> > wrong or anything, it also happens on Windows.  On Windows
> > 7 the touchpad driver does not issue a reset from the bad
> > data however.
> >=20
> > The glitch is more prevalent as the machine is turned on but
> > seems to go away after it's been running a while.  We
> > currently don't believe it to be a problem with the EC
> > firmware, but we are still exploring other firmware based
> > solutions.
>=20
> Can it be related to ther Dell models (Latitudes with ALPS
> touchpad) also sending junk data under certain conditions
> (adding Pali to teh CC as he was looking at this issue)?
>=20

Dell Latitude Exx40 models (with ALPS touchpads) have similar=20
problems. Linux psmouse.ko/alps.c driver receive invalid packets=20
which cause lot of problems... ALPS people told me those packets=20
which was found on i8042 bus are really invalid ALPS packets and=20
do not come from ALPS touchpad. Unless there is invisible bug in=20
ALPS touchpad firmware (which was not discovered yet), problem is=20
either in Dell EmeddedController where is connected ALPS touchpad=20
or in Dell BIOS/UEFI (which I believe can modify any such data).

If Dell share EC firmware code in more models (Latitude and XPS)=20
or share some BIOS parts, then problem can be really there.

> > Yes, the logs do fill up with error messages about the bad
> > data within the first few minutes of usage.  In my opinion
> > not freezing but getting errors in the log is better than
> > freezing and getting errors in the log, so we're at least
> > trying to provide a workaround for the problem.  If we come
> > up with a firmware based solution I'd be happy to adjust or
> > remove this later.
>=20
> I am not saying we do not need the solution, I am wondering if
> we can suppress errors altogether. I am also curious why
> reset does not work as it should reinitialize the driver
> completely.
>=20
> And even if you do fix the firmware majority of users will
> still need the software solution as updating BIOS is not
> something that happens often.
>=20
> Thanks.

I do not know what can kernel do when it receive invalid PS/2=20
data from i8042 bus. If bogus packets are total random we can=20
just try to ignore them and try be not out-of-sync. No idea how=20
working solution it would be for new XPS model. Looks like for=20
Latitude Exx40 models with their problems it is working...

Of course correct way is to fix firmware or BIOS or which part of=20
HW is buggy. Ideally distribute that firmware fix to users. I=20
heard that synaptics touchpad supports something like on-the-fly=20
firmware load (without flashing it) which will be active until=20
notebook shutdown.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6572830.EZzUI7F2E1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTnieQACgkQi/DJPQPkQ1JVMQCeLTZJnXdbRbRyCnUrG1oCRwgF
ZsgAoKhI/2y+ZfbEYdAhS3HfqZLVWZax
=n3w8
-----END PGP SIGNATURE-----

--nextPart6572830.EZzUI7F2E1--
