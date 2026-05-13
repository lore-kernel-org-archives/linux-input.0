Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F034218A0
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677032; cv=none; b=HCHUUjZEmJ48GZhBHK2H0zOpAtE5lTdEgEvtE8bABrdDKXS20rr/nRp9MC+mKLIvFzCVaz6ByNtMB01xP/9YKwfI2oiFnXiwSGA7dHmAnfTI9oLr2RFnJetixK68GzdnQqP0x2EyiBlNTkW9DMdPkZk0NobsTXdw9WZlwghtB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677032; c=relaxed/simple;
	bh=ulkEU77Lr6G9FUC/CkjTnF0+9fh24WSxuj4ionvINrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3UigrEoWaRWqKpCs5FWFYHR0XFVj/nYX26YVAE9AqC+6M9KmyYQgUb6pEX8UW5XCYeLhNXprlopHPxlvxdGeWYfJYiSGyajHKipD8gglVeVWYGcW+E2TClaYP9RZxY8ywM+1BrFi5yINFrvlJeDoj0SsCrsqYjvdvoCbyhEHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDmayCmh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDmayCmh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d880e6fbbso66561571cf.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778677030; x=1779281830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBgHfKp9AbQguQz3ct2uzrlSAVjnLko10ZbIJkSr5aU=;
        b=IDmayCmhMu8yhuGnNAtH2+2sE8M9+aIRqxHTW+xlcv3H0MYhjDMAJS7aDhR9+/iLlI
         t9hMBdbPHPjJSUMJ1QuiLv4gCoV5Wg54E75eKAqhg+ZPX3sc3HCHcTnHHNQWpht5OKeh
         Md+9ysfiaYeH2NzJ1uJVox6ESqeeeLFB1Rf721ue3im/NbDOsstwJ3Ua+VHdFYQYNS6b
         KtdHeoaMqWH4kJFE92+itBiKGPv0WW4tXyb6m8X4pg9Fk8/zFE9IXzyzcsxZicDPmCtT
         juyXXwjrDDGYR7MlZK3Y27oANF+XxW2IxD7NVYjv+UsVjBPNm4P6/6EM/J2fr0iJ56KA
         Dv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677030; x=1779281830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBgHfKp9AbQguQz3ct2uzrlSAVjnLko10ZbIJkSr5aU=;
        b=qtvP8KRdcsJ4l3VqBgHqD4YZqCmYEHPn8boJaEPauZk62YxFyULyj6PVJC0MO3nULP
         YOPysrg7s4jLCri2P5S9YOOhoOXjvE4jwanIG3RrKsE48DyY+gbLNOvu6Cl8Yw/ng4np
         Mg2CO2d7st4YGpNFDEbL6eKlOlydVzbLYoEykRwjNvEm2NrPzRKNNoLkSu3yATQCu95R
         BrTNCwmqPxNPmJ38R0gkSgt4ic7bno6wzMEXZTJovIhpheTgNPgN6RV9q7+tTVQTDhs0
         9kbNoOXAOFDIIJEUf9og6dI7q3qYJgZJ/uZsmWSuopwNZw0KglPsexKsE72gtG+A5JK5
         Ex+w==
X-Gm-Message-State: AOJu0Yw3cATocmcz9MKwuo2JicHeta8CFQENc7TdsVNdr2n7XCfD3uXA
	x9OR2q5E1O+ioqABE7eZ2eB8D23JPeVVC7yEh1OZAAGuPqFh/F09wffl
