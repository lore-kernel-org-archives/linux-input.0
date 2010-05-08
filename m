From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] elantech: Improved protocol support for hardware
 2
Date: Sat, 08 May 2010 19:45:55 +0200
Message-ID: <4BE5A353.2080308@euromail.se>
References: <4BE59352.4070407@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:45710 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753658Ab0EHRqv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 8 May 2010 13:46:51 -0400
In-Reply-To: <4BE59352.4070407@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi =C3=89ric,

>>From observation of the values sent from the hardware, it is possible=
 to
> determine also:
>  * the width of the touch (coded on 6 bits)
>  * the lowest coordinates of a three-finger touch
>  * whether there is just three fingers or more
> So report this information as well, and update the protocol descripti=
on
> document.
>=20
> Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
> ---

Please run the ./scripts/checkpatch.pl on patches before submitting the=
m, to
remove trivial formatting errors.

Cheers,
Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
