Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A737F8AF
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530813; cv=none; b=eGGMrOef7H9EO/mD+TRsBU8u8StiT4+35uTx3c+4DxF61xZKtxxvZt+JfvVuBCC3N6XHU5Yz9EOCT+UnEfxWGHOiJEpSk60GRA7FxCxoAn7pzaGhMFvJ7r8F3j2yYK27qQ63CiepxUKOIAY6cS4cgpIqYc0+uZDe+JVdHrxNOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530813; c=relaxed/simple;
	bh=QlCoJgzFuDkzKyD4vPssOlod5ioow6DwDwHxhzMVUXk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VN7TRM4u4H36P3oYQGn/WT9dDfoFcf+Pwa2atRSBvNBwDEbaYcjgC7MRv8/VC22P3RZ2iAUUk6ld+AcBP6ybRbAULU3q/cV/CVM9OXHlE2vRBc4KxghZTDuUmqk3MOLzN2GKcEbzoxG2bm0njBYEqHItOOh57uXZq53JQUp/AGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=gN/k7MhQ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="gN/k7MhQ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso8081685eec.0
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1778530811; x=1779135611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qQPJFpBF/Y6ESwRVchtItkryNrsx2h5o1QJ9xXHHvWE=;
        b=gN/k7MhQZlmt+HmCJ0h5lM7ah0m+TNKxkHec5B9x5z9zDBX+GEXUGOTyE06eNQR2VL
         omWFOzsRu3y2yo9m50iC7xrYL+ti5gNXvbvh03dFhyyX/hA1QixcOFFTPhtwik2N3Ug3
         qARBstLTu5cfdz0Dqwx3x90+IprJ6axjvQRGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530811; x=1779135611;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQPJFpBF/Y6ESwRVchtItkryNrsx2h5o1QJ9xXHHvWE=;
        b=XSmkRWAW7Z9Abn+SoIQQXeyMgHk7JnN6gnWBSqplCwEZfagIue6HIumISqMwASETzh
         j6A3fb6HLmUFKazn03d479Yo8JhCyypKqrSq/C6Wv8OkaB5CE+cwrig8A9tV09zuirfG
         Yire9UaHodu2GE61Kb68QpbEXte0i0VXXaipHPfFXzGZ9/u6OIM4tvrmEQ01CJe/KVKe
         mjt9uPLnIIJnlo1Xgn7FdUp7AD/P44ityAEKOQyVHuv8UIJpnqKCFIVGywlMPsBGJiZX
         cTpHR/nKYji9f7jDPHSsRrpp4pXLEWYhQXg0LfBpD+amvXCreaLKOg87ifZDEezd0JOu
         cOaA==
X-Gm-Message-State: AOJu0YwO8ngAg8V1Vm4f10fdsnjPn0/JPUJqOEpuQC3D/80udeU3FTHa
	mFH0mtCArghD4/mZZ9iMnHGfTql4gJsauwFhrlUog+7H4HZVxD5BOgR1E3y/NBccmeY=
X-Gm-Gg: Acq92OGE4yON+UA6NI1ZKgv9KucJTBRXgqbxT6c1UPE154tnOFnT5x3esyEUhGuRvP3
	u227zBtbXjcWmbFigeqfjzEJUloFW3ICppUnu+Zb9spqKrsxKbxHVihzKaF40TE6P7qSVCuV2us
	npw+aBgldtZQYAIcZFCqOEcwmBZ5FW2+wMH+byN+AHl/KcX5FRorCMdnXmty5vyrtUFY1/9FtDJ
	mZfMRAg9HOe3Bzq5bhJL9lSsY4mBKOPcDZiJ8pa8Sq9G3IjKH4nwpJdiZGSq44WED/iu0U1LjoS
	QN32RC5OaMmMm3jxy2GthwaC2gilqXYOCXmKq7DqZ9VEcK87ye1Qt593FhwTgH+gJlY3T4L7lkm
	EjkVtWK2S4UIfaSIjKCgftEtuTALuBrEQrhcwi/RtO7dK960Xset7GDcfentvT2yr9wgyL38SjA
	tdm5bi4qUN7mPsPJS52fgh91cw+GXTHVDGpa/NAM5JPuhAxx8irkA0VlCl8+7l8CuPSe1wtTpO8
	i8xi5k9tSGYVkhZku6aIxOPHP86paI94+I46Iqc7ohNy1sNfU/2jQNaEjeRowJrBD5Tig==
