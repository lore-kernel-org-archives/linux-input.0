From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [PATCH trivial] input: apanel: remove a redundant MODULE_ALIAS
Date: Mon, 29 Aug 2011 16:10:15 -0700
Message-ID: <20110829161015.323c20a3@nehalam.ftrdhcpuser.net>
References: <1314653189-31020-1-git-send-email-j.neuschaefer@gmx.net>
	<201108291507.14497.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52509 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755323Ab1H2XLU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 19:11:20 -0400
In-Reply-To: <201108291507.14497.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan =?ISO-8859-1?B?TmV1c2No5GZlcg==?= <j.neuschaefer@gmx.net>, Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 29 Aug 2011 15:07:14 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Monday, August 29, 2011 02:26:29 PM Jonathan Neusch=E4fer wrote:
> > Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> > ---
> >  drivers/input/misc/apanel.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apane=
l.c
> > index a8d2b8d..1dd1bd3 100644
> > --- a/drivers/input/misc/apanel.c
> > +++ b/drivers/input/misc/apanel.c
> > @@ -346,5 +346,4 @@ MODULE_DESCRIPTION(APANEL_NAME " driver");
> >  MODULE_LICENSE("GPL");
> >  MODULE_VERSION(APANEL_VERSION);
> >=20
> > -MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
> >  MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");
>                                         ^
>=20
> Not necessarily redundant, if you notice the register is different.
>=20

At one point I found machines with both values, that is why there
are two entries.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
