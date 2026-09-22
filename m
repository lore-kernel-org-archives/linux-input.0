Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2A544D4F
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091243; cv=none; b=qDTZOgfkDBy3K/iifKq7StOj7fSWXEm7DGSKD28om2U5Xn/+YIdawbPsHGa9qG4pBh1Zyp42UErV8cXEqv2S0nUjMeIV0qCPyfXUJDTCXG2kKBiG5KV/Pzv7Yh3FaIEMBW2/JuLzrWeXWEDuMdS5m9c91FlGZO+JYLeqSv0gGSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091243; c=relaxed/simple;
	bh=M44KejLjN9PzhtH13UorzrKXY6qmkOaI4F1rztr/4YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT6TTT0q54E3WB/PlkTsZWhYQYiHD6V3FuTWAMVix/aYeEhFU2cyvlKTMf+yXuGdJRHMAI9dwA2q10bukZs3VsQ+vsRudggzkeqQhsZMjBzzMpYJ/myZcOBqQsZLNIeVHkB5ArE6EZjlp+XO2vqyIENZ69APunFIJJTTCs4FzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBTfh3+n; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBTfh3+n"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so26148a91.1
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790091241; x=1790696041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MX4YUTICf0RtvgphPrSl6xSOkCeNscfqMM3Oh4fbG54=;
        b=PBTfh3+n7dMkYJhumMwoaJGqRYFJBmPd1gUDooELvF1sLwX67eBa5lTtmiGAUtDie5
         6XdtrCkPKDW1fj9TQ04s71zEekfznfJ1YLFhB1Bkc3zhprPXh55joKkQaSotfOMPIKFP
         kGYjgI4baQfae79j3s6yo1kSvI10hPOTipSVK2ArnheTkn5pWYewmdFlW+v1+4iieQj3
         vEu+7OnoPqOKDoMndz/Vjr8wEYerHPHBS6qFHUOX856M8yP0WpMiulp+ruyGCSRQgnCl
         ZSgNikuHHmPviBrMAWpxJWKMdUVOXiFq7Had4wvQO9Fw4fO35koVm0sSL/Nya6hmya/5
         PA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091241; x=1790696041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MX4YUTICf0RtvgphPrSl6xSOkCeNscfqMM3Oh4fbG54=;
        b=1tPJtch2HYU0poQafKqkyojmvyGrMMfaserGtwmLWktQobWxBnz/oZyFnF3LhUqatx
         tYlEE99fj/4lHwMjbuh2iuD7B66zPRASG/Rn3pbNBUSI0k+Pj4mKKEHCUE2zoWIxF62b
         dW6kwcY7BItmZAI4OxQnYS4061VeMLXusQTaEa7OxVpTbSz88flwNBvSE6gKdkSBJc6c
         bhnatKhvZFRjJGS8yXGXCuofb+vImZNw/7j4II9TwfjWJV09mLHhYhiYqyhxMIM6FcPh
         /rx9H7UZFSkxM4zj3uNV8W+ksXZpIyDxDoefB3Zq8En2CfDl8jrErDESZ6/46wp+UpQE
         aykA==
X-Forwarded-Encrypted: i=1; AKwUvBw6TnRQFSnnqudeZPOBmD7HPAV4hmCM7GZeDzLYYy0270QJ/nlINIjcI3ZpSD8RQerWT7g26QQNoS/DKg==@vger.kernel.org
X-Gm-Message-State: AFuF++m/rjvhVUqYiefxVV+H1zUpDK+mMumdeWCcUjSHieP3qBapYzic
	qpFgBiTfecCo7TdgK5gdkFSs6ODUQjytgY0wUrwoq9wFeaNMcqjE9KhT
X-Gm-Gg: AYBFou3wrmNyTGADHrI5oqM8wX4mOSULzeGP9fLfLCaEExE44ITRDuLqoIBI17DOa2z
	6vF4G+aQHJtMDTLxfZMLYIWF1yK9ienSGYTJlnbVik7gTumbtIgJrl5rR2wT0zpGm+bWqJgYiur
	0yHCSXGmOaDbRFpWgKRR5H2c6UtOKT8Q8JN7z3rgtFyoWTiqaCoB8lNXeljPQUJrl2eidWgL14F
	OCQG6bneYQJM7sYl5hDPXF1bZb51kuCD2CWa8PrEpHy8ZOPcfYkOee2TVsxnGfJHWyEsOotTgn+
	veo3g5nAxgWhXTBiLRPdpW7F1u5R8w9iHevv7CuEKAFLJ8NJDCBHVDHGkDkQLx2+tmkKNlU9W7e
	3UUSGlJx9zdgoAv8l9y67gyJc2O/Cc2c662gTePy9n/P4YVUzvuZ7rktYIqZR9l87AxhdYxYEUJ
	1Ulk9YSmj7dVWk7PfVG/6XNon6nTAcrPl9YIpCf8CjHJ9J4SgjTnsgUK2lEtT4qM27ZVreHNSG2
	eTDfQrw7XwoPdxxMqA5NSembZDTIKtk3ifuFg==
