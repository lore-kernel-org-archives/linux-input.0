Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.255.198.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278321;
	b=U/i14iaAaMHnpsAClqqIhN92gH5odZ7MaOqX3cXcgHnffCcigk+dbLwwiwzuvdTehwxv
	 eHCDKExZn7daCmLihjhTBYhJ0An4l5fLdi61tfZO3yWz5xcjb/fV/ZVLZhyODb97RFIH0
	 VKd7aDqN7Y5IyyLL3OTe/pJmmB4szRN142W0aWNp2Tnyildmx8DR144M1WaZqpMG/6hrX
	 9miMi9avv5z7hX2H14eTyp4SOQ/59VQQGOqsSqmtSCaIa3xKLIWd7AIhSYYBd6std+rf0
	 9WRerz4PaTTBIf/TLQq7PUSF2nrXdc171mZ/qLE/iTkhzYtG9NB7UJDLP/ZrWDBsrbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278321;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KWDm0GjzCY+hCrlut+QKv8rvj0gWTSM4ovAgsAx3GME=;
	b=R5OpyZFnL5naHqKsDamPmM+0HUy+IBWol60w8QoHwGy/uioRoIEkiz2T61tsYVVBoafw
	 HJ+1DWSBA3LStmDvIIfKcm/gdDHHmTVcmknboJzUPu5I6dSvTLzQaCwMR/vKPWUglu1EO
	 ulXhxOlhPrunPs7Km7HM/23GRV7Mv+wWIyg21UsamWgNMHUibXrQMD5oPs9GpMIS10HPs
	 a5bdxAzWtj7V9K3D5nk+tO3mSNn8CBIuUMgaCoWGFwoBbEXxEIk5tZQuWWNIDeZPRzCuk
	 jsOWeqlvub8+4Eo5qQQmFQ5vgwpOH4OSY7w1coLfvxIzWbeEOQG1jB60P6CtBRKbvOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=endrift.com;
	spf=pass smtp.mailfrom=endrift.com;
	dkim=pass header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=edoDrpHw;
	arc=none smtp.remote-ip=173.255.198.10
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1F60A260B;
	Tue, 10 Nov 2026 02:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E1F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=edoDrpHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1794278314; bh=O2ftx/z9zONc9bNAjf/AotNbgJmqhjvAIasLxsAIseY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=edoDrpHwVmfum70TW0OeqQzztWmEKIlpXQEiTztgLw+dhMXzpwEIZsBpGq2JkUIrp
	 kbvmPPm0fWoThXvW8Rjn87d9yy/LkaisyQEgLtQLfi5BRT+/T27chXH0w4vs+tZB6d
	 SFNKwoOC5LmTD8LPuxf4vyPVLUWs41Rexqm8wdEzRXTDO2om0woZ1t8iQ0ZJHMM82f
	 0NtfWk3MQ/wQwg82AWjD8BP3fwyFfwVb2o56ZzlB9wJTvld8RmHTukS1BTny9hLlqf
	 nOjUUYZIdojTHBn0vxZJxNPN5MtvlvPlvPFnK5L5oO/S4N5SXXS5pFTEj2yYRj7g4J
	 FhqD5Yhx9vCOQ==
Received: from [192.168.0.22] (unknown [97.126.138.172])
	by endrift.com (Postfix) with ESMTPSA id 0A9BEA04D;
	Mon, 09 Nov 2026 18:38:33 -0800 (PST)
Message-ID: <a2dc00e7-9cab-4315-87a4-795f256c1e03@endrift.com>
Date: Mon, 9 Nov 2026 18:38:33 -0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: nintendo-switch2-usb: check URB before use and reset
 state on free
To: Noah Weinberger <NoahWeinberger2003@proton.me>,
 "djogorchock@gmail.com" <djogorchock@gmail.com>,
 "jikos@kernel.org" <jikos@kernel.org>,
 "bentiss@kernel.org" <bentiss@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HP2LhXZGIipAd2XxKx7dDh8q3SopkJRAxo8IQkuyMxTlR0YfO3rS3CT9NqUkg3ispO72yfhC7Oa4MoZdXgo6lNIEjC1WvQFlrKreFzCnmFM=@proton.me>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