X-Received: by 2002:a05:7301:1008:b0:2d9:b466:5e19 with SMTP id 5a478bee46e88-2fb4b733d76mr5616023eec.21.1778530811190;
        Mon, 11 May 2026 13:20:11 -0700 (PDT)
Received: from [10.10.10.191] ([184.3.231.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8860ce1bfsm15471585eec.9.2026.05.11.13.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 13:20:10 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <cfe31865-021f-4c8b-b307-b6ba9bb7c3d6@embeddedTS.com>
Date: Mon, 11 May 2026 13:20:08 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: ads7846 - consolidate coordinate filtering logic
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Mark Featherston <mark@embeddedts.com>, Marek Vasut <marex@nabladev.com>,
 linux-kernel@vger.kernel.org
References: <afl3WtbabMFNjE24@google.com>
 <cf9e30d8-f51b-4a19-ae7d-914e6bccb265@embeddedTS.com>
 <afzo03UP-shPfNMe@google.com>
Content-Language: en-US
In-Reply-To: <afzo03UP-shPfNMe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dmitry,

On 5/7/26 12:35 PM, Dmitry Torokhov wrote:
> Hi Kris,
> 
> On Thu, May 07, 2026 at 10:48:57AM -0700, Kris Bahnsen wrote:
>> On 5/4/26 9:54 PM, Dmitry Torokhov wrote:
>>> The ads7846 driver has two separate filtering functions,
>>> ads7846_filter() and ads7846_filter_one(), for the full-duplex and
>>> half-duplex SPI paths, respectively.
>>>
>>> They can be consolidated by extracting the core filtering logic for a
>>> single command into a helper function, ads7846_filter_cmd(), which
>>> iterates from l->skip to l->count. The half-duplex setup function is
>>> updated to set l->skip = l->count - 1 so that the helper only processes
>>> the last sample, preserving the original half-duplex behavior.
>>>
>>> Assisted-by: Gemini:gemini-3.1-pro
>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> ---
>>>
>>> Not tested so will appreciate if someone could give it a spin.
>>
>> Forgive my ignorance, but I am unsure of the base commit this applies
>> to and I'm unable to apply it to current HEAD of linux, linux-next,
>> or your input tree.
>>
>> I also am not easily able to test this if it doesn't cleanly apply
>> to the latest LTS, but will do what I can once I know what other
>> patches I would need to pull in to our tree.
> 
> I think if you pull 'next' branch of my tree, then the following patches
> seem to apply cleanly on 7.0:
> 
> c68bc840f06c ("Input: ads7846 - restore half-duplex support")
> 011bdf9f3a9d ("Input: ads7846 - consolidate coordinate filtering logic")


Please confirm that the referenced commits are pushed and that I
am using the correct remote URLs. I am unable to find the referenced
commits still:

$ git remote -v
input   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git (fetch)
input   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git (push)
next    git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (fetch)
next    git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git (push)
[...]
$ git fetch next
$ git fetch input 
$ git show c68bc840f06c
fatal: ambiguous argument 'c68bc840f06c': unknown revision or path not in the working tree.
$ git show 011bdf9f3a9d
fatal: ambiguous argument '011bdf9f3a9d': unknown revision or path not in the working tree.

Apologies in advance if I am missing something obvious.

> I hope they also build ;)
> 
> c68bc840f06c should appear in linux-next soon too.
> 
> Thanks.
> 

-- 
Kris Bahnsen
Software Engineer
embeddedTS

