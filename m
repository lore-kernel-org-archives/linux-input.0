From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 21:41:15 +0100
Message-ID: <201502202141.16017@pali>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502202024.20741@pali> <54E79167.6070701@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4588770.JQggD2fPSe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:53810 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbBTUlT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 15:41:19 -0500
In-Reply-To: <54E79167.6070701@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>

--nextPart4588770.JQggD2fPSe
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 20 February 2015 20:56:23 Mario Limonciello wrote:
> Hi Pali & Dmitry,
>=20
> On 02/20/2015 01:24 PM, Pali Roh=C3=A1r wrote:
> > On Friday 20 February 2015 19:47:17 Dmitry Torokhov wrote:
> >> Hi Mario,
> >>=20
> >> On Thu, Feb 19, 2015 at 12:16:51PM -0600, Mario Limonciello
> >=20
> > wrote:
> >> Can it be related to ther Dell models (Latitudes with ALPS
> >> touchpad) also sending junk data under certain conditions
> >> (adding Pali to teh CC as he was looking at this issue)?
>=20
> We use the same embedded controller design and codebase on
> many of our laptops.  Depending on the root cause, it's
> possible to be the same problem that's happening on Latitude
> 6x40.  I'm leaning on it's likely not the same problem though
> because on Latitude 6x40 II understand the issue does not
> show up on the other side of the EC when the waveform was
> analyzed in Windows.
>=20
> > Dell Latitude Exx40 models (with ALPS touchpads) have
> > similar problems. Linux psmouse.ko/alps.c driver receive
> > invalid packets which cause lot of problems... ALPS people
> > told me those packets which was found on i8042 bus are
> > really invalid ALPS packets and do not come from ALPS
> > touchpad. Unless there is invisible bug in ALPS touchpad
> > firmware (which was not discovered yet), problem is either
> > in Dell EmeddedController where is connected ALPS touchpad
> > or in Dell BIOS/UEFI (which I believe can modify any such
> > data).
>=20
> A colleague has shared to me some information about the issue
> on 6x40 laptops as well.  There was a recent EC change
> (released within last 2 weeks or so) that helps to fix
> problems with i8042 traffic. It was intended to fix keyboard
> repeating, but it may also fix the touchpad data.  Can you
> please confirm if the new BIOS/EC update fixes the problem?
>=20

I have BIOS version A05 on my E6440 machine. That version does=20
not have problems with "repeating keys" and my workaround for=20
ALPS touchpad (which is in mainline tree and -stable trees now)=20
works fine. If I do not see other problems, I will not update=20
BIOS (just because current version working -- with workarounds).

But CCing Rob. He told me as first about existence of new BIOS=20
version for E6440 and he is already testing new version of BIOS,=20
so can share details.

Mario, can you share some details about that new BIOS update? If=20
it is not secret, how was problem with "repeating keys" fixed?=20
Why linux had more problems as Windows? Cannot we implement some=20
"workaround" in linux kernel to prevent that (or similar)=20
problems in future?

> > If Dell share EC firmware code in more models (Latitude and
> > XPS) or share some BIOS parts, then problem can be really
> > there.
>=20
> Yes, specifically with XPS 13 (2015) the code base for the EC
> has common components with Latitude and Precision.  For the
> XPS problem, the EC code has been reviewed but not found any
> issues with it pointing to an EC problem.  There are other
> aspects that are being explored such as the input to the EC
> being overamplified by a mis configured buffer in the
> touchpad.  This would cause the data to saturate outside of
> spec in the EC.
>=20
> >>> Yes, the logs do fill up with error messages about the bad
> >>> data within the first few minutes of usage.  In my opinion
> >>> not freezing but getting errors in the log is better than
> >>> freezing and getting errors in the log, so we're at least
> >>> trying to provide a workaround for the problem.  If we
> >>> come up with a firmware based solution I'd be happy to
> >>> adjust or remove this later.
> >>=20
> >> I am not saying we do not need the solution, I am wondering
> >> if we can suppress errors altogether. I am also curious
> >> why reset does not work as it should reinitialize the
> >> driver completely.
>=20
> Thanks.  I think it's fair to hide them when resetafter=3D0 is
> configured (such as the quirk turns on).  If you agree, i'll
> adjust the patch to do this. To clarify the problem, the
> errors will show up and after 5 the touchpad is reset.  The
> reset is what causes the freeze because the touchpad driver
> takes 1-3 seconds to reinitialize.  The problem will happen
> continue to happen though as it's believed to be higher up
> the chain. If resetafter=3D0 is set, the errors will show up in
> the logs, but the touchpad recovers on it's own.
>=20

resetafter=3D0 means to never reset (even if driver receive e.g=20
thousand invalid packets). I think this is very dangerous if=20
there will be other bugs either in linux driver or some other HW=20
problems.

=46or ALPS issue I added resetafter =3D pktsize * 2 (Allow 2 invalid=20
packets without resetting device). Cannot you find something=20
similar for synaptics touchpads on XPS? (pktsize for ALPS is 6,=20
no idea how big are synaptics packets).

> >> And even if you do fix the firmware majority of users will
> >> still need the software solution as updating BIOS is not
> >> something that happens often.
> >>=20
> >> Thanks.
>=20
> Yes, thanks I agree on this.  We are working on making
> firmware flash on Latitude/Precision/XPS easier for Linux
> users, but we're not there yet on everything.  If you look on
> XPS 13 (2015) it's one of the first to support firmware flash
> from F12 boot menu.  It will search any USB disks and
> partitions that firmware can mount such as EFI system
> partition.
>=20

Older Dell HW (laptops, desktops, servers) supported BIOS update=20
directly from Linux (ubuntu has needed tools in standard=20
repositories). It is not supported/provided anymore? I see that=20
dell_rbu driver is still in linux kernel.

dell_rbu.ko:
description:    Driver for updating BIOS image on DELL systems

> > I do not know what can kernel do when it receive invalid
> > PS/2 data from i8042 bus. If bogus packets are total random
> > we can just try to ignore them and try be not out-of-sync.
> > No idea how working solution it would be for new XPS model.
> > Looks like for Latitude Exx40 models with their problems it
> > is working...
> >=20
> > Of course correct way is to fix firmware or BIOS or which
> > part of HW is buggy. Ideally distribute that firmware fix
> > to users. I heard that synaptics touchpad supports
> > something like on-the-fly firmware load (without flashing
> > it) which will be active until notebook shutdown.
>=20
> Yes, if we can fix this in firmware, that's our goal too.=20
> If/when we get a firmware fix, the quirk can be configured to
> only activate on earlier versions of the firmware that are
> affected.
>=20
> I'm not aware of the on-the-fly firmware load for Synaptics.=20
> Do you know more about this?  In dual mode touchpads is this
> only present on the I2C mode?

There is problem with some synaptics touchpad on some laptops=20
(probably not dell). Windows driver loads own firmware into=20
synaptics touchpad which use different protocol (as original=20
firmware in touchpad). And that loaded firmware is active until=20
laptop is not shut down. When you reboot from Windows to Linux=20
then linux kernel driver refuse to identify & use touchpad=20
because it does not support that new firmware loaded by=20
Windows... I do not know lot of about this problem, I just heard=20
about it from other people. I did not see any laptop "in action".

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4588770.JQggD2fPSe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTnm+wACgkQi/DJPQPkQ1IPZgCffvkDs7kSTHSPHSbECLqN7pAo
etQAoJo+uYR2Q64gC14R/utPg9kqka6G
=VbOo
-----END PGP SIGNATURE-----

--nextPart4588770.JQggD2fPSe--
