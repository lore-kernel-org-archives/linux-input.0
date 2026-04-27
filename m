Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C497320CD1
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777306806; cv=none; b=bsSB6TgUev6CyCbweTMOLUS3nYtp5B4ot3JykeXx5nQUQhZfkJky2bPXMRWPA6B7ZCuBmYPcY02qyAUItqYbRH7unPRmjfvONGdXkqs3VgKhLp33dLnO2L7f1GrB83w6mg6jlQrGl2b28JVm95MTw/0UMghyafT+vNFCiRVqZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777306806; c=relaxed/simple;
	bh=xidvJQjpM7yPCqe5PKIOorDtLSAo4K6bgw4e3ytK1qY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QZc6iWFJBA1J4NqQAdmYeZQ7A/lv6aoDEZGEbaR1drt1hX4JeUxZbJHaGcr6PNWEay3zlRoSgY6dHGmnuS1s+nZ7P3GIlQO6+Fl4aT96jLLT+c+Bur3wX/v5ZfY1e2eqhGquOYRCd2+Q2pof21pi3wIcF1WlnPc5U6WiTA8D+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=FQs3GDZ5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="FQs3GDZ5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so6474665a91.2
        for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777306804; x=1777911604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ot5/VkkpAMcYPEn/1toyTMHXbfWqkhlcoGx5NqyUByo=;
        b=FQs3GDZ59mCkixfqWKRa0YoBHHPrPBCM6BijDOo3TqYenzhklcdOEaCrj1CAwHLtWy
         xL1nVWrmkPAF0Ub5UK46RDkBSXx5aY3iVO9/ulYVIMnQu317isIFU9saspWlKqzF1t6Q
         Jb13N3yS0TOOyXEkJQQlL+o39Iy196Yk4f5+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777306804; x=1777911604;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot5/VkkpAMcYPEn/1toyTMHXbfWqkhlcoGx5NqyUByo=;
        b=NUV9rnAsLxQfvfmQSqxGjN5sPZQwuBSnNvtPZ33bDvRqd/AdoibZHfSEHf/F7uwH6Z
         ZDkF7BjtkVKfqQ3mWByNCvq6k+Du/83QhaIE0zIQUkN314zI7ADWJmSae+uQagKI7BH+
         33QxQ96h7ef+iXnk3NbdNbWlt5BMYpWfLPjKTqq1WtvrH1iZm9s6JXVBCuZxYsA6QuHO
         1btT7R88R6d85rbD2MYxhdDlBu7aATvHj2M45IMy6gfupE2BAWVeaFxfqIG3Nanl5kNI
         19K3S6rUaaAej5Y3TqkWbmS9OO4ZYiYxDXscnI2fR2COyat9zHPdd11s68sHxqszFsxM
         YU5A==
X-Forwarded-Encrypted: i=1; AFNElJ+freNnZNL31nZx8viNzQ4CKL2csFOtQadB0+KO/ew7Zo0+b0YnJ7S5l/R/uRHKYTCpFJ7czkzIN0yrRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8FswQlN2Rj4hRxJEkvWYkrL1tjLqA3Iv4cISsQIZAb0a9tff
	/pM/QqApvLb+WCyrSUzG7Iiw15Sabq9nWx2ZhcMEDP7hm29zEcLooegLMcHRxj95m7nlgTUneIH
	oyx3dTEYu8g==
