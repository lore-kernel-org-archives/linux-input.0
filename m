From: Austin Hendrix <ahendrix@willowgarage.com>
Subject: Re: [PATCH] Add Support for Novatek Touchscreen
Date: Tue, 5 Jun 2012 11:49:28 -0700
Message-ID: <CAOY97Vbjzbv-=jOwxnKR-eBBtGv33aFWV3G3VQnBMVaxMkQYiQ@mail.gmail.com>
References: <CAOY97VZN2a36OBsacQS21P8G70L2tbtbWK5OMWhZYa=D74XO+w@mail.gmail.com>
	<alpine.LNX.2.00.1206051134020.5478@pobox.suse.cz>
	<CAN+gG=FSTxE9d8o4O6+kQHmyg9PdJK28x6=Gjpgr+_xppiRVbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44860 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab2FESta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jun 2012 14:49:30 -0400
Received: by wibhj8 with SMTP id hj8so4225956wib.1
        for <linux-input@vger.kernel.org>; Tue, 05 Jun 2012 11:49:29 -0700 (PDT)
In-Reply-To: <CAN+gG=FSTxE9d8o4O6+kQHmyg9PdJK28x6=Gjpgr+_xppiRVbQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

Sorry about the line wrapping; I'll make sure my mail client deals with=
 it
properly in the future.

Comments inline.

On Tue, Jun 5, 2012 at 3:52 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> Hi Austin, Jiri,
>
> I'm a bit concerned about this patch. Though it's fine for pre-3.5
> kernels, it does not fit into the 3.5 work.
> The thing is that it's easier to backport this patch in it's current
> form, so I don't know exactly the best way to tackle this.

I initially wrote this patch against 3.3, so I guess I'm not surprised =
that
things have changed a bit since then. I can make another patch against =
3.5 if
that's the right thing to do.

>
> See comments inlined.
>
> On Tue, Jun 5, 2012 at 11:34 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Mon, 4 Jun 2012, Austin Hendrix wrote:
>>
>>> Add support for a Novatek touchscreen panel as a generic HID multit=
ouch
>>> panel.
>>>
>>> Signed-off-by: Austin Hendrix <ahendrix@willowgarage.com>
>>> ---
>>> =A0hid-core.c =A0 =A0 =A0 | =A0 =A01 +
>>> =A0hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
>>> =A0hid-multitouch.c | =A0 =A05 +++++
>>> =A03 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>>> index 8e3a6b2..0d6dde1 100644
>>> --- a/drivers/hid/hid-core.c
>>> +++ b/drivers/hid/hid-core.c
>>> @@ -1605,6 +1605,7 @@ static const struct hid_device_id
>>> hid_have_special_driver[] =3D {
>>
>> Austin,
>>
>> thanks for the patch. Your mail client is corrupting (line-wrapping)
>> patches. Please fix that for your future submissions.
>>
>> I have now fixed that up manually and applied.
>>
>>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTR=
IG_TOUCH_SCREEN_16) },
>>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTR=
IG_TOUCH_SCREEN_17) },
>>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTR=
IG_TOUCH_SCREEN_18) },
>>> + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOV=
ATEK_PCT) },
>
> I don't think this should be included in 3.5-rc+ (the whole MT-relate=
d
> devices has been removed from this list).
>
>>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORT=
EK_PKB1700) },
>>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORT=
EK_WKB2000) },
>>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX,
>>> USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>>> index 9373f53..734a2b9 100644
>>> --- a/drivers/hid/hid-ids.h
>>> +++ b/drivers/hid/hid-ids.h
>>> @@ -564,6 +564,9 @@
>>> =A0#define USB_VENDOR_ID_NINTENDO =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x057=
e
>>> =A0#define USB_DEVICE_ID_NINTENDO_WIIMOTE =A0 =A0 =A0 0x0306
>>>
>>> +#define USB_VENDOR_ID_NOVATEK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x060=
3
>>> +#define USB_DEVICE_ID_NOVATK_PCT =A0 =A00x0600
>>> +
>>> =A0#define USB_VENDOR_ID_NTRIG =A0 =A0 =A0 =A0 =A00x1b96
>>> =A0#define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN =A0 0x0001
>>> =A0#define USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1 =A0 0x0003
>>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multito=
uch.c
>>> index 6e3332a..fae08df 100644
>>> --- a/drivers/hid/hid-multitouch.c
>>> +++ b/drivers/hid/hid-multitouch.c
>>> @@ -951,6 +951,11 @@ static const struct hid_device_id mt_devices[]=
 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_PANASONIC,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_PANABOARD=
_UBT880) },
>>>
>>> + =A0 =A0 /* Novatek Panel */
>>> + =A0 =A0 { .driver_data =3D MT_CLS_DEFAULT,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_NOVATEK,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_NOVATEK_PCT=
) },
>
> Shouldn't we use MT_USB_DEVICE instead?

That does look like the hip thing to do in 3.5.

-Austin

>
> Cheers,
> Benjamin
>
>>> +
>>> =A0 =A0 =A0 /* PenMount panels */
>>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_CONFIDENCE,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_USB_DEVICE(USB_VENDOR_ID_PENMOUNT,
>>>
>>
>> --
>> Jiri Kosina
>> SUSE Labs
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
