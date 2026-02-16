Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6C328241
	for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255562; cv=none; b=N0z8iSua8dVb18btUi2Q9EGsR0tSEMPnRXEnuCyBPVhKsSCy2m4rpfcGP8latMCPj1WxYJgB3Xq1+eXTQAUeyrfBPdBAz/18k/3FySTKbe4scH6yEalArfLtJEhBsVmCggEI9u61O5J6/qtXgqJRY2C4BhwGle1Q6JrNkWO4Ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255562; c=relaxed/simple;
	bh=s/u9a7RFxBkreXqZx0ZwHqcPArovGyAc5UL+kxKtdg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0YAarXEgh4JSbkzLxHzv3LFBp0OFDB3eFLXimJvSp/T0+cMZGaLoZmQ+pIPZzPJZAOGG0dBiX8cnPV0w29XDjViZcuitngW1FIFAmvwpxWGzAWAbasFfVmGaRMeuOf7pVL50H4MWCHDJ5ot6EhtAxSYWENpznrgKiI+EsN6IHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PpW5tVCi; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PpW5tVCi"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-46398742245so737127b6e.1
        for <linux-input@vger.kernel.org>; Mon, 16 Feb 2026 07:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771255560; x=1771860360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDY1pgwN95gNKwiq9tVCFy3TSoHft79BSNGMSnMpMmY=;
        b=PpW5tVCicIKPqMAOlJwMhEr1fYa2vvWqmJy57HILg5XA9v6Wk+lEjJ91+YfohWAxN2
         X7da4y74D2oov7MaxOm32ntYHnvMZp0MMszj5MmTrmQ5Cv5k/HdQBjuJ13rdr59GRkAX
         DtoUCqzikSMmSdOuok2h8tFgtFS7qsrt/ETz3ehY3lrf1HXUag9EqM4QNrMQaTwSpoSo
         Fs5tRGapW5Jgl+YdGNihNhlfJZ304fgV9XsrzBkz/8nYVBx2GI78c3VfCoPrVqkf8CBG
         TiOlmze9rUSgCa5MwzuDFTJHE77dgXUoJa1BnDKXnD2snWTPNynE9CpcaLIr1N6TIDlA
         3xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255560; x=1771860360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDY1pgwN95gNKwiq9tVCFy3TSoHft79BSNGMSnMpMmY=;
        b=Oe947y93pDR8jF1f6IjXPkYXla2gqaz2VFKkXUYt5JMBvsMrxbC5ukoMROkY6Ofzmi
         3EmEF6OJtZchKkcBrj92xstmqYL4mIjKsahjIRq6lKVpO3JAH2EJj+AwhC5xsyHRhCPP
         DgEJZWKRof78L9Hgf5P7te94lKZC2UsXlSJTHLQ2+0FmUuSaIhaP94svHLaq6GZhFkkY
         s08RU76jfM7IxNuyIScUZcFA9DbrJmonNhQKThbCUyLTfvru9zI5OXMW3G84+IOtFqQ9
         LfDw7/8pD0KDja5Jv2xytvDkZLangFFAJrIAV/tAeB6l42nkhOrnvDJkjlJSPk6BEKSn
         oX7A==
X-Forwarded-Encrypted: i=1; AJvYcCX2S/ic1645kQssX/2bq6J+qmH9xEKil39WiTLpAP0XL2UCwX1jsL+gvgvGjMj2zbJ5SMJRMIKWyDXwHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rFVA6l09EKiXjHRpqITPQAZtRkAlRM1AcGvpy116xRSZMrhD
	Ky2+a2ZCHBgLtXlSUG7bR3ATKsIZG15Kv0I+HaBGm4VEJfCQ2IxSB0hX+oQwlKfRjHo=
X-Gm-Gg: AZuq6aLlPnPrHuD60dv+Uq7cOPUD4BXJaHP35IvwnKU7yeNNhC5qQ09r9LLO3lUCjQ3
	PQ1epzLgZNZEwD+RBxWNcSrgTL8jJrC5rcWSOzwq85/Ox6DKHfxJmZ15Iwv5Vic7pd0llkCwSij
	3hnT9X7ncCYx5mAlsSZxSAvxValeBlaXHzheEr4WLQVSGghjZZnzW03wPlEBqbXClScprjiTUCy
	NNThox+Kj7ZtBNCL/1gwUxF3TBgMSZ59Vrv8WrkdhBj1ZnjBJkUqslzC1g8ehWyMfGfXPawkjp+
	B+dseeITJ8TSTwBUQpoNfED7LtBOUFdmk3vBz7ipJxuV4AbmnVHyB4Ooc6qeiT8ZTCW0jOkyhUH
	pNWIOwm8ZNOPjbHJDVqpi3QJTQakOeKh9SpR4phrYa1rHIgCzvQRYSbxuuqJhM5cGOu6Yw42VD1
	tKXkTl2bOHp/DdAnOAX++4Nkuj7piI1DqdFMQ3krbcIpuuIjRN/8SzycbaxrTl9Rg8ZPWOGM7e
X-Received: by 2002:a05:6808:c29b:b0:45e:e07c:3fd8 with SMTP id 5614622812f47-4639f1bd0cdmr4633325b6e.43.1771255559738;
        Mon, 16 Feb 2026 07:25:59 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:2d75:8cf2:6289:6a96? ([2600:8803:e7e4:500:2d75:8cf2:6289:6a96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463a4ede045sm6507701b6e.9.2026.02.16.07.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 07:25:59 -0800 (PST)
Message-ID: <bcfc711c-a02a-4470-a2a6-de43c71e7c2e@baylibre.com>
Date: Mon, 16 Feb 2026 09:25:58 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: orientation: hid-sensor-rotation: fix quaternion
 alignment
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org,
 Lixu Zhang <lixu.zhang@intel.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
 <aZLKy4l6OlPgIkZx@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZLKy4l6OlPgIkZx@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/26 1:44 AM, Andy Shevchenko wrote:
> On Sat, Feb 14, 2026 at 03:00:19PM -0600, David Lechner wrote:
>> The main point of this series is to fix a regression reported in
>> hid-sensor-rotation where the alignment of the quaternion field in the
>> data was inadvertently changed from 16 bytes to 8 bytes. This is an
>> unusually case (one of only 2 in the kernel) where the .repeat field of
>> struct iio_scan_type is used and we have such a requirement. (The other
>> case uses u16 instead of u32, so it wasn't affected.)
>>
>> To make the reason for the alignment more explicit to future readers,
>> we introduce a new macro, IIO_DECLARE_REPEATED_ELEMENT, to declare the
>> array with proper allignment. This is meant to follow the pattern of
>> the similar IIO_DECLARE_BUFFER_WITH_TS() macro.
> 
> In both cases it's quaternion, maybe be more explicit and define
> IIO_DECLARE_QUATERNION() ?
> 

It is really the fact that the scan_type has .repeat > 1 that requires
this, so I was trying to make a name that shows that link.

But right now, quaternion is the only thing that has .repeat > 1, so
I guess it would be OK either way. We'll see if Jonathan has an
opinion on the naming.

