From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 0/2 v2] elantech: Additional info reporting with version
 2
Date: Thu, 20 May 2010 19:47:20 +0200
Message-ID: <4BF575A8.4040401@tudelft.nl>
References: <4BE592AB.7040801@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:48947 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab0ETRrW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 13:47:22 -0400
In-Reply-To: <4BE592AB.7040801@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 08-05-10 18:34, =C3=89ric Piel schreef:
> Hello,
>=20
> Will follow a second version of my patches to support more informatio=
n
> in the hardware version 2 of elantech. The main changes is that I've
> done much further reverse engineering on the protocol, and found out =
that:
>  * the width is acutally reported on 6 bits (not just 4)
>  * the coordinates of the three finger touch are rerported as a one
> finger touch
>  * it's possible to differentiate between 3 and 4 fingers touch
>=20
> The second patch to add MT support has only be adapted to work better
> with mousedev, as suggested by Dmitry.
>=20
> Patches are against git input-linux for-linus.

Hi Dmitry,
These two patches were not in your queue for 2.6.35-rc0. Is there any
additional changes that you'd like to have on them before merging?

Cheers,
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
