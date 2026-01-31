Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423F36923C
	for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769889046; cv=none; b=kW4cCg4Sl3+g5LM57p93zFfBOmFlNk0vv0smz1Ww1MWmM1rYR5HqtTv957h7bMMdL0cjlMdIODf7jp22Ql7BsWI9KpmldC0Gl7rSnkiH3cB4jXH078c5QLvcNDI6vynYK6f+uCLbyP5O0Og5JaHoYLlghFB12kXNANza8KgsDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769889046; c=relaxed/simple;
	bh=C5HuJP/IjeG8MYwSuwdaWDcjCmDjLCEPWCcLYeFqHpM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KMRnT9H32vo3FhlHmWc59R5aPf2c6DILAbPpu3bCifLPKi4wzVVK2GHBXZKIXGc6gBBRiiYPCOCQcV7TWdk61vgbTFRYmAGMYVP5qrh0m60RsT9jmFVQgaZgJjEUQvauVAWSGJxv2gPEi10DU+F+h7uBDP2xf8OvU7tgb1fN2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GWIiRwE0; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GWIiRwE0"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-460f3f9fdb1so322070b6e.0
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 11:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769889044; x=1770493844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C5HuJP/IjeG8MYwSuwdaWDcjCmDjLCEPWCcLYeFqHpM=;
        b=GWIiRwE0swLPJFHbUxLmcXD7uZZgmXuGeN7oQvIG4uVEg+WJvCel0i0OAaks2afL9L
         6uezKwjBgoreIu/valrw15ASQ53++7OzIN4roQntTgf7bq6IfTpp9hM7d0/S6d0Xfegy
         cIgLOwoSZsv52q4SkXUrHLn4tqxBRjJAPrcwxYM1AdjdWfUtsQA1jz4qLp8E64gKgSOu
         Sl3xyJDu0Hxz6aQZty2j9HO/8SGDs6t0YgYdwpX5wNwf29Xwnisl1QW39KwYSA4smoE5
         uy8b7xlgItHHF/E/Ze27LEOd1ULSr9UK14LWeo5WqIJHH7pklFAzGSwJxO4n4cpQ+bna
         i3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769889044; x=1770493844;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5HuJP/IjeG8MYwSuwdaWDcjCmDjLCEPWCcLYeFqHpM=;
        b=urpBXpSYO799pvVt/Oam+Ct1TdNrIHOC6GWljJ4SQVS6kIiaJjiKHxTYIaHFbRc4Wg
         Ho5H8wp0oIJzTsGOSSnY0jIahO95F62X6KSDcBCl4e+iMpQWLb6XpLis/tCBBtwn3age
         JL3BuzkM4w+kV4qAPcfpeF2UuTltTBv/lbWaY9S73veF4aT3VWkXX1EqrxWfJS6jMkrj
         KVYWPBIEJsWUXhdxsNZGDB7EbexBIWzruEZQOxWGKWIhxRV8ARegh3fF+ktkziuTHyrL
         DsF1cEz5tIG76WwJ8/u3Oprs5p9BmzOk+70AYwT/50Le9qz0FvppE6AhPOTD/kYqG+Oc
         1nTw==
X-Forwarded-Encrypted: i=1; AJvYcCWDLJrx/zD0mX9qk7OrDOeMvZ00E/+JL73G5qbNlk+hNcKJhp6FdxHGFiRQq2VeUh1r3b57IB5pOTqDTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0KJFBBp/V5DYIPQdTkfx3swCWhN6UYAAoXGbVvzATkVJkzci
	nQ4PWFFXxvDdc8QQTU+3s/WxiigZhsyFAwYZNCDDUcw5/7RutGQD6tDS6KZxLnhE2oQ=
X-Gm-Gg: AZuq6aJGZkC7VdWrHB9Smy/y1FoLDx0Sg1YcV+6pla5n+3mkMHLdtEzL9d4w9/ovsrO
	qcc6vBFmo+o7oAUnVGh6LlgT+SrUvxTkMD0SpG65m7g2IWBDsQVh1/lnvrJNy5oS3qRv5sh46xE
	4wkxq2VqxrA8nNRntwos5QQRvbJy7xhmEACdQoPLJSYSKAmUVmHxIPsHQQXagK9PW/tFuVZp6w9
	t7n/SHXmltEaguJvilY94+pgKMnltrZeXGcmeCxgIlzq4He8x37W/tkUaeYOWMCYbdGrvgbV64j
	vxG+CiOjJIXUSLcKdqY97wf9U80ToOyABXTtgl4/ep6Lsdzv2jWxpHWv5RPUYV8ywtu69Iflzqc
	rrVjOqBxfXfacVWo1EhB6DgLSGQm0Syxa2kJo1XBFEbMQEhDFqc9KrCrsV+dH12SvqT8RrndMNv
	2L4H7WXdSt1qhncgnQSg/BnkwFlDh9Yv1Kk/5jzrWGozWAa8UOHoAgYuPA0GVI
X-Received: by 2002:a05:6808:2222:b0:45e:fff5:89b4 with SMTP id 5614622812f47-45f1e280e98mr5623957b6e.10.1769889043924;
        Sat, 31 Jan 2026 11:50:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c7ffa49sm7655737a34.20.2026.01.31.11.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:50:43 -0800 (PST)
Message-ID: <1ae1f69b-8a72-4831-a6f4-cd7dcf38f793@baylibre.com>
Date: Sat, 31 Jan 2026 13:50:42 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] dt-bindings: iio: adc: cpcap-adc: document Mot
 ADC
From: David Lechner <dlechner@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Dixit Parmar <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-4-clamor95@gmail.com>
 <92858c73-1e11-4283-8ab6-1188e8bae0df@baylibre.com>
Content-Language: en-US
In-Reply-To: <92858c73-1e11-4283-8ab6-1188e8bae0df@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 1:48 PM, David Lechner wrote:
> On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
>> Add compatible for ADC used in Mot board. Separate compatible is required
>> since ADC in the Mot board uses a unique set of configurations.
>>
> Logically, it makes more sense to readers to put the DT binding patch
> before the driver change in the series.

OK, I didn't read carefully enough that there are multiple devices
in this series. So you already did what I suggested. :-)

