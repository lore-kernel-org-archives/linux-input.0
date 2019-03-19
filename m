From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] input: da9063_onkey: convert header to SPDX
Date: Tue, 19 Mar 2019 13:09:50 +0100
Message-ID: <20190319120950.cu3vpuximogjzdtz@verge.net.au>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318155728.28365-4-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 18, 2019 at 04:57:26PM +0100, Wolfram Sang wrote:
> Covnert the header of the source file to SPDX.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/input/misc/da9063_onkey.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
> index 3e9c353d82ef..7b8ae905a6fb 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -1,16 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * OnKey device driver for DA9063, DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/module.h>
> -- 
> 2.11.0
> 
