From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/4] Input: goodix - Allow tweaking of configuration
 file dynamically
Date: Thu, 27 Oct 2016 12:33:44 +0200
Message-ID: <1477564424.2458.9.camel@hadess.net>
References: <20161020195917.20051-1-fcooper@ti.com>
         <20161020195917.20051-3-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161020195917.20051-3-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, dmitry.torokhov@gmail.com, robh+dt@kernel.org, octavian.purdila@intel.com, irina.tirdea@intel.com, merker@debian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, nm@ti.com
List-Id: linux-input@vger.kernel.org

On Thu, 2016-10-20 at 14:59 -0500, Franklin S Cooper Jr wrote:
> Some goodix touchscreen controllers don't have the correct
> configuration
> firmware for the display panel it is attached to. Therefore, settings
> such
> as touchscreen x and y size may need to be passed in via DT and have
> the
> panel reprogrammed for the updated touchscreen resolution.
> 
> This patchset adds support for reading the current configuration
> firmware
> on the panel and allowing it to be modified and rewritten back to the
> device.
> 
> Currently this function is unused but later patches will make use of
> it.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/input/touchscreen/goodix.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index a43c8ca..01e12f8 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -478,6 +478,34 @@ static int goodix_get_gpio_config(struct
> goodix_ts_data *ts)
>  	return 0;
>  }
>  
> +static void goodix_tweak_config(struct goodix_ts_data *ts)
> +{
> +	u8 config[GOODIX_CONFIG_MAX_LENGTH];
> +	int error;
> +	int raw_cfg_len;
> +	u8 check_sum = 0;
> +
> +	raw_cfg_len = ts->cfg_len - 2;
> +
> +	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
> +				config, ts->cfg_len);
> +	if (error) {
> +		dev_warn(&ts->client->dev,
> +			 "Error reading config (%d), avoid tweaking
> config\n",
> +			 error);
> +		return;
> +	}

Please add a placeholder comment here, to go along with the commit
message explanation.

> +	check_sum = goodix_calculate_checksum(ts->cfg_len, config);
> +
> +	config[raw_cfg_len] = check_sum;
> +	config[raw_cfg_len + 1] = 1;
> +
> +	error = goodix_send_cfg(ts, ts->cfg_len, config);
> +	if (error)
> +		dev_warn(&ts->client->dev,
> +			 "Error writing config (%d)\n", error);
> +}
>  /**
>   * goodix_read_config - Read the embedded configuration of the panel
>   *
