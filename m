From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] input: ixp4xx-beeper: include linux/io.h
Date: Wed, 2 Oct 2019 14:07:09 +0200
Message-ID: <CAK8P3a2=V4qJ9CDzZMNCzgOh-nD-24AFdoo83+QRNfc60FxD4Q@mail.gmail.com>
References: <20191002095736.1297224-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002095736.1297224-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Enrico Weigelt <info@metux.net>, Linus Walleij <linus.walleij@linaro.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 2, 2019 at 11:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> asm/io.h may not be included implicitly, causing a rare
> randconfig build error:
>
> drivers/input/misc/ixp4xx-beeper.c:48:3: error: implicit declaration of function '__raw_writel' [-Werror,-Wimplicit-function-declaration]
>                 __raw_writel((count & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE,
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Please ignore, this does not apply to mainline and is probably only needed
on top of another patch that I will submit in the future.

       Arnd
