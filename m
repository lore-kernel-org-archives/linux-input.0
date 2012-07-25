From: Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: RE: [PATCH] fixed a macro coding style issue
Date: Wed, 25 Jul 2012 10:57:30 +0530
Message-ID: <D958900912E20642BCBC71664EFECE3E6DDBF1163A@BGMAIL02.nvidia.com>
References: <no> <1343193656-2643-1-git-send-email-chenbdchenbd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:14347 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2GYF1g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 01:27:36 -0400
In-Reply-To: <1343193656-2643-1-git-send-email-chenbdchenbd@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baodong Chen <chenbdchenbd@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Baodong Chen
> Sent: Wednesday, July 25, 2012 10:51 AM
> To: dmitry.torokhov@gmail.com
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Baodong
> Chen
> Subject: [PATCH] fixed a macro coding style issue
> 
> Fixed a coding style issue in driver/input/input.c
> 
> Signed-off-by: Baodong Chen <chenbdchenbd@gmail.com>
> ---
>  drivers/input/input.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 8921c61..c96e983 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -845,11 +845,13 @@ int input_set_keycode(struct input_dev *dev,
>  EXPORT_SYMBOL(input_set_keycode);
> 
>  #define MATCH_BIT(bit, max) \
> +	do { \
>  		for (i = 0; i < BITS_TO_LONGS(max); i++) \
>  			if ((id->bit[i] & dev->bit[i]) != id->bit[i]) \
>  				break; \
> -		if (i != BITS_TO_LONGS(max)) \
> -			continue;
> +			if (i != BITS_TO_LONGS(max)) \
> +				continue; \

What is the need for extra indentation here?

> +	} while (0)
> 
>  static const struct input_device_id *input_match_device(struct
> input_handler *handler,
>  							struct input_dev
> *dev)
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
