From: Jaikumar Ganesh <jaikumarg@gmail.com>
Subject: Re: [PATCH] HID: magicmouse: Fix race in input mapping.
Date: Tue, 20 Sep 2011 13:58:53 -0700
Message-ID: <CACMz=xi2SCmTU9=n4jjj2=J4K2Re1s5yZvSYCv1_LYE_j50EqA@mail.gmail.com>
References: <1316211154-9436-1-git-send-email-jaikumarg@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63552 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1ITU7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 16:59:14 -0400
Received: by qyk30 with SMTP id 30so4342201qyk.19
        for <linux-input@vger.kernel.org>; Tue, 20 Sep 2011 13:59:13 -0700 (PDT)
In-Reply-To: <1316211154-9436-1-git-send-email-jaikumarg@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaikumar Ganesh <jaikumarg@android.com>
Cc: linux-input@vger.kernel.org, mdpoole@troilus.org

Hello

On Fri, Sep 16, 2011 at 3:12 PM, Jaikumar Ganesh <jaikumarg@android.com=
> wrote:
> magicmouse_select_input was being called after device
> registration. Hence, any thread scanning "/dev" for new
> devices will see the input bits change on an open file
> descriptor. Fix this by calling select_input inside
> input_mapping.
>
> Based on discussions with Michael Poole <mdpoole@troilus.org>
>
> Change-Id: I289a37a850977c2cbbc9eb76fbf6c9a28d1833c5
> Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
> ---
> =A0drivers/hid/hid-magicmouse.c | =A0 13 +++++++------
> =A01 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmous=
e.c
> index 56d0539..1175452 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -98,6 +98,7 @@ struct magicmouse_sc {
> =A0 =A0 =A0 =A0int ntouches;
> =A0 =A0 =A0 =A0int scroll_accel;
> =A0 =A0 =A0 =A0unsigned long scroll_jiffies;
> + =A0 =A0 =A0 bool setup_input;
>
> =A0 =A0 =A0 =A0struct {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0short x;
> @@ -437,6 +438,11 @@ static int magicmouse_input_mapping(struct hid_d=
evice *hdev,
> =A0 =A0 =A0 =A0if (!msc->input)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msc->input =3D hi->input;
>
> + =A0 =A0 =A0 if (!msc->setup_input) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 magicmouse_setup_input(msc->input, hdev=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msc->setup_input =3D true;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* Magic Trackpad does not give relative data after sw=
itching to MT */
> =A0 =A0 =A0 =A0if (hi->input->id.product =3D=3D USB_DEVICE_ID_APPLE_M=
AGICTRACKPAD &&
> =A0 =A0 =A0 =A0 =A0 =A0field->flags & HID_MAIN_ITEM_RELATIVE)
> @@ -465,6 +471,7 @@ static int magicmouse_probe(struct hid_device *hd=
ev,
> =A0 =A0 =A0 =A0hid_set_drvdata(hdev, msc);
>
> =A0 =A0 =A0 =A0msc->single_touch_id =3D NO_TOUCHES;
> + =A0 =A0 =A0 msc->setup_input =3D false;
>
> =A0 =A0 =A0 =A0ret =3D hid_parse(hdev);
> =A0 =A0 =A0 =A0if (ret) {
> @@ -478,12 +485,6 @@ static int magicmouse_probe(struct hid_device *h=
dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* We do this after hid-input is done parsing reports s=
o that
> - =A0 =A0 =A0 =A0* hid-input uses the most natural button and axis ID=
s.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (msc->input)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 magicmouse_setup_input(msc->input, hdev=
);
> -
> =A0 =A0 =A0 =A0if (id->product =3D=3D USB_DEVICE_ID_APPLE_MAGICMOUSE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0report =3D hid_register_report(hdev, H=
ID_INPUT_REPORT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MOUSE_REPORT_ID);
> --
> 1.7.3.1
>


Ping for review.

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
