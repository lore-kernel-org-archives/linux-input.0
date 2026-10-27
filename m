Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062586;
	b=rkYFGINzgVcZ5X+t9ik6//w0gpbXYQcGc1uQRySwhkqx0VTZxf+9AgewoPSxeaggT45/
	 N1WIpZsnpTSMp2Up5j7Q9fxKXMWEOwvdq4pfEge7yzXRj8MMABglaU9fKFN4Eju/Ga60r
	 +VE8KKZl+AlgBjuvulX6zCpJ7UhDd8svYehZtfimWid2iOGzRd8SaWHBUOjnTeHWXDySi
	 6D563EjSKGQ/sOy8tHH21hQbXruXicqcPlGyZ691XeZ39AqXMzoXol73cBq2ZCDSAtCjP
	 ifoeyhXTyG6VhkuxnLTDSkBQH4ZqJa5zV1IiC1zlFyPXvNh1cKpy79FmDzJWGYMcsMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fvxA4psjvpTikdFCmDiAeEgeeyr+lNEAXNl8+Et9d28=;
	b=zq826YRc/7Zwky0Nr8hjavjdw4IzHvcs5c0EQx1Cxna0Vw8E6CiPOVUar885Kx1lF6BZ
	 JNlbfWtrgqomlYddxew3DwPcwkp55h+9MiMRtVwHdzDZfcA0tldlk9G7FYgwdhwZUBPzk
	 8mnFnBSigdfzwa+z5ZJJKRkJIBZz5C3WZ1LT6KoEjS90391vH2hVkPdCAwkVqTL5EGJU5
	 o90MttrFxhpBvvkT93uLfrq6Xlx137uQ2w9naUgiQpu1IFmNV9O4PTlkfu4sTYKyjAnaS
	 3OrxOLS7flPB6clTxKsIENqfeNFE9Q1Vb8nSrn1NpCgn6kK5S/3/tCO5fDl3Z8VSkpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hYwrj0gp;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC267606A31B
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 00:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC267606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hYwrj0gp
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15ea896ddc8so6189934c88.0
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 17:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793062585; x=1793667385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fvxA4psjvpTikdFCmDiAeEgeeyr+lNEAXNl8+Et9d28=;
        b=hYwrj0gpir3Tlmc3k3ZI/BsJn8CK4+Bd+IuUXX/AMkRr7RGzR+hSOP5Uq/CCszFr4J
         /C1ZB+43JLs7Ykk/cCDv2eLVY9WwjQ7sTTKXrd4agciy9z4oSDCb0W6H2rxdmRk6UDCE
         WEMjb2oyaChE3XTjy6higzg9J6YiUSS5xUNElGzYcFxhDXbUU+E5vuNBJ87ojBZiHu7C
         wU1B71B5z4kKCHgLQpZn0AYXFH1CR5V/aZpYhgwUF/p5gpZhJ1YU9ErKklbF8RWvFyLo
         90P178pu8LWHpEKRJcwJxk8uo/d3iLvTvAO2OTuVuWQNNvr7pze0Cunazmtaj0Jc/QVR
         uMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793062585; x=1793667385;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvxA4psjvpTikdFCmDiAeEgeeyr+lNEAXNl8+Et9d28=;
        b=Kq7HfEeRlCLKIElX0mdpY4NnOTd5EbYusqA1b3O5uRuFB3uvz5HTxhJWaYoPa0QZHg
         LV5Vu8130FsBUj4aozThAl8DGGZx2Wzr3rN6ueSH3PFuZJrpxywTR4wiWMy5HC9jrL98
         Hze+GUgc3QwE96yNfm3vhRB5gmIkfvutWDzGD6iqTSGvsOoo0fmAgIX2yzw5TO/AuQPP
         M/TO33jSDczln8Xbz0uv3yKg0gHHliaXrE7HrUT4Z9U9PmykTKLLPs83o57wJjpIbDWn
         2FKjRFfktASnvLk91FrPra/EWQY3uIl+8gviNu5RWabPwVfQuM7eYyVo1pMgu7U4nkkm
         E+AA==
X-Gm-Message-State: AFq9FYL1LxLGcJXOeNPLncV/rDjRGu1vxjpS0RhTpxn2PzJnxvTO6brV
	Pa/AgUc8XIlxqJyqJ9RwF3LcMYQBv8ZFFHj2qqaYImFol91qjakgTLUb
X-Gm-Gg: AYBFou0/FoG79h0E4L+BuSHLMxbBoRx+ZvwRvS6qBsaYWB5tljYzBA+2L0wUCkMf+hH
	SsGqFiRamrPQUbHQsighm+eDHMJghw0Oz6n8cY6LlGRYoiTUHhXz5523+jTozCR9PMUK6GCrSHV
	6FKotaDk+fRwigH3G+6+6pMh+aH/UbigKW/9EaijSRzm6BN3+QRBpKV0fncuHauWJHYg829DjaG
	YtG9ia7MYabqF1qnmOvWeLhJX68lWjyy/25McppOwGxYTrWKAnOJw/ZJYDbxAyLSWV6wpzGbF19
	bJnL4KU13PC73hLA8zRLIjLQbM2tVAdyxXiJwHY6jqBV8nfC/PZsdlhLyexeULZWfwrDsi9dg17
	6/UnPApWv5KUSCwIkzAx7k7tKJbInbs44o945LypiO+J3S/um0KjKe8gvavAu5ZYuliIBqunI3P
	WKOhsl3NTpF+8oLVm/QuMKcaUWpKiAQX5O6TZVuRcSXXxT4xV6dZqnpnsJ1SECOSohbtY3I/CS6
	uBfP8O5xnmnzW88zPUoPqXSjZtuLGi2Jmk48fuqqxHzbDpnFm2jA00vP2cl4DVkYm6CdCDU85CA
	FWChhXTvp1G3T70LB0gURg==
X-Received: by 2002:a05:7022:3f07:b0:144:fa57:c617 with SMTP id a92af1059eb24-19935dd7f53mr13799364c88.34.1793062584598;
        Mon, 26 Oct 2026 17:56:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2dc1:2e1d:6b4d:5a9a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a470sm25575440c88.2.2026.10.26.17.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 17:56:23 -0700 (PDT)
Date: Mon, 26 Oct 2026 17:56:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/4] input: use devm_pm_set_wake_irq
Message-ID: <at_2lPLNBh_CQKOh@google.com>
References: <20250205-input-cleanup-v1-0-9758898ff8cb@nxp.com>
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
In-Reply-To: <20250205-input-cleanup-v1-0-9758898ff8cb@nxp.com>

On Wed, Feb 05, 2025 at 08:45:13AM +0800, Peng Fan (OSS) wrote:
> This is a pick-up of patch 2-5 from patchset [1]
> 
> Since devm_pm_set_wake_irq is in 6.14, so resend the input parts.
> 
> [1] https://lore.kernel.org/all/CAJZ5v0jb=0c5m=FeA-W-aG30H4706Ay_xCHTsiC1S-7MuGxqTQ@mail.gmail.com/#r
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (4):
>       input: keyboard: ep93xx_keypad: Use devm_pm_set_wake_irq
>       input: keyboard: omap4_keypad: Use devm_pm_set_wake_irq
>       input: misc: nxp-bbnsm-pwrkey: Use resource managed API to simplify code
>       input: touchscreen: ti_am335x_tsc: Use resource managed API to simplify code

Applied with minor changes to patch #4, thank you.

-- 
Dmitry
