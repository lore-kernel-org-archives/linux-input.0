From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 2/2] HID: multitouch: support Perixx PERIPAD 701
Date: Mon, 16 Jan 2012 19:30:46 +0100
Message-ID: <CAN+gG=G20JCcrny-OBTTgM2MP5mOnnty713nk+g9-znjrCiG3Q@mail.gmail.com>
References: <1326469531-26808-1-git-send-email-benjamin.tissoires@enac.fr>
	<1326469531-26808-2-git-send-email-benjamin.tissoires@enac.fr>
	<20120116150427.GB9828@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47842 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab2APSas convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jan 2012 13:30:48 -0500
In-Reply-To: <20120116150427.GB9828@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Mon, Jan 16, 2012 at 16:04, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
>> Perrix Peripad 701 is an hybrid device which presents a touchpad and
>> a keyboard on the same surface. The switch between the two is contro=
lled
>> by a physical switch, and the firmware sends the events on the right
>> interface (mouse, keyboard or multitouch).
>> This patch enables the multitouch interface of this device to work.
>>
>> We need to manually set the device as a trackpad (we cannot infer it
>> from the reports descriptors as the device works under Windows, a sy=
stem
>> that does not allow multitouch touchpad).
>> We also need to set the hid feature MAX CONTACT NUMBER to 2 or the d=
evice
>> stops sending events once it has been pressed by two touches.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-multitouch.c | =A0 47 +++++++++++++++++++++++++++=
+++++++++++++++
>> =A03 files changed, 49 insertions(+), 0 deletions(-)
>
> What tree does this patch apply to?

it was Jiri's tree, the branch for-next (just tested it, and the two
patches applied fine)

