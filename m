From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 2/2] HID: add support for PenMount dual-touch panel
Date: Thu, 21 Apr 2011 14:19:51 +0200
Message-ID: <BANLkTikN-KRh4i1u_iuZwuQtWP2gU95Oeg@mail.gmail.com>
References: <1303388160-2814-1-git-send-email-benjamin.tissoires@enac.fr>
	<1303388160-2814-3-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1104211417330.12035@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53579 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab1DUMTx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2011 08:19:53 -0400
In-Reply-To: <alpine.LNX.2.00.1104211417330.12035@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, PenMount <penmount.touch@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 21, 2011 at 14:18, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 21 Apr 2011, Benjamin Tissoires wrote:
>
>> Signed-off-by: John Sung <penmount.touch@gmail.com>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>
> Hi Benjamin,
>
> thanks for respinning the pathes.
>
> This one is though missing
>
> - changelog
> - From: line (I believe we'd like to keep John's authorship)

Yep, sorry for that, I just seen it in my triple check after sending
it (grrr...). Do you want me to resend it, or we wait for John to do
it?

Cheers,
Benjamin

>
> Thanks.
>
>> ---
>> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
>> =A0drivers/hid/hid-multitouch.c | =A0 =A08 ++++++++
>> =A03 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index c3d6626..6e31b9f 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1438,6 +1438,7 @@ static const struct hid_device_id hid_have_spe=
cial_driver[] =3D {
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRI=
G_TOUCH_SCREEN_18) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTE=
K_PKB1700) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTE=
K_WKB2000) },
>> + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PEN=
MOUNT_PCI) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_P=
ETALYNX_MAXTER_REMOTE) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUA=
NTA_OPTICAL_TOUCH) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIX=
ART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index d485894..252aeba 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -484,6 +484,9 @@
>> =A0#define USB_VENDOR_ID_PANTHERLORD =A0 =A00x0810
>> =A0#define USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK =A00x0001
>>
>> +#define USB_VENDOR_ID_PENMOUNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x14e1
>> +#define USB_DEVICE_ID_PENMOUNT_PCI =A0 0x3500
>> +
>> =A0#define USB_VENDOR_ID_PETALYNX =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x18b1
>> =A0#define USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE 0x0037
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 6005e78..51b5d27 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -89,6 +89,7 @@ struct mt_class {
>> =A0#define MT_CLS_EGALAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A05
>> =A0#define MT_CLS_STANTUM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 6
>> =A0#define MT_CLS_3M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A07
>> +#define MT_CLS_CONFIDENCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08
>>
>> =A0#define MT_DEFAULT_MAXCONTACT =A0 =A0 =A0 =A010
>>
>> @@ -156,6 +157,8 @@ struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 2048,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_width =3D 128,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_height =3D 128 },
>> + =A0 =A0 { .name =3D MT_CLS_CONFIDENCE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_VALID_IS_CONFIDENCE }=
,
>>
>> =A0 =A0 =A0 { }
>> =A0};
>> @@ -584,6 +587,11 @@ static const struct hid_device_id mt_devices[] =
=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYST=
EMS,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_IRTOUCH_IN=
=46RARED_USB) },
>>
>> + =A0 =A0 /* PenMount panels */
>> + =A0 =A0 { .driver_data =3D MT_CLS_CONFIDENCE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_PENMOUNT_PCI=
) },
>> +
>> =A0 =A0 =A0 /* PixCir-based panels */
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
>> --
>> 1.7.4.2
>>
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
