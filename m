Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EC496D45
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071465; cv=none; b=T+8ZBrmtg/H13kseIKSpJhYABL38HYwu/Zkj8ehSyG6inw2OtP/PBtnch621mre9wPcTON9GKBO9fPwyXTY45jkz/NNZmWOgCq8uhpLwYtSjI8y5NAywm63QXFVeZJrGXWZgYhQGjtMWJtyyWhWer0DNXL/bs+G1G4ybz3PlBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071465; c=relaxed/simple;
	bh=kCzSgK/7/56jj1CaHyRAggKF1tLaHJG4f4NxZt7okfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3xuQKuUOE13vm8/kknRCNseYzc1bkpXjs6IYASylBG1Be0QU9bqDaRVKdsrgtlAmvQ0Zo7QJNoUncLXGisRwCZYBnfSRAmBUrNyOQDL+8bw/SPnZwEnvrX25Ie0KPN7WVAYuuBK6QnwRH4L3MzRrnd0pQsraJX6Hdia2czDoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk1NVVDU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk1NVVDU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbedf433a99so251129a12.2
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789071461; x=1789676261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrZiMbuCSqLlHdSG53XmpcfvF/ZD0Ig5YuGn8olWAVI=;
        b=Lk1NVVDUmhbrXUrhxlk5q08ri8wVkcWqdDGkh6GJUGxkQzIrtD9M/1fv6agKrq5nRR
         iR/0lBJI/6YRXL/5Pjx8mjywozgxPF+wZcJdxzwbQVwhh1/t6TGjL80o8b1NEOA7Sq/8
         MpyVsXJZ7OXNVKJbnPzyjVCsNHsxbArluvSdeYNVrJRq2COzvpAjp3rtFfk7CQAQE7+I
         0J/TRp74FWmfAZx6DlUujtxCAozyZ7c8C0A+/8IRSSWDrUXRLLAuxIf1O8X5BPZnzw63
         1KdxOioOBchTBPYzVbeciWaD3p7D9DtqRLB9XyX5knvKKmenaVplvC8GHaQMTzmybiwy
         +qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071461; x=1789676261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DrZiMbuCSqLlHdSG53XmpcfvF/ZD0Ig5YuGn8olWAVI=;
        b=l5OdYeBBCgdZbH5hVcLxIT3wWpfS2P4W4BG13vh712miCU7lf3WHCPsHSujF1LIjrA
         uDCe0MsmjiwqRblKDvqN1B+fpRvEl9kWNM7sF7U3cDJqjKtLIQfC+0MYVCFoeEZNCSMQ
         A4DVwXcROIfk0o5NnvOinf8s/MnzCRMs3xFtVMNOJT2kkekB/vJpnsgQ27rONkm/QIHC
         28zIBim/9liLAyOCZkQ/CLolC+m0IAM/qgpTt4V356TQ8wg2fNteDDvZM0GrksNKfqQf
         6rweKdafTChfTVz2c2v/YS7mOsicRGkV+GNTTqc0aMhy2B0yfbm/5gfdbsraXUfxrxal
         UQLA==
X-Gm-Message-State: AFuF++nPN/4rgJRBXUxseZKY1M2k5fqz/rISbN/KW3A5+0Iv77L8UttE
	sfH/8l65i7R6awOS9MywDeI5ciC0mugApT/TUIhsXood4blrk0X5Hy9m
X-Gm-Gg: AYBFou2A8q8FYVeDucrJgDMcZ75QeaKQnObnl8x8GWqcSxfp7WtEraYwJhIRzHBPD4+
	59+lKtuEk0jBBwiSvb8hkZvnYHfw8Y3y+VlBe71xWp3VqKO3ETaOooC2CzNo7ut0p1QP6VmGr2H
	31e3zXmnkpfhHvFUeVDTKjkTl+0UxVMU9VbBqEBQYhnBuRRaeLsxQ7jCIWYq7m3NqrFDYAeRVMC
	+b/6PJX5AbLDgbC0R4kpP7USXodz0rlLrPXF9CLb8zh6krYqaPyGpJSuT4GzPit9u5zQsphIL+O
	ehE70XjBauNn6unBDfNJRfNeTzkKAS3TQY7YXzXkz9Rv1Qcv1Qp3VfxFcT4DBHy/if1VbY5DuRc
	wTrTUblJQCD90cU+ToQhe/AHbk6ieQDUrfRr46v3IXFPhFO5fNpnmgctmzElF6hIho+rkmDFmg0
	Obk0M/u9lFBe7pzqg0/xC7w5ybVtBqig5vnTLoJ+CtqXEmhLkrDCJsLIrbiKG/zBEczylxpgOgt
	3nn6YqGmwDjnD1VfpVKGMjrRT+gmwMgLUMRP26Nqfii6HayqjfdM2eMeoLdtxQEPA==
