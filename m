Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446036;
	b=jUal7KpoSrJAJivce2k+HCBQtWxt9reI7Jcvor6G+2Qg7K0n50FOnl/n+k2PxgiEMRSK
	 5MGRsnYG3CW6TZITr1JZEO9cwFo6hXpBO+TJn2JOJXePxr0uHrC6gpZGLbJTGGykPYfgb
	 2GLd7QbC1uKEdA3kNaOM4DH66RTJrVXhpQUcxJoH1090hJ1VLjOOIbeNqCO0q9KrrFHk5
	 j3A5KwJGxAitxH++awmf3TWevMekAgufEZjaprtdaziNC7YmUhZo2RZcbawljzzaLDoDl
	 MCYQU+KAyS8Tn8Df45NQX3CzPs+fEbMd5Rz4cCqLqO2yYdDk7Q1SS0a2Td0CZdbsfSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+HN879x/3xrnX1T4jdzY2SxnuHzj0KuY4gaCUfgnBMQ=;
	b=BACZsG8ZskDKI+w5aP6NEz54bKOHsyRoA/vq30QxTc6DVvug4OpMTnNKtja0m3hwq9O7
	 aAwVskPHeisx5lVkf2yBo93ryJzAhu2rno1edskjIg1orObB6ikpxTe/Hf4GTMG+bx34a
	 WdKtudJ2V0YwDWSgBMO4ymQom1vS86/AIFBPDhVXlsTY9NvGvP37u60S/EIdqXarrKchx
	 aURQR1M1z2D+l0nCKlkuIOBqctT1hkAxpnHvK/s4bdzzU4EjVrVpW432ijDr+Yz83/ecb
	 LDneLDPpBLoXq4AcEYZinr0BVcKPtwPr4OmwtCWisEvsWUBFHaG1J2ZBHzb99EDdk7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xs09brhQ;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C0606A31A
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 21:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 506C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xs09brhQ
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35ef6b49813so4876987eec.0
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792446035; x=1793050835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+HN879x/3xrnX1T4jdzY2SxnuHzj0KuY4gaCUfgnBMQ=;
        b=Xs09brhQMGJMaXQOqufY8TUg0ahTVQdIOXyapxbOxhI6ndXo4csWiJCopyadzNpo6d
         4RJwbuZioHcrTifdjUQqFtC90ILIxAB1T/gwAzIfVlPz15jjzlOMXzt91jUZXs2PRY44
         hXQEQ5X/IO8fZ1PHvjf89qr3lNQT0vG9JXtj+KL0MrNybnzZPwBz8Adif7QNfrBQsdWi
         fD8zIJtccO9G4pYtZo9Vd+nWPUjL65iNzgUI5OqSsWvuEEGFvQMq56X2S9hzX9N1XTjg
         80xAib0n7OX2+5LUfx8nTzkHRkf8Fr5ZMcpWR29FiOJEd+C0Q1PxD38O+aLIRvSzYwD3
         f1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792446035; x=1793050835;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+HN879x/3xrnX1T4jdzY2SxnuHzj0KuY4gaCUfgnBMQ=;
        b=Ga8ypr1tqJzqR5ppI/c1+uNcbqIY43MuSr28T/Lm2iiaDEZu7Whd6yixHkiykyDNX8
         /sodIKM0RUmwYdQdwrzAGhM4FagFLYW/pW2k7SSANkHlozQU/cSDrBh3FB1i08+eBot/
         65Ly4QlgnbIyfmzrBh53a0bY25rN4bkYUOUO0uIzvjLemdwWx7F4mW2nnOQCFI68Eowv
         zN3ymgF152AjmWuaqvwvI7+lNouiG40v2ozISS62Ymi2GR0kZQUpmuOs+dkybimCICxD
         PkMkPVcnrwi0ZwxsLaAoczYje9h4z+3hWupjsq92U0dSo0CpDnvvkb4hrgaf6y0jWx/h
         vNZg==
X-Gm-Message-State: AFq9FYIh/dD5lga+yMcOQ4ltBStXZItl8udEal58A2P3eI7YxXBE2mpG
	k4Riz5elt6WXtqGm7n8gh5MSnpYR5Hge1u21bRf4EnzWfc4QamQ6kG+ZgkJkqA==
