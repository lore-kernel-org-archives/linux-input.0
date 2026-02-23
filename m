Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4437998C
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884354; cv=none; b=Se3QKIMq2F6Xgl91RumOtRTPwMJlTlVjp1vYlHHQkwQ1V9rrOsB5GjFhSLvFn+Pgw3bXGWmcReCimQLDnH/raqJWllkIyLbEe8Qi0llQVdKlfLa3QmWSA+JZHDR0dtDq6cDEnvB1MWSpS/L7krIrUg0OU2sD6LWGeooiegfM5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884354; c=relaxed/simple;
	bh=/RW3C3GCLfF8LHHANtlWIGVLmA4XTDETNrMduy7wdtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf8l8oJFPvl6B7gZASW5qrIo81C9V89BvC5+3hI/enUid2WOGkR/PvBE/SQJL9dxbHfC9xe3Ai5abig96V33cfg/ouP6P412u57dtx07yN7d9aDA5x/7wXIaNkxsmCJy6AFC6P5tbyEdz85Yjla1qF0JBYPiz9sKMIIPkKrCStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVpFLYMa; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVpFLYMa"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd3b0bc201so1416854eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884353; x=1772489153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xoqbvgAR8RAogXqq/JgcJla3JIoQ6jzYoKa5JPxEFM=;
        b=jVpFLYMafVr0ZNxcKy1uBAw3AM5wVI+QKeBvkRy03oqfjn8E81bvlY6kjns2zaWK+H
         5vN5th3224Tqr4+NLkuYn63Shy0JOx5UHJCeN97zsLKcCyJL+2/WTVyLZvdmiTnGc/1S
         Fh+Gf1WakuLkfZWuTVLLx4/ci8ruCbV9k0TfDnGWu0CQWVxpAHLWAOG4JFRyWNvhPxz+
         HAOiRQ5nfpVwICkgoa5Uoy+viXqfrKgN0rgMxWuBoodmx4Uy0FjxWu2Num9WTq3WDxDn
         OoXQnmB2AJbKttoR0TDp5J6ekstWzTzjjlQC0YmcMYxGMkNH4dkccOaN5l1kGC6RYt1L
         I3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884353; x=1772489153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xoqbvgAR8RAogXqq/JgcJla3JIoQ6jzYoKa5JPxEFM=;
        b=SnesJzc0N1PmivBevrAW6PqbIeo1Jt9w5aoZHUAtN2L9CT3HwW19ZCmHH0ftP5b8O1
         GBh4DP0LpZTIfbLpuGAnGngJ0A7q6do6xhC49/vuP7MWizh9rBPK0b2tQ2QleUJr4603
         zlKSPZO4zMmQwY5/HJiYRLPIMY/h85IfhxmH8GdHuloDmJa0qzjXhpbb4DQAUNb2WhBE
         jpzyiZbQWRnUVZgKzNnEUy+mUPOOKRaT60lZ2Zeuts71WC1JU/wYF3OA+ZjFvxKRCf8m
         X1yUjytbWBNA9dxjKlZ2GTrYKdtYu8iRNMeNAYV2enUAUr1z9CjOeNmIy5HNEkHBDyj7
         m2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUyW0QRKZDHztNpsBM89yX8g4LJzuGm5ntQ8NMpKH/Urfl7CYc7/RPvU6BsaeD9sHS2M49eS0bpYP/ynQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYrQdp9dNIuNIJcfRnFBbXexVEHZr7ZLH1neJ0y/ayue2v0KN
	psY1+anO4TqeRtvd5HI6f0NHg7BbvXsxGHiWJ1lltIuEifqfVniJ4+dg
X-Gm-Gg: ATEYQzyptXi1p7nsw58+p6MsATTm6HGFoKUBPq6L+XOl4te0sUmWIq8eayyED8NEpSt
	Wl8Ei89YENb1DwYV5gaSaGq4hpb0fx1Px9QS3MYk93W12cnKSp0NWivpoJaL3ddjT/6+ZzVA8dW
	buJ4P5dmD4LGiPP1UsAg7ga26MsJK2VpgycmQTVncgrgHJuZG6wdkqsjOFdGHEUEXWpHejc4wy9
	LDPH1nuXwydBmd1Um0NO9q7BZmwVUxe3WXQbf8bgwzz3H495VXLDzaOIGqEDj/LcS36q41AvE/7
	mQAID5r1hVrD5ekeDaeRfJsZAPQboGuEI4FZejQwsreSA1yC/dxJvEH0R0NJSQpb2TCS5aRoaWT
	XIfaw/MEkEQecCgqsY31rXrhbhcJyxPkmUOrYaZ3lTngLM2jWWez2qL2fa8aEaHkTWb26/zHvR7
	WZCdOBrDsotQaNwBJgIgEzG6Lgj9Xl34P5yssm/eM1fx+o4wUmaY3dv6i09SBNpGrEin0WFYm7e
	pf3Zt7kNzUpdNh0WG4pbcNgpusXoSJqYB8hxvOAVhH3KXiBEKjjdVw06z6Y6b9KoYRXRdK7STxy
	+PrMt1vDzxyPxVA=
X-Received: by 2002:a05:693c:3108:b0:2ba:6b88:d636 with SMTP id 5a478bee46e88-2bd7bd59e7dmr4326682eec.31.1771884352431;
        Mon, 23 Feb 2026 14:05:52 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:b343:b0de:3e59:4e65? ([2a00:79e0:2e7c:8:b343:b0de:3e59:4e65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa3701sm5263256eec.10.2026.02.23.14.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 14:05:52 -0800 (PST)
Message-ID: <1d63bb85-b846-437f-aae7-6cef18054f70@gmail.com>
Date: Mon, 23 Feb 2026 14:05:49 -0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/62] Input: synaptics-rmi4 - fix a locking bug in an
 error path
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
 Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, Nick Dyer <nick@shmanahar.org>,
 linux-input@vger.kernel.org
References: <20260223215118.2154194-1-bvanassche@acm.org>
 <20260223215118.2154194-16-bvanassche@acm.org> <aZzNSRIJdboXTV2-@google.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <aZzNSRIJdboXTV2-@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/26 1:58 PM, Dmitry Torokhov wrote:
> Hi Bart,
> 
> On Mon, Feb 23, 2026 at 01:50:30PM -0800, Bart Van Assche wrote:
>> Lock f54->data_mutex before the first 'goto error' statement since
>> jumping to the 'error' label causes that mutex to be unlocked.
>>
>> This bug has been detected by the Clang thread-safety checker.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Nick Dyer <nick@shmanahar.org>
>> Cc: linux-input@vger.kernel.org
>> Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   drivers/input/rmi4/rmi_f54.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
>> index ac4041a69fcd..fd57ebb1cb50 100644
>> --- a/drivers/input/rmi4/rmi_f54.c
>> +++ b/drivers/input/rmi4/rmi_f54.c
>> @@ -539,6 +539,9 @@ static void rmi_f54_work(struct work_struct *work)
>>   	int i;
>>   
>>   	report_size = rmi_f54_get_report_size(f54);
>> +
>> +	mutex_lock(&f54->data_mutex);
>> +
> 
> Thank you for the patch. Do you mind if I move mutex_lock() above the
> call to rmi_f54_get_report_size()? It does not extend critical section
> by much, and I think logically makes more sense.

That sounds good to me. Please keep in mind that I'm not familiar with
the rmi4 driver.

Thanks,

Bart.
