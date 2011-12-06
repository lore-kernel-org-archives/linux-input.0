From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: hid-multitouch- support PixArt optical touch screen
Date: Tue, 6 Dec 2011 18:55:05 +0100
Message-ID: <CAN+gG=HVJTHJCLT43soN=HDGcUWL=6rqMtN+TihxL0GbPQP2RQ@mail.gmail.com>
References: <OF2AC9FD94.4CE4D9FB-ON4825795E.0037FF42-4825795E.00380F71@pixart.com.tw>
	<87borm549a.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63930 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab1LFRzH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Dec 2011 12:55:07 -0500
Received: by wgbdr13 with SMTP id dr13so6640448wgb.1
        for <linux-input@vger.kernel.org>; Tue, 06 Dec 2011 09:55:05 -0800 (PST)
In-Reply-To: <87borm549a.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: aaron_tian@pixart.com.tw, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi Aaron,

on top of JJ's comments:

On Tue, Dec 6, 2011 at 12:27, JJ Ding <jj_ding@emc.com.tw> wrote:
> Hi Aaron,
>
> I can't apply your patch. Your MUA seems to wrap the mail. Maybe you
> want to use "git send-email" instead.
>
> Btw, the fisrt part of the mail should be your commit message. You ca=
n
> put your explanation below the "---" line. And hid drivers are
> maintained by Jiri Kosina <jkosina@suse.cz>, you might also CC Jiri n=
ext
> time.
>
> Thanks.
>
> br,
> jj
>
> On Tue, 6 Dec 2011 18:12:19 +0800, aaron_tian@pixart.com.tw wrote:
>> From: Aaron Tian <aaron_tian@pixart.com.tw>
>>
>> Hello,
>>
>> This ia Aaron Tian in Pixart. We have modified the hid-multitouch dr=
iver
>> for
>> supporting PixArt optical touch screen and it works well. Because of=
 the
>> device
>> does not have to set initial report, we apply "HID_QUIRK_NO_INIT_REP=
ORTS"
>> quirk and add the device into hid_blacklist in
>> drivers/hid/usbhid/hid-quirks.c
>>
>> The patch is according to commit 45e713efe2fa574b6662e7fb63fae9497c5=
e03d4
>> of
>> Linux mainline git (3.2.0-rc4+)
>>
>>
>> Signed-off-by: Aaron Tian <aaron_tian@pixart.com.tw>
>> ---
>
>
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-core.c =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +++
>> =A0drivers/hid/hid-multitouch.c =A0 =A0| =A0 =A05 +++++
>> =A0drivers/hid/usbhid/hid-quirks.c | =A0 =A01 +
>> =A05 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 22a4a05..eda54b6 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -349,6 +349,7 @@ config HID_MULTITOUCH
>> =A0 =A0 =A0 =A0 =A0 - Lumio CrystalTouch panels
>> =A0 =A0 =A0 =A0 =A0 - MosArt dual-touch panels
>> =A0 =A0 =A0 =A0 =A0 - PenMount dual touch panels
>> + =A0 =A0 =A0 =A0 - PixArt optical touch screen
>> =A0 =A0 =A0 =A0 =A0 - Pixcir dual touch panels
>> =A0 =A0 =A0 =A0 =A0 - eGalax dual-touch panels, including the Joojoo=
 and Wetab
>> tablets
>> =A0 =A0 =A0 =A0 =A0 - Stantum multitouch panels
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index af35384..e9280ef 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1498,6 +1498,7 @@ static const struct hid_device_id
>> hid_have_special_driver[] =3D {
>> =A0 =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_=
ORTEK_WKB2000)
>> },
>> =A0 =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT,
>> USB_DEVICE_ID_PENMOUNT_PCI) },
>> =A0 =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX,
>> USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_TYPE_PIXART,
>> USB_DEVICE_TYPE_PIXART_OPTICAL_TOUCH_SCREEN) },
>> =A0 =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX,
>> USB_DEVICE_ID_PRIMAX_KEYBOARD) },
>> =A0 =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
>> USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
>> =A0 =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA,
>> USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 4a441a6..869911b 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -571,6 +571,9 @@
>> =A0#define USB_VENDOR_ID_PI_ENGINEERING =A0 0x05f3
>> =A0#define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL 0xff
>>
>> +#define USB_VENDOR_TYPE_PIXART =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0x093a
>> +#define USB_DEVICE_TYPE_PIXART_OPTICAL_TOUCH_SCREEN =A0 =A00x8001

Please change _TYPE_ by _ID_ in both line to be consistent with other #=
define.

>> +
>> =A0#define USB_VENDOR_ID_PLAYDOTCOM =A0 =A0 =A0 0x0b43
>> =A0#define USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII =A0 =A0 0x0003
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index f1c909f..2f338b1 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -722,6 +722,11 @@ static const struct hid_device_id mt_devices[] =
=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_PENMOUN=
T,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_PENMOU=
NT_PCI) },
>>
>> + =A0 =A0 =A0 /* PixArt optical touch screen */
>> + =A0 =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_PIXART,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_PIXART_O=
PTICAL_TOUCH_SCREEN) },
>> +

Do you __really__ need the DUAL here?
I know that the  MT_CLS_INRANGE_CONTACTNUMBER class does not exist,
but if your company does not intend to do only dual touch screen, it
may be better to remove the .maxcontact field (i.e. create
MT_CLS_INRANGE_CONTACTNUMBER).
We had the problem with eGalax devices recently: they were reported as
dual touches by the kernel whereas some of them were 4 touches.

Despite the line wrapping and this comment, the patch looks good.

Cheers,
Benjamin

>> =A0 =A0 =A0 =A0 /* PixCir-based panels */
>> =A0 =A0 =A0 =A0 { .driver_data =3D MT_CLS_DUAL_INRANGE_CONTACTID,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
>> diff --git a/drivers/hid/usbhid/hid-quirks.c
>> b/drivers/hid/usbhid/hid-quirks.c
>> index 5028d60..99324eb 100644
>> --- a/drivers/hid/usbhid/hid-quirks.c
>> +++ b/drivers/hid/usbhid/hid-quirks.c
>> @@ -67,6 +67,7 @@ static const struct hid_blacklist {
>> =A0 =A0 =A0 =A0 { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_Q=
UIRK_NOGET },
>> =A0 =A0 =A0 =A0 { USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIR=
K_NOGET },
>> =A0 =A0 =A0 =A0 { USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_Q=
UIRK_NOGET },
>> + =A0 =A0 =A0 { USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_T=
OUCH_SCREEN,
>> HID_QUIRK_NO_INIT_REPORTS },
>> =A0 =A0 =A0 =A0 { USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDL=
ESS,
>> HID_QUIRK_NOGET },
>> =A0 =A0 =A0 =A0 { USB_VENDOR_ID_QUANTA,
>> USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOG=
ET },
>> =A0 =A0 =A0 =A0 { USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGL=
E,
>> HID_QUIRK_NOGET },
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
