From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] input/misc: PCF8574 I2C keypad
 input device driver
Date: Tue, 9 Mar 2010 14:30:39 -0800
Message-ID: <20100309223038.GB29517@core.coreip.homeip.net>
References: <20100309180906.GA19814@core.coreip.homeip.net>
 <1268168513-7431-1-git-send-email-vapier@gentoo.org>
 <20100309212127.GA29333@core.coreip.homeip.net>
 <8bd0f97a1003091327y5f5596eelb60b3c52694517b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:61344 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab0CIWat (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:30:49 -0500
Received: by fxm5 with SMTP id 5so1961817fxm.29
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 14:30:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a1003091327y5f5596eelb60b3c52694517b1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Tue, Mar 09, 2010 at 04:27:48PM -0500, Mike Frysinger wrote:
> On Tue, Mar 9, 2010 at 16:21, Dmitry Torokhov wrote:
> > On Tue, Mar 09, 2010 at 04:01:53PM -0500, Mike Frysinger wrote:
> >> From: Bryan Wu <cooloney@kernel.org>
> >>
> >> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> >> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> >> ---
> >> v2
> >> =A0 =A0 =A0 - process all feedback from Dmitry except for threaded=
 irqs; that'll have to be done later
> >
> > Could I ask why? As it stands the remove() is racy WRT to a work
> > running. But if you simply add cancel_work_sync() you'll risk leavi=
ng
> > unbalanced enable_irq()/disable_irq().
>=20
> ive never worked with threaded irq handlers before.  i'll have to rea=
d
> about them before i can do the work.  i'm not suggesting you take the
> driver now as is ... having it on a list in case someone else wants a
> mostly-ok driver.

It is very simple, take a look at drivers/input/touchscreen/mcs5000_ts.=
c
Just make sure you request threaded irq with IRQF_ONESHOT.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
