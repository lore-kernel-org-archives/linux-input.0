From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - add Fujitsu Lifebook U745 to force
 crc_enabled
Date: Fri, 6 Nov 2015 11:27:40 -0800
Message-ID: <20151106192740.GB14196@dtor-ws>
References: <1446836485-1006-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446836485-1006-1-git-send-email-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Nov 06, 2015 at 08:01:25PM +0100, Takashi Iwai wrote:
> Another Lifebook machine that needs the same quirk as other similar
> models to make the driver working.
> 
> Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=883192
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 2955f1d0ca6c..537ebb0e193a 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1520,6 +1520,13 @@ static const struct dmi_system_id elantech_dmi_force_crc_enabled[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
>  		},
>  	},
> +	{
> +		/* Fujitsu LIFEBOOK U745 does not work with crc_enabled == 0 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
> +		},
> +	},
>  #endif
>  	{ }
>  };
> -- 
> 2.6.2
> 

-- 
Dmitry
