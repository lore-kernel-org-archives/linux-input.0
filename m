Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B273B71BE
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071856; cv=none; b=SXnsTqVcWoDhJZ1YaIudOkTNMTtpHMDkJimjJMWT0pMyAJYFOC6d1djoG2VB6CN4MoKhZ566J3HeNsRLUuXgy63Fr2U5y8XuxQvXEEjaE75lzceM8wNxE3hKuq/ImYkNTleCzWf4RCg4EjqmCznwNgW+1R53ktqEn0O1DZyi7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071856; c=relaxed/simple;
	bh=h4aCxdhy1tGoV6lGKVJX0x3mhzD+2ezFEQ/0eFlBe+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeKmeYcNtdxKROQCX1ocCtDWL3151RaUS/Dsy+z1l0vlJhxo4w2u6D3m915Fon9huHjbwp58a19kwOuU9Svw8bnZJ2L3q5H586IPKYcavQEaK78zWhsVb7hspTj/jfAgVD8TkDnDXjuhyhNGgnSokmSc26Jck3pBsLlP/vsBw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5hB4aET; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5hB4aET"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso160594a91.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789071851; x=1789676651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0rAC78IGmF6UMoo1efDtTikBTEY+oo8toLUqaRvjb4=;
        b=W5hB4aETjpYFPz7+aqlkKe68+7eovknFf0GKABeP1CN74iKs3ZCHOhHoTedBZtOm7u
         u6JeD35sfPyspazqsqC8ZOXp0cPNgvnlttFJZY2/lFJ97zRsEBp1KMDKMBeYCk9PoTrc
         rC2y+3/z3tz9yOr5oq3uoKpi9grbPdkTvrCBIcN+g0E0dp347l7QBHSEThJj4kzmgbuN
         c1tYdySZpmrxZXbS/YG1TviQF++BQohiU0Z7v16bnYFc67a/g5qLu4gAyiJO2qRa8Upm
         RoiqHg9gtmcHtggdL7tAyJyU8c6UdhbEfEIKD2hLy3KHK2wQNZdmsaSeQIhSvvaZw20/
         9GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071851; x=1789676651;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0rAC78IGmF6UMoo1efDtTikBTEY+oo8toLUqaRvjb4=;
        b=OOAaxBd1AGBMAgs3jqtTndwAwIfZ8mxx61Wm+M+qbFA23y9z3Eg1dEOjwDL/IBBFLN
         DVQlcCdelQRTtt2wqzcxA2RnNCl+bTStzWOgRR1X/d96eBZmm8KtyjgOwglXGy7RvoDE
         T0DUOsakjSqK5hiXoYOkNNsd+F1JtpvbaSV+UWmrYZRAydzoC6PVgv3cfGwz6N5LiEHl
         YvQjy3czL2zouK08CPdi2K1FK7Z6OZULR2qjykvy02l+tsbZzU3CgIYVwr1iJVi/Aq6o
         hM5cMtXmqrM4rNbH6Q6OaijIxk2ojZbh2TP2zWMiOQ/GBV28tRvtIEsCZuiKRScLy1eU
         91IA==
X-Gm-Message-State: AFuF++lzIx8d9eQu/+sruKsPo8nM1Fx1Q43w/7IBWIt1lRw2p8qdGhDi
	VwrPkZ2iK9K9kApSiPumMRAWkroxNHEVlqkHjp+IaebF6SYcX4Gr58F+
X-Gm-Gg: AYBFou2dps1G1+M/zFWRWcjdARz48QAc5HFYs+yUum9kaEs4Y2lerZvxuCgRTWz3FI1
	rMvmR8NkH8QglPwsjkrdnK6h58E7biNCEW43PPuSqvwU4WHbsWusytBeTVSlhIV0fBEsx6PZtot
	VMcE4HF7/sC8AELn84yn6/w9W90WgFgA2xA5i9tYBoNHbLJXgEdqPFvG1cZa/X04/D10u94aeZB
	R4obeQVKWa/7XOKEQ8BA1ZL1vKAlZKXQTRY/ksew2hWlAXWvs9eCl+6MSjKLMMINE6gPz3xjwtL
	ED73t2j7EmGEHzTpEc2Nth5nlX7xDS2uXpFLfd5pa8hdVYG9S55C7ygmfHUImiHhvQFTyzUkRQa
	BmRdUAvAzUQyMB4HcrhcgzpZFNVWTKvRGQjhmHW7rGvZM9iiQwyuRio5+agvR6zekv/HzfdPd7n
	3J7+wfPThn4zckttqT3zHpTkXgoz7ZJZL6uKlEAvQ1wf/uzdwi5xk3OiPGbnTXg0dfmgZpbVxj2
	bgESfryWC7yWmZcLyW2bsAsvZhf1isKwpV+/iOKDprL6N3pTagkQZpEbq1lyCKnlg==
