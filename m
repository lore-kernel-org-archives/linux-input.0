From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Thu, 14 Jun 2012 16:51:06 -0700
Message-ID: <CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
	<20120614212335.GA4210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33883 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2FNXvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jun 2012 19:51:08 -0400
Received: by lbbgm6 with SMTP id gm6so2467335lbb.19
        for <linux-input@vger.kernel.org>; Thu, 14 Jun 2012 16:51:06 -0700 (PDT)
In-Reply-To: <20120614212335.GA4210@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dmitry.torokhov@gmail.com, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>

On Thu, Jun 14, 2012 at 2:23 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> This reverts commit 1963518b9b1b8019d33b4b08deee6f873ffa2730.
>
> It was supposed to just add support for new MTSCREEN devices, but
> instead it significantly changed the code handling TABLETPC2FG and
> BAMBOO_PT. =A0That destroys debugability. =A0Back to the drawing boar=
d.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
>
> Ping Cheng wrote:
>
>> Main part of patch is adding support for a new Wacom MT touch
>> packet and labels these devices using MTSCREEN type.
>>
>> Other items of interest:
>
> Agh!
>
> A patch adding new hardware support should not touch existing support
> for other devices at the same time. =A0Especially not cosmetic change=
s.
>
> [1] has an analysis by Bj=F8rn of why those unrelated changes are
> probably buggy,

I feel very bad about the issue. More testing should have been done
among us during the development. Since the patch was touched by more
than one people at linuxwacom.sf.net project, we most likely did not
test TPC2FG devices after last person's change.

> but I don't really care about that at the moment. =A0If
> it were a separate patch with a description explaining what it was
> supposed to do, the normal review process would take care of those
> things. =A0Piggy-backing onto another patch is just not a good idea.

You are right. But it would be hard to follow why we made the other
changes without putting them together, escpecially we had to exchange
ideas among developers due to personal and testing issues.

All in all, I am very sorry about the problem. But reverting back
isn't as easy as it sounds since we have many patches built on it now.
Using your patch requires us the same amount of time to test on other
devices, which does not help us move forward.

So, I propose we make a patch that fixes the issue upstream. Then
backport it to 3.2.18. Does this work for you?

Thank you.

Ping

