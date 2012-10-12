From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Fri, 12 Oct 2012 23:44:25 +0200
Message-ID: <CACRpkdb+u2ho3KhRsuE_ykM8arCL7B=SmHNS7qarAwh2mGHsjg@mail.gmail.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com>
	<CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
	<50788B53.6040309@gmail.com>
	<CACRpkda==SXUtS1AExnjaQfnCYssGbfH=LrgqWhBiq85Ln02og@mail.gmail.com>
	<50788E3D.2060404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56430 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab2JLVo0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 17:44:26 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3488596vbb.19
        for <linux-input@vger.kernel.org>; Fri, 12 Oct 2012 14:44:25 -0700 (PDT)
In-Reply-To: <50788E3D.2060404@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonas ABERG <jonas.aberg@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Fri, Oct 12, 2012 at 11:40 PM, Daniel Mack <zonque@gmail.com> wrote:

>> Because we wrote in Documentation/pinctrl.txt that if GPIO
>> and pin control handle the same lines, they should be
>> implemented in the gpio driver by calling out to pinctrl's
>> extern int pinctrl_request_gpio(unsigned gpio);
>> extern void pinctrl_free_gpio(unsigned gpio);
>> extern int pinctrl_gpio_direction_input(unsigned gpio);
>> extern int pinctrl_gpio_direction_output(unsigned gpio);
>
> Hmm. So how is a certain pin muxed to its GPIO function then?

By calling exactly the above functions from the GPIO
driver.

> And how
> can pullup/pulldown features be selected?

So as stated in:
"Drivers needing both pin control and GPIOs"

This can be done in several ways, but this way is one option
indeed, so that is a valid reason for having this pinctrl here.

Is biasing what you need to do?

> I admittedly might lack some background here, and if there's better
> solution to what I want to do, I'd be happy to hear about it :)

Sure, no problem we've even tried to document it :-)

All I really want is that platforms have a clear idea about
how and where the pins will be handled, and that if GPIO
and pinctrl handle the same lines, they need to interact.

Yours,
Linus Walleij
