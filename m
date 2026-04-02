Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D71320A00
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113014; cv=none; b=LcmXpnsXgjtms+uFVLPOjXO1Z8U+9U9z61r4OfzanHHHRFeMsTqyI3Mid1x7Y7xukttAJsh4w7dPenanXGfCjehKP0Xki0SN0sLiIGEGPwpL0hV+DpgVqArrO559XgaZt3IoaS7NyvkClcISCNQpta/ow+iym9v/r2zsBVOUmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113014; c=relaxed/simple;
	bh=ePSGLsiMhmFVR8HfoS82y6dWU7vjGnh0+ppzLHlH0T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZhUH6Hnta3ba6AMfAODAIsd4fCpj2SWZBqAjXBgxBIXc3Ls6eiIa6ja/GYTPNAJiUxEf5izCjuiu0IkmaTazD75yT7X82M7SwdqsCEMrKv5w+kT3GLtuFSHBx3II1gAtdDzZkmCXczpJIVth8t/4I2/08DGxkWPTWi+3nEOsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94e578a0fa5so286170241.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 23:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113012; x=1775717812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg/9zln3oOsSy7dvNy1b6XIOWPnJXqk+HqcDI8SZtzg=;
        b=KLl6FGNkn+tCC6HFeqjvAhGsXLVVJ3SojUyfCJ+GLGzkR6mHDt5jkqDjHv+ZSFsTyR
         iJ9wev/b3lnW2wqUpAtnIRcAYoQ+Ra7NpXqczYeS8H5h7z3vKmKpmuuI7kXmmMzx3FCC
         R6OEAH+ivrBkOoQB7n7z6k+TnRiApUNgJBXiG8FtD3vYGZ5x1ACsOzqB1YGHsiWam06b
         fOeytajKZ/O9pvJt+gWXu3xEyW++bK4YD8UjDMnWb1s03CriO4PUYyFS+h6rWxy593fO
         Y7w/PmNPi1horExA5cN5o345uf23I7YQwZZXAUfWWsl2uziZ+O2W0snu1Zr/CQjhABoS
         QQqA==
X-Forwarded-Encrypted: i=1; AJvYcCVNPZEG9ODT3UOEjTUxyo2U0WLPKkPq88QfVx7ivg1Nn/GSlWdD0+l7izoh7nfCyQr/u9GdZbDTiIQpcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjfD4jSIct98r1UJdnkO+vlSGw5aeb0YboJ79/fFmsNlhk6UM
	8Be1tE/4u6z9GLdY9OKPtOQv8SZY3tpy/Gyzizbe9dJSy5sTzIsbRZT5gfPS0V9e7KY=
X-Gm-Gg: ATEYQzx1wKBZVndYGUbQ4masbeRafhVA+5ku850F8jZPpl/3Z984gtuILmoJVbAQHcD
	U4vnWgVAiJqXBuJzbKJ+HR9FyAN9ocJAisRighHsz+dCcopAs3gr7LEr6DRHykVbx73SvoEYg+a
	KjBM4hY328A/KGWlwOyQUVRoMCPw7uqVQJAoY7ZYplcXwV0AjMqJatrqtDbMbCakeTMYWVxGTLH
	FZ+3+hphrKg14Pr4Z45bCDm8PmQwgvwAH7RPPGTq66r7YK1Dh3fF4zJlMgGJSCA6l9FwJrZqO2q
	SxLe0OWeEoJyf2NhEjPeBnd+qNNNQTV3ETbI6m+Lh5id75U5vegewrcDdCuI5wpo5OWBxSbcMFg
	YjEtU7Hi2aQS9ilZebBfaqtT2Q5kF9TOqlL4BeZnDWUon1z4TDlHKWBvVrxABOt+4HXFfudf/Gk
	o2sk+7nSlt1MtlRsNyWpO3VeN4JiyUkNS86TPqlAO/WPHW+Za5yFRwVhMCiRHH
X-Received: by 2002:a05:6102:fa9:b0:602:9977:a4f5 with SMTP id ada2fe7eead31-605681b3d07mr2616243137.27.1775113012500;
        Wed, 01 Apr 2026 23:56:52 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e73126sm2676812137.4.2026.04.01.23.56.51
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 23:56:51 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-953a8eed138so318855241.3
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 23:56:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkmb9jxKOcEYGLeQ82IcSAykWJ6eOEM6p6P6M7lkyRwjd0SpJeLhMbcgCQH2wHPL9QRjp5dNOjiZKlKQ==@vger.kernel.org
X-Received: by 2002:a05:6102:14a5:b0:5ff:d434:b507 with SMTP id
 ada2fe7eead31-6056811633cmr2908434137.17.1775113011410; Wed, 01 Apr 2026
 23:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306104025.43970-1-phucduc.bui@gmail.com> <20260306111912.58388-1-phucduc.bui@gmail.com>
 <20260306111912.58388-4-phucduc.bui@gmail.com> <ac37o-N5lqFMwDCC@google.com>
In-Reply-To: <ac37o-N5lqFMwDCC@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Apr 2026 08:56:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6y4MkCYR-rgn=FA38ZUE_X=3oQWNOvfdyMo=D5_xoxA@mail.gmail.com>
X-Gm-Features: AQROBzDLl0x19_opYuA1X41uZg8W0wbeRV35EXp5674jHgoujIYpObmm59iBhFs
Message-ID: <CAMuHMdW6y4MkCYR-rgn=FA38ZUE_X=3oQWNOvfdyMo=D5_xoxA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] input: touchscreen: st1232: add system wakeup support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: phucduc.bui@gmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Jeff LaBundy <jeff@labundy.com>, Bastian Hecht <hechtb@gmail.com>, 
	Javier Carrasco <javier.carrasco@wolfvision.net>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

On Thu, 2 Apr 2026 at 07:17, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Fri, Mar 06, 2026 at 06:19:12PM +0700, phucduc.bui@gmail.com wrote:
> > From: bui duc phuc <phucduc.bui@gmail.com>
> >
> > The ST1232 touchscreen controller can generate an interrupt when the
> > panel is touched, which may be used as a wakeup source for the system.
> >
> > Add support for system wakeup by initializing the device wakeup
> > capability in probe() based on the "wakeup-source" device property.
> > When wakeup is enabled, the driver enables IRQ wake during suspend
> > so that touch events can wake the system.
> >
> > If wakeup is not enabled, the driver retains the existing behavior of
> > disabling the IRQ and powering down the controller during suspend.
>
> I do not believe this patch is needed: i2c core already handles
> "wakeup-source" property and manages wakeup IRQ.

No, it is not needed, as mentioned in the cover letter of v4[1],
and as tested by me[2].

[1] https://lore.kernel.org/20260309000319.74880-1-phucduc.bui@gmail.com
[2] https://lore.kernel.org/CAMuHMdUqiaP=COTkKU_jK6Hdii+YJ5+zXnxFkOOnhLri5NakTw@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
