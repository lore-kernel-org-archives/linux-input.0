From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 01/12] input: matrix-keypad: update devicetree binding
 doc
Date: Sun, 30 Jun 2013 13:04:38 +0200
Message-ID: <20130630110438.GZ24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-2-git-send-email-gsi@denx.de>
 <51C4C63B.3030300@wwwdotorg.org>
 <20130622092319.GE24305@book.gsilab.sittig.org>
 <51C8C17A.1050700@wwwdotorg.org>
 <20130628082422.GV24305@book.gsilab.sittig.org>
 <51CDA2B2.7090304@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40476 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3F3LEt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jun 2013 07:04:49 -0400
Content-Disposition: inline
In-Reply-To: <51CDA2B2.7090304@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Fri, Jun 28, 2013 at 08:50 -0600, Stephen Warren wrote:
> 
> [ ... just one reference in arch/powerpc/boot/dts/ac14xx.dts ... ]
> > 
> > Don't worry about the 'AC14xx' board too long, its using the
> > keypad matrix driver is new in mainline, and still can get
> > adjusted without too much problems before more wide spread use.
> > "Getting it right" is what I'm currently heading for, while
> > nothing is set in stone yet.
> 
> Given the "ABI-ness" of DT, I'm not convinced we don't have to worry
> about the AC14xx. I think we'll have to continue supporting that
> property, even if there's a newer/better/more-flexible way of
> representing the information too.

Don't get me wrong, I wasn't putting this lightly.  From first
hand experience I can tell that none of those boards in the field
use current or even recent mainline kernels.  All of them are
running an older version which predates the introduction of
'AC14xx' support in kernel.org sources.  Extending official
support and "doing it the right way" is what I'm currently
working on, before those boards may switch to running mainline
kernels and compatibility with the first version that was used
will become an issue.  So to put it into other words:

_If_ the 'AC14xx' board is the _only_ entity which references the
property, then there's no problem at all.  Incompatible changes
for _this_one_board_ are acceptable since at the moment the
current implementation is not used in the field.

Of course I agree that breaking any other board isn't acceptable,
which is why I followed the approach of strictly keeping
backwards compatible behaviour even in those spots where a
different approach or a different default would have looked more
desireable.

Which is why I'm still reluctant to more intrusively change the
general working of the keypad matrix driver in contrast to
introducing strictly local changes which only optionally add
additional features which explicitly must get enabled before
changed behaviour will occur.  So I need some more time to think
of which parts to change in which ways and how to make sure that
nothings breaks ...


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
