From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Fri, 16 Sep 2011 11:23:53 +0200
Message-ID: <CAN+gG=GTA69JzM=bWv8Z+wsCneiDA8cJNbPiVA5+6953e4jm0g@mail.gmail.com>
References: <1315970147-11735-1-git-send-email-marek.vasut@gmail.com>
	<20110916062854.GC6731@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f180.google.com ([74.125.82.180]:48019 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1IPJXz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 05:23:55 -0400
Received: by wyj26 with SMTP id 26so4499486wyj.11
        for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 02:23:53 -0700 (PDT)
In-Reply-To: <20110916062854.GC6731@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>

Hello Marek,

it's commonly use to also add the authors (me and St=E9phane) and the
multitouch maintainer (Henrik). Working in hid-multitouch requires
adding a lot of people in cc... ;-)

Globally, the patch is clean. I don't really like it because a cleaner
way would be to just remove the field .maxcontacts in MT_CLS_EGALAX.
This would require tests from all the different eGalax owners, and
personally, I don't have the time to lead them.

So:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Cheers,
Benjamin

On Fri, Sep 16, 2011 at 08:28, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Marek,
>
> On Wed, Sep 14, 2011 at 05:15:47AM +0200, Marek Vasut wrote:
>> This patch adds USB ID for the touchpanel in Acer Iconia W500. The p=
anel
>> supports up to five fingers, therefore the need for a new addition o=
f panel
>> types.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>
> This should actually go to Jiri (CCed).
>
> Thanks.
>
>> ---
>> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-multitouch.c | =A0 12 ++++++++++++
>> =A03 files changed, 14 insertions(+), 0 deletions(-)
>>
>> NOTE: That checkpatch warning is there because I followed the patter=
n in
>> hid-core.c
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 242353d..6600ac7 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1377,6 +1377,7 @@ static const struct hid_device_id hid_have_spe=
cial_driver[] =3D {
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_=
EGALAX_MULTITOUCH2) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_=
EGALAX_MULTITOUCH3) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_=
EGALAX_MULTITOUCH4) },
>> + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EG=
ALAX_MULTITOUCH5) },
>> =A0 =A0 =A0 { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_=
ID_ELECOM_BM084) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS=
2515) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TR=
IO_LINKER_PLUS_II) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 7484e1b..c2e9369 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -225,6 +225,7 @@
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2 =A0 =A0 =A0 =A00x72=
a1
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3 =A0 =A0 =A0 =A00x48=
0e
>> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4 =A0 =A0 =A0 =A00x72=
6b
>> +#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5 =A0 =A0 =A0 =A00x7302
>>
>> =A0#define USB_VENDOR_ID_ELECOM =A0 =A0 =A0 =A0 0x056e
>> =A0#define USB_DEVICE_ID_ELECOM_BM084 =A0 0x0061
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 58d0e7a..35c53db 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -96,6 +96,7 @@ struct mt_class {
>> =A0#define MT_CLS_3M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x0101
>> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0x0102
>> =A0#define MT_CLS_EGALAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x0103
>> +#define MT_CLS_EGALAX_5FINGER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x0104
>>
>> =A0#define MT_DEFAULT_MAXCONTACT =A0 =A0 =A0 =A010
>>
>> @@ -173,6 +174,14 @@ struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32,
>> =A0 =A0 =A0 },
>> + =A0 =A0 { .name =3D MT_CLS_EGALAX_5FINGER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D =A0MT_QUIRK_SLOT_IS_CONTACTID =
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_VALID_IS_INRANGE =
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_EGALAX_XYZ_FIXUP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 5,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32,
>> + =A0 =A0 },
>>
>> =A0 =A0 =A0 { }
>> =A0};
>> @@ -646,6 +655,9 @@ static const struct hid_device_id mt_devices[] =3D=
 {
>> =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALA=
X_MULTITOUCH4) },
>> + =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX_5FINGER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGALAX_=
MULTITOUCH5) },
>>
>> =A0 =A0 =A0 /* Elo TouchSystems IntelliTouch Plus panel */
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_DUAL_NSMU_CONTACTID,
>> --
>> 1.7.5.4
>>
>
> --
> Dmitry
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
