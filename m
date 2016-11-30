From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 5/5] Input: arizona-haptics - Use SoC component pin
 control functions
Date: Tue, 29 Nov 2016 17:41:35 -0800
Message-ID: <20161130014135.GE20680@dtor-ws>
References: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1480434282-26389-6-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32802 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbcK3Blj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 20:41:39 -0500
Content-Disposition: inline
In-Reply-To: <1480434282-26389-6-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

On Tue, Nov 29, 2016 at 03:44:42PM +0000, Richard Fitzgerald wrote:
> The name of a codec pin can have an optional prefix string, which is
> defined by the SoC machine driver. The snd_soc_dapm_x_pin functions
> take the fully-specified name including the prefix and so the existing
> code would fail to find the pin if the audio machine driver had added
> a prefix.
> 
> Switch to using the snd_soc_component_x_pin equivalent functions that
> take a specified SoC component and automatically add the name prefix to
> the provided pin name.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/misc/arizona-haptics.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
> index 9829363..07ec465 100644
> --- a/drivers/input/misc/arizona-haptics.c
> +++ b/drivers/input/misc/arizona-haptics.c
> @@ -37,6 +37,8 @@ static void arizona_haptics_work(struct work_struct *work)
>  						       struct arizona_haptics,
>  						       work);
>  	struct arizona *arizona = haptics->arizona;
> +	struct snd_soc_component *component =
> +		snd_soc_dapm_to_component(arizona->dapm);
>  	int ret;
>  
>  	if (!haptics->arizona->dapm) {
> @@ -66,7 +68,7 @@ static void arizona_haptics_work(struct work_struct *work)
>  			return;
>  		}
>  
> -		ret = snd_soc_dapm_enable_pin(arizona->dapm, "HAPTICS");
> +		ret = snd_soc_component_enable_pin(component, "HAPTICS");
>  		if (ret != 0) {
>  			dev_err(arizona->dev, "Failed to start HAPTICS: %d\n",
>  				ret);
> @@ -81,7 +83,7 @@ static void arizona_haptics_work(struct work_struct *work)
>  		}
>  	} else {
>  		/* This disable sequence will be a noop if already enabled */
> -		ret = snd_soc_dapm_disable_pin(arizona->dapm, "HAPTICS");
> +		ret = snd_soc_component_disable_pin(component, "HAPTICS");
>  		if (ret != 0) {
>  			dev_err(arizona->dev, "Failed to disable HAPTICS: %d\n",
>  				ret);
> @@ -140,11 +142,14 @@ static int arizona_haptics_play(struct input_dev *input, void *data,
>  static void arizona_haptics_close(struct input_dev *input)
>  {
>  	struct arizona_haptics *haptics = input_get_drvdata(input);
> +	struct snd_soc_component *component;
>  
>  	cancel_work_sync(&haptics->work);
>  
> -	if (haptics->arizona->dapm)
> -		snd_soc_dapm_disable_pin(haptics->arizona->dapm, "HAPTICS");
> +	if (haptics->arizona->dapm) {
> +		component = snd_soc_dapm_to_component(haptics->arizona->dapm);
> +		snd_soc_component_disable_pin(component, "HAPTICS");
> +	}
>  }
>  
>  static int arizona_haptics_probe(struct platform_device *pdev)
> -- 
> 1.9.1
> 

-- 
Dmitry
