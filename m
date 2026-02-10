Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81F26ED3E;
	Tue, 10 Feb 2026 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770702858; cv=none; b=q1p/OD/vWEH/CfAa09YpzIfj1APVRO/GFQ5WWQ5/xOmHx/qhG5ydEzFeDaFBOd64kb2kno5fbAKIYsJIl5k/tgjjlicki1JxAI+tReb5CGKOqXdoq9Ri2Gn7csWWR0tW1eLL9sSdqh/rgEYtzq5iz1gu+7vWs7JRFZa0j6QA4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770702858; c=relaxed/simple;
	bh=7ZpkbukoWdHxQIwUCU05b9nH8be4sbxyQVvaJPubSn0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bS0IGIcYeoCS+3uYBma3rrRO3j9N9BtRxm7Zp+6QHIInyz9MQJGiX4UREjgX8m16u6LGkQJCmP8gFveL5/6ObfQc4eFH3Elz0z4WQPdsTLI/WeD7uG4wvAC+//9LWBKfKE8R5NomrEbfkjELCdzNStAdeCJJhewdiwy/+WDZrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=IZH2Dnfa; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="IZH2Dnfa"
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id B3B552022B;
	Tue, 10 Feb 2026 05:54:09 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id B6D93202EF;
	Tue, 10 Feb 2026 05:54:00 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 48A8C400D5;
	Tue, 10 Feb 2026 05:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1770702840; bh=7ZpkbukoWdHxQIwUCU05b9nH8be4sbxyQVvaJPubSn0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=IZH2DnfatfOzxICF3c5RBX+CtLY0bc/odKtzm1U09rooPZIako/lWKbPLWGpBd5+d
	 PUtdlHdSOHTtnVdBUvEgOAPxPTOZbVd4/CPGJsPHeYk37rdD9s8whohH0i7BPmhdMp
	 rW2YceP03lTbtWODUAh+yQ393zidvJICqHGDyWOk=
Received: from [127.0.0.1] (unknown [117.151.82.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 732F040CF7;
	Tue, 10 Feb 2026 05:53:57 +0000 (UTC)
Message-ID: <c584ce4f-6daa-448e-ab53-a144068216a7@aosc.io>
Date: Tue, 10 Feb 2026 13:53:54 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: liushuyu <liushuyu@aosc.io>
Subject: Re: [PATCH v1] input: xpad: Add support for BETOP BTP-KP50B/C,
 controller's wireless mode
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Shengyu Qu <wiagn233@outlook.com>, dmitry.torokhov@gmail.com,
 vi@endrift.com, niltonperimneto@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAGwozwFXmye4kJzjFbZzUmgmhHn0YyX2eEwidkUJBs7ZhpXhNw@mail.gmail.com>
Content-Language: en-US-large, en-US
In-Reply-To: <CAGwozwFXmye4kJzjFbZzUmgmhHn0YyX2eEwidkUJBs7ZhpXhNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 48A8C400D5
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[34.12%];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,gmail.com,endrift.com,vger.kernel.org];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: nf1.mymailcheap.com

Hi there,
> Hi,
> if I recall, this logic abuses some HID descriptor logic to cycle the
> mode depending on the OS. The arch wiki has a potential fix for
> certain controllers.
>
> This makes you end up in Android mode since linux kernel. Nintendo
> uses a BSD-based kernel, and the Windows NT kernel is different. So by
> breaking the protocol in different ways they get it to cycle.
>
> Antheas

I sent a patch to the linux-input list a few months ago to work around
this issue with the BETOP/Beitong controllers:
https://lore.kernel.org/linux-input/20260102030154.197749-3-liushuyu@aosc.io/.
It would be appreciated if anyone in the thread could verify if my
previous workaround works for their BETOP/Beitong controllers as well.

Thanks,
Zixing

