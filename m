From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cyapa - mark expected switch fall-throughs
Date: Mon, 15 Oct 2018 11:21:34 -0700
Message-ID: <20181015182134.GC127224@dtor-ws>
References: <20181008153824.GA14336@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008153824.GA14336@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 08, 2018 at 05:38:24PM +0200, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I replaced the "Fallthrough state"
> commern with a proper "Fall through", which is what GCC is expecting to
> find.
> 
> Addresses-Coverity-ID: 114758 ("Missing break in switch")
> Addresses-Coverity-ID: 114759 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/mouse/cyapa_gen3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
> index 076dda4..00e395d 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -1067,7 +1067,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
>  			return error;
>  		}
>  
> -	/* Fallthrough state */
> +	/* Fall through */
>  	case CYAPA_STATE_BL_IDLE:
>  		/* Try to get firmware version in bootloader mode. */
>  		cyapa_gen3_bl_query_data(cyapa);
> @@ -1078,7 +1078,7 @@ static int cyapa_gen3_do_operational_check(struct cyapa *cyapa)
>  			return error;
>  		}
>  
> -	/* Fallthrough state */
> +	/* Fall through */
>  	case CYAPA_STATE_OP:
>  		/*
>  		 * Reading query data before going back to the full mode
> -- 
> 2.7.4
> 

-- 
Dmitry
