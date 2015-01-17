From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/6] Fixes for ALPS trackstick
Date: Sat, 17 Jan 2015 11:01:56 +0100
Message-ID: <201501171101.56430@pali>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com> <201501152128.41419@pali> <20150115210216.GD19367@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3559434.yAT2WFysD9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36454 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbbAQKCA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Jan 2015 05:02:00 -0500
Received: by mail-wi0-f174.google.com with SMTP id n3so6914798wiv.1
        for <linux-input@vger.kernel.org>; Sat, 17 Jan 2015 02:01:58 -0800 (PST)
In-Reply-To: <20150115210216.GD19367@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

--nextPart3559434.yAT2WFysD9
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 15 January 2015 22:02:16 Dmitry Torokhov wrote:
> On Thu, Jan 15, 2015 at 09:28:41PM +0100, Pali Roh=C3=A1r wrote:
> > On Thursday 15 January 2015 20:38:18 Dmitry Torokhov wrote:
> > > On Thu, Jan 15, 2015 at 08:19:59PM +0100, Pali Roh=C3=A1r wrote:
> > > > On Thursday 15 January 2015 19:18:20 Dmitry Torokhov=20
wrote:
> > > > > On Thu, Jan 15, 2015 at 11:49:32AM +0100, Pali Roh=C3=A1r=20
wrote:
> > > > > > On Wednesday 14 January 2015 23:55:48 Dmitry
> > > > > > Torokhov
> >=20
> > wrote:
> > > > > > > Hi Pali,
> > > > > > >=20
> > > > > > > This series try to address the issue you brought
> > > > > > > regarding trackstick initialization on Dell
> > > > > > > Latitudes in a different way than the patches you
> > > > > > > proposed. Basically in this series we move
> > > > > > > resetting and all detection in alps_detect() and
> > > > > > > make sure we keep the state so alps_init() can
> > > > > > > reuse it and not perform the detection all over
> > > > > > > again. Doing this allows us to set up device
> > > > > > > characteristics (name, version, etc) properly
> > > > > > > from the get go while still performing reset only
> > > > > > > once.
> > > > > > >=20
> > > > > > > This is untested as I do not have any ALPS devices
> > > > > > > anymore so I'd appreciate you giving it a spin.
> > > > > > >=20
> > > > > > > Thanks!
> > > > > >=20
> > > > > > Hi Dmitry,
> > > > > >=20
> > > > > > on top of which branch/repository should I apply
> > > > > > your patches?
> > > > >=20
> > > > > Should be applicable to my 'next' branch (which I just
> > > > > upreved to 3.19-rc4).
> > > > >=20
> > > > > Thanks.
> > > >=20
> > > > Not working at top of next (0c3e994).
> > > >=20
> > > > Applying: Input: ALPS - renumber protocol numbers
> > > > Applying: Input: ALPS - make Rushmore a separate
> > > > protocol error: patch failed:
> > > > drivers/input/mouse/alps.c:1275 error:
> > > > drivers/input/mouse/alps.c: patch does not apply Patch
> > > > failed at 0002 Input: ALPS - make Rushmore a separate
> > > > protocol
> > >=20
> > > Hmm.. I created a new alps branch (based on 3.19-rc4), can
> > > you try it?
> > >=20
> > > Thanks.
> >=20
> > Compiled from your new alps branch (with "if (!priv)" fix)
> > and modprobing psmouse.ko caused laptop freeze :-( Even
> > sysrq not responded. So something is not working...
>=20
> Hmm, is it on text console or in X? Any chance you could go
> through pathes - there are only 8 of them including 2 of
> yours that should be unmodified.
>=20
> Thanks.

Hi, now I tested patch by patch and kernel crash is caused only=20
by last patch 6/6 and only after I touch touchpad or trackstick.

In text console it prints lot of panic messages and because it=20
prints lot of messages I cannot read (or record) more then last.

In last call trace I see that alps_register_bare_ps2_mouse() was=20
called and it generated page_fault. I do not understand why that=20
function was ever called (I do not have connected any PS/2 mouse=20
which can generate bare 3 bytes PS/2 packet) and also why that=20
function caused page fault.

Last time when I tested my original patch series I did not see=20
any of above problems... I also modified alps.c code to process=20
all ALPS packets into dev3 (as 3 bytes PS/2). It registered dev3=20
from alps_register_bare_ps2_mouse() without problem and reported=20
some data to userspace (of course data was incorrect, because=20
kernel processed 6 bytes ALPS packets as two 3 bytes bare PS/2=20
but there was no other problem...).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3559434.yAT2WFysD9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS6MxQACgkQi/DJPQPkQ1LKYQCgyzZSN5zSdsbJAwFlvdOmVsR2
Q2cAn3uWDmr/XHUG/wJg7wdwyEhh6RzG
=HIoZ
-----END PGP SIGNATURE-----

--nextPart3559434.yAT2WFysD9--
