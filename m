From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib: handle probe deferrals better
Date: Wed, 6 Apr 2016 15:39:13 +0200
Message-ID: <CACRpkdbzRPfEgdcPrQzDBQxVUnpdJFoGSFqeQ82tohfCAE11_g@mail.gmail.com>
References: <1459511048-24084-1-git-send-email-linus.walleij@linaro.org>
	<56FE7785.1010507@ti.com>
	<570294A4.2070801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <570294A4.2070801@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Linux Input <linux-input@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Guenter Roeck <linux@roeck-us.net>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-input@vger.kernel.org

On Mon, Apr 4, 2016 at 6:21 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Below is RFC patch to prove above consent. I've had offlist
> debugging session with Alexander and He mentioned that this change
> fixes boot issue for him.

Thanks for looking into this.

> Of course, there are some question to discuss:
> 1) [+] It should sync initialization of GPIOchip and GPIOirqchip
> 2) [+] This approach requires changes in gpiolib/gpio drivers only, from other side
> It will require to add fixes all over the Kernel if gpiod_to_irq() will
> start returning -EPROBE_DEFER.

Yes, so it will need to be cross-coordinated with IRQ maintainers
Marc and TGLX.

> 3) [-] has_irq might need to be initialized by non-DT drivers

Yes. Every driver in the kernel need to be audited.

> 4) [-] irq_ready might need to be set manually by drivers which do not use GPIO irq
>    helpers (see change in gpio-mpc8xxx.c)

Yes. That too. Every driver in the kernel need to be audited.

> 4) irq_ready access synchronization on SMP? atomic?

Uhhh.... I don't even understand the question.

> job done with commit e6918cd 'gpiolib: handle probe deferrals better'
> reverted.

I have taken that out of my tree as well. My naive approach
doesn't work.

Yours,
Linus Walleij
