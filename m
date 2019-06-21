From: Sebastian Parschauer <s.parschauer@gmx.de>
Subject: Re: [PATCH] hid: add another quirk for Chicony PixArt mouse
Date: Fri, 21 Jun 2019 12:36:11 +0200
Message-ID: <b3cbee0c-07ef-5943-cc8f-f4fa0f854440@gmx.de>
References: <20190621091736.14503-1-oleksandr@redhat.com>
 <20190621093920.qlnhbneoww7c6axw@butterfly.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621093920.qlnhbneoww7c6axw@butterfly.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Natalenko <oleksandr@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dave Young <dyoung@redhat.com>, "Herton R . Krzesinski" <herton@redhat.com>, Oliver Neukum <oneukum@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Thanks, got it on my radar already since Feb 5:

https://github.com/sriemer/fix-linux-mouse/issues/15#issuecomment-46071311=
5

If you see "Manufacturer: PixArt", then chances are high, that the
device is affected. IMHO generic quirks like described in GitHub issue
#20 would cover those easier.

Acked-by: Sebastian Parschauer <s.parschauer@gmx.de>

On 21.06.19 11:39, Oleksandr Natalenko wrote:
> Erm. Cc: s.parschauer@gmx.de instead of inactive @suse address.
>
> On Fri, Jun 21, 2019 at 11:17:36AM +0200, Oleksandr Natalenko wrote:
>> I've spotted another Chicony PixArt mouse in the wild, which requires
>> HID_QUIRK_ALWAYS_POLL quirk, otherwise it disconnects each minute.
>>
>> USB ID of this device is 0x04f2:0x0939.
>>
>> We've introduced quirks like this for other models before, so lets add
>> this mouse too.
>>
>> Link: https://github.com/sriemer/fix-linux-mouse#usb-mouse-disconnectsr=
econnects-every-minute-on-linux
>> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
>> ---
>>   drivers/hid/hid-ids.h    | 1 +
>>   drivers/hid/hid-quirks.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index eac0c54c5970..69f0553d9d95 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -269,6 +269,7 @@
>>   #define USB_DEVICE_ID_CHICONY_MULTI_TOUCH	0xb19d
>>   #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
>>   #define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE	0x1053
>> +#define USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE2	0x0939
>>   #define USB_DEVICE_ID_CHICONY_WIRELESS2	0x1123
>>   #define USB_DEVICE_ID_ASUS_AK1D		0x1125
>>   #define USB_DEVICE_ID_CHICONY_TOSHIBA_WT10A	0x1408
>> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>> index e5ca6fe2ca57..671a285724f9 100644
>> --- a/drivers/hid/hid-quirks.c
>> +++ b/drivers/hid/hid-quirks.c
>> @@ -42,6 +42,7 @@ static const struct hid_device_id hid_quirks[] =3D {
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM), HI=
D_QUIRK_NOGET },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_=
TOUCH), HID_QUIRK_MULTI_INPUT },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART=
_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_=
USB_OPTICAL_MOUSE2), HID_QUIRK_ALWAYS_POLL },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELE=
SS), HID_QUIRK_MULTI_INPUT },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD), HI=
D_QUIRK_BADPAD },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_ST=
ICK), HID_QUIRK_NOGET },
>> --
>> 2.22.0
>>
>
