Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92055C1A2
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090936; cv=none; b=Wmgx8V/Zf0flL2wNZkbS9Z8u6rbhwpinHoqaMjURxbhTs4mpnLSejfiBydstBQ4Qpi/PHIJNCWSyakC+xNV2fMpdUituzh2UfJbRHSmD3GDFO6TxfAkIJaWa2F3n+wpvu+grYtn2BrJNlNwD/twcZBaZ/QRSOwezsXWcOQ7wVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090936; c=relaxed/simple;
	bh=3VG13KlUFZr8mWYPKqpqZXuHm2/ifohKQ5LdDRYyPW0=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=p141MHGbDnE0AbYFLQmrstSD8wXnDTG1Hu7wooPuYt9QcEkWJNIKPI0dHCd992BQMqCWW7WAEpErY/HUpS4HEAiXdRwhmEJveGdvEVcOEiKlBrD905HbEYeLpjXzaL/3xYezz+pj4xjYXZreAiTQWRaLZyml96dgu/Q2Di1Mxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBSmd76h; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBSmd76h"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa65080so500572766b.3
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790090932; x=1790695732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references
         :subject:to:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BJFEjySqrOT3b0xQe8c1PL08A2aFqjKXZIn/4zCssyo=;
        b=tBSmd76hJoEB9fMKN/omvmZDvOyZa8N64v1MjjtGSEkQECTthAYoo4FWF4V7viejbT
         wqne+d8NBaGeTpu6dSkZdN/h4kk4pmBXu+BBiJLXzNUECkrDx4AKnR7sZHqzw5PkDG/c
         A2xnsxdpmZvbUIDMkoES1V4/HlZsX0VZlcuUAzQUZdbc0cRnIki44zGE9e8/o72q/bXK
         zmyA1QLyXs9h0OLiqEI/0wt7evUg7o/dl76iMRJbuCX/klPHkZC950TdUK8duanZpzh9
         XlN5p102XNHL+x2zSQ/YQzYh/mGZ6LdJboHY3hcsvceC+JHaoI1Kcmaght75JGVF9ZeG
         m0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090932; x=1790695732;
        h=content-transfer-encoding:content-type:in-reply-to:references
         :subject:to:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJFEjySqrOT3b0xQe8c1PL08A2aFqjKXZIn/4zCssyo=;
        b=QKD0NBERDaH1Rl+ma1uCuXFGXz/X9eBUU9FcQ+bTb00kJyPu735MxJVgsItGAFHQws
         9zKY/yXjfMhUdXUEQbVAiZEN/Y/8w3sRC6Mfwr0VEBAs9goyLOWfP8FNZYoldWgM3rn9
         W8WNjv9vIDLJ0Tl83yzmBhTv9l3hC5I8zN0RSP0AYUMS5MsDWtuqgXNkWoMy/x12ZCnC
         RjsoCVnsVL4i40vX4uO9OuSbqiwJSs4fgAFZxrIjBQGqDk7fN7ghTg6FCpTSmmNoZ+Y6
         K9JuGNQcKkbBc3BxgM6ESXWmqAGXG8htW8iIYvZnaNGoMEYOh/2DoDns4+0i9fEwiTl1
         pOnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbm35u5He/fBChYvM/JLwk1YMqLzsgEQhEsw+UdTglXfDGSUSNkXu/mWTZtA536onS2CHS67sMs0Nslg==@vger.kernel.org
X-Gm-Message-State: AFuF++lyf0I2soMTdkx+8eMxSPSz5Ldd74BXmRMX7qF6MIj2blQN3vIL
	9nyiFw+FWzlNW3p2sOzEADVzPhSgu21F5yz2fE04miQsgIdx5VTmAF2F
X-Gm-Gg: AYBFou1zVm6MFNCFE7Rm5hpqN/YBb0AtI95enhayHL9Kp/zlt8ueGD5qhahvop5M+vH
	iMRS+kztoMim4AcxkmtIdqW+qxcr7bCuvgwzswah7WWjKzusuMA3XiBM7g7Mta+yeJrFt5wu/l2
	0AprUZMHNw6pPCq4gc94whIXT2vLpsrba85nA5EuDL5kuJrf54DFZDPfO41/UcWCui4DJPfheIa
	K+VxQnK++da34gaqWVhk8YqapBJj/XHf3YzemWbuyCPdjR1lgLv89sQyWQOLZbv+5wnoT/mG5Y+
	ZD7i3IDnisTdDLgwxWvBhQnpAQwyy2rUdLMuq8A0gpjznbhAIrP2aZ+viC4iyTLUt8QncLEtvLy
	Egfjq8BtVBv76ZHBJ5rBnG7o0ogn208RE5+9a5c+PSVK45474rSBOFg5v+BdE4Z6rOyK19JIObN
	dBCLnYLkz2fvPHyvHvZuyasJd5/rxfZrwMpo9aOi8v3anxTywFAvWVMbzaJJoSsBKv6LCP8qH6w
	HF4HWa7IeRneYGKnnfcn8D8TCJWASVfRvuiUO2FiYo=
X-Received: by 2002:a17:906:9f87:b0:c25:c54d:d1a2 with SMTP id a640c23a62f3a-c2a156b259emr1326230866b.18.1790090930441;
        Tue, 22 Sep 2026 08:28:50 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c54f30dsm114527166b.17.2026.09.22.08.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:28:49 -0700 (PDT)
Message-ID: <1db23bb2-f94a-4bd7-b9b6-5175aca68ff1@gmail.com>
Date: Tue, 22 Sep 2026 17:28:47 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: erikhakan@gmail.com
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-input@vger.kernel.org, lains@riseup.net, hadess@hadess.net,
 jikos@kernel.org, bentiss@kernel.org, Shuah Khan
 <skhan@linuxfoundation.org>, Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Rafael Passos <rafael@rcpassos.me>,
 greyxor@protonmail.com, roman.stingler@gmail.com,
 lovekeshsolanki00@gmail.com, k8ie@mcld.eu
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected
 MX Master
References: <20260904034843.1340846-1-rafael@rcpassos.me>
 <awkjflaaQZW7nPVUOsxJ5A@natalenko.name>
 <LYMlyJcyQt29e1KlLnEoLw@natalenko.name>
In-Reply-To: <LYMlyJcyQt29e1KlLnEoLw@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all!

I believe I have an explanation (and a solution) for why everyone's results differ.

As noted in https://lore.kernel.org/linux-input/20260920094508.39682-1-roman.stingler@gmail.com/
there is a conflict between the driver and Solaar in that user settings are not
respected by the driver.

So while investigating that, I found some further issues with regards to how Rafael's
proposed fix would deal with the case where Solaar disables high resolution scroll.

Locally, I have a fix that expands on Rafael's patch and but also handles low-
resolution scroll events. And it also respects on-device user settings so that 
settings set in Solaar will remain.

I believe that the reason for inconsistent behaviour for some testers is simply
that there are unhandled states in combinations of settings in the current code,
which my fix aims to solve.

So, Rafael, is it alright if I post a new series with your fix as Patch 1 and then
my addition as Patch 2?
I'd love to have it properly tested since I don't have a Bolt mouse.

Regards,
Erik
