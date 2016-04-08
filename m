From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] Revert "Input: atmel_mxt_ts - disable interrupt for 50ms
 after reset"
Date: Fri, 8 Apr 2016 08:14:18 -0400
Message-ID: <20160408121418.GT23166@bill-the-cat>
References: <1460069545-10322-1-git-send-email-trini@konsulko.com>
 <5707756E.30506@itdev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mBUZ9KluUNbPxGHh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5707756E.30506@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
List-Id: linux-input@vger.kernel.org


--mBUZ9KluUNbPxGHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2016 at 10:10:06AM +0100, Nick Dyer wrote:
> On 2016-04-07 23:52, Tom Rini wrote:
> > This reverts commit 885f3fb9fa1f9e185e8a4e905157087495734349 due to this
> > change breaking the touchpad on the Chromebook Pixel 2015 on resume from
> > sleep or warm resets.
> >=20
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Nick Dyer <nick.dyer@itdev.co.uk>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Henrik Rydberg <rydberg@bitmath.org>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Hi Tom-
>=20
> Sorry that this has caused a problem. I suggest we try and find a 3rd
> option other than reverting this patch, because otherwise we will cause
> problems on other platforms.

Yeah, it would be good to fix all platforms.  I'm curious, was there an
observed problem on another platform or just a theoretical problem?

> I have a Pixel 2 here - can you advise how to reproduce?

I (and a bunch of other folks, the linux-samus people now point people
at using mxt-app every boot to reset the device) see this every time I
either suspend the laptop or do a warm boot into a new kernel (I didn't
try kexec but it too is probably broken).  Note that I'm not using
mainline to boot ChromeOS but I've got a regular Linux distro in ROOT-C.

--=20
Tom

--mBUZ9KluUNbPxGHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJXB6CaAAoJEIf59jXTHXZSUcEP/2aE2BS2vamjeF6TFYfkZ4wL
U04//fUt3KRD80F+Rr9znMGTUdD5dIs15tUX6XgOLNWqxtZA2a7/l3MZdV7+ru9i
q7j+L1fEvRpBOjgABcj2bdC0o4+QrZLe3RXOcGRfR/nlHp/dnIxpbJsWOG1d/kYd
DM3rQfOgbXNL587zW4kITcEU9lx1UnAPU8Y1BIirxmO8SMQI/+C3WthPLhrIz+Tt
wVExGzlXcb3rw1FVOQuudPQBUciXHPMWjSV4RyzYmutrogQ6SgLA06Vbpfb8Nf9r
ankq1oHbDqKiTWdOAAFOgWu0I7MsET49YAoH3UY0YRvWfByFqMaKvNRqitnIH1bJ
x+iQrB9gWP6MAtKhAaZs05JgeuFCUhHoYzg5GcZwXMf67v+9vLgG2q3k69f7bRRm
Vacakgxumy0ODBIkvx3wrIwsNmAuHlLbH/qTEOAJYl1erXylAwV/0CzfU+6A+mDc
/sLIy5l52BAvYkCKVLCP9FlSeNtGsLZXHIw+YAHfRz1knSGxeDQF6FecUFqxHC7/
ALfnhHEkd+n7yTv4PCLXTYlZIyn6cab9ta6q9vO4KVGIEW5qgWalSGXfgKSZZB30
kNvbtvNQWwKeGHiH3+UNrTnAsPFASED9uSh6DE/kpGdx03/bYUzfQ4XAsTB0zwNh
IFmhtXk8xN5Eyfk8FO6A
=xIqh
-----END PGP SIGNATURE-----

--mBUZ9KluUNbPxGHh--
