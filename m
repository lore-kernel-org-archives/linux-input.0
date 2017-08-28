From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Mon, 28 Aug 2017 09:31:31 -0700
Message-ID: <20170828163131.GA12195@dtor-ws>
References: <20170722185537.12696-1-hdegoede@redhat.com>
 <20170722185537.12696-2-hdegoede@redhat.com>
 <20170817193912.hccxyjwstrtr5oiv@ninjato>
 <CAKdAkRQjhE3WRkcWrZtYzxtMs+dy718JTYWjzELBEDRoVY_qWw@mail.gmail.com>
 <5093164f-72a5-1217-a2b5-52e0a6d9a9d1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5093164f-72a5-1217-a2b5-52e0a6d9a9d1@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Hans,

On Mon, Aug 28, 2017 at 03:04:04PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 18-08-17 00:15, Dmitry Torokhov wrote:
> >On Thu, Aug 17, 2017 at 12:39 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >>Hey guys,
> >>
> >>Sorry, I don't understand some of the stuff here. But I'd like to
> >>understand it before I add something to the I2C core. Especially as it
> >>feels a bit a the edge of the driver model to me.
> >>
> >>On Sat, Jul 22, 2017 at 08:55:37PM +0200, Hans de Goede wrote:
> >>>The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID compatible,
> >>>it uses its own protocol which is handled by the chipone_icn8318 driver.
> >>>
> >>>If the i2c_hid_driver's probe functon gets called it will fail with a
> >>>"hid_descr_cmd failed" error.
> >>
> >>That sounds like it fails pretty late. I'd assume we could check the
> >>blacklist right at the beginning of probe and bail out immediately?
> >>
> >>>Worse, after the probe failure the i2c / ACPI core code will put the ACPI
> >>>device in D3 state
> >
> >So I guess this will also happen if I unbind/rebind chipone_icn8318 driver?
> 
> No because on probe the chipone_icn8318 driver does (with the patches
> I've pending) :
> 
>     struct acpi_device *adev;
> 
>     adev = ACPI_COMPANION(dev);
> 
>     /*
>      * Disable ACPI power management the _PS3 method is empty, so
>      * there is no powersaving when using ACPI power management.
>      * The _PS0 method resets the controller causing it to loose its
>      * firmware, which has been loaded by the BIOS and we do not
>      * know how to restore the firmware.
>      */
>     adev->flags.power_manageable = 0;
> 
> So it disables ACPI pm for the device, keeping the controller in D0 so that
> it will never loose its firmware.
> 
> 
> >>Where does that happen? Sorry, I can't find it. Would it be an idea to
> >>add a flag somewhere telling the device should not be put into D3? That
> >>would be way more generic in case this happens outside I2C world, or?
> >>Disclaimer: I am brainstorming here, don't know super much about ACPI.
> >>
> >>>This commit adds a match callback and returns -ENODEV for i2c_client-s
> >>>with a CHPN0001 ACPI device id, so that the probe function never gets
> >>>called, fixing the controller losing its firmware.
> >>
> >>Do you know if something like a match-callback exists somewhere else in
> >>the kernel?
> >
> >Having blacklist means that we are failing at design somewhere...
> >
> >In this case what we have is wrong ACPI table. Instead of adding hooks
> >to i2c core can we fix it (DSDT) up? I know people do not like it, but
> >I'd say this is task for yet another platform driver to adjust ACPI
> >properties (kill the wrong _CID, disable PS0) before instantiating the
> >device.
> 
> I don't think that is going to fly. Certainly DSDT patching is out of the
> question, we could modify the acpi_dev after enumeration, but that is not
> going to be pretty. This is going to be drivers/platform/x86/silead_dmi.c
> all over again, but where that made sense as to decouple the board-info
> from the driver this case is different as we are not talking board
> specific behavior here, but device specific so this really belongs in the
> drivers IMHO, also the reception of silead_dmi.c has not been 100% positive.

No, this is definitely board-specific as well. This is a brain dead
firmware on a particular board that declares PS0 and wrong CID. The
device itself can be made working perfectly well in another box.

I think I also mentioned before that encoding particular platform
behavior in the device driver is not the best option.

I understand that nobody likes silead_dmi as it is nasty (as it shoudl
be, it fixes missing/wrong data suplied by the platform), but I think
the main objection is that we had to make it built-in. I wonder if we
could work on making it usable as a module, by having driver core try
loading "<device-alias>-quirk" module before doing probes so that quirk
is guaranteed to be available?

> 
> I don't think the blacklist entry in i2c-hid is a problem per se, we've
> similar issues with USB devices where they claim a generic class but need
> a specific driver and we typically solve that with a blacklist for the
> specific vid:pid in the class driver.

Yes, you do that for a particular _device_. You move this device to a
brand new box and you still need the same quirk. Here it is the box that
is deficient.

> 
> The nastiness here is not the blacklist, but the pm issues when the wrong
> driver gets its probe() method called first.

BTW, how do we order probing? Should we try matching on _HID before
trying _CID?

Thanks.

-- 
Dmitry
