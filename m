From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 4/4] Input: soc_button_array - Propagate error from gpiod_count()
Date: Thu, 16 Mar 2017 15:46:09 +0100
Message-ID: <CACRpkdY4VaOk7yb9A5cuXGdS=T2ZLte2nmfaf95xbUeZ+ZraUw@mail.gmail.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com> <20170220161549.39490-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170220161549.39490-5-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
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

Patch applied with Dmitry's ACK.

Yours,
Linus Walleij
