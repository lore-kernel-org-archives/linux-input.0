From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] HID: add support for PenMount dual-touch panel
Date: Fri, 22 Apr 2011 12:12:58 +0200
Message-ID: <BANLkTimLyLKHv0ovX3rXdzQ=JKsNFiCHbQ@mail.gmail.com>
References: <1303388160-2814-3-git-send-email-benjamin.tissoires@enac.fr>
	<1303395712-4572-1-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1104221157090.12035@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60398 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab1DVKNA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Apr 2011 06:13:00 -0400
In-Reply-To: <alpine.LNX.2.00.1104221157090.12035@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, John Sung <penmount.touch@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 22, 2011 at 11:57, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 21 Apr 2011, Benjamin Tissoires wrote:
>
>> From: John Sung <penmount.touch@gmail.com>
>>
>> This patch adds PenMount support to hid-multitouch.
>> A new class MT_CLS_CONFIDENCE is defined for PenMount,
>> since it uses HID_DG_CONFIDENCE as the valid flag.
>>
>> Signed-off-by: John Sung <penmount.touch@gmail.com>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> Acked-by: Henrik Rydberg <rydberg@euromail.se>
>>
>> ---
>>
>> Hi Guys,
>>
>> this is the final version (I hope so).
>> I changed the from, restored back the Kconfig part and reintroduced =
the commit message.
>> John, I hope it's good for you.
>>
>> Cheers,
>> Benjamin
>>
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
>> =A0drivers/hid/hid-multitouch.c | =A0 =A08 ++++++++
>> =A04 files changed, 13 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 996ae3a..8058cf1 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -313,6 +313,7 @@ config HID_MULTITOUCH
>> =A0 =A0 =A0 =A0 - Cypress TrueTouch panels
>> =A0 =A0 =A0 =A0 - Hanvon dual touch panels
>> =A0 =A0 =A0 =A0 - IrTouch Infrared USB panels
>> + =A0 =A0 =A0 - PenMount dual touch panels
>> =A0 =A0 =A0 =A0 - Pixcir dual touch panels
>> =A0 =A0 =A0 =A0 - 'Sensing Win7-TwoFinger' panel by GeneralTouch
>> =A0 =A0 =A0 =A0 =A0 =A0- eGalax dual-touch panels, including the
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
>
> I have modified the commit message slightly, to reflect that Benjamin=
 has
> rebased John's original patch on top of last_index_field changes, and
> applied.
>

That's good for me ;-)

Thanks a lot Jiri,
Benjamin

> Thanks a lot everybody.
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
