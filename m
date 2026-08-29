Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA03F105B
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788005668; cv=none; b=HHTZ6Tb26JUgRtd1v7C7lpXqKX8NixPZeECaIbHAEH5xTHVsr/yxeixzg0RE0jN7BtHXKNw7s55hr0GJ+f1FbEAdqkI5GQ7N+P8HbndGZ97td1hOVHKC/fAkdDom92m6KhsMSbrF2SmC+NHzxRuFrt7kzoW2IDhtLbGwhHht7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788005668; c=relaxed/simple;
	bh=KW7HHHmgW8A4KSxm+ZoRDVSUyYqMMfLhPzmx4E4hIrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxSSCUbLCfPi0oje0mw3Q6XJOoyG7sZ+ckl41yjR/hUgramBAZz/FhxCayGa9ZENPAbqoviPdBMYjJQwNTZZkPzZC3EqJwTRyEXIcHtr7V5Do2Ktu7Hz/aChYvm4N82/6SPqK5GidMmPhtnn9jUS+NgeElKJ5KTdRCsutrjNBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPo3iw6C; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPo3iw6C"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc149372c14so1399365a12.1
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788005666; x=1788610466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ZjeSOJ3ZUdiMaD6OgZX4tAy8bDLNB2jkjQ2lfsH+rk=;
        b=oPo3iw6C4d90PDn7KLV+8Wf7PiZz6hH7WVMkB5OxKZ83/EeOiVYx5m5PmOUjBwC3bo
         ZJG7XZOPSttN9XZn9fD/7gcfRxwa9emars5kdmCyTUYsFVW9zngpFWATpCoN6/cEaiEM
         4Vn/jEmYP48X/ar1zwPRtoy462UPkY4ICjWswMzA84y4OaELFzYRu5CvA/8PZJDDfq1G
         iObwBb4VtwgpbCPw06gPAuqdRMse+bL1jFT+MwP751Gp/21e+P9vrmLUSEvDY8x/YMTC
         A/6ruKQsa9QSfXq9wc7/X/joPul7j7dOJ2I3oZ9iTAstD3Q8mAut8n4rqKTph9mXlpKD
         W4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788005666; x=1788610466;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZjeSOJ3ZUdiMaD6OgZX4tAy8bDLNB2jkjQ2lfsH+rk=;
        b=dW2GlSGSm6m7ibKSGz/CEaJGeTsOEBMQu01qXQ8J/YkbqEvb63f5KXxNoPQnP3rCyq
         a4YgTVpySpzm7xF1v8CchWbCICjSIP2QDstTA7DeVMEii8MUNWKGG0XrwjbWK+s6y/cx
         EfH6LrPb/WkW4vBF6y15o5g5zQNX8JeIgLBr4Dd1dT0swp/t2JwHi93kSjMo577D4Y+C
         OmPhvQGGblyVDmiRkK4yecO/G7S0jOllFjuCv3Fiu2AJr/x7D5rJcaRNMDyBNqmVZaYc
         Eu9xHVozD0BD71KwAoY8h0dwUDrr1Cfke/3wC0Kszub/NDFaVkv2IXW63RRow4nf+xpn
         +zjQ==
X-Gm-Message-State: AFuF++k8XUlzbyXm09s4bWdS+sx0VeRxiYXF+RDpxLj7iXKrs5Y7NKzC
	T0R1DG5uq0j6KwcIKL2/HtXeCe2TDjV/bf2OZsF/YRbvqzBcsq4l5rxN
X-Gm-Gg: AYBFou3ZETIE77s9WJr8ZNa09wR7pfHg/e705dkkt3W3ClRwN9FwtuRpH5MHrLybbmz
	dDAbg1hGCuLEHfT1eXyPr/Q9u9PErYk/tdnGhc/XpRBGp1mgLeEBuqvq4QLVGwbL4Vw6DiOfGDg
	jiUKuFQaKBZAidRnoI6R/q2oi0sGCoODqus3tONuTFlPTlOhWGazIosv1uagk8S7DF5F1X0nB6l
	NUcUZXFTki+TM/pOPQjZVU0L/S/hPa+QkrH7jQl31zXsF57jHBvwoXEgUqqSmutSBMLYclw8Pgg
	5wLVPNIbMSEBMqTwyl+uAEK5LvKLrgTdvmI0nD8lSRlKDkrH5EYPFfKdV+ApHvlr3TqTp2CNK4c
	4pnVSLBBS6qXBw1xa4/0EuMYs+Kp5EgMqfmuK2WePYEOn+MCiJ0qQo/6hFWkQkb0EWqH0S9aGcI
	Sr2KktJiM/zHR9Q/MbS/qy8WU2PGbKMXX3r11RoiF9XH603g4Kx4zEu356DVOBJGikFNgpRiVSW
	zlU17gPzspQOsnM75Wrdn6rl/Wzhg==
X-Received: by 2002:a17:90b:4a8c:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-396d0f69d10mr19229013a91.13.1788005666181;
        Sat, 29 Aug 2026 05:14:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54de:b26f:8c97:cc89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm17396388eec.7.2026.08.29.05.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 05:14:25 -0700 (PDT)
