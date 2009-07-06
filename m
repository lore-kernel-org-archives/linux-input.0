From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Mon, 6 Jul 2009 12:58:54 +0200
Message-ID: <200907061258.54592.marek.vasut@gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <200907040754.28010.marek.vasut@gmail.com> <4A519362.9040805@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:54027 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968AbZGFK64 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2009 06:58:56 -0400
Received: by fxm18 with SMTP id 18so3968980fxm.37
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2009 03:58:59 -0700 (PDT)
In-Reply-To: <4A519362.9040805@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dne Po 6. =C4=8Dervence 2009 08:02:10 Eric Miao napsal(a):
> Marek Vasut wrote:
> > Dne St 10. =C4=8Dervna 2009 06:10:31 Trilok Soni napsal(a):
> >> Hi Dmitry,
> >>
> >>> Sounds good, patch updated again, with attachment.
> >>>
> >>> >From 76776dfc468dc35f0d8394a2331e1a91f390e642 Mon Sep 17 00:00:0=
0 2001
> >>>
> >>> From: Marek Vasut <marek.vasut@gmail.com>
> >>> Date: Thu, 7 May 2009 15:49:32 +0800
> >>> Subject: [PATCH] input: add support for generic GPIO-based matrix
> >>> keypad
> >>
> >> Could you please review this patch and see if it can be acked as m=
erge
> >> window will open in couple of days? Thanks.
> >
> > Hi, I have but one comment (see further), otherwise works well on P=
alm
> > Tungsten C (PXA255A0 CPU).
> >
> > btw Eric, please add yourself to the credits, you did most of the w=
ork on
> > it anyway ;-) .
> >
> >>> Original patch by Marek Vasut, modified by Eric in:
> >>>
> >>> 1. use delayed work to simplify the debouncing process
> >
> > ...
> >
> >>> diff --git a/include/linux/input/matrix_keypad.h
> >>> b/include/linux/input/matrix_keypad.h
> >>> new file mode 100644
> >>> index 0000000..8b661cb
> >>> --- /dev/null
> >>> +++ b/include/linux/input/matrix_keypad.h
> >>> @@ -0,0 +1,34 @@
> >>> +#ifndef _MATRIX_KEYPAD_H
> >>> +#define _MATRIX_KEYPAD_H
> >>> +
> >>> +#include <linux/input.h>
> >>> +
> >>> +#define MATRIX_MAX_ROWS                16
> >>> +#define MATRIX_MAX_COLS                16
> >>> +#define MATRIX_MAX_KEYS                (MATRIX_MAX_ROWS *
> >>> MATRIX_MAX_COLS) +
> >>> +struct matrix_keypad_platform_data {
> >>> +       /* scancode map for the matrix keys */
> >>> +       uint32_t        *key_map;
> >>> +       int             key_map_size;
> >>> +
> >>> +       unsigned        row_gpios[MATRIX_MAX_ROWS];
> >>> +       unsigned        col_gpios[MATRIX_MAX_COLS];
> >
> > Why not doing the above like the following?
> > +       unsigned        *row_gpios;
> > +       unsigned        *col_gpios;
>
> By having an array, one can specify the GPIOs inside the
> structure initialization instead of a dedicated array outside,
> which might look a little bit better.

But this way we will have the MATRIX_MAX_COLS MATRIX_MAX_ROWS used on l=
ess=20
places (and we can eventually get rid of it easier in the future if som=
eone=20
wants to). Well I don't really care about the way you do it, both are O=
K with=20
me ;-)
>
> >>> +       int             num_row_gpios;
> >>> +       int             num_col_gpios;
> >>> +
> >>> +       unsigned int    active_low;

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
