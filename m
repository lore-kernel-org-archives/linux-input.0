From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib: handle probe deferrals better
Date: Thu, 7 Apr 2016 19:09:06 +0200
Message-ID: <CACRpkdZYyZG9=mXdWi3bnfvOqc6LFE1FykTU-QirQOJLv=Z2=A@mail.gmail.com>
References: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
	<56FE7785.1010507@ti.com>
	<570294A4.2070801@ti.com>
	<CACRpkdbzRPfEgdcPrQzDBQxVUnpdJFoGSFqeQ82tohfCAE11_g@mail.gmail.com>
	<57052E67.4050206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <57052E67.4050206@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Linux Input <linux-input@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Guenter Roeck <linux@roeck-us.net>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 6, 2016 at 5:42 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 04/06/2016 04:39 PM, Linus Walleij wrote:

>>> Of course, there are some question to discuss:
>>> 1) [+] It should sync initialization of GPIOchip and GPIOirqchip
>>> 2) [+] This approach requires changes in gpiolib/gpio drivers only, from other side
>>> It will require to add fixes all over the Kernel if gpiod_to_irq() will
>>> start returning -EPROBE_DEFER.
>>
>> Yes, so it will need to be cross-coordinated with IRQ maintainers
>> Marc and TGLX.
>
> Seems, I have to study how to be more clear :(
> This +/- are all about my RFC patch.
> My patch limits the scope of problem to GPIO subsystem/drivers only.
> As opposite, if we will touch gpiod_to_irq() - it will affect on whole
> kernel.

OK I get it now, good.

>> Yes. Every driver in the kernel need to be audited.
>
> With my patch only GPIO drivers need to be checked, especially GPIO
> drivers which:
>  - are non-DT based;
>  - do not use GPIO irq helpers
>  - can make IRQ functionality optional using Kconfig/sysfs/module parameters

Yeah. I mean you have to look at all of them, not patch all of
them. It's a lot but not unberably much. < 300 files.

>>> 4) irq_ready access synchronization on SMP? atomic?
>>
>> Uhhh.... I don't even understand the question.
>
> in my patch the irq_ready is set from _gpiochip_irqchip_add() and
> read from gpiod_request() without any kind of protection and those
> two functions can be executed in parallel.

Aha. Well I don't know if that is really a big problem?
Does that really happen in practice?

Yours,
Linus Walleij
