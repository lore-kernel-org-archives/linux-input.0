Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BDE13959D
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881881; cv=none; b=ShCgSGXXzLWR5XleRhFqM6jlbMXJ8IkIMDfvb07riVTMfgzqP1Ifymf95Ci3wLwipAja0zuU0W2eHb7bCL1VvEvaP4olC5CgYt1dQ8SaapZOh7nRnWK7RVU6FPB3ECgnxFBSgvGAwZlauiLUX6aTW89u5rXOjiAbxmyM9jAIiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881881; c=relaxed/simple;
	bh=6TaviUTwKShMi7laQjTl2xzGeSK4rxlTEr7bWQhQPXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uw9mEb7jK8+kuQj3XluLwW9o44wC4N8noOuddWhGJlB7Lc349fzXOaPB/EW9d6tSb9cguLkhqRA3wp3VQalLmQDiJB14Nu1frw9EOAxIXS/M9DNhWfvz/bZwd/U11AzEHsj92pqPIlA5+pkIeIuUQco7qEb6RFNK20tBdD00MMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=xhFMpa80; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="xhFMpa80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787881879; bh=6TaviUTwKShMi7laQjTl2xzGeSK4rxlTEr7bWQhQPXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xhFMpa80C96/yqrTtX89EdhzJDVqD6oGA7BaKPc8g3ZoMsYyCR9Y4B/CKmX1G++YM
	 KAOiZResOTWPSkYH91XZaPhOIHmcFCPJ23lnK0yw2a9LnGm6AJJEFyD+RUGqkb/FU+
	 +xTRCu4CE79iGBOehvf2h+4opre36pKdabmGROpbRznEHrUrDZLbjamoVq5ePzzICF
	 3oNN/8nHHEq8BSDJd8G74ELQaR0QsKjVqjkcFiwfmSAnsoI7hrzJWhIQIXH6tRG/8n
	 K3ML4nYMRkMPdCT9HOQuQ7qzHy7M7M0ibC12XC8dWetQPPQ+vZBTvMX/IkfZvM63Bl
	 NVmOCa9tPOpTw==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 2F2B6A00C;
	Thu, 27 Aug 2026 18:51:19 -0700 (PDT)
Message-ID: <19303959-3022-4c99-a1e6-b38fda5e4ac7@endrift.com>
Date: Thu, 27 Aug 2026 18:51:16 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] Input: xbox_gip - Add security implementation
 from xone
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-8-vi@endrift.com>
 <20260824214933.GA399653@google.com>
 <e554318e-77ab-496f-ab85-c2c5d7273eed@endrift.com>
 <20260828015001.GA1949@quark>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
