From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] Revert "Input: atmel_mxt_ts - disable interrupt for 50ms
 after reset"
Date: Fri, 8 Apr 2016 08:39:13 -0400
Message-ID: <20160408123913.GV23166@bill-the-cat>
References: <1460069545-10322-1-git-send-email-trini@konsulko.com>
 <5707756E.30506@itdev.co.uk>
 <20160408121418.GT23166@bill-the-cat>
 <5707A376.2080404@itdev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pyeEmK0pobhMhLpj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5707A376.2080404@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
List-Id: linux-input@vger.kernel.org


--pyeEmK0pobhMhLpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 01:26:30PM +0100, Nick Dyer wrote:
> On 2016-04-08 13:14, Tom Rini wrote:
> > On Fri, Apr 08, 2016 at 10:10:06AM +0100, Nick Dyer wrote:
> >> On 2016-04-07 23:52, Tom Rini wrote:
> >>> This reverts commit 885f3fb9fa1f9e185e8a4e905157087495734349 due to t=
his
> >>> change breaking the touchpad on the Chromebook Pixel 2015 on resume f=
rom
> >>> sleep or warm resets.
> >>>
> >>> Cc: Olof Johansson <olof@lixom.net>
> >>> Cc: Nick Dyer <nick.dyer@itdev.co.uk>
> >>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>> Cc: Henrik Rydberg <rydberg@bitmath.org>
> >>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>
> >> Hi Tom-
> >>
> >> Sorry that this has caused a problem. I suggest we try and find a 3rd
> >> option other than reverting this patch, because otherwise we will cause
> >> problems on other platforms.
> >=20
> > Yeah, it would be good to fix all platforms.  I'm curious, was there an
> > observed problem on another platform or just a theoretical problem?
>=20
> Yes, reported by several customers and I've seen it myself in testing
> (Beagleboard + MXT Evaluation Kit). What happens is that the interrupt
> triggers too early during the power on sequence after a soft reset and you
> get an error message when the ISR fails to communicate on the appmode
> address. There have been some anecdotal reports that the device may end up
> stuck in the bootloader mode if this happens, although I'm not 100%
> convinced this is accurate.

Oh interesting, OK.

> >> I have a Pixel 2 here - can you advise how to reproduce?
> >=20
> > I (and a bunch of other folks, the linux-samus people now point people
> > at using mxt-app every boot to reset the device) see this every time I
> > either suspend the laptop or do a warm boot into a new kernel (I didn't
> > try kexec but it too is probably broken).  Note that I'm not using
> > mainline to boot ChromeOS but I've got a regular Linux distro in ROOT-C.
>=20
> OK. I will try it. My Pixel is running Ubuntu with a mainline kernel, so
> should be able to repro.

Thanks.  Happy to test patches when you get there and feel free to shoot
me patches to have more info get dumped out or whatever if needed.

--=20
Tom

--pyeEmK0pobhMhLpj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJXB6ZxAAoJEIf59jXTHXZSWlMP/jaQBjHCssvHFDE1XeaUh3/R
XICylx8Nx+5b1HnCqpPP67+nI61iYdouxYbk62m2zItydx8O0T6WIhZ61RkCc/jQ
/ZPJPjM7wcOUfcEmr3t9TeZwWOuQQk6fWalgDybhWX5Eq1L0hmteUho3DoOMWW19
zliWDQqqTYJXbeD9Ci5KncxIcViFS9IYLXm4S2tc1ZXr1UBb7PgbZRUvl37tdxEs
N2NbJ1PwxDkuz1UoTKfJKuSEbtVx2rpYbAV8gZOX7HkB1+LS6fIG14Mp6azlBnOV
C+1SfeEbRwRHdghHbD9KEBlQCkt1ZHUBo5ekUpWCYvww6ACBPo0seivViTuB+1RI
9yZHLArcCHlc9gMU5olG+JqMuiLep2bffFQQnEs/xb8CiBaQEQ85F/5eHHjxuM0c
+JuD1mwQcXW8hMLP2hNjR5qoTYbn/0NEBTDPYxfcY4rJRczCnPTUPP2EIV6gl62b
FVLqT21meMp3duCOwEgC80IAqqKqmOgkaVX2L9JnlnJbGP0dfCGjFtrP5Y80bO4b
ujmQbp4LTBA+NXibvf+fUMkjgHR9huYBlfFtLcr3KMGvBuQ7S/b3NQIr4XqFDm8E
KyD69Qt3SIGrS5LdeVjt3Rq3UbTMr8n5NuokmaP9fR7un7SnMLACjBKVMkARwPKB
I1gxQeugonMQ2n/U9dPw
=fpDO
-----END PGP SIGNATURE-----

--pyeEmK0pobhMhLpj--
