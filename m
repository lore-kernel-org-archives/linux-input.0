Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4048A2CC
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998116; cv=none; b=QEi6aeBaf+KPWpiiS+SNTVaTpqmK4vVAx6zESe48CdoinY7B8p9SHajq82L4hVexhxVnp8b4anxmUqKdR1ps0juqv7dMDo4fTEQxrcKwjsccoGjOey+nIXaNuAEhRhCbKVgEyVqys16I7CFlEYf9iOLVXYdIHEhjzMFHF7LA+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998116; c=relaxed/simple;
	bh=MhVhqytDBsoXqrV7yikqRH2U/UkDGacf8smarcWqBEc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Im5IcAqp8u0OgJ4dLuS1B9Ve6CfaPgbvUyJev8EbmJR4TcvQ0yebBUaD25PuqsdVR/dtQh0PV2vZvAl0CJWpxwl1aOTC+oRiEbimXDqWbPrScnrJbGaQdQ3U4N2Mk9ieQ/Q53YtNUmIU4sQh+sZHrw1FbvaoLqCJNsQ69Y2VLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=FZn1cz7S; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="FZn1cz7S"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so6954973eec.1
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777998113; x=1778602913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AV/YmfGA78g8SATWPQgqplca6ENgzk/z9se3dsK0CGU=;
        b=FZn1cz7SvlGEETLWUcGy+QBY1LRaOujalecHshojAwoL2v5m+RKUrBUWRX1ZAMa0vo
         yk1lHtLNEmEVw8RjVuct+co/TuMyAkkzDKl12AH6wQSto+kUHuzk6XuBCp4oPFmOZsIt
         EO19/kJ1LT6dzPC9OZmcfZVL8W5ks3Hv5Khmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777998113; x=1778602913;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV/YmfGA78g8SATWPQgqplca6ENgzk/z9se3dsK0CGU=;
        b=kzPWlimhVzE4YsoLWIcMq0l4Bao67pgF8TaG1KKty/nDcagmxEI9lNrGAh+gipJXWr
         Gxr/YrMFen27/M3stlMibjS2Nm2lDnD1XbgS8wfpvd+Kk5Jchb0rlfQeY27IzGfyzuGE
         uA0xAzj0+zHtc4yAppXb+hFFbufd/1evDTFxcBi7Uf0xA1ba9GM7UAedJJJyMfBj+Z2Y
         JhpyG2TDC2IkIx5KfBdEpxQCtwkqfUzAIXy8tpzEiuEzvyOFzUOWdcr5mqOc4NZ+6M/b
         Tibkku78x7nTknTCM+GJKNOXaQoy7HccKk+tdNQVatmt0VMxi8hdxbBQE0vljqq/GziK
         Y89Q==
X-Forwarded-Encrypted: i=1; AFNElJ8fmz+zLZ8mFKiL7NhfTXdAJj1jujDz/r02gVyL1JFlGly3LWODkANDd4PoHpepbLR8HNX5iTqLeg2klA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoW4NNZOZgld/mMQV1R49/71dYJAY/1OzR3s82wYgdkuWsPTpB
	JhIe0YeDZiCpupW9/XXAsD5ZkIqZHap5o65zQ4HGjfSCMy8XAakRHhe3uAJ0rVpc7js=
X-Gm-Gg: AeBDietSRKIKxkppqf21s+j4blfCa9xteH7pNSi95xtpY/5X0SxTmAmCrp5Co6lXlON
	h0VUHJMRS38MGAuUpZX4Og9Y6eE92mDf5verd7ARoILcaiEb1ZBeOCvwGe8Z6xzD3VbTVerXeBE
	4l4eKJf8632bHMEZJigdEhTt6btLB9BowYa9CYIhSnkeY3eiECUaBRS+y8NFsSwanbYxDZDktc2
	WdfDOnyShaMPcQWZAs1yz6bJyiUT/qhXU73jDEDQBXwRlTEe6iFBux+HM7ESHoGFTWUqks0QkLn
	k/2UHvbxEQPn09C9WZnf2+n6vGFMyeyKUwT92KdS/csDeHIhoqlKiRQbBMNW2snVCGYF2ipE/1d
	Mkzoe9N5X8VHgxVHaZ19j/TEjtArWLNsWzf03TxzNdbi71mPeVDhUuLAVFqoAZniqJrjh5mGmj1
	eZV1qbOl1aj3V6b8PtpYpJpRWy68wSmq7bcnnAGf6BMcIc1cZqDmvOkDs6zsTVbEjOSOqq65NOQ
	8KQEn55ByAaktTQW62bF4Shr59bMhjl2j/rxJcTxqP58HThFMDq8QZWKQS7qpona8pVAnSwZQUb
	91IFgk6kQXtPUv0=
