From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 01/12] input: matrix-keypad: update devicetree binding
 doc
Date: Mon, 24 Jun 2013 16:00:26 -0600
Message-ID: <51C8C17A.1050700@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-2-git-send-email-gsi@denx.de> <51C4C63B.3030300@wwwdotorg.org> <20130622092319.GE24305@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59426 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab3FXWAa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jun 2013 18:00:30 -0400
In-Reply-To: <20130622092319.GE24305@book.gsilab.sittig.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/22/2013 03:23 AM, Gerhard Sittig wrote:
...
> On Fri, Jun 21, 2013 at 15:31 -0600, Stephen Warren wrote:
>> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
>>> update the device tree binding documentation for the GPIO matrix keypad
>>> driver: mention the driver's selecting all columns at once, reword the
>>> delay descriptions, add the missing active low GPIO pin level property
>>
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
...
>>> +Simple keypad matrix layouts just connect GPIO lines to mechanical
>>> +switches, with no other active components involved.  Although due to the
>>
>> I don't think that's always true. On some Tegra boards for example,
>> multiple processes can "press" certain switches, so we actually have a
>> wired-OR feed into a transistor which then connects a particular
>> (column, row) combination. We do this e.g. for remote-control USB over
>> the power button for example. I believe the effect is the same, but it
>> does mean that statement above isn't quite true.
> 
> That's why I wrote about "simple ... layouts", but couldn't tell
> exactly when it was appropriate to discuss the more advanced
> setups as well, and in how much depth to do that in the device
> tree binding.
> 
> So is there a better way of putting this?  Is the "simple" or the
> "mechanical" the issue in the description?

I think both "simple" and "mechanical" should be removed. My reasoning:

At the level of connection between rows/columns, aren't all matrix
keypads set up such that something connects a row to a column to signify
a keypress, not just "simple layouts".

Similarly, "mechanical" should be removed since it's not always true,
and even if it were, it would be irrelevant to anything outside the
keyboard, perhaps aside from the need to debounce.

In fact, thinking about this more, I think all four paragraphs of text
that this patch adds would be better in Documentation/input/, as you
mentioned elsewhere. When introducing any extra properties, you could
mention their potential use by a driver, as explanation for why they're
useful, but there's probably no need to describe the complete operation
of the driver in the DT binding.

>>> +- gpio-activelow:	row pins as well as column pins are active low
>>
>> That one change is definitely wrong. Each entry in row-gpios and
>> col-gpios should include GPIO flags (in a format defined by the binding
>> for the DT node providing the GPIO). Those flags include an active-high
>> vs. active-low bit. In Linux, you can use of_get_gpio_flags() to
>> retrieve a standardized representation of the flags.
> 
> See my introduction above.  This isn't a "change", it's just
> catching up in the documentation and adding what was omitted
> before.

Oh dear, that's quite unfortunate. I see that even though that property
wasn't documented in the binding doc, arch/powerpc/boot/dts/ac14xx.dts
has still already used it, so we probably can't fix it. I suppose we
must simply document it, and ignore the shortcomings of that binding:-(

> And I can see another issue here (maybe shadowed by the wording I
> used, referring to "row pins"):  The fact that a pin may be
> inverted (within the SoC), and the fact that an externally
> connected component might require low active stimulus over
> otherwise high active pins/connections, might need to get
> reflected well.  Or am I too picky here?
> 
> Are there other cases to learn from, where non-inverted physical
> pins get attached to components which require inverted logical
> information?  Do we combine the overall polarity within the GPIO
> pin's abstraction, or do logical drivers above GPIO handle the
> inversion?

In general, I would expect the binding to represent the overall
effective polarity of the signal that must be programmed into the
relevant GPIO controller. SW doesn't really care how/why the signal is
inverted, simply that it needs to (or doesn't) invert the signal when it
programs the GPIO controller.
