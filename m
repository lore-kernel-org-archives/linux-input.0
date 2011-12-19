From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/4] input : wacom - retrieve maximum number of touch points
Date: Sun, 18 Dec 2011 19:22:35 -0600
Message-ID: <CAGzDe_aKEnRBZvTT2qbNXWF+GFi9KBHExX5R=+O5kdM0g1zzKg@mail.gmail.com>
References: <1324082264-32724-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60041 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab1LSBWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Dec 2011 20:22:36 -0500
Received: by eekc4 with SMTP id c4so5014130eek.19
        for <linux-input@vger.kernel.org>; Sun, 18 Dec 2011 17:22:35 -0800 (PST)
In-Reply-To: <1324082264-32724-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, Dec 16, 2011 at 6:37 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> From the HID usage table when it is supported.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 36 ++++++++++++++++++++++++=
+++++++-----
> =A0drivers/input/tablet/wacom_wac.c | =A0 10 ++++------
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A01 +
> =A03 files changed, 36 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index c9588ee..b9736fb 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -31,6 +31,7 @@
> =A0#define HID_COLLECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xa1
> =A0#define HID_COLLECTION_LOGICAL =A0 =A0 =A0 =A0 0x02
> =A0#define HID_COLLECTION_END =A0 =A0 =A0 =A0 =A0 =A0 0xc0
> +#define HID_MT_CONTACTMAX =A0 =A0 =A0 =A0 =A0 =A0 =A00x55

This value is proposed to be added to same digitizer usage table as
the finger and stylus we define a few lines above it.  So I'd use same
naming pattern as those: HID_USAGE_CONTACTMAX.

