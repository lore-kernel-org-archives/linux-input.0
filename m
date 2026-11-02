Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636468;
	b=bC5fAmIaYRYrXt4XkL0WH+G87fQSzBX3Mhz5r/2yQSL2t9QhOfGbbLIAeQWpa5YlRmOG
	 e15PfjD9UUR/Cdh4ZV72A9xm1JyvTfEuG4y4KgkMZrzBqLsSH5tL3ZbEnnTSgZen8u7/f
	 drBYarPUmckg/xLMpZtcmFvdv6TFV2gdVoOAbMaMzNip3o7gkrCD1A38iuGik4deyKZtS
	 XkTYa6cE9VQKGmzfL0CdiRtnTb6SUaclBQZ/xuXvlVVibUucJ2ydQcWHAKFUDsSOVYIay
	 Ox3u0t3L5Ad+hRT6WHooRLdMLTD67BxPN6B8NklB7EJZjapZDH9fGxh/1IaS3asVvwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=5mo//5iszunT69Ntkv8F5KhrsTxnizkW5ppwaMrOTwU=;
	b=HLfdmdjI4AycOVpeap+GwpAJrF2bSq0sLTzG8iPCkx6s7/ZZ8BadIc19GfsruZaUQNyh
	 pUzdyLRJsOkQzm79IECBTK7NZH+X6vexMJfByKi8O4wWelfBgtEyUVIKUnUYiPcHF5v+q
	 r9gec6BXudd+JKs5zgrfeKLdxGAtNAJFZEVhmjlXlzEC7a0ucEa2a0ePHaaSLQn8jCPUd
	 vPv9VwzUbexine4+F+MJWpmVHoz8fQ3KwwhYaL80lPuicMWnX6lhu2KC3MAGpzXW906Pp
	 5wgf/6Ed/oi17dnqN3/EXE6HN3MiP5kO1lklj0nnyBXs2T8K7Q1zZohUxHt5RVj6kqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlWMI7ef;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90678606ABAA
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 16:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90678606ABAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlWMI7ef
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so2009498a91.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636468; x=1794241268; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mo//5iszunT69Ntkv8F5KhrsTxnizkW5ppwaMrOTwU=;
        b=hlWMI7eftQ8W/OE8uU3ILgMYzQHry+3zhXjvPuTaEaRJcpSsrbQHF4OF/9RCyzKcre
         QbfN+fMOFcIfH1vIe2QYShyHlsMrQiqkP/r1JJMP9WnuYgzGkX7uhuqNqgaEA3lVj5Q3
         1lgjCB2OOCjtZ4r99ogWkCgzewD6Tc20aV/ryg2L8mGEHZHgI14mfOJulrzLihKlJNP7
         y0+CN5VBHjwRNaCRq/KSaBZnxNv8EDfuXZWlhKgguoaWKaLwXH/uYDZbG+J6SoXlWDdD
         VdncapUpaMiXFOBDItiBK9S+SvjdzRrkYUSWMNSo0DYaTzKOHPuxb1nzrf2Jw60WPQy1
         oRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636468; x=1794241268;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mo//5iszunT69Ntkv8F5KhrsTxnizkW5ppwaMrOTwU=;
        b=yAWzhWhr9bn+zyEAz1uG8f/kxDjin6KS2vywmX8SSv24Sb2zbUekzWdTkSqlCHm2Pg
         gBV+CsYhqBDP33JDCjNSdOApycgJxMnZ4oIbWHFBx/SAFgrvylmUvZ1bh30i5S308MNx
         wweZEX3/nnbmUaMgG/eIukyw3ytAL1230TcUf1Ttfgll76c0zmmLMg+B/pft79ZBA43h
         PdASZxSfZgjiEZNRm6ErHY02cpsoTpePL78M/KCUWlrTIRzL9btcYQ+Z5zxst7eRUq0g
         9y79mYg7R4EhhqEZ0XpXfNODzi69CUvinHV6aPTTsx8L+rtTLdQdFPEPaoH6bttAT119
         P8cA==
X-Forwarded-Encrypted: i=1; AKwUvBz79RL6nL2Sst2tVXDIoXuY8qxqQv6K/z89/axsYGQ/ANe1GvdqEjwOR71sFumWhHAprArsfMUWjk7cyQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/TmSrJ3HHjPaSDNiyeFSveUo59kqBfozCAInyRdB/PYPnQp4OP
	DCVcmDCVT1SngTDqpPUN+m7ZgtQa+y7oft+iCngEJrIZ0oXCqt3rCQzC
X-Gm-Gg: AYBFou2+yGt+3ytzCYgAwBjXTDOo3a5lfp2V1URzayhxfgzrDHBmPLiWTondyrn8trA
	z3IbTouwboMMfjJiLIf3acCmMX8IhBLcUcXC5kE4Gp0/84Jt1W1UMb+YILjCLxdI5s3pceaRJFY
	6aIVme3UgPogUJ7zRfwQXc/AElCLNX6voU2+W8HSiXRuWKw8lUVyvMuiycfhP3uWBtkieL6tryQ
	epqLxkR4K4/18QllBiTMq9CKZ0gLcCga0jr9/zGXE+OFEFHvVzst+Ac57Hj7HyaicuQx98ov99r
	ZSav6UHkJkx3JbKHgB3ueMMvzlcYB4rUD1aE4A1fW6W1Hsn3JzcIQOsieA2mFTPgoNqkoGP9+hI
	v06RW/YAV4SQ4/AacGjjAqwhgg4QRq8pZDzav73YaWUlUzOperwXKVeV4P10G2wBt3PKW5pTW9I
	A2RgqVvdVkNh136z2eZUSNGYEyO/cOWqpFSCE545f3IdbxrO8/uWyVWjh3OfX7C4SfiNXYLs0u6
	DVO5qpPdA+s9isuoRye6PYD5CbUMMfdsL/xCKNTxL3iOJH8LubWXZcOkShpE3msuD0uWeOCMrn3
	LAqTAObjH5MMsS7QKd5jr/VlV8WbCfKBajjdmXEhMrgQnygxooBBphO25y2sIYOrFCcaPCs0FoR
	+YT7UUe0q277XN1aRJtvB+lDx1G2WnOlviQ==
X-Received: by 2002:a17:90b:4b8a:b0:3ac:9259:122c with SMTP id 98e67ed59e1d1-3ae8977737emr7944503a91.40.1793636467693;
        Mon, 02 Nov 2026 08:21:07 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm19939285a91.1.2026.11.02.08.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:21:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 16:21:06 +0000
Message-Id: <DMKV29CMKFZB.11MEZ8S0HXFE4@gmail.com>
Subject: Re: [PATCH 1/2] HID: bpf: serialize hardware operations with device
 destruction
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yifan Zhang" <yfzhang23@stu.pku.edu.cn>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 <linux-input@vger.kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <179362071770.29269.481376767482231629@stu.pku.edu.cn>
References: <179362071770.29269.16022650793604369465@stu.pku.edu.cn> <179362071770.29269.481376767482231629@stu.pku.edu.cn>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 03:58 AM Yifan Zhang <yfzhang23@stu.pku.edu.cn> wrote:
> Hold prog_list_lock across HID-BPF hardware operations.  Device destruction
> sets destroyed while holding the same lock, so it waits for an operation
> that has already started.  Later operations return -ENODEV before reaching
> the low-level driver.  Apply the same lifetime rule to output reports.

sashiko is right. This will deadlock.

pw-bot: cr
