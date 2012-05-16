From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/3] HID: wacom: Move Graphire raport header check.
Date: Wed, 16 May 2012 09:20:02 -0700
Message-ID: <CAF8JNh+_Jm7Nwppi6quS_8s=J7R0SXvGX+vV--LsUJzjqZdU0w@mail.gmail.com>
References: <1337106748-28437-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:60815 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684Ab2EPQUD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 May 2012 12:20:03 -0400
In-Reply-To: <1337106748-28437-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: jkosina@suse.cz, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 15, 2012 at 11:32 AM, Przemo Firszt <przemo@firszt.eu> wrot=
e:
> That check is valid only for Wacom Graphire, as the device raports al=
ways
> start with 0x03. Intuos4 WL high-speed raports begin with 0x04, so
> the check would be filtering out valid reports.
>
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>

Acked-by: Ping Cheng <pingc@wacom.com> for the series.

Ping

> ---
> =A0drivers/hid/hid-wacom.c | =A0 12 +++++++-----
> =A01 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 29372ed..4fc4eeb 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -578,13 +578,15 @@ static int wacom_raw_event(struct hid_device *h=
dev, struct hid_report *report,
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
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_gr_parse_report(hdev, wdat=
a, input, data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data[0] =3D=3D 0x03) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_gr_parse_r=
eport(hdev, wdata, input, data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_err(hdev, "Unknown =
report: %d,%d size:%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 data[0], data[1], size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i =3D 1;
> --
> 1.7.10.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
