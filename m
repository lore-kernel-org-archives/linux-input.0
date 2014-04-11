From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Input: ads7846: Fix device usage within attribute show
Date: Fri, 11 Apr 2014 14:53:16 -0700
Message-ID: <5348644C.7070109@roeck-us.net>
References: <1397246613-26538-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:49873 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbaDKVxU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2014 17:53:20 -0400
In-Reply-To: <1397246613-26538-1-git-send-email-alexanders83@web.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexanders83@web.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 04/11/2014 01:03 PM, Alexander Stein wrote:
> With commit e585c40ba (Input: ads7846 - convert to
> hwmon_device_register_with_groups()) the device passed to the attribute's
> show function isn't the spi device as before.
> So fixup the passed device to ads7846_read12_ser.
>
> Signed-off-by: Alexander Stein <alexanders83@web.de>

And I thought I got that right. Oh well.

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/input/touchscreen/ads7846.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 180ff7a..3824369 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -425,7 +425,7 @@ static int ads7845_read12_ser(struct device *dev, unsigned command)
>   name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
>   { \
>   	struct ads7846 *ts = dev_get_drvdata(dev); \
> -	ssize_t v = ads7846_read12_ser(dev, \
> +	ssize_t v = ads7846_read12_ser(&ts->spi->dev, \
>   			READ_12BIT_SER(var)); \
>   	if (v < 0) \
>   		return v; \
>

