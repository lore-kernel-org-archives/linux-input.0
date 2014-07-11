From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 05/15] Input - wacom: compute the HID report size to get
 the actual packet size
Date: Thu, 10 Jul 2014 18:09:59 -0700
Message-ID: <CANRwn3R4LG0SoDR5hKC+LehTWxnmJsKsVsXdkkx4MrDxUwPZNQ@mail.gmail.com>
References: <1404163586-29582-1-git-send-email-benjamin.tissoires@redhat.com>
	<1404163586-29582-6-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:51370 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbaGKBKC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2014 21:10:02 -0400
In-Reply-To: <1404163586-29582-6-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, linuxwacom-devel <linuxwacom-devel@lists.sourceforge.net>

On Mon, Jun 30, 2014 at 2:26 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> This removes an USB dependency and is more accurate: the computed pkt=
len
> is the actual maximum size of the reports forwarded by the device.
>
> Given that the pktlen is correctly computed/validated, we can store i=
t now
> in the features struct instead of having a special handling in the re=
st of
> the code.
>
> Likewise, this information is not mandatory anymore in the descriptio=
n
> of devices in wacom_wac.c. They will be removed in a separate patch.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I'm concerned this new function could be fooled if we release a tablet
that has one report which is longer than the desired report, but none
of the hardware I tested was like this and it would be fairly easy to
address even if it did happen. Thought I should mention it though.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


> ---
>  drivers/input/tablet/wacom_sys.c | 58 ++++++++++++++++++------------=
----------
>  1 file changed, 26 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index cd3d936..3f1cee6 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -149,7 +149,6 @@ static int wacom_parse_logical_collection(unsigne=
d char *report,
>         if (features->type =3D=3D BAMBOO_PT) {
>
>                 /* Logical collection is only used by 3rd gen Bamboo =
Touch */
> -               features->pktlen =3D WACOM_PKGLEN_BBTOUCH3;
>                 features->device_type =3D BTN_TOOL_FINGER;
>
>                 features->x_max =3D features->y_max =3D
> @@ -240,29 +239,6 @@ static int wacom_parse_hid(struct hid_device *hd=
ev,
>                                         features->device_type =3D BTN=
_TOOL_FINGER;
>                                         /* touch device at least supp=
orts one touch point */
>                                         touch_max =3D 1;
> -                                       switch (features->type) {
> -                                       case TABLETPC2FG:
> -                                               features->pktlen =3D =
WACOM_PKGLEN_TPC2FG;
> -                                               break;
> -
> -                                       case MTSCREEN:
> -                                       case WACOM_24HDT:
> -                                               features->pktlen =3D =
WACOM_PKGLEN_MTOUCH;
> -                                               break;
> -
> -                                       case MTTPC:
> -                                       case MTTPC_B:
> -                                               features->pktlen =3D =
WACOM_PKGLEN_MTTPC;
> -                                               break;
> -
> -                                       case BAMBOO_PT:
> -                                               features->pktlen =3D =
WACOM_PKGLEN_BBTOUCH;
> -                                               break;
> -
> -                                       default:
> -                                               features->pktlen =3D =
WACOM_PKGLEN_GRAPHIRE;
> -                                               break;
> -                                       }
>
>                                         switch (features->type) {
>                                         case BAMBOO_PT:
> @@ -305,8 +281,6 @@ static int wacom_parse_hid(struct hid_device *hde=
v,
>                                         }
>                                 } else if (pen) {
>                                         /* penabled only accepts exac=
t bytes of data */
> -                                       if (features->type >=3D TABLE=
TPC)
> -                                               features->pktlen =3D =
WACOM_PKGLEN_GRAPHIRE;
>                                         features->device_type =3D BTN=
_TOOL_PEN;
>                                         features->x_max =3D
>                                                 get_unaligned_le16(&r=
eport[i + 3]);
> @@ -1227,12 +1201,34 @@ static void wacom_calculate_res(struct wacom_=
features *features)
>                                                     features->unitExp=
o);
>  }
>
> +static int wacom_hid_report_len(struct hid_report *report)
> +{
> +       /* equivalent to DIV_ROUND_UP(report->size, 8) + !!(report->i=
d > 0) */
> +       return ((report->size - 1) >> 3) + 1 + (report->id > 0);
> +}
> +
> +static size_t wacom_compute_pktlen(struct hid_device *hdev)
> +{
> +       struct hid_report_enum *report_enum;
> +       struct hid_report *report;
> +       size_t size =3D 0;
> +
> +       report_enum =3D hdev->report_enum + HID_INPUT_REPORT;
> +
> +       list_for_each_entry(report, &report_enum->report_list, list) =
{
> +               size_t report_size =3D wacom_hid_report_len(report);
> +               if (report_size > size)
> +                       size =3D report_size;
> +       }
> +
> +       return size;
> +}
> +
>  static int wacom_probe(struct hid_device *hdev,
>                 const struct hid_device_id *id)
>  {
>         struct usb_interface *intf =3D to_usb_interface(hdev->dev.par=
ent);
>         struct usb_device *dev =3D interface_to_usbdev(intf);
> -       struct usb_endpoint_descriptor *endpoint;
>         struct wacom *wacom;
>         struct wacom_wac *wacom_wac;
>         struct wacom_features *features;
> @@ -1258,6 +1254,7 @@ static int wacom_probe(struct hid_device *hdev,
>         wacom_wac =3D &wacom->wacom_wac;
>         wacom_wac->features =3D *((struct wacom_features *)id->driver=
_data);
>         features =3D &wacom_wac->features;
> +       features->pktlen =3D wacom_compute_pktlen(hdev);
>         if (features->pktlen > WACOM_PKGLEN_MAX) {
>                 error =3D -EINVAL;
>                 goto fail1;
> @@ -1275,8 +1272,6 @@ static int wacom_probe(struct hid_device *hdev,
>         usb_make_path(dev, wacom->phys, sizeof(wacom->phys));
>         strlcat(wacom->phys, "/input0", sizeof(wacom->phys));
>
> -       endpoint =3D &intf->cur_altsetting->endpoint[0].desc;
> -
>         /* set the default size in case we do not get them from hid *=
/
>         wacom_set_default_phy(features);
>
> @@ -1287,13 +1282,12 @@ static int wacom_probe(struct hid_device *hde=
v,
>
>         /*
>          * Intuos5 has no useful data about its touch interface in it=
s
> -        * HID descriptor. If this is the touch interface (wMaxPacket=
Size
> +        * HID descriptor. If this is the touch interface (PacketSize
>          * of WACOM_PKGLEN_BBTOUCH3), override the table values.
>          */
>         if (features->type >=3D INTUOS5S && features->type <=3D INTUO=
SHT) {
> -               if (endpoint->wMaxPacketSize =3D=3D WACOM_PKGLEN_BBTO=
UCH3) {
> +               if (features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH3) {
>                         features->device_type =3D BTN_TOOL_FINGER;
> -                       features->pktlen =3D WACOM_PKGLEN_BBTOUCH3;
>
>                         features->x_max =3D 4096;
>                         features->y_max =3D 4096;
> --
> 2.0.0
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
