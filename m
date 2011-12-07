From: aaron_tian@pixart.com.tw
Subject: =?Big5?B?pl6rSKFHIFJlOiBbUEFUQ0hdIElucHV0OiBoaWQtbXVsdGl0b3VjaC0=?=
 =?Big5?B?IHN1cHBvcnQgUGl4QXJ0IG9wdGljYWwgdG91Y2ggc2NyZWVu?=
Date: Wed, 7 Dec 2011 15:44:03 +0800
Message-ID: <OFB3AC2F13.ACC2B517-ON4825795F.002A6116-4825795F.002A7C2F@pixart.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.pixart.com.tw ([210.202.126.7]:35391 "HELO mg.pixart.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753283Ab1LGHoT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Dec 2011 02:44:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: aaron_tian@pixart.com.tw, dmitry.torokhov@gmail.com, JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-input-owner@vger.kernel.org

Hi Benjamin and JJ,

Thanks for your advises, I will use new class MT_CLS_INRANGE_CONTACTNUMBER 

which remove the .maxcontact field for the device.

And I will check my patch before submitting.


br,
Aaron


> Hi Aaron,
> 
> on top of JJ's comments:
> 
> On Tue, Dec 6, 2011 at 12:27, JJ Ding <jj_ding@xxxxxxxxxx> wrote:
>> Hi Aaron,
>>
>> I can't apply your patch. Your MUA seems to wrap the mail. Maybe you
>> want to use "git send-email" instead.
>>
>> Btw, the fisrt part of the mail should be your commit message. You can
>> put your explanation below the "---" line. And hid drivers are
>> maintained by Jiri Kosina <jkosina@xxxxxxx>, you might also CC Jiri 
next
>> time.
>>
>> Thanks.
>>
>> br,
>> jj
>>
>> On Tue, 6 Dec 2011 18:12:19 +0800, aaron_tian@xxxxxxxxxxxxx wrote:
>> > From: Aaron Tian <aaron_tian@xxxxxxxxxxxxx>
>> >
>> > Hello,
>> >
>> > This ia Aaron Tian in Pixart. We have modified the hid-multitouch 
driver
>> > for
>> > supporting PixArt optical touch screen and it works well. Because of 
the
>> > device
>> > does not have to set initial report, we apply 
"HID_QUIRK_NO_INIT_REPORTS"
>> > quirk and add the device into hid_blacklist in
>> > drivers/hid/usbhid/hid-quirks.c
>> >
>> > The patch is according to commit 
45e713efe2fa574b6662e7fb63fae9497c5e03d4
>> > of
>> > Linux mainline git (3.2.0-rc4+)
>> >
>> >
>> > Signed-off-by: Aaron Tian <aaron_tian@xxxxxxxxxxxxx>
>> > ---
>>
>>
>> >  drivers/hid/Kconfig             |    1 +
>> >  drivers/hid/hid-core.c          |    1 +
>> >  drivers/hid/hid-ids.h           |    3 +++
>> >  drivers/hid/hid-multitouch.c    |    5 +++++
>> >  drivers/hid/usbhid/hid-quirks.c |    1 +
>> >  5 files changed, 11 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> > index 22a4a05..eda54b6 100644
>> > --- a/drivers/hid/Kconfig
>> > +++ b/drivers/hid/Kconfig
>> > @@ -349,6 +349,7 @@ config HID_MULTITOUCH
>> >           - Lumio CrystalTouch panels
>> >           - MosArt dual-touch panels
>> >           - PenMount dual touch panels
>> > +         - PixArt optical touch screen
>> >           - Pixcir dual touch panels
>> >           - eGalax dual-touch panels, including the Joojoo and Wetab
>> > tablets
>> >           - Stantum multitouch panels
>> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> > index af35384..e9280ef 100644
>> > --- a/drivers/hid/hid-core.c
>> > +++ b/drivers/hid/hid-core.c
>> > @@ -1498,6 +1498,7 @@ static const struct hid_device_id
>> > hid_have_special_driver[] = {
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, 
USB_DEVICE_ID_ORTEK_WKB2000)
>> > },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT,
>> > USB_DEVICE_ID_PENMOUNT_PCI) },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX,
>> > USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>> > +       { HID_USB_DEVICE(USB_VENDOR_TYPE_PIXART,
>> > USB_DEVICE_TYPE_PIXART_OPTICAL_TOUCH_SCREEN) },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX,
>> > USB_DEVICE_ID_PRIMAX_KEYBOARD) },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
>> > USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
>> >         { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
>> > USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },
>> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> > index 4a441a6..869911b 100644
>> > --- a/drivers/hid/hid-ids.h
>> > +++ b/drivers/hid/hid-ids.h
>> > @@ -571,6 +571,9 @@
>> >  #define USB_VENDOR_ID_PI_ENGINEERING   0x05f3
>> >  #define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL 0xff
>> >
>> > +#define USB_VENDOR_TYPE_PIXART                         0x093a
>> > +#define USB_DEVICE_TYPE_PIXART_OPTICAL_TOUCH_SCREEN    0x8001
> 
> Please change _TYPE_ by _ID_ in both line to be consistent with other 
#define.
> 
>> > +
>> >  #define USB_VENDOR_ID_PLAYDOTCOM       0x0b43
>> >  #define USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII     0x0003
>> >
>> > diff --git a/drivers/hid/hid-multitouch.c 
b/drivers/hid/hid-multitouch.c
>> > index f1c909f..2f338b1 100644
>> > --- a/drivers/hid/hid-multitouch.c
>> > +++ b/drivers/hid/hid-multitouch.c
>> > @@ -722,6 +722,11 @@ static const struct hid_device_id mt_devices[] = 
{
>> >                 HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT,
>> >                         USB_DEVICE_ID_PENMOUNT_PCI) },
>> >
>> > +       /* PixArt optical touch screen */
>> > +       { .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
>> > +               HID_USB_DEVICE(USB_VENDOR_ID_PIXART,
>> > +                       USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN) },
>> > +
> 
> Do you __really__ need the DUAL here?
> I know that the  MT_CLS_INRANGE_CONTACTNUMBER class does not exist,
> but if your company does not intend to do only dual touch screen, it
> may be better to remove the .maxcontact field (i.e. create
> MT_CLS_INRANGE_CONTACTNUMBER).
> We had the problem with eGalax devices recently: they were reported as
> dual touches by the kernel whereas some of them were 4 touches.
> 
> Despite the line wrapping and this comment, the patch looks good.
> 
> Cheers,
> Benjamin
> 
>> >         /* PixCir-based panels */
>> >         { .driver_data = MT_CLS_DUAL_INRANGE_CONTACTID,
>> >                 HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
