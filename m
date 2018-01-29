From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7/8] Input: mms114 - add SPDX identifier
Date: Mon, 29 Jan 2018 11:46:59 -0800
Message-ID: <20180129194659.df7nlhwx4demk6o6@dtor-ws>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
 <CGME20180129113331epcas2p193a0a99f660793fbfcf2ec825fac0e2c@epcas2p1.samsung.com>
 <20180129113323.18961-8-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129113323.18961-8-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 29, 2018 at 08:33:22PM +0900, Andi Shyti wrote:
> Replace the original license statement with the SPDX identifier.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/mms114.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index d70c03adf148..3230c92de1ed 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -1,11 +1,8 @@
> -/*
> - * Copyright (C) 2012 Samsung Electronics Co.Ltd
> - * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// Samsung S6SY761 Touchscreen device driver
> +//
> +// Copyright (c) 2012 Samsung Electronics Co., Ltd.
> +// Author: Joonyoung Shim <jy0922.shim@samsung.com>
>  
>  #include <linux/module.h>
>  #include <linux/delay.h>
> -- 
> 2.15.1
> 

-- 
Dmitry
