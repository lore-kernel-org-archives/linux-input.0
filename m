From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] input: wacom - Bamboo One 1024 pressure fix
Date: Tue, 22 May 2012 10:42:44 -0700
Message-ID: <CAF8JNhLCeS3w9ST4=waLOz1y4TPD_LM4F9dnAVe3TDYhv6txhg@mail.gmail.com>
References: <1337564612-15301-1-git-send-email-chris@cnpbagwell.com>
	<1337564612-15301-2-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56234 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab2EVRmp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 May 2012 13:42:45 -0400
Received: by yhmm54 with SMTP id m54so5698030yhm.19
        for <linux-input@vger.kernel.org>; Tue, 22 May 2012 10:42:44 -0700 (PDT)
In-Reply-To: <1337564612-15301-2-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Sun, May 20, 2012 at 6:43 PM,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> Bamboo One's with ID of 0x6a and 0x6b were added with correct
> indication of 1024 pressure levels but the Graphire packet routine
> was only looking at 9 bits. =A0Increased to 10 bits.
>
> This bug caused these devices to roll over to zero pressure at half
> way mark.
>
> The other devices using this routine only support 256 or 512 range
> and look to fix unused bits at zero.
>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> Reported-by: Tushant Mirchandani <tushantin@gmail.com>

Reviewed-by: Ping Cheng <pingc@wacom.com>

Ping

> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A02 +-
> =A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 004bc1b..869e057 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -248,7 +248,7 @@ static int wacom_graphire_irq(struct wacom_wac *w=
acom)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_X, le16_to=
_cpup((__le16 *)&data[2]));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_Y, le16_to=
_cpup((__le16 *)&data[4]));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (wacom->tool[0] !=3D BTN_TOOL_MOUSE=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_PRESSURE, data[6] | ((data[7] & 0x01) << 8));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_PRESSURE, data[6] | ((data[7] & 0x03) << 8));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input=
, BTN_TOUCH, data[1] & 0x01);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input=
, BTN_STYLUS, data[1] & 0x02);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input=
, BTN_STYLUS2, data[1] & 0x04);
> --
> 1.7.10.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
