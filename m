From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH V2 4/5] extcon: arizona: Use SoC component pin control
 functions
Date: Wed, 30 Nov 2016 09:19:14 +0900
Message-ID: <583E1B02.4040000@samsung.com>
References: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <CGME20161129154455epcas3p2f983a463ce7e9de35e78cb8625dcb200@epcas3p2.samsung.com>
 <1480434282-26389-5-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46592 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756396AbcK3ATQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 19:19:16 -0500
In-reply-to: <1480434282-26389-5-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org

Hi Richard,

I have no any objection for this patch.

But, the patch4 is dependent on patch1.
After finished the review of patch1,
I'll add acekd-by tag. 

Best Regards,
Chanwoo Choi

On 2016년 11월 30일 00:44, Richard Fitzgerald wrote:
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
> ---
>  drivers/extcon/extcon-arizona.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index aeab47d..ed78b7c 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -270,9 +270,10 @@ static void arizona_extcon_pulse_micbias(struct arizona_extcon_info *info)
>  	struct arizona *arizona = info->arizona;
>  	const char *widget = arizona_extcon_get_micbias(info);
>  	struct snd_soc_dapm_context *dapm = arizona->dapm;
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
>  	int ret;
>  
> -	ret = snd_soc_dapm_force_enable_pin(dapm, widget);
> +	ret = snd_soc_component_force_enable_pin(component, widget);
>  	if (ret != 0)
>  		dev_warn(arizona->dev, "Failed to enable %s: %d\n",
>  			 widget, ret);
> @@ -280,7 +281,7 @@ static void arizona_extcon_pulse_micbias(struct arizona_extcon_info *info)
>  	snd_soc_dapm_sync(dapm);
>  
>  	if (!arizona->pdata.micd_force_micbias) {
> -		ret = snd_soc_dapm_disable_pin(arizona->dapm, widget);
> +		ret = snd_soc_component_disable_pin(component, widget);
>  		if (ret != 0)
>  			dev_warn(arizona->dev, "Failed to disable %s: %d\n",
>  				 widget, ret);
> @@ -345,6 +346,7 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
>  	struct arizona *arizona = info->arizona;
>  	const char *widget = arizona_extcon_get_micbias(info);
>  	struct snd_soc_dapm_context *dapm = arizona->dapm;
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
>  	bool change;
>  	int ret;
>  
> @@ -352,7 +354,7 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
>  				 ARIZONA_MICD_ENA, 0,
>  				 &change);
>  
> -	ret = snd_soc_dapm_disable_pin(dapm, widget);
> +	ret = snd_soc_component_disable_pin(component, widget);
>  	if (ret != 0)
>  		dev_warn(arizona->dev,
>  			 "Failed to disable %s: %d\n",
> 

