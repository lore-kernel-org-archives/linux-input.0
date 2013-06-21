From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v1 01/12] input: matrix-keypad: update devicetree binding
 doc
Date: Fri, 21 Jun 2013 15:31:39 -0600
Message-ID: <51C4C63B.3030300@wwwdotorg.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de> <1371838198-7327-2-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59041 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945979Ab3FUVbn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jun 2013 17:31:43 -0400
In-Reply-To: <1371838198-7327-2-git-send-email-gsi@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> update the device tree binding documentation for the GPIO matrix keypad
> driver: mention the driver's selecting all columns at once, reword the
> delay descriptions, add the missing active low GPIO pin level property

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

Presumably the changes to this file simply seek to precisely document
the HW that this binding supports, and do not intend to change the
semantics of the binding at all. If that's the case, then they seem fine
to me.

Have you checked that all users of this binding do assume that the
column GPIOs are output, and rows inputs, rather than the other way
around for example? I suppose if the Linux driver is already implemented
to assume that, then nobody can be successfully using this binding for
HW where that isn't the case, so this change is fine.

This change assumes it's OK to activate all columns at once, and
presumably that drivers can request the GPIOs as IRQs. This need not be
true on all HW. Should an additional property be added to describe
whether it's legal to activate all columns at once? For the IRQ case,
presumably the driver can simply try to request an IRQ for each GPIO,
and fall back to not doing so if that doesn't work.

> +Simple keypad matrix layouts just connect GPIO lines to mechanical
> +switches, with no other active components involved.  Although due to the

I don't think that's always true. On some Tegra boards for example,
multiple processes can "press" certain switches, so we actually have a
wired-OR feed into a transistor which then connects a particular
(column, row) combination. We do this e.g. for remote-control USB over
the power button for example. I believe the effect is the same, but it
does mean that statement above isn't quite true.

> +driver's operation of activating all columns at the same time for most

Saying "driver" in a DT binding is a slight red flag. The binding should
really purely describe HW, rather than SW's use of it. Here, the use is
probably generic enough not to be an issue, although it there's some way
to reword it to avoid that word it might be good.

> +- gpio-activelow:	row pins as well as column pins are active low

That one change is definitely wrong. Each entry in row-gpios and
col-gpios should include GPIO flags (in a format defined by the binding
for the DT node providing the GPIO). Those flags include an active-high
vs. active-low bit. In Linux, you can use of_get_gpio_flags() to
retrieve a standardized representation of the flags.