X-Gm-Gg: Acq92OG+V/3Ur+FyZCkbNAqRqhW4hNyEjPTkOYQf65+VR4VR+e+tSgMPEaWI9NYy41E
	qg1WzSS9L+zSpI4mNRrCa/CkehHw15YOcJvMA98nm4JIxsJOihsuBIGoJcwF4E89mBswfk1KS2y
	xIPXLEfwjH8KZa45TxxvMxP5ahTPVy3tEqtDSFBiX/OwTRS+QmZ5599z6q5MScb/TlvqOM0OX2y
	0Xr8K+kijodcQTdi4KMVXeNSomTTYruPI4KXRMjc/fKgKnEEUjImxwgRfRjB7/Fzk/LhYvBLx8b
	BRk/mOGqAlHGpI/81pkXO7Yhpv/obUjCHubufcgQmnen6LANveWWElEYbbkqFwhQEjh5bs6i6uA
	9874yMiBx4clitafTWKItbl7EQMny6fB5w9/izx+ojqoiBaBVTsgvsyoNcx7pjrBO9A/43S7ozE
	t0fBdAXAgba3l4vH6+XkLP+JxXB+wrjuD57Q2ZkFaT9T+zwvfxu808wSm+iOcKA6Kr2C1Q9wjDi
	g==
X-Received: by 2002:ac8:5804:0:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-514cef5f533mr99666831cf.14.1778677029747;
        Wed, 13 May 2026 05:57:09 -0700 (PDT)
Received: from ?IPV6:2600:381:240e:1495:ec49:7390:6c45:8623? ([2600:381:240e:1495:ec49:7390:6c45:8623])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e3d90sm142912671cf.20.2026.05.13.05.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 05:57:09 -0700 (PDT)
Message-ID: <2ab54cc0-3c80-4d09-8ec7-639385ff2ed7@gmail.com>
Date: Wed, 13 May 2026 08:57:05 -0400
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: multitouch: Fix Yoga Book 9 14IAH10 touchscreen
 misclassification
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, bentiss@kernel.org
References: <20260402182937.388847-1-carvsdriver@gmail.com>
 <20260413125803.46792-1-carvsdriver@gmail.com>
 <364r776o-6771-o29n-8ss3-857n32071op7@xreary.bet>
Content-Language: en-US
From: Dave Carey <carvsdriver@gmail.com>
In-Reply-To: <364r776o-6771-o29n-8ss3-857n32071op7@xreary.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It's pretty rad.  Have one more patch coming in a bit to fix a trailing 
ghost touch issue.

On 5/12/26 11:39 AM, Jiri Kosina wrote:
> On Mon, 13 Apr 2026, Dave Carey wrote:
>
>> The Lenovo Yoga Book 9 14IAH10 (83KJ) (17EF:6161) firmware includes a
>> HID_DG_TOUCHPAD application collection designed for the Windows inbox HID
>> driver's Win8 PTP touchpad mode.  On Linux the HID_DG_TOUCHSCREEN
>> collections provide the correct direct-touch interface.  The presence of
>> the touchpad collection causes hid-multitouch to misclassify the
>> touchscreen nodes as indirect buttonpads, leaving them non-functional.
>>
>> Within the touchpad collection:
>> - HID_UP_BUTTON usages trigger the touchscreen-with-buttons heuristic
>>    that sets INPUT_MT_POINTER on the touchscreen applications.
>> - The HID_DG_TOUCHPAD application itself sets INPUT_MT_POINTER via
>>    mt_allocate_application(), propagating to all touchscreen nodes.
>> - A HID_DG_BUTTONTYPE feature (report 0x51) returns MT_BUTTONTYPE_CLICKPAD,
>>    setting td->is_buttonpad = true for the entire device.
>>
>> Additionally, the firmware resets if any USB control request arrives while
>> the CDC-ACM interface is initialising (~1.18 s after enumeration).
>> The Win8 compliance blob (0xff00:0xc5) and Contact Count Max feature
>> reports in the touchscreen collections trigger GET_REPORT calls at probe
>> that hit this window.  Surface Switch (0x57) and Button Switch (0x58)
>> feature reports are sent by mt_set_modes() on every input-device open and
>> close, repeatedly hitting this window throughout device lifetime.
>>
>> The firmware also leaves a persistent ghost contact in its contact buffer
>> (contact ID 2, fixed coordinates, tip always asserted) on every enumeration.
>> This ghost occupies a multitouch slot and prevents KWin from seeing a clean
>> finger-lift, causing stuck touch state.  The ghost is cleared when Input
>> Mode is set via HID_REQ_SET_REPORT at probe.
> Oh man, what a device.
> Applied, thanks.
>
