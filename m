From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: Remove raport header check.
Date: Mon, 14 May 2012 13:21:25 -0700
Message-ID: <CAF8JNhJozNYzTbEHXHbr2mkOBH-RqxzeFqFWNbTXBLo6oYQppg@mail.gmail.com>
References: <1337012006-6854-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37760 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429Ab2ENUV0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 May 2012 16:21:26 -0400
Received: by yhmm54 with SMTP id m54so4626119yhm.19
        for <linux-input@vger.kernel.org>; Mon, 14 May 2012 13:21:25 -0700 (PDT)
In-Reply-To: <1337012006-6854-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org

On Mon, May 14, 2012 at 9:13 AM, Przemo Firszt <przemo@firszt.eu> wrote=
:
> That check was valid when hid-wacom was only supporting Wacom Graphir=
e, as the
> device raports always start with 0x03. Intuos4 WL high-speed raports
> begin with 0x04, so the check would be filtering out valid reports.

I assume the if-statement was added on purpose. It was most likely
used to filter noises for Graphire.

Should we change to

if (data[0] !=3D 0x03 || (data[0] !=3D 0x04 &&
    hdev->product =3D=3D USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH)) {

        hid_err(hdev, "Unknown report: %d,%d size:%d\n",
					data[0], data[1], size);
        return 0;
}

and remove default case for I4?

Or, remove the if-statement as you suggested and add a default case
for Graphire to post hid_err and exit when data[0] !=3D 3.

Either way works for me.

Ping

>
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> ---
> =A0drivers/hid/hid-wacom.c | =A0 =A04 ----
> =A01 file changed, 4 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 29372ed..324ea74 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -578,10 +578,6 @@ static int wacom_raw_event(struct hid_device *hd=
ev, struct hid_report *report,
> =A0 =A0 =A0 =A0hidinput =3D list_entry(hdev->inputs.next, struct hid_=
input, list);
> =A0 =A0 =A0 =A0input =3D hidinput->input;
>
> - =A0 =A0 =A0 /* Check if this is a tablet report */
> - =A0 =A0 =A0 if (data[0] !=3D 0x03)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> =A0 =A0 =A0 =A0switch (hdev->product) {
> =A0 =A0 =A0 =A0case USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return wacom_gr_parse_report(hdev, wda=
ta, input, data);
> --
> 1.7.10.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
