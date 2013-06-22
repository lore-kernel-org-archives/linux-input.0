From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 01/12] input: matrix-keypad: update devicetree binding
 doc
Date: Sat, 22 Jun 2013 11:23:19 +0200
Message-ID: <20130622092319.GE24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-2-git-send-email-gsi@denx.de>
 <51C4C63B.3030300@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50158 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab3FVJXf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Jun 2013 05:23:35 -0400
Content-Disposition: inline
In-Reply-To: <51C4C63B.3030300@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

Let me first thank you for reviewing the set and for providing so
much feedback!

Then let me give a little background:  The first part of the
series with the doc update doesn't introduce anything new into
the driver, it just makes the document catch up with what the
driver already does.

And the later steps of extending the driver and its getting
configured by device tree properties was heavily driven by the
desire to keep up strict backwards compatibility.  Since breaking
a means of input and taking away a UNIX user's keyboard isn't
good for your health. :)  While I can and do test the setup which
the extension is targetting at, I cannot test the other setups
due to lack of hardware.

So when in doubt, I went with small and unintrusive steps and
lots of remarks such that the default behaviour is strictly
identical to before the change yet the desired new behaviour
becomes available upon request, and all of it is documented.

On Fri, Jun 21, 2013 at 15:31 -0600, Stephen Warren wrote:
> 
> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> > update the device tree binding documentation for the GPIO matrix keypad
> > driver: mention the driver's selecting all columns at once, reword the
> > delay descriptions, add the missing active low GPIO pin level property
> 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> 
> Presumably the changes to this file simply seek to precisely document
> the HW that this binding supports, and do not intend to change the
> semantics of the binding at all. If that's the case, then they seem fine
> to me.
> 
> Have you checked that all users of this binding do assume that the
> column GPIOs are output, and rows inputs, rather than the other way
> around for example? I suppose if the Linux driver is already implemented
> to assume that, then nobody can be successfully using this binding for
> HW where that isn't the case, so this change is fine.

I understand your concerns very well, since they crossed my mind
too when I wrote that update.

One way of keeping the driver's details away from the device tree
doc might be to create another file under Documentation/input/,
discussing all of the driver's operation and the assumed or
supported hardware setups there, and reducing the device tree
binding doc to just "mention the fact" that something is
adjustable and which property to use.

This would in addition reduce duplication with other approaches
of configuring the driver (there's static platform data as well).


Regarding the layering:  I'm aware of the one 'GPIO matrix
keypad' driver implemented in
drivers/input/keyboard/matrix_keypad.c, which uses a pdata
structure which can get filled in by means of static platform
data provided with code or by parsing the device tree (the
preferred method for future extensions).

Other drivers may implement their own logic to scan matrices and
detect changes, and share the pdata structure since they have to
track similar conditions as well.  That's the only reason why I
had to touch other files than just keypad and keymap.  But none
of them are device tree aware AFAIK.

So yes, from what I can see, the GPIO matrix keypad driver is the
only instance which probes the device tree and implements what
the binding describes.  Which is why I updated the device tree
binding's doc to provide motivation why something might need
adjustment and what the consequences are of specifying a
parameter.

But this only applies if the binding is seen in concert with the
Linux driver.  When the binding gets used elsewhere in the
kernel, or when code outside the kernel implements a binding,
then the individual driver's details should be kept out of the
binding doc.

Unless all drivers implement similar logic in just individual
ways, because they all need to drive a keypad matrix and thus
will face similar problems.  Oh well, let's see how others feel
or think about it ...


Another aspect to keep in mind here is that the current
implementation already was layered into "the keypad" which drives
the pins and detects presses and may get implemented in several
drivers, and "the keymap" which translates key positions to key
codes they generate and gets shared among many keypad drivers.


I'm not certain about whether the corgi, spitz, palm, tnetv107x
and qi_lb60 implementations just share the pdata layout and
implement their own logic, or just fillin the pdata from
constants provided with the code yet end up creating the same
GPIO matrix keypad driver.

If they brought their own logic, I could not see how they
reference the individual settings, and when they don't inspect
new settings then they end up with strictly the former behaviour.

If they create the same matrix driver that I extended, and just
provide the settings by other means, then they can optionally
make use of the new features yet see strictly identical behaviour
if they don't adjust what later got introduced.


> This change assumes it's OK to activate all columns at once, and
> presumably that drivers can request the GPIOs as IRQs. This need not be
> true on all HW. Should an additional property be added to describe
> whether it's legal to activate all columns at once? For the IRQ case,
> presumably the driver can simply try to request an IRQ for each GPIO,
> and fall back to not doing so if that doesn't work.
> 
> > +Simple keypad matrix layouts just connect GPIO lines to mechanical
> > +switches, with no other active components involved.  Although due to the
> 
> I don't think that's always true. On some Tegra boards for example,
> multiple processes can "press" certain switches, so we actually have a
> wired-OR feed into a transistor which then connects a particular
> (column, row) combination. We do this e.g. for remote-control USB over
> the power button for example. I believe the effect is the same, but it
> does mean that statement above isn't quite true.

That's why I wrote about "simple ... layouts", but couldn't tell
exactly when it was appropriate to discuss the more advanced
setups as well, and in how much depth to do that in the device
tree binding.

So is there a better way of putting this?  Is the "simple" or the
"mechanical" the issue in the description?

> > +driver's operation of activating all columns at the same time for most
> 
> Saying "driver" in a DT binding is a slight red flag. The binding should
> really purely describe HW, rather than SW's use of it. Here, the use is
> probably generic enough not to be an issue, although it there's some way
> to reword it to avoid that word it might be good.

All of this (and the other feedback) suggests that I should have
another look into the separation of the specific drivers details
(under Documentation/input/ and strictly bound to the Linux
kernel driver implementation) and DT binding (merely discussing
how to specify parameters and not discussing how they affect the
driver's operation).

> > +- gpio-activelow:	row pins as well as column pins are active low
> 
> That one change is definitely wrong. Each entry in row-gpios and
> col-gpios should include GPIO flags (in a format defined by the binding
> for the DT node providing the GPIO). Those flags include an active-high
> vs. active-low bit. In Linux, you can use of_get_gpio_flags() to
> retrieve a standardized representation of the flags.

See my introduction above.  This isn't a "change", it's just
catching up in the documentation and adding what was omitted
before.

And I can see another issue here (maybe shadowed by the wording I
used, referring to "row pins"):  The fact that a pin may be
inverted (within the SoC), and the fact that an externally
connected component might require low active stimulus over
otherwise high active pins/connections, might need to get
reflected well.  Or am I too picky here?

Are there other cases to learn from, where non-inverted physical
pins get attached to components which require inverted logical
information?  Do we combine the overall polarity within the GPIO
pin's abstraction, or do logical drivers above GPIO handle the
inversion?


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
