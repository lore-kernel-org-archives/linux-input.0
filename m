From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv7][ 1/4] Input: tsc2007: Add device tree support.
Date: Mon, 4 Nov 2013 13:01:59 +0100
Message-ID: <CACRpkdbuB6g+Qo0FCXaueKpAvT6vUKuNmoceWCGfG0KLa8+3Aw@mail.gmail.com>
References: <1382618536-25320-1-git-send-email-denis@eukrea.com>
	<20131024151736.GE9044@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:32904 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab3KDMB7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Nov 2013 07:01:59 -0500
Received: by mail-oa0-f42.google.com with SMTP id k14so7070256oag.15
        for <linux-input@vger.kernel.org>; Mon, 04 Nov 2013 04:01:59 -0800 (PST)
In-Reply-To: <20131024151736.GE9044@ulmo.nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Denis Carikli <denis@eukrea.com>, Rob Herring <rob.herring@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>

On Thu, Oct 24, 2013 at 5:17 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Thu, Oct 24, 2013 at 02:42:13PM +0200, Denis Carikli wrote:

>> +Optional properties:
>> +- gpios: the interrupt gpio the chip is connected to (trough the penirq pin)
>> +  (see GPIO binding[2] for more details).
>> +- interrupt-parent: the phandle for the gpio controller
>> +  (see interrupt binding[1]).
>> +- interrupts: (gpio) interrupt to which the chip is connected
>> +  (see interrupt binding[1]).
>> +- pinctrl-0: Should specify pin control groups used for the gpio
>> +  (see pinctrl bindings[0]).
>> +- pinctrl-names: Should contain only one value - "default"
>> +  (see pinctrl bindings[0]).
>
> Also I haven't seen a response as to why this can't be handled by the
> GPIO driver. Adding Linus Walleij, perhaps he knows a more definitive
> answer.
>
> Linus, the issue here is that the pinctrl properties for this chip are
> supposed to pinmux the pendown GPIO for this chip. I was under the
> impression that this should be handled by the GPIO controller itself, so
> that when gpio_request() was called on a pin it would be the GPIO
> controller driver's responsibility to pinmux it appropriately.

If this is the only thing it does (just mux in the GPIO and not setting
any pulls or other pin config properties) then it can fall through from
the GPIO controller's request function to pinctrl_request_gpio()
and then pinctrl_free_gpio(), pinctrl_gpio_direction_input()
and pinctrl_gpio_direction_output() respectively so that pin control
provides a muxing back end to the GPIO driver.

Actually these functions are up to the driver to implement, but
the core will call ->gpio_request_enable() on the pinctrl driver,
and if all GPIOs are set up the same way (i.e. the same bits
are always poked into the hardware) then this can be done
in that routine.

If more fine-grained control is needed, this approach providing
a full pin control handle and state settings connected to the
struct device * can and should be used instead.

Yours,
Linus Walleij
