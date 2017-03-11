From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ARM: pxa: magician: Add support for ADS7846 touchscreen
Date: Sat, 11 Mar 2017 21:43:47 +0100
Message-ID: <8760jfh7cs.fsf@belgarion.home>
References: <b2805fd9-f208-ab60-a58f-eccc15dceebd@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:34680 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbdCKUnx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Mar 2017 15:43:53 -0500
In-Reply-To: <b2805fd9-f208-ab60-a58f-eccc15dceebd@tul.cz> (Petr Cvek's
        message of "Tue, 7 Mar 2017 02:17:55 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> This patch adds support for ADS7846 touchscreen driver.
>
> The basic functionality was tested, x_plate_ohms and y_plate_ohms were
> physically measured. The value pressure_max was empirically set to match
> the measured range, which is affected by x_plate_ohms and ADS samples.

> +static struct platform_device vads7846_device = {
> +	.name	= "reg-fixed-voltage",
> +	.id	= 1,
Why "1" and not "-1" ?

>  /*
> + * Touchscreen
> + */
> +
> +static struct ads7846_platform_data ads7846_pdata = {
> +	.model		= 7846,
> +	.x_plate_ohms	= 317,
> +	.y_plate_ohms	= 500,
> +	.pressure_max	= 1023,	/* with x plate ohms it will overflow 255 */
> +	.debounce_max	= 3,	/* first readout is always bad */
> +	.debounce_tol	= 30,
> +	.debounce_rep	= 0,
> +	.gpio_pendown	= GPIO115_MAGICIAN_nPEN_IRQ,
> +	.keep_vref_on	= 1,	/* TODO can be off? */
Can you remove that TODO please ?
Either put it or not, and amend the commit message to explain the choice you
make and why you make it, either empirically or by measure.

> +struct pxa2xx_spi_chip tsc2046_chip_info = {
> +	.tx_threshold	= 1,
> +	.rx_threshold	= 2,
> +	.timeout	= 64,
> +	/* NOTICE must be GPIO, incompatibility with hw PXA SPI framing */
> +	.gpio_cs	= 14,
Hard encoded value of 14, I don't like it, a GPIO14_xxx would suit me better.

Cheers.

-- 
Robert
