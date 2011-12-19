From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 4/4] input: wacom - add 0xE5 (MT device) support
Date: Sun, 18 Dec 2011 20:07:28 -0600
Message-ID: <CAGzDe_as-4WtU0eH69xMsck8q_uMmsE2A-A3iHB-1zqq2uyD3A@mail.gmail.com>
References: <1324082302-334-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48151 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab1LSCHa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Dec 2011 21:07:30 -0500
Received: by eaaj10 with SMTP id j10so4365024eaa.19
        for <linux-input@vger.kernel.org>; Sun, 18 Dec 2011 18:07:28 -0800 (PST)
In-Reply-To: <1324082302-334-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, Dec 16, 2011 at 6:38 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 26 ++++++------
> =A0drivers/input/tablet/wacom_wac.c | =A0 82 ++++++++++++++++++++++++=
+++++++++++++-
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A08 ++++
> =A03 files changed, 101 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index b9736fb..eee06ef 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -297,6 +297,10 @@ static int wacom_parse_hid(struct usb_interface =
*intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->touch_max =3D 2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D MTSCREEN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_MTOUCH;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D BAMBOO_PT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_BBTOUCH;
> @@ -331,18 +335,15 @@ static int wacom_parse_hid(struct usb_interface=
 *intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_USAGE_Y:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (us=
age =3D=3D WCM_DESKTOP) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0if (finger) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_FINGER;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_TPC2FG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 int type =3D features->type;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D TABLETPC2FG || type =3D=3D MTS=
CREEN) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 6]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 7;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 } else if (features->type =3D=3D BAMBOO_PT) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_BBTOUCH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 } else if (type =3D=3D BAMBOO_PT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> @@ -356,10 +357,6 @@ static int wacom_parse_hid(struct usb_interface =
*intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0} else if (pen) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* penabled only accepts exact bytes of data *=
/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_GRAPHIRE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_PEN;

All makes sense.  Getting rid of duplicate code since X/Y will always
be present.  Maybe worth a 1 line comment now that its cleaned up so
someone doesn't let it creep back in.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_le16(&report[i + =
3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
> @@ -432,7 +429,8 @@ static int wacom_query_tablet_data(struct usb_int=
erface *intf, struct wacom_feat
>
> =A0 =A0 =A0 =A0/* ask to report tablet data if it is MT Tablet PC or
> =A0 =A0 =A0 =A0 * not a Tablet PC */
> - =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
> + =A0 =A0 =A0 if (((features->type =3D=3D TABLETPC2FG) || (features->=
type =3D=3D MTSCREEN))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && features->device_typ=
e !=3D BTN_TOOL_PEN) {

Glad to see this device_type check.  I thought it was probably needed.

I'll have to trust you on this one but its different than Bamboo's.
The set on Bamboo is on Pen and causes it to start sending pen
packets.  IIR, the touch packets are always sending.  So this is
opposite and enables something related to touch?

Assuming you say yes, do you mind changing that to an affirmative
check for TOUCH so it reads:

  if (TOUCH)
    /* do TOUCH set's */
  if (PEN)
    /* do PEN set's */

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[0] =3D 3;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[1] =3D 4;
> @@ -479,9 +477,9 @@ static int wacom_retrieve_hid_descriptor(struct u=
sb_interface *intf,
> =A0 =A0 =A0 =A0features->pressure_fuzz =3D 0;
> =A0 =A0 =A0 =A0features->distance_fuzz =3D 0;
>
> - =A0 =A0 =A0 /* only Tablet PCs and Bamboo P&T need to retrieve the =
info */
> + =A0 =A0 =A0 /* only devices that support touch need to retrieve the=
 info */
> =A0 =A0 =A0 =A0if ((features->type !=3D TABLETPC) && (features->type =
!=3D TABLETPC2FG) &&
> - =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT))
> + =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT) && (features->t=
ype !=3D MTSCREEN))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> =A0 =A0 =A0 =A0if (usb_get_extra_descriptor(interface, HID_DEVICET_HI=
D, &hid_desc)) {
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 8dc185d..1a887a1 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -729,6 +729,73 @@ static int wacom_intuos_irq(struct wacom_wac *wa=
com)
> =A0 =A0 =A0 =A0return 1;
> =A0}
>
> +static int wacom_mt_touch(struct wacom_wac *wacom)
> +{
> + =A0 =A0 =A0 struct wacom_features *features =3D &wacom->features;
> + =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
> + =A0 =A0 =A0 char *data =3D wacom->data;
> + =A0 =A0 =A0 struct input_mt_slot *mt;
> + =A0 =A0 =A0 int i, id =3D -1, j =3D 0, k =3D 4;
> + =A0 =A0 =A0 int x =3D 0, y =3D 0;
> + =A0 =A0 =A0 int current_num_contacts =3D data[2];
> + =A0 =A0 =A0 int contacts_to_send =3D 0;
> + =A0 =A0 =A0 bool touch =3D false;
> +
> + =A0 =A0 =A0 /* reset the counter by the first packet */
> + =A0 =A0 =A0 if (current_num_contacts) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts =3D current_num_=
contacts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts_left =3D current=
_num_contacts;
> + =A0 =A0 =A0 }

It seems that the saved contact values are only processed in case were
data[2] indicates no contact counts in packet.  I would think that
packets with no contacts could be ignored (return) unless there is
some data that must be implied.  Why is it not ignored?

> +
> + =A0 =A0 =A0 /* There are at most 5 contacts per packet */
> + =A0 =A0 =A0 contacts_to_send =3D min(5, (int)features->num_contacts=
_left);

Its not obvious to me if data[2] contains touches in packet or total
touches on screen.

> +
> + =A0 =A0 =A0 for (i =3D 0; i < contacts_to_send; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D le16_to_cpup((__le16 *)&data[k])=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* is there an existing slot for this c=
ontact? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < features->touch_max; =
j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt =3D &input->mt[j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (input_mt_get_value(=
mt, ABS_MT_TRACKING_ID) =3D=3D id )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no. then find an unused slot to fill=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (j >=3D features->touch_max) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < featu=
res->touch_max; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mt =3D =
&input->mt[j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (inp=
ut_mt_get_value(mt, ABS_MT_TRACKING_ID) =3D=3D -1 )
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

This may need a little more thought since hid-multitouch doesn't query
old value.  Is there a case were a touch is removed and new touch
added in same packet?  Probably that would never send the -1 to user
land.

Thats all.

Chris

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch =3D data[k - 1] & 0x1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, j);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (touch) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D le16_to_cpup((__l=
e16 *)&data[k + 6]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 y =3D le16_to_cpup((__l=
e16 *)&data[k + 8]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_POSITION_X, x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_POSITION_Y, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D -1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keep the id from firmware since we n=
eed
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it to process future events
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_TRACKING=
_ID, id);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 k +=3D WACOM_BYTES_PER_MT_PACKET;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 input_mt_report_pointer_emulation(input, true);
> +
> + =A0 =A0 =A0 features->num_contacts_left -=3D contacts_to_send;
> + =A0 =A0 =A0 if (features->num_contacts_left < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->num_contacts_left =3D 0;

Same comment as above.  Could use a comment on why storing this would b=
e needed.

> + =A0 =A0 =A0 return 1;
> +}
> +
> =A0static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
> =A0{
> =A0 =A0 =A0 =A0struct input_dev *input =3D wacom->input;
> @@ -767,6 +834,10 @@ static int wacom_tpc_single_touch(struct wacom_w=
ac *wacom, size_t len)
> =A0 =A0 =A0 =A0bool prox;
> =A0 =A0 =A0 =A0int x =3D 0, y =3D 0;
>
> + =A0 =A0 =A0 if ((wacom->features.touch_max > 1) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (len > =
WACOM_PKGLEN_TPC2FG))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0if (!wacom->shared->stylus_in_proximity) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (len =3D=3D WACOM_PKGLEN_TPC1FG) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prox =3D data[0] & 0x0=
1;
> @@ -847,6 +918,9 @@ static int wacom_tpc_irq(struct wacom_wac *wacom,=
 size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_TPCST:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_tpc_singl=
e_touch(wacom, len);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WACOM_REPORT_TPCMT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_mt_touch(w=
acom);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_PENABLED:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_tpc_pen(w=
acom);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -1088,6 +1162,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac,=
 size_t len)
>
> =A0 =A0 =A0 =A0case TABLETPC:
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> + =A0 =A0 =A0 case MTSCREEN:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_tpc_irq(wacom_wac, len)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -1156,7 +1231,7 @@ void wacom_setup_device_quirks(struct wacom_fea=
tures *features)
>
> =A0 =A0 =A0 =A0/* these device have multiple inputs */
> =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC || features->type =3D=
=3D TABLETPC2FG ||
> - =A0 =A0 =A0 =A0 =A0 features->type =3D=3D BAMBOO_PT)
> + =A0 =A0 =A0 =A0 =A0 features->type =3D=3D BAMBOO_PT || features->ty=
pe =3D=3D MTSCREEN)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->quirks |=3D WACOM_QUIRK_MULT=
I_INPUT;
>
> =A0 =A0 =A0 =A0/* quirk for bamboo touch with 2 low res touches */
> @@ -1330,6 +1405,7 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> + =A0 =A0 =A0 case MTSCREEN:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->device_type =3D=3D BTN_T=
OOL_FINGER) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_init_slots(in=
put_dev, features->touch_max);
> @@ -1629,6 +1705,9 @@ static const struct wacom_features wacom_featur=
es_0xE2 =3D
> =A0static const struct wacom_features wacom_features_0xE3 =3D
> =A0 =A0 =A0 =A0{ "Wacom ISDv4 E3", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A026202, 16325, =A0255,
> =A0 =A0 =A0 =A0 =A00, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES=
 };
> +static const struct wacom_features wacom_features_0xE5 =3D
> + =A0 =A0 =A0 { "Wacom ISDv4 E5", =A0 =A0 =A0 WACOM_PKGLEN_MTOUCH, =A0=
 =A026202, 16325, =A0255,
> + =A0 =A0 =A0 =A0 0, MTSCREEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xE6 =3D
> =A0 =A0 =A0 =A0{ "Wacom ISDv4 E6", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A027760, 15694, =A0255,
> =A0 =A0 =A0 =A0 =A00, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES=
 };
> @@ -1784,6 +1863,7 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x9F) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE2) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE3) },
> + =A0 =A0 =A0 { USB_DEVICE_WACOM(0xE5) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE6) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x47) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xF4) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 1c9dc3e..265b09f 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -24,6 +24,10 @@
> =A0#define WACOM_PKGLEN_BBTOUCH =A0 20
> =A0#define WACOM_PKGLEN_BBTOUCH3 =A064
> =A0#define WACOM_PKGLEN_BBPEN =A0 =A0 10
> +#define WACOM_PKGLEN_MTOUCH =A0 =A062
> +
> +/* wacom data size per MT contact */
> +#define WACOM_BYTES_PER_MT_PACKET =A0 =A0 =A011
>
> =A0/* device IDs */
> =A0#define STYLUS_DEVICE_ID =A0 =A0 =A0 0x02
> @@ -39,6 +43,7 @@
> =A0#define WACOM_REPORT_INTUOSPAD =A0 =A0 =A0 =A0 12
> =A0#define WACOM_REPORT_TPC1FG =A0 =A0 =A0 =A0 =A0 =A06
> =A0#define WACOM_REPORT_TPC2FG =A0 =A0 =A0 =A0 =A0 =A013
> +#define WACOM_REPORT_TPCMT =A0 =A0 =A0 =A0 =A0 =A0 13
> =A0#define WACOM_REPORT_TPCHID =A0 =A0 =A0 =A0 =A0 =A015
> =A0#define WACOM_REPORT_TPCST =A0 =A0 =A0 =A0 =A0 =A0 16
>
> @@ -68,6 +73,7 @@ enum {
> =A0 =A0 =A0 =A0WACOM_MO,
> =A0 =A0 =A0 =A0TABLETPC,
> =A0 =A0 =A0 =A0TABLETPC2FG,
> + =A0 =A0 =A0 MTSCREEN,
> =A0 =A0 =A0 =A0MAX_TYPE
> =A0};
>
> @@ -92,6 +98,8 @@ struct wacom_features {
> =A0 =A0 =A0 =A0int distance_fuzz;
> =A0 =A0 =A0 =A0unsigned quirks;
> =A0 =A0 =A0 =A0unsigned touch_max;
> + =A0 =A0 =A0 unsigned num_contacts;
> + =A0 =A0 =A0 unsigned num_contacts_left;
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
