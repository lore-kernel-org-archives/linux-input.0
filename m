Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052E4048A3;
	Sun,  4 Oct 2026 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099228; cv=none; b=XIMDjV1JowJG1I5hUNzagqetX0AVv8UTYsShNXiSqxqaK3TwxHYFTtZo6Q6n3A2oPEAI0YokiW0pDguM5sX3+y9l1gGdMhlPv9iB6LA84mnab6p84dKuKDs+xi8FDCdwIaANGtbd5sx+HogjHbQ6CCwfdhqx15KzVZUl7ywWqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099228; c=relaxed/simple;
	bh=xxxVwSskC+Sk+Zw6RbW+oehPTKNFbYFx30+SFh33kic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0WNb3q38yDVhGSW5zKpRnGuAJ/awZAxvZcvdz53jWvISv9QrZlL7FPPfYO9nv5mHJAVftqxSgfksVj7UX9knvzLDRIKPCPsoxxMbpO70Bm0tL/a39b/M+DAxZy4a2D09KmptK7pk6Y24OWp3UOn4V65uHKqXegqdES9TwD4/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvCja7hF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvCja7hF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5341F000FF;
	Sun,  4 Oct 2026 07:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099219;
	bh=2Zn4b/DBeLtLnClC5/XXLrxcZcl6FLMugkU3R1bOvBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fvCja7hFiJC1wqwD63xh6ottdQCpXAH5l3PVSURdwKICqLWo21ueFktjqD/ppptOS
	 KsSGprSV9FJJE/M2RGfL+Sp3bew8MPw+mIcFjWgPpXhFOyz1XriJGWtjRPn25zK99u
	 gQwHZLS1NiZZB8Ojeglc+ba2hPlywuwTsJwG8yAt9dtsm9+KIcgXOttb29vYJjC31/
	 LF+pyWrJKP3tJgHjgrp+u6CIV7CCVv+SxW9Vk+qPEZnpR4DBe0DRf6bOwoHUzJn9aA
	 RI1ToifanS2LG5Ee9gXhnkqAe440vTXP67HKL/l7j+3SdtV/Rn6meWweHJbkxHwcRV
	 0w5113cBiirkQ==
Message-ID: <79b7910f-ece2-487c-bdbb-cc5d736056a7@kernel.org>
Date: Sun, 4 Oct 2026 09:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: input: touchscreen: hynitron,cst816x:
 axes and panel
To: Daniel Golle <daniel@makrotopia.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hendrik Noack <hendrik-noack@gmx.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Ferass El Hafidi <funderscore@postmarketos.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
References: <cover.1790944534.git.daniel@makrotopia.org>
 <04a70b1cb0969ec4e4b38f7945e0b22a977b038b.1790944534.git.daniel@makrotopia.org>
 <20261004-unbreakable-funny-guan-73da47@quoll>
 <asIAQMF57X2-YZKi@makrotopia.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <asIAQMF57X2-YZKi@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2026 09:29, Daniel Golle wrote:
> On Sun, Oct 04, 2026 at 09:24:26AM +0200, Krzysztof Kozlowski wrote:
>> On Fri, Oct 02, 2026 at 01:47:21PM +0100, Daniel Golle wrote:
>>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
>>> index 72d4da636881e..027a2b3dcf2e8 100644
>>> --- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
>>> @@ -36,6 +36,18 @@ properties:
>>>        - description: Slide right gesture
>>>        - description: Long press gesture
>>>  
>>> +  panel: true
>>> +
>>> +  touchscreen-min-x: true
>>> +  touchscreen-min-y: true
>>> +  touchscreen-size-x: true
>>> +  touchscreen-size-y: true
>>> +  touchscreen-fuzz-x: true
>>> +  touchscreen-fuzz-y: true
>>> +  touchscreen-inverted-x: true
>>> +  touchscreen-inverted-y: true
>>> +  touchscreen-swapped-x-y: true
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -43,6 +55,9 @@ required:
>>>  
>>>  additionalProperties: false
>>
>> So just use unevaluatedProperties instead of listing almost entire
>> contents of touchscreen.yaml.
>>
> 
> "almost" is the keyword here. If it is acceptable to include properties
> the driver doesn't (and will never) parse, I'll do that instead.

And if you add them to the driver, you would be changing the binding? We
ask instead to post complete binding (see also writing-bindings).

Best regards,
Krzysztof
