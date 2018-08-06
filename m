From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: raydium_i2c_ts - use true and false for boolean
 values
Date: Mon, 6 Aug 2018 15:20:39 -0700
Message-ID: <20180806222039.GA141444@dtor-ws>
References: <20180805003406.GA30522@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180805003406.GA30522@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Aug 04, 2018 at 07:34:06PM -0500, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index d1c09e6..c89853a 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -466,7 +466,7 @@ static bool raydium_i2c_boot_trigger(struct i2c_client *client)
>  		}
>  	}
>  
> -	return 0;
> +	return false;
>  }
>  
>  static bool raydium_i2c_fw_trigger(struct i2c_client *client)
> @@ -492,7 +492,7 @@ static bool raydium_i2c_fw_trigger(struct i2c_client *client)
>  		}
>  	}
>  
> -	return 0;
> +	return false;
>  }
>  
>  static int raydium_i2c_check_path(struct i2c_client *client)
> -- 
> 2.7.4
> 

-- 
Dmitry