X-Received: by 2002:a05:7301:3d06:b0:2c1:7793:7bbb with SMTP id 5a478bee46e88-2f409cb094fmr1796691eec.27.1777998113220;
        Tue, 05 May 2026 09:21:53 -0700 (PDT)
Received: from [10.10.10.191] ([184.3.231.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2casm21012701eec.14.2026.05.05.09.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:21:52 -0700 (PDT)
From: Kris Bahnsen <kris@embeddedts.com>
X-Google-Original-From: Kris Bahnsen <kris@embeddedTS.com>
Message-ID: <c49600c3-a78d-4d74-82bd-7f95328388a5@embeddedTS.com>
Date: Tue, 5 May 2026 09:21:50 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org,
 Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260430173739.3843425-1-kris@embeddedTS.com>
 <aflcL6y_ugHV5p8s@google.com>
Content-Language: en-US
In-Reply-To: <aflcL6y_ugHV5p8s@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dmitry,

On 5/4/26 8:01 PM, Dmitry Torokhov wrote:
> Hi Kris,
> 
> On Thu, Apr 30, 2026 at 05:37:38PM +0000, Kris Bahnsen wrote:
>> The workaround for XPT2046 clears the command register, giving the
>> touchscreen controller a NOP. The change incorrectly re-uses the
>> req->scratch variable which is used as rx_buf for xfer[5], so by
>> the time xfer[6] occurs, the contents of req->scratch may not be
>> 0. It was found that the touchscreen controller can end up in
>> a completely unresponsive state due to it being given a command
>> the driver does not expect.
>>
>> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
>> transmit all 0 bits and use the scratch variable for the rx_buf for
>> both the 1 byte command to and 2 byte response from the controller.
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
>>
>> V1 -> V2: Don't use rx_buf when clearing command reg
>> V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
>>           output on xfer with len and NULL buffers
>>
>>  drivers/input/touchscreen/ads7846.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> index 4b39f7212d35c..488bcc8393293 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>>  	spi_message_add_tail(&req->xfer[5], &req->msg);
>>  
>>  	/* clear the command register */
>> -	req->scratch = 0;
>> -	req->xfer[6].tx_buf = &req->scratch;
>> +	req->xfer[6].rx_buf = &req->scratch;
> 
> Sashiko (I believe correctly) pointed out that by doing this "scratch"
> is now write only and this may cause DMA from the device stomp on
> message status and other unrelated data that shares the same cacheline
> with scracth. While it was already a problem before now it is even more
> likely.
> 
> Since scratch is now write-only I believe moving it below "sample"
> forces it into separate cacheline and fixes this problem. Could you
> please try making this change?

Apologies, I'm not quite certain I understand what you mean by
"moving it below sample." Do you mean relocating the xfer[6] block
immediately below the xfer[3] block like so? If yes, I can get this
tested and a v4 patch together. If not, can you please clarify?


diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35..6d57865ff505 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -390,6 +390,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
        req->xfer[3].len = 2;
        spi_message_add_tail(&req->xfer[3], &req->msg);
 
+       /* clear the command register */
+       req->xfer[6].rx_buf = &req->scratch;
+       req->xfer[6].len = 1;
+       spi_message_add_tail(&req->xfer[6], &req->msg);
+
        /* REVISIT:  take a few more samples, and compare ... */
 
        /* converter in low power mode & enable PENIRQ */
@@ -402,12 +407,6 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
        req->xfer[5].len = 2;
        spi_message_add_tail(&req->xfer[5], &req->msg);
 
-       /* clear the command register */
-       req->scratch = 0;
-       req->xfer[6].tx_buf = &req->scratch;
-       req->xfer[6].len = 1;
-       spi_message_add_tail(&req->xfer[6], &req->msg);
-
        req->xfer[7].rx_buf = &req->scratch;
        req->xfer[7].len = 2;
        CS_CHANGE(req->xfer[7]);

> 
> Thanks.
> 

-- 
Kris Bahnsen
Software Engineer
embeddedTS

