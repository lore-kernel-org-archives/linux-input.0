From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Sat, 4 Feb 2017 21:28:13 +0100
Message-ID: <CACRpkdavKk=pZPyXiDAaAouzv=MX+LBOLhMmSftgQj0_q=da+g@mail.gmail.com>
References: <1486043591-6278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1486043591-6278-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1486043591-6278-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Feb 2, 2017 at 2:53 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:

> Rename devm_get_gpiod_from_child() into
> devm_fwnode_get_gpiod_from_child() to reflect the fact that this
> function is operating on a fwnode object.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch applied.

Yours,
Linus Walleij
