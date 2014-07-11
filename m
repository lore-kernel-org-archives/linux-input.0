From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 05/15] Input - wacom: compute the HID report size to get
 the actual packet size
Date: Fri, 11 Jul 2014 09:20:54 -0400
Message-ID: <CAN+gG=GtjXQgRJqq6t+Kj70APg4vMXrdGs+w4KWHnqd7PF--Hg@mail.gmail.com>
References: <1404163586-29582-1-git-send-email-benjamin.tissoires@redhat.com>
	<1404163586-29582-6-git-send-email-benjamin.tissoires@redhat.com>
	<CANRwn3R4LG0SoDR5hKC+LehTWxnmJsKsVsXdkkx4MrDxUwPZNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:45473 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbaGKNU4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jul 2014 09:20:56 -0400
In-Reply-To: <CANRwn3R4LG0SoDR5hKC+LehTWxnmJsKsVsXdkkx4MrDxUwPZNQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxwacom-devel <linuxwacom-devel@lists.sourceforge.net>

On Thu, Jul 10, 2014 at 9:09 PM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> On Mon, Jun 30, 2014 at 2:26 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> This removes an USB dependency and is more accurate: the computed pk=
tlen
>> is the actual maximum size of the reports forwarded by the device.
>>
>> Given that the pktlen is correctly computed/validated, we can store =
it now
>> in the features struct instead of having a special handling in the r=
est of
>> the code.
>>
>> Likewise, this information is not mandatory anymore in the descripti=
on
>> of devices in wacom_wac.c. They will be removed in a separate patch.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> I'm concerned this new function could be fooled if we release a table=
t
> that has one report which is longer than the desired report, but none
> of the hardware I tested was like this and it would be fairly easy to
> address even if it did happen. Thought I should mention it though.
>

