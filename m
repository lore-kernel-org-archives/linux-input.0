From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Thu, 8 Dec 2016 10:12:57 -0800
Message-ID: <20161208181257.GA12133@dtor-ws>
References: <20161201143434.GD1280@mail.corp.redhat.com>
 <20161201172448.GA46688@google.com>
 <20161205235908.rmiyd7io4kddple6@rob-hp-laptop>
 <20161206084803.GR1280@mail.corp.redhat.com>
 <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com>
 <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <20161208154145.GA30888@mail.corp.redhat.com>
 <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com>
 <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 08, 2016 at 10:26:41AM -0600, Rob Herring wrote:
> On Thu, Dec 8, 2016 at 10:13 AM, Dmitry Torokhov
> <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On December 8, 2016 8:03:06 AM PST, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >>On Thu, Dec 8, 2016 at 9:41 AM, Benjamin Tissoires
> >><benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >>> On Dec 06 2016 or thereabouts, Doug Anderson wrote:
> >>>> Hi,
> >>>>
> >>>> On Tue, Dec 6, 2016 at 6:56 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >>>> > On Tue, Dec 6, 2016 at 2:48 AM, Benjamin Tissoires
> >>>> > <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >>>> >> On Dec 05 2016 or thereabouts, Rob Herring wrote:
> >>>> >>> On Thu, Dec 01, 2016 at 09:24:50AM -0800, Brian Norris wrote:
> >>>> >>> > Hi Benjamin and Rob,
> >>>> >>> >
> >>>> >>> > On Thu, Dec 01, 2016 at 03:34:34PM +0100, Benjamin Tissoires
> >>wrote:
> >>>> >>> > > On Nov 30 2016 or thereabouts, Brian Norris wrote:
> >>>> >>> > > > From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> >>>> >>> > > >
> >>>> >>> > > > Add a compatible string and regulator property for Wacom
> >>W9103
> >>>> >>> > > > digitizer. Its VDD supply may need to be enabled before
> >>using it.
> >>>> >>> > > >
> >>>> >>> > > > Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> >>>> >>> > > > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>>> >>> > > > Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>>> >>> > > > Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >>>> >>> > > > Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >>>> >>> > > > ---
> >>>> >>> > > > v1 was a few months back. I finally got around to
> >>rewriting it based on
> >>>> >>> > > > DT binding feedback.
> >>>> >>> > > >
> >>>> >>> > > > v2:
> >>>> >>> > > >  * add compatible property for wacom
> >>>> >>> > > >  * name the regulator property specifically (VDD)
> >>>> >>> > > >
> >>>> >>> > > >  Documentation/devicetree/bindings/input/hid-over-i2c.txt
> >>| 6 +++++-
> >>>> >>> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> >>>> >>> > > >
> >>>> >>> > > > diff --git
> >>a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> >>b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> >>>> >>> > > > index 488edcb264c4..eb98054e60c9 100644
> >>>> >>> > > > ---
> >>a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> >>>> >>> > > > +++
> >>b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> >>>> >>> > > > @@ -11,12 +11,16 @@ If this binding is used, the kernel
> >>module i2c-hid will handle the communication
> >>>> >>> > > >  with the device and the generic hid core layer will
> >>handle the protocol.
> >>>> >>> > > >
> >>>> >>> > > >  Required properties:
> >>>> >>> > > > -- compatible: must be "hid-over-i2c"
> >>>> >>> > > > +- compatible: must be "hid-over-i2c", or a
> >>device-specific string like:
> >>>> >>> > > > +    * "wacom,w9013"
> >>>> >>> > >
> >>>> >>> > > NACK on this one.
> >>>> >>> > >
> >>>> >>> > > After re-reading the v1 submission I realized Rob asked for
> >>this change,
> >>>> >>> > > but I strongly disagree.
> >>>> >>> > >
> >>>> >>> > > HID over I2C is a generic protocol, in the same way HID over
> >>USB is. We
> >>>> >>> > > can not start adding device specifics here, this is opening
> >>the can of
> >>>> >>> > > worms. If the device is a HID one, nothing else should
> >>matter. The rest
> >>>> >>> > > (description of the device, name, etc...) is all provided by
> >>the
> >>>> >>> > > protocol.
> >>>> >>> >
> >>>> >>> > I should have spoken up when Rob made the suggestion, because
> >>I more or
> >>>> >>> > less agree with Benjamin here. I don't really see why this
> >>needs to have
> >>>> >>> > a specialized compatible string, as the property is still
> >>fairly
> >>>> >>> > generic, and the entire device handling is via a generic
> >>protocol. The
> >>>> >>> > fact that we manage its power via a regulator is not very
> >>>> >>> > device-specific.
> >>>> >>>
> >>>> >>> It doesn't matter that the protocol is generic. The device
> >>attached and
> >>>> >>> the implementation is not. Implementations have been known to
> >>have
> >>>> >>> bugs/quirks (generally speaking, not HID over I2C in
> >>particular). There
> >>>> >>> are also things outside the scope of what is 'hid-over-i2c' like
> >>what's
> >>>> >>> needed to power-on the device which this patch clearly show.
> >>>> >>
> >>>> >> Yes, there are bugs, quirks, even with HID. But the HID declares
> >>within
> >>>> >> the protocol the Vendor ID and the Product ID, which means once
> >>we pass
> >>>> >> the initial "device is ready" step and can do a single i2c
> >>write/read,
> >>>> >> we don't give a crap about device tree anymore.
> >>>> >>
> >>>> >> This is just about setting the device in shape so that it can
> >>answer a
> >>>> >> single write/read.
> >>>> >>
> >>>> >>>
> >>>> >>> This is no different than a panel attached via LVDS, eDP, etc.,
> >>or
> >>>> >>> USB/PCIe device hard-wired on a board. They all use standard
> >>protocols
> >>>> >>> and all need additional data to describe them. Of course, adding
> >>a
> >>>> >>> single property for a delay would not be a big deal, but it's
> >>never
> >>>> >>> ending. Next you need multiple supplies, GPIO controls, mutiple
> >>>> >>> delays... This has been discussed to death already. As Thierry
> >>Reding
> >>>> >>> said, you're not special[1].
> >>>> >>
> >>>> >> I can somewhat understand what you mean. The official
> >>specification is
> >>>> >> for ACPI. And ACPI allows to calls various settings while
> >>querying the
> >>>> >> _STA method for instance. So in the ACPI world, we don't need to
> >>care
> >>>> >> about regulators or GPIOs because the OEM deals with this in its
> >>own
> >>>> >> blob.
> >>>> >>
> >>>> >> Now, coming back to our issue. We are not special, maybe, if he
> >>says so.
> >>>> >> But this really feels like a design choice between putting the
> >>burden on
> >>>> >> device tree and OEMs or in the module maintainers. And I'd rather
> >>have
> >>>> >> the OEM deal with their device than me having to update the
> >>module for
> >>>> >> each generations of hardware. Indeed, this looks like an
> >>"endless"
> >>>> >> amount of quirks, but I'd rather have this endless amount of
> >>quirks than
> >>>> >> having to maintain an endless amount of list of new devices that
> >>behaves
> >>>> >> the same way. We are talking here about "wacom,w9013", but then
> >>comes
> >>>> >> "wacom,w9014" and we need to upgrade the kernel.
> >>>> >
> >>>> > No. If the w9014 can claim compatibility with then w9013, then you
> >>>> > don't need a kernel change. The DT should list the w9014 AND
> >>w9013,
> >>>> > but the kernel only needs to know about the w9013. That is until
> >>there
> >>>> > is some difference which is why the DT should list w9014 to start
> >>>> > with.
> >>>> >
> >>>> > If you don't have any power control to deal with, then the kernel
> >>can
> >>>> > always just match on "hid-over-i2c" compatible.
> >>>>
> >>>> Just my $0.02.  Feel free to ignore.
> >>>>
> >>>> One thought is that I would say that the need to power on the device
> >>>> explicitly seems more like a board level difference and less like a
> >>>> difference associated with a particular digitizer.  Said another
> >>way,
> >>>> it seems likely there will be boards with a w9013 without explicit
> >>>> control of the regulator in software and it seems like there will be
> >>>> boards with other digitizers where suddenly a new board will come
> >>out
> >>>> that needs explicit control of the regulator.
> >>>>
> >>>> In this particular case I feel like we can draw a lot of parallels
> >>to
> >>>> an SDIO bus.
> >>>>
> >>>> When you specify an SDIO bus you don't specify what kind of card
> >>will
> >>>> be present, you just say "I've got an SDIO bus" and then the
> >>specific
> >>>> device underneath is probed.  Here we've say "I've got an i2c
> >>>> connection intended for HID" and then you probe for the HID device
> >>>> that's on the connection.
> >>>>
> >>>> Also for an SDIO bus, you've possibly got a regulators / GPIOs /
> >>>> resets that need to be controlled, but the specific details of these
> >>>> regulator / GPIOs / resets are specific to a given board and not
> >>>> necessarily a given SDIO device.
> >>>>
> >>>
> >>> Thanks Doug for this. I had the feeling this wasn't right, but you
> >>> actually managed to put the words on it. If it's a board problem (if
> >>> you switch the wacom device with an other HID over I2C device and you
> >>> still need the same regulator/timing parameters), then this should
> >>> simply be mentioned on the patch.
> >>>
> >>> So Brian, could you please respin the series and remve the Wacom
> >>> mentions and explain that it is required for the board itself?
> >>
> >>In advance, NAK.
> >>
> >>This is not how DT works. Either this binding needs a Wacom compatible
> >>or don't use DT.
> >>
> >
> > And if tomorrow there is Elan device that is drop-in compatible
> > (same connector, etc) with Wacom i2c-hid, will you ask for
> > Elan-specific binding? Atmel? Weida? They all need to be powered up
> > ultimately.
> 
> Yes, I will. Anyone who's worked on drop-in or pin compatible parts
> knows there's no such thing.