>
> =A0enum {
> =A0 =A0 =A0 =A0WCM_UNDEFINED =3D 0,
> @@ -191,6 +192,7 @@ static int wacom_parse_logical_collection(unsigne=
d char *report,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D features->y_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_le16(&re=
port[10]);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->touch_max =3D 16;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0length =3D 11;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return length;
> @@ -239,11 +241,18 @@ static int wacom_parse_hid(struct usb_interface=
 *intf,
> =A0 =A0 =A0 =A0int result =3D 0;
> =A0 =A0 =A0 =A0int i =3D 0, usage =3D WCM_UNDEFINED, finger =3D 0, pe=
n =3D 0;
> =A0 =A0 =A0 =A0unsigned char *report;
> + =A0 =A0 =A0 unsigned char *rep_data;
>
> =A0 =A0 =A0 =A0report =3D kzalloc(hid_desc->wDescriptorLength, GFP_KE=
RNEL);
> =A0 =A0 =A0 =A0if (!report)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> + =A0 =A0 =A0 rep_data =3D kmalloc(2, GFP_KERNEL);
> + =A0 =A0 =A0 if (!rep_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out1;
> + =A0 =A0 =A0 }
> +

This function is getting a little long.  I suggest pulling this new
get report that this kmalloc() is related to to its own function.
Then its only alloc'ed on hardware that needs it and keeps function
length shorter.

It also makes it more flexible in case we want to localize all get's
to the wacom_query_tablet_data() function.


> =A0 =A0 =A0 =A0/* retrive report descriptors */
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D usb_control_msg(dev, usb_rc=
vctrlpipe(dev, 0),
> @@ -258,7 +267,7 @@ static int wacom_parse_hid(struct usb_interface *=
intf,
>
> =A0 =A0 =A0 =A0/* No need to parse the Descriptor. It isn't an error =
though */
> =A0 =A0 =A0 =A0if (result < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out2;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < hid_desc->wDescriptorLength; i++) {
>
> @@ -286,16 +295,19 @@ static int wacom_parse_hid(struct usb_interface=
 *intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC2FG) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->touch_max =3D 2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D BAMBOO_PT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_BBTOUCH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->touch_max =3D 2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_phy =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 5]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 8]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 15;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->touch_max =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_phy =3D
> @@ -369,6 +381,19 @@ static int wacom_parse_hid(struct usb_interface =
*intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pen =3D=
 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_MT_CONTACTMAX:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 rep_data[0] =3D 12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 result =3D wacom_get_report(intf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 WAC_HID_FEATURE_REPORT, rep_data[0],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 rep_data, 2, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while=
 (result < 0 && limit++ < WAC_MSG_RETRIES);

I think this loop should be removed and pass WAC_MSG_RETRIES as last
value instead of "1".  Is there any error code besides ETIMEDOUT or
EPIPE that we need to handle that the loop is catching?

Chris

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((re=
sult >=3D 0) && (rep_data[1] > 2))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 features->touch_max =3D rep_data[1];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -389,9 +414,9 @@ static int wacom_parse_hid(struct usb_interface *=
intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - out:
> - =A0 =A0 =A0 result =3D 0;
> - =A0 =A0 =A0 kfree(report);
> + out2: result =3D 0;
> + =A0 =A0 =A0 kfree(rep_data);
> + out1: kfree(report);
> =A0 =A0 =A0 =A0return result;
> =A0}
>
> @@ -873,7 +898,8 @@ static int wacom_probe(struct usb_interface *intf=
, const struct usb_device_id *i
>
> =A0 =A0 =A0 =A0endpoint =3D &intf->cur_altsetting->endpoint[0].desc;
>
> - =A0 =A0 =A0 /* Retrieve the physical and logical size for OEM devic=
es */
> + =A0 =A0 =A0 /* Retrieve the physical and logical size for touch dev=
ices */
> + =A0 =A0 =A0 features->touch_max =3D 0;
> =A0 =A0 =A0 =A0error =3D wacom_retrieve_hid_descriptor(intf, features=
);
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail3;
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index e18f362..33a4359 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -830,7 +830,8 @@ static int wacom_tpc_irq(struct wacom_wac *wacom,=
 size_t len)
> =A0{
> =A0 =A0 =A0 =A0char *data =3D wacom->data;
>
> - =A0 =A0 =A0 dbg("wacom_tpc_irq: received report #%d", data[0]);
> + =A0 =A0 =A0 dbg("wacom_tpc_irq: received report #%d with %d contact=
s",
> + =A0 =A0 =A0 =A0 =A0 =A0data[0], wacom->features.touch_max);
>
> =A0 =A0 =A0 =A0if (len =3D=3D WACOM_PKGLEN_TPC1FG || data[0] =3D=3D W=
ACOM_REPORT_TPC1FG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_tpc_single_touch(wacom, l=
en);
> @@ -1319,7 +1320,7 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->device_type =3D=3D BTN_T=
OOL_FINGER) {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(inp=
ut_dev, 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(inp=
ut_dev, features->touch_max);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(i=
nput_dev, ABS_MT_TOOL_TYPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00, MT_TOOL_MAX, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(i=
nput_dev, ABS_MT_POSITION_X,
> @@ -1374,6 +1375,7 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_FIN=
GER, input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_DOU=
BLETAP, input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(inp=
ut_dev, features->touch_max);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->pktlen =3D=
=3D WACOM_PKGLEN_BBTOUCH3) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_=
bit(BTN_TOOL_TRIPLETAP,
> @@ -1381,13 +1383,9 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_=
bit(BTN_TOOL_QUADTAP,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0input_dev->keybit);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_m=
t_init_slots(input_dev, 16);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_=
set_abs_params(input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ABS_MT_TOUCH_MAJOR,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, 255, 0, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_m=
t_init_slots(input_dev, 2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(i=
nput_dev, ABS_MT_POSITION_X,
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 050acae..6ddd2e4 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -89,6 +89,7 @@ struct wacom_features {
> =A0 =A0 =A0 =A0int pressure_fuzz;
> =A0 =A0 =A0 =A0int distance_fuzz;
> =A0 =A0 =A0 =A0unsigned quirks;
> + =A0 =A0 =A0 unsigned touch_max;
> =A0};
>
> =A0struct wacom_shared {
> --
> 1.7.6.4
>
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
