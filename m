From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/6] Input: gpio_keys - add support for GPIO descriptors
Date: Sat, 29 Oct 2016 10:38:21 +0200
Message-ID: <CACRpkdaGDtV19eSmnhpRUQKki8bzDy0ymK8ZhWzW=KTejLF9iA@mail.gmail.com>
References: <1477696485-6995-1-git-send-email-dmitry.torokhov@gmail.com> <1477696485-6995-5-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477696485-6995-5-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 29, 2016 at 1:14 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> GPIO descriptors are the preferred way over legacy GPIO numbers
> nowadays. Convert the driver to use GPIO descriptors internally but
> still allow passing legacy GPIO numbers from platform data to support
> existing platforms.
>
> Based on commits 633a21d80b4a2cd6 ("input: gpio_keys_polled: Add support
> for GPIO descriptors") and 1ae5ddb6f8837558 ("Input: gpio_keys_polled -
> request GPIO pin as input.").
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
