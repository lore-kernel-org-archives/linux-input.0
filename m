From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 07/10] gpio: max77650: add GPIO support
Date: Fri, 8 Feb 2019 12:22:10 +0100
Message-ID: <CACRpkdYKLeKA7CPFvoBPHB-K+X_n80YvFyYS_SHxuTTyGLNZ4g@mail.gmail.com>
References: <20190205091237.6448-1-brgl@bgdev.pl> <20190205091237.6448-8-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205091237.6448-8-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Tue, Feb 5, 2019 at 10:12 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add GPIO support for max77650 mfd device. This PMIC exposes a single
> GPIO line.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this with the rest of the stuff through MFD!

Thanks,
Linus Walleij
