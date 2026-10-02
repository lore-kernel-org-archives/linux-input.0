Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD92DF13F
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915406; cv=none; b=Nrq9sDYF5CdwRGXHncTwV5pZbuvsUKziW0OYVMEeTXXDMegXclqMHUWjNd69xKK/ra1Io35xsrBWxrtKproYMf333tgpH74GaJSdZnqWKOl90E6G9RUrL4/S52fZ91sKNEgUoeTSOFWj4WajZT2D1ah4smMqPLY3V39C3HJZXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915406; c=relaxed/simple;
	bh=skCxL5kgdq4Im1kbeyxs95mJwjBNLk/dld2S/AnhFok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXf7Sv78kKzOZLepVYabDNbHTVL0svuAeep9c5LyadcHX2hDz0QdAhpmqqigWRuxbRucPOIK9RdVeNSnrIjS8MG7Ganm9J2BVG/QpOu+kQjWr3xIjfQX3jwa7GIi7Ss/ajf9Rzk5FPqWuqn8okdd4pcLiPGnozHIZW5oT15HliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QChkMo/b; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QChkMo/b"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b4f2d90c4so3189935eec.2
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 21:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790915404; x=1791520204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n1DNGli8LEQ3653hox2gDIOPWeBMifJ/aaLwIpGsDdc=;
        b=QChkMo/bx93LprKtoop79FKHHb9feuKERQ5ooPzPsiuYAXO6JXLTwdWd9ZO4SdQzqE
         IO11vw6xVvmW5C7CTixxGVZvD2fKQ3o4KdK3LjxdRwbEbNmAi1w+RXVb7jKLy+dAi8ZI
         XIwoBwB/LS0n6rEElNvFiQKQs3C99mtyK14XjmbE+6uI5aAh4PTM+KzPHB5hC4RTAWjZ
         O4Bt5NaNTamqgV4jb7Ny+Ecx/cYgV6EQ4gYEYmd6I2Q5x2Rj/mL+NmrXKw/xZ25gQ1S/
         S3y/4Nkt3kQ1T6k44it2cIvKv+bYjmPBMPL7cBq+nlYudJ+RnpvfrXrbwu1HoyxRmBrn
         qZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790915404; x=1791520204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n1DNGli8LEQ3653hox2gDIOPWeBMifJ/aaLwIpGsDdc=;
        b=tpWDV7uybLbu/apH5BA/OQc0iTlBzHv7u00Uc6F0jsTuRuEQ44xU9dDs2ZcnZKvriI
         jnAClTk2xM1UKNaVuhTAPY70H4mk5UXfpUHXbhZSIAM2Hrxz7UBLNHXCHG5kVNVDHAxM
         ngOPMai8ACthSB2OgTG9DMg62Uli8Iz161gD+STZZm0y3RxnoUYd7bM9Rcb4erUn6/IV
         a608Yvhq0MAEYNRy3Dlkgc5RteTVjXtBUrkAVxLyl75299jsa1o7V+ypYCSw7P+gTOW9
         V5KqdM3b/c/nDAAA1aUB80JiXL6ivnkP/34Ql2yHCaPui+gnRQTFOss3ZGm08fjrX0x9
         Wojg==
X-Forwarded-Encrypted: i=1; AKwUvBwTbhVI5LSoPub9DS4eHRnEeu1MlSwDANlQ7E/WdLTMqtd8cmTVVW9+aeSrVf8I+eJDecS+LdehssbzMw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLbrYjdkJQQPhFX3IEBodA7qKGYwynl7uSyONagH6EMsDGJossG
	dReKTHeMm86Ldw5bVb6wuqLrjjMSCqBVCZIbueQR8kvazmXqe76bepoj
X-Gm-Gg: AYBFou1aI+wzh/ji3sjuX9ESGtJSgtqgub97uuCQuGsYAqgE13pDj1wqrgd/GfkNlRE
	j3K6jx5qK2UZYiXmE70/ybOhxOUlmIVdB74hvprQWt9i7swVba/HlAjbpg+9W+we7waYvWSluao
	Kz58+B/p2s7qDTXh2s19VvGpV3hNPGk2iOWxk5CW0J7FjU4LmW35Xgtfs0fHkwH6HY6mLNT6gKt
	tgHODdhqoERTNlD2WLfHutoJT/1KtRGvkFQivA56M+1i0HwaMVz2aA0WLebRJ380ceoOmWL/Hwy
	0w7pZgVi6Dvw51lPa+cA2Bw9tZDFeFK9R0MU1ioZ9cGftxUpaWUYbQk9qGx1cfok+yaebeE/YaA
	p9i1ARHJRdIbAFUE4Tc1sWFDQl5u39TUlMS6jXof1LG7bReqFfzcukD3kb12BrRRuXP6EFxIbac
	3lkO0KmDlj9ryOwzG5gxavNSidoBImX+oC05pqHV5B92l7WcSLVQ0+YaseyUH+nstXEiCGDlHOc
	9fBeEaZQAWfbpslKIpL4cgVbteFqh/xpWVD+z8b
X-Received: by 2002:a05:693c:8808:10b0:33c:259a:759 with SMTP id 5a478bee46e88-34f21996151mr1636583eec.36.1790915403809;
        Thu, 01 Oct 2026 21:30:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:786c:ba70:85d5:57bf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fd9698sm2802618eec.23.2026.10.01.21.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:30:02 -0700 (PDT)
Date: Thu, 1 Oct 2026 21:29:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cyttsp5 - convert to DEFINE_SIMPLE_DEV_PM_OPS
Message-ID: <ar8zQtjdc88JWHpn@google.com>
References: <20261001175415.159900-1-diederik@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001175415.159900-1-diederik@cknow-tech.com>

On Thu, Oct 01, 2026 at 07:53:18PM +0200, Diederik de Haas wrote:
> The use of SIMPLE_DEV_PM_OPS got deprecated in commit
> 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
> 
> So convert the pm ops to use its replacement: DEFINE_SIMPLE_DEV_PM_OPS.
> This also allows us to drop the __maybe_unused attributes.
> 
> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>

Applied, thank you.

-- 
Dmitry
