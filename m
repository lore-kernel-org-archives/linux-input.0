From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/3 v2] input : wacom - Add serial number for Graphire4
 and old Bamboo
Date: Tue, 5 Jul 2011 21:15:41 -0500
Message-ID: <CAGzDe_ZoXYkRzLPwzeMd4Vkt4H7tbzS=ga7yerxCH3nU27ouNA@mail.gmail.com>
References: <1309908304-18792-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60893 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab1GFCPl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 22:15:41 -0400
Received: by iyb12 with SMTP id 12so5715922iyb.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 19:15:41 -0700 (PDT)
In-Reply-To: <1309908304-18792-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pingc@wacom.com>

On Tue, Jul 5, 2011 at 6:25 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> With the removal of BTN_TOOL_FINGER for tablet buttons and
> expresskeys, serial number is needed to distingush if the
> events were from a regular tool (stylus, eraser, or mouse)
> or the attribures (buttons, strips, or wheels) on the tablet
> since there are overlapped events between the tools and the
> tablet attributes.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

This patch I believe will even work in isolation of others in series
and will fix some pad button issues reported by various graphire
users.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 7ce1294..b93501a 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -265,6 +265,7 @@ static int wacom_graphire_irq(struct wacom_wac *w=
acom)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->id[0] =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_MISC, waco=
m->id[0]); /* report tool id */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input, wacom->tool[0]=
, prox);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_MSC, MSC_SERIAL, =
1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_sync(input); /* sync last event =
*/
> =A0 =A0 =A0 =A0}
>
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
