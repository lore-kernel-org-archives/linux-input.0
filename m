Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF065192
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803196; cv=none; b=t+TWoigmfHaHdQRRZSlBRTH3l48Uys9ozxq8QAGeoMdCOJqWjWguKqgrru6UVeUNebObUGM/WSEx5wQICo2B26UPqewd5QpHgpzZvp9M7oKt/C9EVt44KIZ7fI0mKh3IQzysva8dMPYZJnp2/ivGN7mJtC4ImKj2J9/sZ+GNV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803196; c=relaxed/simple;
	bh=WsojPxnxKW6t5kjIh+eqQlvaB66sXJuF7NgRSyBuLPw=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=V2M1XN/hUDm7yEiJW3VXFL7HXql8BN8r2iWqKGP9vKn91pmzoncTRVKcg4cIadwqIOY5m5T21PtWJB9gLe8/+FkovsI3FnfwkY4kczWqfgMqTB7dwIvqpzrkMZg8f7UkrU+KohC5GHb+bNykyx4q6vp3y45ijnSqKFOX9EuxRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qN74wijZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qN74wijZ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a600a1caf8so5874331a12.2
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788803193; x=1789407993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references
         :subject:to:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WsojPxnxKW6t5kjIh+eqQlvaB66sXJuF7NgRSyBuLPw=;
        b=qN74wijZPMqtb0Y+fFDSW2KygZcixgAT4Gs95e/0yGief30p3AfiJ+0OsUKg3McvmH
         b4AggIjbUqpu8MuzfnSnjQ5Ra/yn025T0c/tltPk/+rVd1va3QR6OaKX8uwlLFfjgtqH
         LBYCyS+UlUX/JAc/qaC96+m2uEIABKmh6PPgEPDqSK1lliR6O6eDU94KL+44q91kzt4U
         cZEEHgE6N8dXdlSDMW6EnWG/V5CxapyhcuKLYON33xgaT/v1gk0EYGast7UfxjQHqgwh
         /hfnR+o4Syf2ceC1yyP0tjtZjml2IfpmO8yvqIX6H1lfNiZrlFrqOTw4OEGZ53nvdjKC
         pJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788803193; x=1789407993;
        h=content-transfer-encoding:content-type:in-reply-to:references
         :subject:to:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsojPxnxKW6t5kjIh+eqQlvaB66sXJuF7NgRSyBuLPw=;
        b=RPlbOFxp26XJheWBWTxxISPpzdMmpOIfKIQybWaQc3W9Z9rLaJbS4vYmOPQotT5/DK
         dDu7Ue+Dpi9IM/GoHdYeaZ00/8EfsaoAbqG9f493pQ3hfGRt/UsgVWsk8GDSNtdeAmw7
         PqMqYCK15udFnfi3znikNNZTDpZyFKg4X6nBOI8T6y+FVN6bQQwCEtB4tsSSkvls8NhP
         pe55Rl2jOzar9Xrki3p2Ue35UbJndotm5tcH1zlFXDjcR0mjagJS2YTqIxz1/lqPySjL
         RGeRVML2fVwNKFBm6lU4ZNsOS0Mj3nohXZu/loa6IemK3BWz3/fRgqB/+5rTXPj6gRjB
         zO9A==
X-Forwarded-Encrypted: i=1; AKwUvByVk/SEXTPQg5UqdReefOnmSYieDFRm3006v9ymvwt7voVKNQrjQS/DQ6U/pO1aL78Itkx4EcPxFWaJ2w==@vger.kernel.org
X-Gm-Message-State: AFuF++mUmK2NThjt9h3NcTPUo5Lc8PxNunB8g1VxrC8T7KjRYIuFF4Ai
	WuKU8Ejr2s4WVooT2JsB6IrIpLzc57YY494F35IFRRINA5YNN8rmNtoZ
X-Gm-Gg: AYBFou2SWK29IDSNlfMDNyXu4rhZORs0pczSoQegZrXJTYVQANyMBGvfgon+kORoU8J
	Zowwfw6G8eJ4Vw2ibSOTGAzrK7YV69x7UdNf40yYR8EDowN652UvHvsl93lVGzGToJynvaxR53v
	67MXzOwMKAMSXNXmSVhCKH2+MjgL1QU0I2Jg2/X+pfR8DfkfTxy7NnPBWf5onnszQ/b2ziZoXQu
	PnnNz7daa3wYGp99qVkAWPBMBuHOXDf7+iguwHcAW98SY1rd8Ie27dJwqU5J4XsgOAdfBWl6Ye8
	TcD3xBx5BF5bQ5pUKHUl7SI3sRxpcICYKzFqSOTPMFiaUw06awwk6f8oFDMFWwxhtk7r+/7jQhh
	NvZMPLskj2gp5DTI+j98VFTM5W0WNenmkgDZ3zbN0xYIzTDMLCLUBtByrRVS4qR0elwEDd2pmoD
	1Ki1lkyaCE1D2wQVJRwZ++77xX4DfYlA5nRxJdLRPIzAN+n8diY5cocfCydYpmRJGW7Ky8owUsD
	fndFZJGAak/9G++jv9w5pdmkPdvnqJr
X-Received: by 2002:a05:6402:234c:b0:6a7:f361:5fad with SMTP id 4fb4d7f45d1cf-6a7f3616404mr7167407a12.34.1788803192526;
        Mon, 07 Sep 2026 10:46:32 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6e0esm4698132a12.9.2026.09.07.10.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 10:46:30 -0700 (PDT)
Message-ID: <6d7c758f-168f-42b3-b195-b6c2f52f0cf6@gmail.com>
Date: Mon, 7 Sep 2026 19:46:28 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: erikhakan@gmail.com
To: Rafael Passos <rafael@rcpassos.me>,
 Alexey Zagorodnikov <xglooom@gmail.com>, Rafael Passos <rafael@rcpassos.me>,
 lains@riseup.net, hadess@hadess.net, jikos@kernel.org, bentiss@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>, linux-input@vger.kernel.org,
 devnull+greyxor.protonmail.com@kernel.org, k8ie@mcld.eu
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for Bolt-connected
 MX Master
References: <20260904034843.1340846-1-rafael@rcpassos.me>
 <96cd3161-3a6c-455e-a63c-f3226b27f74f@gmail.com>
 <119cd005-ece9-4e2a-aded-0d6d66c5bcfc@gmail.com>
 <3fca5207-198d-4dc8-956e-7b196f71b934@gmail.com>
 <DL6T82VA1NU5.1R1U7FE0CF6H@rcpassos.me>
In-Reply-To: <DL6T82VA1NU5.1R1U7FE0CF6H@rcpassos.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again!
This patch works fine on my MX Keys Business. No regressions noted.

It seems then that the earlier patch by Grégoire cause similar regressions to what
Kateřina Medvědová reported when all three interfaces were treated as DJ interfaces
in https://lore.kernel.org/linux-input/345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu/
where she reported e.g. that the mouse became very sensitive as well as some
other issues.

I.e. it seems like this patch is the better approach.

Thanks
Erik