Autocrypt: addr=vi@endrift.com; keydata=
 xsBNBFtJAmYBCADmRIN9O/aBbYc93lUMvG2hPip++otLit+65EwNHB1y9BmbVr0Q8Tz7rbAM
 K2mB0EiA4Z3DesoLIOzlJq0E4fgDsAi8ok/i7aTx35d0Qeab95GEdkCMcL98xNJE0agq+KYk
 pnvFlhdyC23K32KdOijsUqqbd86GgxRZmuf/Yf932KxKAj+n0aFBw5y6i0ep7WQBF6ytpqah
 Uzy04D//smiTr6rrXg+C09MX0XZ2Fvcv3gmimnoV6C/ZCO1Zecqyhrs0YFfdIhFEBp2ItYim
 MoeU4g6y726gyRO/+wwzZkryJMU8hHootzW1gUylZeELSwx8uIJSHFiLE7AK+M5soPtDABEB
 AAHNG1ZpY2tpIFBmYXUgPHZpQGVuZHJpZnQuY29tPsLAjgQTAQoAOBYhBNj+0QMp9OPSosB4
 6X72E7X7Nb0rBQJbSQJmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH72E7X7Nb0r
 WIcH/0GnIOkmAyy2UlgS/VKi193ZRWYJjBfUncIBf57gLt1KYY0PvUoR9MVvkLqcx8vaCxWh
 bVSqzxT6WU1ECp/URdQV2W4IGB6W4B8rT3VGw0QzbVVQRmt6vReEMFVL+vBfgHKTRBItiy7x
 Bd+JZDusiyrrGok9TqqkBYlZPWE29ajiOAe05N1UhuRq7y8w/bOkzFD36ohMtfqV4hByWV+q
 d0LujqgZm1AkM1FqpJ4j8h1Gox5rpmWfaHJmBQ8HcKqQfwACQCvDNHS2vlTXJYfxlh+mVerL
 YKZgWnyvqx4pLKqJOXQKssIaDjnDfTu6bQgXvhaKb1+piBUYuoe9/+3E15TOwE0EW0kCZgEI
 AL/KzT+NR1/LbJ7Kuv3gAHFp+S7cfyyPSamN6i6/X135vNSawG7g81iWUweAW6YahFA2haqw
 t+8/Bm9Dzc8rF6RHCElK1GoHiF4SIYQxjqPo2wwqvTad9FblWTfaYRKfVDvNz2Rz4i681JrR
 8gizvzJPX+gocH7FMzPwb1DAwL2kKA5wilgAGSv8nZqeG55hNt2t/XiT6Yd97DJv86D24UUP
 BetLTq2jUWtX+omt+JhF3QzMjnyGQYKHNXUB/ipBxNSkwnDrWg/f1EjDtNzuOHManJDC9Bqi
 qhi1abiTNlmmewI5iLEnnxzfSKS5HO9nCC1szl229DHwIMH7jA+G+z0AEQEAAcLAdgQYAQoA
 IBYhBNj+0QMp9OPSosB46X72E7X7Nb0rBQJbSQJmAhsMAAoJEH72E7X7Nb0roioIAM0oDKEU
 QH7Og4+AXm35uklIiCX6cFQPgDVlQn7M/QFLnEhhCfPTt8PkIIN4dLgs4lIJxExpgQWgOLUX
 h+ZLLupzZXoysAXfdwNLf/RqRed/zTZbUjssy4D7yeNIJThzU32kDy0Hx3pMNM/Hd9yaXmHL
 LDkfwcyQuqA9+eeOogkDC8inLNLfYQ8JtVQZuWppNcbOZkBxfMVAmPHg6C9fe2biQFojoLPe
 4nQheprKfBp5QsY2cIjP8kaWPpfJEJ5i2aNgtrfebEzjYoWWLkK78Lo8qABdxkVhH6rhAlw2
 rVf41cHNCfHF7ddvOb9IItWacXxYn7ql+dI/Se3+ISWDboQ=
