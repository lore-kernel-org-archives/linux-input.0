Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C47242D6B
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881212; cv=none; b=JVWJu8+OgxbVYsnMdzdZFxIr6r8kVbC9fnieVOIPkWWDovLRP0lxVUBBhjxh17O2NPMiifI6SMXO5rGeF8xKSNlv4MrIjcI/0+CZHH+1NyqM0WEuXlkXILGK1iu8Ht/am7o5isTzqILCD7FBiMSpoUPueXlgGu3Ntnlp0kXwI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881212; c=relaxed/simple;
	bh=QcZ3wJXOC0JW+rJWRwLhfchrNZaoprNB0Zz89OLUzC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHyL4CNaR/Fb70wZhSx2tDXlQqDcjxSeVHuQjzSjJEDMJUVI4LhTwUPh/F4NkGEDzuesdSvZvCQHR0YM8G0KHbcQaj5hvQrocTSz8D83dqRry0oVIxZw9RY56SeCGIq6K+Ni78RNmBXQoZKOo391p8JMYcmQR1tNlNFxH2AXKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=wZM+mTBx; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="wZM+mTBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787881204; bh=QcZ3wJXOC0JW+rJWRwLhfchrNZaoprNB0Zz89OLUzC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wZM+mTBxJH3ksVcvsJTSn0vko842TXJplHnel2JXSECz+786Cs3sHt/muj/EOhxE+
	 9nBPv8GMV3Ljwgr25DnLeefeKEgLgMOpPRRWm0L/7RQ8soIHUPU0f8HR4qzp7eOJLz
	 stjCzhHluixWA+ovfZfpJVFCeKrMzGbOTLhl3XJgmM9W3zzUFFcARwkZaXL1yyPkoN
	 9FOkTZeV6yrftliAFyxpEjd2ZkmQsHmvzjPyKM0DPJnwYJduylpj8aNZkaOXe0HyHp
	 573cfwGG+4PT2P01Gra4NrzMvU+ToVHXV7cDg8mZI+Rixq2DTOF1tRzf2SvM6F/1g2
	 80SQmfrHSQV1w==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 7BDC6A00C;
	Thu, 27 Aug 2026 18:40:04 -0700 (PDT)
Message-ID: <e554318e-77ab-496f-ab85-c2c5d7273eed@endrift.com>
Date: Thu, 27 Aug 2026 18:40:01 -0700
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
In-Reply-To: <20260824214933.GA399653@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 8/24/26 2:49 PM, Eric Biggers wrote:
> On Fri, Aug 21, 2026 at 07:11:31PM -0700, Vicki Pfau wrote:
>> +int gip_security_start_handshake(struct gip_security *security)
>> +{
>> +	struct shash_desc *shash_transcript, *shash_prf;
>> +
>> +	if (!security->shash_transcript) {
>> +		shash_transcript = gip_security_alloc_shash("sha256");
>> +		if (IS_ERR(shash_transcript))
>> +			return PTR_ERR(shash_transcript);
>> +
>> +		security->shash_transcript = shash_transcript;
>> +	}
>> +
>> +	if (!security->shash_prf) {
>> +		shash_prf = gip_security_alloc_shash("hmac(sha256)");
>> +		if (IS_ERR(shash_prf)) {
>> +			crypto_free_shash(shash_transcript->tfm);
>> +			kfree(shash_transcript);
>> +			security->shash_transcript = NULL;
>> +			return PTR_ERR(shash_prf);
>> +		}
>> +
>> +		security->shash_prf = shash_prf;
>> +	}
> 
> There's no need to use crypto_shash.  Just call the SHA-256 and
> HMAC-SHA256 functions (<crypto/sha2.h>) directly.

This code was originally written by someone else more familiar with these functions than me, but it looks like shash_transcript gets finalized repeatedly without being reset. See gip_security_get_transcript, which exports the state, finalizes it, then rolls back the state before finalizing it. I don't think this can be done with the basic sha2 functions. I might be able to do it with the HMAC though. I'd need to familiarize myself with the API first.> 
> - Eric

Vicki

