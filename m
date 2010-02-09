From: Marc Zyngier <maz@misterjones.org>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Tue, 9 Feb 2010 07:39:03 +0000
Message-ID: <20100209073903.4d8a00e4@taxman.wild-wind.fr.eu.org>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
	<f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
	<bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
	<bf0eec9a1002080308v77c9c026j302767e41cd660f2@mail.gmail.com>
	<20100208113306.GN9007@buzzloop.caiaq.de>
	<6a1db73cb6c89001764393acd766f2ba.squirrel@www.loen.fr>
	<f17812d71002081705q7723c388re8582d1186802340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:41619 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751297Ab0BIHjO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2010 02:39:14 -0500
In-Reply-To: <f17812d71002081705q7723c388re8582d1186802340@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, Jebediah Huang <jebediah.huang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Tue, 9 Feb 2010 09:05:22 +0800
Eric Miao <eric.y.miao@gmail.com> wrote:

> On Mon, Feb 8, 2010 at 8:32 PM, Marc Zyngier <maz@misterjones.org> wrote:
> >> I just saw that there is indeed no support for irq line handling in this
> >> driver. In order to use these lines as input for something like the
> >> gpio_keys driver, support for that should be added. I never used this
> >> driver and can't say whether it is under active development.
> >
> > It should be rather easy to introduce something similar to what I did for
> > the pca953x driver (http://patchwork.kernel.org/patch/77418/)
> >
> > MAX732x seems a lot saner than PCA953x, as it has at least a hardware
> > interrupt mask...
> 
> Well, I'd say max732x is a chip of heavy simplification, input/output direction
> of each pin is normally hardcoded, depending on the chip model used, there
> seems no such interrupt mask registers for SW use really.

I'm currently staring at the max7319 datasheet, and it really looks
like there is such a register:

"All input ports are continuously monitored for state changes
(transition detection). Transitions are latched, allowing detection of
transient changes. Any combination of inputs can be selected using the
interrupt mask to assert the INT output. When the MAX7319 is
subsequently accessed through the serial interface, any pending
interrupt is cleared."

So it would seems (although I agree with you that max732x as a GPIO
expander is grossly simplified) that the feature is at least advertised.

	M.
-- 
I'm the slime oozin' out from your TV set...
