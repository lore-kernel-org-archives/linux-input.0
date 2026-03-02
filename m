Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DF410D26
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465974; cv=none; b=q59thuEJmdnVzjN2oYWn5zAmyDr8JSH/HYs3o+e+llDjGI1seAvTCbNPo76mJP+v6Oi8eny3Xj1XlbZzfH3qyDQ7KzecU015Y66hmSuM+sbaKcngyHizMNJcfeoRMzk6k2JzFFV4J24HBsSb1F7xR1jO43YL9ZVV+cxf+z21H2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465974; c=relaxed/simple;
	bh=pu1I02sYh4+cO2CSPw9w87sHzIWlMmVNgS2cffxbA6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxmoS8VaJNh5U5qQVtemXveXigX0ffqU4CmcOIvITDbx84Ke+UfdI6Qa1F+DMBK4qyUOwZxp+vfLvPyowD13fJuYx2NbfD5lxUk1GfiNcCzQS6lIeWhSVOehLVGmAh58kAcQlIiIva3Sj8NooidMTRxYWCwCD2GmnTCqQhZmHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9ZJxG5V; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9ZJxG5V"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c68f0e47so3108512a34.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 07:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772465973; x=1773070773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQKYDG8QbYnUOgU9BiYmvyjnHkVzeJt+cs+KoB644B4=;
        b=c9ZJxG5VgiFCXPtHXziRtMzO8J8YRis9FBfWQ2Kd5FqMD/GBW+w1nNZJw43R/WacJA
         lZHwG4hoJno/SFdgV1t2FIJisYkaXNmhTzMVrgPhHsZ6coC1bqaNQvCqxyKyLDCtUGdq
         zg/1qCi00TDIXdux+NG4hXcYscxeQAzUAtjCmhb+tmMB4v0/eu8O9TW5u4Z0jgCb0o7W
         UQd0L9x12O1Zv8QPX9Ba5jOKmBezOAfwAY51NVoDJUASFZAywUJDRg41fq4QwPFa97Gc
         wFMsyMnA/FxGROhFxv3gPnpjmgIVsk/SdWMT5cWg3XuMPPLJr/KF+Tb2jqmzJ4Y96un7
         8ZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465973; x=1773070773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQKYDG8QbYnUOgU9BiYmvyjnHkVzeJt+cs+KoB644B4=;
        b=XDvTZLoxOGU++qcy2xS1Ab1IqDQaw4TwLnQZbZQuv6LnQiyr+Ux7v7dy+5pTdzoGvo
         yan1cY1z9pVYNuOUQzf5fXmY5F1U0goRpdQXPB8cVZke6jPoxnXS/lPgrfZV5OZFUZ31
         7y8/2rVa0bTN0Xya1T9nKScYaKU7pinKsfdmSK7voYkxmyVkxcC8+xSSx6Kj5nUgC+aJ
         M5JdAgRZCdIMcxu7C0YsTUMxShaH9aU6gITdoyV9WUCkx3JrDoni+SXi3WX2L8DeUdZV
         a5puc82JAkTtMc4EhOre2Y729+SArV3X2XCddKiYX6s0uAstFc1rBUeKY4B/Li8QQIix
         Wv4g==
X-Forwarded-Encrypted: i=1; AJvYcCXObaqGac/gYO5emxtIkfnangpp9vvd046DekodBijSxer0KZaLff0jDKqI3xneuADnvK5Yms9OuThh/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/sZTvs50L8kapcFjWG1Eu+Lp+YXrsA/Nr31cd0/MP3njUTma
	l4X35SZcV+IA1uK1K/ZbKJ3PglIanGGyAF8I4DZabydQt/uVTjBY5cXtq0GrLCq/jh4=
X-Gm-Gg: ATEYQzzyRnduTTpJ/qjn0Z3as6Gyc5a0F4tHc47fJ+EB45IbWdzDn0hNZYQNWcJ43ir
	llLjVnsvsbJRAi7zLSx4AGdYy8jDl2TLddgfw5aORYKrgBNCT2qov5ifTTlGofgJVPUQRFTVfQE
	Y5in0E/8MYxmCbV3jtejPFb/m+cvqGwWhPrM9rkz96/2nPp897/NRO78N421itWqgcs+3t+2H0G
	q7HcY/w73sfDCrNOymFPQ3PgHJ+wrehzI2vca4LWQgWBRvox+jtmsuPL7H8LVTAD1WbTGZrdxa3
	lXB7Ub691GoqSM1Ms946WUVy/bxkM/NMdl0Wj69xk1oZPiXaeCvK/NDjOn1e4ImyD9Ov3ZKZDzv
	EFVlJunGyx6bL59WnwVSBU7rvWCL/MVPWxTKwXkAB3MhR4aMfm0lfhYaspXrXZK+bgau/LA4sdp
	kuyqjHpfQL9Y3zaXQdzp+olcJzWhwGtAbeH0BX3M6JX5ULobDy8IP6qqItL63f92ikdcMvRG3V6
	w==
X-Received: by 2002:a05:6830:854c:10b0:7cf:e3f3:437 with SMTP id 46e09a7af769-7d591bcdb8emr5176114a34.22.1772465972689;
        Mon, 02 Mar 2026 07:39:32 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626869sm10916908a34.16.2026.03.02.07.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:39:32 -0800 (PST)
Message-ID: <d7809acc-01e8-4dd7-8c6a-a7e8386a9e6b@baylibre.com>
Date: Mon, 2 Mar 2026 09:39:30 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: buffer: fix timestamp alignment when quaternion
 in scan
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
 <aaVOrvyzgDKNsB0S@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aaVOrvyzgDKNsB0S@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 2:47 AM, Andy Shevchenko wrote:
> On Sun, Mar 01, 2026 at 02:24:53PM -0600, David Lechner wrote:
>> Fix timestamp alignment when a scan buffer contains an element larger
>> than sizeof(int64_t). Currently s32 quaternions are the only such
>> element, and the one driver that has this (hid-sensor-rotation) has a
>> workaround in place already so this change does not affect it.
>>
>> Previously, we assumed that the timestamp would always be 8-byte aligned
>> relative to the end of the scan buffer, but in the case of a scan buffer
>> a 16-byte quaternion vector, scan_bytes == 32, but the timestamp needs
>> to be placed at offset 16, not 24.
> 
> ...
> 
>> -		((int64_t *)data)[ts_offset] = timestamp;
> 
>> +		*(int64_t *)(data + ts_offset) = timestamp;
> 
> What's the point in modifying this? The comment you added suffice for
> the original line.
> 

ts_offset is now in bytes rather than number of int64_t elements.
So ((int64_t *)data)[ts_offset] would now 8x past the end of the array.
