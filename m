From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC v3 4/5] hid-multitouch: added support for Cypress TrueTouch panels
Date: Mon, 10 Jan 2011 20:13:41 +0100
Message-ID: <AANLkTi=CL=7Aax1dfBHUzszR8KdrJaE0nCHg2tNFAqqJ@mail.gmail.com>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
	<1294425762-29730-5-git-send-email-benjamin.tissoires@enac.fr>
	<20110107200014.GC29913@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42039 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab1AJTNn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 14:13:43 -0500
In-Reply-To: <20110107200014.GC29913@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 7, 2011 at 9:00 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> On Fri, Jan 07, 2011 at 07:42:41PM +0100, Benjamin Tissoires wrote:
>> Added support for Cypress TrueTouch panels, which detect up to 10 fi=
ngers
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> Signed-off-by: St=E9phane Chatty <chatty@enac.fr>
>> ---
>
> Hi, just minor things.
>
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-multitouch.c | =A0 19 +++++++++++++++++++
>> =A04 files changed, 22 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 511554d..de31d75 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -293,6 +293,7 @@ config HID_MULTITOUCH
>>
>> =A0 =A0 =A0 =A0 Say Y here if you have one of the following devices:
>> =A0 =A0 =A0 =A0 - PixCir touchscreen
>> + =A0 =A0 =A0 - Cypress TrueTouch
>>
>> =A0config HID_NTRIG
>> =A0 =A0 =A0 tristate "N-Trig touch screen"
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 2b4d9b9..e6a86bf 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1298,6 +1298,7 @@ static const struct hid_device_id hid_blacklis=
t[] =3D {
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CY=
PRESS_BARCODE_2) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CY=
PRESS_BARCODE_3) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CY=
PRESS_MOUSE) },
>> + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPR=
ESS_TRUETOUCH) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_=
EGALAX_MULTITOUCH) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_=
EGALAX_MULTITOUCH1) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 17b444b..c258c42 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -180,6 +180,7 @@
>> =A0#define USB_DEVICE_ID_CYPRESS_BARCODE_1 =A0 =A0 =A00xde61
>> =A0#define USB_DEVICE_ID_CYPRESS_BARCODE_2 =A0 =A0 =A00xde64
>> =A0#define USB_DEVICE_ID_CYPRESS_BARCODE_3 =A0 =A0 =A00xbca1
>> +#define USB_DEVICE_ID_CYPRESS_TRUETOUCH =A0 =A0 =A00xc001
>>
>> =A0#define USB_VENDOR_ID_DEALEXTREAME =A0 0x10c5
>> =A0#define USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701 =A0 =A0 =A00x819a
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 3b05dfe..7af9f71 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -32,6 +32,7 @@ MODULE_LICENSE("GPL");
>> =A0/* quirks to control the device */
>> =A0#define MT_QUIRK_NOT_SEEN_MEANS_UP =A0 (1 << 0)
>> =A0#define MT_QUIRK_SLOT_IS_CONTACTID =A0 (1 << 1)
>> +#define MT_QUIRK_CYPRESS =A0 =A0 (1 << 2)
>
> Missing tab.

Ok

>
>>
>> =A0struct mt_slot {
>> =A0 =A0 =A0 __s32 x, y, p, w, h;
>> @@ -62,6 +63,7 @@ struct mt_class {
>> =A0/* classes of device behavior */
>> =A0#define MT_CLS_DEFAULT 0
>> =A0#define MT_CLS_DUAL1 1
>> +#define MT_CLS_CYPRESS 2
>
> Missing tabs... goes for the previous patch as well, coming to think =
of it.

ok and ok

>
> It does seem slightly complicated, doesn't it. How about dropping
> these, and referring to explicit static structures instead?

I don't want people to place those static structures anywhere in the co=
de.

In v4, I've added a field .name and I retrieve it in the mt_probe funct=
ion.

>
>>
>> =A0/*
>> =A0 * these device-dependent functions determine what slot correspon=
ds
>> @@ -73,6 +75,14 @@ static int slot_is_contactid(struct mt_device *td=
)
>> =A0 =A0 =A0 return td->curdata.contactid;
>> =A0}
>>
>> +static int cypress_compute_slot(struct mt_device *td)
>> +{
>> + =A0 =A0 if (td->curdata.contactid !=3D 0 || td->num_received =3D=3D=
 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return td->curdata.contactid;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> +}
>> +
>> =A0static int find_slot_from_contactid(struct mt_device *td)
>> =A0{
>> =A0 =A0 =A0 int i;
>> @@ -95,6 +105,7 @@ static int find_slot_from_contactid(struct mt_dev=
ice *td)
>> =A0struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 { 0, 0, 0, 10 }, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 /* MT_CLS_DEFAULT */
>> =A0 =A0 =A0 { MT_QUIRK_SLOT_IS_CONTACTID, 0, 0, 2 }, =A0 =A0 /* MT_C=
LS_DUAL1 */
>> + =A0 =A0 { MT_QUIRK_CYPRESS | MT_QUIRK_NOT_SEEN_MEANS_UP, 0, 0, 10 =
}, /* MT_CLS_CYPRESS */
>> =A0};
>
> These could be named structs instead of an array, e.g.,
>
> static const struct mt_class mt_cls_dual1 =3D {
> =A0 =A0 =A0 .quirks =3D MT_QUIRK_SLOT_IS_CONTACTID,
> =A0 =A0 =A0 .max_contacts =3D 2,
> };
>
>>
>> =A0static void mt_feature_mapping(struct hid_device *hdev, struct hi=
d_input *hi,
>> @@ -223,6 +234,9 @@ static int mt_compute_slot(struct mt_device *td)
>> =A0 =A0 =A0 if (cls->quirks & MT_QUIRK_SLOT_IS_CONTACTID)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return slot_is_contactid(td);
>>
>> + =A0 =A0 if (cls->quirks & MT_QUIRK_CYPRESS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return cypress_compute_slot(td);
>> +
>> =A0 =A0 =A0 return find_slot_from_contactid(td);
>> =A0}
>>
>> @@ -422,6 +436,11 @@ static void mt_remove(struct hid_device *hdev)
>>
>> =A0static const struct hid_device_id mt_devices[] =3D {
>>
>> + =A0 =A0 /* Cypress panel */
>> + =A0 =A0 { .driver_data =3D MT_CLS_CYPRESS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_CYPRESS_TRUE=
TOUCH) },
>> +
>> =A0 =A0 =A0 /* PixCir-based panels */
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_DUAL1,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
>
> Could use pointers here instead.
>
> Thanks!
> Henrik


Thanks,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
