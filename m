From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 01/10] mfd/extcon: max77693: Remove unused extern
 declarations and max77693_dev members
Date: Mon, 04 May 2015 15:45:00 +0900
Message-ID: <5547156C.9030402@samsung.com>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430305114-23598-2-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28503 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbEDGpD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 May 2015 02:45:03 -0400
In-reply-to: <1430305114-23598-2-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org

On 04/29/2015 07:58 PM, Krzysztof Kozlowski wrote:
> Clean up the max77693 private header file by removing:
> 1. Left-overs from previous way of interrupt handling (driver uses
>    regmap_irq_chip).
> 2. Unused members of struct 'max77693_dev' related to interrupts in
>    extcon driver.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/extcon/extcon-max77693.c     | 4 ----
>  include/linux/mfd/max77693-private.h | 8 --------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
> index a66bec8f6252..760e1e2cc1ce 100644
> --- a/drivers/extcon/extcon-max77693.c
> +++ b/drivers/extcon/extcon-max77693.c
> @@ -1218,10 +1218,6 @@ static int max77693_muic_probe(struct platform_device *pdev)
>  			irq_src = MUIC_INT3;
>  			break;
>  		}
> -
> -		if (irq_src < MAX77693_IRQ_GROUP_NR)
> -			info->max77693->irq_masks_cur[irq_src]
> -				= init_data[i].data;
>  	}

When removing the unused statement, I think you better to remove it as following:
because 'enum max77693_irq_source irq_src' is not used.

 	for (i = 0; i < num_init_data; i++) {
-		enum max77693_irq_source irq_src
-				= MAX77693_IRQ_GROUP_NR;
-
 		regmap_write(info->max77693->regmap_muic,
 				init_data[i].addr,
 				init_data[i].data);
-
-		switch (init_data[i].addr) {
-		case MAX77693_MUIC_REG_INTMASK1:
-			irq_src = MUIC_INT1;
-			break;
-		case MAX77693_MUIC_REG_INTMASK2:
-			irq_src = MUIC_INT2;
-			break;
-		case MAX77693_MUIC_REG_INTMASK3:
-			irq_src = MUIC_INT3;
-			break;
-		}
-
-		if (irq_src < MAX77693_IRQ_GROUP_NR)
-			info->max77693->irq_masks_cur[irq_src]
-				= init_data[i].data;
 	}
 
[snip]

Except for upper comment, Looks good to me.

Thanks,
Chanwoo Choi
