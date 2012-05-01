From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: wacom - use dev_xxx() instead of naked printk()s
 and dbg()s
Date: Tue, 1 May 2012 11:23:21 -0500
Message-ID: <CAGzDe_a4ZoeuyCGSuEJ=At+cdp07Er+MYqNG9epcAOOcQ4P-=w@mail.gmail.com>
References: <20120430055130.GA12364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39773 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751846Ab2EAQXX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 May 2012 12:23:23 -0400
Received: by lahj13 with SMTP id j13so2569057lah.19
        for <linux-input@vger.kernel.org>; Tue, 01 May 2012 09:23:21 -0700 (PDT)
In-Reply-To: <20120430055130.GA12364@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Jason Gerecke <killertofu@gmail.com>

On Mon, Apr 30, 2012 at 12:51 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Nice alignment to same debug levels as well.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 15 ++++++++-------
> =A0drivers/input/tablet/wacom_wac.c | =A0 29 +++++++++++++++++++-----=
-----
> =A02 files changed, 27 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 8f3b30b..b3a8bd3 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -522,7 +522,8 @@ static int wacom_retrieve_hid_descriptor(struct u=
sb_interface *intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D usb_get_extra_descriptor(&in=
terface->endpoint[0],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 HID_DEVICET_REPORT, &hid_desc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "wacom:=
 can not retrieve extra class descriptor\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&intf->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "can no=
t retrieve extra class descriptor\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> @@ -1040,13 +1041,13 @@ static void wacom_wireless_work(struct work_s=
truct *work)
> =A0 =A0 =A0 =A0wacom->wacom_wac.input =3D NULL;
>
> =A0 =A0 =A0 =A0if (wacom_wac->pid =3D=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "wacom: wireless table=
t disconnected\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&wacom->intf->dev, "wireless t=
ablet disconnected\n");
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct usb_device_id *id =3D wac=
om_ids;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"wacom: wireless tablet =
connected with PID %x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_wac->pid);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&wacom->intf->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"wireless tablet con=
nected with PID %x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_wac->pid);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (id->match_flags) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (id->idVendor =3D=3D=
 USB_VENDOR_ID_WACOM &&
> @@ -1056,8 +1057,8 @@ static void wacom_wireless_work(struct work_str=
uct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!id->match_flags) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"wacom: =
ignorning unknown PID.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&wacom->intf->=
dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ign=
oring unknown PID.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 10e5cf8..004bc1b 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -61,7 +61,8 @@ static int wacom_penpartner_irq(struct wacom_wac *w=
acom)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "wacom_penpartner_irq:=
 received unknown report #%d\n", data[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(input->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: received unknown r=
eport #%d\n", __func__, data[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0 }
>
> @@ -76,7 +77,8 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
> =A0 =A0 =A0 =A0int prox, pressure;
>
> =A0 =A0 =A0 =A0if (data[0] !=3D WACOM_REPORT_PENABLED) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("wacom_pl_irq: received unknown rep=
ort #%d", data[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(input->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: received unknown r=
eport #%d\n", __func__, data[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> @@ -146,7 +148,8 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
> =A0 =A0 =A0 =A0struct input_dev *input =3D wacom->input;
>
> =A0 =A0 =A0 =A0if (data[0] !=3D WACOM_REPORT_PENABLED) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "wacom_ptu_irq: receiv=
ed unknown report #%d\n", data[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(input->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: received unknown r=
eport #%d\n", __func__, data[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> @@ -175,7 +178,8 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
> =A0 =A0 =A0 =A0struct input_dev *input =3D wacom->input;
> =A0 =A0 =A0 =A0int prox =3D data[1] & 0x20, pressure;
>
> - =A0 =A0 =A0 dbg("wacom_dtu_irq: received report #%d", data[0]);
> + =A0 =A0 =A0 dev_dbg(input->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: received report #%d", __func__, da=
ta[0]);
>
> =A0 =A0 =A0 =A0if (prox) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Going into proximity select tool */
> @@ -211,7 +215,8 @@ static int wacom_graphire_irq(struct wacom_wac *w=
acom)
> =A0 =A0 =A0 =A0int retval =3D 0;
>
> =A0 =A0 =A0 =A0if (data[0] !=3D WACOM_REPORT_PENABLED) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("wacom_graphire_irq: received unkno=
wn report #%d", data[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(input->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: received unknown r=
eport #%d\n", __func__, data[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit;
> =A0 =A0 =A0 =A0}
>
> @@ -489,10 +494,13 @@ static int wacom_intuos_irq(struct wacom_wac *w=
acom)
> =A0 =A0 =A0 =A0unsigned int t;
> =A0 =A0 =A0 =A0int idx =3D 0, result;
>
> - =A0 =A0 =A0 if (data[0] !=3D WACOM_REPORT_PENABLED && data[0] !=3D =
WACOM_REPORT_INTUOSREAD
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 && data[0] !=3D WACOM_REPORT_INTUOSWRIT=
E && data[0] !=3D WACOM_REPORT_INTUOSPAD
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 && data[0] !=3D WACOM_REPORT_INTUOS5PAD=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dbg("wacom_intuos_irq: received unknown=
 report #%d", data[0]);
> + =A0 =A0 =A0 if (data[0] !=3D WACOM_REPORT_PENABLED &&
> + =A0 =A0 =A0 =A0 =A0 data[0] !=3D WACOM_REPORT_INTUOSREAD &&
> + =A0 =A0 =A0 =A0 =A0 data[0] !=3D WACOM_REPORT_INTUOSWRITE &&
> + =A0 =A0 =A0 =A0 =A0 data[0] !=3D WACOM_REPORT_INTUOSPAD &&
> + =A0 =A0 =A0 =A0 =A0 data[0] !=3D WACOM_REPORT_INTUOS5PAD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(input->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: received unknown r=
eport #%d\n", __func__, data[0]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> =A0 =A0 =A0 =A0}
>
> @@ -938,7 +946,8 @@ static int wacom_tpc_irq(struct wacom_wac *wacom,=
 size_t len)
> =A0{
> =A0 =A0 =A0 =A0char *data =3D wacom->data;
>
> - =A0 =A0 =A0 dbg("wacom_tpc_irq: received report #%d", data[0]);
> + =A0 =A0 =A0 dev_dbg(wacom->input->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: received report #%d\n", __func__, =
data[0]);
>
> =A0 =A0 =A0 =A0switch (len) {
> =A0 =A0 =A0 =A0case WACOM_PKGLEN_TPC1FG:
> --
> 1.7.7.6
>
>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
