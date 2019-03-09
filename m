From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: msm-vibrator: use correct gpio header
Date: Sat, 9 Mar 2019 15:33:30 -0800
Message-ID: <20190309233330.GB13699@dtor-ws>
References: <20190304195734.1070109-1-arnd@arndb.de>
 <CACRpkdaq9YzFSSXp7HSOf+RC2PGxv0N-m+iV99tn-0xTeEZr=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaq9YzFSSXp7HSOf+RC2PGxv0N-m+iV99tn-0xTeEZr=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Masney <masneyb@onstation.org>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 05, 2019 at 08:49:01AM +0100, Linus Walleij wrote:
> On Mon, Mar 4, 2019 at 8:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > When CONFIG_GPIOLIB is not set, we get a couple of build
> > errors during test building:
> >
> > drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_start':
> > drivers/input/misc/msm-vibrator.c:79:3: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
> >    gpiod_set_value_cansleep(vibrator->enable_gpio, 1);
> >    ^~~~~~~~~~~~~~~~~~~~~~~~
> >    gpio_set_value_cansleep
> > drivers/input/misc/msm-vibrator.c: In function 'msm_vibrator_probe':
> > drivers/input/misc/msm-vibrator.c:176:26: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
> >   vibrator->enable_gpio = devm_gpiod_get(&pdev->dev, "enable",
> >                           ^~~~~~~~~~~~~~
> >                           devm_gpio_free
> > drivers/input/misc/msm-vibrator.c:177:13: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
> >              GPIOD_OUT_LOW);
> >              ^~~~~~~~~~~~~
> >              GPIOF_INIT_LOW
> > drivers/input/misc/msm-vibrator.c:177:13: note: each undeclared identifier is reported only once for each function it appears in
> >
> > This is easy to avoid when we use gpio/consumer.h as the documented interface.
> >
> > Fixes: 0f681d09e66e ("Input: add new vibrator driver for various MSM SOCs")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

-- 
Dmitry
