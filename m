Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5F4E56F9
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070727; cv=none; b=PYaHMZ231/uSwShElR09J2xoDBrY2hK93KSq6rTHUKxjSoCdkA16wuxS2DTpIyg1Gy/aWTfXAA/APyxilX5Uv13tTm9UdXlIYXGEgEDn+t62ZpBKHyw3pvpiuqy8TGziuOwukDKqET2xSlTytlBCO4tG/lpXD3TDq6Di2ylIlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070727; c=relaxed/simple;
	bh=z8rJXMmxlASWUbyFEAKP8P/3qFO3Ptq8mGN9eXy1jFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMrvaAPzIXz2B7dVXBA12KiqxrnM7lGUVIBeZwc5+oJ1x28AYRjV1D8uXvkW7bKHFd4R/+M7OtBiIovUhN6/EYVGDjR13vkpummSJNRbd1DnkiAqHFyl0WYWLCUBuFvkC8piNILMoHuPSojtldGTmg4wlEkjnXI0llUDLP0bj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuZodHjl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuZodHjl"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2db710396ffso11857135ad.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070723; x=1789675523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnuVxbiXCgrcJRB1M65AA3bcvT6F9ansgD+TG7v7Nac=;
        b=RuZodHjldCffGC11wbFFs73TxA4M6SBDNALATa5B00+aFFN91sAq6hIo6zO7+HhUiZ
         Y8Kn2x7W+9175QD/NQhM/w1NtEu3/ZrID25h6YaMfmSBSSJAb2phGEUEB8hqKMc9cIfj
         sj0NVMzDe12tVa8tG7RvMPycchfpwzfbJrzqvzwNVPRTEqyfGM++NXFC4rJ8CT1RON7l
         t/9UfbQ7Gh1FevLdkaq8sUwNLLy08UsTkvWoEYW8/tMQXihSrSTOWjiUvWW9cVJnSH4X
         RIV83H/nzjK4DZ7+ypOfbW1f87vkPlv0kUr1kFbiDHgZ515Vh/ItuehpCPL8oP4tbEwP
         wB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070723; x=1789675523;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NnuVxbiXCgrcJRB1M65AA3bcvT6F9ansgD+TG7v7Nac=;
        b=gQIXnrfXLRDO21lgi4OcJfChhswQg/ftiO0cobLaE7d1/9sP6+vzyONF3t8Nz2eugQ
         xISj2jBiWqygOAGxpxsvG0RV2nHdYzPQs2FPTlFIpu528Rg20DSyqeKZbIBLIBNmakoZ
         ZovXakpfW+t0TFD1gbxwp9rjCmK9DkrATyW3L8rclKKPbjJY+e2OfZfpNHvSAerqGn6p
         gDEdtMqnyu+7FtZrQSUo1+aaURYSzGC1pVwGkNNdILCP2SpbLbeyWopel0yEh6RfEj1r
         LUDDvVZyyar5QMDRjcAZqNqeQ5eBIpQzdIo3+kaIzGwv2Pssf80ScuklQFJ86l+MqIov
         0JxQ==
X-Gm-Message-State: AFuF++nutfICB/KAZ7mwGbw37dRQkGIbZoRcB+9gPekxBK9lac9/OHec
	s/e9gXtaYdHNm7XpuLXglIOUQQTRYqi68ltZko/67aLDelDpQiBKEwi2
X-Gm-Gg: AYBFou1XpiviHCN/x4Y09yi7ICUf8n2JXX43fu23aLAxOOqIlR2vdzK8kJP5ToqFxq+
	YwlxQQPltw+/Ms6oaQ9YQWbEq2EhYWFJcsMzJOmMo6pWDK/c44W8YZFjcnVrUHn65HJCzn4Mnmn
	9wRHcqElpHcgiXNWd3111Li8ovuXekSe7SyiMqAoaA8/DiXSXY8rGIQxqW290NeulMCekkSKurL
	7pN+0qpq13BYV6yGx8izG271702B/Oc1XqNFfUBLdDv93ynWf+SQz8DOp7tnmt4I2ZVjWE50Vpa
	KyfV2f7mCubv66uiVZyh43TCISulFydi9mKjqy4YY4BJjRQhx6vB277gLAMz3F4XPw7GkXN9GXp
	eeVPnhH84r5lMu7JVJggEKSrviy2hkvjE5xGaJbP9lyCVXmz29SbSzTPZzbv/lOSFWb59He6xEa
	/UlDQIkDzAH/YtDsq5wbrath5XhSjU7Cj46B7bNsWFWFj6PnH8KEEPxMiTAy5kKC1B1d9Fy5wbM
	k2cyeW3JahUDpDcMc5ceWHF3s8nNVYoKVrdtJCbosqhhsuNMbD6A0uyrc0s9ZXSgA==
X-Received: by 2002:a17:902:e74d:b0:2d7:1b20:e98f with SMTP id d9443c01a7336-2dd0e8a1969mr66012825ad.2.1789070723090;
        Thu, 10 Sep 2026 13:05:23 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e95075sm409076eec.11.2026.09.10.13.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:05:22 -0700 (PDT)
Message-ID: <a781d941-90ff-452b-b2f6-c43134cc7b55@gmail.com>
Date: Thu, 10 Sep 2026 13:05:21 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] HID: hid-oxp: retain fractional brightness when
 reading RGB status
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-leds@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-4-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-4-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> Multiply the hardware brightness level by the LED brightness range before
> dividing by four. Dividing first reported every intermediate hardware
> level as zero instead of 25, 50 or 75 percent.
>
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>   drivers/hid/hid-oxp.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 0c895bd..86a559c 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -334,8 +334,8 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
>   	drvdata.rgb_en = rgb_rep->enabled == 0 ? OXP_FEAT_DISABLED :
>   						 OXP_FEAT_ENABLED;
>   	drvdata.rgb_brightness = rgb_rep->brightness;
> -	led_mc->led_cdev.brightness = rgb_rep->brightness / 4 *
> -				      led_mc->led_cdev.max_brightness;
> +	led_mc->led_cdev.brightness = rgb_rep->brightness *
> +				      led_mc->led_cdev.max_brightness / 4;
>   	/* If monocolor had less than 100% brightness on the previous boot,
>   	 * there will be no reliable way to determine the real intensity.
>   	 * Since intensity scaling is used with a hardware brightness set at max,
> @@ -423,8 +423,8 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
>   	drvdata.rgb_en = rgb_rep->enabled == 0 ? OXP_FEAT_DISABLED :
>   						 OXP_FEAT_ENABLED;
>   	drvdata.rgb_brightness = rgb_rep->brightness;
> -	led_mc->led_cdev.brightness = rgb_rep->brightness / 4 *
> -				      led_mc->led_cdev.max_brightness;
> +	led_mc->led_cdev.brightness = rgb_rep->brightness *
> +				      led_mc->led_cdev.max_brightness / 4;
>   	/* If monocolor had less than 100% brightness on the previous boot,
>   	 * there will be no reliable way to determine the real intensity.
>   	 * Since intensity scaling is used with a hardware brightness set at max,

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
