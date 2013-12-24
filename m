From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [RFC  v3] Add ff-memless-next
Date: Tue, 24 Dec 2013 03:11:57 +0100
Message-ID: <16141479.Xuvegy6qFd@geidi-prime>
References: <1494187.y8mYFDm1lA@geidi-prime> <1387844508.22671.73.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.spider.cz ([31.31.77.241]:56949 "EHLO prifuk.cz"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753836Ab3LXCMD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 21:12:03 -0500
In-Reply-To: <1387844508.22671.73.camel@joe-AO722>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, elias.vds@gmail.com

On Monday 23 of December 2013 16:21:48 you wrote:
> On Mon, 2013-12-23 at 23:46 +0100, Michal Mal=FD wrote:
> > One case where uncombinable effects were mishandled was corrected. =
Rest of
> > the changes are just coding style fixes.
>=20
> trivia:
> > diff --git a/drivers/input/ff-memless-next.c
> > b/drivers/input/ff-memless-next.c
> []
>=20
> > +static __always_inline s32 mlnx_calculate_x_force(const s32 level,
> > +						  const u16 direction)
>=20
> __always_inline is almost never warranted.
> gcc generally does the right thing.
I did some reading about __always_inline vs. plain inline and I ran int=
o
some contradictory information about what is considered broken. Thanks
for letting me know...

Is there anything else that needs some reviewing?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
