From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Input: gpio_keys_polled - always use gpiod_get_value_cansleep
Date: Thu, 20 Oct 2016 14:23:41 +0200
Message-ID: <CACRpkdYnbGPXO0uPrY4gaaS-PieUJej4agkixpPxW=k9qFs8ZA@mail.gmail.com>
References: <20161019234107.GA2927@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161019234107.GA2927@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 20, 2016 at 1:41 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> It does not matter if given GPIO may sleep or not when reading state,
> polling is always done in a non-atomic context, so we should always
> be able to simply use gpiod_get_value_cansleep().
>
> Also let's note in the logs when we fail to read gpio state.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Apart from the other comments mentioned:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
