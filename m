From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 10/14] Input: auo-pixcir-ts - Replace devm_add_action()
 followed by failure action with devm_add_action_or_reset()
Date: Sat, 13 Jul 2019 01:49:59 -0700
Message-ID: <20190713084959.GA103820@dtor-ws>
References: <20190708123347.12081-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190708123347.12081-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 08, 2019 at 08:33:47PM +0800, Fuqian Huang wrote:
> devm_add_action_or_reset() is introduced as a helper function which 
> internally calls devm_add_action(). If devm_add_action() fails 
> then it will execute the action mentioned and return the error code.
> This reduce source code size (avoid writing the action twice) 
> and reduce the likelyhood of bugs.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/auo-pixcir-ts.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
> index 8e48fbda487a..8e9f3b7b8180 100644
> --- a/drivers/input/touchscreen/auo-pixcir-ts.c
> +++ b/drivers/input/touchscreen/auo-pixcir-ts.c
> @@ -602,9 +602,8 @@ static int auo_pixcir_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> -	error = devm_add_action(&client->dev, auo_pixcir_reset, ts);
> +	error = devm_add_action_or_reset(&client->dev, auo_pixcir_reset, ts);
>  	if (error) {
> -		auo_pixcir_reset(ts);
>  		dev_err(&client->dev, "failed to register reset action, %d\n",
>  			error);
>  		return error;
> -- 
> 2.11.0
> 

-- 
Dmitry
