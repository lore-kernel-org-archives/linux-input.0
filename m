From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] HID: Add quirk for Lenovo Yoga 910 with ITE Chips
Date: Sat, 15 Jul 2017 19:58:10 +0200
Message-ID: <1500141490.2490.1.camel@hadess.net>
References: <20170715122721.6908-1-ctx.xda@gmail.com>
         <1500128998.2468.1.camel@hadess.net>
         <CAA7d1im1hxM13SrsF5pQsJmtugjT2CJZnJdmbC2KxL5_QPXd_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48839 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdGOR6S (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 15 Jul 2017 13:58:18 -0400
In-Reply-To: <CAA7d1im1hxM13SrsF5pQsJmtugjT2CJZnJdmbC2KxL5_QPXd_Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Patrick Pedersen <ctx.xda@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, jic23@kernel.org, srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org

On Sat, 2017-07-15 at 19:52 +0200, Patrick Pedersen wrote:
> On Sat, Jul 15, 2017 at 4:29 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Sat, 2017-07-15 at 14:27 +0200, Patrick Pedersen wrote:
> > > As with previous generations of this device (see https://patchwor
> > k.ke
> > > rnel.org/patch/7887361/), the ITE
> > > HID Sensor Hub, responsible for the accelerometer and als sensor,
> > > requires a quirk entry.
> > >
> > > Without the entry, the Sensor Hub can't be accessed and the
> > kernel
> > > fails to report any movements. As a result
> > > iio-sensor-proxy receives no new data.
> > >
> > > It shall additionally be noted that the i2c-hid 'sleep' bug
> > (present
> > > since kernel ver. 4.3)
> > > still affects the driver. This means that the sensor hub will not
> > > report any movement, until
> > > the device is suspended and resumed.
> > >
> > > Signed-off-by: Patrick Pedersen <ctx.xda@gmail.com>
> > > ---
> > >  drivers/hid/hid-ids.h        | 1 +
> > >  drivers/hid/hid-sensor-hub.c | 3 +++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > index 4f9a3938189a..b427a0bcfbe8 100644
> > > --- a/drivers/hid/hid-ids.h
> > > +++ b/drivers/hid/hid-ids.h
> > > @@ -565,6 +565,7 @@
> > >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
> > >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
> > >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA900     0x8396
> > > +#define USB_DEVICE_ID_ITE_LENOVO_YOGA910     0x8186
> > >
> > >  #define USB_VENDOR_ID_JABRA          0x0b0e
> > >  #define USB_DEVICE_ID_JABRA_SPEAK_410        0x0412
> > > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-
> > sensor-
> > > hub.c
> > > index 4ef73374a8f9..85b8425483bd 100644
> > > --- a/drivers/hid/hid-sensor-hub.c
> > > +++ b/drivers/hid/hid-sensor-hub.c
> > > @@ -820,6 +820,9 @@ static const struct hid_device_id
> > > sensor_hub_devices[] = {
> > >       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > USB_VENDOR_ID_ITE,
> > >                       USB_DEVICE_ID_ITE_LENOVO_YOGA900),
> > >                       .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > > +     { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > USB_VENDOR_ID_ITE,
> > > +                     USB_DEVICE_ID_ITE_LENOVO_YOGA910),
> > > +                     .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > >       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > USB_VENDOR_ID_INTEL_0,
> > >                       0x22D8),
> > >                       .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > 
> > At this point, wouldn't it make sense to apply the quirk to *all*
> > ITE
> > devices in Lenovo Yoga laptops?
> 
> I'm not sure If I got your suggestion right.
> 
> Those laptops do not share the same ITE chip. ITE is simply 
> the vendor/manufacturer of the hid sensor hub. All three defined 
> yoga laptops use a different ITE sensor hub model.
> 
> To make this clear, my device, the 
> Lenovo Yoga 910 uses a ITE8186, 
> where the Yoga 900 uses a ITE8396, 
> the Yoga 2 a ITE8350 and so on
> 
> Now what "could" me done, is to detect and set the quirk
> automatically. 
> This should be doable, as the Hardware PID corresponds to the 
> model number of the Sensor Hub (ex. ITE8186 = PID 0x8186)

I'm saying that if the vendor of the device is USB_VENDOR_ID_ITE and
the manufacturer of the hardware is Lenovo in the DMI information, and
the model of hardware contains "Yoga", that HID_SENSOR_HUB_ENUM_QUIRK
be applied automatically, instead of adding quirks one-by-one.
