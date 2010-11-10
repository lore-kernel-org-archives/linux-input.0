From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v1 PATCH 1/6] matrix_keypad: Increase the max limit of rows
 and columns
Date: Wed, 10 Nov 2010 15:30:36 -0800
Message-ID: <20101110233036.GB2121@core.coreip.homeip.net>
References: <1289393281-4459-1-git-send-email-tsoni@codeaurora.org>
 <1289393281-4459-2-git-send-email-tsoni@codeaurora.org>
 <AANLkTi=J2fGOC-RQsPB1SD4GcQ2Df2ZO_a=2mxneHbUa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52200 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab0KJXap (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Nov 2010 18:30:45 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=J2fGOC-RQsPB1SD4GcQ2Df2ZO_a=2mxneHbUa@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org

On Thu, Nov 11, 2010 at 02:33:45AM +0800, Eric Miao wrote:
> On Wed, Nov 10, 2010 at 8:47 PM, Trilok Soni <tsoni@codeaurora.org> w=
rote:
> > Some keyboard controller have support for more than
> > 16 columns and rows.
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Eric Miao <eric.y.miao@gmail.com>
> > Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
> > ---
> > =A0include/linux/input/matrix_keypad.h | =A0 =A08 ++++----
> > =A01 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/input/matrix_keypad.h b/include/linux/in=
put/matrix_keypad.h
> > index 80352ad..d80845e 100644
> > --- a/include/linux/input/matrix_keypad.h
> > +++ b/include/linux/input/matrix_keypad.h
> > @@ -4,11 +4,11 @@
> > =A0#include <linux/types.h>
> > =A0#include <linux/input.h>
> >
> > -#define MATRIX_MAX_ROWS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
> > -#define MATRIX_MAX_COLS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
> > +#define MATRIX_MAX_ROWS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A018
> > +#define MATRIX_MAX_COLS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A018
> >
> > -#define KEY(row, col, val) =A0 =A0 ((((row) & (MATRIX_MAX_ROWS - 1=
)) << 24) |\
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((=
(col) & (MATRIX_MAX_COLS - 1)) << 16) |\
> > +#define KEY(row, col, val) =A0 =A0 ((((row) % (MATRIX_MAX_ROWS)) <=
< 24) |\
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((=
(col) % (MATRIX_MAX_COLS)) << 16) |\
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (va=
l & 0xffff))
> >
>=20
> Or maybe we can solve this completely by introducing something like:
>=20
> struct matrix_keycode {
>         int row;
>         int col;
>         int value;

Though that triples the space needed to store initial keymaps.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
