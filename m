From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: gpio irqchip initialization race
Date: Fri, 1 Apr 2016 13:29:14 +0200
Message-ID: <CACRpkdYeMdUtqizXGFzLDwbiL7=xDM+tt0kQU5S166AL13Y_1Q@mail.gmail.com>
References: <44236018.b6N0xPzKYW@ws-stein>
	<CACRpkdbfidnokJ2WyagdcEycDu3dXKVon2z4TKM7KhNg_Hyf9w@mail.gmail.com>
	<CACRpkdZ32AAq2BfoEeyiBm1RiXQVkTO6gxsEuuMGhm7wuUXxgQ@mail.gmail.com>
	<1587936.Xd43Z6OAxQ@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1587936.Xd43Z6OAxQ@ws-stein>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 1, 2016 at 10:56 AM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> [Me]
>> And in this case (if gpio_keys handle -EPROBE_DEFER gracefully)
>> all should be fine with my oneliner patch.
>>
>> I am more uncertain about the -EINVAL (-22) we might need some
>> more analysis there.
>
> I did 10 runs and got the following results:
>> 3x  gpio-keys user_sw: Unable to claim irq 0; error -22
>> 2x  gpio-keys user_sw: Unable to get irq number for GPIO 376, error -517
>> 5x  ok
>
> So, for one gpio-keys seems not to handle -EPROBE_DEFER gracefully

After reading the code the only problem seems to be that it prints that
error. A small patch to silence that print should fix it then, can you
confirm that in these cases the gpio-keys are retried later?

> and it seem
> still possible to get an invalid irq number.

I think this is because gpiolib initialize .to_irq() before setting up the
irqdomain.

I'm making a combined patch fixing both issues, send out in a few sec.

Yours,
Linus Walleij