> How about this patch (untested)?
>
> Thanks,
> Jonathan
>
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D55;bug=3D67716=
4
>
> =A0drivers/input/tablet/wacom.h =A0 =A0 | =A0 =A04 +-
> =A0drivers/input/tablet/wacom_sys.c | =A0 91 +++++++++++++++---------=
-----------
> =A0drivers/input/tablet/wacom_wac.c | =A0 99 ++----------------------=
--------------
> =A0drivers/input/tablet/wacom_wac.h | =A0 =A08 ---
> =A04 files changed, 45 insertions(+), 157 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/waco=
m.h
> index b79d45198d82..b4842d0e61dd 100644
> --- a/drivers/input/tablet/wacom.h
> +++ b/drivers/input/tablet/wacom.h
> @@ -135,6 +135,6 @@ extern const struct usb_device_id wacom_ids[];
>
> =A0void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
> =A0void wacom_setup_device_quirks(struct wacom_features *features);
> -int wacom_setup_input_capabilities(struct input_dev *input_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct wacom_wac *wacom_wac);
> +void wacom_setup_input_capabilities(struct input_dev *input_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct wacom_wac *wacom_wac);
> =A0#endif
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index cad5602d3ce4..a0cc46e5f13c 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -320,10 +320,6 @@ static int wacom_parse_hid(struct usb_interface =
*intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* need to reset back */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0}
> -
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
> @@ -356,15 +352,18 @@ static int wacom_parse_hid(struct usb_interface=
 *intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_USAGE_Y:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (us=
age =3D=3D WCM_DESKTOP) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0if (finger) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 int type =3D features->type;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (type =3D=3D TABLETPC2FG || type =3D=3D MTS=
CREEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_FINGER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_TPC2FG;
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
 =A0 =A0 =A0 =A0 =A0 =A0 } else if (type =3D=3D BAMBOO_PT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 } else if (features->type =3D=3D BAMBOO_PT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_BBTOUCH;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_phy =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_l=
e16(&report[i + 3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> @@ -378,6 +377,10 @@ static int wacom_parse_hid(struct usb_interface =
*intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0} else if (pen) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* penabled only accepts exact bytes of data *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_GRAPHIRE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_PEN;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_le16(&report[i + =
3]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 4;
> @@ -440,29 +443,22 @@ static int wacom_query_tablet_data(struct usb_i=
nterface *intf, struct wacom_feat
> =A0 =A0 =A0 =A0if (!rep_data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error;
>
> - =A0 =A0 =A0 /* ask to report Wacom data */
> - =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_FINGER) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if it is an MT Tablet PC touch */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG |=
|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->type =3D=3D MTSCREEN)=
 {
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
> =A0 =A0 =A0 =A0} else if (features->type !=3D TABLETPC &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->type !=3D WIRELESS &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN_=
TOOL_PEN) {
> @@ -484,7 +480,7 @@ static int wacom_query_tablet_data(struct usb_int=
erface *intf, struct wacom_feat
> =A0}
>
> =A0static int wacom_retrieve_hid_descriptor(struct usb_interface *int=
f,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0struct wacom_features *features)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct wacom_features *features)
> =A0{
> =A0 =A0 =A0 =A0int error =3D 0;
> =A0 =A0 =A0 =A0struct usb_host_interface *interface =3D intf->cur_alt=
setting;
> @@ -512,13 +508,10 @@ static int wacom_retrieve_hid_descriptor(struct=
 usb_interface *intf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* only devices that support touch need to retrieve the=
 info */
> - =A0 =A0 =A0 if (features->type !=3D TABLETPC &&
> - =A0 =A0 =A0 =A0 =A0 features->type !=3D TABLETPC2FG &&
> - =A0 =A0 =A0 =A0 =A0 features->type !=3D BAMBOO_PT &&
> - =A0 =A0 =A0 =A0 =A0 features->type !=3D MTSCREEN) {
> + =A0 =A0 =A0 /* only Tablet PCs and Bamboo P&T need to retrieve the =
info */
> + =A0 =A0 =A0 if ((features->type !=3D TABLETPC) && (features->type !=
=3D TABLETPC2FG) &&
> + =A0 =A0 =A0 =A0 =A0 (features->type !=3D BAMBOO_PT))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> - =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0error =3D usb_get_extra_descriptor(interface, HID_DEVI=
CET_HID, &hid_desc);
> =A0 =A0 =A0 =A0if (error) {
> @@ -990,10 +983,8 @@ static int wacom_register_input(struct wacom *wa=
com)
> =A0 =A0 =A0 =A0int error;
>
> =A0 =A0 =A0 =A0input_dev =3D input_allocate_device();
> - =A0 =A0 =A0 if (!input_dev) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!input_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>
> =A0 =A0 =A0 =A0input_dev->name =3D wacom_wac->name;
> =A0 =A0 =A0 =A0input_dev->dev.parent =3D &intf->dev;
> @@ -1003,20 +994,14 @@ static int wacom_register_input(struct wacom *=
wacom)
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
> - =A0 =A0 =A0 if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(input_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->input =3D NULL;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 return 0;
> -
> -fail2:
> - =A0 =A0 =A0 input_free_device(input_dev);
> - =A0 =A0 =A0 wacom_wac->input =3D NULL;
> -fail1:
> =A0 =A0 =A0 =A0return error;
> =A0}
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 004bc1bb1544..5b31418b416b 100644
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
> @@ -951,10 +882,10 @@ static int wacom_tpc_irq(struct wacom_wac *waco=
m, size_t len)
>
> =A0 =A0 =A0 =A0switch (len) {
> =A0 =A0 =A0 =A0case WACOM_PKGLEN_TPC1FG:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_single_touch(wacom, le=
n);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_tpc_single_touch(wacom,=
 len);
>
> =A0 =A0 =A0 =A0case WACOM_PKGLEN_TPC2FG:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_mt_touch(wacom);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_mt_touch(wacom);
>
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (data[0]) {
> @@ -963,9 +894,6 @@ static int wacom_tpc_irq(struct wacom_wac *wacom,=
 size_t len)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case WACOM_REPORT_TPCST:
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
> @@ -1245,7 +1173,6 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac,=
 size_t len)
>
> =A0 =A0 =A0 =A0case TABLETPC:
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> - =A0 =A0 =A0 case MTSCREEN:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sync =3D wacom_tpc_irq(wacom_wac, len)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -1319,8 +1246,7 @@ void wacom_setup_device_quirks(struct wacom_fea=
tures *features)
> =A0 =A0 =A0 =A0/* these device have multiple inputs */
> =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC || features->type =3D=
=3D TABLETPC2FG ||
> =A0 =A0 =A0 =A0 =A0 =A0features->type =3D=3D BAMBOO_PT || features->t=
ype =3D=3D WIRELESS ||
> - =A0 =A0 =A0 =A0 =A0 (features->type >=3D INTUOS5S && features->type=
 <=3D INTUOS5L) ||
> - =A0 =A0 =A0 =A0 =A0 features->type =3D=3D MTSCREEN)
> + =A0 =A0 =A0 =A0 =A0 (features->type >=3D INTUOS5S && features->type=
 <=3D INTUOS5L))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->quirks |=3D WACOM_QUIRK_MULT=
I_INPUT;
>
> =A0 =A0 =A0 =A0/* quirk for bamboo touch with 2 low res touches */
> @@ -1351,8 +1277,8 @@ static unsigned int wacom_calculate_touch_res(u=
nsigned int logical_max,
> =A0 =A0 =A0 =A0return (logical_max * 100) / physical_max;
> =A0}
>
> -int wacom_setup_input_capabilities(struct input_dev *input_dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct wacom_wac *wacom_wac)
> +void wacom_setup_input_capabilities(struct input_dev *input_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct wacom_wac *wacom_wac)
> =A0{
> =A0 =A0 =A0 =A0struct wacom_features *features =3D &wacom_wac->featur=
es;
> =A0 =A0 =A0 =A0int i;
> @@ -1548,18 +1474,8 @@ int wacom_setup_input_capabilities(struct inpu=
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
> @@ -1645,7 +1561,6 @@ int wacom_setup_input_capabilities(struct input=
_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 return 0;
> =A0}
>
> =A0static const struct wacom_features wacom_features_0x00 =3D
> @@ -1878,9 +1793,6 @@ static const struct wacom_features wacom_featur=
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
> @@ -2059,7 +1971,6 @@ const struct usb_device_id wacom_ids[] =3D {
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x9F) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE2) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE3) },
> - =A0 =A0 =A0 { USB_DEVICE_WACOM(0xE5) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xE6) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0xEC) },
> =A0 =A0 =A0 =A0{ USB_DEVICE_WACOM(0x47) },
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 78fbd3f42009..321269c1ac4c 100644
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
>
> @@ -81,7 +76,6 @@ enum {
> =A0 =A0 =A0 =A0WACOM_MO,
> =A0 =A0 =A0 =A0TABLETPC,
> =A0 =A0 =A0 =A0TABLETPC2FG,
> - =A0 =A0 =A0 MTSCREEN,
> =A0 =A0 =A0 =A0MAX_TYPE
> =A0};
>
> @@ -124,8 +118,6 @@ struct wacom_wac {
> =A0 =A0 =A0 =A0struct input_dev *input;
> =A0 =A0 =A0 =A0int pid;
> =A0 =A0 =A0 =A0int battery_capacity;
> - =A0 =A0 =A0 int num_contacts_left;
> - =A0 =A0 =A0 int *slots;
> =A0};
>
> =A0#endif
> --
> 1.7.10.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
