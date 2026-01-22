Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A63A5C21
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114715; cv=none; b=SWgq5O87DvFlKSfMV0Lf6TKx3vInL3iJ4NLO2z0QpycuhFho0OPuBjPSb9VqhCex0Kundiqq4kHcuyjlvT6gIPNxLGz9mwoH6SMmbsCLQu1d412SeoXabkM/EFB8t7PGmnha8wrH02DmTuFw6i1v5cTjbXIekf1FHgk8K8p7Qbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114715; c=relaxed/simple;
	bh=NKKxp8XslWhqHgE40+VZpWgrnehA4xyD/dkaXnrk8dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtC+GZB4CW70ZMk6c/2Z637zmSwW9lFzMMX/FyfOKysLoSdTlsCa4JC3KiN2V57tMYg7R4UmSCaUpvh/WXSULQClozszlfuuvzMCYNevHYIK3102iRZIJ+p908O3LOqTj6J1kTVAZF1mPAnOY2zFzY9YOCiyvUDdYxJnSd2czD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmtfkiHz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmtfkiHz"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-894703956b8so18737106d6.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769114702; x=1769719502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTNx2TZxkL4VnUPzuBRv8diBN0csSmN/zfw5ymS8riM=;
        b=JmtfkiHzaUyP+RwLciTo31s1foWW/g5wEdziASi5cz7YVN75Knmu6ZDwOCsuoJHdp6
         lvNLBuCzB4qQaXcJheQ7dlqMXjL1FZ1q2kcuObdzSmCVZH4IW6j2XwAKGmQ48smIS7rd
         CPRZLNTmRbZsnWYBQUzPZPnvsAuGQuYr40KVquaweHPehQXO4H6fbIfdLN67ZjX6rDrH
         lYUnYfGqjmJCf4Xa90E1dkAEoEr+4N84fAEFlLPsAN+mnZmAgbQ9Jfu8DzWPGrp8gQJ7
         g7X3v2mvVKWXZZxAWoct40gASwKS9QaFK2tjbUN7L8+i8KAG5pSvglrkSIJSsTwUMSb4
         LU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769114702; x=1769719502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTNx2TZxkL4VnUPzuBRv8diBN0csSmN/zfw5ymS8riM=;
        b=BV2ikW3hD1MZtnjcXscJGcu7cC1ZoYE6CBMxXHXDDrXtKOg4Jsb7uLeUKsXlZ6ADDA
         ef6uwIn/y2T8fYXpchTrQxua6OPmog8JeJiN7s7x6f9SeNR9O61uUD5eq4AUpFSE+31G
         /OndRQWy0M4vaWYJgxp6gxMK360zGwKkv85N1isHB/yVqZkrZCJcgxTP7iHfASZ2/tJk
         TTZBZ3SuvSJyB7TQHqTORlH4qZ2rAZq54yWHeBj3I5YvDZfK0hPoG1xNaKQdBrV7TwpH
         /qn7sRHXq8ql7HzCN4ixarNk7mZl0usFoYMjKNW+FzOtkqAmpcM93qaV2Spc51lYf6TW
         eG6w==
X-Forwarded-Encrypted: i=1; AJvYcCXsj2Ac+2oYZzd1eyAIJ4JNYSLaOVr8SXkXEn++K5X+gMcQpqvTcrdu7I1sVECY7GjJg+rZYIWW1HI4Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylrJEsc2mq/yKb59r//Gb4zTR2JERQz3/CNwPhyPo7QmzJHPxh
	ZcTrrchpNSxQAXq6ZFtgrv9UU/sNXSDqr5TS1h5pxX+09V2PeuMXe8qpLzCJKA==
