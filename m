From: Hans Holmberg <hans-syntQev1tZzUyQxjFilb4QC/G2K4zDHf@public.gmane.org>
Subject: Re: [RFC PATCH] Input: gpio_keys - add dt abs/rel button support
Date: Thu, 2 Feb 2017 15:50:51 +0100
Message-ID: <20170202144913.GA3419@Gaia>
References: <20170131073111.GA3918@Gaia>
 <20170131081053.GA8311@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170131081053.GA8311@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Stein <alexander.stein-jNDFPZUTrfQ+B2oLq8eQJv4efur1V5z/s0AfqQuZ5sE@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 31, 2017 at 12:10:53AM -0800, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Tue, Jan 31, 2017 at 08:31:14AM +0100, Hans Holmberg wrote:
> > Also emit 0 on button releases for REL and ABS keys. This is a must-have
> > for supporting digital joysticks, and aligns the driver whith
> > gpio-keys-polled.
> 
> This does not quite aligns this with gpio-keys-polled though: there we
> read state of *all* GPIOs and if neither reports value for a given axis
> then we report "release" event. Here we react to event from a single
> GPIO and whenever it is released we report 0. So the events could be:
> 
> +1,0,+2,0,+3,... Or, worse, +1,-1,0 if we have 2 GPIOs for +1 and -1 and
> you happen to service interrupt for GPIO becoming active before
> servicing interrupt for GPIO becoming inactive.
> 
> I think to have the behavior you want you need to check state of other
> GPIOs for the same axis before reporting final state.

Yep, thanks for pointing it out. It makes sense to report 0 only when 
there are no buttons pressed on the same axis. 

The question is, what should be reported when more than one button is 
pressed on the same axis?

To me, it would make most sense to have a an ordered list (the sequence the 
buttons are provided via dt/pdata would do) and report only the last(or first)
if several buttons on an axis are pressed. This is what I would expect if I'd 
use the abs-axis for controlling i.e. audio volume.

A variation of this is to always report the last pressed, and then fall back 
on the ordered list when that button is released.

gpio_keys_polled reports multiple ABS values for an axis if more than one 
button is pressed, which seems wierd to me.

This is how gpio_keys_polled handles pressed keys on the same axis:

Use case:

Buttons defined(in this order)
Button A value = 1
Button B value = 2

Evtest:

[A down, B up]
Event: time 1486029549.621182, type 3 (EV_ABS), code 0 (ABS_X), value 1
Event: time 1486029549.621182, -------------- EV_SYN ------------

[A down, B down] 
Event: time 1486029558.201182, type 3 (EV_ABS), code 0 (ABS_X), value 2
Event: time 1486029558.201182, type 3 (EV_ABS), code 0 (ABS_X), value 1
Event: time 1486029558.201182, -------------- EV_SYN ------------
Event: time 1486029558.311190, type 3 (EV_ABS), code 0 (ABS_X), value 2
Event: time 1486029558.311190, type 3 (EV_ABS), code 0 (ABS_X), value 1
...

(this keeps on repeating(!) while the buttons are pressed)

[A down, B up]
<no events>

[A up, B up]
Event: time 1486029561.391175, type 3 (EV_ABS), code 0 (ABS_X), value 0
Event: time 1486029561.391175, -------------- EV_SYN ------------

Is this intentional? If so, gpio_keys can be made to mimic this(minus
the repeating reports)

Thanks,
Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
