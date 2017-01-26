From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 04/13] Input: keyboard - Use local variables consistently
Date: Thu, 26 Jan 2017 06:28:37 -0800
Message-ID: <fa619844-70aa-5b62-8ecd-f15440451cec@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
 <1485024365-3368-5-git-send-email-linux@roeck-us.net>
 <CACRpkdZW1CEmn-bKYNY_gExkMSS1CtA5ggR-ULz=xDe9j8JMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZW1CEmn-bKYNY_gExkMSS1CtA5ggR-ULz=xDe9j8JMqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-input@vger.kernel.org

On 01/26/2017 02:31 AM, Linus Walleij wrote:
> On Sat, Jan 21, 2017 at 7:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
>> If a function declares a variable to access a structure element,
>> use it conssistently.
>
> Weird spelling :)
>
Call id sssnaky :-)

Guenter

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
>
> Yours,
> Linus Walleij
>
