From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Sat, 4 Jul 2009 07:54:27 +0200
Message-ID: <200907040754.28010.marek.vasut@gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com> <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com> <5d5443650906092110j1ed0914fn791039c4a4746bda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59385 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbZGDFyb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jul 2009 01:54:31 -0400
Received: by fxm18 with SMTP id 18so2514183fxm.37
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2009 22:54:33 -0700 (PDT)
In-Reply-To: <5d5443650906092110j1ed0914fn791039c4a4746bda@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dne St 10. =C4=8Dervna 2009 06:10:31 Trilok Soni napsal(a):
> Hi Dmitry,
>
> > Sounds good, patch updated again, with attachment.
> >
> > >From 76776dfc468dc35f0d8394a2331e1a91f390e642 Mon Sep 17 00:00:00 =
2001
> >
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Thu, 7 May 2009 15:49:32 +0800
> > Subject: [PATCH] input: add support for generic GPIO-based matrix k=
eypad
>
> Could you please review this patch and see if it can be acked as merg=
e
> window will open in couple of days? Thanks.

Hi, I have but one comment (see further), otherwise works well on Palm=20
Tungsten C (PXA255A0 CPU).

btw Eric, please add yourself to the credits, you did most of the work =
on it=20
anyway ;-) .
>
> > Original patch by Marek Vasut, modified by Eric in:
> >
> > 1. use delayed work to simplify the debouncing process

=2E..

> > diff --git a/include/linux/input/matrix_keypad.h
> > b/include/linux/input/matrix_keypad.h
> > new file mode 100644
> > index 0000000..8b661cb
> > --- /dev/null
> > +++ b/include/linux/input/matrix_keypad.h
> > @@ -0,0 +1,34 @@
> > +#ifndef _MATRIX_KEYPAD_H
> > +#define _MATRIX_KEYPAD_H
> > +
> > +#include <linux/input.h>
> > +
> > +#define MATRIX_MAX_ROWS                16
> > +#define MATRIX_MAX_COLS                16
> > +#define MATRIX_MAX_KEYS                (MATRIX_MAX_ROWS *
> > MATRIX_MAX_COLS) +
> > +struct matrix_keypad_platform_data {
> > +       /* scancode map for the matrix keys */
> > +       uint32_t        *key_map;
> > +       int             key_map_size;
> > +
> > +       unsigned        row_gpios[MATRIX_MAX_ROWS];
> > +       unsigned        col_gpios[MATRIX_MAX_COLS];

Why not doing the above like the following?
+       unsigned        *row_gpios;
+       unsigned        *col_gpios;

> > +       int             num_row_gpios;
> > +       int             num_col_gpios;
> > +
> > +       unsigned int    active_low;

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
