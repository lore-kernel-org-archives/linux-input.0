Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7E415F1D;
	Tue, 15 Sep 2026 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491947; cv=none; b=qahReH+xR5xcdOXFbR7KzW7WqqEgD+hoTTgv4oxHYdFaQ3IVfIxTo8CQkamMY90Ta8GmZADVsrGTnKVgzXrTeW21CGocPqeK1Xp/JqWJPYCC5sqjkmQ5EIV0VE4j9yU6JU7YAnbKbf8CnzO5A3xuUJITLtkVcxcMNOdzhsHxuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491947; c=relaxed/simple;
	bh=Zx83wo6QJQIxKx90gBepVfzlPmvihSB9ExdjybAx41s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofP1gf0FxLPWKw7cGjsRj9dPP7F15pzqx9CGBpGeumvpPmG2eHKF64Xd1eCez237+gkED8pgTWYDtYrAmnYFTxc8MgPOaOBvyumP7NQAzMXtppwJqc8U5pnANwMho437Iaphhitk1Ovae0WsUv005Wt0va510srlQaF1SIt4LwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwS/EXu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwS/EXu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A811F000FF;
	Tue, 15 Sep 2026 17:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491946;
	bh=kWMuwM74nE69/ubaOSzHo4L7ka8vFyWxM+nUzRNSh+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jwS/EXu3QS/S3gwrUjNQnllD5Il+icd1yu6yGSj1V8lxEO/hrCzbPyVzLas7IwXNx
	 4QxA2ebitlZktu+eSQ+qtkua5eaCtT9l2/9qQeDGV7BiRR3bpXT0GX0iiZ/u9XHwEZ
	 MugZVE+XWh5FV90RJuAPp9m0m2uJB+qUj2smnq4y2h8VNoyIDkHg5RRaopOBRM50EM
	 VuXj5uBHDUIiC1QCgkdwdw3ok8HcKOr7NwzEB/jLxwV0k25Gjwo1eTgTQk/Jx87j3l
	 bPb0oMuBh74nsCXdgQA5e9Vu7hPFiE/tYlRN0r0Q0JRy82qGsRB8H7cO1O1g8e/S/A
	 m8Cz1EDZw8lZA==
Message-ID: <dec4f6e1-115e-46dd-8fb9-a3c67f1a8811@kernel.org>
Date: Tue, 15 Sep 2026 19:05:38 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
To: Kendall Willis <k-willis@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, msp@baylibre.com, s-kochidanadu@ti.com,
 a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
 <20260914-unbreakable-competent-beluga-efb5ad@quoll>
 <20260915164819.nlgpuvf37rhzgc66@uda0506412>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260915164819.nlgpuvf37rhzgc66@uda0506412>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/09/2026 18:48, Kendall Willis wrote:
> On 12:13-20260914, Krzysztof Kozlowski wrote:
>> On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
>>> Document pinctrl properties on the gpio-keys device node. By using the
>>> wakeup pinctrl state, the pins are able to wakeup the system from a
>>> low-power state. The default pinctrl state describes the default pin
>>> configuration.
>>>
>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>> index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>> @@ -22,6 +22,22 @@ properties:
>>>  
>>>    poll-interval: true
>>>  
>>> +  pinctrl-0:
>>> +    description: Default pinctrl state
>>> +
>>> +  pinctrl-1:
>>> +    description: Wakeup pinctrl state
>>> +
>>> +  pinctrl-names:
>>> +    description:
>>> +      When present should contain at least "default" describing the default pin
>>> +      states. The second state called "wakeup" describes the pins in their
>>> +      wakeup configuration required to exit sleep states.
>>> +    minItems: 1
>>> +    items:
>>> +      - const: default
>>> +      - const: wakeup
>>
>> This will introduce new warnings, which should be being fixed in this
>> patchset (e.g. at91-kizbox3-hs.dts).
>>
> 
> Will fix the binding to work with current device trees.
> 
>> But nevertheless, isn't second state the sleep state? How can you
>> configure pins for the wakeup state - like being in the wakeup? You
>> configure the pins for given state, which will be a system suspend, so
>> sleep?
>>
> 
> The sleep state usually refers to putting the pins in a state to save
> power. The wakeup pinctrl state is for putting the pins in a state to
> allow wakeup from suspend for that device. Both 'sleep' and 'wakeup'
> are for system suspend, but they fill different functions. The CAN
> subsystem also uses the 'wakeup' state in addition to the 'sleep' state
> [1].

So you mean sleep would be a separate state? But then aren't both
exactly the same states? IOW, if device is wakeup-source, it will have
for "sleep" state pin configuration allowing to wakeup.

Best regards,
Krzysztof
