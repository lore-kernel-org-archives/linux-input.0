From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 0288/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 14:12:54 +0200
Message-ID: <475c0733-2967-3fec-0559-e6bf5dda37f7@analog.com>
References: <20160802105701.569-1-baolex.ni@intel.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:8106
	"EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965546AbcHBOsQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 10:48:16 -0400
In-Reply-To: <20160802105701.569-1-baolex.ni@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>, dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, chuansheng.liu@intel.com

On 02.08.2016 12:57, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7877.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> index 9c250ae..85e6135 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -497,7 +497,7 @@ static ssize_t ad7877_disable_store(struct device *dev,
>  	return count;
>  }
>
> -static DEVICE_ATTR(disable, 0664, ad7877_disable_show, ad7877_disable_store);
> +static DEVICE_ATTR(disable, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7877_disable_show, ad7877_disable_store);
>
>  static ssize_t ad7877_dac_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
> @@ -527,7 +527,7 @@ static ssize_t ad7877_dac_store(struct device *dev,
>  	return count;
>  }
>
> -static DEVICE_ATTR(dac, 0664, ad7877_dac_show, ad7877_dac_store);
> +static DEVICE_ATTR(dac, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7877_dac_show, ad7877_dac_store);
>
>  static ssize_t ad7877_gpio3_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
> @@ -558,7 +558,7 @@ static ssize_t ad7877_gpio3_store(struct device *dev,
>  	return count;
>  }
>
> -static DEVICE_ATTR(gpio3, 0664, ad7877_gpio3_show, ad7877_gpio3_store);
> +static DEVICE_ATTR(gpio3, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7877_gpio3_show, ad7877_gpio3_store);
>
>  static ssize_t ad7877_gpio4_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
> @@ -589,7 +589,7 @@ static ssize_t ad7877_gpio4_store(struct device *dev,
>  	return count;
>  }
>
> -static DEVICE_ATTR(gpio4, 0664, ad7877_gpio4_show, ad7877_gpio4_store);
> +static DEVICE_ATTR(gpio4, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ad7877_gpio4_show, ad7877_gpio4_store);
>
>  static struct attribute *ad7877_attributes[] = {
>  	&dev_attr_temp1.attr,
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
