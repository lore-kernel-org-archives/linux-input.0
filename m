Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586128;
	b=iTOHyMwPfV6BV3KK8DTSom5lkKY/PjWfq14S7r+MzwqLeBdgwuoE69Z3Fjhprz4+UlN2
	 LZ2v4Y75iW9BDyb3uwLUtOsipvUQ8Z+/jr98gKa6pczp2XtAQBU8fdasTDPqH5MsOTQp6
	 49Vskxpue6LyvU3iupLk3KtHkU+MqEI4Tn8sgu1iaVJidyKl3dVibv0EmlAioTwoGu0Oi
	 xeA5uwC/U0FaVwHrQ8mBpyP5924sX4iveAKMyS6ZVd6Mrx7wO+csrU8Ba7aheIy3b3AtR
	 Nuq9UARlTOSlq04ayYVN96OxAubEmhb6c5FniME35VYeNAPnEEEvW3CNVHYJ4Y3LRyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=5Uy8INcgxmvf3ypEhU++L0dxlWAvxIBXbMxHPLoS9dQ=;
	b=hL5rM6VkEs+h4ZC1kxtUfmGhd3daPFPa9llvJR6osLeD4nINgltlkaa8TmzleddYJqnj
	 ddCvw/gRi/I5y0o3mzpi2N+lWC4B43Tcp0QI6D7ccQnREyfv4TfLZ/W+oF6Vwu6Wi9AJF
	 fnrxJUuD4mPo/arB/YAVTLvnbt5UfV5uK1YZ40Sga6A5ZGrjU8rP81MhWmGdKvfCgZoNH
	 Kj8AYRaoUrue6A49La4T8qmwCbvxW/plfGj52cPm9WZH7yJxXsptJ1aSH3QMs8r2VxM6/
	 MglIAY4TW3fFiHskHK+nJnBegB4PVu9XKk4nv0xaFra17izw66GAAffqcoW8Nbx2F6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pohIA85l;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D4606EBA3
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59D4606EBA3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pohIA85l
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3acec6677so1379474c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 08:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794586127; x=1795190927; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Uy8INcgxmvf3ypEhU++L0dxlWAvxIBXbMxHPLoS9dQ=;
        b=pohIA85l3h5xXb9YDk567J+y4AgksW9R3QXTcTPMv+u/HCBaUGGJJifA72Ew9frt1a
         C7cIe9IeolLrjPTa4NXuKZ2fUTEaV8S6E1i9G1QPAgkyqord6ELkqpDKbo03zpOYg1kW
         ang0sUDw9uBk34KuE30avQn6bCkNTkGnycBciRGLqIeNJK23qUss+8OPDgYmCu+Lpvcg
         qmsidxjOj7QN2hxrkIo6VCvhC+fL6gMnqhYbMU0pEzPxMiJFwdMYwSW31PRYv5BMyiFC
         FBmnr04++b1q1/yAYhFi/ZHIf4A2n/f1EaLOGi5OMzX8zwfz+4wVJZs9whZdTLrjYCgI
         DBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586127; x=1795190927;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Uy8INcgxmvf3ypEhU++L0dxlWAvxIBXbMxHPLoS9dQ=;
        b=vIJJK2WH8DKBU3KAF8+6NH8ZEAxKBuY+1ufa9kfg9XpS75Fynl+zjl1/M9Td7g+kkz
         wGeTplwGOZhJVqmW7P8uV1tdow7h45IaVV78zdtOuACN6oP3JlHh0QegHxZlFj7B2hIY
         EEvK3iTCEYydQ4pW+WT8c+Gn9XKoAAvZR889u8uengPLcSc8RLjaeGnyx7Pj1GO8hAB4
         VZMjQEIHd1meSeskTmVothnvkJgtAt8t72taXMfa8C/J1+MEd9HzTsp3Tt+bpvpMuGUF
         gLu+KmMl4TZz1eF2d0YUrVv2AGETCRGXeClhSTk6p5JmPWk3itzCav1agqAo2zlTtbc0
         e6mg==
X-Forwarded-Encrypted: i=1; AL+hErFHSnLOTIMCD7vmvWiT7ayp6d04KBYdPBkJkJzsHk9ezPj3jVFRyzmNcEqXZBLbYT16GJTBDjoyvoFE6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9zG4jEATnCT42gpYwhFJB5Hek/enl5fQ2dQyw2ULyeRM1npr/n
	fGv03QrqM1kbs/+Gq7DhjgFJzndHTUbb6BDZwgoqHnzYpwPLROp/ydhP
