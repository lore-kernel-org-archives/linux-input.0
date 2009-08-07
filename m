From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] UCB1400: enable touchscreen interrupt unconditionally
Date: Fri, 7 Aug 2009 15:04:46 +0200
Message-ID: <200908071504.47036.marek.vasut@gmail.com>
References: <479e0fb40908070559o2f31a2dbh48c11328b78c734f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:65137 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbZHGNFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2009 09:05:07 -0400
Received: by fxm28 with SMTP id 28so1310715fxm.17
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2009 06:05:06 -0700 (PDT)
In-Reply-To: <479e0fb40908070559o2f31a2dbh48c11328b78c734f@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pavel Revak <palo@bielyvlk.sk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Dne P=C3=A1 7. srpna 2009 14:59:52 Pavel Revak napsal(a):
> Hi,
>
> Sometimes, when I using the touchscreen, it stops working till next r=
estart
> and I see the following message:
>  "ucb1400: unexpected IE_STATUS =3D 0x0"
>
> The following patch retriggers the touchscreen interrupt unconditiona=
lly.
> This prevents hanging of the touchscreen in case of bogus interrupt
> occurence.
>
> Signed-off-by: Pavel Revak <palo@bielyvlk.sk>
> ---
> diff --git a/drivers/input/touchscreen/ucb1400_ts.c
> b/drivers/input/touchscreen/ucb1400_ts.c
> index 5498662..6752de5 100644
> --- a/drivers/input/touchscreen/ucb1400_ts.c
> +++ b/drivers/input/touchscreen/ucb1400_ts.c
> @@ -168,11 +168,11 @@ static void ucb1400_handle_pending_irq(struct
> ucb1400_ts *ucb)
>         ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, isr);
>         ucb1400_reg_write(ucb->ac97, UCB_IE_CLEAR, 0);
>
> -       if (isr & UCB_IE_TSPX) {
> +       if (isr & UCB_IE_TSPX)
>                 ucb1400_ts_irq_disable(ucb->ac97);
> -               enable_irq(ucb->irq);
> -       } else
> -               printk(KERN_ERR "ucb1400: unexpected IE_STATUS =3D %#=
x\n",
> isr);
> +       else
> +               dev_dbg(&ucb->ts_idev->dev, "ucb1400: unexpected IE_S=
TATUS
> =3D %#x\n", isr);
> +       enable_irq(ucb->irq);
>  }
>
>  static int ucb1400_ts_thread(void *_ucb)

Hi!

looks OK to me, it's a bug that was introduced in the spliting process =
last=20
year by me it seems.

Acked-by: Marek Vasut <marek.vasut@gmail.com>

Dmitry, can we get this in before .32? Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
