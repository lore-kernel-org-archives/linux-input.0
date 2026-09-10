Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160056C63E
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070873; cv=none; b=kncrmlEVUmluq0CMNGuwLqg3HamdgpYv13BxeFaIghPYOspwXj00i14JJCrwCOaOFdooHZUhhrxmHqg666t7pWoh4ci8y1z7hKRASn8EIZgx1Mv42g5Txljnh4kv/TrSJlIlIt40KV4mulurnzafEfwNcKc1kBvz6uGvJj5KuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070873; c=relaxed/simple;
	bh=AsBTu9mpyhzRchZiMp555VxdVBD2V0/4+SAhW/xU12I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+NiMhcZMGgVtzT0xH8WJNodxwCHNSXzdGsc3wD9yXPAxKMwRKP2i0Ph4a32ARZiHDlp3Js4qJg/vEaAsTBOJqwoxyB8wFLy4HFBxANcfCTMy9fHlubQYUsH9iS0VDkkHXn5PABBGRdP9N2pa4xmJDjaJXlXzwNCc4tlNWIXxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgdWidPU; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgdWidPU"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so874095ad.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789070861; x=1789675661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbfqiWzAX0EbCmILdSHnkqcNgbIbLdok++0YD66gtk4=;
        b=EgdWidPURIFa8LSt5LAjKRixathjLQDpQ9s9tMS3F6HesjSKfMX+p3VKwOefesj1qO
         J4S/tvbl071upJ8yjIBXmYOrahIPSIGdsF+no94dEB1/+Q5xvuGfVhq3fQJJlhat1Zfa
         GEjvYdXCHXcGjavVnKI1hlaJhwRHp38wLH6AhPil7kfDz8O8pGX3Ja4YLPfqhY6wr4Mv
         TjlTzFEJnbqTWkBdnGHyoNh6J1HR/UGEQYqe5DEux11seSmTxDrZjZr1GdBMo/6gCXDO
         n8qMaKYI35HpHa5EabA2LfpZF43k+AlEHEUWTtclglaubnZrQnzo78T9kipkfNMKVqmB
         y8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789070861; x=1789675661;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RbfqiWzAX0EbCmILdSHnkqcNgbIbLdok++0YD66gtk4=;
        b=b9H2HanyA35F7M+dqh4ZUqOQrdH0HC2Kd/7UXoyzf0a/ISx0Zdkhn0vW1hSgahnKWV
         igi1MRRcbqZTyDFlevSWxfgMB9JzWG4X1q7K4IhbcK0PjAgCYxoz90ej01VVUfTgY2yh
         xU6xgWMdu7ruOKsIOEiIig6hrcpy8vgRy3iG0zeoEdM/AuSsJQ9yDWXXV66KcJBjVwcU
         p8xWlOvh64QFQO2y+gnUlXkwzfzDNTDcHI5JeRvwONHq/38Aw6/ZAbJU7g3NeoQUg8Xp
         kVOkmXGNwhm5snTg1JXPI79/Zv+V1ueExzeEXycws9QcmY1RrUblkZDsPe4rBOM1gvSH
         y2yw==
X-Gm-Message-State: AFuF++ket/m6LPPhi7hgVXb8B0Y02uxHGatFwpQstJU2iqqbASxAYnRu
	gpxthbW5CC28BxdkH8cadXJRakMHSL8OhxluTI3LPx+byv73hyM6mFdd
X-Gm-Gg: AYBFou1okfdC362/D+RHBlXuOBogi3NJJjKNgf79kGKy3QhapiYcjV7o/KzUGgnrNy4
	KUv3Us1rG82bSJqY9uGrRdxejASC8tlqIfFM8qtE50bTW9WT7edO5P/p00shVlYkzSot7lf1Zc3
	akHy/o7RXdVH9M3CNkT1necHjqZqt5qr0B83miNLAvvfwiWSMxpPXJUqWZ9zNd/RTmDZlkYRDr9
	kgRZM92yN3TZbNyjVzRRRIp21NDUwJdXRBxQOWohOUb/kv6NYZD/o7hWroPQw7Bzxx8/Jx3eXoc
	02pVHPM9xba8KCZOO7yiR6dHnKfW6/vh4mZbNUPu3ffUUtANxvtoPf+JaLBEzfgLicR9lamplTF
	ohVzM8IM2HyQIyUzVt/tmBjMQtg8uY391yJhzDODIhEq99WZLJwumAexcIsU17LBR4jGZmOYDTS
	W8/ql/DdCMrDgzG2OU1BC6LDEoHqEjIUr//YOvgAprMsR0E957v8HhkjSRAS8LNsAz06xn9CY6Q
	7MvrSChLqDoCptNWx2lMqzOjwacUEo5DLnSnNF/IspZruRiGux5Zk5oAnGYlVl3Ng==
