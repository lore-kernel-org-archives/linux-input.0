From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - mark expected switch fall-through
Date: Mon, 15 Oct 2018 11:21:56 -0700
Message-ID: <20181015182156.GD127224@dtor-ws>
References: <20181008170355.GA18107@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008170355.GA18107@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 08, 2018 at 07:03:55PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index bbc122f..d3aacd5 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -488,7 +488,7 @@ static int mxt_lookup_bootloader_address(struct mxt_data *data, bool retry)
>  			bootloader = appmode - 0x24;
>  			break;
>  		}
> -		/* Fall through for normal case */
> +		/* Fall through - for normal case */
>  	case 0x4c:
>  	case 0x4d:
>  	case 0x5a:
> -- 
> 2.7.4
> 

-- 
Dmitry
