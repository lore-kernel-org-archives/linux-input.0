From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom - Advertise BTN_TOOL_PEN and BTN_STYLUS for PenPartner
Date: Fri, 26 Aug 2011 14:48:43 -0700
Message-ID: <CAF8JNhJyptbc6YHH2K3+C=Fxto94GoVApVepStQLGzcepyHUXQ@mail.gmail.com>
References: <1314394285-6994-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60859 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab1HZVsn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Aug 2011 17:48:43 -0400
Received: by yie30 with SMTP id 30so1962555yie.19
        for <linux-input@vger.kernel.org>; Fri, 26 Aug 2011 14:48:43 -0700 (PDT)
In-Reply-To: <1314394285-6994-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Fri, Aug 26, 2011 at 2:31 PM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> The Wacom PenPartner should advertise its stylus tip and button
> in addition to the eraser tool. These are both physically
> present on the hardware, and emitted from 'wacom_penpartner_irq'.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Reviewed-by: Ping Cheng <pingc@wacom.com>

Ping

> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index c1c2f7b..87b0e0d 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1191,13 +1191,13 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
> =A0 =A0 =A0 =A0case PL:
> =A0 =A0 =A0 =A0case PTU:
> =A0 =A0 =A0 =A0case DTU:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_PEN, input_dev->keyb=
it);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_STYLUS, input_dev->keybit=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_STYLUS2, input_dev->keyb=
it);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> =A0 =A0 =A0 =A0case PENPARTNER:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_PEN, input_dev->keyb=
it);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_RUBBER, input_dev->=
keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_STYLUS, input_dev->keybit=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case BAMBOO_PT:
> --
> 1.7.6
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
