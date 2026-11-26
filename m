Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672127;
	b=TEXcb1NqN1NFr600I8HLkJ5TjjcS/0/vq0BOvqlhts6Nc+mm12ZZM37zyIkGxyYeydUL
	 9Nlfyob4PR47zixxKw5EAbknZCK9cIU8HvM0ElgZOhQV51a/Ms+SBRd2pGLdl/BWUS7vQ
	 xOnsSyh3iq3Er6i6lpJHQhCejKNfTBdu8r9IyBI9rZz6IM5C7W3x4JLisaDZ/ZO4HLkqg
	 GKLl+6I9NjATT44pkvnNLKQiBN8xs5htYIfEWaY/sGeyFKaTVs8peaf6Ae9eu70V2J9S/
	 CWHjjpuBPdNhtdSKvmLZqGOCsyq0m2+ZbY1JtH+ozxwcKJC/DBe+pY83gQ6WH2b6PJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dB5Cc0GlIwAe8K481F3VemkeNW1/IrDh/4u9ChxI8ZQ=;
	b=MZ8gCWgtFgZ8k2U6VX6BMViJ3mgzn1JjS+MMBDQP8ExVbtYzV/YJzwa8fCGP14gae3KR
	 UO3nTGRh1ef2EcL+PvSA2NBIx0bBQo5DTHZjGsvrH9Mf3gGkfH8Cz17Y1VousP35vY55G
	 Olg61+sQNSLEdZUqkG32v1dphFVahyuLXCgAz6nBCcc8CT+X2nU5SiIJMoXzWtw6HfEaS
	 YL4TuEJ9kwnjHcUKP+1Wsm7RIRF9CwdJnF2f/L/58UU2vcf7QxxTFq9iS1JpGoMMDjsxQ
	 /38SeusoACiZxKqBAbbKXtZ7l1jjAaKq4GBy2F35RxgkaVPfdKEUJEXMZv26fBYCB6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y7cYVK4Y;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454C606A31C
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 05:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1454C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y7cYVK4Y
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-38692f62b22so8222254eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 21:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795672126; x=1796276926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dB5Cc0GlIwAe8K481F3VemkeNW1/IrDh/4u9ChxI8ZQ=;
        b=Y7cYVK4YAyORmvwJGgHQkJmCbjNQj1MahNRXOkKUM2+or7Dp3kSTuwH2dkxXorV5Aq
         8uQmM3WipZ9LGqJBq8n2JGs0CkQ1MQ84pF5Yb1KZNpcIKzXdHNKMWzI29/IutitHwcZl
         +Knni/KfskM/TU9DmO7AAFsnLNeTOUog59ju2YsxtYzeUQ/H5F4LWv2ATDqhfS6m8W4x
         B4VCNUsiQhd7yDMrS3iAcFyBTm94BWlfLgKWGoXO2DCTJf5Q5bhrMJl8H+nT4YDcamw8
         V0WWqkJYJ2EUlatDSqBpD6s2a3nOpkBBLgwEI68Uugntz0K36Z63fsw35FVvkJpVHWwQ
         p67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795672126; x=1796276926;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dB5Cc0GlIwAe8K481F3VemkeNW1/IrDh/4u9ChxI8ZQ=;
        b=BzEh0rGktVTrCzbqRI3Gb43vMU+Dk6OJFtJAOBDpEhGKbt/wDBtyiqpUp/otbA+viw
         wkgHCJtwOEcSpzGKssd9LYwPb0+9lm6SXR77vCs8kLJVVMezMzlATmax0IvtkxlkXaXl
         fRHCBb/r5+OH9eQEZsrIaDV0ei6AAar0yantd+Y9CWMX8rnE2iE8ysOs2XVZnA4XOG5+
         oIxFdW72ceRO3jh2sBtJzDUXXYYlpULiuQtXUo+fSknuTi4myunuN7PrwZ207RuhaMbG
         WatGRHIpAjAJBIVF2egI7GuKKpTAWKOGHM5ne4mYTgv94HLFyKde8Skdi3PVWuyHDtEr
         MB6Q==