Autocrypt: addr=vi@endrift.com; keydata=
 xsBNBFtJAmYBCADmRIN9O/aBbYc93lUMvG2hPip++otLit+65EwNHB1y9BmbVr0Q8Tz7rbAM
 K2mB0EiA4Z3DesoLIOzlJq0E4fgDsAi8ok/i7aTx35d0Qeab95GEdkCMcL98xNJE0agq+KYk
 pnvFlhdyC23K32KdOijsUqqbd86GgxRZmuf/Yf932KxKAj+n0aFBw5y6i0ep7WQBF6ytpqah
 Uzy04D//smiTr6rrXg+C09MX0XZ2Fvcv3gmimnoV6C/ZCO1Zecqyhrs0YFfdIhFEBp2ItYim
 MoeU4g6y726gyRO/+wwzZkryJMU8hHootzW1gUylZeELSwx8uIJSHFiLE7AK+M5soPtDABEB
 AAHNG1ZpY2tpIFBmYXUgPHZpQGVuZHJpZnQuY29tPsLAjgQTAQoAOBYhBNj+0QMp9OPSosB4
 6X72E7X7Nb0rBQJbSQJmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH72E7X7Nb0r
 WIcH/0GnIOkmAyy2UlgS/VKi193ZRWYJjBfUncIBf57gLt1KYY0PvUoR9MVvkLqcx8vaCxWh
 bVSqzxT6WU1ECp/URdQV2W4IGB6W4B8rT3VGw0QzbVVQRmt6vReEMFVL+vBfgHKTRBItiy7x
 Bd+JZDusiyrrGok9TqqkBYlZPWE29ajiOAe05N1UhuRq7y8w/bOkzFD36ohMtfqV4hByWV+q
 d0LujqgZm1AkM1FqpJ4j8h1Gox5rpmWfaHJmBQ8HcKqQfwACQCvDNHS2vlTXJYfxlh+mVerL
 YKZgWnyvqx4pLKqJOXQKssIaDjnDfTu6bQgXvhaKb1+piBUYuoe9/+3E15TOwE0EW0kCZgEI
 AL/KzT+NR1/LbJ7Kuv3gAHFp+S7cfyyPSamN6i6/X135vNSawG7g81iWUweAW6YahFA2haqw
 t+8/Bm9Dzc8rF6RHCElK1GoHiF4SIYQxjqPo2wwqvTad9FblWTfaYRKfVDvNz2Rz4i681JrR
 8gizvzJPX+gocH7FMzPwb1DAwL2kKA5wilgAGSv8nZqeG55hNt2t/XiT6Yd97DJv86D24UUP
 BetLTq2jUWtX+omt+JhF3QzMjnyGQYKHNXUB/ipBxNSkwnDrWg/f1EjDtNzuOHManJDC9Bqi
 qhi1abiTNlmmewI5iLEnnxzfSKS5HO9nCC1szl229DHwIMH7jA+G+z0AEQEAAcLAdgQYAQoA
 IBYhBNj+0QMp9OPSosB46X72E7X7Nb0rBQJbSQJmAhsMAAoJEH72E7X7Nb0roioIAM0oDKEU
 QH7Og4+AXm35uklIiCX6cFQPgDVlQn7M/QFLnEhhCfPTt8PkIIN4dLgs4lIJxExpgQWgOLUX
 h+ZLLupzZXoysAXfdwNLf/RqRed/zTZbUjssy4D7yeNIJThzU32kDy0Hx3pMNM/Hd9yaXmHL
 LDkfwcyQuqA9+eeOogkDC8inLNLfYQ8JtVQZuWppNcbOZkBxfMVAmPHg6C9fe2biQFojoLPe
 4nQheprKfBp5QsY2cIjP8kaWPpfJEJ5i2aNgtrfebEzjYoWWLkK78Lo8qABdxkVhH6rhAlw2
 rVf41cHNCfHF7ddvOb9IItWacXxYn7ql+dI/Se3+ISWDboQ=
In-Reply-To: <20260828015001.GA1949@quark>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 8/27/26 6:50 PM, Eric Biggers wrote:
> On Thu, Aug 27, 2026 at 06:40:01PM -0700, Vicki Pfau wrote:
>>>
>>> There's no need to use crypto_shash.  Just call the SHA-256 and
>>> HMAC-SHA256 functions (<crypto/sha2.h>) directly.
>>
>> This code was originally written by someone else more familiar with
>> these functions than me, but it looks like shash_transcript gets
>> finalized repeatedly without being reset. See
>> gip_security_get_transcript, which exports the state, finalizes it,
>> then rolls back the state before finalizing it. I don't think this can
>> be done with the basic sha2 functions.
> 
> What do you mean?  In the library the context is just a plain struct, so
> you can just make a copy of it if needed.  Like this:
> 
> static void gip_security_get_transcript(const struct sha256_ctx *ctx,
>                                         u8 transcript[GIP_SECURITY_TRANSCRIPT_LEN])
> {
>         struct sha256_ctx tmp = *ctx;
> 
>         sha256_final(&tmp, transcript);
> }
> 

I probably should have thought of that. That does make sense. I'm still trying to make sense of this code to fix things sashiko reported.

> - Eric

Vicki
