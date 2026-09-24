Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21AE4DD6F5
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286540; cv=none; b=htyoNuAvLUHbIKkEcO3zJck3qoPM3uEEgR33XWkd+R/etoV4FhyDI2eOps4NozWB0WD0+daEZWWvNJJTJOmSZF88wqg9hZaBWLRujE/ZEaRwNTEQUdrEM3RJvMKLrcRKTFWqo29ohFXwrpmtwQrsvOPnN+iPE57k40VKjBqElek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286540; c=relaxed/simple;
	bh=+bTnSt3emqvX/u3TSnqSXB2cSUSvItl6IDfwbhpwNPw=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=VWbXsHTlVz1Cs1H/bglqvXqErzx8I4p4/FGJ/UPF48xFXISlVeaLdwNSOpUBLRyABoLiknY0U3BGFZVh0Aug0HSZN9FTQAXwz6eMxae6wIyBGW87Agw9J6QYNiam7JJHipvX2pMzPoJpSBj1S0dg0lwixsXZOtSaLrustL8dqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiwYNDA3; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiwYNDA3"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe5so40017766b.2
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286536; x=1790891336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references
         :subject:to:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V2P12fpVrgq7wOLuxL2hcnHvjU6EVrhPKd2g6E7O5Ns=;
        b=KiwYNDA3WkcJoKyhl6bBpGQ/+hENvzHJMlcsjB3J8iFlJ1jFu2e4Vjf/umHEm7a8iM
         oYR0R2EXDPngKjnE6ChSyIkH6Um4xT+0XZTlcy0u2SNDuMIMtr6wS3Md8NubIzLulRlB
         d9lwjdOpM0BUD9TDJpU2b37hIRRPhNIVCY9DIACA75h4Atu1iHuLj26IgFQ5XOlaj98m
         m8EZxmvgLbbnQIShulLc194vVSy7mNCRoDBKjlKzmsbtpV48dfgvn/GaYMXy6xaE3MqU
         3rJBr0WQI7UaXCbMudtjfnTwJkUqFXPA4m2Tg/8qVnlKa8AJrUOvE4ya4fGrg9LnPS+b
         +LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286536; x=1790891336;
        h=content-transfer-encoding:content-type:in-reply-to:references
         :subject:to:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2P12fpVrgq7wOLuxL2hcnHvjU6EVrhPKd2g6E7O5Ns=;
        b=e2UFejfJdUYrAigJt+eWH9bzqM37M52b27agfHQeJ2J/pyfjSGdPXBEJp4XWJ05XOz
         ynkWV6FalkKEG+gBcixtcTrfm+P1xvxC1o8hdS+OYeSUo+koGUofflXypFlWwU4htyW6
         /4hI9h/wuSu5k6qC/jfTWUEE6sbemeKrOh5BIGqhPhAVcxkaV7ZfnOlMEIf7+8EzNeH5
         KlA5SLn4f0324a36OsBVdItp0ygUiua1clWvta7peTJehnap3ZZ5bcK3Ha+VMKOfARXV
         4HP9RLdVPZ1u8HiQXbAyDLOwHY7nGL5W0rIYFqsBXOhG/y8x3gJnYl1hf6+o20jSVn3/
         1N5Q==
X-Forwarded-Encrypted: i=1; AKwUvByz/WVvxp3PqiAE7Dgg9m9JoKMDkcz//UjiXvYGONPF86rC3N+iY4/kxbeXRtNZdTZC23bxU738bzSIZA==@vger.kernel.org
X-Gm-Message-State: AFuF++mZOae8ZEQil6EyaAnP9CaEwRLofBl+QNgDMP9As0IKypVeA/uI
	YFK+19UyCJ1NJs+8JQzCsxnj1z4E6RM9R8d0XC5jBCb3cexFzYLCFNTU
X-Gm-Gg: AYBFou2FyOQZEwFGbrWYElpx6hMQAAJD2FAQbmCMe7+eidEUccZJGg/+EU6Q7upFasW
	s7olsdP04jcyoT5N/XSV6FcWCCUIHtQp6WZYqxxi7nYGcGEYK6c/BRDmIwT0qSr6mt3C6WeLp6C
	nY2ivhdxeC8RXDBLkG/ndLslRVqJxHoR59jleYn/GIIOIeVxbsFJDjafdG52HzAxct01or62/NY
	5qLOWcknBLvparZp0pw4ceuwMZJ+r9BuRayjrbU4VqBm6Euo3qOL7w3fqu4P4zvDyyu1nVxExRi
	Esez/OR6jvw0S1kLRvoEAuJLtOFD7HGcxmGo7EQwyfonSynNmfQzKSFlsMn8wPSjAMMqYRhcmt+
	A2SPUUrHe0URgaxXge4T1X8CeizR9rhEvwUPFyBavc8stfKcN7eOIA8hiqNvzsqxAxgKtRhEVIm
	Um64LgtoCsdvRCWFLAawaLy4uc+EePqrz81nTfwExL0nYybca4I8HRvkVb90VCPtYERB9sn34dD
	xYe163iAenfFs8EkIA1WAOuZ7Y24MTwXfJu2l6XIyA=
X-Received: by 2002:a17:907:9447:b0:c26:2eee:ffc7 with SMTP id a640c23a62f3a-c2ac250ec3emr317347066b.35.1790286535550;
        Thu, 24 Sep 2026 14:48:55 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae678ec74sm20420166b.4.2026.09.24.14.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:48:55 -0700 (PDT)
Message-ID: <6432e712-cafd-42bc-9adb-5e620e57ccb8@gmail.com>
Date: Thu, 24 Sep 2026 23:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: erikhakan@gmail.com
To: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>,
 =?UTF-8?Q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>,
 Alexey Zagorodnikov <xglooom@gmail.com>,
 Roman Stingler <roman.stingler@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 =?UTF-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
References: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <97b3c67c-03ea-4ae6-ba64-afcdbbd8f36b@gmail.com>
 <xpFXjeFKTb2mOjg5M5iN0g@natalenko.name> <r8QjhQUkS86zOaJsxE4nUw@gmail.com>
In-Reply-To: <r8QjhQUkS86zOaJsxE4nUw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

My mail got cut off for some reason, maybe Gmail thought I wrote too much :)
I'll repeat the end here.

Benjamin Tissoires wrote:
> Bolt in kernel was adding in 7.3, so I'm going to revert it now, and
> we'll have to have a fully working plan for an eventual inclusion in a
> future kernel version.

Since I'm completely new to kernel development, I don't know the proper
etiquette here. :) Do I submit the new patch mentioned above as a series 
with the old reverted commit first and the new commit on top of that, or do
I submit it as an entirely new patch?

Cheers!
Erik
