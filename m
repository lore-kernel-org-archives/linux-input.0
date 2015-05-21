From: Alan Wu <alan.c.wu@gmail.com>
Subject: Re: [PATCH] hid: Add secondary vendor id for the marco, USB_DEVICE_ID_MS_TYPE_COVER_3_V2
Date: Wed, 20 May 2015 19:40:45 -0700
Message-ID: <CABkLPOLdQwjWfY4=dVrDmVRnaSDmfUb8+X8UK0xghg6+q3Aj7w@mail.gmail.com>
References: <1432138645-11540-1-git-send-email-xerofoify@gmail.com>
	<alpine.LNX.2.00.1505210129060.8186@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1505210129060.8186@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Nicholas Krause <xerofoify@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Jiri,
  I believe the patch may work, but I would rename the IDs.  Obviously
I can't test Surface 3 non-Pro cover, but the difference is likely due
to the following:

This is 0x07dc (I do own)
http://www.microsoftstore.com/store/msusa/en_US/pdp/Surface-Pro-Type-Cover/productID.300193600

This is 0x07de (I do not own)
http://www.microsoftstore.com/store/msusa/en_US/pdp/Surface-3-Type-Cover/productID.314885800

I would rename 0x07dc to USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 (original
submitted patch)
and 0x07de to USB_DEVICE_ID_MS_TYPE_COVER_3 (Nicholas' patch).

I would probably also rename 0x07dd to USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP.

At the time of my submission, there did not exist a Surface 3 non-Pro
to distinguish from my Surface 3 Pro, and it seems like the MS Type
Covers prior to Surface 3 series are compatible for both Pro and
non-Pro versions (Surface 2, Surface 2 Pro, Surface, and Surface Pro)
according to this:
http://www.microsoftstore.com/store/msusa/en_US/pdp/Type-Cover-2/productID.286867100

Thanks,
Alan

On Wed, May 20, 2015 at 4:30 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 20 May 2015, Nicholas Krause wrote:
>
>> This adds a secondary marco for the vendor id,
>> USB_DEVICE_ID_MS_TYPE_COVER_3_V2 in order to support this device having
>> a secondary vendor id. Further more we also add this marco to the
>> structures, hid_blacklist and ms_devices and move over the function,
>> hid_scan_collection to use support this newer macro.
>>
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>
> I don't trust your patches any more, sorry. Adding Alan to Ack this.
>
>> ---
>>  drivers/hid/hid-core.c          | 4 +++-
>>  drivers/hid/hid-ids.h           | 1 +
>>  drivers/hid/hid-microsoft.c     | 2 ++
>>  drivers/hid/usbhid/hid-quirks.c | 1 +
>>  4 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 722a925..16fa795 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -706,7 +706,8 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
>>
>>       if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
>>           (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
>> -          hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP) &&
>> +          hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP ||
>> +          hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_V2) &&
>>           hid->group == HID_GROUP_MULTITOUCH)
>>               hid->group = HID_GROUP_GENERIC;
>>
>> @@ -1900,6 +1901,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>>       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
>> +     { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_V2) },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 41f167e..1371732 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -671,6 +671,7 @@
>>  #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
>>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
>>  #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
>> +#define USB_DEVICE_ID_MS_TYPE_COVER_3_V2 0x07de
>>  #define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
>>
>>  #define USB_VENDOR_ID_MOJO           0x8282
>> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
>> index af935eb..6f23d81 100644
>> --- a/drivers/hid/hid-microsoft.c
>> +++ b/drivers/hid/hid-microsoft.c
>> @@ -278,6 +278,8 @@ static const struct hid_device_id ms_devices[] = {
>>               .driver_data = MS_DUPLICATE_USAGES },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
>>               .driver_data = MS_HIDINPUT },
>> +     { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_V2),
>> +             .driver_data = MS_HIDINPUT },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
>>               .driver_data = MS_HIDINPUT },
>>
>> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
>> index a775143..4b02c59 100644
>> --- a/drivers/hid/usbhid/hid-quirks.c
>> +++ b/drivers/hid/usbhid/hid-quirks.c
>> @@ -87,6 +87,7 @@ static const struct hid_blacklist {
>>       { USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A, HID_QUIRK_ALWAYS_POLL },
>>       { USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
>>       { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
>> +     { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_V2, HID_QUIRK_NO_INIT_REPORTS },
>>       { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP, HID_QUIRK_NO_INIT_REPORTS },
>>       { USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
>>       { USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
>> --
>> 2.1.4
>>
>
> --
> Jiri Kosina
> SUSE Labs
