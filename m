From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Thu, 12 Jan 2012 01:22:21 +0100
Message-ID: <20120112002221.GA7546@polaris.bitmath.org>
References: <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com>
 <20120110114212.GA2142@polaris.bitmath.org>
 <20120111073812.GB18668@core.coreip.homeip.net>
 <4F0D5521.5030808@canonical.com>
 <20120111100444.GA5573@polaris.bitmath.org>
 <4F0D5FCE.6080809@canonical.com>
 <20120111171848.GA21047@core.coreip.homeip.net>
 <4F0E00D0.4060201@canonical.com>
 <20120111215950.GE21047@core.coreip.homeip.net>
 <4F0E13C9.7090100@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:59432 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2ALAWY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 19:22:24 -0500
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id B4DF1D444
	for <linux-input@vger.kernel.org>; Thu, 12 Jan 2012 01:22:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F0E13C9.7090100@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

> Here's what I believe the meanings should be:
> 
> Touchpad: pointer, !direct
> Touchscreen: !pointer, direct
> Drawing tablet: pointer, direct
> Magic mouse-like devices: !pointer, !direct

Yes, this is what everyone is saying, except !pointer && !direct means
"default" or "figure it out some other way".

> However, there is a further problem in that we can't easily support
> multiple tools with different behavior on the same evdev device. What
> would you say a bamboo touch+pen is, which I believe is used as an
> indirect device for touch but a direct device for tools. Thus, in the
> thread I linked from back in September, Henrik and I agreed that direct
> should only apply when the tool is touch, and pointer should apply for
> all other tools. This would result in the following:

To try to move back to a sane track, try this, where the word "apply"
in the previous paragraph has been changed to "care" instead:

> Touchpad: !pointer, !direct

pointer && !direct, since pointer is "dont care".

> Touchscreen: !pointer, direct

Yes, !pointer && direct.

> Drawing tablet (no touch): pointer, !direct

pointer && direct, but the tool is not touch, so direct is "dont care".

> Pen+touch tablet: pointer, direct

Yes, pointer && direct

> Magic mouse-like devices: !pointer, !direct

Both pointer and direct are "dont care", and the device needs to be
detected some other way. If there ever will be a special driver for
magic-mouse-like devices, using both relative pointer and touch data,
it will make sense to add a special property for such devices.

Hopefully the above is showing clearly that what was "documented" in
the threads enclosing the protocol patches still holds, and that there
is no use to dwell on it further.

> The properties weren't documented when they were merged, and they
> obviously aren't clear. However, if either table above is correct, then
> we can't assume that !pointer && !direct means "unknown".

If all devices fell in the pointer or direct or both categories, we
could. If not all devices do, the problem is rather that some property
bits are missing (or excluded) from the description.

> There is a way to fix this in a backwards compatible way: add a new
> property bit called something like "PROPERTIES_AVAILABLE". If any bits
> are set, then it implies that the properties are available (which covers
> older kernels). If no bits are set, then the properties are unknown.
> What do you think?

It is rather the special properties of the magic mouse that are
missing. All types of devices do not _have_ to use properties; most
types can be figured out by other means.

Saying "prop == 0" is equivalent to "figure out some other way" makes
sense, but it is also sensible to say "(prop & some_subclass_of_bits)
== 0", since some properties are bound to describe totally different
things. This is what we did with "!direct && !pointer".

> > The same is applicable to other properties as well. If device is telling
> > you that it is a "buttonpad" you can trust it, but if it does not you
> > need to decide for yourself how to treat it.

Yes, and this will always be true. Old devices or systems that become
used in new ways cannot always adapt to a "if property not present
then dont use that way" policy.

> No, in kernels previous to 2.6.38 it's clearly unknown. My problem is
> that I believe there was no way to determine unknown properties. If
> unknown properties is equivalent to magic-mouse like devices, then we're
> going to treat a lot of devices wrong. Or, we have to use heuristics to
> determine what a device is, like no properties and MT and REL_{X,Y} ==
> magic-mouse like. Properties was supposed to resolve this once and for
> all, so we didn't need heuristics.

Properties were added to be able to distinguish usecases that could
not be distinguished at all before. It was never meant to replace
everything else.

> >> Henrik, can you comment on the documentation patches? You wrote the
> >> patch, so you hopefully know what's going on :).

I wasn't copied in on the conversation, but they seem fairly well
commented on already.

Henrik
