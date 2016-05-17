From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Tue, 17 May 2016 11:50:06 +0200
Message-ID: <877fet10a9.fsf@smart-cactus.org>
References: <87eg9j6zf7.fsf@smart-cactus.org> <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM> <87bn45gr0e.fsf@smart-cactus.org> <20160517082309.GZ29844@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56032 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbcEQJuN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 05:50:13 -0400
In-Reply-To: <20160517082309.GZ29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Allen_Hung@Dell.com, Mario_Limonciello@Dell.com, linux-input@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:

> Hi Ben!
>
> Maybe it could help you, look at my email sent to linux-input ML year
> ago: http://thread.gmane.org/gmane.linux.kernel.input/41210

Hi Pali!

Thanks, this looks great (assuming this is in fact the protocol spoken
by the E7470 hardware; perhaps Allen could confirm this?). I'll have a
go at rebasing this sometime soon, although it looks like this may take
a fair bit of work as the patch is of the usual... questionable quality
that you'd expect from a hardware vendor and on top of that the driver
itself seems to have evolved significantly.

>
> Also try to look at dell drivers page, there could be linux package for
> your laptop with drivers. Lot of them used to be in dkms format
> (upstream source code with dell changes).
>
I've been unable to find a support package for my machine on the web
site. However, I'm also in touch with Dell through the usual support
channel so perhaps they'll be able to provide a more up-to-date code
drop.

> ALPS code from Dell were open source, it was just hard to find it and
> compile it on other then one kernel version. And harder to generate
> patch (like I did in above email)...
>
Right, as I said it looks like rebasing this code drop onto a recent
kernel might require quite some effort.

I do wish that Dell would apply more pressure on their input device
vendors to take upstream support (or open protocol documentation)
seriously. It's very frustrating that we need to go through this same
process with every hardware iteration.

Thanks again for the reference, Pali!

Cheers,

=2D Ben


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXOulOAAoJEHPt6ejPuu8BexwIAMHcGuM0Fu513eNjTnFKaOF+
hKUZTSaG7Dd3xBI24ff3cYxEtuqBTMfkjqQvKjRrizyw66yvYhR8JxW3urLnclL5
uKW8VjB9Ghsw5D8iYQ1cigRyI9eZ7fgPjfM59RbggE1fI4MW6DM4NppBYWqQZUCs
d1uD8DoCIuK/j0XMnu9KdhxOl1QBQFZNSV6iOc9sUXvNiN5YcJ4CQ826daneHies
OE4lmjuT1ITijKxNze43LcwFfuOOk2DKQOHap8fNsmh9wbeoK7UgCyFD4POwabTW
aa2eOXdzD349hntGgwgvAtfavjm6Zn5RfNoWRiZXEUWDYmZLl8xzZL6feefNe4w=
=0lel
-----END PGP SIGNATURE-----
--=-=-=--