And yet we are shipping quite a few of Chromebooks with touchpads that
are dual-sourced and can be exchanged at any time without any changes to
the software (be it kernel or firmware).

> 
> That in no way means the OS driver has to know about each and every
> one. If they can all claim compatibility with Wacom (including power
> control), then they can have a Wacom compatible string too. Or you can
> just never tell me that there's a different manufacturer and I won't
> care as long you don't need different control. But soon as a device
> needs another power rail, GPIO or different timing, then you'd better
> have a new compatible string.

That I simply do not understand. We routinely enhance bindings because
the devices get used on different boards that expose more or less
connections. I.e. quite often we start with a device whose rails are
controlled by the firmware, and so the binding only contains register
and interrupt data. Then we come across board that exposes reset GPIO
and we add that to the binding (bit we do not invent new compatible
string just because there is GPIO now). Then we get a board that
actually wants kernel to control power to the chip and we add a
regulator. Non-optional, mind you, because we rely on the regulator
system to give us a dummy one if it is not described by the
firmware/other means. And then we get another board that exposes another
power rail (let's say 3.3V to the panel whereas the previous one did not
use it). And we add another regulator binding. All this time we have
the same compatibility string.

So in this case we finally got to the point where we admit that devices
speaking HID over I2C do have power rails; we simply did not need to
control them before. The same Wacom digitizer, that you now demand to
add a compatible for, may have been used in other boards where power
rails were either turned on by the firmware at boot time and left on
until the board is shutdown, or ACPI was controlling them (via _ON/_OFF
methods), or there was some other magic. Having a supply and ability to
control the time it takes to bring the device into operating state is in
no way Wacom-specific, so why new compatibility instead of enhancing
the current binding?

And on top of that, currently multiple compatible strings are utterly
broken with regard to module loading (you only emit modalias for the
first component), so having DTS with multiples does not work well in
real life.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
