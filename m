Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB004438019
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492179; cv=none; b=jHE9wn3pQhg0gfWjhp2TQfkLbJfGNzmlykRpUnEDhPqfBV09JkSLlZwsjFejryQYP/k6N0mxycdqUawvNLQtlcwQxdRet5sJpKjkvqBQr7JwdJmcHmgBVYJ8ykezRImHM/4SzWzOThVxeDGkGrZBoui9Z+mnFkT8XJDAW80MrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492179; c=relaxed/simple;
	bh=C3zoy/9VsAfZabk3hbv9KlBEnMZNR9UmRIwAl2VpG2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxgSJBHrMFKhwQYyJ/wAJPP+Iu0qKxiCfIBN/cJ64Dd15QeOvXy7JUtUU8TPE2/8h4RinQIR4fh6+QnapDSohgJOTePbt81sB1gErRwn/wV8W5Bj/2/saE3K/vAtjxvOJ9GNz1EvpUDznJpSfsQGcSf+3HglJG3BtgbD9N1Uz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwxGMjyO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwxGMjyO"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd77300825so165435ad.1
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492170; x=1790096970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7mmyqxL4Ir0d/CfwYClhfzZRHAjxnBiwBulaRxIKo8=;
        b=AwxGMjyO3w0ZFJysg9WSkLH+6ScUYJLSO1aqzkesrvGqdRERTAOvxMEVSrfYGrnXuj
         zjT1DITrCJ3WHAmiEXzPEhJuCAjRcCPAxHDYhbNr+u1tgDMPPuZh0k7SYk8hVPiF1waK
         FBrMYG8wwmZ5T9guURYeM6x4tlrGn/zbr/EKeenrD9y+4M3ZKczwRjfLKX+Rq6JfD3SN
         9DJnmNrdPMXoMq66qyMywYz/J6rDZVcDZTMfNSBW8LGiZRJreXiDg3ip+nS1KzO2YSeC
         INMr5rc+06I6bStcphKGh+oa0Qds0E/a+VVj5wvaxcEQrT37aht2kuAiAcmoYCXTuMEj
         oBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492170; x=1790096970;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i7mmyqxL4Ir0d/CfwYClhfzZRHAjxnBiwBulaRxIKo8=;
        b=szAfvA9XuC99EcBIZ1erlL8Dn0P2k5OQXH5XNbmYlOmt8sU5GeZpXpCtlH99tuN32C
         rmIsuXbkokCrtFT/qch5ollzxfik66ua8dMehgzpMIU4BfA4cEN9/xPhF3DjWnbW/7Mn
         xZkzfPv0bKT9QI+KiNBGF+RfjuknLyzFZhX/J4ckzakyCtwum991dCsi9fDfg5A9Q1Tg
         KdKotqqOu/ibTiSLfq/GxgB6Pkp6L7dhd3sNgBplSlUlT7Q09iyDttBSaB5w5ClpMGt2
         mpRXrGEeQt+Fx68gRGMUxrDy+1tNlACuOQJ4WuC7YeCu46gr3W2E26/j/rxV3IzpPfLN
         xokQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0/2jaGZcK+9P64mMKhas772Ooe0OjNxR5e9bEGthxiC7xfzggSMpZmUjdtlGGOewMfCuxZSneth4R4Q==@vger.kernel.org
X-Gm-Message-State: AFuF++ncbFD9xgfVIlt1y/le8LkjYdkmiiT+NHXj2zyPYa+4HP8wkm8Q
	xMIcp70ug8W3DCj8onbEoyMhFH3TlR44ZoddCndumjFUlf0WGUCHPfaB
X-Gm-Gg: AYBFou38TO+qxRyAji/FVmb/4IGTFq0IfLEyKoW+5kYLGDNIugu6xulf4oSQeoiRrna
	Rsutlvjr/aJYl8xB1MdTCgkkcvWSF5jEC8NIXtnT/z24kzdCNTcSr9L+OV+HybPG1jfNDY/yvQM
	wSWZIb5PU1DZ7Kgjf+2q3zYYGHEC82FRh+PZ53Es3xM2VSQQSRaUnsVFstXOmdLL56dLIeEML0r
	bLb6dgFGF7ht79857eY5d4ZpYB669/ZJmcvSvxA4mwEUtieN2XmtlvWo9E8VGGF2UJJCOVkuQrY
	9aTAvWMPSar6Fr+uHE3li2mPRGwSbQPPJ6/pq3gwtX2g0AmfdSYztbS6ZbFPCsWDDSGZfuOi+0W
	W8LzHBMDsyHOySRLkh/wLzPFZ0Yki5bJOZGE81Jv59Tb2rdNccmKMpP9J7eAyYxqL7AEwHBcj6N
	KireTszcXpytyTncCzhkBv4INOBmab8ZGHkdH428v/xfvporrU67uW56WmD5M5C2lERNyQPKqEJ
	ECv/sgQkiNegQCdg0Ms5lOJCH0Zq1XrBOf3HIESQVK5/5VP
