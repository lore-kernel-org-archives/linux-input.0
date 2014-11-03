From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: stmpe: add pull up/down register offsets for
 STMPE
Date: Mon, 3 Nov 2014 12:25:59 +0000
Message-ID: <20141103122559.GB4538@x1>
References: <1413636974-3244-1-git-send-email-linus.walleij@linaro.org>
 <20141020064605.GB25349@x1>
 <20141024214206.GG19933@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35736 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaKCM0H (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 07:26:07 -0500
Received: by mail-ie0-f174.google.com with SMTP id x19so4978748ier.5
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2014 04:26:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141024214206.GG19933@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, 24 Oct 2014, Dmitry Torokhov wrote:

> On Mon, Oct 20, 2014 at 07:46:05AM +0100, Lee Jones wrote:
> > On Sat, 18 Oct 2014, Linus Walleij wrote:
> >=20
> > > This adds the register offsets for pull up/down for the STMPE
> > > 1601, 1801 and 24xx expanders. This is used to bias GPIO lines
> > > and keypad lines.
> > >=20
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > > Hi Sam, Lee: I think you should just ACK this so Dmitry can take =
the
> > > patch series through the input tree, where the registers need to =
be
> > > used to enable the keypad on the STMPE2401.
> > > ---
> > >  drivers/mfd/stmpe.c       | 4 ++++
> > >  drivers/mfd/stmpe.h       | 3 +++
> > >  include/linux/mfd/stmpe.h | 2 ++
> > >  3 files changed, 9 insertions(+)
> >=20
> > Does this need to go in with the other patches in the set?
> >=20
> > I'm _guessing_ that, as you've sent them separately, they can be
> > applied separately?
> >=20
> > This needs to go in via MFD, but for my own reference:
> >=20
> > Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> The new register definitions are needed for patch #3.  If you insist =
on
> this going through MFD then please take the other 2 patches with my A=
ck
> through MFD tree as well I do not think we need the whole song and da=
nce
> trying to synchronize 2 trees.

Actually, I can't see the other patches as they weren't sent to me.

Please apply them all to your tree with my Ack.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
