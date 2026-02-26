Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60079364043
	for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104726; cv=none; b=er3KG7lHL/RdgGPKF+UAnYeB8WLEtkE4woTpBm7Kjq6jQJV9057EV9HDAuR94tjyw+jFFRHeTU1uAO2hVUPszHYXPP4wj3Un4uu0+SWbJrDJeM3jsd3ARVe8DGeknPJ/f4dqAkXsmLhvoGNO/iLFQ8OVFGmGIxQm6OeuYiQUC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104726; c=relaxed/simple;
	bh=ICU3EA6UgrG8p+rSNbvyBuEVUfibTv5KSnmzR93d+G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFx9GPjbPgUs6D9AZpQN81IeSMmvJWNqDyN9Sse8JuacH8lDBArM8a4N+K2wVmJcBBzekyqDs7ywGYo5AUbqc8VBYZWlW8H0aXBx1ePujxCFzB4Wu0PF7BTagWnV6QEI3onS9gXZwV5/T3/H3JxsEfkKo8aKHKOgEPaA8Ni7ik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb39647a70so64487385a.0
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 03:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772104723; x=1772709523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bnw64VDmOIsDBjD+cxaJBPxWhHWJgKFnBBtMRI3MdyY=;
        b=QFUbg6ji6OQ20FLdTkkQgT751zPuV2yVHd6BX3nD+CTOfAT1B2Hzf7ymX5VKMy+ZL0
         jJykBFM73+h/7C0wyhjr0akW8nWOxwCNfWoj8FyV5jdZ1Zq9Y/4Qm679l6Rk0Qams93t
         KtqOJzQ95W9DDGAvfORpSeJ7lMfvvBZ9QcNK7dHMKCpjSYDtoNHJKfFTMirg2J5/FfJY
         tr2FKK4V9XrrJ2N41+Ti3AHuUnxoZ55qh/jlXsMAc/CghOpdQIYFxChwXIQlPSnKSGUX
         9aN1LDU/sJNBax88fRNQHBFVYEh+w4QoiA44OJwMWfxQlUPuMqJz7vyikcAJTrKxQ+3s
         j9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG62UcjIvEinmdo+DG766+YFccK1qkkq5AEGRSJmHhw0OmxKVJGSrNFtv8jVm6NdM4tdUCaSHrUAfX9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YydlASODrhC99YvB5PbVBNRHTWZt0p/l8ckJCAcj4fY6TzZFAs7
	CUfjAnC55lhTCie0UXuvt+wUE2zfFiO8zNTbkvEKVEyB21noi+qBmk9E25E1DRhq
X-Gm-Gg: ATEYQzykXGmfRI1C2uCu6afV7qwDgNzyQKjwFn1TYzW1JnNpTIjLokEBoMRBolTNYx+
	MSmsS3Ys7oco0Ybd+AG8/wmpdbtimPJzNZRAYWjGJ6+YDsykyJ+vdhOfKmnxuDIBIO5pEuvmRa8
	LVJEU9cgE+A7MOmSqFoA5F5L426hA19OTgH9A7hRg/nBea8Wm/TD4Tgbqv0VEPy4SWLL8iEdK0p
	Ye0WwgJPAJECWv7rrGKI2Gd6nGkM4UEevZFQJnXppIo9lBcnaDC/cBVx0tKRuxeF6orSjSgAr/P
	9jS1KAZak633UM38nMtuX8OolqGi7C9wadsAumLk+jPfuFaq55al5pRThBeLpT9z5IJsoigB18O
	E4mZXngtZIO6yr9OaquEu8FTZaScictHSlrkc0y9J2gFvXmtSAxkrFwLU4mMTdeW1kP81Omxz8w
	bkNalCExsbaRh9IQH9bO965asYfaoJTXDuwr1mW5LWjB57tmOvxDr/UdqFxAs/Uori
X-Received: by 2002:a05:6102:6cd:b0:5f5:7718:72e9 with SMTP id ada2fe7eead31-5ff13e48346mr1525453137.2.1772097645850;
        Thu, 26 Feb 2026 01:20:45 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df6417a98sm1141104241.4.2026.02.26.01.20.44
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:20:45 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a91535e5bso214322e0c.1
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 01:20:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLdi6VDJsX6hrv6Wc5xLliZXlHUFYlPvkj/Ufyg4iKrv970Km2ZlO3nzL5ThhjWKB7WkfMT4x45Dye7g==@vger.kernel.org
X-Received: by 2002:a05:6102:1606:b0:5fe:12c9:6e55 with SMTP id
 ada2fe7eead31-5ff141ca4fdmr1209533137.39.1772097644539; Thu, 26 Feb 2026
 01:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225155409.612478-1-hugo@hugovil.com>
In-Reply-To: <20260225155409.612478-1-hugo@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Feb 2026 10:20:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVd0Ds5vHQa+MG2E+E36qAu5HQE3b+Vzpbv84MM=2DFWw@mail.gmail.com>
X-Gm-Features: AaiRm50xBGkpSKzhEw3ibXVEzal-pPxdV_uLqXQh8Zi8JcZzUL3k8C9xrOoM_9A
Message-ID: <CAMuHMdVd0Ds5vHQa+MG2E+E36qAu5HQE3b+Vzpbv84MM=2DFWw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] input: add GPIO-based charlieplex keypad
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robin@protonic.nl, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, hvilleneuve@dimonoff.com, 
	mkorpershoek@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, lee@kernel.org, 
	alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Hugo,

Thanks for your series!

On Wed, 25 Feb 2026 at 16:54, Hugo Villeneuve <hugo@hugovil.com> wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Hello,
> this patch series add a new GPIO charlieplex keypad driver.
>
> The first two patches simply commonize two properties that are present in
> a few bindings, so that the actual patches for the charlieplex keypad driver
> can reuse them instead of also redefining them.
>
> I have tested the driver on a custom board with a Solidrun RZ/G2LC SOM
> with three charlieplex keyboards, all connected thru a single PCA9416 I2C GPIO

PCA9416? The closest I could find is TCA9416, which is something
different.

> expander.
>
> Link: [v1] https://lore.kernel.org/all/20260203155023.536103-1-hugo@hugovil.com/
> Link: [v2] https://lore.kernel.org/all/20260213171431.2228814-1-hugo@hugovil.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
