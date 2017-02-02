From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio: Rename devm_get_gpiod_from_child()
Date: Thu, 2 Feb 2017 11:53:17 +0100
Message-ID: <CACRpkdbVFsKvUWisrxpSWu=C2c-BNMGcaaH0MfNfD3eY0_VNEA@mail.gmail.com>
References: <1485790909-2915-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1485790909-2915-2-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 30, 2017 at 4:41 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:

> Rename devm_get_gpiod_from_child() into
> devm_fwnode_get_gpiod_from_child() to reflect the fact that this
> function is operating on a fwnode object.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

All right! So we settled we're gonna merge this and the other patch and
we have the necessary ACKs.

This is unfortunately not applying because I have a bunch of other patches
touching the same files (that's why I think it's a good opportunity to
rename it now, as mentioned IIRC).

Could you rebase this on the following branch:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-gpiod-flags

Then I will apply it on top of that immutable branch and pull it into the
devel branch of gpio so that we get it in and also have an immutable
branch with all changes if some other subsystem maintainer needs it
because of clashes.

Yours,
Linus Walleij
