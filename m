Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F273B9D84
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162651; cv=none; b=lqAkOWYgUkgbyMh5R7sNdfaqycvU3Ugenx9nFZisuljQUEDxhQfrUmvLEYeHCrIxu0RUNMGoWkUmVIx1HSDOokN7fwn9JjX5P1H5+Xn1n1xNrxW8gGDUzNWpMaxWqxYoZ7fUgrK57liFX5X+2y0Jm16PVvN/DecKzlj8J3HBI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162651; c=relaxed/simple;
	bh=07ndbrJflIVkf8+WPofP2WZeeRp05e6JIu3UbX6Kp50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lSJyhga9N/svAx2IeFD4lASPmvZ5Vuycd8ZzguZHa+khdL1hffho5iWZhYpf7JAT4r2cqKCjkvnKtpCIcFp1CxNQpSjARdPmJUW+YbqqRe2APnlCbiCx8u8fadsgI1F574Bc6Oar3gi93gOmL6xlDSLBk+fMkUUoKfjAbsbgLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=XJ7x/dS7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="XJ7x/dS7"
Date: Tue, 10 Mar 2026 17:08:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1773162647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z0zsmE6swrwjZxcPpLTo7Ccdu1wDy0ZaJKXK5yg4Ppg=;
	b=XJ7x/dS7e+l8XHprHTXdI08ufQkTNp7UiQg1tN0sysJebfPrxheYJNw3mcVAq6GmsSovjs
	9mp3FKjc1i3SWt3s59PWngd+ET/GUGKSYnkFczC11gboP35lNpLHJUdN4ugMmQ0rVDAUbo
	ssix3GmGfT3iHBmcSAEZg/dzJDRLMh4ccTh9vuoy1sOlsyu5xlrbLuqpblSipRZTqJgOjw
	Cnnjf20S02puowKrnW+4Yu/vhK0/9LadBtVb/1zeZjTwXZcDa6JVywHIgSTqTWul9v4ryD
	DS7fFmMTZslyWb5sL0auTf6+aH0MRfWAYS2gbgCdPIde3yRKWHALZFG8CwQJXg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Hendrik Noack <hendrik-noack@gmx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
References: <20260307181557.66927-1-hendrik-noack@gmx.de> <20260307181557.66927-2-hendrik-noack@gmx.de> <20260308-vivacious-coucal-of-current-2d7ac8@quoll> <feae85c4-bea1-40b2-87d5-952b26ff3ee3@gmx.de> <fddf0e3b-707e-41b3-805b-2abeffed6c05@kernel.org> <f067754d-229c-4418-a367-6df5feb6cee0@gmx.de> <21aec29b-595d-4889-a71e-abe9e5ce834f@kernel.org> <tbp04l.1q4xkmdkoohga@postmarketos.org> <0200ee01-b14c-4fec-bbbb-b2a3c0f140f2@kernel.org>
In-Reply-To: <0200ee01-b14c-4fec-bbbb-b2a3c0f140f2@kernel.org>
Message-ID: <tbp11w.2apu4pl02emnt@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT

On Tue, 10 Mar 2026 16:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>On 10/03/2026 17:50, Ferass El Hafidi wrote:
>> Hi Krzysztof & Hendrik,
>> 
>> On Mon, 09 Mar 2026 13:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> On 09/03/2026 14:12, Hendrik Noack wrote:
>>>> Hello Krzysztof,
>>>>
>>>> 09.03.2026 13:56:41 Krzysztof Kozlowski <krzk@kernel.org>:
>>>>
>>>>> On 09/03/2026 13:54, Hendrik Noack wrote:
>>>>>> Hello Krzysztof,
>>>>>>
>>>>>> 08.03.2026 10:15:35 Krzysztof Kozlowski <krzk@kernel.org>:
>>>>>>
>>>>>>> You received review and instruction what to do. Did you read it?
>>>>>>
>>>>>> I read the review of Dmitry and incorporated it into this version.
>>>>>
>>>>> So you ignored my email completely or it did not reach you (it is on
>>>>> lore.kernel.org though)?
>>>>
>>>> I don't know what email you mean. You gave reviews on my first verison, 
>>>> which I already incorporated in v2 and then gave a review-by on v2, 
>>>> which I also added on v3, but now dropped, because I added a property
>>>> to the DT binding.
>>>
>>> The instruction I gave you when giving review.
>> 
>> If you gave review on the v3 dt-bindings, I can't find it on lore:
>> https://lore.kernel.org/all/20251205152858.14415-2-hendrik-noack@gmx.de/
>> 
>> On v2 you gave a R-b to the dt-bindings along with some instructions:
>> https://lore.kernel.org/all/2bf9dbd4-351e-4a79-9fcf-e41c5273d0be@kernel.org/
>> which were followed from what I can tell; your R-b was retained on v3,
>> but dropped on this revision (v4) because of new properties being added
>> (new `reset-gpio` property, technically also `wacom,w9002` compatible
>> but my understanding is new compatibles don't really matter much), as
>> your email said "Please add Acked-by/Reviewed-by/Tested-by tags when
>> posting new versions [...] unless patch changed (e.g. new properties
>> added to the DT bindings)".
>
>Thanks. I also provided the link further explaining what one has to do
>if one ever decide to drop the review.

Assuming you're talking about that R-b dropping should be mentioned in
the cover letter, that was probably just overlooked.

>
>Dropping it silently is for me rather sign I should ignore this patchset
>to avoid wasting time of lost reviews.

That was most likely not the intent, I think your feedback is valuable.

Best regards,
Ferass

[PS: I see you left some review after your last email, thank you for
     your time and sorry for the inconvenience.]

>
>Best regards,
>Krzysztof
