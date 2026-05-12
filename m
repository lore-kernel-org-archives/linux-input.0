Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9139526B
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615924; cv=none; b=kgw+ehL35Hc1AYB7jTo4hqoyLkyHW8+vMus3r4dTUX7yNAlWM25iP6i1quxU8ax6l2cTvW5WQV8HcDd0Ka6Io3+xYD4emIjGpq+HNnANN85uhC/IJLvfl9uzC34JOFEZJO4VJqTT1UB9Bp0Y1t+tmqTjMIbosHbl4sW7JHklUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615924; c=relaxed/simple;
	bh=iS9CVxYSDjOlMzX4YWq9lgFPwRaODxDtNawc3oXlSI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poiV6xXYBtZjw2TgCNLsxSw6WlT8d56MEsChfCssdJ6DtdDinSB0m/o/C3goI8U0FxzNCGAJrJjGq/NnfxpSsvg8oS90MRQtMnmf1V0TR6xd++A8lSogntk+hgpz5fiGLH5SQtKPc84Qw1SOijdHkm3h4n9/Y7NigTcLrs8uq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=I4xkEgv1; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="I4xkEgv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1778615370; bh=iS9CVxYSDjOlMzX4YWq9lgFPwRaODxDtNawc3oXlSI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I4xkEgv1Uqs3mfJpfAT4A9BTm8JF06X3B2bb7wIeLu1FM3ffi7twMFny/jDPkt3uv
	 9aeMIiAEnzwKgbPBZ7LUdXidD1Zhoi6b86OQX77xHqS1V5Xoz4I+wxLiA9pty43wum
	 H6sDdIqt7mDT9dRdSVrbesBQTfL1ZbC+cippCuZwBQyocMM5ZQoBE0bBiuS9KBae+R
	 yA/0NJny1YHnffmCNrEne+bkWrDx200Ucqg+5gywAYn4J03N9xvLCBWiSiPjRSUNGn
	 yhiv5cEN55zyS4vIUlXMx5lqBOwdSlaNJuysBddjilHcWIEBmPnDe6AmR9qFpQGfOa
	 OcYTHeMdhqAUg==
Received: from [192.168.1.220] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 90CA4A01E;
	Tue, 12 May 2026 12:49:30 -0700 (PDT)
Message-ID: <7f1bb387-60b9-441e-a090-07246bd6e4eb@endrift.com>
Date: Tue, 12 May 2026 12:49:29 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] HID: nintendo: Add preliminary Switch 2 controller
 driver
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
References: <20260415073142.1303505-1-vi@endrift.com>
 <rqposs64-2nnp-5552-nqp3-o45q11328o97@xreary.bet>
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
In-Reply-To: <rqposs64-2nnp-5552-nqp3-o45q11328o97@xreary.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 8:43 AM, Jiri Kosina wrote:
> On Wed, 15 Apr 2026, Vicki Pfau wrote:
> 
>> This series adds preliminary support for Switch 2 controllers using the
>> same split-driver model as previous versions. This is a minor iteration on
>> v3 (which was erroneously submitted as v2 again), fixing an issue where we
>> checked for NULL instead of handling an ERR_PTR, as well as a few typo
>> fixes.
>>
>> Vicki Pfau (3):
>>   HID: nintendo: Add preliminary Switch 2 controller driver
>>   HID: nintendo: Add rumble support for Switch 2 controllers
>>   HID: nintendo: Add unified report format support
> 
> Vicki,
> 
> are you planning v5 with Silvan's comment addressed, please?

Yes, sorry. I was on vacation last week and have had my priorities shifted at work since I got back. I have something else I noticed that needs fixing too. I'll try to get the new version out today.

> 
> Thanks,
> 

