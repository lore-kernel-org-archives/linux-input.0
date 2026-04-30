Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D233F597
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568100; cv=none; b=Ao48UHF7Q1BCvQ9Tfg3Q2mDvkPrz/DXoxl7Fb91IJAcDa1BuQayNjjmkamAOnd2hiGE6zYZsIFvmFGLMs56phTnCLwZIKgdsy1S/3dntM/8EWD2xkpFrUHIPAUM4Rm17KbQadNRvU2jANMZwWrAGjqvLex8q3+DvE2gWVPMk9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568100; c=relaxed/simple;
	bh=eUBp07JKTe82zy1ykUrgvp3E6cfoSBuBKsp0BQUA5sM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m96x01vP46S0CjqOakXQRGC13unWCxGzNAkiewS6Nd4qH+h/H1eHFW7DXynf0VgU6wQmkZc5d/tm3U/rcw3y7YdxyHQAMtRGeDj3Y9zSjOso3NmZLwLcHFOD3LZ03HsVZXbXjZG4w71awgAFnkOX9g09GOUMaghFPw4xF9WJLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=la+T50yT; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="la+T50yT"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2d96243c91fso842034eec.1
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777568098; x=1778172898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nSw+yolZYnlsfqzqQJDRiH90jYV8jI3JvmhNU4UgfQ8=;
        b=la+T50yT46UYls8wd9vBo9pXd4/tj2bcTxIu4bambdQoDJPCPZ2egjDPqeAj8oYlX2
         gHz7qwDpPautLnVmijMOK/HbbhxbPTpc7NbGGlJSAdyt0ZjyPlIt60+/E+yQ/6giPD9i
         VNk3JBUvvf7fWlVmW5DXSdf5FqqtO34OhCHyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777568098; x=1778172898;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSw+yolZYnlsfqzqQJDRiH90jYV8jI3JvmhNU4UgfQ8=;
        b=an2kU5PN4pqjB+pZ3MaSOiffcdILBYfIvRgggrI3/ABnTBs9lHeVt4iDoAU5lX6a3d
         MPeizTKjAzoSy3CFgHp19mQGPPD3m02NK2BWnskpweGJKhqL8SbtXQzRamAP177tvbFy
         OHJ01ygizeZWeYcZ9LACCJxXKRltd7JSUxzeFR1BnfIwzrRAYBegW43eGpxsE2haLU8Z
         /9lnk3sKZ85rT+M872oJUlNBedcsj2PHMeRYI0iSZ62sO6TJjQOgWKwz9id6ajw81pA4
         C8+B36KsyKWWhw4cj5TpW5rZpE0xIahl9STKsz/cauG2v4noCsrHdNQoO7dyzk1JXxW6
         t/zQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pbHhAJcPQ9rOxtPGwfmi24E4caLlHF84OEcDJJFxdxf3XBarZSYOaiOTW19feFhtWKM2Sjg/2hmNZPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy/MxdmtLN8YWymRsnw+bWdIkAZha+Bvsymsiu8h5CFBLwmRVQ
	fjDNvLByx2j1JyqHT6UiM5/lDoIvmaqqBZCPNb216yPnZMcBCznA0Dc1LDl2zMh/EhY=
X-Gm-Gg: AeBDietqvr7UaRsPaWJj3BiDcOCVQz6GkRwbcBMMP9OhNe9wtuU/v5fJfdGJb8MOBXq
	XhlFv+NuMihTPTaumgBds4xgtXJEl7tvFzMLh9wif4n8Cf8n6KzW6BZz6iC8aZCAdzDcaxoz1EU
	iWGCIi5Mr6iZPXBoLZCrWQe10KFZEtV3vOn/MdOguasdJ20HWqhqLxYiC1eT5C/FJ3UQPc+f3zj
	JSqzQ+CbdF0ruxn9KMPM1Ce02urfoFpxk85rsjL0g7uP+rZ0MuAR3lmBHMFhi5VoEMXpOLg+D+0
	4s7DOAHtZYF8e5z9JaUhEn4BJDxJ7orRknyoZkF0BshNQtUd1sqQSRX6wxsGc6T1NLh00fk2Waf
	oyRRnXGJx/Uglvjeuf3kXPK6r/SN/0i8GeT1s18PgfKYeaBEr5hsapNKlqIm5Km1iyBrUt3aTqn
	urtFOBw7NozJfQGv6bba/ITprlSyEhs5DsgYIny3guxRSqcETMo6v5B+5gyWAxrT9KDa893QhyZ
	hUL9s2qEYCv61DEpCWzikzEUyXOtgOzXlIHbxYhm4yVGdPipunxy3bdbJ/4mNuViROwfEKDLUhv
	c0XxAgAL6hLwAKbAR4wW41BnTCtOqfmk9qqk
X-Received: by 2002:a05:7301:6508:b0:2df:7b88:a1b0 with SMTP id 5a478bee46e88-2ed3e67ba53mr2079292eec.27.1777568097436;
        Thu, 30 Apr 2026 09:54:57 -0700 (PDT)
Received: from [10.10.10.191] (97-120-253-104.ptld.qwest.net. [97.120.253.104])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b11fsm553662eec.19.2026.04.30.09.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 09:54:56 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <271d8aeb-1159-46f3-b290-31b6e094d8a0@embeddedTS.com>
Date: Thu, 30 Apr 2026 09:54:53 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org,
 Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260427174657.691272-1-kris@embeddedTS.com>
 <afJZSCXeoSO502o1@google.com>
Content-Language: en-US
In-Reply-To: <afJZSCXeoSO502o1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dmitry,

On 4/29/26 12:19 PM, Dmitry Torokhov wrote:
> On Mon, Apr 27, 2026 at 05:46:57PM +0000, Kris Bahnsen wrote:
>> The workaround for XPT2046 clears the command register, giving the
>> touchscreen controller a NOP. The change incorrectly re-uses the
>> req->scratch variable which is used as rx_buf for xfer[5], so by
>> the time xfer[6] occurs, the contents of req->scratch may not be
>> 0. It was found that the touchscreen controller can end up in
>> a completely unresponsive state due to it being given a command
>> the driver does not expect.
>>
>> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
>> transmit all 0 bits. Also set rx_buf to NULL because the value
>> returned does not matter. Thus moving the 3 byte pattern to clear
>> the command register to a single message.
> 
> Unfortunately my suggestion was flawed: I think this will flood the logs
> with "Bufferless transfer has length %3". We need to have either tx or
> rx buffer :(

Ah. I do see that dev_err() line in spi_transfer_one_message().
All of my testing up to this point has been with an SPI host driver
that implements its own transfer_one() operation so that error
was never actually reached.

I'll send a v3 today that reverts back to the two separate xfers,
using scratch for the rx_buf, and then NULL for tx_buf. That
sounds like that should be the path of least resistance.

> 
> Thanks.
> 

-- 
Kris Bahnsen
Software Engineer
embeddedTS

