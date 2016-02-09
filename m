From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] input: adp5589: Fix row 5 handling for adp5589
Date: Tue, 9 Feb 2016 11:24:42 +0100
Message-ID: <56B9BE6A.3080700@analog.com>
References: <1455013795-28180-1-git-send-email-lars@metafoo.de>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0079.outbound.protection.outlook.com ([65.55.169.79]:4087
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932535AbcBIKby (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 05:31:54 -0500
In-Reply-To: <1455013795-28180-1-git-send-email-lars@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 02/09/2016 11:29 AM, Lars-Peter Clausen wrote:
> The adp5589 has row 5, don't skip it when creating the GPIO mapping.
> Otherwise the pin gets reserved as used and it is not possible to use it as
> a GPIO.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/input/keyboard/adp5589-keys.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
> index 4d446d5..c01a1d6 100644
> --- a/drivers/input/keyboard/adp5589-keys.c
> +++ b/drivers/input/keyboard/adp5589-keys.c
> @@ -235,7 +235,7 @@ struct adp5589_kpad {
>   	unsigned short gpimapsize;
>   	unsigned extend_cfg;
>   	bool is_adp5585;
> -	bool adp5585_support_row5;
> +	bool support_row5;
>   #ifdef CONFIG_GPIOLIB
>   	unsigned char gpiomap[ADP5589_MAXGPIO];
>   	bool export_gpio;
> @@ -485,7 +485,7 @@ static int adp5589_build_gpiomap(struct adp5589_kpad *kpad,
>   	if (kpad->extend_cfg & C4_EXTEND_CFG)
>   		pin_used[kpad->var->c4_extend_cfg] = true;
>
> -	if (!kpad->adp5585_support_row5)
> +	if (!kpad->support_row5)
>   		pin_used[5] = true;
>
>   	for (i = 0; i < kpad->var->maxgpio; i++)
> @@ -884,12 +884,13 @@ static int adp5589_probe(struct i2c_client *client,
>
>   	switch (id->driver_data) {
>   	case ADP5585_02:
> -		kpad->adp5585_support_row5 = true;
> +		kpad->support_row5 = true;
>   	case ADP5585_01:
>   		kpad->is_adp5585 = true;
>   		kpad->var = &const_adp5585;
>   		break;
>   	case ADP5589:
> +		kpad->support_row5 = true;
>   		kpad->var = &const_adp5589;
>   		break;
>   	}
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
