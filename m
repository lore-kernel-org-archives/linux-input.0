From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add Lenovo LaVie Z to the i8042 reset list
Date: Wed, 18 Jul 2018 17:28:49 +0000
Message-ID: <20180718172849.qvfv3s3jyzf3jf6o@penguin>
References: <20180705130849.10479-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705130849.10479-1-wens@csie.org>
Sender: stable-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 05, 2018 at 09:08:49PM +0800, Chen-Yu Tsai wrote:
> The Lenovo LaVie Z laptop requires i8042 to be reset in order to
> consistently detect its Elantech touchpad. The nomux and kbdreset
> quirks are not sufficient.
> 
> It's possible the other LaVie Z models from NEC require this as well.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index b353d494ad40..136f6e7bf797 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -527,6 +527,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
>  		},
>  	},
> +	{
> +		/* Lenovo LaVie Z */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
> +		},
> +	},
>  	{ }
>  };
>  
> -- 
> 2.18.0
> 

-- 
Dmitry
