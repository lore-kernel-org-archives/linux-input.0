Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835801;
	b=cEWmns2LKe9dpqRTtz2ekoQ6IgAnASUBPMRFzWmphGIJSy9IzhSNRcYPut5Eet1uwZ0s
	 r+ofVPQHzWbaGTPp5SQd75oHE3Bse5cP2S2w6rluQbEC3n/XkBgm9HHOt4IP0HQS7chL+
	 zcYeSC3z9l1OsoBePRJINTm5JhE0MxwvXFgQRu/j696iPCEMKAaUHGMQ6tyDnunxDesCW
	 xL9TupHvMswIv3I/swWqeujjHKyHOgk084mbSMi3BnRo0l6aGvoKr9KfQgYzL6nyla6Oc
	 6BhxZ8sJp1bBfzP8IoqEWUR+p8mYaxNduiWvuAIBM/4EZmxefIxDEhbNaJ497MtiRTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5nFrUseiN9YOf0OgZ2S8yogfl08qqWr5d0TY5rbXHDg=;
	b=vE1WdpwmnXvwBepOfY2EdGfKGeaGnmIvglNoSVzzXr0yym7TUv90bqW/7czCwdYREAJc
	 lvD32r+UUqcQ8MfVmXXpRmjMijnNrA84vCDSzDVmxlHHwqF42+dIPY7nmXq5A9hjZklLc
	 4bS8OctIyamFqCqeQF9j8hjhXaWHMxNdUP24zK8qbSs8Mu8pibjiUKP50csPo5BgnHDdo
	 tggVmgDqhY6y+URbO5cTNVmhqKL3gj4k6jLjqyeghB1SMuIgrsJHOSPf+THIDTxJDQU3z
	 P4UMlrksrEOuzCEN56f44TFzr9UzAoYadqibmsZGDcCsyHrC63SLY8A2DhNeWEHF1pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTUWy8jM;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F9606A326
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 23:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66F9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTUWy8jM
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a3c08d6928so1986088c88.0
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 15:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793835800; x=1794440600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5nFrUseiN9YOf0OgZ2S8yogfl08qqWr5d0TY5rbXHDg=;
        b=fTUWy8jM1PsytsBsChYqVoszYkib2vcZrvOgSPKUcKRvOR2J5KlKs9FxUqVw8q8iFH
         Bc+DyvtMrivviUhsJf6HrM086DGRaC5KbowncGQ0/M1apkBieWLL4XEYGda4IKzCkmJ2
         9tgEdaQrKAJOCBGJVguKlOnY6y+l2arA7bXhdD70ekFiZVw+fh+PCR3KJK+teTgWZsx3
         Iex+BPdW4t5+1bylYB+A8YBcnddCBGtf4ZdVm56baw+25ZpVvLrU3v4bmPyA7c14pL8V
         9lJaNEMZH6a9oYqTug2PXqB86vxJCcWAXonEuz9BAviQY67Uf4ME4EEbBGhTn4ua5j8m
         gkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793835800; x=1794440600;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5nFrUseiN9YOf0OgZ2S8yogfl08qqWr5d0TY5rbXHDg=;
        b=k+XJVQQvuaauChjFGycz4u2rcWd74CI64vLXNPjPkmid5U7QMXY1pqZxanq30LcZJZ
         LvHCGhnIIEYJEqOnxMcvzrYhx656f1bDlNI3QCbUI/+llr8rsuFEpgV7VA0uZLF7Jx/7
         rsBtCghmYk8GQCAHmn1J08keyg+y5md/oPqp21D2bEw0S7vYUhTinb2IEbadnOm4nZSM
         ZxPmDAK+2CG+h2MRz7vA4w3yjgJvFf8SUtY7fkOna0J+3z7qQyoh7hT7wmOszh5xWuXm
         FpUMZyBp2iZzjZKqwfO5fgU9dfkYqm8QnltBvELJC5cAV/GA+50z2575oaR2M2DvTH75
         P/Pw==
X-Forwarded-Encrypted: i=1; AKwUvBz+89qHEKa4Nv367rIZye8SlNosbqQb+VUJ6ns3eD3II12xUbMkebMIb4we/CZPv2Pp80E+j1BWAkceRQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+I+/6a9AW5HHfg04nUNNNJsTytfyAykTKQ2bWX7gx+h40opQX0
	wq/BDtxFYHReuLjiXrOH3+4hlvWAfKij+UT0J474+micErcNSYKLAjh3
X-Gm-Gg: AYBFou2d5Y1CjkfaIFOgFTI2mewFPWAMH94sTjvZzBcRDz3uuTs6KwnO8uvquEV5+IU
	1TLnKpTB7vrUguF0gniKqtC2stDj294bOtmtWEm9KxvE+XuqAJRRfZ7S9id8EeLmr9LUEmL0FPM
	MUDwpaHr6UZ2mZRzXq0oPe7eZBLqxDV6n26cg0524cBsuVVNnXmftjK8WMvDS0tR+JJ51Gb/OlG
	z/FfSiccnxCum8GGcLOc5tNkiOW1D57lX9u8Q7Y05yp2UoaSLIqgslNuL+YoboDRhi1jbcJqRot
	XHQtkfnbkV9HVfKieP1OFE7fag/Nne2U9JTLYKTyCCG+zW0x+s8yuDfCq5ghOgY5XCd/KG/eOyl
	YPtmSYm3kpVbQtNdg0W4v9pWH4CCrLLYkBI9oSwiFpYjshClibNxhqGBwlPSq2UhZuqwFZMD+jM
	TlAVxQt9bbENed1x4QfbiRgI7Us792HXLfDoMfh/74CgL1m+5ccSxRGxX1sFsvSM5RMOsLXy9Wf
	D8LSRalK3tSUmWDITrBZn1zSFy9m4kPton0UTH6TzMgu328LTLHjrQSgBQ7ZVY8Ns/BBbhPmyM6
	+EjKkHraNq+gPLe6rLgPkWTZeaFlTypK8Y5GICajbUQWEzztL8f8UMp1sOmQCSzxj4oOgQ==
X-Received: by 2002:a05:7022:b053:10b0:190:da74:2c89 with SMTP id a92af1059eb24-1ac5bda4447mr27386294c88.21.1793835799860;
        Wed, 04 Nov 2026 15:43:19 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d36a1sm12650219eec.12.2026.11.04.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:43:19 -0800 (PST)
Date: Wed, 4 Nov 2026 15:43:15 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: arnd@arndb.de, marco.crivellari@suse.com, 
	bartosz.golaszewski@oss.qualcomm.com, tony@atomide.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brgl@kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] Input: gpio-keys - do not rely on debouncing
 capabilities of dedicated irqs
Message-ID: <auvDDyECLJsQdIu9@google.com>
References: <20261104185044.2551808-1-andreas@kemnade.info>
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
In-Reply-To: <20261104185044.2551808-1-andreas@kemnade.info>

On Wed, Nov 04, 2026 at 07:50:44PM +0100, Andreas Kemnade wrote:
> If no GPIO interrupts are used, these IRQs are unlikely subject to the same
> debouncing mechanisms as a GPIO interrupt would be, so stick to software
> debouncing. Experienced on OMAP4 using pinctrl IRQs.
> 
> Fixes: 3717194f2492 ("Input: gpio-keys - add system suspend support for dedicated wakeirqs")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thank you.

-- 
Dmitry
