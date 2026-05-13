Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E62DC783
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706040; cv=none; b=rQ4qfsymebCEf8jPm1YBZ6f4tp6yCu9jiz5PoGs8D/1nbcfA+9HCj1YKgf1fDlU0Rdnm4xt0VbU0rNsJ3QLL6ZJDGvPpSnZ9h+X+2wnkyFEHbDoK4ENZmNeK2UewSJ4dIj2WhluyarJ3O6RngYmcEULyrDeFzHPPfokW9GgbOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706040; c=relaxed/simple;
	bh=85eabx4FJDthIA1iiZuvAPiMe4w29R6IT8l+J1vALG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm8fNd9/fVJkVMmNYfgNI436SZ5pGI1eZcZRWYAWDCETD1R0wrGLd/ggdJvnPq+ai33iQUPneqxW6ZaKtQrBMuhBFuyK1XY7yB3o6pNx5zjQkAyyh22ht+HTzzlje2z4lNzoPVuacegUX0lsyftHpRpdaFntdUnwUID53VbrMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+qQMyAm; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+qQMyAm"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0ad52830cso10726051eec.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778706038; x=1779310838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdhepsCVtVZQ5kji2LOpAZF9HKifBLd0nMcwleNUngc=;
        b=I+qQMyAmBVUbyW8NafiArSKeo4SP8gaSkcoEYshaF1tTn3fSSRTARhSu9nYN76F7jK
         X/ZHeOaqM3bLQ8/GXthD8PF4Qp9QHhdrQg48sJXZeY93lAZjemV95NFe5rsrt1jvE/d8
         N7cUfsBZwx0KW7r0NDt9jNMRNayZXkq3p0p1zIJqjUwZ204lHSKJ5VFb9o9tSPN13Tbo
         xQfzIRVOGYmLqgMjZs6YGGN84bEIFPqoEsjwsfj9zEa/3NhIMEwJlSlyW+loAx4FHM6c
         eDCxY0erCUK3mCYrzDMX9eWIJFBuX2jOrNL5HMhOSFi8bMNgC/9fCdFzcyDLKRa3Bieq
         l+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706038; x=1779310838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdhepsCVtVZQ5kji2LOpAZF9HKifBLd0nMcwleNUngc=;
        b=laeU7M91j37eVeSowhv4A004O35ViBdG9kZgUXbYCkO40k+7GA+gLgi8QfsYWEE7tb
         3eB5QZCJO207uXbubAmh2iytF835ACFBogpfeuK2ztdgT/w/H1gnK4hVaWJJLr4Ai7wG
         FXnCGODeJ+KwuzrpcDn6KnJSvAgqIy5APWJs4yHxQo0tNJcC0UgpiQP7N34VjLwxkCjs
         U1w5yhSc311dd+/zZ9HmOxdZiHKTU3c35ruBy26hB+8m6iL8ngIK/ZJbGQH4gxtY3bsT
         I0CB2EOhf3cnWjpScaFtVSy05x5CHywRneJO6Eo2A5ATL9ONvkBE+nQ35xuBdrrpxz/3
         Bdzw==
X-Forwarded-Encrypted: i=1; AFNElJ95MsT6dbNYWaXOjlKeBpypiWBhuCrsqWccOAkH40oxjiZCj2+Qt12xDAyR94IZSkB3cB9mH3OIF5rszA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gHS528nEccEvKBSmkTI0fyYgeTZuMoCHfrfcPPeF+BChnUUw
	CE9PyrHJ1IHO6jpOd84PeRdmjmO6Ehr3pHEMCyvOnUNzUIzINmfMAxI9
X-Gm-Gg: Acq92OG3JObnyXRY9gBGnB9fnxyH2Z+YEkd9Ds/YYBlBRGJtT9TvufzVN+ubUPUGuMk
	t1toUr46jg0aQehMgq6wf5KbxUKOfEt2LrkZQmXDjJFiQIRXYXoK7QwbCA9y4XHpguYZYSAGPB1
	Dlfi8S5fe1zhpQLlTvXPHoRRgUL0NZa+LknBWPc5GohgKZxje532LcZQvdHGpv//Hk0UEDqfbxH
	fOsOvW8SVZsnm7PH7K8SPnAb2Y3bv61nKE4oTI0gm7HI4NRWv9eMo/WT0yzyiSifR2mZqt8nZcF
	1EpXwNIjtE0QtaL44aEUK5NEYyNC6ndMPn92xmB6FhK4d+VJWd4V6Zvuf+7xKTiQWI1+7CjG5mA
	mXDhHN9hDAGZUnXF8lt7xdMpQYOptlJx8x+pt0QhAnCLe5OcXeq1WC0DJnx48omCXZDIqrbmjHC
	38Z5cxQrZVAZKBC119Qqc+QUMATTT7W2oLu+1CZ+5+Zq6U2vlsDe7Qi/X+X0wTofwE
X-Received: by 2002:a05:7300:3214:b0:2ea:5057:a331 with SMTP id 5a478bee46e88-3011996d5f4mr3285400eec.21.1778706038053;
        Wed, 13 May 2026 14:00:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e25b:b38f:c027:f0cb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm520520eec.4.2026.05.13.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:00:37 -0700 (PDT)
Date: Wed, 13 May 2026 14:00:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ranjan Kumar <kumarranja@chromium.org>
Cc: bleung@chromium.org, dusonlin@emc.com.tw, bentiss@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elan_i2c - prevent division by zero on invalid
 device parameters
Message-ID: <agTlxHSZqSI8cnjK@google.com>
References: <20260513073908.3326178-1-kumarranja@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513073908.3326178-1-kumarranja@chromium.org>

Hi Ranjan,

On Wed, May 13, 2026 at 07:39:08AM +0000, Ranjan Kumar wrote:
> The Elan I2C touchpad driver queries the device for its physical
> dimensions and trace counts to calculate the device resolution and width.
> However, if the device firmware or device tree provides invalid zero
> values for x_traces, y_traces, x_mm, or y_mm, it results in a fatal
> division-by-zero exception leading to a kernel panic during device probe.
> 

Neither crashing nor aborting probe with -EINVAL is great as we will not
be able to flash another firmware.

How do we get into this state? Is this something actually observed or
just theoretical?

> Add sanity checks to ensure these physical parameters are non-zero
> before performing the division. If invalid values are detected, log an
> error and return -EINVAL to gracefully abort the initialization and
> maintain system stability.

That is hardly "stability" for a laptop when its pointer is not working.

Thanks.

-- 
Dmitry
