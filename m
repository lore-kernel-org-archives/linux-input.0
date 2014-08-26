From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: drv260x: add check for ERM mode and LRA
 Libraries
Date: Tue, 26 Aug 2014 15:46:18 -0700
Message-ID: <20140826224618.GD8377@core.coreip.homeip.net>
References: <1408716696-1126-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408716696-1126-1-git-send-email-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 22, 2014 at 09:11:36AM -0500, Dan Murphy wrote:
> Add a check to ensure that LRA libraries are not mixed with
> the ERM mode.
> 
> If ERM mode and the Library is empty "OR" the
> LRA library then exit.
> 
> As the LRA and empty libraries are not applicable for
> the ERM actuator.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Applied, thank you.

> ---
>  drivers/input/misc/drv260x.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index a7a19e6..d6a26a7 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -564,6 +564,14 @@ static int drv260x_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> +	if (haptics->mode == DRV260X_ERM_MODE &&
> +	    haptics->library == DRV260X_LIB_EMPTY ||
> +	    haptics->library == DRV260X_LIB_LRA) {
> +		dev_err(&client->dev,
> +			"ERM Mode with LRA Library mismatch\n");
> +		return -EINVAL;
> +	}
> +
>  	haptics->regulator = devm_regulator_get(&client->dev, "vbat");
>  	if (IS_ERR(haptics->regulator)) {
>  		error = PTR_ERR(haptics->regulator);
> -- 
> 1.7.9.5
> 

-- 
Dmitry
