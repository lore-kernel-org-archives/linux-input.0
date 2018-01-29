From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 8/8] Input: mms114 - fix typo in definition
Date: Mon, 29 Jan 2018 11:47:09 -0800
Message-ID: <20180129194709.h4vd3ciwglkncsps@dtor-ws>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
 <CGME20180129113332epcas1p1edee9b62330e4bcfddf4ab7586843ce4@epcas1p1.samsung.com>
 <20180129113323.18961-9-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129113323.18961-9-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 29, 2018 at 08:33:23PM +0900, Andi Shyti wrote:
> It's 'MMS114_INFORMATION', not 'MMS114_INFOMATION'
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/mms114.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index 3230c92de1ed..5b609531b3aa 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -28,7 +28,7 @@
>  
>  /* Read only registers */
>  #define MMS114_PACKET_SIZE		0x0f
> -#define MMS114_INFOMATION		0x10
> +#define MMS114_INFORMATION		0x10
>  #define MMS114_TSP_REV			0xf0
>  
>  #define MMS152_FW_REV			0xe1
> @@ -138,7 +138,7 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
>  
>  	touch_size = packet_size / MMS114_PACKET_NUM;
>  
> -	error = i2c_smbus_read_i2c_block_data(data->client, MMS114_INFOMATION,
> +	error = i2c_smbus_read_i2c_block_data(data->client, MMS114_INFORMATION,
>  					      packet_size, (u8 *)touch);
>  	if (error < 0)
>  		goto out;
> -- 
> 2.15.1
> 

-- 
Dmitry
