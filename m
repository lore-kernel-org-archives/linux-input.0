Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11DB3B4CAE
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099908; cv=none; b=HVs3fI8+g+lfy+rhWaknVGdk+lLhkclC2S+p5Xt+TL3dDy7vxF8+y8IV38VZN6xDgjghWjEtdUOyFfnb7O+Ce8j29yfw2yR3vVpiKQIj22pg2sfQng6aJZOVTM5mYyE7vTcCE7trLHgPAfMWpieJwGJfxVH/URkbr7z0APULjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099908; c=relaxed/simple;
	bh=yjVvYWruYiurilUZGx3YmchtTkWBm32mvE2sRniBUkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1nZiHNVL4MRxELxp0iTrNXEBkK7U6Q1A98saVrOY3ZCeIGPCCPBOixLL8TEvSoCqxrsHmvd4fihLfM2cREJpJvnk2CLE4mz0eFDlnJAzYiI1COVwuTds7jy/pDX/+zjhxMzguVuDPgbBNu5aqNRMf8j3AY5yFqep6hZ6w4hffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-894703956b8so14331616d6.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 08:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099898; x=1769704698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RivxhFW3aLIuA4wf02xkjYz2Qc8LREwOTlCZIGLK+7s=;
        b=iS68GP7sY7oCIyEAxRh/d3auP7PXI1bspZwkBhyiLB3Z/U1LTCVPyOFqDvxm0E3sH4
         5o8BvbD9Nduik1tEQnuVY6hkKwc6mJPeWve+m3vJBJ7Ebef20JuY1EdQsS6W/1US1oFn
         rRQnX6dELglK38ppKuZa3AqEebxPNhkx9gjqX9usIKqk3XMC3A6y3D983kDFNKAVRnZ6
         eAeGL8uhIQ6VXl9akDL3IDVtYvndNRTKAHAlzaxdo2Ak51E6jn+pil7suT263uaVwEw8
         8Z0FXDmiLp8mnJijDjYo1qeX/At3VttKwrV6m5NkTTeSA3sDiqavueGmVK/0kCQ9pRl3
         Fb4g==
X-Forwarded-Encrypted: i=1; AJvYcCXuabYXkaUia85zqulv/AYHKOq31/gWr1+V/YZWMQ9YjXtoXbLiZisZswGn69uUcGlLucfWhFolCtLiSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34LRzuN918b/JXoILs6nxGiegBhh1od4AOfoaFDRsIGt+JlRi
	FAltz9ql9yUvCEFUo31xlg/0sIoGKic4Ts5STnI7VC7u9hMvry1iLNZ1YMmFZqnc
X-Gm-Gg: AZuq6aKvZbAOcu+QbnFydKin4f2l2GVcBLrPRdOkRemtTlZEjSf/N9MNY7UecD6RXUW
	0ogBeqoRZ+Qwp8lbrqfvKXsPjJXb+PQzQa6Wxy4qKG/uxh1XINzlpZb5ADZgZ1N04VmaTDGu8CU
	h61Ulppx7twmtVdGmzOBLVAOGT3rfvj059z9JtqRcyA3PQSdX68You/u7oCGkIhrrG4Oozp7QMY
	89W/UYOyP9SsvBFxq7rv+iwMTavL1XhbiveIhfGphb5/d4bciF/SwfhHWjDSePpP5h4dBp5eGJM
	qYo6J+VIGxWYb68qghKB8kc8ej0GeobG1o/C0tgIbbjOMWT0MOyH0JHROhAmJgCg8iHTpwejd2a
	2WVByE7BIXKppMJa9mm6HkbAHZVw0XarRyUzyK3fou1kLdqsifbQA9vtkv/voRGi17cUCZ60Ea6
	dLf6LbZbNUS6mJOPoqpO0aL0HAr8YWjYoNAjOLE81IOmrbLmlhKgo9
X-Received: by 2002:ad4:5f4b:0:b0:87c:2900:1f97 with SMTP id 6a1803df08f44-89490207708mr471546d6.44.1769099898330;
        Thu, 22 Jan 2026 08:38:18 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8947f19e845sm18754996d6.45.2026.01.22.08.38.18
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 08:38:18 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-502b698e510so13189341cf.0
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 08:38:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCZEdtKx3JqdDOZsaVPp3NUezZdVqIaIeUkmyez5Iwr3rkJEWlS9TxwoRhtdmJX2w8xU080/7weCKRhQ==@vger.kernel.org
X-Received: by 2002:a05:6122:8c1e:b0:563:4d66:359c with SMTP id
 71dfb90a1353d-5663e92322amr105461e0c.0.1769099515330; Thu, 22 Jan 2026
 08:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121232522.154771-1-marek.vasut+renesas@mailbox.org> <20260122162206.9wrHkrTZ@linutronix.de>
In-Reply-To: <20260122162206.9wrHkrTZ@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2026 17:31:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVs_ODx3eByHkU03vopUuLuY7=uRnfTKuai65jNr+xMhA@mail.gmail.com>
X-Gm-Features: AZwV_Qhrjqav4P9LaAmfkNarIMkgQPtcyvVLyM7bNci-hkGtkEP1lpbMFk1IY3o
Message-ID: <CAMuHMdVs_ODx3eByHkU03vopUuLuY7=uRnfTKuai65jNr+xMhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] linux/interrupt.h: allow "guard" notation to disable
 and reenable IRQ with valid IRQ check
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-input@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian,

On Thu, 22 Jan 2026 at 17:22, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-01-22 00:23:47 [+0100], Marek Vasut wrote:
> > @@ -242,6 +242,21 @@ extern void irq_wake_thread(unsigned int irq, void *dev_id);
> >  DEFINE_LOCK_GUARD_1(disable_irq, int,
> >                   disable_irq(*_T->lock), enable_irq(*_T->lock))
> >
> > +static inline void disable_valid_irq(unsigned int irq)
> > +{
> > +     if (irq > 0)
> > +             disable_irq(irq);
> > +}
>
> | $ grep " 0:" /proc/interrupts
> |    0:         43          0          IO-APIC  2-edge      timer
>
> in other words, interrupt 0 is valid.

AFAIK, the x86 legacy timer interrupt is the sole remaining valid user
of interrupt number zero.
Nowadays lots of code assumes valid interrupt numbers are non-zero
positive numbers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