In-Reply-To: <HP2LhXZGIipAd2XxKx7dDh8q3SopkJRAxo8IQkuyMxTlR0YfO3rS3CT9NqUkg3ispO72yfhC7Oa4MoZdXgo6lNIEjC1WvQFlrKreFzCnmFM=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Noah,

On 11/8/26 2:29 PM, Noah Weinberger wrote:
> Hello,
> 
> Proposed-fix limitation: the checks below do not establish URB or
> interface lifetime across the pointer check, lock release, and subsequent
> use. These proposed changes may therefore not resolve the teardown race
> or the late-work use-after-free described below. Please review the
> locking and work/interface lifetime before treating this as a complete
> fix; this is an incomplete proposal for maintainer review, not a
> validated resolution.
> 
> switch2_bulk_in() calls schedule_work() after dropping bulk_in_lock, so
> the work can be queued after switch2_usb_free_in_urbs() has returned
> from cancel_work_sync(). free_in_urbs() NULLs bulk_in[i].urb but never
> resets bulk_in[i].state, so the late work still sees NS2_URB_IN and
> dereferences urb->urb->transfer_buffer / urb->urb->actual_length on a
> NULL pointer - the existing !urb->urb check sits after those
> dereferences:
> 
>     if (urb->state != NS2_URB_IN)
>             continue;
>     spin_unlock_irqrestore(...);
>     if (ns2_usb->cfg.parent) {
>             err = switch2_receive_command(..., urb->urb->transfer_buffer,
>                                     urb->urb->actual_length);   <-- NULL deref
>     ...
>     if (!urb->urb)   <-- too late
> 
> A malicious or misbehaving controller (or an unplug racing active
> traffic) wins a narrow window to trigger this; the outcome is an oops
> in workqueue context, and a use-after-free if the work runs after the
> interface data is released. The patch re-checks urb->urb under the lock
> before using it and resets the URB state when freeing, mirroring what
> switch2_usb_shutdown() already does.
> 
> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), drivers/hid/hid-nintendo-switch2-usb.c:51-121 (completion), 209-240 (free path), 288-316 (work).
> New driver merged in this window (zero prior field exposure).
> 
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.
> 
> Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
> ---
> diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nintendo-switch2-usb.c
> index 8b3b684..c846cef 100644
> --- a/drivers/hid/hid-nintendo-switch2-usb.c
> +++ b/drivers/hid/hid-nintendo-switch2-usb.c
> @@ -231,6 +231,7 @@ static void switch2_usb_free_in_urbs(struct switch2_usb *ns2_usb)
>  
>  		ns2_usb->bulk_in[i].urb = NULL;
>  		ns2_usb->bulk_in[i].data = NULL;
> +		ns2_usb->bulk_in[i].state = NS2_URB_FREE;
>  		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
>  
>  		usb_kill_urb(urb);
> @@ -298,6 +299,11 @@ static void switch2_usb_message_in_work(struct work_struct *work)
>  		urb = &ns2_usb->bulk_in[i];
>  		if (urb->state != NS2_URB_IN)
>  			continue;
> +			/* urb->urb is NULLed by switch2_usb_free_in_urbs() while we
> +			 * may still run; re-check under the lock before using it.
> +			 */
> +			if (!urb->urb)
> +				continue;
>  		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
>  
>  		if (ns2_usb->cfg.parent) {

NAK this approach. This doesn't actually close the window (assuming it actually exists), it only narrows it, which should be pretty apparent by looking at what locks are held during freeing the URBs. The code is pretty aggressive about not scheduling the work after shutdown so I'm unclear if this is even possible. Furthermore, it makes sure the work is canceled before it frees the URBs. Just because the LLM says so doesn't mean it's true.

I can add an additional shutdown check in the beginning of the work, which would resolve this if it's possible.

Vicki
