Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA941B8EB
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747135; cv=none; b=l3WLW3Ajp4Dc2idvXCvRsrd0+vA8wgFkgauzQTd6pr8y8esT6PVX/l2Z9BYfEhoQ8loa52r++411X5EarlX0aXjw1fsMZwV3QOdKTBx1OIdkkThku4qGMRREOH1SegxTQwOyDRo/nSXNgjWjTDtmf0yWHP4lPfOHpgah84pPMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747135; c=relaxed/simple;
	bh=G/4pYCI+p6biU0oob2SAOB3uONa8AVChe5krxzG7DZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/IaGVBprh96Q/UZHj9o9WT5R3nhrJdzHht1Bmi66JHyn6xRoLCgDTFhclJpN09RUtO38vOMdBy8yG4TDsJaCritSx0QdAUkAhT0981abG8yDwOyEB5Lg6tcTPjqZmhceP7yH/EL26PnJRtLb8PVRIHax3F8ryQdkREc23ykyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhUMNIPi; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhUMNIPi"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1369226a91.2
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 05:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747134; x=1788351934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QLB1RbqXq7v7CNRa3wJukW4z5hiwan9Z3mACetA9txg=;
        b=HhUMNIPiTSQVpBDqwuYr1bDNISgpuMItOcXrP8pRE91ZF2A1Kz6ESIQ9nndGokElNp
         61Nv3Mlz2+BCWHw6ga38qZHnQR1hd6hba7qAFyQB4Wq+eQX1ZYa3X2E8qCEljS/B2v7R
         auFYK8/B3vBhgBgOhDQhgiaOgIehTTNf1QYW5E8Ya4UfKmicEn/xdluepOMRoN78KvOl
         ukDq7CEomaNwUfDkNKrF5IgODpG/RCs5J5ehaJUWOSe8UeJsz1sSMZD0mmuJTlLLBxo1
         TgRc3X/ilTb5y8+QGHmu/R7oqlCI0f6h8jL3lQEZOXTHMISfPV4o6Shkfq3YFCr0HEN5
         ffwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747134; x=1788351934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QLB1RbqXq7v7CNRa3wJukW4z5hiwan9Z3mACetA9txg=;
        b=bpUjn65Z4xM8ENNvRGe08sadXKserTjXE/s7dpi8fDtgDaGO0r13gzUV235AiflJwi
         qjdg7Q9shJBkQaQtz/2ANthXhzXjKMZz7eDUolLkmieyzDkEC4IjY8iN5tckiV3VeBNm
         3vuYLODqrnU0mDw3nvSuFC0LLa8tAlXgpAZlLVMHdSxQ0Pga9pIVrwuTP5U6vKR1BQJq
         qoanIUhBLA6tkcFpe74Dq5wXYv0wvw7sZtpAwbGmJx3C7xelGKtUf5r8KTpEnmsZX9K6
         nye3vE6VR/ykcHuGRH4LemZOePHgpb3l3cADbUpTosZSqMGHXtSyW+2Dt2anPqNBSnXZ
         BC2A==
X-Forwarded-Encrypted: i=1; AHgh+RpVCLLJ4/zG6dCP8mf1h5ECGrCt9i+7GJAQG+PfrYhayWxWqeg7duhRG/lQYyorBgwGDTqUEBiOw+3aMw==@vger.kernel.org
X-Gm-Message-State: AFuF++kBoZ7F31+ERrDVGbrtyIY8gCN+qGnoVmVtgNtLz7loawzfFQet
	pOLGo3zPEkOJvalxV4fs8uHav/ViVipcrXNdEkMDyz54hYI838RQAcM2
X-Gm-Gg: AR+sD13UeWDAofeoHoW1OQuH6NVmkXdmLD7JW8HjD0LPAEm/zXSLSN6yP2JnZ6THI96
	kfJXv2unyQCwAZAp9GgoNS2HvVf1RjnOhkZQxlcZRq0hVu1z9ubnYHQ6UmoF8lageVGLmPwqVr6
	T5oTYMMFEEsvEqXn7vXcrc+kpMOlVtMqe0IWnOaNeSFHAH2ZJgLaW8qrDhOzldUnenznzOfCrgj
	h1UIGjMr66u9PHE5WHYd+yfUDj1OhhmOGAMXeSghItKvJznHqbqXZpwNM5WpD3UXqWi2KxpXgzj
	26i1TbtyPaXR4lMZKUlFUoN7zwJn38bqKIQNEy/Q/J1t+bnmYWlAr6NYRDPJ7fSB2g0tNUuoWP5
	IMGHMaZ4RmAlWBr5H52AHPoufhUqR5hQZybyZz881bld0p5EmQledl7tKgricOJe9TAz4OqFZWz
	+kcshJgf49FA4t6XO1CWANRqpDdKEQ/nuhKNNxGXs7u3k9ug6zK0qjVvMYBl3qmwRJrhogEwRj4
	F1JiSTwF/XttjF4R9aTaJBn7gxd
X-Received: by 2002:a17:90b:1dce:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-3966d3e1cfdmr13717327a91.10.1787747133812;
        Wed, 26 Aug 2026 05:25:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5877:641:857b:1318])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905c18bsm8457963c88.14.2026.08.26.05.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:25:32 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:25:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Xiaolong Chen <xiaolong.chen@gmail.com>, Yuanbo Ye <yuan-bo.ye@motorola.com>, Tao Hu <taohu@motorola.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: adp5588-keys - cache GPIO state before
 registering the gpiochip
Message-ID: <ao7bNPVKN1q4dWOS@google.com>
References: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>

On Tue, Aug 18, 2026 at 06:00:02PM +0200, Alvin Šipraga wrote:
> So as not to clobber any pre-programmed GPIO state in the execution
> of its gpiochip ops, the driver caches things during probe time.
> However, since those ops can be called both during and immediately after
> the call to devm_gpiochip_add_data(), it is imperative that things are
> cached before that. That's not the case right now, so reorder the two
> steps to prevent any clobbering.
> 
> In a conrete example which motivated this change, a bootloader was
> preconfiguring an important GPIO output to HIGH before booting the
> kernel. Linux would then inadvertently set that output to LOW while
> configuring a GPIO hog on a discrete GPIO line within the same 8-bit
> bank (because the cached value was 0=LOW).
> 
> Fixes: ba9f507a1bea ("Input: adp5588-keys - export unused GPIO pins")
> Signed-off-by: Alvin Šipraga <alvin.sipraga@analog.com>

Applied, thank you.

-- 
Dmitry
