From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] input: ixp4xx-beeper: include linux/io.h
Date: Wed, 2 Oct 2019 14:00:14 +0200
Message-ID: <CACRpkdaVhhGF-g_95zPg2wvXGcGfYG1YUVVuz5nOsRw8GwGQkw@mail.gmail.com>
References: <20191002095736.1297224-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002095736.1297224-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Enrico Weigelt <info@metux.net>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 2, 2019 at 11:57 AM Arnd Bergmann <arnd@arndb.de> wrote:

> asm/io.h may not be included implicitly, causing a rare
> randconfig build error:
>
> drivers/input/misc/ixp4xx-beeper.c:48:3: error: implicit declaration of function '__raw_writel' [-Werror,-Wimplicit-function-declaration]
>                 __raw_writel((count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE,
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I am thinking a bit about the future of this driver. Isn't it more
reasonable to just make a hrtimer-driven PWM and use the existing
PWM userspace ABI and timer framework in Linux for this?
Not that there is a generic timer-driven PWM but ... that is
essentially what this driver is.

Yours,
Linus Walleij