X-Received: by 2002:a17:90b:5807:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39d9c1befffmr644645a91.16.1789071851148;
        Thu, 10 Sep 2026 13:24:11 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a598aasm973848c88.1.2026.09.10.13.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:24:10 -0700 (PDT)
Message-ID: <36c6e08d-4856-47ca-a45a-018cc563846e@gmail.com>
Date: Thu, 10 Sep 2026 13:24:09 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] HID: hid-oxp: fix and extend X2-family controller
 support
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-leds@vger.kernel.org, linux-api@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-1-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> This 15-patch series fixes existing hid-oxp configuration and RGB issues
> and adds controller and lighting support for ONEXPLAYER X2-family devices,
> including the ONEXPLAYER 3 and X2 Mini Pro.
>
> The fixes correct the M1/M2 defaults, validate input reports and RGB state,
> correct brightness and color scaling, serialize RGB updates, and make
> configuration state and delayed-work lifetime local to each HID interface.
> They also handle controller reinitialization across system suspend.
>
> The X2 support selects configuration interface 2, supplies the required
> three-page button map, and adds the Gen3 protocol for joystick-ring zones
> 1, 2 and 7. The Guide button and rear logo receive independent multicolor
> LED devices using zones 5 and 6, with monocolor and breathing effects.
> The final patch documents the controller and lighting sysfs ABI.
>
> Patches 1-10 contain behavioral fixes. Patch 11 groups existing declarations.
> Patch 12 adds X2 button maps and interface selection; patch 13 provides the
> shared LED representation; patches 14-15 add X2 lighting support.
>
> This series is based on mainline commit
> 50d05c7c76c96b90462f24debacca971d2e86713.
>
> Testing:
>
> I tested this series on an ONEXPLAYER 3 running Bazzite 44 with kernel
> 7.2.0-ogc6.1.fc44.x86_64. Testing covered front controls, rear paddles,
> Steam and Quick Access behavior, independent RGB effects, brightness/off
> controls, and suspend/resume restoration. I also built the module with
> W=1. X2 Mini Pro hardware testing remains outstanding.
>
> All 15 patches apply cleanly to the stated base and pass git diff --check
> and checkpatch.pl with zero errors and zero warnings.
>
> Development and review:
> https://github.com/OpenGamingCollective/linux-unstable/pull/13
>
> I used LLM assistance for protocol analysis, implementation,
> documentation, code review, and test orchestration.


Hi Andrei,

Thank you for this, a lot of really good and needed changes are present 
here that will greatly improve the driver and it takes a load off my plate.
For the patches with Fixes tags please add Cc: stable@vger.kernel.org in 
v2. I'd also revisit which patch some of them fix and make sure the tags 
are correct, RGB and buttons were added in separate patches.

Thanks,
Derek.

> Andrei Aldea (15):
>    HID: hid-oxp: fix default M1 and M2 key mappings
>    HID: hid-oxp: validate input report lengths before decoding
>    HID: hid-oxp: retain fractional brightness when reading RGB status
>    HID: hid-oxp: reject invalid Gen2 RGB status values
>    HID: hid-oxp: fix multicolor LED intensity scaling
>    HID: hid-oxp: serialize complete RGB updates
>    HID: hid-oxp: select brightness policy for the new RGB effect
>    HID: hid-oxp: stop configuration work during teardown
>    HID: hid-oxp: keep configuration state per HID interface
>    HID: hid-oxp: handle controller reinitialization across suspend
>    HID: hid-oxp: group declarations and protocol definitions
>    HID: hid-oxp: support three-page button maps on X2 controllers
>    HID: hid-oxp: represent RGB LEDs with a common array
>    HID: hid-oxp: add Gen3 joystick ring RGB support
>    HID: hid-oxp: add X2 auxiliary RGB zones
>
>   .../ABI/testing/sysfs-driver-hid-oxp          |  196 ++
>   MAINTAINERS                                   |    1 +
>   drivers/hid/hid-oxp.c                         | 1743 ++++++++++++++---
>   3 files changed, 1623 insertions(+), 317 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-oxp
>
>
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
