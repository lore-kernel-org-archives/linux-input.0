Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF531355B
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785904433; cv=none; b=ta3uZrO9F7PQW4A16ZPdPy3mSXgiB18VhLwyh9Vu+Lq8HANSeNO7I61s/Cfg++RPBg+dEkzzUSEBnrhEsQVMZ8f1ZxZwkCQDCXNwwyybD5d3Thx/Fiofv8qSzkUQMNMs3U2gvOxbB61MKnJ04YN8zLcdT45Oh2+mXt0lbDsJKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785904433; c=relaxed/simple;
	bh=hmPVkxHG0GAgX7S5j0UfseU867TpcLXvRK+Y2JAHh50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFmLGiL+OfQSuX2BqSp9UjQgFSc0W+i+igy7nPZXYmHDHgY7O1XJIGm4/XJC+6FE47DkETYFNj1ARLv6XJjMTxN/PDzTIzJ6qd+wx6wDxnswf0ZnCGOBW17BM5gHzQmPjmdfospfwC1shw+ccEVo+L1DEUq3NtgPWI5UHHV00tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw5pxP2y; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw5pxP2y"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso308630a12.2
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 21:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785904432; x=1786509232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L+VSIt/dK4uaFU6UoLSPrTrRpY150XN2pn30jvRWAek=;
        b=Qw5pxP2ySPYDEsCusknMzs54qVav0CARSAubYbI5ME8i3VJtd3FPc454FMzRmBA/is
         jETSr5LVCOmEMARJUl0Okiur7nvVDevjGk9zGnvNa0ONUMXipuGIX4qBHwZQXHqipC56
         V2ktohl5ol7gTBNnCoYu/UlrvpLeB0Pi+fwM8NlSiL7/ACCMxrzZ3aUbd95FthVbHOmL
         eASa/Je1/4UmBalRpoyup+hcggV9Grk02DvA/X7d/nVrF/vDlA7LPxHVQaT2z3A328ha
         mBvHmgigr6yF0Yc0bOA2RbX2ZhIlkGGxFQ9sGnDkA4YZupMVov+KnjVSFcV7HJIngbZ6
         EU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785904432; x=1786509232;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+VSIt/dK4uaFU6UoLSPrTrRpY150XN2pn30jvRWAek=;
        b=prD2UyYn51G/CgPCPjXGGc1tru/1MtiGoATjphF6AQRdT5dJziMpM9c0YnSa9jS/WU
         wc1wQE6APxpkRHqsGMp2DN4mwmnNLhx74fbLoooFe6aX6BDzAfE4ZZ4o5GjjOSc5B7O/
         wow8fvbS+GedmgZ8GEaZyqFXUFYHc0cxjFHkTIenxbqWbo+MMVUJ5mcOSrI4+E7xm23A
         sgJptedJmbdwEVUKQ94+z196XFLBvtgmPfEMx86Q5ExAdTkEIihMWPUq4ecTm8+t26pV
         c/MlcX7EYbzPrbJlqH5tOy88+iAxXkIvdvAch+kFkEvDXhM/h7F3xl7t9aenKLjCsjyE
         Z29A==
X-Forwarded-Encrypted: i=1; AHgh+Rq87Trs8B3taa61K7B5X5kul3x8qv4i7iEdE+OA0qL5XW325L8k0AaAJeWAamUI0qmPCu3u5tzbiyZWeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhgrfSAoT946Y+pJVLI30tXqvLZR3CBWT+7SK6bdSndYQGjtC
	um8Z0HGyiCp4F8wAfTeqQneVN1UnhUHXX1pAC6IZ0wy54xJlEvK/lxOm
X-Gm-Gg: AR+sD134unvDqEBsFAXEkJ7ibbfaU43uXgekF6JPebuX5CrbS+EPkMKmLV7tlDuzP2D
	WuZt0G6ixOOPm9K9b4JcaiotuJo5Op6vSavaVh0rzvhUdQDagGxOmgSZlbBj0/xVqGvag3amKSs
	h1M/+RD3PV4dxG6fdN5UnUS1fCEDf3sCrjjC4K/034hOUv803zMcMr7LnVhv7orxkkEs2QDa8SO
	aTbWr+PoAhYlyuwAKggNTu5xHd1F7KuuzOlHY/Vie1P5wEH/KbQH/BC6A4BTNhGfwpi1xX2bA+y
	Q2ZGrqQsMTQVHBtPpbs7gThF7V34u+IYO1yf/NDp07p055g/sx1/l5gpOYWRIuXOakHqxQtTdGF
	UrmzgZ6jzu60lX466S98Ry/L3Ia/hQDAQl35/jfjhisDz5LE5wWb4Zn3scqaUMPJwfKYNDeIU4B
	4sGISx9jfGKBhzE/c533FTdrevqhNwUvxktrXyUwuNidpgJj27nm6aScL4GNt6j1j7q56EaQROH
	wZdEy1WtQv9r2aBl36qVaXe9VWICA==
X-Received: by 2002:a05:6a20:d52a:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3cb85df276cmr4903580637.8.1785904431560;
        Tue, 04 Aug 2026 21:33:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf3a:ac93:79c4:84fd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be99sm19559233eec.15.2026.08.04.21.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:33:50 -0700 (PDT)
Date: Tue, 4 Aug 2026 21:33:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Samuel Ortiz <sameo@linux.intel.com>, Rabin Vincent <rabin.vincent@stericsson.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: stmpe-keypad - disable keypad on probe failure
Message-ID: <anK82Y-C2GCd2cBP@google.com>
References: <20260804141525.39388-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804141525.39388-1-mhun512@gmail.com>

Hi Myeonghun,

On Tue, Aug 04, 2026 at 11:15:25PM +0900, Myeonghun Pak wrote:
> stmpe_keypad_chip_init() enables the keypad block before programming
> its registers. If any subsequent register access fails, the function
> returns without disabling the block. The later IRQ request and input
> device registration failures have the same problem.

What exactly is the problem with leaving keyboard block enabled? 

Thanks.

-- 
Dmitry
