From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input - arizona-haptics: Add driver haptics module
 on Arizona CODECs
Date: Tue, 27 Nov 2012 01:08:20 -0800
Message-ID: <20121127090820.GB25658@core.coreip.homeip.net>
References: <1354000088-30517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1354000088-30517-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57059 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758390Ab2K0JIY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 04:08:24 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so5780917pad.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 01:08:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1354000088-30517-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org

On Tue, Nov 27, 2012 at 07:08:06AM +0000, Mark Brown wrote:
> +
> +static int arizona_haptics_probe(struct platform_device *pdev)
> +{
> +	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
> +	struct arizona_haptics *haptics;
> +	int ret;
> +
> +	haptics = kzalloc(sizeof(*haptics), GFP_KERNEL);
> +	if (!haptics)
> +		return -ENOMEM;
> +
> +	haptics->arizona = arizona;
> +
> +	ret = regmap_update_bits(arizona->regmap, ARIZONA_HAPTICS_CONTROL_1,
> +				 ARIZONA_HAP_ACT, arizona->pdata.hap_act);
> +	if (ret != 0) {
> +		dev_err(arizona->dev, "Failed to set haptics actuator: %d\n",
> +			ret);

Leaking haptics memory.

> +		return ret;
> +	}
> +
> +	INIT_WORK(&haptics->work, arizona_haptics_work);
> +
> +	haptics->input_dev = input_allocate_device();
> +	if (haptics->input_dev == NULL) {
> +		dev_err(arizona->dev, "Failed to allocate input device\n");

Leaking haptics memory again.

> +		return -ENOMEM;
> +	}
> +
> +	input_set_drvdata(haptics->input_dev, haptics);
> +
> +	haptics->input_dev->name = "arizona:haptics";
> +	haptics->input_dev->dev.parent = pdev->dev.parent;
> +	haptics->input_dev->close = arizona_haptics_close;
> +	__set_bit(FF_RUMBLE, haptics->input_dev->ffbit);
> +
> +	ret = input_ff_create_memless(haptics->input_dev, NULL,
> +				      arizona_haptics_play);
> +	if (ret < 0) {
> +		dev_err(arizona->dev, "input_ff_create_memless() failed: %d\n",
> +			ret);
> +		goto err_ialloc;
> +	}
> +
> +	ret = input_register_device(haptics->input_dev);
> +	if (ret < 0) {
> +		dev_err(arizona->dev, "couldn't register input device: %d\n",
> +			ret);
> +		goto err_iff;
> +	}
> +
> +	platform_set_drvdata(pdev, haptics);
> +
> +	return 0;
> +
> +err_iff:
> +	if (haptics->input_dev)
> +		input_ff_destroy(haptics->input_dev);
> +err_ialloc:
> +	input_free_device(haptics->input_dev);

You are leaking haptics memory here.
> +
> +	return ret;
> +}
> +
> +static int arizona_haptics_remove(struct platform_device *pdev)
> +{
> +	struct arizona_haptics *haptics = platform_get_drvdata(pdev);
> +
> +	input_unregister_device(haptics->input_dev);
> +

And here as well.

> +	return 0;
> +}
> +

Thanks.

-- 
Dmitry
