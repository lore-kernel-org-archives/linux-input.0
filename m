Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E8496D42
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071088; cv=none; b=VIYj+xlifbzjnf/g4mRcuZAKsICWEP7ECnks24Cp7tfjc4qff4JCTe5BjfWgOQj5R0HkSjHuaNFjUngBaZB5ZGoeiTrFggsSBiBhysFbBjiv9e9gG5VxJVtPRpUrdqRyd5JE+z1ZDIPep90npgT61SyrTFsoOBsRdwhA25vXiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071088; c=relaxed/simple;
	bh=70JpcLWpChN9TggxfsupsPzSJyZcERoa5xrjGNGx7hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvCUHbri5pnCpL7geAollrMlOQJc3s9bMcsgGVX47KlMh5sKIthumeFvpwdKcqndI5MUM/WaXC+MIhpWDy7Zey2BiB51lgva5CyDPto2hDJ6ubhsIWwHGRT1SldhlxUn3Lj91P1K73WAfWb27z4fBLPVrC6WTZ766ZXQukNbHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0gO5fN/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0gO5fN/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so135407a91.2
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789071085; x=1789675885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgdj2pqHYPEmivAmLwAJxzuvMuZle0+ZMxeCxj5yEEA=;
        b=e0gO5fN/yp5frL4o1ZPYeAgeCE7m4NrUYN5UXNR22c3+QQYGAAM66xJHloWAHHmpRM
         sd7KE59DMNLjofwor+qTL8S1pAdFXMRP5jrnD06x+8EDJTA7CcUHgyzGTISxUkW/184m
         mJhzDqnwnUCE+jT0fDnJb6wTnRIFi+4Q99GlLZw3PrlpHszOTGD25wIgMn/u8bjcTvpf
         fxIg05doB3U5llS66FcUO2mteX7xgXYnQCpD45ip5CekhWdjxj9cjKopPuf+wXGcaGOy
         Hwc1M5C9p94PyWWfPqKoEMt+Ee3EhosPo/ZzJfbOV8iS+W/D+SPMwsJVKhjrHZWa9DCJ
         aU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071085; x=1789675885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lgdj2pqHYPEmivAmLwAJxzuvMuZle0+ZMxeCxj5yEEA=;
        b=ZhI5+vJZ4yatcH042Mr6m9pimm3j22wLrAyHDOtiIlbFj99UrlVbw5Yh7qPbEuADdA
         M+8X2s6Jo3FhKyidmWy+N9ZHkyPFAuDWMfyOQYRPlMRrNl9V1B+fxHGSHuKYwzzyz+9u
         mZZX2nAHDL2T4mLZnyFOcabiisjnSfKstOYuzQZig7DogmAyMrbinOy8aMVvDW2F0der
         8QCpV3ZtrFzZNrurIY4rbO/wxVuORRGce2AkB7BUj3eNkcWxz3o7A/Smjl4Iq/JEA2nw
         4UhQv1rH96RHJX3mN3X5XPV8CfMI5REd9Bv+KjXfPlQiD5cHnVe8a8hsTYBPpS2WlTMW
         +EHA==
X-Gm-Message-State: AFuF++ll0RBCP+glOClrwnnCHhGzPoYTspITfr8NTy1AYZp0LhIIq8aL
	qNLgzHDyYOzyXzbUdrrTGRLfY3C7a5HrrR4y0+7wNTvpISnXMsno9SRT
X-Gm-Gg: AYBFou2bLRD1635KH6P7Ed386yL3ukrVhmm9aPhCTaCVMYcTQJz4j3c3REpsSEecyaH
	o1RAVtPNcc/Ttt3/kemh2O84wGs39cbIT6yQj5AFxVEs4p2JJhx6o/nvNSktVEhCCZjHw07Cw2k
	xdKQbAU0OIV1Ev29/JMJhrHLTV8bouyjQqc7HH8fuqXpzAyl8WYgxPvcPXOnDl6JFndTgt0f+/Z
	GktNfPRd0fNggUo1Jme/weykRWwwtTkiu8HBFBjKa+jpqb7Xya6wwSBoaFs12CJ824FYwsdblSQ
	6PNpYoewyFrpZGeYIDwTepaxKRsEp8XhdT004aEZ84F5LWL2q8A3bbKjiY4P3gRD4HBZquLCBWW
	ffuSZCvFE0Nj8ZmVzrbXY6PT3Qna84srdldHLqFIiphc++cZPzeJEsob0YbwqXes7HtmPqet+Gm
	LoIWNTiiI+We6mtwjuhj8Tp9Kg4oFZyFgYKOuWDbTVBCft6sZxPptc9WgNgjOmizJDO+JJ/o/3C
	qo/b1H8ao0JG6JFXhTGfV9VWY4BRhAUSI98AA1QCbTvxZMN45DaLopcBCHIjaIFPQ==
X-Received: by 2002:a17:90b:582b:b0:398:c0ad:711c with SMTP id 98e67ed59e1d1-39d9c1d1f85mr626260a91.15.1789071085459;
        Thu, 10 Sep 2026 13:11:25 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf015csm562594eec.4.2026.09.10.13.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:11:25 -0700 (PDT)
Message-ID: <d5714550-61d6-45a6-a0f7-2ca8b472ca49@gmail.com>
Date: Thu, 10 Sep 2026 13:11:24 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] HID: hid-oxp: select brightness policy for the new
 RGB effect
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-leds@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-8-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-8-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> Set the requested effect before constructing its status command, since
> monocolor uses maximum hardware brightness and software intensity scaling.
> Previously entering or leaving monocolor used the old effect's brightness
> policy. Restore the cached effect if either output command fails.
>
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>   drivers/hid/hid-oxp.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 8d07816..9c22c8e 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -1240,6 +1240,7 @@ static DEVICE_ATTR_RO(enabled_index);
>   static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
>   			    const char *buf, size_t count)
>   {
> +	u8 old_effect;
>   	int ret;
>   	u8 val;
>   
> @@ -1250,15 +1251,21 @@ static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
>   	val = ret;
>   
>   	guard(mutex)(&drvdata.rgb_mutex);
> +	old_effect = drvdata.rgb_effect;
> +	drvdata.rgb_effect = val;
>   
>   	ret = oxp_rgb_status_store(drvdata.rgb_en, drvdata.rgb_speed,
>   				   drvdata.rgb_brightness);
> -	if (ret)
> +	if (ret) {
> +		drvdata.rgb_effect = old_effect;
>   		return ret;
> +	}
>   
>   	ret = oxp_rgb_effect_set(val);
> -	if (ret)
> +	if (ret) {
> +		drvdata.rgb_effect = old_effect;
>   		return ret;
> +	}
>   
>   	return count;
>   }

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
