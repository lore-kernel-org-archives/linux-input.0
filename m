From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Tue, 6 Dec 2016 08:56:16 -0600
Message-ID: <CAL_Jsq+C1MWrN4Sg_xOgpTzQh9gfL12G5Uxb1ya2MTkoa=7fMA@mail.gmail.com>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <20161201143434.GD1280@mail.corp.redhat.com> <20161201172448.GA46688@google.com>
 <20161205235908.rmiyd7io4kddple6@rob-hp-laptop> <20161206084803.GR1280@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161206084803.GR1280@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>, Jiri Kosina <jikos@kernel.org>, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 6, 2016 at 2:48 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Dec 05 2016 or thereabouts, Rob Herring wrote:
>> On Thu, Dec 01, 2016 at 09:24:50AM -0800, Brian Norris wrote:
>> > Hi Benjamin and Rob,
>> >
>> > On Thu, Dec 01, 2016 at 03:34:34PM +0100, Benjamin Tissoires wrote:
>> > > On Nov 30 2016 or thereabouts, Brian Norris wrote:
>> > > > From: Caesar Wang <wxt@rock-chips.com>
>> > > >
>> > > > Add a compatible string and regulator property for Wacom W9103
>> > > > digitizer. Its VDD supply may need to be enabled before using it.
>> > > >
>> > > > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> > > > Cc: Rob Herring <robh+dt@kernel.org>
>> > > > Cc: Jiri Kosina <jikos@kernel.org>
>> > > > Cc: linux-input@vger.kernel.org
>> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
>> > > > ---
>> > > > v1 was a few months back. I finally got around to rewriting it based on
>> > > > DT binding feedback.
>> > > >
>> > > > v2:
>> > > >  * add compatible property for wacom
>> > > >  * name the regulator property specifically (VDD)
>> > > >
>> > > >  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 6 +++++-
>> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
>> > > > index 488edcb264c4..eb98054e60c9 100644
>> > > > --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
>> > > > +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
>> > > > @@ -11,12 +11,16 @@ If this binding is used, the kernel module i2c-hid will handle the communication
>> > > >  with the device and the generic hid core layer will handle the protocol.
>> > > >
>> > > >  Required properties:
>> > > > -- compatible: must be "hid-over-i2c"
>> > > > +- compatible: must be "hid-over-i2c", or a device-specific string like:
>> > > > +    * "wacom,w9013"
>> > >
>> > > NACK on this one.
>> > >
>> > > After re-reading the v1 submission I realized Rob asked for this change,
>> > > but I strongly disagree.
>> > >
>> > > HID over I2C is a generic protocol, in the same way HID over USB is. We
>> > > can not start adding device specifics here, this is opening the can of
>> > > worms. If the device is a HID one, nothing else should matter. The rest
>> > > (description of the device, name, etc...) is all provided by the
>> > > protocol.
>> >
>> > I should have spoken up when Rob made the suggestion, because I more or
>> > less agree with Benjamin here. I don't really see why this needs to have
>> > a specialized compatible string, as the property is still fairly
>> > generic, and the entire device handling is via a generic protocol. The
>> > fact that we manage its power via a regulator is not very
>> > device-specific.
>>
>> It doesn't matter that the protocol is generic. The device attached and
>> the implementation is not. Implementations have been known to have
>> bugs/quirks (generally speaking, not HID over I2C in particular). There
>> are also things outside the scope of what is 'hid-over-i2c' like what's
>> needed to power-on the device which this patch clearly show.
>
> Yes, there are bugs, quirks, even with HID. But the HID declares within
> the protocol the Vendor ID and the Product ID, which means once we pass
> the initial "device is ready" step and can do a single i2c write/read,
> we don't give a crap about device tree anymore.
>
> This is just about setting the device in shape so that it can answer a
> single write/read.
>
>>
>> This is no different than a panel attached via LVDS, eDP, etc., or
>> USB/PCIe device hard-wired on a board. They all use standard protocols
>> and all need additional data to describe them. Of course, adding a
>> single property for a delay would not be a big deal, but it's never
>> ending. Next you need multiple supplies, GPIO controls, mutiple
>> delays... This has been discussed to death already. As Thierry Reding
>> said, you're not special[1].
>
> I can somewhat understand what you mean. The official specification is
> for ACPI. And ACPI allows to calls various settings while querying the
> _STA method for instance. So in the ACPI world, we don't need to care
> about regulators or GPIOs because the OEM deals with this in its own
> blob.
>
> Now, coming back to our issue. We are not special, maybe, if he says so.
> But this really feels like a design choice between putting the burden on
> device tree and OEMs or in the module maintainers. And I'd rather have
> the OEM deal with their device than me having to update the module for
> each generations of hardware. Indeed, this looks like an "endless"
> amount of quirks, but I'd rather have this endless amount of quirks than
> having to maintain an endless amount of list of new devices that behaves
> the same way. We are talking here about "wacom,w9013", but then comes
> "wacom,w9014" and we need to upgrade the kernel.

No. If the w9014 can claim compatibility with then w9013, then you
don't need a kernel change. The DT should list the w9014 AND w9013,
but the kernel only needs to know about the w9013. That is until there
is some difference which is why the DT should list w9014 to start
with.

If you don't have any power control to deal with, then the kernel can
always just match on "hid-over-i2c" compatible.

> I have dealt with that for the wacom modules for years, and this is
> definitively not a good solution.
>
> And one additional caveat of this solution is the time between the
> release of the new device and its readiness in the hands of the
> consumer. You need to push a patch upstream, then backport it or wait
> for it to come to your distribution. While if there is a device tree
> specific quirk, you just read the spec of the device and applies it to
> your device tree and you are good to go.
>
> So no, I don't buy this. If hardware makers want to have fancy way of
> initializing their devices, we can cope with those, but I don't want to
> do the Device Tree job in a kernel module were you need to recompile it
> each time a new device appears.
>
>>
>> Now if you want to make 'hid-over-i2c' a fallback to 'wacom,w9013', I'm
>> fine with that.
>
> I agree to have some sort of quirks in the i2c-hid module, but
> definitively not a list of devices with a specific initialization
> sequence. Device Tree has also been introduced to remove the specific
> platform devices, and you are basically asking us to go back there,
> which I don't want.

That is not correct. DT does not abstract the h/w to hide
implementation details like ACPI does with AML code. We still have
specific platform drivers and always will. DT is about removing the
board files and describing connections between devices.

Rob
