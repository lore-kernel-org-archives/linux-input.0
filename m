Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7233A16AA
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043229; cv=none; b=U4jCFiVw8EEPm9kWar9Hp+G0neOYdNisrIQ98UIIJGoCZxLu6RnPkM3secPnyPoGxfi3oAjz2ocpZ++9PhZ1a/EHGhKnYT0Erj+2kYGVJQvG108ayZ6RBYhxVIp8C8eptZZLBGCzkfa5hjkUGw7qHlH8IaPUREjCiLbYtJa1qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043229; c=relaxed/simple;
	bh=ix264Hb7/tOHT6d+jjnWC+mNom3lPkhDrHDjxzpe7C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbnLPhvqY/TjtaG6NJaomS1DOL2993r5eohLWkdpLziBntKNn6uCpPDTh25Y+7BWBN0RsbororLt7Cf8S45zxpaKYxH1pmS06NF53HPtGHGlket7M2waQtf3sWzlktn0bnT2+leKVe04xbbusOm8M6Z2HFlBxGGEk8+VYC9bjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6Zw2aLm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Zw2aLm"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so8007125a12.1
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784043226; x=1784648026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZ80D47Oo7vTvRWX1vy20MFgvqLnPrfkvbVchQS7ZL8=;
        b=Y6Zw2aLm7EXu/mwOmmFx2QUUZhdWcMJQgFIuo9xt0h05g31M87vGh97oRPY96pFksM
         LHXBRMcDSi1IiQdqbs7m91mfJyhWlQNHkQCVnH0on76k0o9pPd24ZKU9OW2VipoarwLe
         IO8Ld1nYXxuesiq8w4yPsck5tmOTS79neCiiveTxMC707LDG0Cm/1Jbz1HbEOxV3zz6R
         Irx51gTCs9PyReUrXboeY239j9Y+nXNPC572odbAeKgNtkYoeQgOcnGdUF7kmj6ShP4I
         HPKlhYk6Tb2X3Luq3vkZJQ0IYhCpRAyB7r+LQl8SC9hDPCmFTNOUpFmZUgKUdnt7NtXJ
         ctwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043226; x=1784648026;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZ80D47Oo7vTvRWX1vy20MFgvqLnPrfkvbVchQS7ZL8=;
        b=Y5g34UV8QDcYYuBrdbBUnCJAKgikPRRFLGL9bPgh0jKLWgFsKwl7GohS+Aee50lAXl
         laknbHbXOlsiMjgZglVA93UYtz4ua5hji0M7KgORYXQZu4Lk9KQF3Bdz/VRZwTYj9y1b
         9MUK6PA1025iOaFXH4x18gudPPgmKKywXoiyXoY5UA3o0Iijkz72qMcx/Aqbjwhtw8Rc
         +W+NDHFWX+5jG+m3Yal8/SjqeBnzAbjAeyXcRho7IBppiHbh6xwVXOnxpTaiWfoM0rA5
         XIP4dzYK92VZiWa2o6zyoBsDH+YU/IO37Je/xCKbwJEyngoW/iZhErTWgMAi+hDwTUuy
         f2aw==
X-Forwarded-Encrypted: i=1; AHgh+RoKeZDJvy1XLtknI32pMnmQnC+1TyyVzI1J3YobJhDn5kpSMAfbamMNg1AYhOaWwRrh1FlVvPW/jIuJpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbv69DCflCvaWvDx8SXZyDaiZIhUabD9EwujMgYPN7JifO7Gzi
	7zGYYFTR8NzkBZeUZJ+z5x0P+TxaqHc0ODaRimUZ/Y+yIHelQkVhoyhxZFKiWTl9
X-Gm-Gg: AfdE7clc4u20AOOVup198opaQb24B6O7JPBJ27yHj/Myg1ZjVe7A8lrwu7D8jOxDd9Y
	KFSdTZHNmEfzez9ya3YFtrs4VyPM3966AwEam75c5PPFFq/VEmvkuKjVDPIVuOzdb/jg13DhFqP
	kBJRGqq45r6IgOw9vZWaHdVLh8OG5UtteTpdRPLuo4GIi4BPkBz3YRNjtbi+orwss6UMe3eJeWq
	nbtglVPNBH1gF2ujfpk66X7y9VMe8k8faFscCn1xSuYSWuTyAYqQgBHsYsojDMPMS+oU0zJHOp6
	Wp6A2nx7WtrO96wpGJkd2yy29VPn+uXWbiDr+clrcrglVwC/66nQUz5xTPgA3KoGmG7SWhYdnId
	GkQAr3hiZx0UV+IORhhZHqgBHkzmp9WV+ZHsIF13wWORsWCgP57uFP1KWwNN2/Op0vn9k1ZRXf4
	xg3ff7x1KTaSjaXjUiuKAroNegcqr2nlDn762mzbDEa6HdBRve6WanJqyA
X-Received: by 2002:a05:6402:1ec5:b0:69e:11a9:9ba9 with SMTP id 4fb4d7f45d1cf-69e11a99d0fmr172116a12.31.1784043226143;
        Tue, 14 Jul 2026 08:33:46 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd28a298asm1741673a12.13.2026.07.14.08.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 08:33:44 -0700 (PDT)
Message-ID: <0c1609f7-f2d5-49a3-8a50-5b2a8a8a6dc0@gmail.com>
Date: Tue, 14 Jul 2026 17:33:44 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
To: =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>
Cc: bentiss@kernel.org, hadess@hadess.net, jikos@kernel.org,
 lains@riseup.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bcbf28f0-a3da-454d-b05e-a554017fba0e@mcld.eu>
 <20260714005441.472898-1-erikhakan@gmail.com>
 <54844d1b-636c-4896-8994-f4e960e57944@mcld.eu>
Content-Language: en-US
From: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
In-Reply-To: <54844d1b-636c-4896-8994-f4e960e57944@mcld.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/14/26 12:32, Kateřina Medvědová wrote:
> Hi,
>
> Just tested V1 again with both of the receiver versions I have on hand 
> and the input issues I described happen on both.

I see. Then I assume it either comes down to our different keyboard 
models behaving differently, or something behaving differently in our 
setups. I use KDE Plasma on Fedora for what it's worth.

>
> btw, thank you for pointing out that you can check the FW version in 
> fwupd. This greatly simplified testing.
>
> I do have one find -- when a device gets powered off (yanked battery, 
> switch moved to the off position, switching devices), the battery 
> stays in upower. Unifying also does this, disconnected devices stay. 
> Either this was intentional or a bug. Either way the behavior is 
> consistent with the existing code and isn't introduced by your 
> changes. I'm just not sure what the correct behavior should be. Sorry 
> if this pollutes the discussion, I'm completely new to the LKML.

Good find! I suggest we leave that separately though. But as I am also 
completely new to the LKML I don't know what best practices here are. 
Let's wait for maintainers to chime in :)

>
> I'm not sure what else I could try, I'll keep your V2 on my system and 
> let you know if any issues pop up.

Great, thank you!

>
> Regards,
> Kate
>
> On 7/14/26 2:54 AM, Erik Håkansson wrote:
>> Hi,
>>
>> Thank you very much for your help.
>>
>> Unfortunately I don't have a Windows system easily accessible, so I
>> can't check my firmware version in Options+.
>> fwupdmgr says:
>>> Current version:    MPR05.03_B0020
>> so perhaps that means 5.03.20.
>>
>> Let me know if anything pops up if you dig some more,
>> Thanks,
>> Erik
