From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 10 Apr 2015 22:19:20 -0400
Message-ID: <871tjrv23b.fsf@gmail.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201504110039.40761@pali> <55285797.1080303@dell.com> <201504110114.45676@pali> <55285D94.8030306@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33196 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbbDKCT1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 22:19:27 -0400
In-Reply-To: <55285D94.8030306@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>, Pali =?utf-8?Q?Roh?= =?utf-8?Q?=C3=A1r?= <pali.rohar@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mario Limonciello <mario_limonciello@dell.com> writes:

> On 04/10/2015 06:14 PM, Pali Roh=C3=A1r wrote:
snip

>> Can you comment if this is also same problem with invalid packets
>> on E6440/E7440 machines?
>>
> Hi Pali,
>
snip
>
> The invalid packets on the Exx40 machines I believe is caused by some
> behavior that happens if the touchpad/trackstick receives data shortly
> after the internal keyboard was busy.  An interrupt is fired on the EC
> that will cause it discard data.  I think this is why it ends up on
> the other end looking like it does.
>
Is this to say that the issue will be fixed with a BIOS update?

Cheers,

=2D Ben


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJVKISoAAoJEHPt6ejPuu8BFfoH+QEFx4in6mxn4p96aj4qiLj0
XeBCOFyy4kL6WX24eRwXuM8weSLjmZF3fVOkyOJQuEeLWOzQoRUmGEBmc6JiDPol
zGs+6ZpsClO6ommewpIJtcUTcbpoW2+PH2bWCGO1/7P4gJRHRHXjJDr+TCPmaZ1g
AeAt3TdrsuvB2qb6aBOainyAq10Y/x8Xdvew5iZkt4uHiN8mod4YWUuIwgyYYQfu
h4XQnqNIDRIalSISXGXs1OvgTEEzHYm6piAze2iaDYwK+bklYrWZJvIg5+vYCATM
dEyANJYzV6l6+EG+gBP5QcPHPH2my4i0kwLmhHndMRSsJubOx8Az6I3ZUc4EmM4=
=GH7F
-----END PGP SIGNATURE-----
--=-=-=--
