Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA03537D2
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846936; cv=none; b=eleZ2xvpnNTayks7d2a0ga1MsW0Rdr+GHwTasl0JGKVEkzmLGb5FZUGPWcxtl2GBvKDq+iF6NE38ll66OFvvibFCxr/2LLo1VdjaOvN0dyaU5GSsifBA+quFohK4VG7padZQl/X//V3MyLbFOGZxkZJ88OwnCXPq0CtXtnZICv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846936; c=relaxed/simple;
	bh=VVXQpNqWLW1dVXRTbBnK4jSBzvkYq1ziwM+XpLrjVUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJSJa4Ceh3n4GnYan41CNyyhmW+hmTgOgMG/vGUgUvfrtFde7U/9qY/qWxlGP+rAsejjSgOeJMbzqwVIsrvzobUY368bHJjOTEeo/21OStJb67X+RiEOcY7xuAlkqY7Q07VZ60iZR54ktMyiuiSNoPEetlW9skXY3MmL/kcxfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouC0cmCe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouC0cmCe"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-474560436c3so2048451f8f.0
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782846933; x=1783451733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZr2386okY0q9G71/qNFP3T8rZHkPGtTBZNsCKJwoh4=;
        b=ouC0cmCeFAWvbT6OJsZ4M8xUZ4FdLNtTYyUf+Lwaj7VD6tzHXZs7cQ5G15FGclpETL
         wRJvwO/HHx7hFpPOtszCERWAcHZbLIjT7ZLhISKba9SwhaMqELd6RMa24xu7vS03oQRe
         pHSNQVIpo+xJd3iveLZ4rVSG7MB+ZcvSCM19ln4lBM7T1zXaMTfz8/apndCdTqSBH21M
         61xRnHbbo/tWaTxODcEC6F+UX02Yrn8RNHD5ueL2P1BG24uE5VCimRth+J4aBlGUEXzY
         CZz+4R5U8iEm4srWEq44hV78ATsW1UnE2BlkjhmL1BbiKyWcdYcEjCKxeIA+dms+lohy
         LaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846933; x=1783451733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZr2386okY0q9G71/qNFP3T8rZHkPGtTBZNsCKJwoh4=;
        b=npAaIXJFMkhhBQbMqPervoWZdxGrBSzOVeyvoLHw+yosjcMP9CRCVb0aqxqBZ87XIg
         FgknJ59+/VVyI40UEuEN1STiFO96RgDO+KbLfCb5bTjMW3HDeCEmO7wBvlO+6Fn7sMao
         HotFXGRgocmPCy1Oa0il/t7ZA3Xy7QjNeMxZkDQZGBKdoO/22Up+FfI1WDpMhbuePr+p
         O9SpuZti5Z2MAW05eC33cZ5eaN6w/e7FDzuY1GabjnM2m88SwQCNf1hmi9eY1RsjSqpu
         oRLqWY0r1Bf+eGKqfVjfIXCw4I0uSuV+eJsdwPNJj4B0N+q7LH/XZIIuRSo1ImybmE6s
         yzxg==
X-Forwarded-Encrypted: i=1; AHgh+RqMDA+1pA6dOn6gUqBXPC56OajuuR1UGP6Ub2QsAwZCKiBV/FP8gh+QWvZTsgMk9ZMSaRDdtl4LbM/huQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnZqYIb9j6WeQHWyPwnQIhp8rtDmyaAofS8If7Dw2bkF1YaAS
	m1QBRV4Sisc8QsgDmd/q167SPlKZ9tRjZQIY+GUffmJK40/ska00T34=
X-Gm-Gg: AfdE7cnZNr5lLPlVMw5HixpMEin9hQKN4rFzNs2oXPYMTMcLnOfFJWsUpk5O95u/p3V
	8BPIzvsqw8Zg+vLMiY2o9DfyUIYQAKNHgVJbC68ZzbEdKOzZBgRjg0bXCKSVczMxKzjOEwAP7on
	cemRAShZr8rtXnIKSsl33BXalyQEXL2yzcMjdDIWGm02TrrSSWNw6LSYxlAIqcOlxqwFNg+y2v2
	rV04qk3w4FGlDM7HE5RaeWAdxHghU14YCXtob1Fp4L39nllqG+nrOhsVdYbSDyXMsbVRTD/2ubR
	+cG+KeQYL0Tj6EwpRUSfLVehmuZ69aEGjA37UycKpQI9gzvP6GQ6OnxYOWb/zn0/F3GOvtRNAh4
	jBE8h9gcdTj2vrNVy+4DQa/NQb9pZrjEKrLRrn21vJWS/4E7TdREUpSq/7+dpixgVsl2iKGkmzk
	0RotT35R//s9ZlXRw0T3+9OCB05pmEqHLes1u4sh0sHJtlQQzdcfSxUONkN6MH1B0Zjg==
X-Received: by 2002:a5d:5847:0:b0:45e:f439:9def with SMTP id ffacd0b85a97d-47550cabba5mr7533113f8f.15.1782846932698;
        Tue, 30 Jun 2026 12:15:32 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:989a:410e:90cf:c762])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756778fac3sm9499721f8f.32.2026.06.30.12.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:15:32 -0700 (PDT)
Date: Tue, 30 Jun 2026 21:15:30 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: maplecontrol - set driver data before registering
 input device
Message-ID: <akQV0oosd9Bs-1hE@lithos>
References: <akNYib9hQFNN1fA9@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNYib9hQFNN1fA9@google.com>

On 29 Jun 22:49, Dmitry Torokhov wrote:
> Set maple driver data before calling input_register_device() to
> ensure that it is available if the device is opened immediately and
> the callback is triggered.
> 
> Cc: stable@vger.kernel.org
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/joystick/maplecontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
> index 7f36f73844a9..6293b6e8148b 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -112,6 +112,8 @@ static int probe_maple_controller(struct device *dev)
>  	pad->dev = idev;
>  	pad->mdev = mdev;
>  
> +	maple_set_drvdata(mdev, pad);
> +
>  	idev->open = dc_pad_open;
>  	idev->close = dc_pad_close;
>  
> @@ -146,7 +148,6 @@ static int probe_maple_controller(struct device *dev)
>  		goto fail;
>  
>  	mdev->driver = mdrv;
> -	maple_set_drvdata(mdev, pad);
>  
>  	return 0;
>  
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
> 
> -- 
> Dmitry

Tested-by: Florian Fuchs <fuchsfl@gmail.com>

Regards
Florian
