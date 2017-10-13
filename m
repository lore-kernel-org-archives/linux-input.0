From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: joydev - blacklist ds3/ds4/udraw motion
 sensors
Date: Fri, 13 Oct 2017 16:50:44 -0700
Message-ID: <20171013235044.thyp7bajww7j62pr@dtor-ws>
References: <20171006010333.61496-1-roderick@gaikai.com>
 <20171006010333.61496-2-roderick@gaikai.com>
 <20171007184453.GB14355@dtor-ws>
 <1DD62093774CEE42AFC16E785A1088049E200451@USCULXMSG13.am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:54771 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753252AbdJMXur (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 19:50:47 -0400
Content-Disposition: inline
In-Reply-To: <1DD62093774CEE42AFC16E785A1088049E200451@USCULXMSG13.am.sony.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Cc: "roderick@gaikai.com" <roderick@gaikai.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Hi Roderick,

On Wed, Oct 11, 2017 at 12:53:53AM +0000, Colenbrander, Roelof wrote:
> Hi Dmitry,
> 
> Thanks for your suggestions the feedback looks good. Just got back to office after a long weekend, then was surprised to see you already made a few changes to the series. The changes look. Thanks for the assistance!
> 

OK, if that works for you then I will queue it up.

Thanks.

> Thanks,
> Roderick
> ________________________________________
> From: Dmitry Torokhov [dmitry.torokhov@gmail.com]
> Sent: Saturday, October 07, 2017 11:44 AM
> To: roderick@gaikai.com
> Cc: linux-input@vger.kernel.org; Benjamin Tissoires; Jiri Kosina; Colenbrander, Roelof; stable@vger.kernel.org
> Subject: Re: [PATCH 1/1] Input: joydev - blacklist ds3/ds4/udraw motion sensors
> 
> Hi Roderick,
> 
> On Thu, Oct 05, 2017 at 06:03:33PM -0700, Roderick Colenbrander wrote:
> > From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> >
> > Introduce a device table used for blacklisting devices. We currently
> > blacklist the motion sensor subdevice of THQ Udraw and Sony ds3/ds4.
> >
> > Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/input/joydev.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> > index 29d677c714d2..e2a0f63d5656 100644
> > --- a/drivers/input/joydev.c
> > +++ b/drivers/input/joydev.c
> > @@ -70,6 +70,40 @@ struct joydev_client {
> >       struct list_head node;
> >  };
> >
> > +/* These codes are copied from from hid-ids.h, unfortunately there is no common
> > + * usb_ids/bt_ids.h header.
> > + */
> > +#define USB_VENDOR_ID_SONY 0x54c
> > +#define USB_VENDOR_ID_THQ            0x20d6
> > +#define USB_DEVICE_ID_SONY_PS3_CONTROLLER    0x0268
> > +#define USB_DEVICE_ID_SONY_PS4_CONTROLLER    0x05c4
> > +#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2  0x09cc
> > +#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE     0x0ba0
> > +#define USB_DEVICE_ID_THQ_PS3_UDRAW  0xcb17
> > +
> > +/* List of devices blacklisted from joydev. A reason for blacklisting a
> > + * device is to support (legacy) software supporting joydev, but which will
> > + * never get updated to support these devices or features. An example would
> > + * be handling of motion sensors, which these applications could not handle
> > + * resulting in undefined behavior.
> > + */
> > +static const struct joydev_blacklist {
> > +     __u16 bustype;
> > +     __u16 vendor;
> > +     __u16 product;
> > +     unsigned long propbit; /* Allow for filtering based on device properties. */
> > +} joydev_blacklist[] = {
> > +     { BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER, BIT(INPUT_PROP_ACCELEROMETER) },
> > +     { BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER, BIT(INPUT_PROP_ACCELEROMETER) },
> > +     { BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2, BIT(INPUT_PROP_ACCELEROMETER) },
> > +     { BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER, BIT(INPUT_PROP_ACCELEROMETER) },
> > +     { BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER, BIT(INPUT_PROP_ACCELEROMETER) },
> > +     { BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2, BIT(INPUT_PROP_ACCELEROMETER) },
> > +     { BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE, BIT(INPUT_PROP_ACCELEROMETER) },
> > +     { BUS_USB, USB_VENDOR_ID_THQ, USB_DEVICE_ID_THQ_PS3_UDRAW, BIT(INPUT_PROP_ACCELEROMETER) },
> > +     { 0, 0, 0, 0}
> 
> I would assume that regardless of connection (USB, BT, SPI, I2C, the
> accelerometer in PS4 controller should not be handled by joydev.  I
> wonder if we should not factor out input device id matching from
> input_match_device(), add propbit handling to input device id and use it
> here? Then your blacklist would be:
> 
> #define ACCEL_DEV(vendor, product)                              \
>         {                                                               \
>                 .flags          = INPUT_DEVICE_ID_MATCH_VENDOR |        \
>                                         INPUT_DEVICE_ID_MATCH_PRODUCT | \
>                                         INPUT_DEVICE_ID_MATCH_PROPBIT,  \
>                 .vendor         = (vendor),                             \
>                 .product        = (product),                            \
>                 .propbit[0]     = BIT(INPUT_PROP_ACCELEROMETER),        \
>         }
> 
> static const struct input_device_id joydev_blacklist {
>         ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
>         ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
>         ...
>         { }
> };
> 
> > +};
> > +
> >  static int joydev_correct(int value, struct js_corr *corr)
> >  {
> >       switch (corr->type) {
> > @@ -805,6 +839,25 @@ static bool joydev_dev_is_absolute_mouse(struct input_dev *dev)
> >       return true;
> >  }
> >
> > +
> > +static bool joydev_dev_is_blacklisted(struct input_dev *dev)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; joydev_blacklist[i].vendor; i++) {
> > +             if (dev->id.bustype == joydev_blacklist[i].bustype &&
> > +                 dev->id.vendor == joydev_blacklist[i].vendor &&
> > +                 dev->id.product == joydev_blacklist[i].product &&
> > +                 dev->propbit[0] == joydev_blacklist[i].propbit)
> 
> You probably want "&" and not strict match?
> 
> > +             {
> > +                     dev_info(&dev->dev, "joydev: Blacklisting '%s'\n", dev->name);
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
> >  {
> >       /* Avoid touchpads and touchscreens */
> > @@ -819,6 +872,10 @@ static bool joydev_match(struct input_handler *handler, struct input_dev *dev)
> >       if (joydev_dev_is_absolute_mouse(dev))
> >               return false;
> >
> > +     /* Disable blacklisted devices */
> > +     if (joydev_dev_is_blacklisted(dev))
> > +             return false;
> > +
> >       return true;
> >  }
> >
> > --
> > 2.13.6
> >
> 
> Thanks.
> 
> --
> Dmitry
> 

-- 
Dmitry
