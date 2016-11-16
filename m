From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 -next] Input: gpio_keys: set input direction
 explicitly for gpio keys
Date: Wed, 16 Nov 2016 10:34:34 -0800
Message-ID: <20161116183434.GC335@dtor-ws>
References: <1479297298-26555-1-git-send-email-sudeep.holla@arm.com>
 <1479303734-16198-1-git-send-email-sudeep.holla@arm.com>
 <20161116173656.GA335@dtor-ws>
 <e96aa040-49d9-4e8e-d017-10712354984c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35460 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbcKPSei (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Nov 2016 13:34:38 -0500
Content-Disposition: inline
In-Reply-To: <e96aa040-49d9-4e8e-d017-10712354984c@arm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, Nov 16, 2016 at 05:42:15PM +0000, Sudeep Holla wrote:
> 
> 
> On 16/11/16 17:36, Dmitry Torokhov wrote:
> >On Wed, Nov 16, 2016 at 01:42:14PM +0000, Sudeep Holla wrote:
> >>Commit 700a38b27eef ("Input: gpio_keys - switch to using generic device
> >>properties") switched to use generic device properties for GPIO keys and
> >>commit 5feeca3c1e39 ("Input: gpio_keys - add support for GPIO descriptors")
> >>switched from legacy GPIO numbers to GPIO descriptors.
> >>
> >>Previously devm_gpio_request_one was explicitly passed GPIOF_DIR_IN flag
> >>to set the GPIO direction as input. However devm_get_gpiod_from_child
> >>doesn't have such provisions and hence fwnode_get_named_gpiod can't set
> >>it as input.
> >>
> >>This breaks few platforms with the following error:
> >>" gpiochip_lock_as_irq: tried to flag a GPIO set as output for IRQ
> >>  unable to lock HW IRQ <n> for IRQ
> >>  genirq: Failed to request resources for POWER (irq <x>) on irqchip
> >>  gpio_keys: Unable to claim irq <x>; error -22
> >>  gpio-keys: probe failed with error -22 "
> >>
> >>This patch fixes the issue by setting input direction explicitly for
> >>gpio input keys. It also remove the existing GPIOF_DIR_IN flag setting
> >>for the legacy gpios and merges into single gpiod_direction_input call.
> >>
> >>Fixes: 700a38b27eef ("Input: gpio_keys - switch to using generic device properties")
> >>Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>Cc: Linus Walleij <linus.walleij@linaro.org>
> >>Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >>Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>---
> >> drivers/input/keyboard/gpio_keys.c        | 5 ++++-
> >> drivers/input/keyboard/gpio_keys_polled.c | 5 ++++-
> >> 2 files changed, 8 insertions(+), 2 deletions(-)
> >>
> >>v1->v2:
> >>	- Fix the build(had sent a wrong version by accident)
> >>
> >>Hi Dmitry,
> >>
> >>The other option would be to pass the flag explicitly and add support to
> >>handle it in the path devm_get_gpiod_from_child would take.
> >
> >Hi Sudeep,
> >
> >No, I think explicitly configuring it for input is good (at least for
> >now), but we need error handling.
> >
> 
> Sure, a quick glance makes me think: all I need is to return the error
> as everything is handled by devm_* APIs. If so I will respin with that
> change, otherwise please let me know if I am missing anything here.

No, I think that is it.

Thanks.

-- 
Dmitry