X-Received: by 2002:a17:90b:4c47:b0:39e:6a7f:1dc6 with SMTP id 98e67ed59e1d1-3a073201bf0mr1653263a91.34.1790091240806;
        Tue, 22 Sep 2026 08:34:00 -0700 (PDT)
Received: from eggarch ([152.58.24.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07d48e8basm130683a91.17.2026.09.22.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:34:00 -0700 (PDT)
Date: Tue, 22 Sep 2026 21:03:24 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Roman Stingler <roman.stingler@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Erik Hakansson <erikhakan@gmail.com>, 
	Filipe Lains <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION 7.3-rc1] HID: logitech-hidpp: hi-res scroll mode
 forcibly re-enabled on every reconnect for Bolt devices, overriding
 userspace
Message-ID: <arJs7GjCP3r4IaM-@eggarch>
References: <20260920094508.39682-1-roman.stingler@gmail.com>
 <arAe2iRkYh9p98Rf@eggarch>
 <20260920205058.11958-1-roman.stingler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920205058.11958-1-roman.stingler@gmail.com>

On Sun, Sep 20, 2026 at 10:50:53PM +0200, Roman Stingler wrote:
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 1504de32b1c8..ffc7cef49b59 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2044,6 +2044,7 @@ static int hidpp_hrs_set_highres_scrolling_mode(struct hidpp_device *hidpp,
>  #define HIDPP_PAGE_HIRES_WHEEL		0x2121
>  
>  #define CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY	0x00
> +#define CMD_HIRES_WHEEL_GET_WHEEL_MODE		0x10
>  #define CMD_HIRES_WHEEL_SET_WHEEL_MODE		0x20
>  
>  static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
> @@ -2072,12 +2073,10 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
>  	return ret;
>  }
>  
> -static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
> -	bool high_resolution, bool use_hidpp)
> +static int hidpp_hrw_get_wheel_mode(struct hidpp_device *hidpp, u8 *mode)
>  {
>  	u8 feature_index;
>  	int ret;
> -	u8 params[1];
>  	struct hidpp_report response;
>  
>  	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
> @@ -2085,13 +2084,14 @@ static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
>  	if (ret)
>  		return ret;
>  
> -	params[0] = (invert          ? BIT(2) : 0) |
> -		    (high_resolution ? BIT(1) : 0) |
> -		    (use_hidpp       ? BIT(0) : 0);
> +	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
> +					  CMD_HIRES_WHEEL_GET_WHEEL_MODE,
> +					  NULL, 0, &response);
> +	if (ret)
> +		return ret;
>  
> -	return hidpp_send_fap_command_sync(hidpp, feature_index,
> -					   CMD_HIRES_WHEEL_SET_WHEEL_MODE,
> -					   params, sizeof(params), &response);
> +	*mode = response.fap.params[0];
> +	return 0;
>  }
>  
>  /* -------------------------------------------------------------------------- */
> @@ -3910,8 +3910,16 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
>  	u8 multiplier = 1;
>  
>  	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
> -		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
> -		if (ret == 0)
> +		u8 mode;
> +
> +		/*
> +		 * The wheel mode is persistent state in the device, so read it
> +		 * rather than overwriting it, and scale to match. A device
> +		 * left in hi-res still gets the multiplier it needs; one the
> +		 * user configured for low resolution is left alone.
> +		 */
> +		ret = hidpp_hrw_get_wheel_mode(hidpp, &mode);
> +		if (ret == 0 && (mode & BIT(1)))
>  			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
>  	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
>  		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
> 
> Tested on top of 7.3-rc3, installed via DKMS so it is the module loaded at
> boot. Results against the same device:
> 
>                             stock   your patch   this
>   suspend/resume                no        yes       yes
>   solaar write sticks           no        yes       yes
>   module reload                 no        no        yes
>   cold boot                     no        no        yes

I didn't think of this, your patch seems like a better solution.
I think you should format and send it.


Regards,
Lovekesh
