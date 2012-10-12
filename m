From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Fri, 12 Oct 2012 23:40:54 +0200
Message-ID: <CACRpkdZeDb4=nfRarENpwJh5vepuQgDRN==kZK637VsYKj8bpg@mail.gmail.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com>
	<CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
	<2124185.0mAfDLSa7H@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35566 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab2JLVk4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 17:40:56 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so3986354vcb.19
        for <linux-input@vger.kernel.org>; Fri, 12 Oct 2012 14:40:55 -0700 (PDT)
In-Reply-To: <2124185.0mAfDLSa7H@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-input@vger.kernel.org, Jonas ABERG <jonas.aberg@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>

On Fri, Oct 12, 2012 at 11:35 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Friday, October 12, 2012 11:26:00 PM Linus Walleij wrote:
>> On Fri, Oct 12, 2012 at 5:55 PM, Daniel Mack <zonque@gmail.com> wrote:
>> > This allows DT driven boards to allocate and configure the pinmux once
>> > the driver is probed.
>> >
>> > Signed-off-by: Daniel Mack <zonque@gmail.com>
>> > Cc: Linus Walleij <linus.walleij@linaro.org>
>> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> (...)
>>
>> > +       /* request pin mux */

That is not good, pinctrl is not just about muxing.

>> > +       pinctrl = devm_pinctrl_get_select_default(dev);
>> > +       if (IS_ERR(pinctrl))
>> > +               dev_warn(dev, "pins are not configured from the
>> > driver\n");
>>
>> I think dev_warn() is rather nasty to throw in here, dev_info() is OK.
>>
>> However I suspect this driver could actually handle default, idle and sleep
>> states, especially after the runtime PM patches discussed elsewhere,
>> but that can be patched later.
>
> I take this as Acked-by then?

Not yet. I want to clarify the use. In the Documentation/pinctrl.txt
document we say:

-----------8<----------------------8<------------------8<-------------------
Drivers needing both pin control and GPIOs
==========================================

Again, it is discouraged to let drivers lookup and select pin control states
themselves, but again sometimes this is unavoidable.

So say that your driver is fetching its resources like this:

#include <linux/pinctrl/consumer.h>
#include <linux/gpio.h>

struct pinctrl *pinctrl;
int gpio;

pinctrl = devm_pinctrl_get_select_default(&dev);
gpio = devm_gpio_request(&dev, 14, "foo");

Here we first request a certain pin state and then request GPIO 14 to be
used. If you're using the subsystems orthogonally like this, you should
nominally always get your pinctrl handle and select the desired pinctrl
state BEFORE requesting the GPIO. This is a semantic convention to avoid
situations that can be electrically unpleasant, you will certainly want to
mux in and bias pins in a certain way before the GPIO subsystems starts to
deal with them.

The above can be hidden: using pinctrl hogs, the pin control driver may be
setting up the config and muxing for the pins when it is probing,
nevertheless orthogonal to the GPIO subsystem.
But there are also situations where it makes sense for the GPIO subsystem
to communicate directly with with the pinctrl subsystem, using the latter
as a back-end. This is when the GPIO driver may call out to the functions
described in the section "Pin control interaction with the GPIO subsystem"
above. This only involves per-pin multiplexing, and will be completely
hidden behind the gpio_*() function namespace. In this case, the driver
need not interact with the pin control subsystem at all.

If a pin control driver and a GPIO driver is dealing with the same pins
and the use cases involve multiplexing, you MUST implement the pin controller
as a back-end for the GPIO driver like this, unless your hardware design
is such that the GPIO controller can override the pin controller's
multiplexing state through hardware without the need to interact with the
pin control system.
-----------8<----------------------8<------------------8<-------------------

Yours,
Linus Walleij
