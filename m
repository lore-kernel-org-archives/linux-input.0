From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] HID: wacom: fix proximity tool release
Date: Tue, 21 Feb 2012 07:25:39 -0600
Message-ID: <CAGzDe_bDK1LyRttGrKim++NRDCYVdWK=O3fGYabpvqXP5=stRA@mail.gmail.com>
References: <1329682829-24347-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56587 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754863Ab2BUNZl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 08:25:41 -0500
In-Reply-To: <1329682829-24347-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: aris@redhat.com, jkosina@suse.cz, pinglinux@gmail.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

On Sun, Feb 19, 2012 at 2:20 PM, Przemo Firszt <przemo@firszt.eu> wrote=
:
> Don't zero the current tool before reporting its release to the input
> subsystem.
>
> Signed-off-by: Aristeu Rozanski <aris@redhat.com>
> Tested-by: Przemo Firszt <przemo@firszt.eu>
> ---
> =A0drivers/hid/hid-wacom.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 0621047..696b907 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -322,10 +322,10 @@ static void wacom_i4_parse_pen_report(struct wa=
com_data *wdata,
>
> =A0 =A0 =A0 =A0switch (data[1]) {
> =A0 =A0 =A0 =A0case 0x80: /* Out of proximity report */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdata->tool =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input, BTN_TOUCH, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_PRESSURE, =
0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input, wdata->tool, 0=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdata->tool =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_sync(input);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 0xC2: /* Tool report */
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
