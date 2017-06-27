From: Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: input: Add the Goodix GTx5 series
 Touchscreen devicetree bindings
Date: Tue, 27 Jun 2017 11:14:31 +0800
Message-ID: <20170627031431.GA15616@andrew-dell>
References: <22592d94-f482-3e4f-3860-1dce83472d4f@goodix.com>
 <20170623203706.upfzigj6ghdbqx2q@rob-hp-laptop>
 <20170626132253.GA24061@andrew-dell>
 <CAL_JsqJ6w7oEjm=i_KX8Y_axbRSdX4Q+14NQ8XaHnDevGQrS_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ6w7oEjm=i_KX8Y_axbRSdX4Q+14NQ8XaHnDevGQrS_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, andrew-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org, mouse-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 26, 2017 at 09:16:40AM -0500, Rob Herring wrote:
> On Mon, Jun 26, 2017 at 8:22 AM, Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org> wrote:
> > Hi Rob,
> >
> > Thank you for the review.
> >
> > On Fri, Jun 23, 2017 at 03:37:06PM -0500, Rob Herring wrote:
> >> On Mon, Jun 19, 2017 at 06:40:32PM +0800, Wang Yafei wrote:
> >> > Signed-off-by: Wang Yafei <wangyafei-PiwChjOeyQzQT0dZR+AlfA@public.gmane.org>
> >> > ---
> >> >  .../bindings/input/touchscreen/goodix-gtx5.txt     | 75 ++++++++++++++++++++++
> >> >  1 file changed, 75 insertions(+)
> >> >  create mode 100755 Documentation/devicetree/bindings/input/touchscreen/goodix-gtx5.txt
> 
> [...]
> 
> >> > +- touchscreen-key-map: keycode value map  /*KEY_HOMEPAGE, KEY_BACK*/
> >>
> >> This hardly seems sufficient to map screen areas to keys. There's been
> >> some discussion about doing that in the past.
> >
> > Sorry haven't notice that before, I will change it to the flowing
> > property format:
> > linux,keycodes = <KEY_HOMEPAGE>, <KEY_MENU>, <KEY_BACK>;
> 
> That's better, but not really what I meant. There's still some
> assumption about what region each key is located in. Is every design 3
> keys? How do you know what region of the touchscreen is a given key?
> iOW, what are the valid ranges of coordinates for each key?

I'm afraid it hard to show each key located in. The location of touch
key is determined by touch panel hardware design and the touchscreen
controller configuration data. In general, there are two different
implementations of touch key, one is specified some area on the top of
LCD, another is on the out side of LCD and will print some pattern to
indicate the key info. No matter what kind kind of implementation, the
touch controller will report a specialized key event to driver different
from coordinate events, and the driver no need to care about the rages of
coordinates. When receive a key event the only thing that driver need to
do is map it to a certain linux keycode and report to OS. The
corresponding linux keycodes of each key is determined by this device
property. The key number in not immutable, for example on some x86 tablets
there only have one home button with windows logo on the front. The key
number is determined by touch controller firmware usually no more than
5.

> 
> >> > +           compatible = "goodix,gtx5";
> >> > +           reg = <0x14>;
> >> > +           interrupt-parent = <&msm_gpio>;
> >> > +           interrupts = <13 0x2800>;
> >> > +           vtouch-supply = <&pm8916_l15>;
> >> > +           reset-gpios = <&msm_gpio 12 0x0>;
> >> > +           irq-gpios = <&msm_gpio 13 0x2800>;
> >> > +           irq-flags = <1>; /* 1:trigger rising, 2:trigger falling;*/
> >> > +           touchscreen-max-id = <10>;
> >> > +           touchscreen-size-x = <400>;
> >> > +           touchscreen-size-y = <400>;
> >> > +           touchscreen-max-w = <400>;
> >> > +           touchscreen-max-pressure = <255>;
> >> > +           touchscreen-swapped-x-y;
> >> > +           touchscreen-key-map = <172 158>; /*KEY_HOMEPAGE, KEY_BACK*/
> >> > +           sensor0 {
> >>
> >> How many sensors can there be? That needs to be documented.
> >>
> >> Why do you need a sub-node?
> >
> > sensor is an internal call, we use senesorX to represent the touchpanel
> > is produced by which factory. A panel factory will have it corresponding
> > config data to get the best touch results. It will delete the sub-node
> > and change to the following format:
> >         panel0,normal-cfg = [...]  /* panelX,cfg : X is no more than 10*/
> 
> panel0 is not a vendor and normal doesn't tell us anything. How about
> just "goodix,panel-cfg-X"?

Okay, goodix,panel-cfg-X, seems more reasonable, I will use this.

Sincerely.

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
