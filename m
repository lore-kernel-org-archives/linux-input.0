Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B96331214
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763944; cv=none; b=d7rnM6jPm6GIOIoWWBFYvCF3Ab/W4Zu36JdEiDaabCfvBnMqSuivnE8HObMW26ur04BcGkzZ5NuhhOnSFCyRy03ZFpmlafFC8HaWBsO2J1fuelMegHgHgtCMJgt0Ywt0GIDZaKs774bkI6mAXID8EhY/nLbZoj2wfSaakIlSdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763944; c=relaxed/simple;
	bh=1pWDBhgd3Y2wOSYN4muygCXyIuKwM/4Zt/lFMaHBLrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAUQvDOIMOFIbnCvGJVvQq2hKOfnMZLzlknlR/6jEN2VO1uX8A0f/YgUKufdGnbF+2lNJw9VNSi1l7Vgczws5sj8Qg3q94sge5UhlOfdzf8wX1NWQkS71EFFFm9+98/CDAEkrW/ecbCsctoZ0Q5i1o4E6CppviAzLqkbPebh2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOuRv7Uw; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOuRv7Uw"
Message-ID: <ab282e6e-bc0a-4705-b25a-780d3ab33f5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782763930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yT9IuEu2h56ZUk/8mzISwTM00xrZ83NpYSGHNjOPy/M=;
	b=ZOuRv7UwX8iHSPRH37LJcJ/CrE2hhUcXy+uw1rNCtnPtogE0fYq2lG8FvU95FzkgkmY9V6
	PdP81nWG2p5z7gvt6NxjGSy4zqJEyGt4mXzO1z9tbtr+i7QBhJUG8HXVhR8vQQTcfQ5TxX
	IcCTRxZzLifbsosxIihwpLrh8ascb9s=
Date: Mon, 29 Jun 2026 20:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/5] HID: asus: security fixes and more hardware
 support
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
 Mateusz Schyboll <dragonn@op.pl>, Denis Benato <benato.denis96@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 Connor Belli <connorbelli2003@gmail.com>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
 <rr8s664r-5s34-1815-57ss-32p461sopp45@xreary.bet>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <rr8s664r-5s34-1815-57ss-32p461sopp45@xreary.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/29/26 11:21, Jiri Kosina wrote:
> On Fri, 19 Jun 2026, Denis Benato wrote:
>
>> Hi all,
>>
>> I have added support for controlling the (way too bright) XG mobile
>> LEDs in hid-asus and added the i2c version of already supported
>> hardware that was probed only when it's a USB: these are two separate
>> features changes and are the only two that are not fixes for
>> pre-existing issue (see below).
>>
>> Auto-review bot has spotted a bunch of pre-existing problems alongside
>> problems in my own code therefore at this point I am going to fix the
>> more problems I can and including those fixes and improvements in this
>> patchset.
>>
>> For v4 I decided to follow Antheas' suggestion of reusing the existing
>> workqueue and by making it more generic I solved a good bunch of issues.
>>
>> The v5 iteration is simply me fixing a bunch of bugs in new code spotted
>> by the bot. Thanks for providing such a useful tool!
>>
>> On a side node this patchset has a few more warnings: specifically
>> "WARNING: Prefer kzalloc_obj over kzalloc with sizeof" but it's a false
>> positive as that would introduce sleeping calls in atomic contexts.
> Denis,
>
> thanks. Could you please flag which patches you'd prefer to go in still 
> for 7.1 and which ones are not critical and could wait for 7.2? The whole 
> lot is quite big.
Hi Jiri!

Patch 1 contains multiple fixes, mainly use of sleeping calls in atomic contexts:
I'd say slap it in 7.1 fixes.

Patch 2 is a minor improvement removing an OOM message to align the driver
to newer code where that would have been a flagged warning: probably a fix for
7.1 but there's no rush for this one.

Patch 3 is a logic fix, condition is very rare (not sure if even possible) but belongs
to 7.1 almost certainly.

Patch 4 new feature support: goes to 7.2.

Patch 5 unsure. It adds support to the backlight, but to properly do it I'll need
to wait for lamparray to be merged since autonomous mode must be disabled
to take effect. I'd say 7.2 just because of the missing lamparray. Merging in 7.1
has no downsides, yet IDK if putting in 7.1 violates some rule (probably yes?).

Please give a (very) quick read to the following link:
https://github.com/OpenGamingCollective/asusctl/issues/119#issuecomment-4723566635

This is something I am full of tickets for, probably we have reached the thousand
between discord, github and gitlab: very prominent issue and I'm eagerly waiting
for lamparray support to appear upstream.

Thanks,
Denis
> Thanks,
>