X-Gm-Gg: AYBFou0pIVbaEUpR2rGYrLZ/WnR7/rIUknSFcoagkppbTBt0n+/vM5Sep3QiAhPgztO
	1hv7il1mIQlbixogsebhZlXo+1YBeQ4gwycHEGoIdWHz9Xn/nimH4I5FX9Ndnwi+i2phopwuUdq
	SyjkQRFDHOsQrodKZ8a8+tDbjL4FEZyV01w3RYcgam1qs7YaccisXpBip/hvl3cbILnuQaFg81b
	04XEiwEH2AeaWQv3j50zliWLPnA5gX8TWUJLsk8QRXqbhelKpnzbEY7bJHJuOgGCDe/mOdwoMkj
	fV37+/KGiIGPo3f8bLJRVok7EuTqEXBM4om7iJmmkdxrynVF/VwwWEBnWBlsghyOoHMeYoawoMR
	zd6tYDt7HQDLMk9nr2JCGmHftXVW7haqH7lt/+Tyht+5mztrI3Au37IG0CdC4cc5R1sHBVKzYKh
	7zGSPqYKvm6k3+ICc6YXmBlZs1h3wxu7svs0nlcwfanI2ruMos1o2iiLhXyy2sH6qXh7EGVFqM4
	vu2uDNjE52GWO09yFlK9akFSk2UqGWkiF53tRMePcWDEwizFBXNarcApvq8YFb0mUQOEdfzvc2q
	cdLLs7e0Gm66bbEocRtRtaETqPG2BOCnqxrYoubNlTybaIl7McjEsHie43gYB3ky3xIBqg==
X-Received: by 2002:a05:7022:5f19:b0:16f:c9db:c5af with SMTP id a92af1059eb24-1b5030d70a7mr2467351c88.11.1794586126660;
        Fri, 13 Nov 2026 08:08:46 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm9958884c88.5.2026.11.13.08.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:08:44 -0800 (PST)
Date: Fri, 13 Nov 2026 08:08:44 -0800
Message-ID: <563ab45500cc33d06b7973075635d0dc@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eduardo Henrique Teixeira <ehstbr@gmail.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	linux-input@vger.kernel.org,
	lovekeshsolanki00@gmail.com
Subject: Re: [BUG] ThinkPad T490 Synaptics TM3471-020 input lag and missed taps with SMBus/RMI4
In-Reply-To: <CAASp5sxs8o0rAe38Q4YZqK+F6st6TvxKSOR2RoKY9b1-gQCuow@mail.gmail.com>
References: <CAASp5sxs8o0rAe38Q4YZqK+F6st6TvxKSOR2RoKY9b1-gQCuow@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Eduardo,

On Fri, Oct 30, 2026 at 06:10:50PM -0700, Eduardo Henrique Teixeira wrote:
> I would like to report a possible issue with Synaptics InterTouch
> (SMBus/RMI4) on the Lenovo ThinkPad T490.
>
> Hardware:
>
>    - Model: Lenovo ThinkPad T490 (20N3S5DU1N)
>    - Touchpad: Synaptics TM3471-020
>    - Firmware ID: 3972349
>    - BIOS: 1.85
>    - Distribution: Ubuntu
>    - Kernel: 7.3.0-10-generic
>
> Symptoms:
>
> The touchpad exhibits noticeable delays when detecting finger contact,
> sometimes perceived as approximately 200–500 ms before pointer movement
> begins.
>
> Short taps frequently fail to register as mouse clicks. Longer touches are
> more likely to be recognized.

Dmitry Mikushin (CCed) recently fixed a performance bottleneck on
Synaptics TM3471 over SMBus where rmi_f12 was reading the entire
79-byte F12 data packet on every attention interrupt (requiring three
SMBus block reads and ~17.4 ms per frame, capping the report rate at
~43 Hz), even though only the first 32 bytes (Data1) are used.

Could you please test his two rmi_f12 patches (now in the input next
branch) that limit the F12 read to Data1 (~7.3 ms, ~65 Hz) and see if
they resolve the input lag and missed taps on your T490:

https://lore.kernel.org/linux-input/20261026142648.2567233-2-dmitry@kernelgen.org/
https://lore.kernel.org/linux-input/20261026142648.2567233-3-dmitry@kernelgen.org/

Thanks.

-- 
Dmitry
