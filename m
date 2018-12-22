From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: drv2667: fix indentation issues, remove extra tabs
Date: Fri, 21 Dec 2018 17:01:28 -0800
Message-ID: <20181222010128.GB31346@dtor-ws>
References: <20181221231241.15925-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221231241.15925-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 21, 2018 at 11:12:41PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are some statements that are indented incorrectly, fix this by
> removinf the extra tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/misc/drv2667.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
> index 2849bb6906a8..6091f0490e8f 100644
> --- a/drivers/input/misc/drv2667.c
> +++ b/drivers/input/misc/drv2667.c
> @@ -177,9 +177,9 @@ static int drv2667_set_waveform_freq(struct drv2667_data *haptics)
>  		error = regmap_write(haptics->regmap, DRV2667_PAGE, read_buf);
>  		if (error) {
>  			dev_err(&haptics->client->dev,
> -					"Failed to set the page: %d\n", error);
> -				return -EIO;
> -			}
> +				"Failed to set the page: %d\n", error);
> +			return -EIO;
> +		}
>  	}
>  
>  	return error;
> -- 
> 2.19.1
> 

-- 
Dmitry
