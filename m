From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] gpio: acpi: Don't return 0 on acpi_gpio_count()
Date: Thu, 16 Mar 2017 15:42:51 +0100
Message-ID: <CACRpkdZLYeSuM+geLJgDOa2FXwP8mWXs-tmi6vQjRBtMpoJUwA@mail.gmail.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com> <20170220161549.39490-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170220161549.39490-2-andriy.shevchenko@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 20, 2017 at 5:15 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It's unusual to have error checking like (ret <= 0) in cases when
> counting GPIO resources. In case when it's mandatory we propagate the
> error (-ENOENT), otherwise we don't use the result.
>
> This makes consistent behaviour across all possible variants called in
> gpiod_count().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied with Mika's ACK.

Yours,
Linus Walleij
