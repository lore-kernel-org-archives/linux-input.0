From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 01/12] input: matrix-keypad: update devicetree binding
 doc
Date: Fri, 28 Jun 2013 10:24:22 +0200
Message-ID: <20130628082422.GV24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-2-git-send-email-gsi@denx.de>
 <51C4C63B.3030300@wwwdotorg.org>
 <20130622092319.GE24305@book.gsilab.sittig.org>
 <51C8C17A.1050700@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:42717 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab3F1IY0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 04:24:26 -0400
Content-Disposition: inline
In-Reply-To: <51C8C17A.1050700@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Mon, Jun 24, 2013 at 16:00 -0600, Stephen Warren wrote:
> 
> On 06/22/2013 03:23 AM, Gerhard Sittig wrote:
> ...
> 
> [ device tree binding doc, discussing matrix hardware layouts ]
> 
> I think both "simple" and "mechanical" should be removed. My reasoning:
> 
> At the level of connection between rows/columns, aren't all matrix
> keypads set up such that something connects a row to a column to signify
> a keypress, not just "simple layouts".
> 
> Similarly, "mechanical" should be removed since it's not always true,
> and even if it were, it would be irrelevant to anything outside the
> keyboard, perhaps aside from the need to debounce.
> 
> In fact, thinking about this more, I think all four paragraphs of text
> that this patch adds would be better in Documentation/input/, as you
> mentioned elsewhere. When introducing any extra properties, you could
> mention their potential use by a driver, as explanation for why they're
> useful, but there's probably no need to describe the complete operation
> of the driver in the DT binding.

So the direction to go is
- move the Linux driver specific discussion to
  Documentation/input/ including potential hardware setups and
  the background on the driver's theory of operation
- just concentrate on "adjustables" in the binding document,
  merely listing the set and their units, while the motivation or
  background either "is obvious" or can get looked up in the
  driver's discussion

Reducing the set of options is orthogonal to that.  Breaking
backwards compatibility by changing the default behaviour after
introducing more generic approaches to the specific issue is an
option that remains for future changes.

> >>> +- gpio-activelow:	row pins as well as column pins are active low
> >>
> >> That one change is definitely wrong. Each entry in row-gpios and
> >> col-gpios should include GPIO flags (in a format defined by the binding
> >> for the DT node providing the GPIO). Those flags include an active-high
> >> vs. active-low bit. In Linux, you can use of_get_gpio_flags() to
> >> retrieve a standardized representation of the flags.
> > 
> > See my introduction above.  This isn't a "change", it's just
> > catching up in the documentation and adding what was omitted
> > before.
> 
> Oh dear, that's quite unfortunate. I see that even though that property
> wasn't documented in the binding doc, arch/powerpc/boot/dts/ac14xx.dts
> has still already used it, so we probably can't fix it. I suppose we
> must simply document it, and ignore the shortcomings of that binding:-(

Don't worry about the 'AC14xx' board too long, its using the
keypad matrix driver is new in mainline, and still can get
adjusted without too much problems before more wide spread use.
"Getting it right" is what I'm currently heading for, while
nothing is set in stone yet.

The actual issue I see is that
- the device tree binding specs get mapped to platform data
- the platform data is shared among the (device tree capable but
  as well used without a device tree) keypad matrix driver _and_
  the other platform data providing machines (mostly ARM based)

So the drivers' logic referenced the 'active low' flag which the
platform data already carried, which the device tree parse
routines happen to setup.  So when you see a reference to the
property in a .dts, it's just "the tip of the ice berg" since
there are other ways to communicate or setup that property.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
