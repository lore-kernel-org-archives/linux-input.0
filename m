From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: Problems with a Zytronic touchscreen on kernel 3.5 (USB ID 0x14c8:0x0005) - regression from kernel 3.0
Date: Wed, 01 Aug 2012 11:35:19 +0100
Message-ID: <1937294.3n9nv0bdlA@f17simon>
References: <1514977.1uDfr8LPn9@f17simon> <CAN+gG=EZHh0AU43DzU35M0z5tyE75aRU8_XYwOhxmVHQYycGtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3322132.dUGWsCr8hL"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp05.uk.clara.net ([195.8.89.38]:58071 "EHLO
	claranet-outbound-smtp05.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750902Ab2HAKf3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Aug 2012 06:35:29 -0400
In-Reply-To: <CAN+gG=EZHh0AU43DzU35M0z5tyE75aRU8_XYwOhxmVHQYycGtw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Greg Kroah-Hartman <greg@kroah.com>


--nextPart3322132.dUGWsCr8hL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 1 August 2012 11:50:28 Benjamin Tissoires wrote:
> Hi Simon,
> 
> well, it's a known bug. This panel is now fixed in 3.6-rc0, and I
> submitted the fix for stable. I'm still waiting for the stable
> approval.
> 
<snip>
> 
> PS: the fix is at
> 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=4aceed37e315e8eaa26cb4c8dfd619a32fa24669
> 
I've just confirmed that applying 4aceed37e315e8eaa26cb4c8dfd619a32fa24669 on 
top of 3.5 fixes my problem.

Thanks,
-- 
Simon Farnsworth
Software Engineer
ONELAN Ltd
http://www.onelan.com

--nextPart3322132.dUGWsCr8hL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAABAgAGBQJQGQZtAAoJEIKsye9/dtRWMt0H+wSvJN/ZTH7ev+Iqt70vXKul
BIGGP7tVtfDF9AvCKCRWgGbcBSIKjHutiRaSaxK1TgUjQCBMyxcdwqCC+8kbFUo1
fd7IrF8VLF1PMIY4NxgwsnnBnJoCXUJjo28ZU8Ga8/H3D9NVlxvNTVKwgjR4leKG
rbGXP+OwhuzkXpenStbfaZd6pueuxjOILqeeMvzlILGgcgzZzQ7k27yykQBUeJU4
4tlTPf1eoK2rxujFRzy0GkxEGQFdoURgkJ66RhD1XQsZ88oKIJVJZM4/9oEcT03F
UQaZWjJWPCGUZFhnsQsI8vOe1lCBiSswCXrNEnmGWGkogTJKwW9Iwb5tCdsfyU0=
=0xn/
-----END PGP SIGNATURE-----

--nextPart3322132.dUGWsCr8hL--

