Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E41D5ADE
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440620; cv=none; b=jNavVIQb4kU/NWs3GEXZlKF4PJYtef1BTgBml3ja9vgoUkWZqdtIXK7sVctyJSicBGHErfH++2/Sh7YbKXGBh9mRll5mo7k1cRJp5OfCfvsjyPptTv3+w/QrpvTIn+OJEKMuccEYvizUgUZ+Foos4QdCUE/wq/jqxTr2iM06D/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440620; c=relaxed/simple;
	bh=XpMC6Y5whEOwulrzdfFzbfqb6Q9PR5L9eW6LFKByM9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlhgF6Wx3APV1+FN+NAof3zE++X16qePc4iRfdvQUJRfsuUNg6yLOiEqJyZOi8uBxpdoToulkagpkJ8FySb0EYa4kDoLFdZVAs5+hoNz4Ee7LP4EkoRXFCbyUeB6pqZRePxxXSyHHSLuOezU05kqVlyBF/VW7VQj/Tv/lqHT9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=CsUkzDdw; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="CsUkzDdw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1782440618; bh=XpMC6Y5whEOwulrzdfFzbfqb6Q9PR5L9eW6LFKByM9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CsUkzDdwsWccak6XD+kMiz+gq04pq+BZSOLqqg9IWRsJ0yEr5ddUzG+jfV4rHOLRx
	 OlTCiUZHn2PYv5jfrPNVoVd51RSVAW4XGOG4sjmXOxiUwNFx3gsG29q8VcbeOt7uwT
	 5NC+Nd3q1D4CSxdmrzNkK2dSKQN2qj4EJoijTgH60IkxvgGFny5s8M8WxlXd5j3dK8
	 D6clOgqvTU0/yxpRi/PZ5Fj8QGSR4hxtSY9TvfrUzvEFbXmWcFnyRmvYJPNB6d5a+Q
	 I8/GRqxr+RUF3x0zM34UkLCCaj2kbCe9P1wh454WMgu0anr74PfId5FjkPR03CyMQV
	 60IYCOpc0mr4g==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id A68ADA018;
	Thu, 25 Jun 2026 19:23:38 -0700 (PDT)
Message-ID: <7dab0b1f-f757-46ad-961f-2114191b0e57@endrift.com>
Date: Thu, 25 Jun 2026 19:23:36 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] HID: nintendo: Add unified report format support
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
References: <20260625045948.2343168-1-vi@endrift.com>
 <20260625045948.2343168-4-vi@endrift.com>
 <20260625051335.6F41E1F000E9@smtp.kernel.org>
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
In-Reply-To: <20260625051335.6F41E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/26 10:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Global minimum report size check incorrectly rejects valid legacy, non-unified reports.
> --
> 
> commit ebbc8f2a738bc80390ec8c8785093f44578537e8
> Author: Vicki Pfau <vi@endrift.com>
> 
> HID: nintendo: Add unified report format support
> 
> This commit adds support for the unified report format that all controllers
> also support. It includes overlapping fields for like buttons and axes between
> them.
> 
>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> index ae360f4d15d1a..9cb4a503fe2d3 100644
>> --- a/drivers/hid/hid-nintendo.c
>> +++ b/drivers/hid/hid-nintendo.c
> 
> [ ... ]
> 
>> @@ -3732,7 +3833,7 @@ static int switch2_event(struct hid_device *hdev, struct hid_report *report, uin
>>  	if (report->type != HID_INPUT_REPORT)
>>  		return 0;
>>  
>> -	if (size < 15)
>> +	if (size < 17)
>>  		return -EINVAL;
>>  
> 
> [Severity: High]
> Does this global size check incorrectly reject valid non-unified reports?
> 
> Since non-unified reports like NS2_REPORT_GC only access up to raw_data[14]
> and can legitimately have a size of exactly 15 bytes, it seems this check will
> cause those legitimate 15-byte or 16-byte reports to be dropped with -EINVAL
> in switch2_event().
> 
> Should this 17-byte requirement be scoped inside the case NS2_REPORT_UNIFIED:
> block instead?
> 

Generally speaking, these reports should always be 63 bytes. This check is mostly here as a basic sanity check to make sure we don't accidentally reach out of bounds in the case of something very weird happening. It's fine if it seems a little overzealous since it's so far beyond normal operation already. I would guess than the Switch 2 rejects anything that short out-of-hand already.
