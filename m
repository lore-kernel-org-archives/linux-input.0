Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05378331A65;
	Mon, 16 Mar 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681028; cv=none; b=rYn6hkbZZTbwMYzmeJrhj92mpMfDrNvYFg39FrRNoU9IFs+AunbZl4mcukco0xq/6ytmtmksV+eWLE4UdvOj8wqBR5x/dxm0HrRIQJt6MpITI4xg8PIfoKRmG44jofOhQdDQh0CeotSmOBL0pvKIt+igYDzFd5ZUuE5gTN5p92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681028; c=relaxed/simple;
	bh=3tkf9QwwGxRoyFGwRKQeLLeArKtrL7dM6sG9gdRDKBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doVjyrCz1nt0MrKspoLYyf5+r5U/eQPB9+S0jCXaV2Updx3/E9q+7IzG+eQ3ecLd2gO1A/e4oXRCBe3VI1SuUHPex09TgpRXRAbyMuxJ98GtomVBBh7qlGE1nrCoyQkYqmZ0xUaJZnSlIqN4SCZvPDBywopS+Mr9/+4WBVnHNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzGk74fB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzGk74fB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093EDC19421;
	Mon, 16 Mar 2026 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773681027;
	bh=3tkf9QwwGxRoyFGwRKQeLLeArKtrL7dM6sG9gdRDKBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bzGk74fBV1Qa2WZ25enbkKM6yFm9ECBE44IX/azvZuarTtJe8Kg58IHuEreTP0UKN
	 OVTfQhZmsYtf9AZLFhMCIqooaGruNaDiN15tdx8XyQs2WGpSiZYpfh2CoHJf1Zk6sp
	 CwxmVyrT/PHin27RF4KVgR1TAUxu74/yJlfxf772LvvglQ8/rpWIEOgGMllWJHcygg
	 cwun3w1S4QeldxYTCD+G2lpoK/3x6YfKFLVf7Zi71XpbYhxh0Qw4ynlyseh93/HDEo
	 Mls+jxclPo/yeKu1CWCmqBKQmKvuxSq+5tn/02bavi0H6inilFb6uz8LnC/4GyhgVn
	 vUKL64X74JcOw==
Message-ID: <fef8779a-a5e6-45f0-82dd-0cd8a892c0ea@kernel.org>
Date: Mon, 16 Mar 2026 18:10:23 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: ti,tsc2005: Add
 wakeup-source
To: Conor Dooley <conor@kernel.org>, phucduc.bui@gmail.com
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmitry.torokhov@gmail.com, krzk+dt@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, marex@denx.de, mingo@kernel.org,
 tglx@kernel.org
References: <20260316034606.11304-1-phucduc.bui@gmail.com>
 <20260316-refusal-disband-54161c7b96e0@spud>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260316-refusal-disband-54161c7b96e0@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/03/2026 12:13, Conor Dooley wrote:
> On Mon, Mar 16, 2026 at 10:46:06AM +0700, phucduc.bui@gmail.com wrote:
>> From: bui duc phuc <phucduc.bui@gmail.com>
>>
>> Document the "wakeup-source" property for the ti,tsc2005 touchscreen
>> controllers to allow the device to wake the system from suspend.
>>
>> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
>> ---
>>  .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml  | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
>> index 7187c390b2f5..c0aae044d7d4 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
>> @@ -55,6 +55,9 @@ properties:
>>    touchscreen-size-x: true
>>    touchscreen-size-y: true
>>  
>> +  wakeup-source:
>> +    type: boolean
> 
> wakeup-source: true

I am not so sure.

The property is multi-type, so we want to choose one - bool, IMO,
because device cannot wakeup the specific system idle states. Or am I
misinterpreting the phandles behind wakeup-source and every device can
be differently routed in such system?

Best regards,
Krzysztof
