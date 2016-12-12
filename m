From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Mon, 12 Dec 2016 10:34:23 -0800
Message-ID: <20161212183422.GA138477@google.com>
References: <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <20161208154145.GA30888@mail.corp.redhat.com>
 <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com>
 <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
 <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm>
 <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
 <alpine.LNX.2.00.1612120951130.16984@cbobk.fhfr.pm>
 <20161212100110.GA13907@mail.corp.redhat.com>
 <CAL_JsqJ7t=C4+PgCyNTev66V33-cyPkUHKsTcbnsYgvAaffVfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ7t=C4+PgCyNTev66V33-cyPkUHKsTcbnsYgvAaffVfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi all,

On Mon, Dec 12, 2016 at 08:47:06AM -0600, Rob Herring wrote:

[Snip Benjamin's proposal; I agree we don't really want a multi-level DT
layout purely for making the driver look a little nicer (I'm not sure
this would really be nicer anyway). And I think, as Rob notes here, our
disagreement is smaller than appears. But I might be wrong.]

> Anyway, we're only debating this:

OK, so I think we might have a consensus of sorts? I'll describe it
here, in case I'm wrong. Otherwise, I'll send another rev.

>          i2c-hid-dev@2c {
>                  compatible = "wacom,w9013", "hid-over-i2c";

I plan to document the above, but not treat "wacom,w9013" specially in
the driver, apart from possibly listing it in the driver of_match_table.
This was mentioned by Dmitry earlier, and I didn't see any objection.

(Note that there are problems with module autoload when using multiple
compatible strings like above. May not be supremely relevant to the
documentation, but it *is* practically important.)

>                  reg = <0x2c>;
>                  hid-descr-addr = <0x0020>;
>                  interrupt-parent = <&gpx3>;
>                  interrupts = <3 2>;
>                  vdd-supply = <sth>;

Document and support 'vdd-supply', optionally.

>                  init-delay-ms = <100>;

Per Rob's mention below, support this as 'post-power-on-delay-ms',
optionally.

We can use either of these properties on any device, with the
intention that if there are future needs for divergent bindings, the
aforementioned compatible property can help us differentiate.

>          };
> 
> vs.
> 
>          i2c-hid-dev@2c {
>                  compatible = "hid-over-i2c";
>                  reg = <0x2c>;
>                  hid-descr-addr = <0x0020>;
>                  interrupt-parent = <&gpx3>;
>                  interrupts = <3 2>;
>                  vdd-supply = <sth>;
>                  init-delay-ms = <100>;
>          };
> 
> My only other nit is use "post-power-on-delay-ms" which is already a
> defined property name rather than "init-delay-ms".

Any objections? Speak now or forever [1] hold your peace.

Brian

[1] Who am I kidding? There's always room for more paint on the
bikeshed.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