X-Gm-Gg: AeBDiesMcnttLqOTTRPsWu3a/At+dHSSFZVJ04qebeDVlt5Djoow7THPrFhIAlXFUu3
	s1uT+A8baUeediomqux8MCR0EchZ/knbmF2TIRjND+TADipJ/lldVmK1zuNiGoSBxcLzc/SC0pc
	k7bDzKJ22c6ON61wd6pEdEUWsU5fw/W8NvT1HAoENJzx5JTo9upTh0Y97z9RMbkFDnzxts7bANw
	wJJCj0muqxJPj7YIJ0WVUv3EUQsaaLcTyG12alEbiDw4ghA+3QUPS5+gamHkzT9uH5Oeny9POn0
	CYheeBr19fMWCoDSYVzE7P1tUS+/sfMH7OVMGPQm7hSwYVVZmZ0Lt7cbkCp4+xDd8xqzJjAr4CZ
	r0KsYAVcC1w4y8rDOa3PZhRxvTBGt9NAikO6pUE904irkbfGVQnQr7a7aiR8Pg8vPAlJMBZO7KN
	Rog/lzrTixofI5S41QG3iw9odtCINpewbYyFS3lxM69s82/kRkVCO3+lL2OqabROn4hZRlcG/0e
	UUo7+iK8MKK/b9XbczaTtpSTthaYkD8rFg7aITCRPuDeRnSfAc07N5FOXT74+W4h0IjTpBMHTEV
	URiJm8cKNKG4tDb327IZzlX9Lrql0TXHd9Lm
X-Received: by 2002:a17:90b:3b4a:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-361403d61camr43690659a91.3.1777306803667;
        Mon, 27 Apr 2026 09:20:03 -0700 (PDT)
Received: from [10.10.10.191] (97-120-253-104.ptld.qwest.net. [97.120.253.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410cc196sm33025839a91.17.2026.04.27.09.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 09:20:02 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <12a76d8c-344e-49a3-b168-6cd353d720a0@embeddedTS.com>
Date: Mon, 27 Apr 2026 09:20:01 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org,
 Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260424192534.3504976-1-kris@embeddedTS.com>
 <ae2YWxew6M03MFfN@google.com>
Content-Language: en-US
In-Reply-To: <ae2YWxew6M03MFfN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/25/26 9:51 PM, Dmitry Torokhov wrote:
> Hi Kris,
> 
> On Fri, Apr 24, 2026 at 07:25:34PM +0000, Kris Bahnsen wrote:
>> The workaround for XPT2046 clears the command register, giving the
>> touchscreen controller a NOP. The change incorrectly re-uses the
>> req->scratch variable which is used as rx_buf for xfer[5], so by
>> the time xfer[6] occurs, the contents of req->scratch may not be
>> 0. It was found that the touchscreen controller can end up in
>> a completely unresponsive state due to it being given a command
>> the driver does not expect.
>>
>> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
>> transmit all 0 bits, moving the 3 bytes to a single message.
>>
>> This change was tested on real TSC2046 and ADS7843 controllers,
>> but not the XPT2046 the workaround was originally created for.
>> Confirming that the original modification to clear the command
>> register does not impact either real controller.
>>
>> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
>> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
>> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
>> ---
>>  drivers/input/touchscreen/ads7846.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> index 4b39f7212d35c..599793d27129e 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -327,7 +327,7 @@ struct ser_req {
>>  	u8			ref_off;
>>  	u16			scratch;
>>  	struct spi_message	msg;
>> -	struct spi_transfer	xfer[8];
>> +	struct spi_transfer	xfer[7];
>>  	/*
>>  	 * DMA (thus cache coherency maintenance) requires the
>>  	 * transfer buffers to live in their own cache lines.
>> @@ -403,16 +403,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>>  	spi_message_add_tail(&req->xfer[5], &req->msg);
>>  
>>  	/* clear the command register */
>> -	req->scratch = 0;
>> -	req->xfer[6].tx_buf = &req->scratch;
>> -	req->xfer[6].len = 1;
>> +	req->xfer[6].rx_buf = &req->scratch;
>> +	req->xfer[6].len = 3;
> 
> Doesn't this overflow "scratch" which is only 2 bytes? I guess there is
> a hole in ser_req between "scratch" and "msg" but I do not think we
> should rely on this.
> 
> Can we also set rx_buf to NULL to discard incoming data?

Well spotted! I'm quite annoyed with myself that I fixed one pointer
use bug to introduce a buffer overflow.

Will send a v2 patch later today.
 
> [credit to sashiko].
> 
> Thanks.
> 

-- 
Kris Bahnsen
Software Engineer
embeddedTS

