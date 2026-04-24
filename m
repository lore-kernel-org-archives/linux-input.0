Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F103932F7
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044716; cv=none; b=MESXbPszEgQrG3bzHGeYpYe7+5/cja+VDg0uXU0SJAaafnWrBmcpYPuDmjamMzc6AdtKnCdi1bUToERTV+Z3Q4iYkFhYEvdf0GmPjTCS4C34SbRHuBL3K6vxJ8ppriY8bNxgRGJeE3HmqaH+S9X+qKAVODtE5aXy9YZ2ige8UjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044716; c=relaxed/simple;
	bh=otD7jQdcDLxaXX/SFvmfgLVOCJ6x6Ljebj6G+BBXCTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ/wYr8MyMRQHelSi+hgZUDSHgg3twSIPfzbYnFqrnNk8UJOmDo1OzA5IBrVw8T3Wy5Dfl5JSQ5o74tafx/+pWq6X+DCMwUMcq3VSVeidBmmD+blMvJM/aoNisjPyquQgLOdIzKFd321bfwuRvZ+CJFi4LevQSoZojdchcDNmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fks5Jd4b; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fks5Jd4b"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba895adfeaso8794432eec.0
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777044714; x=1777649514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3J8fVdyPxB0m2xHleeQEB0k0imM/1ZciMz1C7VyY1IU=;
        b=fks5Jd4b5wx5wDPU3rJvoFnDM2ZhAbwDdNjF7ljO+ZS4UEYddxsmPVeEqgnpoqkZbr
         PRW967WbdROt/JdZr5JtZZPs1WtZ93XmMP2EMnr/alflntSKpptGgZkNHoWBMe/Zzpj7
         GKJG+iL73h4QyolE4p815wrIC79TNWH1R99Vemw4T1+GXIL8wQp2Kbd1UiVq9o99PNV4
         Gk9vexxrmaUYNqjxrc/rpU0K1godWNP/pt4BRaBDFUxeEBJDYKuI5nGp3UPB9e0xtN5N
         gDWCXLFgkAhjKaQbe1mB4EbXYAFG8pVGwQ0/4igiOeanSK0fMK4b2ET9cR0OLgzC+ncZ
         2+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777044714; x=1777649514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J8fVdyPxB0m2xHleeQEB0k0imM/1ZciMz1C7VyY1IU=;
        b=Xl+5XTQNWWRYTT+2qnwfsWgtASSafGqVoVDaS7G2koY2Q6IjoIYE3gV7GCS/tJDYmJ
         0NgOKATwP0c5vTxticZxR7yWbfyD5E2V8g78ciK/1Ad3eW/gBWyLTXGUWLp8nT0u7EGs
         UZFkpEyGA1teBDNfJWUMHCu5+uQQKE7SagEkYXYkklWQCtwjtrWBpaTlV/V75HMH5gPY
         R5Ijwj5sFzRx6+nVh4D1+oxfbNfTHMHZ2pQBJr5KHEksIrScQSHKq5VlCb2k38tQNzcu
         6THIL2ThhuscXgt7VxnZ3Y+7Ahn98xfEIP0fl1YlIIfVAR8pC1gU1wGNjA9DiA77899b
         Sykw==
X-Forwarded-Encrypted: i=1; AFNElJ+aD0/oNekXjqm18UJodjg8NTV9Qvg3WZKRNCFf8cCimvIySch8xRHluIKa5ZCDZAtlOVBnrgD4f5Mudw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPFSQhCc3caBeFf3uRaD7XN5yNvia1rr53vvFgj6ViBEq+lm0
	MTaXUyhhCaDLwl4CNO/3oUqLjGi6HEB22SUJ6oHTk0jl+0g4Dd+jAZzk
X-Gm-Gg: AeBDietc3PVaVQ9wi32aTaFssEKV9F5ZAzd/4JI+qtCtUBFxf/RbhPEwnd8u2AEhyaL
	3d3BaYU1pDdgovYUZ38FwA+SqYcTQZmwWSunIibX5Niop3pvxZgWbren3MAfG+cnJQt0+7J8OdF
	zdtz8DlcHjxo8o7aE68cqdKxQcGPkM8hoxqz4fzJuZqspTdUpB1LOpZw0bfbF3Kqb2FfRom7QKw
	Ohh+AAmeAke0dSY5V20m2U35s9XxQExsN1ZOdgWFUz1+NBSqTNgf/dCP0ovsuE6kM2DtXP33KhG
	8biu+HPX4u7qK2JU9BXdeA9yiUlaIiWym9WH9PJxDrOdYgLSw/6pWZ7i2jrCBMJ8EFnn0hn7Tbd
	VIRHA1yMMBx3B46WaDP45FmwJl2afm/Rk8t0zgCmWmqrn2XOXur5n012KThQiVZ6uN7TxFeHGBi
	9CGkaqjV7zDFBLeM19ozqHlSkOCwkXicq2idfCjpuKL87pYt8FMp2BPUbXy6/Vra6A8sZr6ZqCT
	cM=
X-Received: by 2002:a05:7300:b905:b0:2dd:5641:f01 with SMTP id 5a478bee46e88-2e479110b4emr18033448eec.28.1777044713716;
        Fri, 24 Apr 2026 08:31:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f405:91aa:7e5f:f595])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c86sm38983450eec.1.2026.04.24.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:31:53 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:31:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Input: isa1200 - new driver for Imagis ISA1200
Message-ID: <aeuMn2w3kSUl-wxF@google.com>
References: <20260424071305.89503-1-clamor95@gmail.com>
 <20260424071305.89503-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424071305.89503-3-clamor95@gmail.com>

On Fri, Apr 24, 2026 at 10:13:05AM +0300, Svyatoslav Ryhel wrote:
> From: Linus Walleij <linusw@kernel.org>
> 
> The ISA1200 is a haptic feedback unit from Imagis Technology using two
> motors for haptic feedback in mobile phones. Used in many mobile devices
> c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
> GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> 
> The exact datasheet for the ISA1200 is not available; all data was modeled
> based on available downstream kernel sources for various devices and
> fragments of information scattered across the internet.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

There are a bunch of valid sashiko comments, please address them:

https://sashiko.dev/#/patchset/20260424071305.89503-1-clamor95%40gmail.com

Thanks.

-- 
Dmitry
