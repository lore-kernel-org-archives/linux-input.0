From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: cyapa: fix the copy paste error on electrodes_rx
 value
Date: Tue, 13 Oct 2015 23:34:20 -0700
Message-ID: <20151014063420.GF20406@dtor-ws>
References: <1444630624-5127-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444630624-5127-1-git-send-email-dudl@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: bleung@google.com, sudipm.mukherjee@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 12, 2015 at 02:17:04PM +0800, Dudley Du wrote:
> Fix the copy paste error on the electrodes_rx value set code which will
> cause the electrodes_rx value be always set to the value of electrodes_y.
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Dudley Du <dudl@cypress.com>

Applied (with change to ternary ?: ), thank you.

> ---
>  drivers/input/mouse/cyapa_gen6.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
> index 5f19107..a5eb5ae 100644
> --- a/drivers/input/mouse/cyapa_gen6.c
> +++ b/drivers/input/mouse/cyapa_gen6.c
> @@ -241,14 +241,12 @@ static int cyapa_gen6_read_sys_info(struct cyapa *cyapa)
>  	memcpy(&cyapa->product_id[13], &resp_data[62], 2);
>  	cyapa->product_id[15] = '\0';
>  
> +	/* Get the number of Rx electrodes. */
>  	rotat_align = resp_data[68];
> -	if (rotat_align) {
> +	if (rotat_align)
>  		cyapa->electrodes_rx = cyapa->electrodes_y;
> -		cyapa->electrodes_rx = cyapa->electrodes_y;
> -	} else {
> +	else
>  		cyapa->electrodes_rx = cyapa->electrodes_x;
> -		cyapa->electrodes_rx = cyapa->electrodes_y;
> -	}
>  	cyapa->aligned_electrodes_rx = (cyapa->electrodes_rx + 3) & ~3u;
>  
>  	if (!cyapa->electrodes_x || !cyapa->electrodes_y ||
> -- 
> 1.9.1
> 
> 
> ---------------------------------------------------------------
> This message and any attachments may contain Cypress (or its
> subsidiaries) confidential information. If it has been received
> in error, please advise the sender and immediately delete this
> message.
> ---------------------------------------------------------------
> 

-- 
Dmitry
