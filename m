Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E631B10B
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132806; cv=none; b=q/n+0SnN18T7InYYYCqDZcx3PKQaqk+6y3LFnhRVvUJbA9KF1orxawimFDhRZaZdINKyf4hFtGsOaPimwBAcMudeKN/E2/lCkI+fPeVHG6ItlNxWYsbHiTNui1bofCxMvKgmaggme+kQAkvqevQ6CtghcmKchnKAr7hoXlksUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132806; c=relaxed/simple;
	bh=28lDDY5rpR6CsziLEQ198qmqjTbExvXRIV3VKpU/v+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n38Lz/iv28/JtkKBsjkh7q1JAO7klbDcX3iUvlLS62EpEXQaMP4nCdabYE0FQH9Lx2bK4dnL/mKKG2/WFolQrufvssgT5Z317mJ8y1ISOnKq1glKQAOqlJ44bBY5mYLUxRA2wsBXm5/wjbMkUmhxHynB5dtAz+3DGbSIrbxUadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=C7CCQ1Q1; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="C7CCQ1Q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1790132222; bh=28lDDY5rpR6CsziLEQ198qmqjTbExvXRIV3VKpU/v+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C7CCQ1Q1AuaMDtaMaboZ0UkZDN18UDCw+siB/6KvTNdiSankIgKM8lsESaE6j4Fkp
	 xm4eszlVsuNSKk5QPFgYb0prqV8o+ZIJgJdq8Ixz1uG4xQQHQ63uQ1LnrI+3muIozt
	 d38ZydfJdJmtSTQy+cJ1LJiyCiZhoNqa3qxvOoNzbzT6JEijNFwvGsadwF7w1p9e9R
	 VUM+bsvZoWAOkE5S5rXAHQoMm4Bgn4bBVcH+fy7KsG1/zEEpMqtLtx6iS0AEDjeiKr
	 YtNwfoDVGI3ZupJ/NeNwzovbVY6yb/a4p65eTVnknrletFsxDTFGmf0V7ZAVKlcZ1T
	 wk2xnm5xPD4Qw==
Received: from [192.168.0.22] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id E4477A022;
	Tue, 22 Sep 2026 19:57:01 -0700 (PDT)
Message-ID: <61eafb02-d682-40c2-9dd9-14da921ca1ca@endrift.com>
Date: Tue, 22 Sep 2026 19:57:00 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 Silvan Jegen <s.jegen@gmail.com>, Jiri Kosina <jikos@kernel.org>
References: <20260812012037.3251614-1-vi@endrift.com>
 <20260812012037.3251614-2-vi@endrift.com>
 <f3a50814-687e-454c-a9c6-45eb42f9334d@endrift.com> <arKcATgEevwsU_eF@beelink>
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
In-Reply-To: <arKcATgEevwsU_eF@beelink>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Benjamin,

On 9/22/26 8:20 AM, Benjamin Tissoires wrote:
> Hi Vicki,
> 
> On Sep 14 2026, Vicki Pfau wrote:
>> Dmitry,
>>
>> Can you please review the USB portion of this patch? I've been submitting drafts since December and you've yet to review it. This series has been ready for a month and I don't want to miss another merge window.
> 
> Looking further more into drivers/input/joystick/nintendo-switch2-usb.c,
> and correct me if I'm wrong, but that file doesn't seem to use any input
> related API. And given that it's sharing a struct with HID, I wonder in
> the end if you should not move this file in drivers/hid/ instead. Jiri
> might have a different view, but I think we can make an exception given
> that this is a requirement for the HID part to work correctly.
> 
> This would remove the pain of multi-subsystems handling.

I can do that. It's a pure USB module so I had assumed it was ill-fitting in the hid directory, but it is solely for the operation of a hid driver so I guess it makes sense. Nintendo Switch 2 controllers have two interfaces over USB: a standard HID one and a sidechannel it uses bulk transfers on to do configuration. There's a similar sidechannel over Bluetooth, but that's future work.

I'll prepare a v14 when I have time. There's a third party controller I want to take a look at too; the right joy-con works with this series, but the left doesn't. Very strange.
> 
> Cheers,
> Benjamin
> 

Vicki
