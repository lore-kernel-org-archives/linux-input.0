From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: multitouch: Support Asus T304UA media keys
Date: Wed, 2 Aug 2017 14:16:07 +0200
Message-ID: <20170802121607.GA13659@mail.corp.redhat.com>
References: <20170724212225.3426-1-jprvita@endlessm.com>
 <20170724212225.3426-3-jprvita@endlessm.com>
 <alpine.LSU.2.20.1708021126550.30597@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753117AbdHBMQP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 2 Aug 2017 08:16:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1708021126550.30597@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: =?utf-8?B?Sm/Do28=?= Paulo Rechi Vita <jprvita@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux@endlessm.com, =?utf-8?B?Sm/Do28=?= Paulo Rechi Vita <jprvita@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Aug 02 2017 or thereabouts, Jiri Kosina wrote:
> On Mon, 24 Jul 2017, João Paulo Rechi Vita wrote:
> 
> > The Asus T304UA convertible sports a magnetic detachable keyboard with
> > touchpad, which is connected over USB. Most of the keyboard hotkeys are
> > exposed through the same USB interface as the touchpad, defined in the
> > report descriptor as follows:
> > 
> > 0x06, 0x31, 0xFF,  // Usage Page (Vendor Defined 0xFF31)
> > 0x09, 0x76,        // Usage (0x76)
> > 0xA1, 0x01,        // Collection (Application)
> > 0x05, 0xFF,        //   Usage Page (Reserved 0xFF)
> > 0x85, 0x5A,        //   Report ID (90)
> > 0x19, 0x00,        //   Usage Minimum (0x00)
> > 0x2A, 0xFF, 0x00,  //   Usage Maximum (0xFF)
> > 0x15, 0x00,        //   Logical Minimum (0)
> > 0x26, 0xFF, 0x00,  //   Logical Maximum (255)
> > 0x75, 0x08,        //   Report Size (8)
> > 0x95, 0x0F,        //   Report Count (15)
> > 0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
> > 0x05, 0xFF,        //   Usage Page (Reserved 0xFF)
> > 0x85, 0x5A,        //   Report ID (90)
> > 0x19, 0x00,        //   Usage Minimum (0x00)
> > 0x2A, 0xFF, 0x00,  //   Usage Maximum (0xFF)
> > 0x15, 0x00,        //   Logical Minimum (0)
> > 0x26, 0xFF, 0x00,  //   Logical Maximum (255)
> > 0x75, 0x08,        //   Report Size (8)
> > 0x95, 0x02,        //   Report Count (2)
> > 0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
> > 0xC0,              // End Collection
> > 
> > This UsagePage is declared as a variable, but we need to treat it as an
> > array to be able to map each Usage we care about to its corresponding
> > input key.
> > 
> > Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
> > ---
> >  drivers/hid/hid-ids.h        |  1 +
> >  drivers/hid/hid-multitouch.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/hid.h          |  2 ++
> >  3 files changed, 46 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 3d911bfd91cf..6b7f9707076e 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -176,6 +176,7 @@
> >  #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
> >  #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
> >  #define USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD	0x17e0
> > +#define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
> >  #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
> >  #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
> >  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> > index 152d33120a55..6b3de7b01571 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -72,6 +72,7 @@ MODULE_LICENSE("GPL");
> >  #define MT_QUIRK_FIX_CONST_CONTACT_ID	BIT(14)
> >  #define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
> >  #define MT_QUIRK_STICKY_FINGERS		BIT(16)
> > +#define MT_QUIRK_ASUS_CUSTOM_UP		BIT(17)
> >  
> >  #define MT_INPUTMODE_TOUCHSCREEN	0x02
> >  #define MT_INPUTMODE_TOUCHPAD		0x03
> > @@ -169,6 +170,7 @@ static void mt_post_parse(struct mt_device *td);
> >  #define MT_CLS_GENERALTOUCH_TWOFINGERS		0x0108
> >  #define MT_CLS_GENERALTOUCH_PWT_TENFINGERS	0x0109
> >  #define MT_CLS_LG				0x010a
> > +#define MT_CLS_ASUS				0x010b
> >  #define MT_CLS_VTL				0x0110
> >  #define MT_CLS_GOOGLE				0x0111
> >  
> > @@ -290,6 +292,10 @@ static struct mt_class mt_classes[] = {
> >  			MT_QUIRK_IGNORE_DUPLICATES |
> >  			MT_QUIRK_HOVERING |
> >  			MT_QUIRK_CONTACT_CNT_ACCURATE },
> > +	{ .name = MT_CLS_ASUS,
> > +		.quirks = MT_QUIRK_ALWAYS_VALID |
> > +			MT_QUIRK_CONTACT_CNT_ACCURATE |
> > +			MT_QUIRK_ASUS_CUSTOM_UP },
> >  	{ .name = MT_CLS_VTL,
> >  		.quirks = MT_QUIRK_ALWAYS_VALID |
> >  			MT_QUIRK_CONTACT_CNT_ACCURATE |
> > @@ -905,6 +911,8 @@ static int mt_touch_input_configured(struct hid_device *hdev,
> >  	return 0;
> >  }
> >  
> > +#define mt_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, \
> > +						    max, EV_KEY, (c))
> >  static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> >  		struct hid_field *field, struct hid_usage *usage,
> >  		unsigned long **bit, int *max)
> > @@ -923,10 +931,35 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> >  	    field->application != HID_DG_TOUCHPAD &&
> >  	    field->application != HID_GD_KEYBOARD &&
> >  	    field->application != HID_CP_CONSUMER_CONTROL &&
> > -	    field->application != HID_GD_WIRELESS_RADIO_CTLS)
> > +	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
> > +	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
> > +	      td->mtclass.quirks & MT_QUIRK_ASUS_CUSTOM_UP))
> >  		return -1;
> >  
> >  	/*
> > +	 * Some Asus keyboard+touchpad devices have the hotkeys defined in the
> > +	 * touchpad report descriptor. We need to treat these as an array to
> > +	 * map usages to input keys.
> > +	 */
> > +	if (field->application == 0xff310076 &&
> 
> Could you please follow the convention and define a symbolic constant for 
> this as well?
> 
> Otherwise the patch looks OK to me, so after this minor nit is fixed, I'll 
> be queuing it for 4.14 unless Benjamin raises any objections.
> 

Sorry for the delay. I was at GUADEC the whole past week and couldn't
get much kernel work done. I was thinking a little bit about this
series though. Patch 1 is fine, but patch 2 is a little bit more of an
issue.
Ideally, I'd like to keep hid-multitouch from having too many vendor
specific code, but it looks like this is the easier way to handle things
here.

I guess the proper way of solving this situation would be to merge the
generic windows 8 code from hid-multitouch into hid-input so that other
drivers can benefit from it, but this is going to be a lot of work and
-ETIME.

Jiri, I wouldn't scream too loud if you merge this, so do as you want :)

Cheers,
Benjamin

> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
