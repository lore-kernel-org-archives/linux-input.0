From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 04/13] Input: keyboard - Use local variables consistently
Date: Thu, 26 Jan 2017 10:59:40 -0800
Message-ID: <CAKdAkRQdDvu0wzcvdAeG_oWUPSS3h90W+ibg2CpCjfewhM8ZXA@mail.gmail.com>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
 <1485024365-3368-5-git-send-email-linux@roeck-us.net> <CACRpkdZW1CEmn-bKYNY_gExkMSS1CtA5ggR-ULz=xDe9j8JMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36483 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdAZS7m (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 13:59:42 -0500
In-Reply-To: <CACRpkdZW1CEmn-bKYNY_gExkMSS1CtA5ggR-ULz=xDe9j8JMqg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sudeep Holla <sudeep.holla@arm.com>

On Thu, Jan 26, 2017 at 2:31 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Jan 21, 2017 at 7:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
>> If a function declares a variable to access a structure element,
>> use it conssistently.
>
> Weird spelling :)
>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
>> -               error = devm_gpio_request_one(&pdev->dev, button->gpio, flags,
>> -                                             desc);
>> +               error = devm_gpio_request_one(dev, button->gpio, flags, desc);
>
> I think I have changes in the GPIO tree touching these code sites.
>
> I put those on an immutable branch so Dmitry can pull it if he needs
> it as a base for this patch:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/commit/?h=ib-gpiod-flags

I just tried it and it seems to merge cleanly even on top of Guenter's
patch so I think I do not have to pull it in, not yet at least.

Thanks.

-- 
Dmitry
