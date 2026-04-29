Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E473BB48
	for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443962; cv=none; b=NjTLLeJVaQ9yX89a1pXmBQPDVIuqXlvlW1F29jKENlxrfk8T6bjCBYWqWnvwqL3u2YLWyi/3sRz3iWNX5FmYzSIS3ObwQHsSV2UgIKHNP6tns0xqz0BvjzdOOdzBg57nmkUKINbxjs2oE0oDYmidtnMSinGWdTfm08U4sRem9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443962; c=relaxed/simple;
	bh=ZLqCgcENzbDmuWw3/IYd35vvgMiuLJTU1MiipLmd20k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q31UYysdcuRwIDGJ2Bc9tCh4MJ6N9or0Yz9YKj1O2VXdAui2YwNLBaP5eENuIdQ4hb+PeBGLZztm3y/YzJFhFSqAh+oAbGHLBRl0tqyKl995cl5oKRGepWDtHdn7ceXuwgc3+rb1jgidm3vRrJtLj3wgDWmBaDpqnZhPWD2L90Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rD/wOIKV; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD/wOIKV"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e4a04f059so15111235e87.2
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 23:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777443959; x=1778048759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2ra/cL6pAIpg0TWrgfpVFTftHGeLUpW/FdHh0Y70lk=;
        b=rD/wOIKV07LEVAVveADTEzjWT6v0U+cx/LMNkGGs/ja/pzLLc11fFDoQH27jTu8B7U
         pYBXEovjeTsq/St1r3vFQTDmbbQvx1AZFZGcPpv2NcY0xKy8NtwgghYAKkGxhI+bBgMG
         XWsZsv07pOskUzy5hO51VgDAIRwxSi4gFnTuXmSFrMyd76GtuJ7KKJP3rpYR9UTc+SU+
         0ATS0XEjBAwQN4U8YkLn8mfEBVot3bQYEF82wxfYaCMLWU+dUkCNHGl6XKDBbomfy6o8
         elCBrmATGoIIgxGt78cUiVz8JghI+bIGge0PYFrZOo6JAHONNSLkCw7PSVeuvMauMu5A
         5Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777443959; x=1778048759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2ra/cL6pAIpg0TWrgfpVFTftHGeLUpW/FdHh0Y70lk=;
        b=dbH2HLMLn4TTukiogGCMvpC+NocI5ExtEWcV16NJC6lFVR2xuQyJ53bixBTaqu36Py
         t35rhw33IRxx1H+evdiD6yYbIO/eA8IPseB4zVO4ObJpvZ3U4bqTnv/B3ci4OipCuzma
         nqRgHK0ceKJNPgCM02dtD5jGY9QPj4bIxS6XL188Lj9DQfJ8LGlik2m4xPN6qHjxcjmV
         bECtctF57741lFr1U79YbL34tM4JwurWqZNyKPb+V1smlpc4eu53J6tqAvPNx6OmaQd5
         MjtiyWa8UwchexHyeOfC0xf4BscKcmj+3wIgBpeVbQ8Ors4ZYrd2LAvrIdZXaiIVULQ5
         6X/A==
X-Forwarded-Encrypted: i=1; AFNElJ+9uYUQRP7Nv5DqBtGvvmnkbgOqvCLg2W3G//UrRl1JNlsi122UGGWjn+6qk6XJRNbfxOifccGf5eGZAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBV9OIjDJd0EHLBrfJb0jCqjYrWcvgImcWcZJ0OaQ8RR06Hkp9
	kwLDXpHQiNhQVlmZmYrdysEP5TMn2NJ+SdlnVZumw/nBDoO6xRsW3Xvc
X-Gm-Gg: AeBDieuzhgCIoRUblAm6Y3oajwgAvezzgSxB+HkVbap2VfBlnUsIXr4oiKU32E3Uo3y
	eWWWLkoadS7ttQOEpT4O9cmYmxg9NoAkZlZubu6KzWP++xYpgzHSyja+Z+jwC8qwlQYu5LBBNtN
	maxItud3A7lHv41S0hMmhI4Uf7AY9wu/iv33CDI9qjACWi6I3e3WYqGoGDBMLkmijfaEUhSJ7Uz
	ugxmyFQZM/RJu5OF2lsgKKDiZxUfgW7p73zeY+AtHJxa989LVbF7kXJdV2NHQBXZ8RhDR3N6Vcp
	cFVa3iER2ljbtyVqXchZQvpjPoEj/kfe7mW3s+xLXoQ+8N7d91ToLk/nr317mzEB1Q12UV1Nwvv
	OxqE0XWTybjkdeFQHxszHw1Z3//dTZxZPo786wPQ6i+gIpUZjltS6nY90FFihmXNAI60+KDZuec
	vPbL1bKIaFXXG3B5tfHbsKc96MA0cUIAHQqmPNEeyLbrAJYGyUj70vtGEZaludoGFsqRXLv8J5s
	dXMobmJYXYnXky3GyU=
X-Received: by 2002:a05:6512:3181:b0:5a3:ffdc:1d22 with SMTP id 2adb3069b0e04-5a74662a7e8mr2683695e87.36.1777443959279;
        Tue, 28 Apr 2026 23:25:59 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a74a773599sm278769e87.77.2026.04.28.23.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 23:25:58 -0700 (PDT)
Message-ID: <7a1bb930-da45-41af-bd27-9a10bd0c8be8@gmail.com>
Date: Wed, 29 Apr 2026 09:25:57 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] input: gpio-keys: make legacy gpiolib optional
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Andreas Kemnade <andreas@kemnade.info>, Krzysztof Kozlowski
 <krzk@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260427143406.3020992-1-arnd@kernel.org>
 <afAz-UQY0aCaThV3@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <afAz-UQY0aCaThV3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi deee Ho,

On 28/04/2026 07:14, Dmitry Torokhov wrote:
> On Mon, Apr 27, 2026 at 04:33:49PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Most users of gpio-keys and gpio-keys-polled use modern gpiolib
>> interfaces, but there are still number of ancient sh, arm32 and x86
>> machines that have never been converted.
>>
>> Add an #ifdef block for the parts of the driver that are only used on
>> those legacy machines.
>>
>> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
>> passing an IRQ number instead. In order to keep this working both with
>> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
>> the gpio number if an IRQ is passed.
>>
>> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> v2: skip the fake GPIO number passing from mfd
>> ---
>>   drivers/input/keyboard/gpio_keys.c        | 7 ++++---
>>   drivers/input/keyboard/gpio_keys_polled.c | 2 ++
>>   drivers/mfd/rohm-bd71828.c                | 1 -
>>   drivers/mfd/rohm-bd718x7.c                | 1 -
> 
> Let's see if my patches to rohm drivers will get accepted and then maybe
> we can remove legacy gpio API from gpio-keys altogether.

What comes to the ROHM drivers, I am ok with the "swnode stuff" proposed 
by Dmitry (if it helps with cropping some legacy). Still, from the ROHM 
driver POV, I sure have no problems with just simple zeroing the gpios 
and providing the IRQ which in driver side is clean(ish) and simpl(ish) :)

So, in case someone opposes Dmitry's changes, for ROHM drivers:
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
