From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] input: touchscreen: Add generic touchscreen
 softbutton handling code
Date: Mon, 1 Aug 2016 10:41:54 -0700
Message-ID: <20160801174154.GA3231@dtor-ws>
References: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
 <1469978590-14081-2-git-send-email-hdegoede@redhat.com>
 <20160801165430.GA30345@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160801165430.GA30345@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 01, 2016 at 11:54:30AM -0500, Rob Herring wrote:
> On Sun, Jul 31, 2016 at 05:23:07PM +0200, Hans de Goede wrote:
> > Some touchscreens extend over the display they cover and have a number
> > of capacative softbuttons outside of the display the cover.
> > 
> > With some hardware these softbuttons simply report touches with
> > coordinates outside of the normal coordinate space for touches on the
> > display.
> > 
> > This commit adds a devicetree binding for describing such buttons in
> > devicetree and a bunch of helper functions to easily add support for
> > these to existing touchscreen drivers.
> > 
> > Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  .../bindings/input/touchscreen/softbuttons.txt     |  58 +++++++++
> >  drivers/input/touchscreen/Makefile                 |   2 +-
> >  drivers/input/touchscreen/softbuttons.c            | 145 +++++++++++++++++++++
> >  include/linux/input/touchscreen.h                  |   9 ++
> >  4 files changed, 213 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> >  create mode 100644 drivers/input/touchscreen/softbuttons.c
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> > new file mode 100644
> > index 0000000..3eb6f4c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> > @@ -0,0 +1,58 @@
> > +General Touchscreen Softbutton Properties:
> > +
> > +Some touchscreens extend over the display they cover and have a number
> > +of capacative softbuttons outside of the display the cover.
> > +
> > +Some of these softbuttons simply report touches with coordinates outside of
> > +the normal coordinate space for touches on the display. This binding is for
> > +describing such buttons in devicetree.
> > +
> > +Each softkey is represented as a sub-node of the touchscreen node.
> > +
> > +Required subnode-properties:
> > + - label			: Descriptive name of the key.
> > + - linux,code			: Keycode to emit.
> > + - softbutton-min-x		: X start of the area the softbutton area covers
> > + - softbutton-max-x		: X end of the area the softbutton area covers
> > + - softbutton-min-y		: Y start of the area the softbutton area covers
> > + - softbutton-max-y		: Y end of the area the softbutton area covers
> 
> This generally looks fine to me, but I am wondering one thing. If the 
> buttons are located at the origin of an axis, can we handle that case? I 
> don't think you can unless you assume softbutton-max-? is 0 for the 
> touchscreen. To put it another way, you have a gap from 1024 to 1084 
> which you can't express for buttons at the origin unless you do negative 
> numbers.

I do not this this should be done in kernel: I do not see nay difference
in softbuttons or sliders or circular controls or... They are not
controller-specific and I think are better handled in userspace. We do
that for Synaptics touchpads with softbuttons, we can do that for other
controllers.

Also, what is or stance when there is no bezel and we sill want to have
the softbutons (i.e. all Nexus phones and tablets)?

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