X-Received: by 2002:a17:90a:e7d2:b0:39b:92bb:9ef0 with SMTP id 98e67ed59e1d1-39dec0bdc60mr15161562a91.20.1789492169910;
        Tue, 15 Sep 2026 10:09:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1a033df0sm58769a91.4.2026.09.15.10.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 10:09:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d45d4de8-6925-40ad-a5b7-b8cef6356175@roeck-us.net>
Date: Tue, 15 Sep 2026 10:09:28 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] hwmon: (aquacomputer_d5next) Add AMPINEL support
To: Vas Zayarskiy <contact@vasily.cc>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, Jack Doan <me@jackdoan.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20260914233728.22725-1-contact@vasily.cc>
 <20260914233728.22725-5-contact@vasily.cc>
 <a968a02f-c513-42f0-993f-ede4f785025c@roeck-us.net>
 <ICzeTYsqVwKewqbj_Gv2WM93k1Kr6uygPhcTJ3M8PBtvmoV3AlfEnRWAspP-fQgdmRW4IR1OPPpDLhmQiIqEAh5OuCKvwRzxAHSO-7rnYAQ=@vasily.cc>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <ICzeTYsqVwKewqbj_Gv2WM93k1Kr6uygPhcTJ3M8PBtvmoV3AlfEnRWAspP-fQgdmRW4IR1OPPpDLhmQiIqEAh5OuCKvwRzxAHSO-7rnYAQ=@vasily.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 22:29, Vas Zayarskiy wrote:
> Hi Guenter,
> 
> Thanks for the review. I will add the trailing comma and separate the shared report validation and handling of an unknown firmware-version offset from the AMPINEL addition. I also noted the -ENODATA and conversion/scaling wording corrections on patch 2.
> 
>> If the match function _is_ needed, the reason needs to be explained, even
>> more so since this may impact USB_PRODUCT_ID_AQUAERO.
> 
> The requirement is to keep AMPINEL's keyboard interface bound to hid-generic while the hwmon driver handles telemetry. Both interfaces share the same VID/PID and match aqc_table. With the existing __check_hid_generic(), that ID match is enough for hid-generic to decline the keyboard. Returning -ENODEV from aqc_probe(), or rejecting it in aqc_match() alone, does not make it eligible for hid-generic.
> 
> The Aquaero collection check rejects its non-telemetry interfaces during probe, but that check alone does not establish keyboard fallback to hid-generic. V3 leaves Aquaero's collection filtering in probe: aqc_match() accepts it subject to the same generic-driver override checks the core already applies when there is no match callback. I do not have Aquaero hardware and have not validated its keyboard behavior.
> 
> The matcher test demonstrates the AMPINEL rejection with the original hid-generic logic and passes with patch 1. This is a userspace harness, not a live kernel fallback test. With both revised modules loaded on the physical AMPINEL, the keyboard registration/capabilities survived hwmon reload and suspend/resume, and its capabilities were preserved on reboot. I will make the matching rationale explicit in the next revision.
> 
>> FWIW, the raw even can happen prior to this, which will result
>> in bad data. This also affetcs other devices supported by this
>> driver (and those with fans can crash when it happens).
> 
> Could you clarify the path that permits raw_event during probe here? I checked the series base, 46fde107b4e881f179bf02bca69d8a0020561b3c. include/linux/hid.h documents that callbacks are blocked during probe unless the driver calls hid_device_io_start(). In hid-core.c, hid_device_probe() holds driver_input_lock around the driver's probe, and __hid_input_report() returns -EBUSY when it cannot acquire that lock.
> 
> aqc_probe() does not call hid_device_io_start(), and neither hid_hw_start() nor hid_hw_open() releases that lock. My reading is that normal USB reports cannot reach aqc_raw_event() until initialization has completed. Is there another path that bypasses this protection? I have not reproduced the race, and would like to understand it before adding a shared initialization fix.
> 

You are correct. Sorry, I missed the part about callbacks being blocked during probe
unless hid_device_io_start() is called.

Thanks,
Guenter

