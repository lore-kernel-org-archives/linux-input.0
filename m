Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10A141B361
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466783; cv=none; b=ROUFgdZaddSLvdXmdd3Xwy3a9dHboA9NxblfXUEoW1Qy7HScuKMqNMWOGAplATVsB07SVp7roB09wuD2XRBydEW63nFhqdi6Me/Hrc4FwOAyUgdODoWUmZ9dLzhbLOcub9BZJgwVz2kMzIAaK16F/wtCyjiOukkU8XZ/Q0SVlqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466783; c=relaxed/simple;
	bh=cSI4UvLmu3nc2agJSrZQMx03WUPtezKCSNssLL/i+VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZiuVWuepEwUEUreOI2/GT4MfUbOwVAnN45gtAofAy4ynz4pTOC3Hz5ORIdD6uAXkiGwwu1XztRO7AhtCjZkVam5cELzau9vEq+H27RHcInXoR3qDk8lOXRY7NgsRLEsr/86Gg4eaYfXpCCYPLiJSvsM6CP57ZSlyg/YOtPGdN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C59py6Fj; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C59py6Fj"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-464ba2bb3aeso3604905b6e.1
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 07:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772466780; x=1773071580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WtWjK/XrBFXhlPr3QyvBUKjwrSPr3UtmIW2Gtd1DQ8=;
        b=C59py6FjC1Egf/a0Qk1Xks12CiPRfil5/zZJKiVHcuYcBfXHEwyJxgHP9xhVactflJ
         T8szDakNG5m3ijSYKQ20t6eiHWpVtywlMktd6kXEafBXQc0qbRBafuCp7YuNGo3cm8+v
         Jz8DDDK3AxDuG4tGZL5ehIXAj9jcCmfMGHPdb0h8JywgvLJPOKqCAhHSRZSrCg54NM+j
         bvkW08d+yJepYeibN8m7e8x85CiLgjuRlrBdSaIaj2CSEV3GbQ2kG8OSQyg8J3mchMus
         F76AvltS0x0n1cpIbZUAxKHfOI22JyVM4W3AuTFl5DEu7DXifws+xGDM/8/AVMNw6kP9
         9fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466780; x=1773071580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WtWjK/XrBFXhlPr3QyvBUKjwrSPr3UtmIW2Gtd1DQ8=;
        b=vinFcoiQEPBuWWc5RgUTr75by/ZVS2g89kRX7pX11L5pweLA5QCG+G71ES2m5EOV78
         Ku50rHJ+nbEEVOXdEzVt6ktEdb7MQ6yDFbaHj1ARgV6iWH9nW2L/lMOOVWIf+adoT5J9
         VFrt9EYhLnDBtB2AwwWOCBZ5hb6mBRz4XA/7D8R5xBsNhct5OpL0EMp54z/6Gx9rU6H8
         RfVdj3KrLW0m87y75ZdCkD26FPDmpM32HEpeMw6VRQARMVPHDSseGho2sKuRwdktUH6b
         FDevhI8oY7xhYjQ2glIgu3tmqg7yhbF3jDa9rx5mICOWq5rZVHBWv2+2oNNpQXPa4gM5
         vdjw==
X-Forwarded-Encrypted: i=1; AJvYcCVSZuvQpE/M8701LcmcgQrCR5RU7yu1OSm01GkZUp3PCfgXOTKZ7InMwvOjqGKzUuGsXPs7uCKz9Qf0Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhX8wZ5G3XT1s2S8DerB0mCsjPPq7vMBzAgGpV9WjVeQVQDll
	HbyYmQtbEWZwAfHzgQ8Bm2atXUJHvlMV72HQyuGTWKMHxUiJUxAMUojmTLrpNOdF3S8=
