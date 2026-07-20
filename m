Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFA414A00;
	Mon, 20 Jul 2026 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550123; cv=none; b=fK5MteM1hFYE08GN/W49Q3Hl4hnIl2WFSzVPocEM2izK5D6dDHGeERRHXGW9cYbrKM9i8qvWh/T6lZjkf9FHJJDClOT9p6vLTqx8lo2+PfHrL1k+nWlucOFIVIZ21ggr4rH1w9MShnCnRnETAEW6VlyGbYO7OL1+PF/fkFRX9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550123; c=relaxed/simple;
	bh=9lOVOnumtAsfQSLOwUN2YsnNLG+2nmHgVr0PkvKkTPg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsfuTBWBo6dV1NOt7FpQPAoysHG4b/HDzxaI6RS2qB8GR/9/yaxWrDA90sj+G1XBGBDBY9RAdnlExYZoZyPcVs3YP9uU2BReUfxcMvEGRyr9Uh/iKXBpAEhtKlQRwjS8OvYnJVqxbc4/znyyDzgQcE/0u1CTcm0BaHYm/1FEMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5/2+3N0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5/2+3N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D5A1F00A3A;
	Mon, 20 Jul 2026 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784550121;
	bh=qWAepaDYSO16i9UQ2qZXK18TNEHcxKr17Fun1bqjqRU=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=c5/2+3N0clE4dlSl21ej0uv0Ss9+sSQ2lyXgS5NvZZI7xNPdzA2WSuMwbP8W0sZ7e
	 weF5lX6YDaofcax9FHtiPTmUZt2HFUH6JEIkV2GBTdwh4fBDg7H+EeJF+ZEQ7HRI/k
	 KWqZ5ASS3jNd68VzEkO6yfKObHq63YuzDDkWBkJorneN7TqXDUgdXW5Hwyqn/Y+/nI
	 CkzrHMyCH2Dd/U8xhSLO/11Yq0gL4SELwlJTBzIaI2gdQ9xfLoH7G2YTLntcTB3val
	 2j1qBLmlhuhLVt4IpuQqTvZtwQaqN/2CNM911y1BPf4IFL2B9UzTLn2tI7ua1ATas7
	 B/WX3qY8F0CPg==
Date: Mon, 20 Jul 2026 13:21:56 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Message-ID: <20260720122156.GA11805@google.com>
References: <20260716090726.2711293-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716090726.2711293-1-lee@kernel.org>

Is Jason back in this week?

Note that all of the Sashiko review comments are pre-existing issues.

> Input subsystem guidelines require that device capabilities are advertised
> before the input device is registered.  The Wacom driver was violating
> this by advertising the SW_MUTE_DEVICE capability post-registration in
> wacom_set_shared_values() (and duplicating it in device-specific setup
> cases).
> 
> Resolve this by moving the SW_MUTE_DEVICE capability setup to
> wacom_setup_touch_input_capabilities() for all touch devices that support
> it, excluding TabletPC devices.
> 
> Additionally, replace the lookup-dependent
> 'wacom_wac->shared->touch->product' references with 'hdev->product'
> inside wacom_setup_touch_input_capabilities() as 'hdev' is already
> available and represents the touch device itself.
> 
> Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> 
> v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's request
> v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch devices
> 
>  drivers/hid/wacom_sys.c |  6 ------
>  drivers/hid/wacom_wac.c | 19 +++++++++++--------
>  2 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f7..6c2a3ddfe366 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
>  			wacom_wac->shared->is_touch_on = true;
>  	}
>  
> -	if (wacom_wac->shared->has_mute_touch_switch &&
> -	    wacom_wac->shared->touch_input) {
> -		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> -		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> -				     SW_MUTE_DEVICE);
> -	}
>  }
>  
>  static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index a29bf051ada7..32c4fd03479e 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3953,6 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
>  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>  					 struct wacom_wac *wacom_wac)
>  {
> +	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
> +	struct hid_device *hdev = wacom->hdev;
>  	struct wacom_features *features = &wacom_wac->features;
>  
>  	if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
> @@ -3963,9 +3965,12 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>  	else
>  		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>  
> -	if (features->type == HID_GENERIC)
> +	if (features->type == HID_GENERIC) {
> +		input_dev->evbit[0] |= BIT_MASK(EV_SW);
> +		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>  		/* setup has already been done */
>  		return 0;
> +	}
>  
>  	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
>  	__set_bit(BTN_TOUCH, input_dev->keybit);
> @@ -3997,19 +4002,17 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>  		input_dev->evbit[0] |= BIT_MASK(EV_SW);
>  		__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>  
> -		if (wacom_wac->shared->touch->product == 0x361) {
> +		if (hdev->product == 0x361) {
>  			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
>  					     0, 12440, 4, 0);
>  			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
>  					     0, 8640, 4, 0);
> -		}
> -		else if (wacom_wac->shared->touch->product == 0x360) {
> +		} else if (hdev->product == 0x360) {
>  			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
>  					     0, 8960, 4, 0);
>  			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
>  					     0, 5920, 4, 0);
> -		}
> -		else if (wacom_wac->shared->touch->product == 0x393) {
> +		} else if (hdev->product == 0x393) {
>  			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
>  					     0, 6400, 4, 0);
>  			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> @@ -4039,8 +4042,8 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>  		fallthrough;
>  
>  	case WACOM_27QHDT:
> -		if (wacom_wac->shared->touch->product == 0x32C ||
> -		    wacom_wac->shared->touch->product == 0xF6) {
> +		if (hdev->product == 0x32C ||
> +		    hdev->product == 0xF6) {
>  			input_dev->evbit[0] |= BIT_MASK(EV_SW);
>  			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>  			wacom_wac->has_mute_touch_switch = true;
> -- 
> 2.55.0.141.g00534a21ce-goog
> 

-- 
Lee Jones