X-Gm-Gg: AYBFou2ZTgU8T12CKwmBAakDCTcOr9InZTA/LMFsiL1Ppz+Eo33/JHoz5ZBb/A533gm
	Psz8Jj4Cb0uS0VhQoF12zeIqDK6NsM6mEl2kqZPvcnXhxodDFLAH9jafp1GfWtQOfpBi/9ncNKM
	aggu2vhy6ViCUc85AnWdf0wPXl3jrp2QIZP8Ji2m1BjSkuNUZcpxx6utd8lyQ/f5BGh94PFnLIW
	gKRf1XpLv2oHOcXHkubswuOBF9iYk6H70a2dArQO9sI67hcOFV4Zcp3aoKAPaQtGGd82h+2e/OY
	uI+EoXzTsKv82yKVKXU+P+of97lI69c6Q75dLbhEURMogqvXgKgKlwzpSbomRV7kGNb9Ht+gNIw
	1axQsJaJ0goBOLIOER/Q/j6rV62maMPXLSxgxJyrEd9O0zHNG4l7/z/KklyhzHRdT/2qs3CrZWl
	bxTfP580GQ/wEa8hGs1Sgzn2RGPE1PGu6CAZJbgMUBnAlZUAQbFfTfs1yqt39NkQBE8kI67VJ8w
	4/IuRuoHgdbqqB6YkgxSTsqPMm3hHL9bk6Io0n3
X-Received: by 2002:a05:7301:dd89:b0:351:4d03:c6a with SMTP id 5a478bee46e88-361a1668b5dmr12075118eec.12.1792446035202;
        Mon, 19 Oct 2026 14:40:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7c21:7991:4e59:de42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm36677182eec.21.2026.10.19.14.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:40:34 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:40:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jame Jao <jaojame6@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro
 14 2026
Message-ID: <ataOD1M2R_6mFJKi@google.com>
References: <CAN52AYvyTzrAnreG8iB_a9WFeOxUsvkTHgaVaaU-+A3_pRMe-g@mail.gmail.com>
 <atJz_OR-rIVb-RDW@google.com>
 <CAN52AYs19_b749avEjT-1ZaNZs6qp+3YyTHJgxRiAJTLyhJedg@mail.gmail.com>
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
In-Reply-To: <CAN52AYs19_b749avEjT-1ZaNZs6qp+3YyTHJgxRiAJTLyhJedg@mail.gmail.com>

Hi Jame,

On Sat, Oct 17, 2026 at 01:03:47AM -0400, Jame Jao wrote:
> Hi Dmitry,
> 
> thanks, the quirk works.  Patch below; it is also attached as
> atkbd-tm2426.patch in case anything gets wrapped on the way.
> 
> Test setup: Xiaomi Redmi Book Pro 14 2026, board TM2426, BIOS RMAPT4B0P0909
> (2026-05-21).  Arch linux-zen 7.2.9 build with this patch on top; the only
> other local change in that build is an unrelated platform/x86
> suspend/resume patch, input code is otherwise untouched.
> 
> With i8042.dumbkbd=1 removed from the kernel command line and the quirk
> active:
> 
>   uname -r        7.2.9-zen1-1.2-zen
> 
>   /proc/bus/input/devices
>   N: Name="AT Translated Set 2 keyboard"
>   P: Phys=isa0060/serio0/input0
>   H: Handlers=sysrq kbd leds event3
>   B: EV=120013          (EV_LED is present; dumbkbd used to give EV=100013)
> 
>   /sys/class/leds
>   input3::capslock  input3::numlock  input3::scrolllock
> 
>   writing input3::capslock/brightness 1 then 0 round-trips, and the Caps
>   Lock lamp follows the key again.
> 
> The built-in keyboard produced 127 key events with 34 distinct key codes
> during the test, so it really is usable without the workaround.
> 
> Minor observation: the two "Spurious ACK" lines in dmesg come from an old
> local userspace helper that pokes /dev/port for the LED; that helper is
> redundant now and I am removing it.
> 
> From: Eason <jaojame6@gmail.com>
> Subject: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book
> Pro 14 2026
> 
> The built-in keyboard of the Xiaomi Redmi Book Pro 14 2026 (board TM2426)
> types in GRUB but stops delivering keystrokes once the kernel has booted.
> The same failure mode is already handled for the sibling machines
> "Xiaomi Book Pro 14" (TM2424) and "REDMI Book Pro 16 2026" (TM2425) by
> skipping ATKBD_CMD_RESET_DIS in atkbd_probe(), which the embedded
> controller that emulates the PS/2 keyboard does not survive.
> 
> Add the TM2426 DMI entry with the same callback.  Testing without
> i8042.dumbkbd=1 on this machine, the built-in keyboard delivers key
> events again, and the driver now registers the LED class devices that
> dumbkbd used to remove (input3::capslock, input3::numlock,
> input3::scrolllock).  Writing input3::capslock/brightness round-trips and
> the Caps Lock lamp follows the key again.
> 
> Tested-by: Eason <jaojame6@gmail.com>
> Signed-off-by: Eason <jaojame6@gmail.com>

Thank you for the patch but why the From and SOB does not match the
sender?

Thanks.

-- 
Dmitry
