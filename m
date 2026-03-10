Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEC2E6CC7;
	Tue, 10 Mar 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161706; cv=none; b=XVfTFHrU5aDV0JUE5qMwy0KMhX06cwf5OxQKm+54VKEIm2rgaNfj40Pfy9tCmWmCcRBlfv/SJz2akUkms2wcaGlk8eR1iu7QS9MVBNx7YDpENtTHwoPeSqhxP/21jfE5d0IuRLcWUp8FDUX+5Gc91k/RsxNvz0apnL+LgaMnfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161706; c=relaxed/simple;
	bh=vEcm5KdRxoRD5WWRGQpBPfS+2NXteHPKWMwjv9JsnbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU9x3hkXS9TBgrg7suP1O3KgnXK1cZzBtygZUWU6mwlRqpXXT3ckOoUtAMAz33wQN3ygFULcaIsDq+f24wzKP7MD7oUUQr9bugL+QNo9gg7/jsx2Z6cLEZReseUv/aKJ7E/DYYWAAF5Cp9mYlLKrQaDm85bhGaT0opMlhZqEUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4G5811I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4G5811I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE68C2BC9E;
	Tue, 10 Mar 2026 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773161706;
	bh=vEcm5KdRxoRD5WWRGQpBPfS+2NXteHPKWMwjv9JsnbY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y4G5811IuEl6AKih9ZZr1AkgKAlGvBYlgSE9VXahJxSbB65H7ShmvW0O/eWjATjcU
	 4czTaikGOsSMPFhRubFgmOr2Pbku8gEF++JhqWY1PcAeEWEVMGBuAXAD31iSuB2pmh
	 IiytqsMDuKTMiuN+us6gllMoT/xyCvpv52qcxLi5dqLYJ+jgnXkahm/AJ5IKPY+xBy
	 ExwBe0QgkCWpFhodqxvvdcIqQTceVTQilZkzgGDtfXmOn3GpD6WWpHSsI/5EUlWZYB
	 qaPEYGlB3ixejSKDm26IIrbaJIjMvfdWhqbhBkAka+rVjDnmdErXrny8Jqzd+55E+/
	 cImsEBvi+wYbg==
Message-ID: <0200ee01-b14c-4fec-bbbb-b2a3c0f140f2@kernel.org>
Date: Tue, 10 Mar 2026 17:55:01 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: Input: Add Wacom W9000-series
 penabled touchscreens
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Hendrik Noack <hendrik-noack@gmx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260307181557.66927-1-hendrik-noack@gmx.de>
 <20260307181557.66927-2-hendrik-noack@gmx.de>
 <20260308-vivacious-coucal-of-current-2d7ac8@quoll>
 <feae85c4-bea1-40b2-87d5-952b26ff3ee3@gmx.de>
 <fddf0e3b-707e-41b3-805b-2abeffed6c05@kernel.org>
 <f067754d-229c-4418-a367-6df5feb6cee0@gmx.de>
 <21aec29b-595d-4889-a71e-abe9e5ce834f@kernel.org>
 <tbp04l.1q4xkmdkoohga@postmarketos.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <tbp04l.1q4xkmdkoohga@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2026 17:50, Ferass El Hafidi wrote:
> Hi Krzysztof & Hendrik,
> 
> On Mon, 09 Mar 2026 13:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 09/03/2026 14:12, Hendrik Noack wrote:
>>> Hello Krzysztof,
>>>
>>> 09.03.2026 13:56:41 Krzysztof Kozlowski <krzk@kernel.org>:
>>>
>>>> On 09/03/2026 13:54, Hendrik Noack wrote:
>>>>> Hello Krzysztof,
>>>>>
>>>>> 08.03.2026 10:15:35 Krzysztof Kozlowski <krzk@kernel.org>:
>>>>>
>>>>>> You received review and instruction what to do. Did you read it?
>>>>>
>>>>> I read the review of Dmitry and incorporated it into this version.
>>>>
>>>> So you ignored my email completely or it did not reach you (it is on
>>>> lore.kernel.org though)?
>>>
>>> I don't know what email you mean. You gave reviews on my first verison, 
>>> which I already incorporated in v2 and then gave a review-by on v2, 
>>> which I also added on v3, but now dropped, because I added a property
>>> to the DT binding.
>>
>> The instruction I gave you when giving review.
> 
> If you gave review on the v3 dt-bindings, I can't find it on lore:
> https://lore.kernel.org/all/20251205152858.14415-2-hendrik-noack@gmx.de/
> 
> On v2 you gave a R-b to the dt-bindings along with some instructions:
> https://lore.kernel.org/all/2bf9dbd4-351e-4a79-9fcf-e41c5273d0be@kernel.org/
> which were followed from what I can tell; your R-b was retained on v3,
> but dropped on this revision (v4) because of new properties being added
> (new `reset-gpio` property, technically also `wacom,w9002` compatible
> but my understanding is new compatibles don't really matter much), as
> your email said "Please add Acked-by/Reviewed-by/Tested-by tags when
> posting new versions [...] unless patch changed (e.g. new properties
> added to the DT bindings)".

Thanks. I also provided the link further explaining what one has to do
if one ever decide to drop the review.

Dropping it silently is for me rather sign I should ignore this patchset
to avoid wasting time of lost reviews.

Best regards,
Krzysztof
