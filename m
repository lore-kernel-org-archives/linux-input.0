Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465597;
	b=No5XLU87fTBPgCXe47NATTdhS5fAQIF5eXyaz6GRWNydcyfyWNDWmnGze9EENDVVt0EA
	 bU3776T1pJsk0YKV6Br9GWuereMo8UG452byprrI9LA2LSjcoWT8l14X1tGHHGfO+2aDn
	 YBkATIPw8i7wP2UPPCq37dKNCFJCKcvyvaWvJUZvyY5e7NipI1jcX9h2Fqo/2ceIZQkUl
	 kVS+00cQdeFo+QkVVML0m9thVq12m6oREt0qyF2efBMO2PDLnjYyymTTEXHdcDzbTSuZN
	 rntJHe3o2zNAqIBMR5wiGUOvG6fccuyBGCKDdvHVcDtt+NY/MmC6JJMyXiV1+QaIZCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HF7kC7ehUvjMLFdO+wj8zalglx6VqyJuBB04EXzZxKg=;
	b=fambVds6SHW6ruW+na9rFMP/mbAHEjqj+6WJgzLEzoMNy78A01fI2W0kKJ8kbPoab6Hn
	 wy2qvmViDyjsUMSbV5xhrVKnhayfIoXf6v0FL7NOsdKHECPsxDYjMpHInwtcWkOo5hczL
	 8ajBwfuSTRub7R8lqYXLiSWfQOJuAE7JieaqokUKL0ztCxpIy/3AOl+tq2YvzETxbprvA
	 ZFGfUoqyrKATCZXTibiQLtbuITLxbZM/ifClk76cY09Nl5PRIvYVy5k6C7l2gMUSwflML
	 pdl4L+B9MFF879q4EAIdHWsQz1jyEZ6GmcnsiELeXbY6R20Q7M/lyE+fharuTxNYBMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDQEEOjt;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8233606A326
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8233606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JDQEEOjt
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38692f62b22so2817224eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465596; x=1796070396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HF7kC7ehUvjMLFdO+wj8zalglx6VqyJuBB04EXzZxKg=;
        b=JDQEEOjtQi4j7/aQ9NeZ5rJt2c9HVesTmaMZZFOcX4uaBY92kBL95IIrzoq0Ax30pr
         gLAHUHeWc2ooegw/GHvR3MNLB1ifvcF/Rb+AMj6GqueKAlA0shXumJ2NoRRMxxTwrH+1
         tg/zyLFCAvTi8L+5EVNsgXz/lb31rjVOip6dDi9mR5MkpS6APLMmUbbjVP2mKNbCTCaN
         ZaGVkza5xa2VByAMUz7668CZBKKugWiOUn/TL9N/OUPqxvTs/m52ZQf09LzwrJwS4B29
         8+Te87KL9Xzl0WvEq4cDDttiIo39RvGFfEeL17zFbFGZfjFA3Vtnvz+2eSnH6Jgglvtv
         DTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465596; x=1796070396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HF7kC7ehUvjMLFdO+wj8zalglx6VqyJuBB04EXzZxKg=;
        b=petGvmYhLIzsytSkZVsi4NcVDlckEbz455qyULa1mVUQy/NGFeeeUYjeiAtwTxs1qR
         w9BDVgIiNQ4rJ0VXxmDdV/FHy/K1fUAlZRd9ENNJA6Ye2p+qCO7vW/B1210J1gxQrkv4
         bvuEx60mllaMGMxZ4UfKHOEwsB3ICtCGISvHOaX3VklKFB+u1u4zdUzo1ycK4ZC2/kTU
         FuX7g/8KvvT3trwcSTZiv8Jv/rIF7PEkmh1am4nOwXm5MnOSZzx/QJKdcF+sUGfj17Fv
         HYuPOF/mJ9r6cSz1hbpU2D3FfZHytWTGgZMhWrEA4ewzq8Hjk/sE+8XPENgSiSfrjf22
         RQdQ==
X-Forwarded-Encrypted: i=1; AL+hErG2DUZdTG5M3k+WwbMco7ooAzwjP56fSxfF80IfyW7yl5YktfEti320ze6Ik81hUTF9RAjiY+zWmqSyuA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/KLVNF1XqJe9Yl8A+nCN6ZnO8AhJqjo4nr6Oh6kJBcriwqDD8x
	FpDBdYsuwvIMdjJTe4OQjgsWTIhkl0wnX1dPzhHRHCncS2a6t115Ye81
X-Gm-Gg: AZFdTZfmgisUET9mN8Zcovw/BCb+uvqotkcu48UDZ1MAGJ88jPRzXBjM5FZtY7scVvj
	9iwxTNhC6pWCXPzQdWm0u2IGFzeS2D45ha1oKpynFyW7SkajkEFKLPULqDhHxFVlmdjbRyuQwcj
	P7ZHailE8zBNNL35yXLlXdXLsNur11zWb0b+RYhQkTD2R3BERFoyHkMgeY0ruom39UpRMpX7Ul0
	3UJltLJUZUDNjoQuhAIAF3SomqhqpsDl+QRlZ072zZqmF1Rll9RL5Dp+P2dRQgP/JgDk39GKLSz
	gl0aFWwzWlNU/e2YC5T3PeU48PCBVBAV5Abdlbvje0HHHoYGZz9Zuf0X4vwkhhdjWN0gvMEHZVH
	qypJPNO6rtuFAR6tTJJ8KmsKmVTgizCWJl42j9qCcuU+HwVZ5TXff4DZRgAkoV8hf9Q50tDNOvv
	h2Xl5eWTxmxcxOgyN0QVI2jfClEh9YMiZ19wJ7qwub2kENqTfRk9nNeYnFXocEt+K6DCBj6nOXh
	VEkCSjfCRdpk48aMe3hKAtXrUkVMM1rFzQDnX4LuedO5CeZieA4wmV4QT1iEPj7sB4NBpBweGM1
	Sr9tiXau6libCtnKKjUm3pNX4W9v1IDPeQ1LMHyvQIwg4ilWvHRQe3gObEQdwIlY3HuMoNI=
X-Received: by 2002:a05:7300:ce11:b0:381:a037:b060 with SMTP id 5a478bee46e88-3856e63b3dfmr13805896eec.9.1795465595743;
        Mon, 23 Nov 2026 12:26:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm36533049eec.7.2026.11.23.12.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:26:34 -0800 (PST)
Date: Mon, 23 Nov 2026 12:26:32 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Ian Bridges <icb@fastmail.org>, "Cheng, Wacom" <pingc@wacom.com>, 
	Jaya Kumar <jayakumar.lkml@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 10/10] Input: wacom_w8001 - use reinit_completion() in
 w8001_command()
Message-ID: <awShdGUZ-Ur-nLtp@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-11-lee@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-11-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:16PM +0000, Lee Jones wrote:
> w8001->cmd_done is already initialised in w8001_connect() before opening
> the serio port, yet w8001_command() calls init_completion() again for
> each command.
> 
> Calling init_completion() on an active completion reinitialises its
> internal waitqueue spinlock, triggering lockdep warnings and racing with
> complete() in w8001_interrupt() if a late response to a previously
> timed-out command arrives concurrently.
> 
> Use reinit_completion() in w8001_command() instead.
> 
> Fixes: 3eb1aa43ef5c ("Input: add support for Wacom W8001 penabled serial touchscreen")
> Closes: https://sashiko.dev/#/bug/linux-002efaac-c345-4827-8f1c-7b9d9226c713
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