X-Gm-Gg: ATEYQzyVJ5GodE9pxdvKauU3MFxS3c9eMbBkX+2Ay/YRC9D2OBRc2xBdVpOmscJOOyO
	saT4q/RAIXuTgTDUTkximl5UgvxBRIiZnwc8e/zErukiqGXbBBYR6CQpSXZjs4KwK0lBNT84zxs
	vHUJ0ZBlAuKSGuOowtwtncx8gtVvlhtWbxDyc6pfXlAflmgXbyqcFmFW4xkBb3haTO7KbTH+Izf
	cC3lB8r9KiJ4G9y7CfOTcE0OxsdQvYIroQScuHZyMyWcvZkY8UWIZ3zfT3rWCp1n4AGhYiUrnlo
	NkRmNMwij7Dh96aYO0i14DOEpYH7YyJ/Z1dLvkPZXxoz07ZIFAGvDm+/QN0FfLLFfyUdQRmMFFj
	rZr46lg+E3R6ee/D2GROilUxT48IeoyfSMgO4VoGeVOBAIvWwKcBX9OpIESeJjEAKU+ay9gI4cy
	PPLZIsPryoks8sXrCrKvawvFhZQDb2RK0LtUMP6OC+3w4CClBELspE6WbdoIZnjKYMX1vaByRM2
	VPmXF4B3zn7
X-Received: by 2002:a05:6808:1188:b0:45e:fcf2:b693 with SMTP id 5614622812f47-464bf0363f1mr6898511b6e.29.1772466779623;
        Mon, 02 Mar 2026 07:52:59 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7? ([2600:8803:e7e4:500:4c09:7c6b:bc48:f2f7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb5d0a8csm7577165b6e.14.2026.03.02.07.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:52:59 -0800 (PST)
Message-ID: <d22e03b2-2093-4d33-8ec5-484f64f2e8cd@baylibre.com>
Date: Mon, 2 Mar 2026 09:52:58 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org,
 Lixu Zhang <lixu.zhang@intel.com>
References: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
 <aaVRIOejIgnOdAfY@ashevche-desk.local>
 <6158f495b13f2a8cdc09f37e296166ccf0393c78.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6158f495b13f2a8cdc09f37e296166ccf0393c78.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/2/26 6:32 AM, Nuno Sá wrote:
> On Mon, 2026-03-02 at 10:58 +0200, Andy Shevchenko wrote:
>> On Sat, Feb 28, 2026 at 02:02:21PM -0600, David Lechner wrote:
>>> The main point of this series is to fix a regression reported in
>>> hid-sensor-rotation where the alignment of the quaternion field in the
>>> data was inadvertently changed from 16 bytes to 8 bytes. This is an
>>> unusually case (one of only 2 in the kernel) where the .repeat field of
>>> struct iio_scan_type is used and we have such a requirement. (The other
>>> case uses u16 instead of u32, so it wasn't affected.)
>>>
>>> To make the reason for the alignment more explicit to future readers,
>>> we introduce a new macro, IIO_DECLARE_QUATERNION(), to declare the
>>> array with proper alignment. This is meant to follow the pattern of
>>> the similar IIO_DECLARE_BUFFER_WITH_TS() macro.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>
>> But this is in conflict with the other hack-patch in another series.
>> I'm a bit lost what patch 2 fixes here and that hack-patch fixes
>> in the same driver. Shouldn't survive only one?
> 
> +1.
> 
> I see this is older so should we only look at the other series?
> 
> - Nuno Sá

They are fixing two separate bugs.

This bug (which is a recent regression) is that the size of the struct is
wrong. It is supposed to be 32 bytes, but a recent change make it only 24.
This causes iio_push_to_buffers_with_ts() to write over data past the end
of the struct.

The other bug (which has been a bug for 6 years) is that the the timestamp
is in the wrong place. That patch also has an effect of making the struct
the right size, but that is only a side-effect.

So yes, I should have mentioned that in the cover letter that this series
should probably be applied first since it is the worse bug. And it looks
like I'll be doing a v2 of the other series anyway, so I can properly rebase
it and declare the dependency.