Date: Sat, 29 Aug 2026 05:14:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Maurizio Casciano <mauriziocasciano7@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: drv260x: Fix suspend and resume sequencing
Message-ID: <apLD91vzHIrLOPWC@google.com>
References: <cover.input-v2.1787872237.git.mauriziocasciano7@gmail.com>
 <4454f96d3f5b78db90732cea5c1b1373ed0a2d65.1787872237.git.mauriziocasciano7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4454f96d3f5b78db90732cea5c1b1373ed0a2d65.1787872237.git.mauriziocasciano7@gmail.com>

Hi Maurizio,

On Fri, Aug 28, 2026 at 01:16:37AM +0200, Maurizio Casciano wrote:
> Force-feedback playback is queued asynchronously, but system suspend
> can cut the enable GPIO and vbat supply while the worker is pending.
> Quiesce the worker and reject new playback requests after suspend
> begins.

Would it be easier to use disable_work_sync()/enable_work()?

> 
> The enable pin also disables I2C and resets volatile configuration.

Again, this is not true.

> Raise it before communicating on resume, observe the startup delay,
> and rerun device initialization. Restore the same state if regulator
> shutdown aborts suspend.
> 
> Assisted-by: Codex:gpt-5.6-sol sparse
> Signed-off-by: Maurizio Casciano <mauriziocasciano7@gmail.com>
> ---
>  drivers/input/misc/drv260x.c | 42 ++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index f26a9052edd2..c64a86bc9bfd 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -181,6 +181,7 @@
>   * @work: Work item used to off load the enable/disable of the vibration
>   * @enable_gpio: Pointer to the gpio used for enable/disabling
>   * @regulator: Pointer to the regulator for the IC
> + * @suspended: Whether force-feedback work must remain quiesced
>   * @magnitude: Magnitude of the vibration event
>   * @mode: The operating mode of the IC (LRA_NO_CAL, ERM or LRA)
>   * @library: The vibration library to be used
> @@ -194,6 +195,7 @@ struct drv260x_data {
>  	struct work_struct work;
>  	struct gpio_desc *enable_gpio;
>  	struct regulator *regulator;
> +	bool suspended;
>  	u8 magnitude;
>  	u32 mode;
>  	u32 library;
> @@ -215,6 +217,13 @@ static int drv260x_calculate_voltage(unsigned int voltage)
>  	return (voltage * 255 / 5600);
>  }
>  
> +static void drv260x_set_suspended(struct drv260x_data *haptics,
> +				  bool suspended)
> +{
> +	scoped_guard(spinlock_irqsave, &haptics->input_dev->event_lock)
> +		haptics->suspended = suspended;
> +}
> +
>  static void drv260x_worker(struct work_struct *work)
>  {
>  	struct drv260x_data *haptics = container_of(work, struct drv260x_data, work);
> @@ -243,6 +252,9 @@ static int drv260x_haptics_play(struct input_dev *input, void *data,
>  {
>  	struct drv260x_data *haptics = input_get_drvdata(input);
>  
> +	if (haptics->suspended)
> +		return 0;
> +
>  	/* Scale u16 magnitude into u8 register value */
>  	if (effect->u.rumble.strong_magnitude > 0)
>  		haptics->magnitude = effect->u.rumble.strong_magnitude >> 8;
> @@ -583,17 +595,21 @@ static int drv260x_probe(struct i2c_client *client)
>  static int drv260x_suspend(struct device *dev)
>  {
>  	struct drv260x_data *haptics = dev_get_drvdata(dev);
> -	int error;
> +	int error, restore_error;
>  
>  	guard(mutex)(&haptics->input_dev->mutex);
>  
>  	if (input_device_enabled(haptics->input_dev)) {
> +		drv260x_set_suspended(haptics, true);
> +		cancel_work_sync(&haptics->work);
> +
>  		error = regmap_update_bits(haptics->regmap,
>  					   DRV260X_MODE,
>  					   DRV260X_STANDBY_MASK,
>  					   DRV260X_STANDBY);
>  		if (error) {
>  			dev_err(dev, "Failed to set standby mode\n");
> +			drv260x_set_suspended(haptics, false);
>  			return error;
>  		}
>  
> @@ -602,9 +618,15 @@ static int drv260x_suspend(struct device *dev)
>  		error = regulator_disable(haptics->regulator);
>  		if (error) {
>  			dev_err(dev, "Failed to disable regulator\n");
> -			regmap_update_bits(haptics->regmap,
> -					   DRV260X_MODE,
> -					   DRV260X_STANDBY_MASK, 0);
> +
> +			gpiod_set_value(haptics->enable_gpio, 1);
> +			usleep_range(250, 500);
> +			restore_error = drv260x_init(haptics);
> +			if (restore_error)
> +				dev_err(dev, "Failed to restore configuration: %d\n",
> +					restore_error);
> +
> +			drv260x_set_suspended(haptics, false);

If we need error unwinding please use goto style.

Thanks.

-- 
Dmitry
