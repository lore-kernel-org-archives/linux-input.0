Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA351D54FA
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783806919; cv=none; b=msP49pG8hC0lKDnww3x7Fgt0BI3QR1qGOYAI7mIGQSq8XgqDEYqGf7IlTKmaS7fzjUmOdzOh914YbVa7gbFAaiWSz1H8jiEFoT0Kc527PXy68A++jyCJ6wxVTfgnIaEsr9bjDMMdDZCZAm4fm2+Kr1D7CCtoVBaBwEECg06HOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783806919; c=relaxed/simple;
	bh=+g/zQMRr25BR6fKjHXZoDZ0Xm5YR7ayk9SrrK7joU9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaHdYw/8DfW5/lWR2G9lUg2VjUrnYvLsICd3jtcKFc3GY8ZtWoMEsjy+PtlYu701sK491WdKhUjdCBaPV5lis7GEVHvb0gxTeQoNWPobWdfVE5bEpGu0o7L9jCXSnCQmzVonUnVitPw7756kW3zspuvgp34yri/jccYMX4FtWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEhPteiL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEhPteiL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1933378a91.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783806917; x=1784411717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8FLFQgdcqhO0RIIwKxkkuCrdHtU1MdsA2yWXjq6XIr8=;
        b=nEhPteiLMBfXyrY1gyPWawvaA4bFkYKDj2gVvJl1xE5oif40oGc71MPzcGjpeRhoXN
         +D+xBsOtGgt+B3jIWiY4vzUdPZ2oJEJCUX1KV/815B2VG+guVKsKdQpyi9B+oUQQDD1m
         7UiEtmOYAVV6QOMNzembBs26CTYJ5zJ0CVw3QmJPMnLtYmaMgVy7GwEWBzpPKGz+fqeN
         t5GPTZusvM7qtyfwICHiVkRNa4UysdhQD3fc1OaTx3jU91lRY3JEIBdq2X/TE58ee/YC
         dsP2uklaonChIKEGc8CXrjC6j1ZwwAJLkcJ3/PvzvhjoP+i8645rF/lT9rveU0jN2vU6
         +QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783806917; x=1784411717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8FLFQgdcqhO0RIIwKxkkuCrdHtU1MdsA2yWXjq6XIr8=;
        b=pwJXSYkosyCKCSPbnLdoX+nLXY5Q39lO5VLyy+kk9ihzB8//WqCAp7Z42/dv2Nvefm
         zThl7fpf5Bn9MuaYq7TJV6KGu5Nfh2WBwxBwfPfbB6Wph7k+FH9EADyUBNtCL5ZV+WmE
         +E1oihGP9vZHXU+b7sGy3ABzqQeLC9mBPc2Gb2w4IMOowdqzb+42WSsPlLz+0y1qJu47
         3Cb8BfydHgS3Wf9/nxmKc6dmZp2SYVlgVscqUxPzuEiTEdlkbJeBX/oKro3b54g7pXPl
         uG8PSkOEv03pRqGdEHztRMK7l/mBa2lkF3mIU0HilhvEfE8jL3dXhjhTXi99WJA6ozi4
         kD2g==
X-Forwarded-Encrypted: i=1; AHgh+Rr0v8PuckIXTcgCs8y04VeTgZYI8UTLy030774H/Vj81yFrhtUAC7fKsiGPYif7qcS3u8h64bgRIKfENg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykfxtVrZssO1n7ggR42Tc5llbZvw157vc/bBljbZ1HRi0+CrxG
	meea2kGMyYdNag9bTjqF6ar7SKQ/3qp3Lk9emcS7IUCYyae+duscEPVB
X-Gm-Gg: AfdE7ckoYqHLZnNTCJs6y0YAsz2mIujwIQZgsh4fWKG0rck56IBUoGN4AFf+6T75sG7
	nuSRbUICjbEUIBLIY6P2stst/1G6FfQd11iadk7G91/vu3sRTh7K67+QSB5aseXLWxxCYPkkx2z
	McPe3fHw2qttW0EuVBCG5W3Wz8gYErNP6fakDj7GFBgwaMQUa7ix8w9PhPuEv6yvG7QY8ksvTP6
	Wn/wPnrPvQTzMM/yOrSuiYklAl1rD1feksRzOBjcSl4DjQ1IE8xsJIGakJE8MUkqG3nLaIJZVOg
	zW5inyvR6Z0AB+00DuHHmo6k0KfheUWcv+d2IYtMmy+dtfDycKUwR3+DNw/3WUMkL3f06NXbEzs
	2MHfuZI/iK6FzekjKLKSAnBvwmV8jt6MbuP2PLQ/vYR0W5T7acVvLJIAw/odMzAQsHa3Y4yE7Cr
	gL7MNQl+GpxR0PqzeERidOc3hVpSLiIUcpjBl9auo9Ew2KTnPbQxC86HvLO0aqEKUf0uKoQ9u/T
	w==
X-Received: by 2002:a17:90b:540d:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38dc7752969mr3988834a91.30.1783806917501;
        Sat, 11 Jul 2026 14:55:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm35851752eec.24.2026.07.11.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 14:55:16 -0700 (PDT)
Date: Sat, 11 Jul 2026 14:55:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Shih-Yuan Lee <fourdollars@debian.org>, 
	Ronald =?utf-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>
Cc: Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] Input: applespi - cancel pending work on driver
 remove
Message-ID: <alK4jVB5dTp1nvuG@google.com>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
 <20260711131140.18777-2-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711131140.18777-2-fourdollars@debian.org>

Hi Shih-Yuan,

On Sat, Jul 11, 2026 at 09:11:38PM +0800, Shih-Yuan Lee wrote:
> During driver removal in applespi_remove(), the managed private data
> structure is freed by devres. However, the driver does not cancel the
> asynchronous work applespi->work, which registers the touchpad input
> device.
> 
> This creates a use-after-free (UAF) vulnerability if a pending or
> running worker thread attempts to access the private data after the
> remove function returns.
> 
> Fix this by explicitly calling cancel_work_sync(&applespi->work) in
> applespi_remove() before cleanups.
> 
> Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
> ---
>  drivers/input/keyboard/applespi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index b5ff71cd5a70..3bdb9e7cfb8b 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1822,6 +1822,8 @@ static void applespi_remove(struct spi_device *spi)
>  
>  	applespi_drain_reads(applespi);
>  
> +	cancel_work_sync(&applespi->work);
> +
>  	debugfs_remove_recursive(applespi->debugfs_root);
>  }

For this, and the next one, the issue is that the touchpad discovery is
asynchronous. I wonder if making touchpad detection synchronous and
making the entire driver as PROBE_PREFER_ASYNCHRONOUS would not make it
simpler and more robust.

It looks like Ronald tried to do that in [1] but unfortunately it was
dropped on the floor (my fault :( ). Maybe you can try it out and
freshen it?

Thanks.

-- 
Dmitry

[1] https://lore.kernel.org/all/20190721070523.24695-1-ronald@innovation.ch/