X-Received: by 2002:a17:903:8c4:b0:2db:2ae9:fab3 with SMTP id d9443c01a7336-2dd2a33680fmr18443635ad.11.1789070861121;
        Thu, 10 Sep 2026 13:07:41 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f06423sm389262eec.20.2026.09.10.13.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:07:40 -0700 (PDT)
Message-ID: <d5960580-a130-4d67-8b24-1544f1e7c135@gmail.com>
Date: Thu, 10 Sep 2026 13:07:39 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] HID: hid-oxp: serialize complete RGB updates
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-leds@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-7-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-7-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> The transport mutex protects one report at a time, but changing an RGB
> effect requires a status command followed by a color or effect command.
> Serialize whole RGB transactions so sysfs and delayed brightness work do
> not interleave these command sequences.
>
> Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>   drivers/hid/hid-oxp.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index bee1317..8d07816 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -181,6 +181,7 @@ static struct oxp_hid_cfg {
>   	struct led_classdev_mc *led_mc;
>   	struct hid_device *hdev;
>   	struct mutex cfg_mutex; /*ensure single synchronous output report*/
> +	struct mutex rgb_mutex; /*serialize complete RGB transactions*/
>   	u8 rgb_brightness;
>   	u8 gamepad_mode;
>   	u8 rumble_intensity;
> @@ -1074,6 +1075,8 @@ static ssize_t oxp_rgb_status_show(void)
>   	u16 up = get_usage_page(drvdata.hdev);
>   	u8 *data;
>   
> +	guard(mutex)(&drvdata.rgb_mutex);
> +
>   	switch (up) {
>   	case GEN1_USAGE_PAGE:
>   		data = (u8[1]) { OXP_GET_PROPERTY };
> @@ -1191,6 +1194,8 @@ static ssize_t enabled_store(struct device *dev, struct device_attribute *attr,
>   		return ret;
>   	val = ret;
>   
> +	guard(mutex)(&drvdata.rgb_mutex);
> +
>   	ret = oxp_rgb_status_store(val, drvdata.rgb_speed,
>   				   drvdata.rgb_brightness);
>   	if (ret)
> @@ -1244,6 +1249,8 @@ static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
>   
>   	val = ret;
>   
> +	guard(mutex)(&drvdata.rgb_mutex);
> +
>   	ret = oxp_rgb_status_store(drvdata.rgb_en, drvdata.rgb_speed,
>   				   drvdata.rgb_brightness);
>   	if (ret)
> @@ -1302,6 +1309,8 @@ static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
>   	if (val > 9)
>   		return -EINVAL;
>   
> +	guard(mutex)(&drvdata.rgb_mutex);
> +
>   	ret = oxp_rgb_status_store(drvdata.rgb_en, val, drvdata.rgb_brightness);
>   	if (ret)
>   		return ret;
> @@ -1340,6 +1349,8 @@ static void oxp_rgb_queue_fn(struct work_struct *work)
>   	u8 val = 4 * brightness / max_brightness;
>   	int ret;
>   
> +	guard(mutex)(&drvdata.rgb_mutex);
> +
>   	if (drvdata.rgb_brightness != val) {
>   		ret = oxp_rgb_status_store(drvdata.rgb_en, drvdata.rgb_speed, val);
>   		if (ret)
> @@ -1470,6 +1481,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
>   
>   	hid_set_drvdata(hdev, &drvdata);
>   	mutex_init(&drvdata.cfg_mutex);
> +	mutex_init(&drvdata.rgb_mutex);
>   	drvdata.hdev = hdev;
>   
>   	if (up == GEN2_USAGE_PAGE && oxp_hybrid_mcu_device())

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