>
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index a421abd..f7c43b6 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -355,6 +355,7 @@ config HID_MULTITOUCH
>> =A0 =A0 =A0 =A0 - Lumio CrystalTouch panels
>> =A0 =A0 =A0 =A0 - MosArt dual-touch panels
>> =A0 =A0 =A0 =A0 - PenMount dual touch panels
>> + =A0 =A0 =A0 - Perixx Peripad 701 touchpad
>> =A0 =A0 =A0 =A0 - PixArt optical touch screen
>> =A0 =A0 =A0 =A0 - Pixcir dual touch panels
>> =A0 =A0 =A0 =A0 - Quanta panels
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index b8574cd..662a0b6 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -659,6 +659,7 @@
>>
>> =A0#define USB_VENDOR_ID_TOPSEED2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1784
>> =A0#define USB_DEVICE_ID_TOPSEED2_RF_COMBO =A0 =A0 =A00x0004
>> +#define USB_DEVICE_ID_TOPSEED2_PERIPAD_701 =A0 0x0016
>>
>> =A0#define USB_VENDOR_ID_TOPMAX =A0 =A0 =A0 =A0 0x0663
>> =A0#define USB_DEVICE_ID_TOPMAX_COBRAPAD =A0 =A0 =A0 =A00x0103
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 1ba60d3..a3fa874 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -77,6 +77,8 @@ struct mt_device {
>> =A0 =A0 =A0 unsigned last_slot_field; =A0 =A0 =A0 /* the last field =
of a slot */
>> =A0 =A0 =A0 int last_mt_collection; /* last known mt-related collect=
ion */
>> =A0 =A0 =A0 __s8 inputmode; =A0 =A0 =A0 =A0 /* InputMode HID feature=
, -1 if non-existent */
>> + =A0 =A0 __s8 maxcontactnumber; =A0 =A0 =A0 =A0 =A0/* Maximum Conta=
ct Number HID feature,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-1 =
if non-existent */
>
> How about separating this addition from the device patch?

if you want.

>
>> =A0 =A0 =A0 __u8 num_received; =A0 =A0 =A0/* how many contacts we re=
ceived */
>> =A0 =A0 =A0 __u8 num_expected; =A0 =A0 =A0/* expected last contact i=
ndex */
>> =A0 =A0 =A0 __u8 maxcontacts;
>> @@ -101,6 +103,7 @@ struct mt_device {
>> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0x0102
>> =A0#define MT_CLS_EGALAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x0103
>> =A0#define MT_CLS_EGALAX_SERIAL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x01=
04
>> +#define MT_CLS_TOPSEED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 0x0105
>>
>> =A0#define MT_DEFAULT_MAXCONTACT =A0 =A0 =A0 =A010
>>
>> @@ -190,6 +193,11 @@ static struct mt_class mt_classes[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32,
>> =A0 =A0 =A0 },
>> + =A0 =A0 { .name =3D MT_CLS_TOPSEED,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D MT_QUIRK_ALWAYS_VALID,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .is_indirect =3D true,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .maxcontacts =3D 2,
>> + =A0 =A0 },
>>
>> =A0 =A0 =A0 { }
>> =A0};
>> @@ -242,6 +250,7 @@ static void mt_feature_mapping(struct hid_device=
 *hdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->inputmode =3D field->report->id;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case HID_DG_CONTACTMAX:
>> + =A0 =A0 =A0 =A0 =A0 =A0 td->maxcontactnumber =3D field->report->id=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->maxcontacts =3D field->value[0];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (td->mtclass.maxcontacts)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if the maxconta=
cts is given by the class */
>
> Contactnumber is a bit unclear, easily mistaken for maxcontacts
> semantic. How about a maxcontact_(id|rid|report_id) instead?

ok for  maxcontact_report_id

>
>> @@ -610,6 +619,36 @@ static void mt_set_input_mode(struct hid_device=
 *hdev)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static void mt_set_maxcontacts(struct hid_device *hdev)
>> +{
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> + =A0 =A0 struct hid_report *r;
>> + =A0 =A0 struct hid_report_enum *re;
>> + =A0 =A0 int fieldmax, max;
>> +
>> + =A0 =A0 if (td->maxcontactnumber < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (!td->mtclass.maxcontacts)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 re =3D &(hdev->report_enum[HID_FEATURE_REPORT]);
>> + =A0 =A0 r =3D re->report_id_hash[td->maxcontactnumber];
>> + =A0 =A0 if (r) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 max =3D td->mtclass.maxcontacts;
>> + =A0 =A0 =A0 =A0 =A0 =A0 fieldmax =3D r->field[0]->logical_maximum;
>> + =A0 =A0 =A0 =A0 =A0 =A0 hid_info(hdev, "%s: value =3D %d / %d / %d=
\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->field[0]->value[0],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->mtclass.maxcontacts,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fieldmax);
>> + =A0 =A0 =A0 =A0 =A0 =A0 max =3D fieldmax < max ? fieldmax : max;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (r->field[0]->value[0] !=3D max) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->field[0]->value[0] =3D =
max;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbhid_submit_report(hdev,=
 r, USB_DIR_OUT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +}
>> +
>
> This seems to execute for all devices, not only for the present devic=
e?

yes and no.

If .maxcontact is not filled, then it won't be executed
(td->mtclass.maxcontacts =3D=3D 0).

=46or those having the .maxcontact field, it won't hurt them.
It's even better, as we explicitly ask the device to report the number
of slots we allocate.
If the feature is read-only (or the device crash), then it's a
firmware bug as it's not implementing either the hid protocol, or the
Microsoft kind-of specification.

BTW, thanks for the review, I'll send a v2 soon.

Cheers,
Benjamin

>
>> =A0static int mt_probe(struct hid_device *hdev, const struct hid_dev=
ice_id *id)
>> =A0{
>> =A0 =A0 =A0 int ret, i;
>> @@ -635,6 +674,7 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 td->mtclass =3D *mtclass;
>> =A0 =A0 =A0 td->inputmode =3D -1;
>> + =A0 =A0 td->maxcontactnumber =3D -1;
>> =A0 =A0 =A0 td->last_mt_collection =3D -1;
>> =A0 =A0 =A0 hid_set_drvdata(hdev, td);
>>
>> @@ -657,6 +697,7 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>>
>> =A0 =A0 =A0 ret =3D sysfs_create_group(&hdev->dev.kobj, &mt_attribut=
e_group);
>>
>> + =A0 =A0 mt_set_maxcontacts(hdev);
>> =A0 =A0 =A0 mt_set_input_mode(hdev);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -669,6 +710,7 @@ fail:
>> =A0#ifdef CONFIG_PM
>> =A0static int mt_reset_resume(struct hid_device *hdev)
>> =A0{
>> + =A0 =A0 mt_set_maxcontacts(hdev);
>> =A0 =A0 =A0 mt_set_input_mode(hdev);
>> =A0 =A0 =A0 return 0;
>> =A0}
>> @@ -869,6 +911,11 @@ static const struct hid_device_id mt_devices[] =
=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_SIT=
RONIX,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_MTP_SITRON=
IX)},
>>
>> + =A0 =A0 /* TopSeed panels */
>> + =A0 =A0 { .driver_data =3D MT_CLS_TOPSEED,
>> + =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_TOPSEED2_PER=
IPAD_701) },
>> +
>> =A0 =A0 =A0 /* Touch International panels */
>> =A0 =A0 =A0 { .driver_data =3D MT_CLS_DEFAULT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_TOUCH_INTL,
>> --
>> 1.7.4.4
>>
>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
