From: Heinz Wiesinger <HMWiesinger@liwjatan.at>
Subject: Re: T440s Synaptics clickpad: lost sync / KBC bad data
Date: Mon, 23 Dec 2013 09:00:23 +0100
Message-ID: <2151662.dpCX0YOWBV@titania>
References: <alpine.DEB.2.00.1312151507560.6449@icf1.fcevgrfzbqf.pbz> <loom.20131221T224832-537@post.gmane.org> <alpine.DEB.2.00.1312220001560.4559@icf1.fcevgrfzbqf.pbz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1564267.YldFb1JgXz"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx09lb.world4you.com ([81.19.149.119]:56571 "EHLO
	mx09lb.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab3LWIdH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 03:33:07 -0500
In-Reply-To: <alpine.DEB.2.00.1312220001560.4559@icf1.fcevgrfzbqf.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "J. Domburg" <jeroen@spritesmods.com>
Cc: linux-input@vger.kernel.org


--nextPart1564267.YldFb1JgXz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 22 December 2013 00:17:06 you wrote:
> On Sat, 21 Dec 2013, Heinz Wiesinger wrote:
> > J. Domburg <jeroen <at> spritesmods.com> writes:
> > I'm experiencing exactly the same issue. I have my T440s now for a bit
> > more
> > than two weeks. No issues with the touchpad until today when it suddenly
> > started acting up and I now see messages like these in dmesg
> 
> <snip>
> 
> Hi Heinz, all,
> 
> Always good to know mine is not an isolated case, although in this case, I
> wouldn't want to wish the issue on anyone else...
> 
> FYI: I haven't resolved this issue yet, but I'm thinking this may be a
> hardware issue after all. I decided to try and see if Win7 has this issue
> too, and got myself an USB-stick to install it from. I didn't even get
> past the installer. It gave me exactly the same issues as Linux has:
> an erratic and finally hanging cursor when using the clickpad.
> 
> I can understand Lenovo not wanting to support a Linux-only-issue so up
> till now I haven't bothered them yet with my issue, but I can't see my
> laptop not having mouse support in something as commonly used and
> well-supported by hardware manufacturers as the Win7 installer. This
> smells like an hardware issue to me, so I filed a warranty case today.
> 
> If people here don't mind, I'll keep the list updated, if anything so
> other people running into the same issues will have a reference and know
> this isn't necessarily a kernel thing.
> 
> Depending on how Lenovo reacts, I'll either have a working laptop or a
> good reason to go soldering and probing the i2c bus. In any case, I should
> end up with a solution I'd think :) although it'd be good if someone more
> versed in the i8042 and related things would look over my shoulder in the
> latter case.

I ended up doing the same and just got their reply. They seem to be pretty 
adamant about it being a software issue, with the argument being if it were a 
hardware issue the clickpad would either be working fine or not working at all, 
but not on and off. Did you hear back from them as well?

Grs,
Heinz
--nextPart1564267.YldFb1JgXz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iF4EABEIAAYFAlK37ZcACgkQp17cM+UqRsq3yAD/WpnvCVuIxCgUqbZJJ5M/VseP
FMtKHITkrswDI7K/3OwA/iBQbvP035Qt4Y9AoRyUTpqNyPCq6vAocFZaxqPhmz1e
=gSW/
-----END PGP SIGNATURE-----

--nextPart1564267.YldFb1JgXz--

