From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] Input: goodix - add more entries in i2c_device_id
Date: Thu, 12 Oct 2017 13:08:25 -0500
Message-ID: <CAL_JsqKYC6KZxYyB3SXSbCWDdPFrV=C=Qwx3_x3FDUjm2xpX6Q@mail.gmail.com>
References: <20171012150443.27542-1-m.niestroj@grinn-global.com> <20171012150443.27542-2-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171012150443.27542-2-m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 12, 2017 at 10:04 AM, Marcin Niestroj
<m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> wrote:
> Add corresponding entry in i2c_device_id table for each of_device_id
> entry. This makes it possible to autoload module for goodix
> touchscreen device-tree entry, based on modalias (which is generated
> by stripping manufacturer prefix from compatible string).

Stripping the vendor prefix is behavior we don't want to expand. Add
or extend the OF match table instead.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
