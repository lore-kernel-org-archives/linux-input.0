From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 3/3] Input: adxl34x - Fix references to adx134x
Date: Fri, 11 Feb 2011 16:31:10 +0100
Message-ID: <4D55563E.4050309@analog.com>
References: <1297438422-25838-1-git-send-email-broonie@opensource.wolfsonmicro.com>  <1297438422-25838-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Reply-To: michael.hennerich@analog.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:45178 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757328Ab1BKPjP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 10:39:15 -0500
In-Reply-To: <1297438422-25838-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On 02/11/2011 04:33 PM, Mark Brown wrote:
> The adxl34x SPI driver has what appears to be a typo referring to the
> device as adx134x with the numeral 1 rather than letter l. This appears
> to be an error so convert.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>   
Thought I fixed that before...
Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/misc/adxl34x-spi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
> index 5231add..f29de22 100644
> --- a/drivers/input/misc/adxl34x-spi.c
> +++ b/drivers/input/misc/adxl34x-spi.c
> @@ -58,7 +58,7 @@ static int adxl34x_spi_read_block(struct device *dev,
>  	return (status < 0) ? status : 0;
>  }
>  
> -static const struct adxl34x_bus_ops adx134x_spi_bops = {
> +static const struct adxl34x_bus_ops adxl34x_spi_bops = {
>  	.bustype	= BUS_SPI,
>  	.write		= adxl34x_spi_write,
>  	.read		= adxl34x_spi_read,
> @@ -77,7 +77,7 @@ static int __devinit adxl34x_spi_probe(struct spi_device *spi)
>  
>  	ac = adxl34x_probe(&spi->dev, spi->irq,
>  			   spi->max_speed_hz > MAX_FREQ_NO_FIFODELAY,
> -			   &adx134x_spi_bops);
> +			   &adxl34x_spi_bops);
>  
>  	if (IS_ERR(ac))
>  		return PTR_ERR(ac);
>   


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif

