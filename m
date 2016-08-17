From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] mfd: max14577: Change Krzysztof Kozlowski's email to
 kernel.org
Date: Wed, 17 Aug 2016 15:09:02 +0100
Message-ID: <20160817140902.GE4254@dell>
References: <1471435666-11880-1-git-send-email-k.kozlowski@samsung.com>
 <1471435666-11880-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471435666-11880-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 17 Aug 2016, Krzysztof Kozlowski wrote:

> Change my email address to kernel.org instead of Samsung one for the
> purpose of any future contact.  The copyrights remain untouched and are
> attributed to Samsung.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mfd/max14577.c               | 4 ++--
>  include/linux/mfd/max14577-private.h | 2 +-
>  include/linux/mfd/max14577.h         | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
> index 6c245128ab2e..6cbe96b28f42 100644
> --- a/drivers/mfd/max14577.c
> +++ b/drivers/mfd/max14577.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 2014 Samsung Electronics
>   * Chanwoo Choi <cw00.choi@samsung.com>
> - * Krzysztof Kozlowski <k.kozlowski@samsung.com>
> + * Krzysztof Kozlowski <krzk@kernel.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -569,6 +569,6 @@ static void __exit max14577_i2c_exit(void)
>  }
>  module_exit(max14577_i2c_exit);
>  
> -MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>");
> +MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>");
>  MODULE_DESCRIPTION("Maxim 14577/77836 multi-function core driver");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/max14577-private.h b/include/linux/mfd/max14577-private.h
> index f01c1fae4d84..df75234f979d 100644
> --- a/include/linux/mfd/max14577-private.h
> +++ b/include/linux/mfd/max14577-private.h
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 2014 Samsung Electrnoics
>   * Chanwoo Choi <cw00.choi@samsung.com>
> - * Krzysztof Kozlowski <k.kozlowski@samsung.com>
> + * Krzysztof Kozlowski <krzk@kernel.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> diff --git a/include/linux/mfd/max14577.h b/include/linux/mfd/max14577.h
> index ccfaf952c31b..d81b52bb8bee 100644
> --- a/include/linux/mfd/max14577.h
> +++ b/include/linux/mfd/max14577.h
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 2014 Samsung Electrnoics
>   * Chanwoo Choi <cw00.choi@samsung.com>
> - * Krzysztof Kozlowski <k.kozlowski@samsung.com>
> + * Krzysztof Kozlowski <krzk@kernel.org>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
