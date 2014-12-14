From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] Input: gpio_keys - replace timer and workqueue with
 delayed workqueue
Date: Sun, 14 Dec 2014 10:05:43 +0100
Message-ID: <CACRpkdZsHbUVNsG60veYPpAKP+dngpUq=gLjncaUb+Lvq+h1-A@mail.gmail.com>
References: <20141208071930.GA20802@dtor-ws>
	<20141208072124.GA21031@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141208072124.GA21031@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexander Shiyan <shc_work@mail.ru>, Laxman Dewangan <ldewangan@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Dec 8, 2014 at 8:21 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> We do not need to roll our own implementation of delayed work now that we
> have proper implementation of mod_delayed_work.
>
> For interrupt-only driven buttons we retain the timer, but we rename
> it to release_timer to better reflect its purpose.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

What I want to do with this, on top of this, is to move debouncing to
the GPIO subsystem. I want gpio(d)_set_debounce() to *always*
work and the timer moved to gpiolib.c.

We can't have debouncing in every subsystem using GPIOs, it
belongs in the GPIO core.

Yours,
Linus Walleij
