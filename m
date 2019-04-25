From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Date: Thu, 25 Apr 2019 01:19:48 -0700
Message-ID: <20190425081948.GB31301@innovation.ch>
References: <20190422031251.11968-1-ronald@innovation.ch>
 <20190422031251.11968-2-ronald@innovation.ch>
 <CAO-hwJLMZvBGheEtH_iU+mBtE4T3OsT6W+=1x-ewzGGP5Fxp4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJLMZvBGheEtH_iU+mBtE4T3OsT6W+=1x-ewzGGP5Fxp4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


  Hi Benjamin,

Thank you for looking at this.

On Wed, Apr 24, 2019 at 04:18:23PM +0200, Benjamin Tissoires wrote:
> On Mon, Apr 22, 2019 at 5:13 AM Ronald Tschalär <ronald@innovation.ch> wrote:
> >
> > The iBridge device provides access to several devices, including:
> > - the Touch Bar
> > - the iSight webcam
> > - the light sensor
> > - the fingerprint sensor
> >
> > This driver provides the core support for managing the iBridge device
> > and the access to the underlying devices. In particular, since the
> > functionality for the touch bar and light sensor is exposed via USB HID
> > interfaces, and the same HID device is used for multiple functions, this
> > driver provides a multiplexing layer that allows multiple HID drivers to
> > be registered for a given HID device. This allows the touch bar and ALS
> > driver to be separated out into their own modules.
>
> Sorry for coming late to the party, but IMO this series is far too
> complex for what you need.
> 
> As I read this and the first comment of drivers/mfd/apple-ibridge.c,
> you need to have a HID driver that multiplex 2 other sub drivers
> through one USB communication.
> For that, you are using MFD, platform driver and you own sauce instead
> of creating a bus.

Basically correct. To be a bit more precise, there are currently two
hid-devices and two drivers (touchbar and als) involved, with
connections as follows (pardon the ugly ascii art):

  hdev1  ---  tb-drv
           /
          /
         /
  hdev2  ---  als-drv

i.e. the touchbar driver talks to both hdev's, and hdev2's events
(reports) are processed by both drivers (though each handles different
reports).

> So, how about we reuse entirely the HID subsystem which already
> provides the capability you need (assuming I am correct above).
> hid-logitech-dj already does the same kind of stuff and you could:
> - create drivers/hid/hid-ibridge.c that handles USB_ID_PRODUCT_IBRIDGE
> - hid-ibridge will then register itself to the hid subsystem with a
> call to hid_hw_start(hdev, HID_CONNECT_HIDRAW) and
> hid_device_io_start(hdev) to enable the events (so you don't create
> useless input nodes for it)
> - then you add your 2 new devices by calling hid_allocate_device() and
> then hid_add_device(). You can even create a new HID group
> APPLE_IBRIDGE and allocate 2 new PIDs for them to distinguish them
> from the actual USB device.
> - then you have 2 brand new HID devices you can create their driver as
> a regular ones.
> 
> hid-ibridge.c would just need to behave like any other hid transport
> driver (see logi_dj_ll_driver in drivers/hid/hid-logitech-dj.c) and
> you can get rid of at least the MFD and the platform part of your
> drivers.
> 
> Does it makes sense or am I missing something obvious in the middle?

Yes, I think I understand, and I think this can work. Basically,
instead of demux'ing at the hid-driver level as I am doing now (i.e.
the iBridge hid-driver forwarding calls to the sub-hid-drivers), we
demux at the hid-device level (events forwarded from iBridge hdev to
all "virtual" sub-hdev's, and requests from sub-hdev's forwarded to
the original hdev via an iBridge ll_driver attached to the
sub-hdev's).

So I would need to create 3 new "virtual" hid-devices (instances) as
follows:

  hdev1  ---  vhdev1  ---  tb-drv
                        /
          --  vhdev2  --
         /
  hdev2  ---  vhdev3  ---  als-drv

(vhdev1 is probably not strictly necessary, but makes things more
consistent).

> I have one other comment below.
> 
> Note that I haven't read the whole series as I'd like to first get
> your feedback with my comment above.

Agreed: let's first get the overall strategy stabilized (also so I
can avoid having to rewrite the code too many more times ;-) ).

[snip]
> > +static __u8 *appleib_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> > +                                 unsigned int *rsize)
> > +{
> > +       /* Some fields have a size of 64 bits, which according to HID 1.11
> > +        * Section 8.4 is not valid ("An item field cannot span more than 4
> > +        * bytes in a report"). Furthermore, hid_field_extract() complains
> 
> this must have been fixed in 94a9992f7dbdfb28976b565af220e0c4a117144a
> which is part of v5.1, so not sure you actually need the report
> descriptor fixup at all.

Wasn't aware of this change - thanks. Yes, with that the warning
message should be gone and this fixup can be avoided.

One thing I find strange, though, is that while 94a9992f7dbd changes
the condition at which the warning is emitted, it still truncates the
value to 32 bits, albeit completely silently now for lengths between
32 and 256 bits. I.e. I'm somewhat surprised that hid_field_extract()
(and __extract() ) weren't updated to actually return the full values
for longer fields. Either that, or the callers of hid_field_extract()
changed to read longer fields in 32 bit chunks.


  Cheers,

  Ronald
