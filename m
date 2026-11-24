Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484253;
	b=eQapdXGW/x84wujtAp9LyZJCGZZYJ2VTAf36wE55CyOk2VK/2Dd0mn18PATQ6cxAmo81
	 eZ2ik7tlNzn5x154r4QJxQu4Qb3HvBKUIrwjkIVSc5JMcz1VHBTj9uNy1Nw52688xDLIX
	 vjIpG3jz9UzCch7yVGU0rW+p6CqKBnwKD4DCs3ec0Xs37Vk64U9GELy5XBzMyf17R6FYd
	 td+iKy9bPh2bgRg52jtaChtpM5CcSUe9hVhniR+3TkfAZaU8/IBMIZaJuxdxWZupPcZBn
	 QGl8EoWl3tD1c/myK28SFxK8l/FUCZ/O3acoWc/bIBLGKKiDR8T0bp8GpbTYL+RqyFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+4GuLZnncWSPgY9po7iJToNx53KFsiruJ7YElhg33E8=;
	b=pzCQ14jt2amM1Ml2C7uDyttCrCE0V+VE6fW74MEnkUm1sEkvs73h1Z+qmC9LY3kEX+uj
	 UkQ0eJZ09O4zzQieLUVJM+Joq+HkhoN2MYHLS+qJy53uqpbeuWWz90MW/OHquXykBVJbc
	 J39ElwqUDIqfHfUCab2OCNrynib+ktrTitsS5lZSL41OSY1z/iXP3RYo42LzPIA4cuYkN
	 QrOzBi+HC10EMbgs/K8PVw01EhpXvNcPdeXEAz0zFumXs01MoiEOAKys8IwUPMXN6wEMd
	 TqHndgnf2gYIWfzz7XxOxxtN8JEojA5Gu0zXS3sL1K5iS9DR7bWvGCzHMz4LNjajm1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cimI2Fg0;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A70A606A322
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 01:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A70A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cimI2Fg0
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38699cf08dfso4156328eec.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 17:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795484252; x=1796089052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4GuLZnncWSPgY9po7iJToNx53KFsiruJ7YElhg33E8=;
        b=cimI2Fg0Nir9Ip5ELkjvEp3lJWUKanxHQHo6mRlDdF9wlRTzHWIDNjQbth101BjTTf
         OxBPdIsxXMaGy85nxdHqif2oLrjgyOY3Ux+ekWhX+/pUyyulMtreGKZTcyltAJxammzA
         zXl6SKNx7yy+/doSz+RMCEiX5tTgRSdA5aQ2hd9cBHMCsnXw/fWHbxWqqMjvxLMmK1VW
         SblNzBd21LlkC42g7TK1rVzpW4QmJmniuMWOHQvDyaAfh02sZGrhfS5FP9m6Ab7zr3mo
         XdJG8q0GqNB33VnviO5+34swSf353B5TcgS3lax7eCt+/Dy0SDcLUYGLJtEn8mU0xVm7
         Q9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795484252; x=1796089052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4GuLZnncWSPgY9po7iJToNx53KFsiruJ7YElhg33E8=;
        b=vZ4ki+xTFiMri24Bhxdd6yjC+SKgdJSvfL7Ma9IJ4uOKNRTiRFfW12zjN78TqZOhAJ
         CL5OFOKOvn+X1GJNVLwAnkyfmvLcYa80kJWnMSF/KaSA7XnQUBNhxE+XNka1jowfhVDv
         FmHhNkfgWtYuRXQRUnGEWSbbWHO8YOyPZrL15IVHRubT9CtB64qf7PdTZkI1j3dU+mKP
         vpOGZJullJVadD76/Nhb4UJ55QNo3qVxMTNEMEeD2L/4HP+G8jP0NCRfNBBFVghfnRbr
         M3T3CvrVSEp5HUg7JrHKuCi4DVIv6XBVrUQT6KkVMejjMm71uBCWrv7OHosB1Ynq/88b
         HmSw==
X-Gm-Message-State: APuU4Z8lgu7A9QwQQtFz7p3vvV0rMrOHWLGnOQN6ZGSoTYm81Jsr/Rzk
	lyhdUFm+UH4Oq82Cyp6RC/ZTN/OONGz/SJuERcEe1brSVWd++KjM+hEg
X-Gm-Gg: AZFdTZd5eIxTdGi8YYiC1obuLiPKYSmpcMoVrodiX0tQdc4bUl09OtPV32JQXtNU7P0
	QPOuA9foTEATvIFNVQs4jUZk5qwGvGCoO5f4czJ/G8gKNgQXK5D123SIblReGjAl4rm/AcWv0KR
	TJGThqd8q+qnPJmFrSBZmFMBt8eXlFBwg8ylR5IVbyhAkib1ueb1nWLSziG7clw8Ot2m3uSpIxT
	OLo0SwU/s4vkDCQHTjTIGiJlF40PRU0C9bqoohPtl6Sq840oZktqagIU/M94Ay+Ejat7mWphnkQ
	m07qlBeDuhSMYmvGsVFNQ6Ohlyp4poPDagO2bJuQIwgTVD53x5DbkUajVAIKDb2eHPWX1MrcYYV
	TZVWnhYLihGM6jnp6ASe4m+JO41aKIH1QmXovce1FFw/vTXpO7RKe02twPPLEW0KZd/C/JVISXo
	Q3MnKe1D9xnnOgFTRwa8ScT7T1YHlJLd9lL9fIL4pZCWCnRkRl/E7VTFFQwdWDlxgqEYFvyrI2y
	n6P3p/8oqvsN9NKHyiI828F7HFXRvjUT3b0oiswzjZjtKv7nDI8pQtWkwUclJzoa0HT5jj4mZPS
	1qyitRyplc8fsdDOBZ8+zWkdgt+ru59QK/P9raMZvkA5eAx3HON8C6WMec+8byL5GeMTbj0=
X-Received: by 2002:a05:7300:7c08:b0:384:3123:a0cb with SMTP id 5a478bee46e88-3856ff5b880mr21376997eec.27.1795484252142;
        Mon, 23 Nov 2026 17:37:32 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm33334473eec.25.2026.11.23.17.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:37:31 -0800 (PST)
Date: Mon, 23 Nov 2026 17:37:28 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chris Sutherland <csutherland.random@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 17IWC11
Message-ID: <awTqUmpSO79drKco@google.com>
References: <20261029164444.400649-1-csutherland.random@gmail.com>
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
In-Reply-To: <20261029164444.400649-1-csutherland.random@gmail.com>

On Thu, Oct 29, 2026 at 04:44:44PM +0000, Chris Sutherland wrote:
> The IdeaPad Slim 3 17IWC11 (83VS) creates an AT keyboard device but
> produces no events after atkbd init. The 15IWC11 (83RR) already skips
> deactivate for this EC failure. Add 83VS to that quirk.
> 
> Tested on a 7.3.0+ build. Without the quirk the device is silent.
> With it, /dev/input/event3 produces events from the internal keyboard.
> 
> Signed-off-by: Chris Sutherland <csutherland.random@gmail.com>

Applied, thank you.

-- 
Dmitry
