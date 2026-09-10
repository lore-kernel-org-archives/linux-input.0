Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9A568545
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070679; cv=none; b=G0+wFXMqLeu1hShKq2NWUu/+07BLSA/QyOK9AxmCTJSkgGUFIWHlKGODtEZ3WK61b7iHwan67KT2uz97m+jH+1SLme+ecu0X6FUXVyp2o/y+zWjCnjkpnMJ7sCvgJ6PGnSLMvWZkCQBIaS7HNgpARRKoWtDnPjbfGRlnn6LVkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070679; c=relaxed/simple;
	bh=E/u4JbeHNzAyqPkp0nbuRzJRPv2PPFHaZAvR6l/kWps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhMoZqxp4fSsj12vGOLCfrZHwJgVnyZkHDZUD21PV2Ne44DUgEEBPuKn1Dj5A89KrFlKmbK79zZydpZw7BDfnhOoYLW8kkwzwOQY8DdUhNvJp26PcD6noLHPcDuqnfw/+XItnbZrti8iynJDj7W5wR8VQIgQO5TcDXk9c5iBwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwF2gGz6; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwF2gGz6"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a856865so98369b3a.2
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070677; x=1789675477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=glhIiPms7olMgwg+mn5dw0hW61m6sgEWq22CFgDOSsk=;
        b=BwF2gGz6vc3TgDUAjUhap/8LsAe6ipxAXeVIC6sjNwjF0L6Bvyy+KyoVCoSXugncY/
         VOf9qZEX1L+9YIe9j4q8+kMpGhpTwZKOIi11vhG30Qt4NnhlBwId65QZMr8qjlMZW9Dh
         quZpalr3AQw/4MFy83XkWV8K+evQQRwyofbQrG3dN2G5dOu7RmaOTapllvDIXfLIv4Do
         4am42PtlLgBQ506u+tzWhJAewY0YKqkPzYGXbI0csh+0/vXphLRnioazmjKHOrqu0WHm
         HofAVHC20lo7GIIiAXc3cdTgRgcrUmSbUc678CNH8H0u5a/9eUbtyNcO9Gd5WrDu8AO0
         dADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070677; x=1789675477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=glhIiPms7olMgwg+mn5dw0hW61m6sgEWq22CFgDOSsk=;
        b=M/w1RWdnW1q9/sQRwgYb0QgSayDHu0HERP1K0Ihnfs2N5ALZyjTB3gnupD6qK1dYjo
         W7EKCzzAI84fQ0nOVfOjx8hBefmJcyftmvWK9V9buDdHuP+g8mxRSK+CrJRF/s1tg5mM
         2LcGu7dGN2SCYN+DM9gLE1Lzc9yKLBy/KRZWuDG8s1FNkyWaY8mwHNuFzur07DGolC+m
         4bcTB5bK2W+ptlp8echevJI7gsJPUsR0P0KngNbFO6GZx5ScKkPdRY0E1zx7uINf9FA9
         k+v6/1FyvhoD5o+OIBz0uXBXhQniLyTiFuUol4ifOkMcE/00p5Z/8U1gdbaBbmXB39Lc
         XcoA==
X-Gm-Message-State: AFuF++myoDgmkPxpcVt69ZOPM+N+fQFqOrCJD2xCM1agadOrJcbAGwV3
	oSGNMMSueWucToogjHoLqpYa8/g+BA8SqGmz5gMrJlWvFNXsI6RipcCy
X-Gm-Gg: AYBFou0dR5wofWud3gVJCps9KbUlhNqgywnHvtsr+2RcIq+OCorO9fFQANBPQUBMzWz
	r/qtCX/yN9C6pu00xKDqZzgJ59FCUPcO25te9yNb6jwGZMGx3/KuWlp0DXr8W07unUq6BEUd+or
	vSazrBp4eyg71zVna4IV7Uqw6D0cg/Do2HEkEYU4aaTr7e52dDe5Kkr+Zt8Oj91uBipfGXxuwZZ
	ElH0FtvvF4pcnRAdBFYaGtW4epyb/vlV4P8f9/4s5yRjdATTQKI44ZFgz42O9XwkG//HeStr5VK
	WZtO7/T1lFiYgi2kOIHZRavdo0FFjXG0B+aXjY9xfGf7TCNJ2IwDqucMW6DaohJKzdPTGdoSqRp
	VuRxDIFmHTUemBKRKoXweDVzj0JYcp0ZXAfY8x9LPk10l15NI8ii05nI/K8BeTL7hp+QViTF93L
	rUdqZbcGBdz/USrIybisYBBDoCacYRpglqdSPVp7Jhah80K1uk7dKmOP5zFtmIwQdNsXSTDPbrp
	pzQGQARxMhtWiXvOjI52fLRV6j477TcBpelFbC60sy9MSMTKBU3B+NxGnwABE1zig==
X-Received: by 2002:a05:6a21:3292:b0:3d3:adad:f173 with SMTP id adf61e73a8af0-3daed3b7f4cmr782259637.21.1789070676939;
        Thu, 10 Sep 2026 13:04:36 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b5e1edsm929478c88.6.2026.09.10.13.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:04:36 -0700 (PDT)
Message-ID: <76dc89d9-86ab-46f3-b26e-f01b550000f1@gmail.com>
Date: Thu, 10 Sep 2026 13:04:35 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] HID: hid-oxp: validate input report lengths before
 decoding
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-leds@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-3-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-3-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> Check the short Gen2 status header before reading its command, and require
> a complete RGB status report before reading either generation's fields.
> Use the supplied input length for the debug dump as well, so a short
> report cannot cause an out-of-bounds read while logging.
>
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>   drivers/hid/hid-oxp.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 3f2be80..0c895bd 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -23,6 +23,7 @@
>   #include "hid-ids.h"
>   
>   #define OXP_PACKET_SIZE 64
> +#define OXP_STATUS_HEADER_SIZE 6
>   
>   #define GEN1_MESSAGE_ID	0xff
>   #define GEN2_MESSAGE_ID	0x3f
> @@ -318,6 +319,9 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
>   	struct led_classdev_mc *led_mc = drvdata.led_mc;
>   	struct oxp_gen_1_rgb_report *rgb_rep;
>   
> +	if (size < sizeof(*rgb_rep))
> +		return 0;
> +
>   	if (data[1] != OXP_FID_GEN1_RGB_REPLY)
>   		return 0;
>   
> @@ -391,6 +395,9 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
>   	struct led_classdev_mc *led_mc = drvdata.led_mc;
>   	struct oxp_gen_2_rgb_report *rgb_rep;
>   
> +	if (size < OXP_STATUS_HEADER_SIZE)
> +		return 0;
> +
>   	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
>   		return 0;
>   
> @@ -404,6 +411,8 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
>   
>   	if (data[3] != OXP_GET_PROPERTY)
>   		return 0;
> +	if (size < sizeof(*rgb_rep))
> +		return 0;
>   
>   	rgb_rep = (struct oxp_gen_2_rgb_report *)data;
>   	/* Ensure we save monocolor as the list value */
> @@ -435,7 +444,7 @@ static int oxp_hid_raw_event(struct hid_device *hdev, struct hid_report *report,
>   {
>   	u16 up = get_usage_page(hdev);
>   
> -	dev_dbg(&hdev->dev, "raw event data: [%*ph]\n", OXP_PACKET_SIZE, data);
> +	dev_dbg(&hdev->dev, "raw event data: [%*ph]\n", size, data);
>   
>   	switch (up) {
>   	case GEN1_USAGE_PAGE:


Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

