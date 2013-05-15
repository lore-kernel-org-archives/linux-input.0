From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: cros_ec_keyb_clear_keyboard() depends on
 CONFIG_PM_SLEEP
Date: Tue, 14 May 2013 23:42:48 -0700
Message-ID: <20130515064248.GB24297@core.coreip.homeip.net>
References: <1368049529-8168-1-git-send-email-geert@linux-m68k.org>
 <CAPnjgZ3Akf0+LKBt4c5HQX5c8PhL+zuvvHWrDpVj0W++GiOanA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:63004 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab3EOGmv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 May 2013 02:42:51 -0400
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3Akf0+LKBt4c5HQX5c8PhL+zuvvHWrDpVj0W++GiOanA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lk <linux-kernel@vger.kernel.org>

On Wed, May 08, 2013 at 09:25:56PM -0600, Simon Glass wrote:
> On Wed, May 8, 2013 at 3:45 PM, Geert Uytterhoeven <geert@linux-m68k.=
org> wrote:
> > If CONFIG_PM_SLEEP is not set:
> >
> > drivers/input/keyboard/cros_ec_keyb.c:211: warning: =E2=80=98cros_e=
c_keyb_clear_keyboard=E2=80=99 defined but not used
> >
> > Move the definition of cros_ec_keyb_clear_keyboard() inside the sec=
tion
> > protected by #ifdef CONFIG_PM_SLEEP to fix this.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Acked-by: Simon Glass <sjg@chromium.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Could you please forward this to Linus as I do not have this driver in
my branch yet.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
