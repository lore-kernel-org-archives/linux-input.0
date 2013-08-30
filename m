From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: [PATCH] HID: usbhid: quirk for N-Trig DuoSense Touch Screen
Date: Fri, 30 Aug 2013 15:34:11 -0400
Message-ID: <CABSveYhSMyCxPZS3nqSdiG-UZwAMMTX7UjgFG=emY+L-K60sdQ@mail.gmail.com>
References: <CABSveYg3gAnx=cKTqN-iqZdypzivXDuvVAJCdKdbCS6fz3gYkw@mail.gmail.com>
 <CAN+gG=H=r3HH=J+1eMUWSiruEm3F64E6UfH5djjR_Xfk+kmmtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:41550 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab3H3Tec (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Aug 2013 15:34:32 -0400
In-Reply-To: <CAN+gG=H=r3HH=J+1eMUWSiruEm3F64E6UfH5djjR_Xfk+kmmtQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi,

I've re-tested it with HID_QUIRK_NO_INIT_REPORTS parameter. Looks
fine, still no delays.

Shoud I re-format & re-submit the patch?
  Vasily Titskiy


On Fri, Aug 30, 2013 at 3:18 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> Hi,
>
> first, for the next submission, do not forget to add Jiri (the HID
> maintainer) in CC, otherwise there are huge chances that he will miss
> your patch.
>
> On Fri, Aug 30, 2013 at 8:47 PM, Vasily Titskiy <qehgt0@gmail.com> wrote:
>> The DuoSense touchscreen device causes a 10 second timeout. This fix
>> removes the delay.
>>
>> Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
>> ---
>>  drivers/hid/hid-ids.h           |    2 ++
>>  drivers/hid/usbhid/hid-quirks.c |    3 +++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 2168885..c3929ea 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -898,4 +898,6 @@
>>  #define USB_VENDOR_ID_PRIMAX 0x0461
>>  #define USB_DEVICE_ID_PRIMAX_KEYBOARD 0x4e05
>>
>> +#define USB_DEVICE_ID_NTRIG_DUOSENSE 0x1500
>> +
>
> Please keep the list sorted. This define should go into the *_NTRIG_* block.
>
>>  #endif
>> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
>> index 19b8360..3fd4dfd 100644
>> --- a/drivers/hid/usbhid/hid-quirks.c
>> +++ b/drivers/hid/usbhid/hid-quirks.c
>> @@ -89,6 +89,9 @@ static const struct hid_blacklist {
>>   { USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },
>>   { USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN, HID_QUIRK_NOGET },
>>   { USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
>> +
>
> extra whitespace
>
>> + { USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_DUOSENSE, HID_QUIRK_NOGET },
>
> I'm sure we could try here the new quirk
> HID_QUIRK_NO_INIT_INPUT_REPORTS, this would be more accurate I think.
> At least can you test if HID_QUIRK_NO_INIT_REPORTS is enough?
> HID_QUIRK_NOGET prevent all request from the host to the device, which
> is a little bit too much in many cases.
>
>> +
>
> extra whitespace too.
>
> Cheers,
> Benjamin
>
>
>>   { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209,
>> HID_QUIRK_MULTI_INPUT },
>>   { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U,
>> HID_QUIRK_MULTI_INPUT },
>>   { USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5,
>> HID_QUIRK_MULTI_INPUT },
>> --
>> 1.7.10.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
