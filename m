From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 1/2] Revert "HID: dragonrise: fix HID Descriptor for
 0x0006 PID"
Date: Thu, 6 Oct 2016 09:47:36 +0200
Message-ID: <20161006074736.GE19261@mail.corp.redhat.com>
References: <20160927184138.3009-1-adi@adirat.com>
 <8737kahj63.fsf@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbcJFHrl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Oct 2016 03:47:41 -0400
Content-Disposition: inline
In-Reply-To: <8737kahj63.fsf@ni.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ioan-Adrian Ratiu <adi@adirat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spbnick@gmail.com, vnaum@vnaum.com

On Oct 05 2016 or thereabouts, Ioan-Adrian Ratiu wrote:
> On Tue, 27 Sep 2016, Ioan-Adrian Ratiu <adi@adirat.com> wrote:
> > This reverts commit 18339f59c3a6 ("HID: dragonrise: fix HID...") because it
> > breaks certain dragonrise 0079:0006 gamepads. While it may fix a breakage
> > caused by commit 79346d620e9d ("HID: input: force generic axis to be mapped
> > to their user space axis"), it is probable that the manufacturer released
> > different hardware with the same PID so this fix works for only a subset
> > and breaks the other gamepads sharing the PID.
> >
> > What is needed is another more generic solution which fixes 79346d620e9d
> > ("HID: input: force generic axis ...") breakage for this controller: we
> > need to add an exception for this driver to make it keep the old behaviour
> > previous to the initial breakage (this is done in patch 2 of this series).
> >
> > Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>

For the series,
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

However, Jiri, I think it would be better applying first 2/2 and then
1/2 in order not having a commit that breaks the currently supported
0079:0006 version.

Cheers,
Benjamin

> 
> Ping?
> 
> Vladislav confirmed that this patch series also fixes the 0079:0011
> DragonRise gamepad, so everything is good. Any info about merging?
> 
> Thank you,
> Ionel
> 
> > ---
> >  drivers/hid/hid-dr.c | 58 ----------------------------------------------------
> >  1 file changed, 58 deletions(-)
> >
> > diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
> > index 8fd4bf7..2523f8a 100644
> > --- a/drivers/hid/hid-dr.c
> > +++ b/drivers/hid/hid-dr.c
> > @@ -234,58 +234,6 @@ static __u8 pid0011_rdesc_fixed[] = {
> >  	0xC0                /*  End Collection                  */
> >  };
> >  
> > -static __u8 pid0006_rdesc_fixed[] = {
> > -	0x05, 0x01,        /* Usage Page (Generic Desktop)	*/
> > -	0x09, 0x04,        /* Usage (Joystick)			*/
> > -	0xA1, 0x01,        /* Collection (Application)		*/
> > -	0xA1, 0x02,        /*   Collection (Logical)		*/
> > -	0x75, 0x08,        /*     Report Size (8)		*/
> > -	0x95, 0x05,        /*     Report Count (5)		*/
> > -	0x15, 0x00,        /*     Logical Minimum (0)		*/
> > -	0x26, 0xFF, 0x00,  /*     Logical Maximum (255)		*/
> > -	0x35, 0x00,        /*     Physical Minimum (0)		*/
> > -	0x46, 0xFF, 0x00,  /*     Physical Maximum (255)	*/
> > -	0x09, 0x30,        /*     Usage (X)			*/
> > -	0x09, 0x33,        /*     Usage (Ry)			*/
> > -	0x09, 0x32,        /*     Usage (Z)			*/
> > -	0x09, 0x31,        /*     Usage (Y)			*/
> > -	0x09, 0x34,        /*     Usage (Ry)			*/
> > -	0x81, 0x02,        /*     Input (Variable)		*/
> > -	0x75, 0x04,        /*     Report Size (4)		*/
> > -	0x95, 0x01,        /*     Report Count (1)		*/
> > -	0x25, 0x07,        /*     Logical Maximum (7)		*/
> > -	0x46, 0x3B, 0x01,  /*     Physical Maximum (315)	*/
> > -	0x65, 0x14,        /*     Unit (Centimeter)		*/
> > -	0x09, 0x39,        /*     Usage (Hat switch)		*/
> > -	0x81, 0x42,        /*     Input (Variable)		*/
> > -	0x65, 0x00,        /*     Unit (None)			*/
> > -	0x75, 0x01,        /*     Report Size (1)		*/
> > -	0x95, 0x0C,        /*     Report Count (12)		*/
> > -	0x25, 0x01,        /*     Logical Maximum (1)		*/
> > -	0x45, 0x01,        /*     Physical Maximum (1)		*/
> > -	0x05, 0x09,        /*     Usage Page (Button)		*/
> > -	0x19, 0x01,        /*     Usage Minimum (0x01)		*/
> > -	0x29, 0x0C,        /*     Usage Maximum (0x0C)		*/
> > -	0x81, 0x02,        /*     Input (Variable)		*/
> > -	0x06, 0x00, 0xFF,  /*     Usage Page (Vendor Defined)	*/
> > -	0x75, 0x01,        /*     Report Size (1)		*/
> > -	0x95, 0x08,        /*     Report Count (8)		*/
> > -	0x25, 0x01,        /*     Logical Maximum (1)		*/
> > -	0x45, 0x01,        /*     Physical Maximum (1)		*/
> > -	0x09, 0x01,        /*     Usage (0x01)			*/
> > -	0x81, 0x02,        /*     Input (Variable)		*/
> > -	0xC0,              /*   End Collection			*/
> > -	0xA1, 0x02,        /*   Collection (Logical)		*/
> > -	0x75, 0x08,        /*     Report Size (8)		*/
> > -	0x95, 0x07,        /*     Report Count (7)		*/
> > -	0x46, 0xFF, 0x00,  /*     Physical Maximum (255)	*/
> > -	0x26, 0xFF, 0x00,  /*     Logical Maximum (255)		*/
> > -	0x09, 0x02,        /*     Usage (0x02)			*/
> > -	0x91, 0x02,        /*     Output (Variable)		*/
> > -	0xC0,              /*   End Collection			*/
> > -	0xC0               /* End Collection			*/
> > -};
> > -
> >  static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> >  				unsigned int *rsize)
> >  {
> > @@ -296,12 +244,6 @@ static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> >  			*rsize = sizeof(pid0011_rdesc_fixed);
> >  		}
> >  		break;
> > -	case 0x0006:
> > -		if (*rsize == sizeof(pid0006_rdesc_fixed)) {
> > -			rdesc = pid0006_rdesc_fixed;
> > -			*rsize = sizeof(pid0006_rdesc_fixed);
> > -		}
> > -		break;
> >  	}
> >  	return rdesc;
> >  }
> > -- 
> > 2.10.0
