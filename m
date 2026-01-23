Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5407340290;
	Fri, 23 Jan 2026 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165583; cv=none; b=c+9Lu26OdOul27rdMyqqyhmV2cCJ86w09H7HD3QbYFTsfW0MYGNefhTxM6qTIw27rxde7e4VhnAeBWB8TWxOFOo44+DwF1UJkw7UmYv8hQkRJMV08l7agqphnOzxyebNonQmCOBe5o/E7/uXHPI1a3jw+WgpAjZX4ct0VqUNVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165583; c=relaxed/simple;
	bh=uLv8LO/KUhOdMpUkUDKLbVQl1Uwqg6NqoOUU7GrtXFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UcGZ2vu/ZlRWwLeG7I3FxoLRTg8rPTH8hPkI4rCZarvQ0ybXVmKqJKQ8+bdsQ75q/X2yfHnlsv/Z5KBuwCwcyXriKbBwNg34PU/IwHKEZS+nHpQShqa9khScUJdXjMp5P1DaqYnuVgfs7pYRLKppFmTOuGHI6HhbU5vSs80FzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfTdr0HW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfTdr0HW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE631C4CEF1;
	Fri, 23 Jan 2026 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769165582;
	bh=uLv8LO/KUhOdMpUkUDKLbVQl1Uwqg6NqoOUU7GrtXFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cfTdr0HWdlkTiJbSZZJmhH6y/hsnvK7ezJdzF+gHYnAp+2EHp+n+L+EukndFYXHg0
	 fJBYG3A15CRh97UVpfXoHByiZxoFrFNNW/ynrjCi3DrV4FDvkjOjg8Wbx7jBgB2rrD
	 k5o4LxEKu2Rp+W8Giy8gct20T4y5Q3W8nBBKqOpWv6RLVRx8l9/mt0DpE/yAK9XZdO
	 eBSHgXk8JW7mDeJ/cJqvY8xoRtgZEPshtedcUf0HPEWOhH5weDT/84DSlRGLdh46Tk
	 ZiMDl+2PcL0m7gVE9ctZS85Vkk0CYvwMa+S9LwVxN7a+LjyoqerdNOtHTag5gU7K7Z
	 1TdqP0lRLmJgg==
From: Thomas Gleixner <tglx@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>
Cc: linux-input@vger.kernel.org, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.Li@nxp.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] linux/interrupt.h: allow "guard" notation to
 disable and reenable IRQ with valid IRQ check
In-Reply-To: <20260122162206.9wrHkrTZ@linutronix.de>
References: <20260121232522.154771-1-marek.vasut+renesas@mailbox.org>
 <20260122162206.9wrHkrTZ@linutronix.de>
Date: Fri, 23 Jan 2026 11:52:58 +0100
Message-ID: <87h5sca9dh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 22 2026 at 17:22, Sebastian Andrzej Siewior wrote:

> On 2026-01-22 00:23:47 [+0100], Marek Vasut wrote:
>> @@ -242,6 +242,21 @@ extern void irq_wake_thread(unsigned int irq, void *dev_id);
>>  DEFINE_LOCK_GUARD_1(disable_irq, int,
>>  		    disable_irq(*_T->lock), enable_irq(*_T->lock))
>>  
>> +static inline void disable_valid_irq(unsigned int irq)
>> +{
>> +	if (irq > 0)
>> +		disable_irq(irq);
>> +}
>
> | $ grep " 0:" /proc/interrupts
> |    0:         43          0          IO-APIC  2-edge      timer
>
> in other words, interrupt 0 is valid.

No. It's not really.

Interrupt number zero is a historic leftover and a mistake which is only
relevant to some oddball archaic architectures like x86 and others which
tried to mimic that.

The general agreement is that interrupt 0 is a legacy oddity and only
supported in very special cases. Everything else treats 0 as invalid.

Thanks,

        tglx

