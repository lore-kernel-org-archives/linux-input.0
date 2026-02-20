Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009D32B99E
	for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771562027; cv=none; b=lsXDANK0KLekn/PQvb+C4KwiIZu3JH4JFKA2T8T/pKvB163GLZNTu5uiTQNlLv2lPaTeVnNyavGSakCrVgA3Hnnim7BrvhSEersiUfqf5tz5iAufbNVErCHawwg3eLeDUwEGaAgL5LF44TVP3dvszxAw6oU+5iqPIYnZpTeo5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771562027; c=relaxed/simple;
	bh=cqQX4otJwlu/EBzCiT+EMmNhTOOeWS2QSPRS41i3ge4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFUHtTh3REYCnAjiaT8/+RvRXfnYU+pH+ea77EvRT6xxcs/iKxZqHjZl9vuagx0ZifiClLc+8tz9XlnUHjBWQSW7/gyyQg++iFo5EC9kmN6VTg9Vdc6yZrI10APjGFhYNlBcgBI9fou2U+j14TRV4CzLpcQRsr1yeHEkKhLVzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiSu46Pk; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiSu46Pk"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233bc1117fso1481441c88.0
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 20:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771562025; x=1772166825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vNvTcmQCYkNV3OvuP9WNSN7cpBfsnIcgezoEmqNLxoI=;
        b=JiSu46Pkj6G4vnhbM69k/5pC7eHg/djAItnoqwQuQ6AKlvPB1cNg39kANI4csVLpTS
         LLGZE1tRFWaj4AVh2FPq89e++l1eJ/D4ll9gah/Ky7BklBhcLVnvgBgZ9Xg8QIHm+6ur
         RbdvjsBQCIkorc3zUcvye6Vo5gKYGYEh17ryV3kBvJpy8SDvTIYlKdTrBxcSvGVeqRZi
         we/j2mnwaR4z0zB9elTunG2Uxytcy4oMOTF2aktynK7ez/o2dax7wowThRfpRuWdw+Cb
         sMWmQy3Dkf/ry2pP0yKTpNaUwVIxTSW3L4Ult4r9vGOoKJINjTd+F0m/cffjP8l2+ByI
         qVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771562025; x=1772166825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNvTcmQCYkNV3OvuP9WNSN7cpBfsnIcgezoEmqNLxoI=;
        b=FjTugkJPERslUCkaTUhGioMtoEY/X80vczV23rCHSsSu1QI/hk8Na8bWwcv9UW5Vbz
         HZZ8BNV1arco9rpvCXm9SX1lsP8NIp2rChBtDy1jVQJfjCtJjHSEtmjtUrQ5PrWqqLDL
         Z0tYwytowfo1p3p0wwcPqHIgBtSVnLc131SAOQydWaXvhY6tus36J99eU1SNAGfWLwoK
         YzGMk6zroxTqAtkazf/4jvcAutxFyzIjgMKJw4UcT2byQaAFWn1iKA/4ALz5q0fHddYL
         rwfuHHAqUzJ0NHM0IzqWMt64xNRQsbrVKK0yo5ZIq1TFwTrE1qeOiZYladdxFACCUAy2
         cmTA==
X-Forwarded-Encrypted: i=1; AJvYcCW/znmZuO+7OQdw88CoeAyvuOMdyiJ3VMZ7gMuYi2mE5Lt9M4xnSQy56m73ZZPzNj4l2+aiyk9ah2xKww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//qm5AL3YoE/CUrSri6YQYaMLW7Uc/BLH63UGCysg0ms1xg+m
	4TBgKvPK4aaN0+HrxxYaf9fwHAQHDjCexa6tcqV05bX8U7IczrLV9me1
