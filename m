Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13047CC99
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845304; cv=none; b=EuFpDoETsO0Z/YJyrbEyCrWLSa9TJzfhajR4n34OT6bNMCgPT5RSMC/DWUIMLPInuDOeUHX2PzeMZ5YL5xIw+cz20pZj9/hsnqXHKwwdj3CgtCuRu5e+Xlc6t/YuLPJEkaMjG5mDdAuKZYgkTbo3hB08dw+T4XUMvWRdCHx2cCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845304; c=relaxed/simple;
	bh=CTwiBTXgKo7K6y0K1Dx2UdK0JxC3dCcCpJUx4YVxSM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKi8PXVVWqk4UJLwjpbnT1D8P4PyBD1NBaL7yBobWHnsE8wSWbxAiPWrD2fUpdvx4L2x039OMnymkX6pZQ04hYPEyNST6xAw6ih/zoKUEH6u2i7vJ1t19kOrDsBROk4wC47vDsqEhvpv7Jn/6c2HgJ8QAx3vFaQuXPEBCCXx/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=o2hkzp9L; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="o2hkzp9L"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so13357869a12.2
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1778845301; x=1779450101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0YuC8NLk0JJSjHe3iGG0tkbsopOL75mgPP59FgiTls=;
        b=o2hkzp9LAx5y+kXSG+qoaGv+0i7ZgiLkzhAo/CibsDYs8RQ4yq0jkysaY1lOxLzEqF
         ccaXDINSjEbYfWdn7P4o/2NKTRkmPULCB0qG4mUSW5F227Jt9KJP/Z57nbFlHf2MaEZP
         ptTBeMTRU003ORlt7aIVLddhZKE6AyfOlb/OJ0TcSIDsQdKq5s7Q+Fuin3C8JRr4O53h
         feefA6yVTyH9GimKO5mMwuhhL3AMD5xfY7qtU58onbNEfNl/J+DTAPGbijWvowl4JReq
         hvIcgf66rOiEjUkHgGY5C5Y24HRXPSS5ja+WPRBIiIvcIkd+wuVXZDYJof4Ubbhs2j4l
         e0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778845301; x=1779450101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0YuC8NLk0JJSjHe3iGG0tkbsopOL75mgPP59FgiTls=;
        b=ftnT83IugfJNKwpai8gHpgy8fF1RzhqnDSyYvqXej8OfufZINV9/nYOiIqEngFIjUt
         sOpMG6GITThmp/Z/q9eIO3iwLobGXQ4Vag3m0gjQiE2VD95EXL3FkUA0mfIWnFPvGtjN
         Wv5eoB47nlayH+E3y6hOZ3K3S4We5ftd5KXB7yVSp4/VKtYlSmi2XUZ3Ghs/hRIuT5K5
         bgx/vB6GZ9Lntt3Cy2JcZvk61rFDc2EeujKC0HiQJcu0DtY8xH1aMsM4Cva3Bu7gOCDb
         rN8bijPn5DwZpBb3wGG4mzsRyLGJtqXqfJrCqAPQoQAJzGmCod8KwUn4z76nXh2el3Gf
         5RAg==
X-Forwarded-Encrypted: i=1; AFNElJ8Rs/jbmktB3EWOlOFQmhYpSF2iMhhJIJgyiRcX43FwrdVTtQwyEwzEg7fjvBf8O0nzQndAIp8RJyiN/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJKMpcP+XF30XF9IX91FSocM6JFgKj8F1kq0x4cwqUnhyRIDv
	uR2cMXWRka9YBfoWXZzpq3BZ3ykc0adcCj4j9nkUM+B3hhXxdS2cry50kwhqXwotAxc=
X-Gm-Gg: Acq92OH0aKgd/KD4iN/m8oRjtf8PWosknkieO4FYpyt0A1gper6NxvdLHE7D5mbUECX
	1hVz0uDM26ErxvWN2Q0HoLGYmmg4mGAt8+/dgGApmX+bb4NW5jJV7EIaSj27oZu7UVhB8eoj8Af
	H5UQT01BPMQYVSsIcV212fCnHeHeAv0kwUcD6G9xLfGcu+HR4oivZIlKfNpOkdt2BirMZiRgqx0
	WWczezv1cc3qSk9a4v7XUKSFtPgVLKZjkKBarDCTqgJil64lXi27g5BOpWSDX360aaLkpyog7j9
	y3ntKJGarFRrYLVNXkYPwR0b7nBWO6457ZcwSO3b7JvrXCYcxkYLcoX4PVxLTO9JBH9rbZl5E9G
	7Rhrd2UCqyaazeNwem1yccYyEdDOck6y05c+APzErPOMCebGA46HX+3BhOqEyl51bF/DA0UYSI6
	ExRwU3moPUJqQCxExdNLfqGTZlUtuUzrpud97GaWPmbGVs954l2DHl609zK/5tHAcV6WIUQA==
X-Received: by 2002:a17:907:c291:b0:bd5:7a3:a58b with SMTP id a640c23a62f3a-bd517994249mr190506866b.46.1778845300966;
        Fri, 15 May 2026 04:41:40 -0700 (PDT)
Received: from [192.168.1.105] (164-6-132-5.ftth.glasoperator.nl. [5.132.6.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c31494sm215043366b.20.2026.05.15.04.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 04:41:40 -0700 (PDT)
Message-ID: <21308d1e-712b-4d3b-b083-251c8d755470@fairphone.com>
Date: Fri, 15 May 2026 13:41:38 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] Input: gpio-keys - add regulator to gpio_keys
To: Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
 <20260508-gpiokeys-vdd-supply-v1-3-0bb32e8e6428@fairphone.com>
 <af3oqSshbXrUYMnz@sirena.co.uk>
Content-Language: en-US
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
In-Reply-To: <af3oqSshbXrUYMnz@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/26 15:44, Mark Brown wrote:
> On Fri, May 08, 2026 at 02:53:15PM +0200, Griffin Kroah-Hartman wrote:
> 
>> +		if (fwnode_property_present(child, "vdd-supply")) {
>> +			button->regulator = devm_fwnode_regulator_get_optional(dev, child, "vdd");
>> +			if (IS_ERR(button->regulator)) {
> 
> As well as the issue I mentioned on a prior thread with this assigning a
> non-physical "vdd" name to the single supply that these components can
> have (which has had issues in the past

Our Hall Effect sensor IC does have a named "vdd" pin, but we are 
totally open to changing this to power-supply or whatever best follows 
the standard.

> painful) the fact that this is fwnode means that this opens up support
> for using this with ACPI which is very problematic given that ACPI has a
> strong model of how regulators should work which is that they should not
> be OS visible at all. 

Would it be more appropriate to drop the devm_fwnode_regulator_get() and 
replace it with a type-casted devm_of_regulator_get()?

> That probably needs more addressing in the prior regulator patch, that 
> needs a bit more motivation and discussion about the issues with trying
> to do a regulator interface firmware neutrally.
Thank you for your response and feedback!
