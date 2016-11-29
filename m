From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: arizona: Use component pin control functions
Date: Tue, 29 Nov 2016 09:25:21 +0000
Message-ID: <20161129092521.GF1867@localhost.localdomain>
References: <1480354350-24978-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1480354350-24978-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50924 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756342AbcK2JYe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 04:24:34 -0500
Content-Disposition: inline
In-Reply-To: <1480354350-24978-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

On Mon, Nov 28, 2016 at 05:32:27PM +0000, Richard Fitzgerald wrote:
> We need to modify the state of some of our own pins and are currently
> not taking account that the pin name may have a name_prefix applied
> to it.
> 
> Replace the snd_soc_dapm_x_pin functions with the equivalent
> snd_soc_component_x_pin functions so that any name_prefix will be
> handled automatically.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/arizona.c | 13 ++++++++-----
>  sound/soc/codecs/cs47l24.c |  2 +-
>  sound/soc/codecs/wm5102.c  |  2 +-
>  sound/soc/codecs/wm5110.c  |  2 +-
>  sound/soc/codecs/wm8998.c  |  2 +-
>  5 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
> index ca5ca9e..01f6ec7 100644
> --- a/sound/soc/codecs/arizona.c
> +++ b/sound/soc/codecs/arizona.c
> @@ -256,7 +256,7 @@ int arizona_init_mono(struct snd_soc_codec *codec)
>  
>  int arizona_init_gpio(struct snd_soc_codec *codec)
>  {
> -	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
> +	struct snd_soc_component *component = &codec->component;

We should probably use snd_soc_dapm_to_component(dapm); here.

>  	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
>  	struct arizona *arizona = priv->arizona;
>  	int i;
> @@ -264,21 +264,24 @@ int arizona_init_gpio(struct snd_soc_codec *codec)
>  	switch (arizona->type) {
>  	case WM5110:
>  	case WM8280:
> -		snd_soc_dapm_disable_pin(dapm, "DRC2 Signal Activity");
> +		snd_soc_component_disable_pin(component,
> +					      "DRC2 Signal Activity");
>  		break;
>  	default:
>  		break;
>  	}
>  
> -	snd_soc_dapm_disable_pin(dapm, "DRC1 Signal Activity");
> +	snd_soc_component_disable_pin(component, "DRC1 Signal Activity");
>  
>  	for (i = 0; i < ARRAY_SIZE(arizona->pdata.gpio_defaults); i++) {
>  		switch (arizona->pdata.gpio_defaults[i] & ARIZONA_GPN_FN_MASK) {
>  		case ARIZONA_GP_FN_DRC1_SIGNAL_DETECT:
> -			snd_soc_dapm_enable_pin(dapm, "DRC1 Signal Activity");
> +			snd_soc_component_enable_pin(component,
> +						     "DRC1 Signal Activity");
>  			break;
>  		case ARIZONA_GP_FN_DRC2_SIGNAL_DETECT:
> -			snd_soc_dapm_enable_pin(dapm, "DRC2 Signal Activity");
> +			snd_soc_component_enable_pin(component,
> +						     "DRC2 Signal Activity");
>  			break;
>  		default:
>  			break;
> diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
> index 1ed1329..275c58a 100644
> --- a/sound/soc/codecs/cs47l24.c
> +++ b/sound/soc/codecs/cs47l24.c
> @@ -1138,7 +1138,7 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
>  	if (ret)
>  		goto err_adsp2_codec_probe;
>  
> -	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
> +	snd_soc_component_disable_pin(&codec->component, "HAPTICS");

ditto for these calls as well.

>  
>  	return 0;
>  
> diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
> index 72ff291..aa590ed 100644
> --- a/sound/soc/codecs/wm5102.c
> +++ b/sound/soc/codecs/wm5102.c
> @@ -1947,7 +1947,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
>  	arizona_init_gpio(codec);
>  	arizona_init_notifiers(codec);
>  
> -	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
> +	snd_soc_component_disable_pin(&codec->component, "HAPTICS");
>  
>  	priv->core.arizona->dapm = dapm;
>  
> diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
> index a9a8bc9..45815b9 100644
> --- a/sound/soc/codecs/wm5110.c
> +++ b/sound/soc/codecs/wm5110.c
> @@ -2295,7 +2295,7 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
>  	if (ret)
>  		goto err_adsp2_codec_probe;
>  
> -	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
> +	snd_soc_component_disable_pin(&codec->component, "HAPTICS");
>  
>  	return 0;
>  
> diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
> index 1e1d9c1..7ccc931 100644
> --- a/sound/soc/codecs/wm8998.c
> +++ b/sound/soc/codecs/wm8998.c
> @@ -1327,7 +1327,7 @@ static int wm8998_codec_probe(struct snd_soc_codec *codec)
>  	arizona_init_gpio(codec);
>  	arizona_init_notifiers(codec);
>  
> -	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
> +	snd_soc_component_disable_pin(&codec->component, "HAPTICS");
>  
>  	return 0;
>  }
> -- 
> 1.9.1

Thanks,
Charles
