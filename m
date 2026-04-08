Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80232C3248;
	Wed,  8 Apr 2026 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649024; cv=none; b=FJD7LoOQGIhLIfKSNPeAl59IKmK4WzHWq2EpjED5JuVWfoR9ukM2aaVqLUne1aaV4tFr+Vzol/avrKsDVZyiE0rVxr7BcoW2yQKtYnbS5Mzp9wcxVFfvCtxqf0W2fM5TBsiFu/fa3nmn3HZWtyZxGNQXGJIr4EAdyEsnrsXzlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649024; c=relaxed/simple;
	bh=cr3DDqYflhk/Q86INDoE+CWNSkDLxE/whb9SQTINams=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AS1Y7XcQvj6XLolg3RpDlG+9upTFSLElBBr6l6HBST9PixBClg/1Oa5SKVoKFEwxxg6kiNgBoLpGEZFZshX07jMjcSHKyQU3pcrDJVOD/IEEN/3eZq8I5yf/NVYR2SYDbczVufIbDaWI4dzK0PbI9hODftkcQq+3haFU61YNHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=RLzjQ/L3; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="RLzjQ/L3"
Received: from [192.168.62.16] (37-48-32-36.nat.epc.tmcz.cz [37.48.32.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 14C625341073;
	Wed, 08 Apr 2026 13:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1775649016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h+2PB2h5YZzIhWQ6GSTNArzi0ONg/J5mrZV6McUkvGM=;
	b=RLzjQ/L3o5y7goDGZNdivWtzKGjOyHq3YS+ii07ObSFF6qQb4PoqeJyE/ihTk8X6WI9Xlu
	TY1YW44qv3nVj1PO2egcK61k1DcJn7j3PCiTQqLromIsdHddo40TJO8OACjkXurUD9nwnP
	GPdYW2sSQ7CgRt0P2x0mxaoxwlhN40A=
Message-ID: <93c43b24-0731-4aad-becb-908ca0f33d6f@ixit.cz>
Date: Wed, 8 Apr 2026 13:50:14 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/7] dt-bindings: input: syna,rmi4: Document
 syna,rmi4-s3706b
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Vincent Huang <vincent.huang@tw.synaptics.com>,
 Casey Connolly <casey.connolly@linaro.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
 <20260324-synaptics-rmi4-v8-1-2168d2df68f5@ixit.cz>
 <acLpBXc9Qi5riQO0@google.com> <5630a4af-e18f-4daf-9b04-ea61091d9e51@ixit.cz>
 <adSMQXgbco8fvRLo@google.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <adSMQXgbco8fvRLo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/04/2026 06:48, Dmitry Torokhov wrote:
> On Wed, Mar 25, 2026 at 12:33:23PM +0100, David Heidelberg wrote:
>> On 24/03/2026 20:42, Dmitry Torokhov wrote:
>>> On Tue, Mar 24, 2026 at 08:40:34PM +0100, David Heidelberg via B4 Relay wrote:
>>>> From: David Heidelberg <david@ixit.cz>
>>>>
>>>> Mostly irrelevant for authentic Synaptics touchscreens, but very important
>>>> for applying workarounds to cheap TS knockoffs.
>>>>
>>>> These knockoffs work well with the downstream driver, and since the user
>>>> has no way to distinguish them, later in this patch set, we introduce
>>>> workarounds to ensure they function as well as possible.
>>>>
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>>> ---
>>>>    Documentation/devicetree/bindings/input/syna,rmi4.yaml | 11 ++++++++---
>>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
>>>> index 8685ef4481f4a..fb4804ac3544d 100644
>>>> --- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
>>>> +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
>>>> @@ -18,9 +18,14 @@ description: |
>>>>    properties:
>>>>      compatible:
>>>> -    enum:
>>>> -      - syna,rmi4-i2c
>>>> -      - syna,rmi4-spi
>>>> +    oneOf:
>>>> +      - enum:
>>>> +          - syna,rmi4-i2c
>>>> +          - syna,rmi4-spi
>>>> +      - items:
>>>> +          - enum:
>>>> +              - syna,rmi4-s3706b  # OnePlus 6/6T
>>>
>>> I thought that all the workarounds will be keyed off this new
>>> compatible, but I do not see that. What am I missing?
>>
>> The compatible is used for sequence in the
>>
>> Input: synaptics-rmi4 - support fallback values for PDT descriptor bytes
>>
>> where it is used to provide values missing for OP6 (and possible others in
>> the future, when added).
>>
>>  From my understanding the series, only two patches (1st and last) are
>> specific for the OP6, rest will likely benefit various TS not implementing
>> full Synaptics set. All measures apply only when touchscreen reports
>> something wrong.
> 
> If the sensor does not implement RMI4 protocol properly it should not
> use rmi4 compatibility. I will not apply any patches that work around
> incomplete implementations unless they are triggered by a dedicated
> compatible.

Ok, good.

Can we agree on subset which is correct now?

I think that
[PATCH v8 4/7] Input: synaptics-rmi4 - f55: handle zero electrode count
[PATCH v8 6/7] Input: synaptics-rmi4 - read product ID on aftermarket touch ICs

could be reasonable to keep as is, except I would reword the 6/7, as reading 
product ID isn't anything aftermarket specific.

Then I would send this subset to get in first and work on the rest, does it 
sounds good to you?

David>
> Thanks.
> 

-- 
David Heidelberg

