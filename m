From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Some issues with imon input driver
Date: Wed, 7 Jul 2010 20:21:44 +0300
Message-ID: <201007072021.44619.anssi.hannula@iki.fi>
References: <201007070536.45900.anssi.hannula@iki.fi> <20100707135259.GA29996@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sirokuusama.dnainternet.net ([83.102.40.133]:52440 "EHLO
	sirokuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755400Ab0GGRVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jul 2010 13:21:51 -0400
In-Reply-To: <20100707135259.GA29996@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

Jarod Wilson kirjoitti keskiviikko, 7. hein=E4kuuta 2010 16:52:59:
> On Wed, Jul 07, 2010 at 05:36:45AM +0300, Anssi Hannula wrote:
> > Hi!
> >=20
> > I tried to set up my imon remote, but run into the issue of buttons
> > getting easily stuck. And while looking at the code, I noticed some=
 more
> > issues :)
>=20
> I'm not entirely surprised, I knew there were a few quirks left I'd n=
ot
> yet fully sorted out. Generally, it works quite well, but I didn't ab=
use
> the receiver quite as thoroughly as you. ;)
>=20
> Can I talk you into filing a bug to track this? I can probably work u=
p
> fixes for a number of these sooner or later, if you don't beat me to =
them,
> but it'd be easy for one or more of the specific problems to slip thr=
ough
> the cracks if not logged somewhere. My From: address here matches my
> b.k.o. account, if you want to assign said bug to me.

Done, though I didn't have the permissions to assign it to you:
https://bugzilla.kernel.org/show_bug.cgi?id=3D16351

> Ah, and because we're actually handing remote controls via
> drivers/media/IR/, you should cc linux-media as well (if not instead =
of
> linux-input) on anything regarding this driver.

OK.

BTW, I wonder if we should also disable kernel autorepeat and use the r=
emote=20
control's own repeat signals instead?
Then extra repeat codes would not not emitted if the release signal is =
missed.

--=20
Anssi Hannula
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
