From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Mon, 12 Dec 2016 08:47:06 -0600
Message-ID: <CAL_JsqJ7t=C4+PgCyNTev66V33-cyPkUHKsTcbnsYgvAaffVfw@mail.gmail.com>
References: <20161206084803.GR1280@mail.corp.redhat.com> <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com>
 <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <20161208154145.GA30888@mail.corp.redhat.com> <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com> <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
 <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm> <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
 <alpine.LNX.2.00.1612120951130.16984@cbobk.fhfr.pm> <20161212100110.GA13907@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161212100110.GA13907-/m+UfqrgI5QNLKR9yMNcA1aTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Dec 12, 2016 at 4:01 AM, Benjamin Tissoires
<benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Dec 12 2016 or thereabouts, Jiri Kosina wrote:
>> Given the timing (merge window being open) and given then NACK given by
>> Rob, I've now unapplied the patches (the for-4.10/i2c-hid branch is now
>> obsolete, and has been superseded by for-4.10/i2c-hid-nopower).
>>
>> However, this is mostly done in order to provide more time for discussion;
>> I still disagree with the reasoning behind the NACK.
>>
>
> To hopefully make things going forward a little bit, I was wondering
> over the week-end if we should not solve this particular issue by adding
> an intermediate platform DT node:
>
> instead of having:
> ---
>         i2c-hid-dev@2c {
>                 compatible = "hid-over-i2c";
>                 reg = <0x2c>;
>                 hid-descr-addr = <0x0020>;
>                 interrupt-parent = <&gpx3>;
>                 interrupts = <3 2>;
>                 vdd-supply = <sth>;
>                 init-delay-ms = <100>;
>         };
> ---
>
> we would have:
> ---
>         platform-i2c-hid@01 {
>                 compatible = "very-special-board-that-needs-firmware-quirks-and-delay-of-100ms";
>                 vdd-supply = <sth>;
>                 i2c-hid-dev@2c {
>                         compatible = "hid-over-i2c";
>                         reg = <0x2c>;
>                         hid-descr-addr = <0x0020>;
>                         interrupt-parent = <&gpx3>;
>                         interrupts = <3 2>;
>                 };
>         };
> ---
>
> If I am not wrong, the platform device should be initialized before
> i2c-hid get called, which allows to setup properly the vdd supply.
> On resume/suspend, the tree should be respected and we should be able to
> enable/disable power in the same fashion this patch provides.
>
> We could then extend this platform device at will without tinkering in
> i2c-hid and we could also handle the GPIOs, reset or whatever is
> required in the future through compatibles.
>
> Thoughts? yes? no? bullshit?

That is structuring the DT match your driver structure, not what the
h/w looks like. This would make sense if the device was multi-function
of which HID-over-I2C was one function. You could do what you describe
with a single node and the platform driver creates the hid-over-i2c
device. DT is not the only way to create devices.

Anyway, we're only debating this:

         i2c-hid-dev@2c {
                 compatible = "wacom,w9013", "hid-over-i2c";
                 reg = <0x2c>;
                 hid-descr-addr = <0x0020>;
                 interrupt-parent = <&gpx3>;
                 interrupts = <3 2>;
                 vdd-supply = <sth>;
                 init-delay-ms = <100>;
         };

vs.

         i2c-hid-dev@2c {
                 compatible = "hid-over-i2c";
                 reg = <0x2c>;
                 hid-descr-addr = <0x0020>;
                 interrupt-parent = <&gpx3>;
                 interrupts = <3 2>;
                 vdd-supply = <sth>;
                 init-delay-ms = <100>;
         };

My only other nit is use "post-power-on-delay-ms" which is already a
defined property name rather than "init-delay-ms".

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
