From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 5/5] input: pxa27x-keypad: add device tree support
Date: Thu, 20 Jun 2013 11:06:20 +0200
Message-ID: <201306201106.20764.arnd@arndb.de>
References: <1371527778-5236-1-git-send-email-chao.xie@marvell.com> <20130619111341.GH2426@book.gsilab.sittig.org> <CADApbehrJ=Jy_Z57serKuDm+-6_oy94QbrJUxL17HCKokDov8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59117 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757310Ab3FTJGd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jun 2013 05:06:33 -0400
In-Reply-To: <CADApbehrJ=Jy_Z57serKuDm+-6_oy94QbrJUxL17HCKokDov8A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <xiechao.mail@gmail.com>
Cc: Marek Vasut <marex@denx.de>, stefan@openezx.org, Eric Miao <eric.y.miao@gmail.com>, slapin@ossfans.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <chao.xie@marvell.com>, laforge@openezx.org, linux-input@vger.kernel.org, sleep_walker@suse.cz, Robert Jarzmik <robert.jarzmik@free.fr>, drwyrm@gmail.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thursday 20 June 2013, Chao Xie wrote:
> On Wed, Jun 19, 2013 at 7:13 PM, Gerhard Sittig <gsi@denx.de> wrote:
> > On Wed, Jun 19, 2013 at 16:38 +0800, Chao Xie wrote:
> >>
> >> On Wed, Jun 19, 2013 at 4:22 PM, Marek Vasut <marex@denx.de> wrote:
> >> >
> >> >> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> >> >> [ ... ]
> >> >> +++ b/Documentation/devicetree/bindings/input/pxa27x-keypad.txt
> >> >> @@ -0,0 +1,60 @@
> >> >> +* Marvell PXA Keypad controller
> >> >> +
> >> >> +Required Properties
> >> >> +- compatible : should be "marvell,pxa27x-keypad"
> >> >> +- reg : Address and length of the register set for the device
> >> >> +- interrupts : The interrupt for the keypad controller
> >> >> +- marvell,debounce-interval : How long time the key will be
> >> >
> >> > Is there no generic prop name for this debounce interval?
> >> >
> >> I searched at drivers/input and Documents.
> >> Two drivers use "debounce-interval", gpio-keys.c and stmpe-keypad.c.
> >> They describe the meanings of "debounce-interval" at its own document file.
> >> Some other drivers uses "xxx,debounce-delay-ms" or "debounce-delay-ms"
> >> So it seems that there is no generic prop name for this debounce interval.
> >
> > Actually there is, but under a different (more user friendly)
> > name:  See the 'debounce-delay-ms' property in
> > Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> > which gets referenced in the matrix_keypad_parse_dt() routine in
> > the drivers/input/keyboard/matrix_keypad.c source file.  Ah, your
> > last sentence mentions that fact.
> >
> > But when you introduce DT support into an existing driver which
> > previously used platform data, then there is no problem with
> > backwards compatibility in .dts files.  So I suggest to go with
> > the "debounce-delay-ms" name since it better reflects to the .dts
> > author (hardware engineer) which unit the number is supposed to
> > be specified in.
> >
> So Arnd
> What do you think? I am fine with either one.

debounce-delay-ms

	Arnd
