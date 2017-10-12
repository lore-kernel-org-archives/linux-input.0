From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] Input: goodix - support gt1151 touchpanel
Date: Thu, 12 Oct 2017 13:09:32 -0500
Message-ID: <CAL_Jsq+GYa-QEZup+z4Uph9=UYEW+Xuv5wAy2TN3iNRQPe3zaA@mail.gmail.com>
References: <20171012150443.27542-1-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171012150443.27542-1-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 12, 2017 at 10:04 AM, Marcin Niestroj
<m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> wrote:
> Support was added based on Goodix GitHub repo [1]. There are two major
> differences between gt1151 and currently supported devices (gt9x):
>  * CONFIG_DATA register has 0x8050 address instead of 0x8047,
>  * config data checksum has 16-bit width instead of 8-bit.
>
> Also update goodix_i2c_test() function, so it reads ID register (which
> has the same address for all devices) instead of CONFIG_DATA (because
> its address is known only after reading ID of the device).
>
> [1] https://github.com/goodix/gt1x_driver_generic
>
> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
> ---
> Patch was developed and tested on top of 4.14-rc4 using custom board.
>
>  .../bindings/input/touchscreen/goodix.txt          |  3 +-

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/input/touchscreen/goodix.c                 | 88 +++++++++++++++++-----
>  2 files changed, 70 insertions(+), 21 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