X-Gm-Gg: AZuq6aJ0SemCaucKBYPD/kcTJlezuatlk+qDL867pXtdcjS/zhQMIBMCt7pysLFzpqy
	RVbeFHpzXo7tkR8Qq3onuTzsu2vh1y3vh9X+8RLGUogYtWfSDuLYajUu9xX1rfofNMiCMgX0okB
	Qy4VTTFZWeklVilinZOoGS1ZzzdAbjx7kSg4sDAIonL3hkAj1HY2x5+KZ1qTDFr6Fbkw+8/cSL8
	ZsidnL2O+TMOj/BJeCGF6DLcI6xENmDi8QAS7r5p1CaJbFGzKNbKhZDoaTVTqP9dXpJ5ahfchcj
	cBaDwwejddrd5+Sm8urvmfDwvlaVPodDzf2iBkrNw4PAM8z9J68tXCL97/+IfRKKzVoOb0a9NgV
	ML7crDrnQXm0Taxb9+fCGT2A1fL5TWdztmFjYhUsyHqV8EW3BHPKj95059bMWB9mONGgLLHxFge
	xxuzHTw+Hw6ug0MEYcf3opxJHtR7mKknV3Ulo3vbHK4v5QwobiI6I=
X-Received: by 2002:a05:693c:3116:b0:2b7:134b:fd47 with SMTP id 5a478bee46e88-2b739994e28mr134644eec.16.1769107103324;
        Thu, 22 Jan 2026 10:38:23 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:777f:716:9c18:5588])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa2a3c0sm136300eec.31.2026.01.22.10.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:38:22 -0800 (PST)
Date: Thu, 22 Jan 2026 10:38:19 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-input@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] linux/interrupt.h: allow "guard" notation to disable
 and reenable IRQ with valid IRQ check
Message-ID: <x5h55qxfl4yrkhgwmijf37zfwqt52pmsts6whewniukbhcatbn@6mo3dytswd5f>
References: <20260121232522.154771-1-marek.vasut+renesas@mailbox.org>
 <20260122162206.9wrHkrTZ@linutronix.de>
 <CAMuHMdVs_ODx3eByHkU03vopUuLuY7=uRnfTKuai65jNr+xMhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVs_ODx3eByHkU03vopUuLuY7=uRnfTKuai65jNr+xMhA@mail.gmail.com>

On Thu, Jan 22, 2026 at 05:31:42PM +0100, Geert Uytterhoeven wrote:
> Hi Sebastian,
> 
> On Thu, 22 Jan 2026 at 17:22, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > On 2026-01-22 00:23:47 [+0100], Marek Vasut wrote:
> > > @@ -242,6 +242,21 @@ extern void irq_wake_thread(unsigned int irq, void *dev_id);
> > >  DEFINE_LOCK_GUARD_1(disable_irq, int,
> > >                   disable_irq(*_T->lock), enable_irq(*_T->lock))
> > >
> > > +static inline void disable_valid_irq(unsigned int irq)
> > > +{
> > > +     if (irq > 0)
> > > +             disable_irq(irq);
> > > +}
> >
> > | $ grep " 0:" /proc/interrupts
> > |    0:         43          0          IO-APIC  2-edge      timer
> >
> > in other words, interrupt 0 is valid.
> 
> AFAIK, the x86 legacy timer interrupt is the sole remaining valid user
> of interrupt number zero.
> Nowadays lots of code assumes valid interrupt numbers are non-zero
> positive numbers.

Quoting an oldie but goodie:

"This has come up before. For example: for an IRQ, 0 means "does not
exist", it does _not_ mean "physical irq 0", and we test for whether a
device has a valid irq by doing "if (dev->irq)" rather than having some
insane architecture-specific "IRQ_NONE". And if you validly really have an
irq at the hardware level that is zero, then that just means that the irq
numbers you should tell the kernel should be translated some way.

(On a PC, hardware irq 0 is a real irq too, but it's a _special_ irq, and
it is set up by architecture-specific code. So as far as the generic
kernel and all devices are concerned, "!dev->irq" means that the irq
doesn't exist or hasn't been mapped for that device yet)."

https://lore.kernel.org/all/Pine.LNX.4.64.0701250940220.25027@woody.linux-foundation.org/

Thanks.

-- 
Dmitry
