Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94B3644D5
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108252; cv=none; b=bF+eQdyBD1rcIaI45E5Uyx9J1X84dmyhyNl1P/eFWlHCE9IPBV+1senYaODzo3vxa96A/D8jSsz9P5Z/tDvpn+1sT7/ZSomotWJvjmITp+XR474nOuJBp9pnSMibMXeKJUECNBiswjatIdXPTAGyYgT3eOiAZ/fo15vmbffAX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108252; c=relaxed/simple;
	bh=QUeVYo+ICZjJILbIW9iYwEWfD5eoanHqZ9Els6Bjq3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLDGn8n1PYXobCBgFl01T2xKah2qYc/NGDj6ktpW0ND+Kw8bP5+x3+x1UE3JUPxtwx0fRc5lv7ikOCdY1JCds9Wx5hR3AMgZWXFGb5VR4ImGwZkwG7MfMHpa5PplPZj2K7A4mRtedPfXHrEPErjr6B2qCX7YlYWwy3e1BGL9SGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejbrWJDo; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejbrWJDo"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-385d75e1a79so3796261fa.2
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 10:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769108240; x=1769713040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mScsg53i6ZoIWtfuaNxg8jLICt1p8GYZ/GGQUU3Wx0=;
        b=ejbrWJDojn6Mrn/TmzFdKWBuWBLOpD43KC7ip8P/nr2hrt/lid2atWFQJYKa2qsGMZ
         /rBkp4mtIJWy/5eaZwSHb7n8rre9QlSpcrwA98mfPpZGfTkbnM67RAaOsfsnh3oBW66R
         MrQYjUY1N2LMGc81/DBVuekKFqRzXVI9jENiCVn9jMfSRRmuaz0ZhfFVbmHmP4X7siiK
         RwoYdwghXgDZFh3/Sk4GJ/Xt0YCaayu8i71C6uigjYykFxnMr/SERJB5puQmpgsTpUko
         9b2zGxvd+2w9HRttRjq9vywvXn2ybp60xrxiBwi8WO5nDAbhPrmu4RCHR2o1968TjlVv
         +eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769108240; x=1769713040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mScsg53i6ZoIWtfuaNxg8jLICt1p8GYZ/GGQUU3Wx0=;
        b=NP/p7eDd1VQLiEDkEQi/+BLUfgVRLHaiuh8GottZRe89kSvBofHYnl6Lxxc5Q/IQUh
         wzmYhrFeNs1grVHIc5kA1G2l8Xus4ohxHSih6g19Nc+KZzAlaSKCSZPyh3enLsJXLBjc
         Ips0qAoCBpNjwryzXixhVmobEl/NRVrpSx4ZDnArU8CIiu7IoxMUisYZejEUD/juA53q
         Fhm3UZBvGuVrDwwrYzAzKvjeihmt3VQayNqkc4Ti1IFsfqFOVifMJYoNqMPKKAB52Lcr
         atQSa4Kh1f5q2/MlHe1VpdgAPFQmCD7k1JDQ4HeeDnMu35HBcMdVZ2OTiia86dqBWOOt
         R7SA==
X-Forwarded-Encrypted: i=1; AJvYcCV8kOFQ7W4AJv0N0qkN9ccRyLrauBaO7iK/O2KrGXAfiEyWHIKab2Ay1y8g8nhs7Or6gC1tJ1jFjSTRdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzimOGZiWBzPKFvdcqGLGrvoMYCIywvV9yrxPGDXpI9zK7qVm
	TvVTZml+Fq8o4/qTO7zOSdBRP2oklhmyFs+56H9INsVEqBB+S+p9VwW8
X-Gm-Gg: AZuq6aLe3wpuesHTmgXnxoZvzUgJqzZ3C9I3/4HsvMqoB9p231Vyi5v840ynRnWXK4D
	Yu1zUG8PL1DCWxzXDIyJYKf2fhZHsrh7RQ0/dpcHUZ9XVQXEq73HS2zt+PQcIB1bX6FQ1xnMiS9
	Rz/v8sbjamKA9sw3yVAbBrj7zHzbFDH1tZtDo+2dFcF49GRqQ98GQU9yz/i1siTLCnrQyW75u/D
	5UjnueFJnJQXP9LBn4nd6VS+kwj0FTqXwi8JEfjMg2Cvr5WY0k7oFPCqX2YxibTpAwejjlD3GSD
	HiSC7eckLufFmxowhfzwgoC0A2hSxS53Nt1VCHdEI1+ccp/LFNbDGfESZ0XGzHlzxB+x08VsgHr
	aro2NpAKbFartWirAv0yEzknpVVPv9BntOzdIpBO/tLqJOIqo670fHnna2wbWA5fx1WHDqpeJ9i
	tQ/b78FjdvVfzg9JgB1Ko+fc1rmzkkRTsdm/+jua4KddFoxTY+40v4ZWbDT4Kukz8MZ8aS0w==
X-Received: by 2002:a2e:a483:0:b0:37b:b8c0:b5e1 with SMTP id 38308e7fff4ca-385da007b4bmr684401fa.27.1769108239476;
        Thu, 22 Jan 2026 10:57:19 -0800 (PST)
Received: from ?IPV6:2a00:1fa0:4677:d84c:4a53:d9f9:de83:6237? ([2a00:1fa0:4677:d84c:4a53:d9f9:de83:6237])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385d9fec3c9sm645761fa.15.2026.01.22.10.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 10:57:19 -0800 (PST)
Message-ID: <d9096670-cd01-41c4-9186-847641c4368a@gmail.com>
Date: Thu, 22 Jan 2026 21:57:16 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux/interrupt.h: allow "guard" notation to disable
 and reenable IRQ with valid IRQ check
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 linux-input@vger.kernel.org, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260121232522.154771-1-marek.vasut+renesas@mailbox.org>
 <20260122162206.9wrHkrTZ@linutronix.de>
 <CAMuHMdVs_ODx3eByHkU03vopUuLuY7=uRnfTKuai65jNr+xMhA@mail.gmail.com>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <CAMuHMdVs_ODx3eByHkU03vopUuLuY7=uRnfTKuai65jNr+xMhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/26 7:31 PM, Geert Uytterhoeven wrote:
[...]

>>> @@ -242,6 +242,21 @@ extern void irq_wake_thread(unsigned int irq, void *dev_id);
>>>  DEFINE_LOCK_GUARD_1(disable_irq, int,
>>>                   disable_irq(*_T->lock), enable_irq(*_T->lock))
>>>
>>> +static inline void disable_valid_irq(unsigned int irq)
>>> +{
>>> +     if (irq > 0)
>>> +             disable_irq(irq);
>>> +}
>>
>> | $ grep " 0:" /proc/interrupts
>> |    0:         43          0          IO-APIC  2-edge      timer
>>
>> in other words, interrupt 0 is valid.
> 
> AFAIK, the x86 legacy timer interrupt is the sole remaining valid user
> of interrupt number zero.
> Nowadays lots of code assumes valid interrupt numbers are non-zero
> positive numbers.

   Makes me remember this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce753ad1549cbe9ccaea4c06a1f5fa47432c8289

> Gr{oetje,eeting}s,
> 
>                         Geert
MBR, Sergey

