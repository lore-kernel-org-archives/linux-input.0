From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Fri, 9 Dec 2016 11:44:13 -0600
Message-ID: <CAL_JsqJhvN9SggUJ7YPiJ2RpR=tGaO7zRP4S_LNmF0C_mHtkvg@mail.gmail.com>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <20161201143434.GD1280@mail.corp.redhat.com> <20161201172448.GA46688@google.com>
 <20161205235908.rmiyd7io4kddple6@rob-hp-laptop> <20161206084803.GR1280@mail.corp.redhat.com>
 <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com>
 <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <CAL_JsqK8ruinQC0pzWLWDLVcTmPdn4ZpejWUAQ0UD7H2MhLyvA@mail.gmail.com> <CAD=FV=VBvn-QDBMehCXuuTH7ym8-nTV=VxPs=JRjRBzNdezz+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=VBvn-QDBMehCXuuTH7ym8-nTV=VxPs=JRjRBzNdezz+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Dec 9, 2016 at 10:05 AM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Hi,
>
> On Thu, Dec 8, 2016 at 8:01 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> Just my $0.02.  Feel free to ignore.
>>>
>>> One thought is that I would say that the need to power on the device
>>> explicitly seems more like a board level difference and less like a
>>> difference associated with a particular digitizer.  Said another way,
>>> it seems likely there will be boards with a w9013 without explicit
>>> control of the regulator in software and it seems like there will be
>>> boards with other digitizers where suddenly a new board will come out
>>> that needs explicit control of the regulator.
>>
>> Then either the regulator is optional or you don't say it is a w9013
>> for that board. But if you do need to initialize the device and
>> therefore know what type of device it is, then you need a compatible
>> for the device. It's when things really vary by board that we add DT
>> properties.
>>
>>> In this particular case I feel like we can draw a lot of parallels to
>>> an SDIO bus.
>>>
>>> When you specify an SDIO bus you don't specify what kind of card will
>>> be present, you just say "I've got an SDIO bus" and then the specific
>>> device underneath is probed.  Here we've say "I've got an i2c
>>> connection intended for HID" and then you probe for the HID device
>>> that's on the connection.
>>
>> No, the soldered down devices require all sorts of extra non-SDIO
>> connections and we do specify the device in those cases.
>
> We have never specified the device on boards I've worked with.
>
> On rk3288-veyron, for instance, we might have stuffed a Broadcom 4354
> WiFi chip or a Marvell 8897 WiFi chip.  Some veyron boards have one
> chip and some have the other.  ...and during bringup we even had some
> of the exact same boards where half were stuffed with one chip and
> half with the other.
>
> Nothing in the device tree says which chip is stuffed.  In both cases
> the board uses the same power on sequence for the WiFi chip.  Once
> that is done, we dynamically probe which actual WiFi part is stuffed.

That's good and I'm happy when that works, but it doesn't work in the
general case. I'm not saying you can't do exactly the same thing here.
All I'm asking for is add the properties to the binding AND a
compatible. The kernel can ignore the added compatible. The key point
is if you have additional properties outside of what it means to be
HID-over-I2C, then you must have a compatible for that device. Whether
you enforce that in the driver, I don't give a shit. I do care how it
is documented though and will care when or if we start validating
bindings (I don't think that's the kernel's job).

This is not just a problem with probe-able buses. This dual sourcing
happens with non-probe-able devices too. Look at Hans' series for
Allwinner tablet touchscreens.

> Certainly not all users that have these WiFi chips use the same power
> on sequence.  I have certainly seen development boards for these chips
> where you just insert them into a regular SD card slot.  This is a
> more expensive solution because you need more logic on the board, but
> it shows that the power on sequence is not associated with these
> chips.

If SD slots were the primary target for SDIO cards, we'd be in much
better shape without all the misc side band signals. Many devices I
don't think could be made to work as a card.

>>> Also for an SDIO bus, you've possibly got a regulators / GPIOs /
>>> resets that need to be controlled, but the specific details of these
>>> regulator / GPIOs / resets are specific to a given board and not
>>> necessarily a given SDIO device.
>>
>> It's both. The device defines what is needed and the specs to control
>> them (active states of GPIOs, de/assertion times of resets, supply
>> voltages, etc.). The board only determines what the connections are
>> and if you can control them.
>
> It's not always that simple.  The device says that it needs power and
> resets to happen.  How power is provided and how resets happen is
> awfully board specific.  As per above it is possible that the board
> wouldn't need to be involved above is you want to spend more money /
> power.

We have ways to deal with board specifics. If you want something
completely generic to handle any possible power sequence of any board
and any device, then propose something that does that. That's not what
we have here with 2 properties.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
