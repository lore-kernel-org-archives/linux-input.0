From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/5] input - wacom: fix retrieving touch_max bug
Date: Mon, 25 Jun 2012 13:32:40 -0700
Message-ID: <CAF8JNh+gdhAQ2N_kK5zbZrm2HhWd0CfgeCmXX9Bne1gmkeFHmA@mail.gmail.com>
References: <1340655986-25427-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65372 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab2FYUcm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 16:32:42 -0400
Received: by bkcji2 with SMTP id ji2so3609453bkc.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 13:32:40 -0700 (PDT)
In-Reply-To: <1340655986-25427-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Sorry for the noise. Please ignore this patch. Something is wrong with
my codebase.

Ping

On Mon, Jun 25, 2012 at 1:26 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> rep_data has already been declared as a pointer.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom.h =A0 =A0 | =A0 =A02 +-
> =A0drivers/input/tablet/wacom_sys.c | =A0 49 ++++++++-------------
> =A0drivers/input/tablet/wacom_wac.c | =A0 90 +-----------------------=
--------------
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A08 ---
> =A04 files changed, 21 insertions(+), 128 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/waco=
m.h
> index b79d451..51b7e37 100644
> --- a/drivers/input/tablet/wacom.h
> +++ b/drivers/input/tablet/wacom.h
> @@ -135,6 +135,6 @@ extern const struct usb_device_id wacom_ids[];
>
> =A0void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
> =A0void wacom_setup_device_quirks(struct wacom_features *features);
> -int wacom_setup_input_capabilities(struct input_dev *input_dev,
> +void wacom_setup_input_capabilities(struct input_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct wacom_wac *wacom_wac);
> =A0#endif
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 9e8fdcf..0494cec 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -213,7 +213,7 @@ static void wacom_retrieve_report_data(struct usb=
_interface *intf,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[0] =3D 12;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D wacom_get_report(intf, WAC_=
HID_FEATURE_REPORT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 rep_data[0], &rep_data, 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 rep_data[0], rep_data, 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0WAC_MSG_RETRIES);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result >=3D 0 && rep_data[1] > 2)
> @@ -318,9 +318,6 @@ static int wacom_parse_hid(struct usb_interface *=
intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D MTSCREEN)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_MTOUCH;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D BAMBOO_PT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_BBTOUCH;
> @@ -355,7 +352,7 @@ static int wacom_parse_hid(struct usb_interface *=
intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0if (finger) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0int type =3D features->type;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D TABLETPC2FG || type =3D=3D MTS=
CREEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D TABLETPC2FG) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> @@ -437,28 +434,22 @@ static int wacom_query_tablet_data(struct usb_i=
nterface *intf, struct wacom_feat
> =A0 =A0 =A0 =A0if (!rep_data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error;
>
> - =A0 =A0 =A0 /* ask to report Wacom data */
> - =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_FINGER) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if it is an MT Tablet PC touch */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type > TABLETPC) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_dat=
a[0] =3D 3;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_dat=
a[1] =3D 4;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_dat=
a[2] =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_dat=
a[3] =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 report_=
id =3D 3;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D=
 wacom_set_report(intf,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WAC_HID_FEATURE_REPORT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0report_id,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data, 4, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err=
or >=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 error =3D wacom_get_report(intf,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WAC_HID_FEATURE_REPORT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 report_id,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_data, 4, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while ((error < 0 || =
rep_data[1] !=3D 4) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0limi=
t++ < WAC_MSG_RETRIES);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* ask to report tablet data if it is MT Tablet PC or
> + =A0 =A0 =A0 =A0* not a Tablet PC */
> + =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_data[0] =3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_data[1] =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_data[2] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rep_data[3] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 report_id =3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D wacom_set_rep=
ort(intf, WAC_HID_FEATURE_REPORT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0report_id, rep_data, 4, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D=
 wacom_get_report(intf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 WAC_HID_FEATURE_REPORT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 report_id, rep_data, 4, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while ((error < 0 || rep_data[1] !=3D=
 4) && limit++ < WAC_MSG_RETRIES);
> =A0 =A0 =A0 =A0} else if (features->type <=3D BAMBOO_PT &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->type !=3D WIRELESS &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN_=
TOOL_PEN) {
> @@ -1005,9 +996,7 @@ static int wacom_register_input(struct wacom *wa=
com)
> =A0 =A0 =A0 =A0input_set_drvdata(input_dev, wacom);
>
> =A0 =A0 =A0 =A0wacom_wac->input =3D input_dev;
> - =A0 =A0 =A0 error =3D wacom_setup_input_capabilities(input_dev, wac=
om_wac);
> - =A0 =A0 =A0 if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> + =A0 =A0 =A0 wacom_setup_input_capabilities(input_dev, wacom_wac);
>
> =A0 =A0 =A0 =A0error =3D input_register_device(input_dev);
> =A0 =A0 =A0 =A0if (error)
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 4453864..1491a91 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -776,72 +776,6 @@ static int wacom_intuos_irq(struct wacom_wac *wa=
com)
> =A0 =A0 =A0 =A0return 1;
> =A0}
>
> -static int find_slot_from_contactid(struct wacom_wac *wacom, int con=
tactid)
> -{
> - =A0 =A0 =A0 int touch_max =3D wacom->features.touch_max;
> - =A0 =A0 =A0 int i;
> -
> - =A0 =A0 =A0 if (!wacom->slots)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> -
> - =A0 =A0 =A0 for (i =3D 0; i < touch_max; ++i) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->slots[i] =3D=3D contactid)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 for (i =3D 0; i < touch_max; ++i) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->slots[i] =3D=3D -1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return i;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return -1;
> -}
> -
> -static int wacom_mt_touch(struct wacom_wac *wacom)
> -{
> - =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
> - =A0 =A0 =A0 char *data =3D wacom->data;
> - =A0 =A0 =A0 int i;
> - =A0 =A0 =A0 int current_num_contacts =3D data[2];
> - =A0 =A0 =A0 int contacts_to_send =3D 0;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* First packet resets the counter since only the fir=
st
> - =A0 =A0 =A0 =A0* packet in series will have non-zero current_num_co=
ntacts.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (current_num_contacts)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->num_contacts_left =3D current_nu=
m_contacts;
> -
> - =A0 =A0 =A0 /* There are at most 5 contacts per packet */
> - =A0 =A0 =A0 contacts_to_send =3D min(5, wacom->num_contacts_left);
> -
> - =A0 =A0 =A0 for (i =3D 0; i < contacts_to_send; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int offset =3D (WACOM_BYTES_PER_MT_PACK=
ET * i) + 3;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool touch =3D data[offset] & 0x1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int id =3D le16_to_cpup((__le16 *)&data=
[offset + 1]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int slot =3D find_slot_from_contactid(w=
acom, id);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (slot < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, slot);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TO=
OL_FINGER, touch);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (touch) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D le16_to_cpup(=
(__le16 *)&data[offset + 7]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D le16_to_cpup(=
(__le16 *)&data[offset + 9]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_POSITION_X, x);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_MT_POSITION_Y, y);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->slots[slot] =3D touch ? id : -1;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 input_mt_report_pointer_emulation(input, true);
> -
> - =A0 =A0 =A0 wacom->num_contacts_left -=3D contacts_to_send;
> - =A0 =A0 =A0 if (wacom->num_contacts_left < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->num_contacts_left =3D 0;
> -
> - =A0 =A0 =A0 return 1;
> -}
> -
> =A0static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
> =A0{
> =A0 =A0 =A0 =A0struct input_dev *input =3D wacom->input;
> @@ -880,9 +814,6 @@ static int wacom_tpc_single_touch(struct wacom_wa=
c *wacom, size_t len)
> =A0 =A0 =A0 =A0bool prox;
> =A0 =A0 =A0 =A0int x =3D 0, y =3D 0;
>
> - =A0 =A0 =A0 if (wacom->features.touch_max > 1 || len > WACOM_PKGLEN=
_TPC2FG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> =A0 =A0 =A0 =A0if (!wacom->shared->stylus_in_proximity) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (len =3D=3D WACOM_PKGLEN_TPC1FG) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prox =3D data[0] & 0x0=
1;
> @@ -964,9 +895,6 @@ static int wacom_tpc_irq(struct wacom_wac *wacom,=
 size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_TPC1FGE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_tpc_singl=
e_touch(wacom, len);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case WACOM_REPORT_TPCMT:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_mt_touch(w=
acom);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_PENABLED:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_tpc_pen(w=
acom);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -1247,7 +1175,6 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac,=
 size_t len)
> =A0 =A0 =A0 =A0case TABLETPC:
> =A0 =A0 =A0 =A0case TABLETPCE:
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> - =A0 =A0 =A0 case MTSCREEN:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_tpc_irq(wacom_wac, len)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -1351,7 +1278,7 @@ static unsigned int wacom_calculate_touch_res(u=
nsigned int logical_max,
> =A0 =A0 =A0 =A0return (logical_max * 100) / physical_max;
> =A0}
>
> -int wacom_setup_input_capabilities(struct input_dev *input_dev,
> +void wacom_setup_input_capabilities(struct input_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct wacom_wac *wacom_wac)
> =A0{
> =A0 =A0 =A0 =A0struct wacom_features *features =3D &wacom_wac->featur=
es;
> @@ -1548,18 +1475,8 @@ int wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> - =A0 =A0 =A0 case MTSCREEN:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->device_type =3D=3D BTN_T=
OOL_FINGER) {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->slots =3D km=
alloc(features->touch_max *
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(int),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!wacom_wac->slots)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-ENOMEM;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < featu=
res->touch_max; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_w=
ac->slots[i] =3D -1;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_init_slots(in=
put_dev, features->touch_max);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(i=
nput_dev, ABS_MT_TOOL_TYPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00, MT_TOOL_MAX, 0, 0);
> @@ -1646,7 +1563,6 @@ int wacom_setup_input_capabilities(struct input=
_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 return 0;
> =A0}
>
> =A0static const struct wacom_features wacom_features_0x00 =3D
> @@ -1879,9 +1795,6 @@ static const struct wacom_features wacom_featur=
es_0xE3 =3D
> =A0 =A0 =A0 =A0{ "Wacom ISDv4 E3", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A026202, 16325, =A0255,
> =A0 =A0 =A0 =A0 =A00, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES=
,
> =A0 =A0 =A0 =A0 =A0.touch_max =3D 2 };
> -static const struct wacom_features wacom_features_0xE5 =3D
> - =A0 =A0 =A0 { "Wacom ISDv4 E5", =A0 =A0 =A0 WACOM_PKGLEN_MTOUCH, =A0=
 =A026202, 16325, =A0255,
> - =A0 =A0 =A0 =A0 0, MTSCREEN, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> =A0static const struct wacom_features wacom_features_0xE6 =3D
> =A0 =A0 =A0 =A0{ "Wacom ISDv4 E6", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG, =A0=
 =A027760, 15694, =A0255,
> =A0 =A0 =A0 =A0 =A00, TABLETPC2FG, WACOM_INTUOS_RES, WACOM_INTUOS_RES=
,
> @@ -2066,7 +1979,6 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x9F) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE2) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE3) },
> - =A0 =A0 =A0 { USB_DEVICE_WACOM(0xE5) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE6) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xEC) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xED) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index bd5d37b..219272f 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -25,10 +25,6 @@
> =A0#define WACOM_PKGLEN_BBTOUCH3 =A064
> =A0#define WACOM_PKGLEN_BBPEN =A0 =A0 10
> =A0#define WACOM_PKGLEN_WIRELESS =A032
> -#define WACOM_PKGLEN_MTOUCH =A0 =A062
> -
> -/* wacom data size per MT contact */
> -#define WACOM_BYTES_PER_MT_PACKET =A0 =A0 =A011
>
> =A0/* device IDs */
> =A0#define STYLUS_DEVICE_ID =A0 =A0 =A0 0x02
> @@ -45,7 +41,6 @@
> =A0#define WACOM_REPORT_INTUOS5PAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> =A0#define WACOM_REPORT_TPC1FG =A0 =A0 =A0 =A0 =A0 =A06
> =A0#define WACOM_REPORT_TPC2FG =A0 =A0 =A0 =A0 =A0 =A013
> -#define WACOM_REPORT_TPCMT =A0 =A0 =A0 =A0 =A0 =A0 13
> =A0#define WACOM_REPORT_TPCHID =A0 =A0 =A0 =A0 =A0 =A015
> =A0#define WACOM_REPORT_TPCST =A0 =A0 =A0 =A0 =A0 =A0 16
> =A0#define WACOM_REPORT_TPC1FGE =A0 =A0 =A0 =A0 =A0 18
> @@ -83,7 +78,6 @@ enum {
> =A0 =A0 =A0 =A0TABLETPC, =A0 /* add new TPC below */
> =A0 =A0 =A0 =A0TABLETPCE,
> =A0 =A0 =A0 =A0TABLETPC2FG,
> - =A0 =A0 =A0 MTSCREEN,
> =A0 =A0 =A0 =A0MAX_TYPE
> =A0};
>
> @@ -126,8 +120,6 @@ struct wacom_wac {
> =A0 =A0 =A0 =A0struct input_dev *input;
> =A0 =A0 =A0 =A0int pid;
> =A0 =A0 =A0 =A0int battery_capacity;
> - =A0 =A0 =A0 int num_contacts_left;
> - =A0 =A0 =A0 int *slots;
> =A0};
>
> =A0#endif
> --
> 1.7.7.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