X-Received: by 2002:a05:6a21:a96:b0:3d3:afeb:880 with SMTP id adf61e73a8af0-3daed895710mr860117637.28.1789071461200;
        Thu, 10 Sep 2026 13:17:41 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm796945c88.3.2026.09.10.13.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:17:40 -0700 (PDT)
Message-ID: <40a5a506-6b06-4c82-8bde-d2d258da7438@gmail.com>
Date: Thu, 10 Sep 2026 13:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] HID: hid-oxp: represent RGB LEDs with a common
 array
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-leds@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-14-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-14-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> Move the existing joystick-ring class device, color components, delayed
> work, and cached settings into a per-LED wrapper owned by each HID
> configuration. Use a tagged state pointer so later LED types can share
> registration and work management without duplicating the lifecycle.
>
> Track only fully initialized work items and walk that count when
> quiescing, suspending, or resuming the configuration. Resolve LED callbacks
> through their containing wrapper, preserving the LED core's drvdata.
>
> Keep a single FULL joystick-ring LED and retain the existing Gen1/Gen2
> 55/57-byte RGB payloads, controls, and defaults. This commit adds no new
> hardware protocol or lighting zones.
>
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>   drivers/hid/hid-oxp.c | 433 +++++++++++++++++++++++++++++-------------
>   1 file changed, 297 insertions(+), 136 deletions(-)
>
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 48fa916..55f8b47 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -198,6 +198,8 @@ struct oxp_bmap_page_2 {
>   	struct oxp_button_idx btn_m2;
>   } __packed;
>   
> +struct oxp_rgb_led;
> +
>   /* Hybrid devices expose RGB and controller configuration on separate HIDs. */
>   struct oxp_hid_cfg {
>   	/* General HID state */
> @@ -218,20 +220,13 @@ struct oxp_hid_cfg {
>   	u8 bmap_format;
>   
>   	/* RGB state */
> -	struct delayed_work oxp_rgb_queue;
> -	struct mc_subled subled_info[3];
> -	struct led_classdev_mc *led_mc;
> -	struct led_classdev_mc cdev;
> +	struct oxp_rgb_led *rgb_leds;
>   	spinlock_t rgb_reply_lock;
>   	struct mutex rgb_mutex; /*serialize complete RGB transactions*/
> -	bool rgb_work_initialized;
>   	bool rgb_reply_pending;
>   	u8 rgb_reply_command;
>   	u8 rgb_reply_zone;
> -	u8 rgb_brightness;
> -	u8 rgb_effect;
> -	u8 rgb_speed;
> -	u8 rgb_en;
> +	u8 rgb_led_count;
>   };
>   
>   enum oxp_gamepad_mode_index {
> @@ -336,6 +331,31 @@ struct oxp_gen_2_rgb_report {
>   	u8 effect;
>   } __packed;
>   
> +enum oxp_rgb_type {
> +	OXP_RGB_FULL,
> +};
> +
> +struct oxp_rgb_full_state {
> +	u8 brightness;
> +	u8 enabled;
> +	u8 effect;
> +	u8 speed;
> +};
> +
> +struct oxp_rgb_led {
> +	struct mc_subled subled_info[3];
> +	struct led_classdev_mc mc_cdev;
> +	struct delayed_work work;
> +	struct oxp_hid_cfg *cfg;
> +	void *state;
> +	u8 type;
> +};
> +
> +struct oxp_rgb_led_desc {
> +	const char *name;
> +	u8 type;
> +};
> +
>   struct oxp_attr {
>   	u8 index;
>   };
> @@ -352,29 +372,55 @@ static u16 get_usage_page(struct hid_device *hdev)
>   	return hdev->collection[0].usage >> 16;
>   }
>   
> +static struct oxp_rgb_led *oxp_rgb_led_by_type(struct oxp_hid_cfg *cfg, u8 type)
> +{
> +	int i;
> +
> +	for (i = 0; i < cfg->rgb_led_count; i++)
> +		if (cfg->rgb_leds[i].type == type)
> +			return &cfg->rgb_leds[i];
> +
> +	return NULL;
> +}
> +
> +static struct oxp_rgb_full_state *oxp_rgb_full_state(struct oxp_rgb_led *led)
> +{
> +	if (!led)
> +		return NULL;
> +
> +	switch (led->type) {
> +	case OXP_RGB_FULL:
> +		return led->state;
> +	}
> +
> +	return NULL;
> +}
> +
>   static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
>   				   struct hid_report *report, u8 *data,
>   				   int size)
>   {
>   	struct oxp_hid_cfg *cfg = hid_get_drvdata(hdev);
> -	struct led_classdev_mc *led_mc = cfg->led_mc;
> +	struct oxp_rgb_led *led = oxp_rgb_led_by_type(cfg, OXP_RGB_FULL);
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
>   	struct oxp_gen_1_rgb_report *rgb_rep;
> +	struct led_classdev_mc *led_mc;
>   
> -	if (size < sizeof(*rgb_rep) || !led_mc)
> +	if (size < sizeof(*rgb_rep) || !state)
>   		return 0;
>   
>   	if (data[1] != OXP_FID_GEN1_RGB_REPLY)
>   		return 0;
>   
> +	led_mc = &led->mc_cdev;
>   	rgb_rep = (struct oxp_gen_1_rgb_report *)data;
>   	/* Ensure we save monocolor as the list value */
> -	cfg->rgb_effect = rgb_rep->effect == OXP_EFFECT_MONO_TRUE ?
> -			     OXP_EFFECT_MONO_LIST :
> -			     rgb_rep->effect;
> -	cfg->rgb_speed = rgb_rep->speed;
> -	cfg->rgb_en = rgb_rep->enabled == 0 ? OXP_FEAT_DISABLED :
> -						 OXP_FEAT_ENABLED;
> -	cfg->rgb_brightness = rgb_rep->brightness;
> +	state->effect = rgb_rep->effect == OXP_EFFECT_MONO_TRUE ?
> +			OXP_EFFECT_MONO_LIST : rgb_rep->effect;
> +	state->speed = rgb_rep->speed;
> +	state->enabled = rgb_rep->enabled == 0 ? OXP_FEAT_DISABLED :
> +					       OXP_FEAT_ENABLED;
> +	state->brightness = rgb_rep->brightness;
>   	led_mc->led_cdev.brightness = rgb_rep->brightness *
>   				      led_mc->led_cdev.max_brightness / 4;
>   	/* If monocolor had less than 100% brightness on the previous boot,
> @@ -441,8 +487,10 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
>   				   int size)
>   {
>   	struct oxp_hid_cfg *cfg = hid_get_drvdata(hdev);
> -	struct led_classdev_mc *led_mc = cfg->led_mc;
> +	struct oxp_rgb_led *led = oxp_rgb_led_by_type(cfg, OXP_RGB_FULL);
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
>   	struct oxp_gen_2_rgb_report *rgb_rep;
> +	struct led_classdev_mc *led_mc;
>   	bool solicited = false;
>   
>   	if (size < OXP_STATUS_HEADER_SIZE)
> @@ -479,22 +527,22 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
>   
>   	if (data[3] != OXP_GET_PROPERTY)
>   		return 0;
> -	if (size < sizeof(*rgb_rep) || !led_mc)
> +	if (size < sizeof(*rgb_rep) || !state)
>   		return 0;
>   
> +	led_mc = &led->mc_cdev;
>   	rgb_rep = (struct oxp_gen_2_rgb_report *)data;
>   	if (rgb_rep->enabled > OXP_FEAT_ENABLED || rgb_rep->speed > 9 ||
>   	    rgb_rep->brightness > 4)
>   		return 0;
>   
>   	/* Ensure we save monocolor as the list value */
> -	cfg->rgb_effect = rgb_rep->effect == OXP_EFFECT_MONO_TRUE ?
> -			     OXP_EFFECT_MONO_LIST :
> -			     rgb_rep->effect;
> -	cfg->rgb_speed = rgb_rep->speed;
> -	cfg->rgb_en = rgb_rep->enabled == 0 ? OXP_FEAT_DISABLED :
> -						 OXP_FEAT_ENABLED;
> -	cfg->rgb_brightness = rgb_rep->brightness;
> +	state->effect = rgb_rep->effect == OXP_EFFECT_MONO_TRUE ?
> +			OXP_EFFECT_MONO_LIST : rgb_rep->effect;
> +	state->speed = rgb_rep->speed;
> +	state->enabled = rgb_rep->enabled == 0 ? OXP_FEAT_DISABLED :
> +					       OXP_FEAT_ENABLED;
> +	state->brightness = rgb_rep->brightness;
>   	led_mc->led_cdev.brightness = rgb_rep->brightness *
>   				      led_mc->led_cdev.max_brightness / 4;
>   	/* If monocolor had less than 100% brightness on the previous boot,
> @@ -1158,9 +1206,11 @@ static const struct attribute_group oxp_cfg_attrs_group = {
>   	.attrs = oxp_cfg_attrs,
>   };
>   
> -static int oxp_rgb_status_store(struct oxp_hid_cfg *cfg, u8 enabled,
> -				u8 speed, u8 brightness)
> +static int oxp_rgb_status_store(struct oxp_rgb_led *led, u8 enabled, u8 speed,
> +				u8 brightness)
>   {
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
> +	struct oxp_hid_cfg *cfg = led->cfg;
>   	u16 up = get_usage_page(cfg->hdev);
>   	u8 *data;
>   
> @@ -1170,12 +1220,12 @@ static int oxp_rgb_status_store(struct oxp_hid_cfg *cfg, u8 enabled,
>   	switch (up) {
>   	case GEN1_USAGE_PAGE:
>   		data = (u8[4]) { OXP_SET_PROPERTY, enabled, speed, brightness };
> -		if (cfg->rgb_effect == OXP_EFFECT_MONO_LIST)
> +		if (state->effect == OXP_EFFECT_MONO_LIST)
>   			data[3] = 0x04;
>   		return oxp_gen_1_property_out(cfg, OXP_FID_GEN1_RGB_SET, data, 4);
>   	case GEN2_USAGE_PAGE:
>   		data = (u8[6]) { OXP_SET_PROPERTY, 0x00, 0x02, enabled, speed, brightness };
> -		if (cfg->rgb_effect == OXP_EFFECT_MONO_LIST)
> +		if (state->effect == OXP_EFFECT_MONO_LIST)
>   			data[5] = 0x04;
>   		return oxp_gen_2_property_out(cfg, OXP_FID_GEN2_STATUS_EVENT, data, 6);
>   	default:
> @@ -1183,8 +1233,9 @@ static int oxp_rgb_status_store(struct oxp_hid_cfg *cfg, u8 enabled,
>   	}
>   }
>   
> -static ssize_t oxp_rgb_status_show(struct oxp_hid_cfg *cfg)
> +static ssize_t oxp_rgb_status_show(struct oxp_rgb_led *led)
>   {
> +	struct oxp_hid_cfg *cfg = led->cfg;
>   	u16 up = get_usage_page(cfg->hdev);
>   	u8 *data;
>   
> @@ -1202,19 +1253,21 @@ static ssize_t oxp_rgb_status_show(struct oxp_hid_cfg *cfg)
>   	}
>   }
>   
> -static int oxp_rgb_color_set(struct oxp_hid_cfg *cfg)
> +static int oxp_rgb_color_set(struct oxp_rgb_led *led)
>   {
> -	u8 br = cfg->led_mc->led_cdev.brightness;
> +	struct led_classdev_mc *led_mc = &led->mc_cdev;
> +	struct oxp_hid_cfg *cfg = led->cfg;
>   	u16 up = get_usage_page(cfg->hdev);
> +	u8 br = led_mc->led_cdev.brightness;
>   	u8 green, red, blue;
>   	size_t size;
>   	u8 *data;
>   	int i;
>   
> -	led_mc_calc_color_components(cfg->led_mc, br);
> -	red = cfg->led_mc->subled_info[0].brightness;
> -	green = cfg->led_mc->subled_info[1].brightness;
> -	blue = cfg->led_mc->subled_info[2].brightness;
> +	led_mc_calc_color_components(led_mc, br);
> +	red = led_mc->subled_info[0].brightness;
> +	green = led_mc->subled_info[1].brightness;
> +	blue = led_mc->subled_info[2].brightness;
>   
>   	switch (up) {
>   	case GEN1_USAGE_PAGE:
> @@ -1242,8 +1295,10 @@ static int oxp_rgb_color_set(struct oxp_hid_cfg *cfg)
>   	}
>   }
>   
> -static int oxp_rgb_effect_set(struct oxp_hid_cfg *cfg, u8 effect)
> +static int oxp_rgb_effect_set(struct oxp_rgb_led *led, u8 effect)
>   {
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
> +	struct oxp_hid_cfg *cfg = led->cfg;
>   	u16 up = get_usage_page(cfg->hdev);
>   	u8 *data;
>   	int ret;
> @@ -1282,7 +1337,7 @@ static int oxp_rgb_effect_set(struct oxp_hid_cfg *cfg, u8 effect)
>   		}
>   		break;
>   	case OXP_EFFECT_MONO_LIST:
> -		ret = oxp_rgb_color_set(cfg);
> +		ret = oxp_rgb_color_set(led);
>   		break;
>   	default:
>   		return -EINVAL;
> @@ -1291,26 +1346,31 @@ static int oxp_rgb_effect_set(struct oxp_hid_cfg *cfg, u8 effect)
>   	if (ret)
>   		return ret;
>   
> -	cfg->rgb_effect = effect;
> +	state->effect = effect;
>   
>   	return 0;
>   }
>   
> -static struct oxp_hid_cfg *oxp_rgb_cfg_from_dev(struct device *dev)
> +static struct oxp_rgb_led *oxp_rgb_led_from_dev(struct device *dev)
>   {
>   	struct led_classdev *led_cdev = dev_get_drvdata(dev);
>   	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
>   
> -	return container_of(mc_cdev, struct oxp_hid_cfg, cdev);
> +	return container_of(mc_cdev, struct oxp_rgb_led, mc_cdev);
>   }
>   
>   static ssize_t enabled_store(struct device *dev, struct device_attribute *attr,
>   			     const char *buf, size_t count)
>   {
> -	struct oxp_hid_cfg *cfg = oxp_rgb_cfg_from_dev(dev);
> +	struct oxp_rgb_led *led = oxp_rgb_led_from_dev(dev);
> +	struct oxp_hid_cfg *cfg = led->cfg;
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
>   	int ret;
>   	u8 val;
>   
> +	if (!state)
> +		return -ENODEV;
> +
>   	ret = sysfs_match_string(oxp_feature_en_text, buf);
>   	if (ret < 0)
>   		return ret;
> @@ -1318,29 +1378,32 @@ static ssize_t enabled_store(struct device *dev, struct device_attribute *attr,
>   
>   	guard(mutex)(&cfg->rgb_mutex);
>   
> -	ret = oxp_rgb_status_store(cfg, val, cfg->rgb_speed,
> -				   cfg->rgb_brightness);
> +	ret = oxp_rgb_status_store(led, val, state->speed, state->brightness);
>   	if (ret)
>   		return ret;
>   
> -	cfg->rgb_en = val;
> +	state->enabled = val;
>   	return count;
>   }
>   
>   static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
>   			    char *buf)
>   {
> -	struct oxp_hid_cfg *cfg = oxp_rgb_cfg_from_dev(dev);
> +	struct oxp_rgb_led *led = oxp_rgb_led_from_dev(dev);
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
>   	int ret;
>   
> -	ret = oxp_rgb_status_show(cfg);
> +	if (!state)
> +		return -ENODEV;
> +
> +	ret = oxp_rgb_status_show(led);
>   	if (ret)
>   		return ret;
>   
> -	if (cfg->rgb_en >= ARRAY_SIZE(oxp_feature_en_text))
> +	if (state->enabled >= ARRAY_SIZE(oxp_feature_en_text))
>   		return -EINVAL;
>   
> -	return sysfs_emit(buf, "%s\n", oxp_feature_en_text[cfg->rgb_en]);
> +	return sysfs_emit(buf, "%s\n", oxp_feature_en_text[state->enabled]);
>   }
>   static DEVICE_ATTR_RW(enabled);
>   
> @@ -1363,11 +1426,16 @@ static DEVICE_ATTR_RO(enabled_index);
>   static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
>   			    const char *buf, size_t count)
>   {
> -	struct oxp_hid_cfg *cfg = oxp_rgb_cfg_from_dev(dev);
> +	struct oxp_rgb_led *led = oxp_rgb_led_from_dev(dev);
> +	struct oxp_hid_cfg *cfg = led->cfg;
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
>   	u8 old_effect;
>   	int ret;
>   	u8 val;
>   
> +	if (!state)
> +		return -ENODEV;
> +
>   	ret = sysfs_match_string(oxp_rgb_effect_text, buf);
>   	if (ret < 0)
>   		return ret;
> @@ -1375,19 +1443,19 @@ static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
>   	val = ret;
>   
>   	guard(mutex)(&cfg->rgb_mutex);
> -	old_effect = cfg->rgb_effect;
> -	cfg->rgb_effect = val;
> +	old_effect = state->effect;
> +	state->effect = val;
>   
> -	ret = oxp_rgb_status_store(cfg, cfg->rgb_en, cfg->rgb_speed,
> -				   cfg->rgb_brightness);
> +	ret = oxp_rgb_status_store(led, state->enabled, state->speed,
> +				   state->brightness);
>   	if (ret) {
> -		cfg->rgb_effect = old_effect;
> +		state->effect = old_effect;
>   		return ret;
>   	}
>   
> -	ret = oxp_rgb_effect_set(cfg, val);
> +	ret = oxp_rgb_effect_set(led, val);
>   	if (ret) {
> -		cfg->rgb_effect = old_effect;
> +		state->effect = old_effect;
>   		return ret;
>   	}
>   
> @@ -1397,17 +1465,21 @@ static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
>   static ssize_t effect_show(struct device *dev, struct device_attribute *attr,
>   			   char *buf)
>   {
> -	struct oxp_hid_cfg *cfg = oxp_rgb_cfg_from_dev(dev);
> +	struct oxp_rgb_led *led = oxp_rgb_led_from_dev(dev);
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
>   	int ret;
>   
> -	ret = oxp_rgb_status_show(cfg);
> +	if (!state)
> +		return -ENODEV;
> +
> +	ret = oxp_rgb_status_show(led);
>   	if (ret)
>   		return ret;
>   
> -	if (cfg->rgb_effect >= ARRAY_SIZE(oxp_rgb_effect_text))
> +	if (state->effect >= ARRAY_SIZE(oxp_rgb_effect_text))
>   		return -EINVAL;
>   
> -	return sysfs_emit(buf, "%s\n", oxp_rgb_effect_text[cfg->rgb_effect]);
> +	return sysfs_emit(buf, "%s\n", oxp_rgb_effect_text[state->effect]);
>   }
>   
>   static DEVICE_ATTR_RW(effect);
> @@ -1431,10 +1503,15 @@ static DEVICE_ATTR_RO(effect_index);
>   static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
>   			   const char *buf, size_t count)
>   {
> -	struct oxp_hid_cfg *cfg = oxp_rgb_cfg_from_dev(dev);
> +	struct oxp_rgb_led *led = oxp_rgb_led_from_dev(dev);
> +	struct oxp_hid_cfg *cfg = led->cfg;
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
>   	int ret;
>   	u8 val;
>   
> +	if (!state)
> +		return -ENODEV;
> +
>   	ret = kstrtou8(buf, 10, &val);
>   	if (ret)
>   		return ret;
> @@ -1444,28 +1521,32 @@ static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
>   
>   	guard(mutex)(&cfg->rgb_mutex);
>   
> -	ret = oxp_rgb_status_store(cfg, cfg->rgb_en, val, cfg->rgb_brightness);
> +	ret = oxp_rgb_status_store(led, state->enabled, val, state->brightness);
>   	if (ret)
>   		return ret;
>   
> -	cfg->rgb_speed = val;
> +	state->speed = val;
>   	return count;
>   }
>   
>   static ssize_t speed_show(struct device *dev, struct device_attribute *attr,
>   			  char *buf)
>   {
> -	struct oxp_hid_cfg *cfg = oxp_rgb_cfg_from_dev(dev);
> +	struct oxp_rgb_led *led = oxp_rgb_led_from_dev(dev);
> +	struct oxp_rgb_full_state *state = oxp_rgb_full_state(led);
>   	int ret;
>   
> -	ret = oxp_rgb_status_show(cfg);
> +	if (!state)
> +		return -ENODEV;
> +
> +	ret = oxp_rgb_status_show(led);
>   	if (ret)
>   		return ret;
>   
> -	if (cfg->rgb_speed > 9)
> +	if (state->speed > 9)
>   		return -EINVAL;
>   
> -	return sysfs_emit(buf, "%hhu\n", cfg->rgb_speed);
> +	return sysfs_emit(buf, "%hhu\n", state->speed);
>   }
>   static DEVICE_ATTR_RW(speed);
>   
> @@ -1476,49 +1557,64 @@ static ssize_t speed_range_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(speed_range);
>   
> -static void oxp_rgb_queue_fn(struct work_struct *work)
> +static void oxp_rgb_full_queue(struct oxp_rgb_led *led,
> +			       struct oxp_rgb_full_state *state)
>   {
> -	struct oxp_hid_cfg *cfg = container_of(to_delayed_work(work),
> -					      struct oxp_hid_cfg, oxp_rgb_queue);
> -	unsigned int max_brightness = cfg->led_mc->led_cdev.max_brightness;
> -	unsigned int brightness = cfg->led_mc->led_cdev.brightness;
> +	unsigned int max_brightness = led->mc_cdev.led_cdev.max_brightness;
> +	unsigned int brightness = led->mc_cdev.led_cdev.brightness;
> +	struct oxp_hid_cfg *cfg = led->cfg;
>   	u8 val = 4 * brightness / max_brightness;
>   	int ret;
>   
> -	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
> -		return;
> -
>   	guard(mutex)(&cfg->rgb_mutex);
>   
> -	if (cfg->rgb_brightness != val) {
> -		ret = oxp_rgb_status_store(cfg, cfg->rgb_en, cfg->rgb_speed, val);
> +	if (state->brightness != val) {
> +		ret = oxp_rgb_status_store(led, state->enabled, state->speed, val);
>   		if (ret)
> -			dev_err(cfg->led_mc->led_cdev.dev,
> +			dev_err(led->mc_cdev.led_cdev.dev,
>   				"Error: Failed to write RGB Status: %i\n", ret);
>   
> -		cfg->rgb_brightness = val;
> +		state->brightness = val;
>   	}
>   
> -	if (cfg->rgb_effect != OXP_EFFECT_MONO_LIST)
> +	if (state->effect != OXP_EFFECT_MONO_LIST)
>   		return;
>   
> -	ret = oxp_rgb_effect_set(cfg, cfg->rgb_effect);
> +	ret = oxp_rgb_effect_set(led, state->effect);
>   	if (ret)
> -		dev_err(cfg->led_mc->led_cdev.dev, "Error: Failed to write RGB color: %i\n",
> -			ret);
> +		dev_err(led->mc_cdev.led_cdev.dev,
> +			"Error: Failed to write RGB color: %i\n", ret);
> +}
> +
> +static void oxp_rgb_queue_fn(struct work_struct *work)
> +{
> +	struct oxp_rgb_led *led = container_of(to_delayed_work(work),
> +					       struct oxp_rgb_led, work);
> +	struct oxp_hid_cfg *cfg = led->cfg;
> +
> +	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
> +		return;
> +
> +	switch (led->type) {
> +	case OXP_RGB_FULL:
> +		oxp_rgb_full_queue(led, oxp_rgb_full_state(led));
> +		break;
> +	}
>   }
>   
>   static void oxp_rgb_brightness_set(struct led_classdev *led_cdev,
>   				   enum led_brightness brightness)
>   {
>   	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
> -	struct oxp_hid_cfg *cfg = container_of(mc_cdev, struct oxp_hid_cfg, cdev);
> +	struct oxp_rgb_led *led = container_of(mc_cdev, struct oxp_rgb_led,
> +					     mc_cdev);
> +	struct oxp_hid_cfg *cfg = led->cfg;
>   
>   	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
>   		return;
>   
>   	led_cdev->brightness = brightness;
> -	mod_delayed_work(system_dfl_wq, &cfg->oxp_rgb_queue, msecs_to_jiffies(50));
> +	mod_delayed_work(system_dfl_wq, &led->work, msecs_to_jiffies(50));
>   }
>   
>   static struct attribute *oxp_rgb_attrs[] = {
> @@ -1535,37 +1631,121 @@ static const struct attribute_group oxp_rgb_attr_group = {
>   	.attrs = oxp_rgb_attrs,
>   };
>   
> -static const struct mc_subled oxp_rgb_subled_info[] = {
> +static const struct oxp_rgb_led_desc oxp_rgb_led_descs[] = {
>   	{
> +		.name = "oxp:rgb:joystick_rings",
> +		.type = OXP_RGB_FULL,
> +	},
> +};
> +
> +static int oxp_rgb_led_init(struct oxp_hid_cfg *cfg, struct oxp_rgb_led *led,
> +			    const struct oxp_rgb_led_desc *desc)
> +{
> +	struct oxp_rgb_full_state *full_state;
> +	struct hid_device *hdev = cfg->hdev;
> +	u8 green;
> +	u8 blue;
> +	u8 red;
> +
> +	led->cfg = cfg;
> +	led->type = desc->type;
> +
> +	switch (led->type) {
> +	case OXP_RGB_FULL:
> +		full_state = devm_kzalloc(&hdev->dev, sizeof(*full_state),
> +					  GFP_KERNEL);
> +		if (!full_state)
> +			return -ENOMEM;
> +		led->state = full_state;
> +		led->mc_cdev.led_cdev.brightness = 0x64;
> +		red = 0x24;
> +		green = 0x22;
> +		blue = 0x99;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	led->subled_info[0] = (struct mc_subled) {
>   		.color_index = LED_COLOR_ID_RED,
> -		.intensity = 0x24,
> +		.intensity = red,
>   		.max_intensity = 0xff,
>   		.channel = 0x1,
> -	},
> -	{
> +	};
> +	led->subled_info[1] = (struct mc_subled) {
>   		.color_index = LED_COLOR_ID_GREEN,
> -		.intensity = 0x22,
> +		.intensity = green,
>   		.max_intensity = 0xff,
>   		.channel = 0x2,
> -	},
> -	{
> +	};
> +	led->subled_info[2] = (struct mc_subled) {
>   		.color_index = LED_COLOR_ID_BLUE,
> -		.intensity = 0x99,
> +		.intensity = blue,
>   		.max_intensity = 0xff,
>   		.channel = 0x3,
> -	},
> -};
> +	};
> +	led->mc_cdev.led_cdev.name = desc->name;
> +	led->mc_cdev.led_cdev.color = LED_COLOR_ID_RGB;
> +	led->mc_cdev.led_cdev.max_brightness = 0x64;
> +	led->mc_cdev.led_cdev.brightness_set = oxp_rgb_brightness_set;
> +	led->mc_cdev.num_colors = ARRAY_SIZE(led->subled_info);
> +	led->mc_cdev.subled_info = led->subled_info;
> +	INIT_DELAYED_WORK(&led->work, oxp_rgb_queue_fn);
>   
> -static const struct led_classdev_mc oxp_cdev_rgb = {
> -	.led_cdev = {
> -		.name = "oxp:rgb:joystick_rings",
> -		.color = LED_COLOR_ID_RGB,
> -		.brightness = 0x64,
> -		.max_brightness = 0x64,
> -		.brightness_set = oxp_rgb_brightness_set,
> -	},
> -	.num_colors = ARRAY_SIZE(oxp_rgb_subled_info),
> -};
> +	return 0;
> +}
> +
> +static int oxp_rgb_leds_register(struct oxp_hid_cfg *cfg)
> +{
> +	int led_count = ARRAY_SIZE(oxp_rgb_led_descs);
> +	struct hid_device *hdev = cfg->hdev;
> +	struct oxp_rgb_led *led;
> +	int ret;
> +	int i;
> +
> +	cfg->rgb_leds = devm_kcalloc(&hdev->dev, led_count,
> +				     sizeof(*cfg->rgb_leds), GFP_KERNEL);
> +	if (!cfg->rgb_leds)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < led_count; i++) {
> +		led = &cfg->rgb_leds[i];
> +		ret = oxp_rgb_led_init(cfg, led, &oxp_rgb_led_descs[i]);
> +		if (ret)
> +			return ret;
> +		cfg->rgb_led_count++;
> +
> +		ret = devm_led_classdev_multicolor_register(&hdev->dev,
> +							    &led->mc_cdev);
> +		if (ret)
> +			return dev_err_probe(&hdev->dev, ret,
> +					     "Failed to create RGB device\n");
> +
> +		ret = devm_device_add_group(led->mc_cdev.led_cdev.dev,
> +					    &oxp_rgb_attr_group);
> +		if (ret)
> +			return dev_err_probe(led->mc_cdev.led_cdev.dev, ret,
> +					     "Failed to create RGB configuration attributes\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void oxp_rgb_disable_works(struct oxp_hid_cfg *cfg)
> +{
> +	int i;
> +
> +	for (i = 0; i < cfg->rgb_led_count; i++)
> +		disable_delayed_work_sync(&cfg->rgb_leds[i].work);
> +}
> +
> +static void oxp_rgb_enable_works(struct oxp_hid_cfg *cfg)
> +{
> +	int i;
> +
> +	for (i = 0; i < cfg->rgb_led_count; i++)
> +		enable_delayed_work(&cfg->rgb_leds[i].work);
> +}
>   
>   static struct quirk_entry quirk_hybrid_mcu = {
>   	.hybrid_mcu = true,
> @@ -1644,8 +1824,7 @@ static void oxp_quiesce_work(struct oxp_hid_cfg *cfg)
>   	scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
>   		cfg->rgb_reply_pending = false;
>   	}
> -	if (cfg->rgb_work_initialized)
> -		disable_delayed_work_sync(&cfg->oxp_rgb_queue);
> +	oxp_rgb_disable_works(cfg);
>   	if (cfg->gen2_work_initialized) {
>   		disable_delayed_work_sync(&cfg->oxp_btn_queue);
>   		disable_delayed_work_sync(&cfg->oxp_mcu_init);
> @@ -1680,6 +1859,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up,
>   {
>   	struct oxp_bmap_page_1 *bmap_1;
>   	struct oxp_bmap_page_2 *bmap_2;
> +	struct oxp_rgb_led *rgb_led;
>   	struct oxp_hid_cfg *cfg;
>   	int ret;
>   
> @@ -1701,31 +1881,14 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up,
>   	if (up == GEN2_USAGE_PAGE && quirks && quirks->hybrid_mcu)
>   		goto skip_rgb;
>   
> -	cfg->cdev = oxp_cdev_rgb;
> -	memcpy(cfg->subled_info, oxp_rgb_subled_info, sizeof(cfg->subled_info));
> -	cfg->cdev.subled_info = cfg->subled_info;
> -	cfg->led_mc = &cfg->cdev;
> -
> -	INIT_DELAYED_WORK(&cfg->oxp_rgb_queue, oxp_rgb_queue_fn);
> -	cfg->rgb_work_initialized = true;
> -	ret = devm_led_classdev_multicolor_register(&hdev->dev, cfg->led_mc);
> -	if (ret) {
> -		dev_err_probe(&hdev->dev, ret,
> -			      "Failed to create RGB device\n");
> -		goto err_quiesce;
> -	}
> -
> -	ret = devm_device_add_group(cfg->led_mc->led_cdev.dev,
> -				    &oxp_rgb_attr_group);
> -	if (ret) {
> -		dev_err_probe(cfg->led_mc->led_cdev.dev, ret,
> -			      "Failed to create RGB configuration attributes\n");
> +	ret = oxp_rgb_leds_register(cfg);
> +	if (ret)
>   		goto err_quiesce;
> -	}
>   
> -	ret = oxp_rgb_status_show(cfg);
> +	rgb_led = oxp_rgb_led_by_type(cfg, OXP_RGB_FULL);
> +	ret = oxp_rgb_status_show(rgb_led);
>   	if (ret)
> -		dev_warn(cfg->led_mc->led_cdev.dev,
> +		dev_warn(rgb_led->mc_cdev.led_cdev.dev,
>   			 "Failed to query RGB initial state: %i\n", ret);
>   
>   	/* Below features are only implemented in gen 2 */
> @@ -1841,8 +2004,7 @@ static int __maybe_unused oxp_hid_suspend(struct hid_device *hdev,
>   	scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
>   		cfg->rgb_reply_pending = false;
>   	}
> -	if (cfg->rgb_work_initialized)
> -		disable_delayed_work_sync(&cfg->oxp_rgb_queue);
> +	oxp_rgb_disable_works(cfg);
>   	if (cfg->gen2_work_initialized) {
>   		disable_delayed_work_sync(&cfg->oxp_btn_queue);
>   		disable_delayed_work_sync(&cfg->oxp_mcu_init);
> @@ -1860,8 +2022,7 @@ static int __maybe_unused oxp_hid_resume(struct hid_device *hdev)
>   	    READ_ONCE(cfg->removing))
>   		return 0;
>   
> -	if (cfg->rgb_work_initialized)
> -		enable_delayed_work(&cfg->oxp_rgb_queue);
> +	oxp_rgb_enable_works(cfg);
>   	if (cfg->gen2_work_initialized) {
>   		enable_delayed_work(&cfg->oxp_btn_queue);
>   		enable_delayed_work(&cfg->oxp_mcu_init);


Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

