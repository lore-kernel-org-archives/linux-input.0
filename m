From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: input: Add the Goodix GTx5 series
 Touchscreen devicetree bindings
Date: Fri, 30 Jun 2017 09:46:35 -0500
Message-ID: <CAL_JsqJXjKTUaOp-DS07Jw-iGrBB3euoE94LFBAhh0TOP8Tmxg@mail.gmail.com>
References: <22592d94-f482-3e4f-3860-1dce83472d4f@goodix.com>
 <20170623203706.upfzigj6ghdbqx2q@rob-hp-laptop> <20170626132253.GA24061@andrew-dell>
 <CAL_JsqJ6w7oEjm=i_KX8Y_axbRSdX4Q+14NQ8XaHnDevGQrS_w@mail.gmail.com> <20170627032705.GA16627@andrew-dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170627032705.GA16627@andrew-dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, andrew-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org, mouse-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 26, 2017 at 10:27 PM, Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, Jun 26, 2017 at 09:16:40AM -0500, Rob Herring wrote:
>> On Mon, Jun 26, 2017 at 8:22 AM, Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org> wrote:
>> > Hi Rob,
>> >
>> > Thank you for the review.
>> >
>> > On Fri, Jun 23, 2017 at 03:37:06PM -0500, Rob Herring wrote:
>> >> On Mon, Jun 19, 2017 at 06:40:32PM +0800, Wang Yafei wrote:
>> >> > Signed-off-by: Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org>
>> >> > ---
>> >> >  .../bindings/input/touchscreen/goodix-gtx5.txt     | 75 ++++++++++++++++++++++
>> >> >  1 file changed, 75 insertions(+)
>> >> >  create mode 100755 Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
>>
>> [...]

>> >> > +           compatible = "goodix,gtx5";
>> >> > +           reg = <0x14>;
>> >> > +           interrupt-parent = <&msm_gpio>;
>> >> > +           interrupts = <13 0x2800>;
>> >> > +           vtouch-supply = <&pm8916_l15>;
>> >> > +           reset-gpios = <&msm_gpio 12 0x0>;
>> >> > +           irq-gpios = <&msm_gpio 13 0x2800>;
>> >> > +           irq-flags = <1>; /* 1:trigger rising, 2:trigger falling;*/
>> >> > +           touchscreen-max-id = <10>;
>> >> > +           touchscreen-size-x = <400>;
>> >> > +           touchscreen-size-y = <400>;
>> >> > +           touchscreen-max-w = <400>;
>> >> > +           touchscreen-max-pressure = <255>;
>> >> > +           touchscreen-swapped-x-y;
>> >> > +           touchscreen-key-map = <172 158>; /*KEY_HOMEPAGE, KEY_BACK*/
>> >> > +           sensor0 {
>> >>
>> >> How many sensors can there be? That needs to be documented.
>> >>
>> >> Why do you need a sub-node?
>> >
>> > sensor is an internal call, we use senesorX to represent the touchpanel
>> > is produced by which factory. A panel factory will have it corresponding
>> > config data to get the best touch results. It will delete the sub-node
>> > and change to the following format:
>> >         panel0,normal-cfg = [...]  /* panelX,cfg : X is no more than 10*/
>>
>> panel0 is not a vendor and normal doesn't tell us anything. How about
>> just "goodix,panel-cfg-X"?
>
> Can I use "goodix,normal-cfg-X" rather than "goodix,panel-cfg-X"? The
> string "normal-cfg" is meaningful to driver.

Okay.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