You are right to mention it. But in the other hand, such a device
would violate the HID specification, and I am not sure the Windows
driver (which I don't know its internal) would be happy too.

Anyway, as you said, if there is such a device, we an use the report
descriptor fixup capability of HID to prevent this from happening.

Cheers,
Benjamin

> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can=E2=80=99t take seven from three,    /
> So you look at the sixty-fours....
>
>
>> ---
>>  drivers/input/tablet/wacom_sys.c | 58 ++++++++++++++++++-----------=
-----------
>>  1 file changed, 26 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet=
/wacom_sys.c
>> index cd3d936..3f1cee6 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -149,7 +149,6 @@ static int wacom_parse_logical_collection(unsign=
ed char *report,
>>         if (features->type =3D=3D BAMBOO_PT) {
>>
>>                 /* Logical collection is only used by 3rd gen Bamboo=
 Touch */
>> -               features->pktlen =3D WACOM_PKGLEN_BBTOUCH3;
>>                 features->device_type =3D BTN_TOOL_FINGER;
>>
>>                 features->x_max =3D features->y_max =3D
>> @@ -240,29 +239,6 @@ static int wacom_parse_hid(struct hid_device *h=
dev,
>>                                         features->device_type =3D BT=
N_TOOL_FINGER;
>>                                         /* touch device at least sup=
ports one touch point */
>>                                         touch_max =3D 1;
>> -                                       switch (features->type) {
>> -                                       case TABLETPC2FG:
>> -                                               features->pktlen =3D=
 WACOM_PKGLEN_TPC2FG;
>> -                                               break;
>> -
>> -                                       case MTSCREEN:
>> -                                       case WACOM_24HDT:
>> -                                               features->pktlen =3D=
 WACOM_PKGLEN_MTOUCH;
>> -                                               break;
>> -
>> -                                       case MTTPC:
>> -                                       case MTTPC_B:
>> -                                               features->pktlen =3D=
 WACOM_PKGLEN_MTTPC;
>> -                                               break;
>> -
>> -                                       case BAMBOO_PT:
>> -                                               features->pktlen =3D=
 WACOM_PKGLEN_BBTOUCH;
>> -                                               break;
>> -
>> -                                       default:
>> -                                               features->pktlen =3D=
 WACOM_PKGLEN_GRAPHIRE;
>> -                                               break;
>> -                                       }
>>
>>                                         switch (features->type) {
>>                                         case BAMBOO_PT:
>> @@ -305,8 +281,6 @@ static int wacom_parse_hid(struct hid_device *hd=
ev,
>>                                         }
>>                                 } else if (pen) {
>>                                         /* penabled only accepts exa=
ct bytes of data */
>> -                                       if (features->type >=3D TABL=
ETPC)
>> -                                               features->pktlen =3D=
 WACOM_PKGLEN_GRAPHIRE;
>>                                         features->device_type =3D BT=
N_TOOL_PEN;
>>                                         features->x_max =3D
>>                                                 get_unaligned_le16(&=
report[i + 3]);
>> @@ -1227,12 +1201,34 @@ static void wacom_calculate_res(struct wacom=
_features *features)
>>                                                     features->unitEx=
po);
>>  }
>>
>> +static int wacom_hid_report_len(struct hid_report *report)
>> +{
>> +       /* equivalent to DIV_ROUND_UP(report->size, 8) + !!(report->=
id > 0) */
>> +       return ((report->size - 1) >> 3) + 1 + (report->id > 0);
>> +}
>> +
>> +static size_t wacom_compute_pktlen(struct hid_device *hdev)
>> +{
>> +       struct hid_report_enum *report_enum;
>> +       struct hid_report *report;
>> +       size_t size =3D 0;
>> +
>> +       report_enum =3D hdev->report_enum + HID_INPUT_REPORT;
>> +
>> +       list_for_each_entry(report, &report_enum->report_list, list)=
 {
>> +               size_t report_size =3D wacom_hid_report_len(report);
>> +               if (report_size > size)
>> +                       size =3D report_size;
>> +       }
>> +
>> +       return size;
>> +}
>> +
>>  static int wacom_probe(struct hid_device *hdev,
>>                 const struct hid_device_id *id)
>>  {
>>         struct usb_interface *intf =3D to_usb_interface(hdev->dev.pa=
rent);
>>         struct usb_device *dev =3D interface_to_usbdev(intf);
>> -       struct usb_endpoint_descriptor *endpoint;
>>         struct wacom *wacom;
>>         struct wacom_wac *wacom_wac;
>>         struct wacom_features *features;
>> @@ -1258,6 +1254,7 @@ static int wacom_probe(struct hid_device *hdev=
,
>>         wacom_wac =3D &wacom->wacom_wac;
>>         wacom_wac->features =3D *((struct wacom_features *)id->drive=
r_data);
>>         features =3D &wacom_wac->features;
>> +       features->pktlen =3D wacom_compute_pktlen(hdev);
>>         if (features->pktlen > WACOM_PKGLEN_MAX) {
>>                 error =3D -EINVAL;
>>                 goto fail1;
>> @@ -1275,8 +1272,6 @@ static int wacom_probe(struct hid_device *hdev=
,
>>         usb_make_path(dev, wacom->phys, sizeof(wacom->phys));
>>         strlcat(wacom->phys, "/input0", sizeof(wacom->phys));
>>
>> -       endpoint =3D &intf->cur_altsetting->endpoint[0].desc;
>> -
>>         /* set the default size in case we do not get them from hid =
*/
>>         wacom_set_default_phy(features);
>>
>> @@ -1287,13 +1282,12 @@ static int wacom_probe(struct hid_device *hd=
ev,
>>
>>         /*
>>          * Intuos5 has no useful data about its touch interface in i=
ts
>> -        * HID descriptor. If this is the touch interface (wMaxPacke=
tSize
>> +        * HID descriptor. If this is the touch interface (PacketSiz=
e
>>          * of WACOM_PKGLEN_BBTOUCH3), override the table values.
>>          */
>>         if (features->type >=3D INTUOS5S && features->type <=3D INTU=
OSHT) {
>> -               if (endpoint->wMaxPacketSize =3D=3D WACOM_PKGLEN_BBT=
OUCH3) {
>> +               if (features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH3) {
>>                         features->device_type =3D BTN_TOOL_FINGER;
>> -                       features->pktlen =3D WACOM_PKGLEN_BBTOUCH3;
>>
>>                         features->x_max =3D 4096;
>>                         features->y_max =3D 4096;
>> --
>> 2.0.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
