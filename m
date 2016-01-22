From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] hid: add support for Lilliput touchscreen
Date: Fri, 22 Jan 2016 23:39:48 +0100
Message-ID: <CAN+gG=Fs9Sm3GwQrn+yGcgz8ono_VM+DwLqBLSGumqYMnXD__Q@mail.gmail.com>
References: <1449863264-14184-1-git-send-email-srinivas.kandagatla@linaro.org>
	<alpine.LNX.2.00.1601211435360.21446@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1601211435360.21446@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Kiran Rudramuni <kchitrik@codeaurora.org>, Nicolas Dechesne <nicolas.dechesne@linaro.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 21, 2016 at 2:37 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 11 Dec 2015, Srinivas Kandagatla wrote:
>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index c6f7a69..4350376 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -2051,6 +2051,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>>       { HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
>>       { HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
>> +     { HID_USB_DEVICE(USB_VENDOR_ID_LILLIPUT, USB_PROD_ID_LILLIPUT) },
>
> Could you please keep the list sorted?
>
>>
>>       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
>>       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 9024a3d..f87993f 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -1055,4 +1055,8 @@
>>  #define USB_DEVICE_ID_RAPHNET_2NES2SNES      0x0002
>>  #define USB_DEVICE_ID_RAPHNET_4NES4SNES      0x0003
>>
>> +/* Lilliput Capacitive TouchScreen */
>> +#define USB_VENDOR_ID_LILLIPUT  0x1391
>> +#define USB_PROD_ID_LILLIPUT    0x2112
>> +
>>  #endif
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index 3d664d0..580749e 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -1209,6 +1209,11 @@ static const struct hid_device_id mt_devices[] = {
>>               MT_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
>>                       USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040) },
>>
>> +     /* Lilliput multitouch panels */
>> +     {  .driver_data = MT_CLS_DEFAULT,

NACK without further explanations.

Why do you need to patch the kernel an already working touchscreen?
MT_CLS_DEFAULT is the default as its name stands, and we do not need
to add a per device entry for it.

Cheers,
Benjamin

>> +             HID_USB_DEVICE(USB_VENDOR_ID_LILLIPUT,
>> +                     USB_PROD_ID_LILLIPUT) },
>> +
>
> This is a bit out of order as well.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
