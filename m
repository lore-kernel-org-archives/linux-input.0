From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/3] Input: gpio-keys - add support for wakeup event action
Date: Sat, 10 Mar 2018 20:32:20 +0200
Message-ID: <CAHp75VfOUSd0WquVjpkyxqmcmm2XUshAy0b+2fC0uO=S-+ZudQ@mail.gmail.com>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
 <20180308073213.8419-2-jeffy.chen@rock-chips.com> <20180310181509.GB260013@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180310181509.GB260013@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@google.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Dmitry Torokhov <dtor@google.com>, Douglas Anderson <dianders@google.com>, devicetree <devicetree@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input <linux-input@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 10, 2018 at 8:15 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> +       while (--i >= 0) {

Just in case

while (i--) {

is slightly better to read.

> +               bdata = &ddata->data[i];
> +               if (bdata->button->wakeup)
> +                       gpio_keys_button_disable_wakeup(bdata);
> +               bdata->suspended = false;
> +       }

-- 
With Best Regards,
Andy Shevchenko
