From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/2] Input: Accelerated touchscreen support for Marvell
 Zylonite
Date: Mon, 02 Mar 2009 14:44:28 +0100
Message-ID: <49ABE2BC.9010401@gmail.com>
References: <1236000228-13025-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:19714 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbZCBNod (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 08:44:33 -0500
In-Reply-To: <1236000228-13025-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 2.3.2009 14:23, Mark Brown wrote:
> index 0000000..b016021
> --- /dev/null
> +++ b/drivers/input/touchscreen/zylonite-wm97xx.c
[...]
> +/*
> + * Pressure readback.
> + *
> + * Set to 1 to read back pen down pressure
> + */
> +static int pressure;
> +module_param(pressure, int, 1);

Weird permissions.

> +/* flush AC97 slot 5 FIFO machines */
> +static void wm97xx_acc_pen_up(struct wm97xx *wm)
> +{
> +	int count = 16;
> +	schedule_timeout_uninterruptible(1);

You meant ssleep(1)?

> +
> +	while (count<  16) {

Weird condition.
+ conding style

> +		MODR;
> +		count--;
> +	}
> +}
> +
> +static int wm97xx_acc_pen_down(struct wm97xx *wm)
> +{
> +	u16 x, y, p = 0x100 | WM97XX_ADCSEL_PRES;
> +	int reads = 0;
> +
> +	/* When the AC97 queue has been drained we need to allow time
> +	 * to buffer up samples otherwise we end up spinning polling
> +	 * for samples.  The controller can't have a suitably low
> +	 * threashold set to use the notifications it gives.
> +	 */
> +	schedule_timeout_uninterruptible(1);

ssleep

> +	if (tries>  5) {

Where is tries defined?

> +static int wm97xx_acc_startup(struct wm97xx *wm)
> +{
> +	int idx = 0;

No need to initialize.

> +static void wm97xx_irq_enable(struct wm97xx *wm, int enable)
> +{
> +	if (enable)
> +		enable_irq(wm->pen_irq);
> +	else
> +		disable_irq(wm->pen_irq);

sync?
