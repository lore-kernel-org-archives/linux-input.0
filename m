From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/4] platform/x86: surface3_button: Propagate error
 from gpiod_count()
Date: Tue, 14 Mar 2017 10:46:08 +0100
Message-ID: <CACRpkdYiHBLuKXRWhynwkYHONy0VoV4_x68Pc4d174EZe-tNpA@mail.gmail.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com> <20170220161549.39490-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170220161549.39490-4-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 20, 2017 at 5:15 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since gpiod_count() does not return 0 anymore, we don't need to shadow
> its error code and would safely propagate to the user.
>
> While here, replace second parameter by NULL in order to prevent side
> effects on _DSD enabled firmware.
>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As I understand it Andy, you're more or less default-maintainer for
drivers/platform/x86 so I can just merge this patch into the
GPIO tree with the rest?

Yours,
Linus Walleij
