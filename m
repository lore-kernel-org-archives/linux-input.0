From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID:i2c-hid: add a simple quirk to fix device defects
Date: Wed, 9 Nov 2016 09:25:03 +0100
Message-ID: <20161109082503.GC10327@mail.corp.redhat.com>
References: <1478594599-25044-1-git-send-email-hn.chen@weidahitech.com>
 <20161108093803.GD6689@mail.corp.redhat.com>
 <22498D53301C4D4A8FFA8F02C7C3C7C06DDE7593@mail02.WHT.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbcKIIZJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 9 Nov 2016 03:25:09 -0500
Content-Disposition: inline
In-Reply-To: <22498D53301C4D4A8FFA8F02C7C3C7C06DDE7593@mail02.WHT.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: "jkosina@suse.cz" <jkosina@suse.cz>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Nov 09 2016 or thereabouts, Hn Chen wrote:
> Hi Benjamin,
> 
> Ok, I will add a static quirk table and lookup for the quirks in i2c_hid_probe().
> 
> About the return value after send the PWR_ON command, it should be failed in weida's case.
> The oscillator of the controller will be gated in the deep sleep mode and 
> the controller will be active after the first command but there is no any feedback.
> So should I check the failed return value here ? Or I should check if it is ok and then just return ?

Maybe just add a comment above saying that this is expected to fail on
some devices, so there is no point in checking the return value here.

Cheers,
Benjamin

> 
> Hn.chen
> 
> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com] 
> Sent: Tuesday, November 08, 2016 5:38 PM
> To: Hn Chen
> Cc: jkosina@suse.cz; dmitry.torokhov@gmail.com; linux-input@vger.kernel.org
> Subject: Re: [PATCH] HID:i2c-hid: add a simple quirk to fix device defects
> 
> On Nov 08 2016 or thereabouts, hn.chen@weidahitech.com wrote:
> > From: HungNien Chen <hn.chen@weidahitech.com>
> > 
> > Weida's device can get a quirk value by the quirk function.
> > Base on the quirk value, set_power function will send a command to 
> > wake up the device before send the PWR_ON command.
> > 
> > Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
> > ---
> >  drivers/hid/hid-ids.h         |  5 +++++
> >  drivers/hid/i2c-hid/i2c-hid.c | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h index 
> > 6cfb5ca..787afdf 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -1033,6 +1033,11 @@
> >  #define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH	0x0500
> >  #define USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET	0x0502
> >  
> > +#define	USB_VENDOR_ID_WEIDA		0x2575
> > +#define	USB_DEVICE_ID_WEIDA_8756	0x8756
> > +#define	USB_DEVICE_ID_WEIDA_8752	0xC300
> > +#define	USB_DEVICE_ID_WEIDA_8755	0xC301
> > +
> >  #define USB_VENDOR_ID_WISEGROUP		0x0925
> >  #define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
> >  #define USB_DEVICE_ID_SUPER_JOY_BOX_3	0x8888
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c 
> > b/drivers/hid/i2c-hid/i2c-hid.c index b3ec4f2..7a9b100 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -41,6 +41,11 @@
> >  
> >  #include <linux/i2c/i2c-hid.h>
> >  
> > +#include "../hid-ids.h"
> > +
> > +/* quirks to control the device */
> > +#define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	(1 << 0)
> > +
> >  /* flags */
> >  #define I2C_HID_STARTED		0
> >  #define I2C_HID_RESET_PENDING	1
> > @@ -143,6 +148,7 @@ struct i2c_hid {
> >  	char			*argsbuf;	/* Command arguments buffer */
> >  
> >  	unsigned long		flags;		/* device flags */
> > +	unsigned long		quirks;		/* Various quirks */
> >  
> >  	wait_queue_head_t	wait;		/* For waiting the interrupt */
> >  	struct gpio_desc	*desc;
> > @@ -154,6 +160,25 @@ struct i2c_hid {
> >  	struct mutex		reset_lock;
> >  };
> >  
> > +/*
> > + * i2c_hid_lookup_quirk: return any quirks associated with a I2C HID 
> > +device
> > + * @idVendor: the 16-bit vendor ID
> > + * @idProduct: the 16-bit product ID
> > + *
> > + * Returns: a u32 quirks value.
> > + */
> > +static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 
> > +idProduct) {
> > +	u32 quirks = 0;
> > +
> > +	/* Weida devices check here */
> > +	if (idVendor == USB_VENDOR_ID_WEIDA &&
> > +	    idProduct >= USB_DEVICE_ID_WEIDA_8752)
> 
> Wouldn't it make more sense to have a static table of the affected products, instead of this test?
> 
> > +		return I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV;
> > +
> > +	return quirks;
> > +}
> > +
> >  static int __i2c_hid_command(struct i2c_client *client,
> >  		const struct i2c_hid_cmd *command, u8 reportID,
> >  		u8 reportType, u8 *args, int args_len, @@ -346,6 +371,11 @@ static 
> > int i2c_hid_set_power(struct i2c_client *client, int power_state)
> >  
> >  	i2c_hid_dbg(ihid, "%s\n", __func__);
> >  
> > +	/* Some devices require to send a command to wakeup first */
> > +	if (power_state == I2C_HID_PWR_ON &&
> > +	    ihid->quirks & I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV)
> > +		i2c_hid_command(client, &hid_set_power_cmd, NULL, 0);
> 
> Isn't there a need to check the return value here?
> 
> > +
> >  	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
> >  		0, NULL, 0, NULL, 0);
> >  	if (ret)
> > @@ -661,6 +691,8 @@ static int i2c_hid_parse(struct hid_device *hid)
> >  
> >  	i2c_hid_dbg(ihid, "entering %s\n", __func__);
> >  
> > +	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
> 
> Please lookup for the quirks in i2c_hid_probe(), right after we set version, vendor and product
> 
> > +
> >  	rsize = le16_to_cpu(hdesc->wReportDescLength);
> >  	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
> >  		dbg_hid("weird size of report descriptor (%u)\n", rsize);
> > --
> > 1.9.1
> > 
> 
> Cheers,
> Benjamin
> 
