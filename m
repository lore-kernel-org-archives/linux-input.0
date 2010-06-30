From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: usbtouchscreen - runtime PM patches testing [Was: [PATCH 1/2]
 Input: usbtouchscreen - add support for ET&T TC4UM touchscreen controller]
Date: Wed, 30 Jun 2010 00:48:29 -0700
Message-ID: <20100630074828.GA4154@core.coreip.homeip.net>
References: <20100603075720.GQ26052@ibawizard.net>
 <1276242054-11127-1-git-send-email-ynezz@true.cz>
 <20100628091959.GH15039@ibawizard.net>
 <20100628164603.GC11670@core.coreip.homeip.net>
 <20100630071635.GJ15039@ibawizard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:63952 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0F3Hsf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 03:48:35 -0400
Received: by pxi8 with SMTP id 8so245367pxi.19
        for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 00:48:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100630071635.GJ15039@ibawizard.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: linux-input@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

On Wed, Jun 30, 2010 at 09:16:35AM +0200, Petr =C5=A0tetiar wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> [2010-06-28 09:46:03]:
>=20
> > Applied to 'next' branch (for .36). But I was wondering - could you
> > please try the runtime PM patches to usebtouchscreen posted by Oliv=
er
> > Neukum on the linux-input list? I'd really like to apply them but
> > I'd like to have them tested first.
>=20
> Thank you for applying my patches. Well, I've now only broken touchsc=
reen,
> which have only 4-wires or so working, but I think, that it should be=
 enough
> for PM testing. What kind of testing do you need, just few suspend & =
resume
> cycles? CC-ing Oliver also.
>=20

Not breaking stuff by default is good enough for me but Oliver should b=
e
able to tell what exactly tests he'd like to see.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
