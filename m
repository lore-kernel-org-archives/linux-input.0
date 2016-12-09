From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Fri, 9 Dec 2016 08:36:47 -0600
Message-ID: <CAL_JsqKCQxhYpQQcM6mb2z1=5owVdzESOx29rXSkmp44BZRe-w@mail.gmail.com>
References: <20161201143434.GD1280@mail.corp.redhat.com> <20161201172448.GA46688@google.com>
 <20161205235908.rmiyd7io4kddple6@rob-hp-laptop> <20161206084803.GR1280@mail.corp.redhat.com>
 <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com>
 <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <20161208154145.GA30888@mail.corp.redhat.com> <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com> <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
 <20161208181257.GA12133@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161208181257.GA12133@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 8, 2016 at 12:12 PM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Dec 08, 2016 at 10:26:41AM -0600, Rob Herring wrote:
>> On Thu, Dec 8, 2016 at 10:13 AM, Dmitry Torokhov
>> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > On December 8, 2016 8:03:06 AM PST, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> >>On Thu, Dec 8, 2016 at 9:41 AM, Benjamin Tissoires
>> >><benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> >>> On Dec 06 2016 or thereabouts, Doug Anderson wrote:

[...]

>> >>>> When you specify an SDIO bus you don't specify what kind of card
>> >>will
>> >>>> be present, you just say "I've got an SDIO bus" and then the
>> >>specific
>> >>>> device underneath is probed.  Here we've say "I've got an i2c
>> >>>> connection intended for HID" and then you probe for the HID device
>> >>>> that's on the connection.
>> >>>>
>> >>>> Also for an SDIO bus, you've possibly got a regulators / GPIOs /
>> >>>> resets that need to be controlled, but the specific details of these
>> >>>> regulator / GPIOs / resets are specific to a given board and not
>> >>>> necessarily a given SDIO device.
>> >>>>
>> >>>
>> >>> Thanks Doug for this. I had the feeling this wasn't right, but you
>> >>> actually managed to put the words on it. If it's a board problem (if
>> >>> you switch the wacom device with an other HID over I2C device and you
>> >>> still need the same regulator/timing parameters), then this should
>> >>> simply be mentioned on the patch.
>> >>>
>> >>> So Brian, could you please respin the series and remve the Wacom
>> >>> mentions and explain that it is required for the board itself?
>> >>
>> >>In advance, NAK.
>> >>
>> >>This is not how DT works. Either this binding needs a Wacom compatible
>> >>or don't use DT.
>> >>
>> >
>> > And if tomorrow there is Elan device that is drop-in compatible
>> > (same connector, etc) with Wacom i2c-hid, will you ask for
>> > Elan-specific binding? Atmel? Weida? They all need to be powered up
>> > ultimately.
>>
>> Yes, I will. Anyone who's worked on drop-in or pin compatible parts
>> knows there's no such thing.
>
> And yet we are shipping quite a few of Chromebooks with touchpads that
> are dual-sourced and can be exchanged at any time without any changes to
> the software (be it kernel or firmware).
>
>>
>> That in no way means the OS driver has to know about each and every
>> one. If they can all claim compatibility with Wacom (including power
>> control), then they can have a Wacom compatible string too. Or you can
>> just never tell me that there's a different manufacturer and I won't
>> care as long you don't need different control. But soon as a device
>> needs another power rail, GPIO or different timing, then you'd better
>> have a new compatible string.
>
> That I simply do not understand. We routinely enhance bindings because
> the devices get used on different boards that expose more or less
> connections. I.e. quite often we start with a device whose rails are
> controlled by the firmware, and so the binding only contains register
> and interrupt data. Then we come across board that exposes reset GPIO
> and we add that to the binding (bit we do not invent new compatible
> string just because there is GPIO now). Then we get a board that
> actually wants kernel to control power to the chip and we add a
> regulator. Non-optional, mind you, because we rely on the regulator
> system to give us a dummy one if it is not described by the
> firmware/other means. And then we get another board that exposes another
> power rail (let's say 3.3V to the panel whereas the previous one did not
> use it). And we add another regulator binding. All this time we have
> the same compatibility string.

All this I agree with, but it almost always starts with a compatible
that matches the device, not a compatible for the protocol. When
adding control for different devices diverge, then they need different
compatibles. Ideally, we'd start with all the supplies and control
lines defined for a binding, so we don't have so much evolving of
bindings. But obviously we can't always get things 100% complete to
start with, so we have to let them evolve. And I can't go read every
datasheet, but I do go read them sometimes for reviews.

> So in this case we finally got to the point where we admit that devices
> speaking HID over I2C do have power rails; we simply did not need to
> control them before. The same Wacom digitizer, that you now demand to
> add a compatible for, may have been used in other boards where power
> rails were either turned on by the firmware at boot time and left on
> until the board is shutdown, or ACPI was controlling them (via _ON/_OFF
> methods), or there was some other magic. Having a supply and ability to
> control the time it takes to bring the device into operating state is in
> no way Wacom-specific, so why new compatibility instead of enhancing
> the current binding?

A new compatible is enhancing the binding IMO. I'm just saying you
need both the compatible and the added properties. Whether the power
on delay should be a property or implied by the compatible is somewhat
debatable, but I'm okay with having it because we already do on other
bindings. What I'm not okay with is "simple" or "generic" bindings
that continually evolve with additional properties to handle more and
more complex cases. DT is not a scripting language. This has been
discussed countless times before...

> And on top of that, currently multiple compatible strings are utterly
> broken with regard to module loading (you only emit modalias for the
> first component), so having DTS with multiples does not work well in
> real life.

Sounds like this should be a fixable problem.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