X-Gm-Message-State: APuU4Z9HRHOROOWEjVo/wQhYHdMxJOvVut+4pKaJEOQ6di5xloM/hg45
	TylItPFJBWTvXzrIXMrgGoZmN/D6uaH6EiY6FmFY4C1zwuLbFA79w7/s
X-Gm-Gg: AZFdTZeOlO5eGIyUb5+qkAu7gFKy8ziIX2m4/TtdLwLRImiIfnoAWYNXBHv9sh4Qj9k
	o79x73jQR+ApHlODxkSxZ+vTX4s+70U0G4gu2TSlPLFPlLTMYwH354vjfqrvAr+5MJNSsbiVHFA
	O4+y0pPmGg29GupxU6q4fWgNfIzA0JKdq6p2PLEpbKHydbct9GETXrpo95Jkzdtkt1yeYNvxjYO
	Jb02byBW/3oWO3hoz8eBGQxH52+a6FozHsja3FL4hLPvv48JT8k21iAcpRIrnTKzwWxWKWQMqvN
	rBo2VF9TUn+p64TFbtp14vBFz/b7Am2G6lhzM3v1QHQliml7wQY4IfkQmasmmtOJdZ8UOCT+rYH
	N133ldkTfeoij4BXB7hPsy3r6qU1CWBibja+O9gFapU6LfZCVrVdoy8e1xAzQfnw/Df8vfPW75Q
	xwVFX4D2TV8WprHQslvw7tAHd7/EMEx/ZgFA5SM3Nh/aAJEG91QSvmnYBhGttnoHZtixsrHYdwP
	fImDsoRSv13BNtf1gBe3zqUL13woYWfrox+e+YyUhEicdN6NuCH5KbVQLoHYKmGYnAf0PbHosME
	E1y0YQWLMmKr/JsHBmYUOQwHjZT++iJ6J8ivgCFIBy/VHZbpn/iDz2n3ZmvwJN5EjPnkLyY=
X-Received: by 2002:a05:693c:414e:10b0:386:a1ae:6762 with SMTP id 5a478bee46e88-386a1ae6d5fmr17113659eec.36.1795672126140;
        Wed, 25 Nov 2026 21:48:46 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f528:8797:fe51:9f7e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm30832597eec.0.2026.11.25.21.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:48:45 -0800 (PST)
Date: Wed, 25 Nov 2026 21:48:42 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aibing Chen <chenaibing@cmss.chinamobile.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cobra - use scnprintf() for the device physical
 path
Message-ID: <awfIN2YNK4aY0l9l@google.com>
References: <20261126035206.1062-1-chenaibing@cmss.chinamobile.com>
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
In-Reply-To: <20261126035206.1062-1-chenaibing@cmss.chinamobile.com>

On Thu, Nov 26, 2026 at 11:52:06AM +0800, Aibing Chen wrote:
> cobra_connect() composes the physical path of each port as "%s/input%d"
> from gameport->phys into a 32 byte array.  gameport->phys can hold up to
> 31 characters, so the composed string reaches 39 bytes and does not fit.
> The path is informational only and truncating it is acceptable, but the
> call site does not say so.
> 
> Building with W=1, where -Wformat-truncation is enabled, the file does not
> build at all today; COMPILE_TEST configurations additionally turn the
> warning into an error through CONFIG_WERROR:
> 
>   drivers/input/joystick/cobra.c:184:29: error: '/input' directive output
>     may be truncated writing 6 bytes into a region of size between 1 and
>     32 [-Werror=format-truncation=]
>   note: 'snprintf' output between 8 and 39 bytes into a destination of
>     size 32
> 
> Use scnprintf(), the helper that expresses a bounded, truncation tolerant
> write, so that the file builds warning free and the intent is visible at
> the call site.
> 
> No functional change.
> 
> Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>

Applied, thank you.

-- 
Dmitry
