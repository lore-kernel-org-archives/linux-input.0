Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862EF507
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161463; cv=none; b=sKMcYVoWopYIcLBeENClxrBAUTKKKh6M3UrJp2E4Z2n7VtBnzTJXNvgHwRjAkh+yj+OxkbRrnxruU2+IKAurd5nUVoWqal1r1g4DaTVwSmr0qxITCmqHWJmrIkR5fryHs/9QOuG2i+W1k+exukxLoPrlXfycxpYpsZZ5fe0QHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161463; c=relaxed/simple;
	bh=PZj1fcwaLVWKDKmtK0kUJv9/mrPhRMVOZLzPKyuWFJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GtlhtkFiCmcKXN1W2DuZ4d5toiaE2Qe3UtgL6pRUQbcGC3WTQd+ftO3+p7bnnWOFPps9t9JVrsfuKsUScusPrRMLDkqXjNqu+KnEKnaNbyLxYa2hY0Ot5LwAFWymjlZ/S/uExA/6d9irSDlUSkbEEYJ6rkBAhP4BDiyIQWBxUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=HRbJPWcF; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="HRbJPWcF"
Date: Tue, 10 Mar 2026 16:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1773161450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SMoBYRHe8BuGZwLX7Nu4sjy0/B8sDrTJ2hSjkubIsk=;
	b=HRbJPWcF4u1V0tzoPI5iuIZawHvyv5chqENEJLgreHyZ9cflws0ME0GkIonFZzm6djM40h
	/ucIY5I1P5YkgIXMJxEMrGiD0MgMv0uCz0OT0gqWwxVR5Q2yv0WKTjwDbVymZbuY+suMdw
	zmAlMP0JAoFGSIP0aKK+LmaR6NE3i3YNeY3am3D6eu+lnsjrjvziqLQF/MUZRf8aiVo0xZ
	suRpFqBu0E7dOz8exCm6wX2YCrpC98sYv0mOWDogGgZoSnEd26iqXTLeMwMfeyyTung4AY
	ucQIW1S7ouhy6c0kuORsl81uFd/AOHh/a+R1aDZoOvXyt9n+ligJrcUI3NPk5g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Hendrik Noack <hendrik-noack@gmx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ferass El Hafidi <funderscore@postmarketos.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
References: <20260307181557.66927-1-hendrik-noack@gmx.de> <20260307181557.66927-2-hendrik-noack@gmx.de> <20260308-vivacious-coucal-of-current-2d7ac8@quoll> <feae85c4-bea1-40b2-87d5-952b26ff3ee3@gmx.de> <fddf0e3b-707e-41b3-805b-2abeffed6c05@kernel.org> <f067754d-229c-4418-a367-6df5feb6cee0@gmx.de> <21aec29b-595d-4889-a71e-abe9e5ce834f@kernel.org>
In-Reply-To: <21aec29b-595d-4889-a71e-abe9e5ce834f@kernel.org>
Message-ID: <tbp04l.1q4xkmdkoohga@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT

Hi Krzysztof & Hendrik,

On Mon, 09 Mar 2026 13:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>On 09/03/2026 14:12, Hendrik Noack wrote:
>> Hello Krzysztof,
>> 
>> 09.03.2026 13:56:41 Krzysztof Kozlowski <krzk@kernel.org>:
>> 
>>> On 09/03/2026 13:54, Hendrik Noack wrote:
>>>> Hello Krzysztof,
>>>>
>>>> 08.03.2026 10:15:35 Krzysztof Kozlowski <krzk@kernel.org>:
>>>>
>>>>> You received review and instruction what to do. Did you read it?
>>>>
>>>> I read the review of Dmitry and incorporated it into this version.
>>>
>>> So you ignored my email completely or it did not reach you (it is on
>>> lore.kernel.org though)?
>> 
>> I don't know what email you mean. You gave reviews on my first verison, 
>> which I already incorporated in v2 and then gave a review-by on v2, 
>> which I also added on v3, but now dropped, because I added a property
>> to the DT binding.
>
>The instruction I gave you when giving review.

If you gave review on the v3 dt-bindings, I can't find it on lore:
https://lore.kernel.org/all/20251205152858.14415-2-hendrik-noack@gmx.de/

On v2 you gave a R-b to the dt-bindings along with some instructions:
https://lore.kernel.org/all/2bf9dbd4-351e-4a79-9fcf-e41c5273d0be@kernel.org/
which were followed from what I can tell; your R-b was retained on v3,
but dropped on this revision (v4) because of new properties being added
(new `reset-gpio` property, technically also `wacom,w9002` compatible
but my understanding is new compatibles don't really matter much), as
your email said "Please add Acked-by/Reviewed-by/Tested-by tags when
posting new versions [...] unless patch changed (e.g. new properties
added to the DT bindings)".

You also gave an in-depth review on the actual driver itself on v1:
https://lore.kernel.org/all/20251028-funky-rose-rook-3ccab5@kuoka/

Best regards,
Ferass

>
>Please wrap your emails to standard email style, so reading will be easier.
>
>Best regards,
>Krzysztof
