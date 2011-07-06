From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 3/3 v2] input : wacom - Cleanup a return value for the old Bamboo
Date: Tue, 5 Jul 2011 21:34:08 -0500
Message-ID: <CAGzDe_Ya8sFhr=h04vhtGqisbHKf7OFA+n=XVGuFo_tf2NVkWA@mail.gmail.com>
References: <1309908360-18866-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33036 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab1GFCeJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 22:34:09 -0400
Received: by iwn6 with SMTP id 6so5714883iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 19:34:09 -0700 (PDT)
In-Reply-To: <1309908360-18866-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pingc@wacom.com>

On Tue, Jul 5, 2011 at 6:26 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> The old code may call input_sync without sending any other events.
> Although the sync event will be ignored in the userland, eliminating
> unnecessary kernel events is the right way to go.

Aligns the code block with previous case statement as well.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 19554a4..03ebcc8 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -300,8 +300,8 @@ static int wacom_graphire_irq(struct wacom_wac *w=
acom)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom-=
>id[1] =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input=
, ABS_MISC, wacom->id[1]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_event(input, EV_=
MSC, MSC_SERIAL, 0xf0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> =A0exit:
> --
> 1.7.5.4
>
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
