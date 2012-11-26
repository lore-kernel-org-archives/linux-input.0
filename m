From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input - arizona-haptics: Add driver haptics module
 on Arizona CODECs
Date: Mon, 26 Nov 2012 15:11:22 -0800
Message-ID: <20121126231122.GA26836@core.coreip.homeip.net>
References: <1353965980-32543-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1353965980-32543-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64408 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412Ab2KZXL1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 18:11:27 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so8390006pbc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 15:11:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353965980-32543-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org

Hi Mark,

On Mon, Nov 26, 2012 at 09:39:38PM +0000, Mark Brown wrote:
> +static int arizona_haptics_play(struct input_dev *input, void *data,
> +				struct ff_effect *effect)
> +{
> +	struct arizona_haptics *haptics = input_get_drvdata(input);
> +	struct arizona *arizona = haptics->arizona;
> +	struct mutex *dapm_mutex = &arizona->dapm->card->dapm_mutex;
> +	u8 val;
> +	int ret;
> +
> +	if (!haptics->arizona->dapm) {
> +		dev_err(arizona->dev, "No DAPM context\n");
> +		return -EBUSY;
> +	}
> +
> +	if (effect->u.rumble.strong_magnitude) {
> +		/* Scale the magnitude into the range the device supports */
> +		if (arizona->pdata.hap_act) {
> +			val = effect->u.rumble.strong_magnitude >> 9;
> +			if (effect->direction < 0x8000)
> +				val += 0x7f;
> +		} else {
> +			val = effect->u.rumble.strong_magnitude >> 8;
> +		}
> +
> +		ret = regmap_update_bits(arizona->regmap,
> +					 ARIZONA_HAPTICS_PHASE_2_INTENSITY,
> +					 ARIZONA_PHASE2_INTENSITY_MASK, val);
> +		if (ret != 0) {
> +			dev_err(arizona->dev, "Failed to set intensity: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		/* This enable sequence will be a noop if already enabled */
> +		ret = regmap_update_bits(arizona->regmap,
> +					 ARIZONA_HAPTICS_CONTROL_1,
> +					 ARIZONA_HAP_CTRL_MASK,
> +					 1 << ARIZONA_HAP_CTRL_SHIFT);
> +		if (ret != 0) {
> +			dev_err(arizona->dev, "Failed to start haptics: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
> +		mutex_lock_nested(dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);

You cannot sleep in play() methods.

Thanks.

-- 
Dmitry
