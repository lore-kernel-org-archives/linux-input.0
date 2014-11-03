From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: stmpe: add pull up/down register offsets for
 STMPE
Date: Mon, 3 Nov 2014 12:57:32 +0000
Message-ID: <20141103125732.GF4538@x1>
References: <1413636974-3244-1-git-send-email-linus.walleij@linaro.org>
 <20141020064605.GB25349@x1>
 <CACRpkdbsswGBy69+EGJTbTpxD7j2FnruyGdyUZRBVtt-JaScfg@mail.gmail.com>
 <58957675.Bh6LToE4gg@dtor-glaptop>
 <CACRpkdYNBZdB14fjj0LnQ8GchaGLTgfpvxhe4J9nc3XF80dFgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:61788 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaKCM5i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 07:57:38 -0500
Received: by mail-ig0-f171.google.com with SMTP id hl2so4488548igb.16
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2014 04:57:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACRpkdYNBZdB14fjj0LnQ8GchaGLTgfpvxhe4J9nc3XF80dFgQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

On Mon, 03 Nov 2014, Linus Walleij wrote:

> On Wed, Oct 29, 2014 at 8:31 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wednesday, October 29, 2014 10:55:14 AM Linus Walleij wrote:
> >> On Mon, Oct 20, 2014 at 8:46 AM, Lee Jones <lee.jones@linaro.org> =
wrote:
> >> > On Sat, 18 Oct 2014, Linus Walleij wrote:
> >> >> This adds the register offsets for pull up/down for the STMPE
> >> >> 1601, 1801 and 24xx expanders. This is used to bias GPIO lines
> >> >> and keypad lines.
> >> >>
> >> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >> >> ---
> >> >> Hi Sam, Lee: I think you should just ACK this so Dmitry can tak=
e the
> >> >> patch series through the input tree, where the registers need t=
o be
> >> >> used to enable the keypad on the STMPE2401.
> >> >> ---
> >> >>
> >> >>  drivers/mfd/stmpe.c       | 4 ++++
> >> >>  drivers/mfd/stmpe.h       | 3 +++
> >> >>  include/linux/mfd/stmpe.h | 2 ++
> >> >>  3 files changed, 9 insertions(+)
> >> >
> >> > Does this need to go in with the other patches in the set?
> >> >
> >> > I'm _guessing_ that, as you've sent them separately, they can be
> >> > applied separately?
> >>
> >> No sorry if it was unclear, the series need to go in toghether.
> >> So this patch adds some infrastructure to the MFD device which
> >> is then utilized by the input driver in a later patch.
> >>
> >> > This needs to go in via MFD, but for my own reference:
> >> >
> >> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >>
> >> Dmitry can you merge this & the rest with Lee's ACK?
> >
> > I'd be delighted, but it _sounded_ like Lee wanted it to go though =
MFD?
>=20
> Lee, can Dmitry take these through input?

That was weird, I replied at the same as as you sent this.

Yes, it's fine.

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
