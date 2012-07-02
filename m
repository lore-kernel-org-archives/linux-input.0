From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] input: Request threaded-only IRQs with IRQF_ONESHOT
Date: Mon, 2 Jul 2012 12:21:29 -0700
Message-ID: <CA+55aFwPSSJAg_EJEgR+Q1OXY1Euc5BsQ05ygRiB976MgFJE9w@mail.gmail.com>
References: <1341229460-23732-1-git-send-email-lars@metafoo.de>
 <20120702190402.GA16271@core.coreip.homeip.net> <alpine.LFD.2.02.1207022111190.2793@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55654 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab2GBTVv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 15:21:51 -0400
Received: by werb14 with SMTP id b14so2747871wer.19
        for <linux-input@vger.kernel.org>; Mon, 02 Jul 2012 12:21:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1207022111190.2793@ionos>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Fabien Marteau <fabien.marteau@armadeus.com>, HeungJun Kim <riverful.kim@samsung.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, Bo Shen <voice.shen@atmel.com>, Sriramakrishnan <srk@ti.com>, Kyle Manna <kyle.manna@fuel7.com>, Cyril Chemparathy <cyril@ti.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Alan Cox <alan@linux.intel.com>, Jianchun Bian <jcbian@pixcir.com.cn>, Aaro Koskinen <aaro.koskinen@nokia.com>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Mon, Jul 2, 2012 at 12:11 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 2 Jul 2012, Dmitry Torokhov wrote:
>>
>> This is not very helpful. Why, instead of bailing out, genirq case does
>> not add IRQF_ONESHOT itself to the flags? Then we would not need to
>> alter zillions of drivers.
>
> https://lkml.org/lkml/2012/6/12/151

In particular, just fix the broken drivers.

If you don't have an interrupt-time function, make it very *very*
explicit that your f*cking driver cannot work unless it's
IRQF_ONESHOT. Make it clear IN YOUR DRIVER, rather than depend on some
implicit "the irq layer will fix up your breakage for you".

We've had this "the irq layer will try to work around your bugs"
before. It's a bad idea. It's broken.

If we ever want to know which drivers use IRQF_ONESHOT, we should damn
well be able to just grep for it. Not "oh, any driver that uses a NULL
irq function implicitly also uses IRQF_ONESHOT". None of this
workaround crap. Just fix the drivers, don't make excuses, don't make
it some kind of "we just let things slide this once" crap.

Making the IRQF_ONESHOT explicit does two things:
 - it makes people who read the code *aware* of things
 - if/when you have irq conflicts and two drivers want to attach to
the same interrupt, at least you can see directly from the source what
flags they used (and again, not have to even *think* about it).

Somebody already posted patches that fixed up the drivers. There's
really no reason not to make it a hard rule that a driver has to use
the proper effing flags. And if a driver gives the wrong flags, we
should damn well tell the driver to go away.

                  Linus
