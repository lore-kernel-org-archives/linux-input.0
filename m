From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] input: cros_ec_keyb_clear_keyboard() depends on
 CONFIG_PM_SLEEP
Date: Tue, 18 Jun 2013 01:16:38 +0200
Message-ID: <20130617231638.GV7998@zurbaran>
References: <1368049529-8168-1-git-send-email-geert@linux-m68k.org>
 <CAPnjgZ3Akf0+LKBt4c5HQX5c8PhL+zuvvHWrDpVj0W++GiOanA@mail.gmail.com>
 <20130515064248.GB24297@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58661 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab3FQXQm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Jun 2013 19:16:42 -0400
Content-Disposition: inline
In-Reply-To: <20130515064248.GB24297@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lk <linux-kernel@vger.kernel.org>

Hi Dmitry,

On Tue, May 14, 2013 at 11:42:48PM -0700, Dmitry Torokhov wrote:
> On Wed, May 08, 2013 at 09:25:56PM -0600, Simon Glass wrote:
> > On Wed, May 8, 2013 at 3:45 PM, Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> > > If CONFIG_PM_SLEEP is not set:
> > >
> > > drivers/input/keyboard/cros_ec_keyb.c:211: warning: =E2=80=98cros=
_ec_keyb_clear_keyboard=E2=80=99 defined but not used
> > >
> > > Move the definition of cros_ec_keyb_clear_keyboard() inside the s=
ection
> > > protected by #ifdef CONFIG_PM_SLEEP to fix this.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >=20
> > Acked-by: Simon Glass <sjg@chromium.org>
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Could you please forward this to Linus as I do not have this driver i=
n
> my branch yet.
I guess you took that one now ? Or are you expecting me to merge it ?

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
