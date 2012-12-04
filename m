From: "Jan-Matthias Braun" <jan_braun@gmx.net>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Tue, 4 Dec 2012 23:11:27 +0100
Message-ID: <201212042311.27348.jan_braun@gmx.net>
References: <8159607.SRZZrRIPNF@orthese> <3334839.0y63iIARTX@orthese> <2305931.9GBOrRiDsv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1908756.5KHSWp30x7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailhost.physik3.gwdg.de ([134.76.92.128]:52822 "EHLO
	mailhost.physik3.gwdg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2LDWlR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 17:41:17 -0500
In-Reply-To: <2305931.9GBOrRiDsv@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@vger.kernel.org

--nextPart1908756.5KHSWp30x7
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Am Donnerstag 29. November 2012, 23:28:55 schrieb Rafael J. Wysocki:
> On Thursday, November 29, 2012 03:03:04 PM Jan-Matthias Braun wrote:
> > Am Donnerstag, 29. November 2012, 01:20:04 schrieb Rafael J. Wysocki:
> > > On Tuesday, November 27, 2012 09:26:11 PM Jiri Kosina wrote:
> > > > On Sun, 25 Nov 2012, Jan-Matthias Braun wrote:
> > > > > I have now done a git bisection from 3.0 to 3.1 and have found co=
mmit
> > > > > 1e2ef05bb8cf851a694d38e9170c89e7ff052741 PM: Limit race condition=
s between runtime PM and system sleep (v2)
> > > > > to be the first one to introduce the necessity of a module reload=
 after resume.
> > >=20
> > > So with that commit your device doesn't work after resume from system=
 suspend
> > > unless you reload the driver?
> >=20
> > Yes. Additionally, with later kernel revisions even this won't help, bu=
t I could imagine this to be a consequence of the same problem.
> >=20
> > > > > I hope that this helps in finding a solution. As I (again) don't =
immediatly
> > > > > know how to go on, I kindly ask you to give me some hints for tes=
ting/patching
> > > > > or even a possible solution. :-)
> > >=20
> > > Can you apply the patch below to the current mainline kernel and see =
if it makes any
> > > difference, please?
> >=20
> > It does: Current mainline kernel (version >3.7.0-rc7 from git) is not s=
howing
> > the problem, if the patch is applied.
>=20
> If you apply the patch below instead of the previous one, does it make
> the problem return, or is it still good?

again, the problem does not occur; the resume behaviour of the touchscreen =
is still good.

Thanks a lot for testing!

Jan

--nextPart1908756.5KHSWp30x7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlC+dQ8ACgkQjZbhs+19QO+dsgCg0g1srUV51/RjgM8lHN2+iovv
lrYAoJpUHlRdmGhDHBvRdErn7FvvIm0b
=2q9g
-----END PGP SIGNATURE-----

--nextPart1908756.5KHSWp30x7--
