Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A48332EBB
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626755; cv=none; b=Tx+kjK6CIc7d02WgdwGa/lBDu+rcknx28VONtR2CnuiMp0m9JEOI1Zq0FPMp90SA2Y8OcAmAbR8Idjrfyv8WCkocBnJPc+5h9QxKcQ08RxJugMUPsDNcM0Hcfk8ZPF4FuTG83Z9LbF8Y4F0RYShV9Zt5k/YCnV7HQihH6QOHjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626755; c=relaxed/simple;
	bh=Us2pie5/ZlQAJJYFqJHN0j1yUSXmxqJ+9dX1xFgY4Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuTO+VxRvmocwPRyUw7WXykNrUweRZmn9uCqGOLPPVJjpRopMAiUCpvOx6EFWgO3QHBs1fhgjMjRSEB+D++xba+Oum5JJAWDYuKr8hwtntRsCvUdKU79MoJT8Rlpz6ingrtAHqr9Yic8xGKZgPtxoT1EutjrXSI6P7tCS4+niXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmFjaEe5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmFjaEe5"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1712a04ddaso360010766b.2
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785626752; x=1786231552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpcRkFY087ds4cMoBIRtuIy848EiAdaOb7SMFkq0qcw=;
        b=GmFjaEe51nZulPD68Fwf7HMdg/FfKpGFTmwL3xBWZCYnHKtq5F6HQtIMgU41BExW4T
         MlNflIo8D3R/FMIqAFi/7KP6bKvDIHCDjglpNa/nd+0HDSI1nQVho8etu0kQpjMesw57
         hSuLQZwJIxuNpg1lqftv14HiwG1cY3CzTDslODJw891y/CoPV3n/s7jyiSOTRNhqgH5m
         An61heUq59sBeGhfMJ+B8HXOAeFKiiw4oYIW2x8TiF9X4SuQdWT7AtvA5+J0kkhkAOyA
         FosXvKcgN73MSgPy6M+o8NVdtRq/SO42lDcvcOS0IQgfcfULqJ82q/ZrpWEV24Mxv/Fj
         h9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785626752; x=1786231552;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpcRkFY087ds4cMoBIRtuIy848EiAdaOb7SMFkq0qcw=;
        b=q6aGolp4dutW57nrPXOiTk4Bso9gA8XbIDHJ+VBBjDee4WETXRLi1A96GK0OwrO+/b
         jC/TQlUsywpLcyl3u5OFRBTA3cfxkFY+l7db9es/jUPHOa8rxDE04pTurTT/ubOu0+qN
         3GtqdgBqYKY9W2xdwtFJ2yisDuwj0JR5d8M0v3CQJHWnU7peouV91seHal4GffLy0kNl
         x1SHuX1R5D8jbJd351haNghntFPqGHTU2bgJGXsOnE4yvPgQSlR34xhc7KkvYXvxqo5I
         ++QOp2IXys2/k6SQxb2564ng5p6HYUreQjrDpS18e9xUFq+hHTNgfRhlYO9f/4JZaZkY
         T9/g==
X-Forwarded-Encrypted: i=1; AHgh+Rrb4S9fQaBbITx6Jbtq1Wb1C6wrVIgYrJzYvh/YODZOaWTu/Cv/YUVFjiM0gMtkXmOFpisfjkCeZli3tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVO9ZZRSx/XLhM6+hQFko4iOZxd+jbHuRUyq0JFodN2tffzZna
	yK43KO2GuttJf41l0JqDOc/J/u84qJQ6BWqonINJJoMKDCojEX4PYZwV
X-Gm-Gg: AR+sD12Fm0CI1WlbY1MgemFdNJhPO9sGMyKJ3Og/f+8m496HYVsg0N3Bm3gFr2lydSV
	TIyIy/6+5agnQmv3/I0y94yoTXXxaqYKIDYB/BMIONeNKHer/yyx3UT2et98GMYZJHQU9zUl18M
	emFy9uD9m8ZvoMypTEIEDlkmWK17I0PPPRj8K462/jJP5CqbYfyFZZHQGG2GL7VfdZRGCRmW8oD
	Oj6nAIjzReCu9Pq6S3MwmR+1ilDUljfmiTJn8bTcZNykI5eqslxcbEbKoryf1U2j7tOtaNVcOQY
	i1ahT/ijzTDRmO3llg7GBuJ9AlRY3F++9KRTzS4ikJUKFBEpfrsH8C+3Ajd8Rb5He7urqv43gkQ
	n9BskUZhFuVd5DjWIstvdI3vVNKn3pvdQMpMoKNMTnNsrhwIzhtOInt9JMU1CSAebeBm1bxy+E7
	QoxzS92MobhfdbIqR+CgxftAry/Wz9/KAlNQh5Vg4/GTMQpwdt61eN3f/3SKZgAJfLDfbr9vxXf
	swZe0v/Cu88AlhGasKhkH+w6UtO2yZm
