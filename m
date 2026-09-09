Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CB3F8ECA;
	Wed,  9 Sep 2026 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946901; cv=none; b=ABg9vczGybapWP1xZ9mUFdTk7Lwyj+cgfxdjW+Yzk07TZyRE7VZ52YehhFjA6rkxn/RDt8BTJS23D7lbJ8BQIWN96FIXcmpKz6dahAYSpUn6lThLZv+KfgqPvkdhK7cCoA24/r89hit4/hIdt0/cVQt7X2ie+RVTv18pJhcGbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946901; c=relaxed/simple;
	bh=efxjKCYATAi0YX4UYw7OKoX7V8KVsknnQ9ugNbh/9sc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xz0agwWRxT4kfwroEdWzNmPgMx3AIPfOCjlP7sI9IB15YRAafsZzefrcAKDtnLs3l15TUMdJu1+elM0u5KCaebtG7g81aFw0N2LKwkqaOSLF++Sr0f5gtIHNuqyjuhzT2uY1dTUE9BXYSy8RhKVvv9Y8g3n4ej3GAn7Emx2XVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwY2ebOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwY2ebOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950031F00A3A;
	Wed,  9 Sep 2026 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946896;
	bh=Wm03WCPdVPyQWKmDSkyuLdbSZ5OQjr0lv3BS6M9u5cM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=nwY2ebOsj7mS3ttN3G3EWRjKiyWFZ0gtEMjIJN3K1wqUJsttsrTdbyfQBFm1jQCyB
	 7vmTYYS839yuv1cX6tja905yvhkh9EcofdP9WnaPtUWoWvyrtAumDS2a4HHmBWIMve
	 5dpueVdHkSghCcKpgrr7/QXpDnzIAKt4PvNyXS7RZRdlqRC/zafVeO6tpHPWHFrjmj
	 xb9UQ0yzEoE/0FbkpwHs3moa+bsONVVPdXlHY/n8J2qWwRNYmuAN5ig7GnJ1qPq8sI
	 tWGX4IgwHa6vbMA/pq4rqS0EcPsDMLoqAQMRGokrQveTjDWaqCF8WCv2Bc3cAHaJfx
	 j0i+ERqvxbX6Q==
Message-ID: <8a8a0fcb-1c93-4f0d-bfcd-ae92af0376e0@kernel.org>
Date: Wed, 9 Sep 2026 11:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: soc_button_array: ignored -EPROBE_DEFER loses the buttons on 68%
 of boots (Surface Pro 11)
From: Hans de Goede <hansg@kernel.org>
To: Sergey Lebedev <lsa.uz@pm.me>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260830141355.55898-1-lsa.uz@pm.me>
 <0fe7a8b6-f3df-4822-a03a-d072b86cdfa8@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <0fe7a8b6-f3df-4822-a03a-d072b86cdfa8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8-Sep-26 23:46, Hans de Goede wrote:

<snip>

>> Why no patch
>> ------------
>>
>> The comment says -EPROBE_DEFER is discarded because Intel uses "virtual
>> GPIOs" that never materialise, so deferring on them would hang the probe
>> forever. A fix has to tell that case apart from a controller that simply has
>> not probed yet, and I do not know which signal you would want to use for
>> that. Guessing would risk reintroducing the problem the workaround exists
>> for.
>>> Happy to test whatever shape you would prefer - the machine is here and I
>> can build and boot kernels on it.
> 
> Thank you for your detailed bug report. I've just submitted a patch which
> I believe should fix this:
> 
> https://lore.kernel.org/platform-driver-x86/20260908214410.70422-1-johannes.goede@oss.qualcomm.com/
> 
> Please give this a try and confirm if it fixes things.

Shashiko review has lead to a v2 and then a v3 of the fix, please
give v3 a try:

https://lore.kernel.org/linux-input/20260909093934.29411-1-johannes.goede@oss.qualcomm.com/

Regards,
 
Hans

