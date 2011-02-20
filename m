From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] Input: serio: Compile error fix (altera_ps2.c)
Date: Sat, 19 Feb 2011 20:47:50 -0800
Message-ID: <20110219204750.88014cd8.randy.dunlap@oracle.com>
References: <1298145859-10892-1-git-send-email-dustan.bower@gmail.com>
	<20110219214549.GA4933@core.coreip.homeip.net>
	<AANLkTinaVspNwHZFMUnbp=8F+K-=PRw95a1es+zyeCA+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:44604 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab1BTEsx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Feb 2011 23:48:53 -0500
In-Reply-To: <AANLkTinaVspNwHZFMUnbp=8F+K-=PRw95a1es+zyeCA+@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dustan Bower <dustan.bower@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Chou <thomas@wytron.com.tw>

On Sat, 19 Feb 2011 20:04:49 -0700 Grant Likely wrote:

> On Sat, Feb 19, 2011 at 2:45 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sat, Feb 19, 2011 at 03:04:19PM -0500, Dustan Bower wrote:
> >> Fixed compile error, today's linux-next tree:
> >>
> >> =C2=A0 CC [M] =C2=A0drivers/input/serio/altera_ps2.o
> >> drivers/input/serio/altera_ps2.c:182:1: error: expected =E2=80=98,=
=E2=80=99 or =E2=80=98;=E2=80=99 before =E2=80=98extern=E2=80=99
> >> make[1]: *** [drivers/input/serio/altera_ps2.o] Error 1
> >> make: *** [_module_drivers/input/serio] Error 2
> >>
> >> Signed-off-by: Dustan Bower <dustan.bower@gmail.com>
> >
> > Thanks Dustan.
> >
> > Grant, maybe you could amend the original patch so that we do not
> > introduce bisection failure point?
>=20
> done, thanks.

Hi Grant,

Did you also fix drivers/spi/spi_oc_tiny.c and
drivers/spi/spi_altera.c ?  I hit those build errors when
CONFIG_OF=3Dy.  Could there be others?

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your cod=
e ***
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