X-Received: by 2002:a17:907:ea8a:b0:c1f:e9d3:a3f0 with SMTP id a640c23a62f3a-c1fe9d3a799mr336087966b.7.1785626751707;
        Sat, 01 Aug 2026 16:25:51 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fe119ce8bsm268154166b.45.2026.08.01.16.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 16:25:50 -0700 (PDT)
Message-ID: <f44b06b1-e1fd-4d96-9728-4567fe62c501@gmail.com>
Date: Sun, 2 Aug 2026 01:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for
 Logitech HID++ devices
To: Bastien Nocera <hadess@hadess.net>, =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2Rv?=
 =?UTF-8?B?dsOh?= <k8ie@mcld.eu>
Cc: bentiss@kernel.org, jikos@kernel.org, lains@riseup.net,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bcbf28f0-a3da-454d-b05e-a554017fba0e@mcld.eu>
 <20260714005441.472898-1-erikhakan@gmail.com>
 <54844d1b-636c-4896-8994-f4e960e57944@mcld.eu>
 <14807a258220aaa2bf4ae5020b452c7da4201168.camel@hadess.net>
Content-Language: en-US
From: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
In-Reply-To: <14807a258220aaa2bf4ae5020b452c7da4201168.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/30/26 10:38, Bastien Nocera wrote:
> On Tue, 2026-07-14 at 12:32 +0200, Kateřina Medvědová wrote:
>> Hi,
>>
>> Just tested V1 again with both of the receiver versions I have on
>> hand
>> and the input issues I described happen on both.
>>
>> btw, thank you for pointing out that you can check the FW version in
>> fwupd. This greatly simplified testing.
>>
>> I do have one find -- when a device gets powered off (yanked battery,
>> switch moved to the off position, switching devices), the battery
>> stays
>> in upower. Unifying also does this, disconnected devices stay.
> Unifying definitely didn't use to do this, I don't know whether it's a
> problem in upower or the kernel.
>
> "udevadm monitor -k -p" correctly shows the battery switching between
> POWER_SUPPLY_ONLINE=0 and POWER_SUPPLY_ONLINE=1 when turning the device
> off. Not sure whether that's what it used to do.
>
> If someone has time, please test with older versions of upower (I would
> say go back to 1.90.2 and start bisecting).

I can confirm the behaviour you're describing from "udevadm monitor -k -p". upower changes "state: discharging" to "state: 
unknown" when disconnected while Solaar simply displays the device as 
disconnect but paired. This behaviour is the same for me for both my 
Bolt keyboard and my Lightspeed mouse. The KDE Power widget removes the 
"Discharging" prefix before the battery percentage but otherwise nothing 
changes when disconnecting for either Bolt or Lightspeed device, which I 
guess is because it's based on upower. I could have a look at this and 
try older upower and/or kernel versions, but since it seems to be 
unrelated to this patch I suggest I do it as a separate activity. 
Regards, Erik

>
>>   Either
>> this was intentional or a bug. Either way the behavior is consistent
>> with the existing code and isn't introduced by your changes. I'm just
>> not sure what the correct behavior should be. Sorry if this pollutes
>> the
>> discussion, I'm completely new to the LKML.
>>
>> I'm not sure what else I could try, I'll keep your V2 on my system
>> and
>> let you know if any issues pop up.
>>
>> Regards,
>> Kate
>>
>> On 7/14/26 2:54 AM, Erik Håkansson wrote:
>>> Hi,
>>>
>>> Thank you very much for your help.
>>>
>>> Unfortunately I don't have a Windows system easily accessible, so I
>>> can't check my firmware version in Options+.
>>> fwupdmgr says:
>>>> Current version:    MPR05.03_B0020
>>> so perhaps that means 5.03.20.
>>>
>>> Let me know if anything pops up if you dig some more,
>>> Thanks,
>>> Erik