X-Gm-Gg: AZuq6aKZ2JOH7PSDt/+FM0LVSqMt+TkeoZ9MBmvJyMtzWXGHljIY+ZOlDWboiba38cw
	dbZBmpLORqElIK1IZDlesew/CGO3K+mIuShP0H1MgywpQZ0zWnuCFUGCQgKsNdu3hLmzeMGwQnn
	QtIi+v9vtZobnQnhDtkWnopwTFCJwhlHHfMm722GAV7cXXVCGrERH2zsk5gtS2ciEGDy30Dh947
	OiIrRa/66LHn9eABHNO5KPRJVuolfQyw4InziSDMnz3Yxvk9S9vTsNxktciknLPkNIOaBauGHFD
	ajQt+JbTYHfRPnTrME6v2ADTSSFdWdP1te5yDrGasXE4tLCJd0EwmNTB1PKPBAohmkO3rQXweH7
	JIWDUEdBHMvCq60pCwH3VKjxwZFKls8N1xY+9bq3fWkkJkwiNDHjvBysAUNq2BuCey8sb9LGwai
	n7tUPHQy+0l09FvzaOLS1bwQQ06aQNwuDsb1lawbbHWEj4CjD6HapjfU2zP3fyzAcDLpK0lnB15
	77F0A==
X-Received: by 2002:a05:7022:1602:b0:11f:1e5b:2dd6 with SMTP id a92af1059eb24-1275faa7f90mr1954175c88.17.1771562025308;
        Thu, 19 Feb 2026 20:33:45 -0800 (PST)
Received: from [192.168.68.65] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc83e6sm24382881c88.15.2026.02.19.20.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 20:33:44 -0800 (PST)
Message-ID: <1ebc2e1b-f1aa-4559-90a0-feb628d5bfe1@gmail.com>
Date: Thu, 19 Feb 2026 20:33:43 -0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: msm8960: expressatt: Add
 coreriver,tc360-touchkey
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, beomho.seo@samsung.com,
 jcsing.lee@samsung.com, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, nick.reitemeyer@web.de
References: <20251205-expressatt-touchkey-v1-1-1444b927c9f3@gmail.com>
 <532531d2-8f26-4ffa-9355-7821a4d64200@oss.qualcomm.com>
 <1e74b956-a45a-4d3e-b7fa-e4d5dc0390db@gmail.com>
 <97d9d942-236c-4f8a-902e-0ad2ab684a76@oss.qualcomm.com>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <97d9d942-236c-4f8a-902e-0ad2ab684a76@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello all,


Top posting for once (context below).

Not too sure what the next steps are to get the tm2 touchkey in. Should 
I resend the patch, contact someone else that can help provide guidance, 
or something else?


Adding Dmitry Torokhov (official maintainer) and Nick Reitemeyer (person 
who introduced this variant).


Thanks,

Rudraksha


On 12/16/25 04:59, Konrad Dybcio wrote:
> On 12/9/25 8:10 AM, Rudraksha Gupta wrote:
>>>> Add the tc360 touchkey. It's unknown if this is the actual model of the
>>>> touchkey, as downstream doesn't mention a variant, but this works.
>>>>
>>>> Link:
>>>> https://github.com/LineageOS/android_kernel_samsung_d2/blob/stable/cm-12.0-YNG4N/drivers/input/keyboard/cypress_touchkey_236/Makefile#L5
>>> This driver mentions a register called CYPRESS_MODULE_VER - maybe
>>> it could help confirm the model?
>>>
>>> Konrad
> [...]
>
>> When run on mainline, this is what was outputted:
>>
>> samsung-expressatt:~$ cat /sys/bus/i2c/devices/0-0020/module_version
>> 0x06
>> samsung-expressatt:~$ cat /sys/bus/i2c/devices/0-0020/fw_version
>> 0x09
>>
>>
>> fw_version matches downstream ClockworkMod Recovery dmesg:
>>
>> ~ # dmesg | grep "FW Ver"
>> <3>[    2.201312] cypress_touchkey 16-0020: Touchkey FW Version: 0x09
>> <3>[    2.206317] cypress_touchkey 16-0020: Touchkey FW Version: 0x09, system_rev: 8
>>
>>
>> Unfortunately, I'm not to sure what the other variant versions are, so I will CC the driver's maintainers:
>>
>> MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
>> MODULE_AUTHOR("Jaechul Lee <jcsing.lee@samsung.com>");
> Sounds like the best idea, I have no clue either
>
> Konrad
>
