Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77045366DD2
	for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888933; cv=none; b=ncUr/oxB43fkF/qa8HstnRclcOb3yOtsq29XLJ6JBlaT6riLxhntxhK4TacU12UgaecQ143U4ReKf/TZSktLo1RTWhE0uQ2MwxnTw2o6LOwk0yqbgAW8xoqalngr/6iRD2hdYXqEIY7INI+Z2QdhsHNXTy66snDEZtVNBIp6tWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888933; c=relaxed/simple;
	bh=dPpm3l3WPw7+UtDy3mOZiDg1GUUhyRC4lyTEv3mW62I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISzfBol5u2AdH2jhAp1j2bLw9jyYuOkkQorlFQSYyQnu2L+FBYOTzOhpmYBue1hszUItqptw9ygzy+aC17G5h/K2Y8+lNTzNZIZHdSAHnUt20/5qBBnd76R3eRHiyzbwQ1pXhzq7rwgampRK5YZ95svRaJ90sVpqV8csFkQo+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E0yl4gOO; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E0yl4gOO"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d148dd3421so1237706a34.0
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2026 11:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769888931; x=1770493731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQ+TaOsJS1d5at3UMn582LZcj7u6OHzNvDSFQmdpmyc=;
        b=E0yl4gOOFJpyySVsDmn/hpM5PSAkXhwDmN9vu9ibhwoX3SIpxHFAmf2pflTYaKtDtm
         AYu4l00lCHJz1k7nAYHzHA58SXe6YDVPOgq3+K6ygl84RCCfWQNYwj1fCbmIVYcJ6QG6
         urTM6ZT+706m23jvUGoDLMc2HgpxbbwWVqQpNXevw0ffTzxpQPaI5lqJK7qvVf3F8iYJ
         T9ZDnE1wyUl96tjA1xkw26atNQphlfRMD9+EyoMYas37+ojq0jc3ZB2px2e90PpVQ2d+
         J/2ClZEYAFJZjDkVIFqR40XT6+zEsnciAbNGJUVcJV3ZYTh2RveYHNroMvyjhaA4EgB1
         qegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769888931; x=1770493731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ+TaOsJS1d5at3UMn582LZcj7u6OHzNvDSFQmdpmyc=;
        b=DIOR7usfe41XBLNxJ2vJlDKfQEd2Oqd+DaxNA1LwxNqnbUCBM7QpI7HGTlWziwUf4Q
         aLtAc0KappdZcLYEzrxu/w4+fkasz42agsH30Mg1pm3l6HF7iO0X1CnTLW/JaWsEAc2u
         lL9AwVQaOfC7XlDMxnZqsWT/JpZfBHPna+TCXrlRRg6EbXQD8+YRLJsXFWL9h5GxtNOf
         +zDfVThUlM6Xd2QriPFGP+kOmYuNRl81nFo6O/dkW3e/GJJf6Zxkyn9SYsQuvgBvfMKi
         QUdWtA3FTPq82qPSReWbBBMd7McyYmOLe3AZSZL1M1HNpR3FM7Bwz9UT2AuFzn7HH2lM
         3RNg==
X-Forwarded-Encrypted: i=1; AJvYcCXIoo7hBv95tUvlmiL1ej3OAfpXU2rv4EFLBZFtrW1HB5MvMYXQzvlJhoq5FKWGyLFvoef3opoue54oKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl14Aj1zbzMmLuG3zNEH+v/wizPiLWEADT8lB6RwKChIqnZj2n
	JkmtxCcIcwHwo/BQXvub7HWowewVHv3yZFYd68fJsRMKDpJ5p/0n2gp3WyMmrTIc1fs=
X-Gm-Gg: AZuq6aJq4LI/SNMgTCh/DrN5siaH+3vRN358R98JtfBKsDrZi6VVixOh60xkEhwqMjG
	FwSm8SaJnhrOndl7l3CDM1Sf4qXi6Z9JMH2Fjo7W4hWB7wAN4ab59oWySUPmYY+v3iuvuqvku0e
	X08Mvksu/pwPilnKfH7w3azkZyjinwHpfdUR+elgxcTsMS517eN5vKh8DDJoHr3GpIe3QmP75Vb
	2E+SiCbJi6CK276UL/laALwBawODpW53T5t1vvwp7EvIqcHll5XztLM7+iAF3MQRcEPjandhj2s
	QnndLKNmoR9Kp1ANS8SCLOjbu2iaN2uVOWu5FLoNiMaiXiO+h+CWM9QGzG62lmEE9YsXRYK0KEg
	1QOUYS5/y9ljv8YaCbt6AS/CahNolGaWTTeUSjCKf8WMvMvZdUa0XYsuXKZ+wQAu6+l4cE/vpfH
	oYYh/UiuWspTvaBag75TIXcF7uRj1yd0GRdNN3VQ0gM+wU+RKSz3JaHcXStzqk
X-Received: by 2002:a05:6830:82a7:b0:7d1:91c9:9e5a with SMTP id 46e09a7af769-7d1a5232569mr4532126a34.8.1769888931469;
        Sat, 31 Jan 2026 11:48:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm7778648a34.6.2026.01.31.11.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 11:48:50 -0800 (PST)
Message-ID: <92858c73-1e11-4283-8ab6-1188e8bae0df@baylibre.com>
Date: Sat, 31 Jan 2026 13:48:49 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] dt-bindings: iio: adc: cpcap-adc: document Mot
 ADC
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260125134302.45958-4-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/26 7:42 AM, Svyatoslav Ryhel wrote:
> Add compatible for ADC used in Mot board. Separate compatible is required
> since ADC in the Mot board uses a unique set of configurations.
> 
Logically, it makes more sense to readers to put the DT binding patch
before the driver change in the series.
