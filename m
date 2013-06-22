From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 07/12] input: keypad-matrix: introduce polling support
Date: Sat, 22 Jun 2013 11:50:22 +0200
Message-ID: <20130622095022.GG24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-8-git-send-email-gsi@denx.de>
 <51C4C7C3.1070905@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:46642 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab3FVJud (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Jun 2013 05:50:33 -0400
Content-Disposition: inline
In-Reply-To: <51C4C7C3.1070905@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Fri, Jun 21, 2013 at 15:38 -0600, Stephen Warren wrote:
> 
> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> > detecting changes in the key press status may not work reliably in
> > interrupt driven mode (see the documentation part of the change for
> > details)
> > 
> > add support to poll the matrix in software for reliable operation in the
> > presence of multi key press events, leave a comment on how sleep and
> > wakeup could be made to work appropriately in the polling case
> 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> 
> > +The approach to enable all columns at the same time and to determine
> > +that a key press status change has occured from row pin level changes
> > +only works reliably for single key presses.  Multi key presses where the
> > +keys share their position on a row line may get deferred or even could
> > +go unnoticed, pressing and holding one key will shadow events which
> > +another key on the same row would have generated.  When reliable
> > +detection of key press events is required even in the presence of multi
> > +key presses, interrupt mode isn't sufficient any longer, and polling
> > +needs to be used.  The polling approach to detecting changes in the key
> > +press status will periodically activate a single column line and check
> > +the signals of the row lines.  Polling may also be applicable to setups
> > +where the hardware doesn't support the activation of several columns at
> > +the same time.
> 
> This feels a bit like encoding a driver implementation detail into the
> DT binding.
> 
> Instead, couldn't the driver simply:
> 
> * When no keys are pressed, perhaps after a certain delay/timeout while
> scanning, enable "interrupt mode".
> 
> * As soon as an interrupt is seen, switch back to "scanning mode".
> 
> * Once no keys are pressed again, go back to "interrupt mode".
> 
> That way, interrupt mode is only used while no key is pressed, and hence
> there's no possibility of shadowing.
> 
> This can all be done without any need for DT binding changes.

That's exactly what the GPIO matrix keypad driver did implement
and still does by default after it got extended.  There is
- the "active scan" step which determines the status of
  individual keys by querying each matrix line individually (in
  software) and
- the "idle" phase where no software is involved but instead a
  change is detected by changes in the GPIO pins' level while all
  columns are enabled (wired-OR if you want)

The patch set doesn't introduce that behaviour, but merely
describes it in more detail.  It doesn't even introduce the
interrupt discussion into the binding document in a strict sense,
but expands on it in the hope for improved usability of the
binding after the motivation became more obvious.


What this part of the series does is to introduce polling mode as
an alternative to the interrupt driven detection of changes, to
improve reliability of change detection in the presence of multi
key presses.


I suggest to have the "meta-discussions" on which documentation
belongs where and on where to put the GPIO polarity and on
whether backward compatibility needs to be kept or may be broken,
in a single spot, to not have several parallel discussions in
multiple subthreads.

Is the cover letter or the first patch the most appropriate
message to respond to with this though in mind?  Or don't you
mind if several replies for different parts of the patch set
discuss similar "background" aspects of the same series?


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
