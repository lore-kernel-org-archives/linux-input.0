From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Enable ADC Filter on UCB1400
Date: Sun, 2 Aug 2009 12:02:36 +0200
Message-ID: <200908021202.36760.marek.vasut@gmail.com>
References: <200907301922.24818.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:59323 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZHBKCz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2009 06:02:55 -0400
Received: by fxm17 with SMTP id 17so2152105fxm.37
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2009 03:02:54 -0700 (PDT)
In-Reply-To: <200907301922.24818.marek.vasut@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: sameo@linux.intel.com, dmitry.torokhov@gmail.com, palo@bielyvlk.sk

Dne =C4=8Ct 30. =C4=8Dervence 2009 19:22:24 Marek Vasut napsal(a):
> Hi!
>
> please consider applying the following patch. I tested it on Palm
> Tungsten|C (ADCSYNC connected, both disabled and enabled through modu=
le
> parameter) and a friend of mine tested it on Toradex Colibri (ADCSYNC=
 not
> connected, disabled).
>
> Thanks

Hi!

any updates on this? Thanks
>
> From 65cb92df1aba511fbc44d62fa25d5cf38a687952 Mon Sep 17 00:00:00 200=
1
> From: Marek Vasut <marek.vasut@gmail.com>
> Date: Thu, 30 Jul 2009 19:03:10 +0200
> Subject: [PATCH] Enable ADC Filter on UCB1400
>
> This patch enables ADC filtering on UCB1400 codec by default. The
> benefit from this change is mostly on some Colibri boards where the
> ADCSYNC pin of the UCB1400 codec isn't connected causing the touchscr=
een
> to jitter very badly. This change has no visible effect on boards whe=
re
> the ADCSYNC pin is connected.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  drivers/input/touchscreen/ucb1400_ts.c |    6 ++++++
>  include/linux/ucb1400.h                |    4 ++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ucb1400_ts.c
> b/drivers/input/touchscreen/ucb1400_ts.c
> index b2828a3..df8e5f3 100644
> --- a/drivers/input/touchscreen/ucb1400_ts.c
> +++ b/drivers/input/touchscreen/ucb1400_ts.c
> @@ -345,6 +345,7 @@ static int ucb1400_ts_detect_irq(struct ucb1400_t=
s
> *ucb) static int ucb1400_ts_probe(struct platform_device *dev)
>  {
>  	int error, x_res, y_res;
> +	u16 fcsr;
>  	struct ucb1400_ts *ucb =3D dev->dev.platform_data;
>
>  	ucb->ts_idev =3D input_allocate_device();
> @@ -382,6 +383,11 @@ static int ucb1400_ts_probe(struct platform_devi=
ce
> *dev) ucb->ts_idev->evbit[0]		=3D BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY)=
;
>  	ucb->ts_idev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
>
> +	/* Enable ADC filter to prevent horrible jitter on Colibri. This al=
so
> +	 * further reduces jitter on boards where ADCSYNC pin is connected.=
 */
> +	fcsr =3D ucb1400_reg_read(ucb->ac97, UCB_FCSR);
> +	ucb1400_reg_write(ucb->ac97, UCB_FCSR, fcsr | UCB_FCSR_AVE);
> +
>  	ucb1400_adc_enable(ucb->ac97);
>  	x_res =3D ucb1400_ts_read_xres(ucb);
>  	y_res =3D ucb1400_ts_read_yres(ucb);
> diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
> index 464fb34..e489ff6 100644
> --- a/include/linux/ucb1400.h
> +++ b/include/linux/ucb1400.h
> @@ -74,6 +74,10 @@
>
>  #define UCB_ADC_DATA		0x68
>  #define UCB_ADC_DAT_VALID	(1 << 15)
> +
> +#define UCB_FCSR		0x6c
> +#define UCB_FCSR_AVE		(1 << 12)
> +
>  #define UCB_ADC_DAT_MASK	0x3ff
>
>  #define UCB_ID			0x7e

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
