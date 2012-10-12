From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Fri, 12 Oct 2012 23:37:29 +0200
Message-ID: <CACRpkda==SXUtS1AExnjaQfnCYssGbfH=LrgqWhBiq85Ln02og@mail.gmail.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com>
	<CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
	<50788B53.6040309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63315 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab2JLVha (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 17:37:30 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3484016vbb.19
        for <linux-input@vger.kernel.org>; Fri, 12 Oct 2012 14:37:29 -0700 (PDT)
In-Reply-To: <50788B53.6040309@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonas ABERG <jonas.aberg@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Fri, Oct 12, 2012 at 11:27 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 12.10.2012 23:26, Linus Walleij wrote:
>> On Fri, Oct 12, 2012 at 5:55 PM, Daniel Mack <zonque@gmail.com> wrote:
>>
>>> This allows DT driven boards to allocate and configure the pinmux once
>>> the driver is probed.
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> (...)
>>> +       /* request pin mux */
>>> +       pinctrl = devm_pinctrl_get_select_default(dev);
>>> +       if (IS_ERR(pinctrl))
>>> +               dev_warn(dev, "pins are not configured from the driver\n");
>>
>> I think dev_warn() is rather nasty to throw in here, dev_info() is OK.
>
> Well, dev_warn is used everywhere else for this particular warning, but
> I can change that of course.

Yeah true ... just that I think that in this case most platforms will
rely on the fall through mechanism where the gpio_get()
and set_direction will fall through to the special-purpose functions
in the gpio driver calling out to pinctrl. So it's actually not an error.

This pinctrl handle is only intended for biasing pins etc, right?

NO muxing!

Because we wrote in Documentation/pinctrl.txt that if GPIO
and pin control handle the same lines, they should be
implemented in the gpio driver by calling out to pinctrl's
extern int pinctrl_request_gpio(unsigned gpio);
extern void pinctrl_free_gpio(unsigned gpio);
extern int pinctrl_gpio_direction_input(unsigned gpio);
extern int pinctrl_gpio_direction_output(unsigned gpio);

Yours,
Linus Walleij
