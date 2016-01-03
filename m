From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: bma150 - constify bma150_cfg structure
Date: Sat, 2 Jan 2016 21:05:03 -0800
Message-ID: <20160103050503.GE23680@dtor-ws>
References: <1451473879-10443-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451473879-10443-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 30, 2015 at 12:11:19PM +0100, Julia Lawall wrote:
> The bma150_cfg structure is never modified, so declare it as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied, thank you.

> 
> ---
>  drivers/input/misc/bma150.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
> index 1d0e61d..b0d4453 100644
> --- a/drivers/input/misc/bma150.c
> +++ b/drivers/input/misc/bma150.c
> @@ -147,7 +147,7 @@ struct bma150_data {
>   * are stated and verified by Bosch Sensortec where they are configured
>   * to provide a generic sensitivity performance.
>   */
> -static struct bma150_cfg default_cfg = {
> +static const struct bma150_cfg default_cfg = {
>  	.any_motion_int = 1,
>  	.hg_int = 1,
>  	.lg_int = 1,
> 

-- 
Dmitry
