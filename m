Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2123E32B
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769319013; cv=none; b=ItfRmlGiBpwEPrfrrf0ZJp2pr4xsiLkausHfjoIg5cwZ65evirJRrPVEw0wJ+CU2h3a1p/EpDBGVwLvbMghDe3EiUem6/QFDWEmctNlXWIJPxEThhZ+hzbkFxwInff6H1GULb9vJOjnuHL3BevbzgoFpPuuX4kmStzTbDUQwyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769319013; c=relaxed/simple;
	bh=Jt1WVQ7kpD6vAUdyUPQXEmWntKszXzMyTQU3h3Iz/qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaAFPh6f99vZC6HWl6vdvld66qaHK6Dzka3ZRD1Ca4mg0msXCUX8/P4B2fjoza9jUkNVIxskounizhChIH1ScF2HZ7iu7n9Jz4fHCvp6O2z/h+8y9XhpDL2YUrTImJZQD/TNOkE6pFPvOoxZlEq2zoYKgxyYdHM/mIZA+rPSBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3n6HWtP; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3n6HWtP"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b7381d2d95so1231374eec.0
        for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 21:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769319011; x=1769923811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4IiGCcexlgth84wQDt2zHknJREH0L1/eshHrOemxLY=;
        b=O3n6HWtPCnVTNm9V7wuS8xWY7We5Bhi0C4OLQt6+1bT6Ea91ZoQiwHrO5oHuftCEkW
         k9S3RodxlO1XlrdOHQl4yMaT9kmcbVggnqAhIc8Dn9Be9mWvtEvFAj+Dxn6CNdLKCMea
         XDvrvWgADcHkorfB285p7xVEFl5FJ/3G/NwXWE6u9L7OfVYDHHSOkruQUdaMm70EQGgc
         SkrhsOwBb0LFeaXZuIxJGrDbYDAqqL44UghNIeiUz+uETd/bzYsLDXuZNshHiqcg7bni
         RzFByCBW4FUIBOQNhOrUQeTuaMr9w/swDqSoDcY5I7CwI2iwv5ViNyfIO3CpV7l3u0Cn
         U1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769319011; x=1769923811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4IiGCcexlgth84wQDt2zHknJREH0L1/eshHrOemxLY=;
        b=R23gl+iWtSVqt9/+XI3j/IodRiT1hb3FVwjnZtBZ8rUFpWjrF93CGDtHC4I5M8uWNe
         awddA/xJyQ7k8hWOi//avDDHG4kTCDGuAFYUC1SyiYG/yPyEywN8OyZwRtt62adsGSQ+
         94xbjWBME4i+Zt4c8vGIrX6S8VCkBguDti6EPAZ/WrgV0JSMTmsiJBMMjfmENR7bChZl
         VkkpdevaCWg/U0iZD+RmXspGAYQTz5aWl1SfKyBe7m0pEXEZG7xEPWYUCuq+2KiciTWA
         lIBdLP3JCqSe5axXBGqDNaH0VmqRMObHDR2Xm9AurAqec4A7ARjjcmc4ZmDM5Ibu7GFF
         YBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVslSI1KuiFNBkUpNwcX6y2IntcnQgW5BH2w742CnCpziwhmsnHphcLwxVirY+Dlcaomqg14C/Lgq2RZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdiBtFLZ5sxBLgfyM51hsaNGUWFeqT/V/lwLjQ79cjbj4ycgh3
	97lsiwVggcpxCtcjn0EEONLlHRUXyvQTUsuo6QrjmVY5qHpjWB5QIqGk
X-Gm-Gg: AZuq6aJJnqp5sTFlquRg6ogT1Ay/46cedX1Z9kKAPX56iIc2nhIhv6DRy88AxwjylqT
	AbYPBfnj1KMpNSO1rUyK1/cMBn8mLCYJ53SINjOzR3TcADEPRMzyMKrHD8V66VhZQjBCpjFemjk
	Nnkwo6QawaqLTKLE2xVvw9Kyg5w+bKmqYWv1WY+4Q8JFW6ZDTMPkiwF5QenTDrbBOaKfUMsm4tB
	scbQUWcAmRzO1evFpd02UaDoxlnnmoxUhbIp2wI5pOeF5xMrX4HZ7ZQtOS3wYa4b31b6en+WoIN
	i0Dz3Ue3T5VmoRhaRRORe2rDofYDNawT4EJObuyuliehzGgaNmsIlvk1whnUvmr2fULaUyX9z5X
	IPRIdsyFlWm9YA1kLOlonKSpArTyR6/MOwewsPG9vgOw93diXmilEb2Ga/7CL9CcjwwmmNrIEdz
	0K1zMr4K7x8K3I1XnBFhX4K+nuBxEvgOtOBrtOXV3H9qNalICpG0mP
X-Received: by 2002:a05:7300:8804:b0:2ae:5022:fe7c with SMTP id 5a478bee46e88-2b7638844bfmr285363eec.1.1769319011095;
        Sat, 24 Jan 2026 21:30:11 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:106d:a8a0:84b7:2d62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa03fd0sm9112849eec.23.2026.01.24.21.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 21:30:10 -0800 (PST)
Date: Sat, 24 Jan 2026 21:30:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-input@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] linux/interrupt.h: allow "guard" notation to disable
 and reenable IRQ with valid IRQ check
Message-ID: <al63ckh4mhr24yony4paeuegh5m3nir77ymkx25okbzvazmghh@avpbc2lsejle>
References: <20260121232522.154771-1-marek.vasut+renesas@mailbox.org>
 <20260122162206.9wrHkrTZ@linutronix.de>
 <87h5sca9dh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5sca9dh.ffs@tglx>

Hi Thomas,

On Fri, Jan 23, 2026 at 11:52:58AM +0100, Thomas Gleixner wrote:
> On Thu, Jan 22 2026 at 17:22, Sebastian Andrzej Siewior wrote:
> 
> > On 2026-01-22 00:23:47 [+0100], Marek Vasut wrote:
> >> @@ -242,6 +242,21 @@ extern void irq_wake_thread(unsigned int irq, void *dev_id);
> >>  DEFINE_LOCK_GUARD_1(disable_irq, int,
> >>  		    disable_irq(*_T->lock), enable_irq(*_T->lock))
> >>  
> >> +static inline void disable_valid_irq(unsigned int irq)
> >> +{
> >> +	if (irq > 0)
> >> +		disable_irq(irq);
> >> +}
> >
> > | $ grep " 0:" /proc/interrupts
> > |    0:         43          0          IO-APIC  2-edge      timer
> >
> > in other words, interrupt 0 is valid.
> 
> No. It's not really.
> 
> Interrupt number zero is a historic leftover and a mistake which is only
> relevant to some oddball archaic architectures like x86 and others which
> tried to mimic that.
> 
> The general agreement is that interrupt 0 is a legacy oddity and only
> supported in very special cases. Everything else treats 0 as invalid.

Could you ack this new guard if you agree with it please?

Thanks.

-- 
Dmitry
