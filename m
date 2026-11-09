Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242381;
	b=gLpgqyM5Sa4Uj4PTey1QJzLRwCsp1SMREqMVDRjeuHfYF63aOvFDsxiKs8Qa5ERNYhGC
	 xMU87bdoW6j+Hrp4Mic+QQam+zyBHmrFD0YEW5KIgzq0jPveqjimcFfNzXiy5Pzncr5nT
	 22zr+QeJ2OCHYzX5H9UwQnb4sGHqZfIK7FKfK50luWQ9+7x8wL4oIjKqdrTi+8a/PkrdE
	 rTOLGb70FbDZIof+PTp7bAEhJD2XV/N821Gb2RfKs3oQ9begDPyaP/OqWMxmN2FErqXOu
	 BEWnL2u3z59A0d6WdvvCldYt+YPKgoSXWURAGUDLgv/O9LYQKzYPzHxpjJjH75TTPPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242381;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XczfXdyyzzvBMaK7H65uC8tHQp56fcZp9lsoW/OvEfE=;
	b=Eo2zqEh4LWDxCqRao+DY6DI/OMaYwFYVDmOlVL+tFvmsiGWPLn2QkOjYCoLzXVtMX9o9
	 +bfHtOPTzbOrFz+snW0MCz1K4JSOBKEK+HQXpIN6cVuswxxNAWZhpNMfAVMXtuiCQKwhf
	 2UHl7NRdGHWqrBdYu30NB+LOKxBtwxPL1hEG59Vb7B1NjcEmiXDY3azCAJPHZVBZWcehA
	 WxHFPL2oRsBZrygUVxHXIS/MhtQVgyCYLsMn82m3kYyz3xswfgVY1PwDzfYPk68s8Y6ID
	 YbFYEjN/sL0PHPzEn6FxhlILe3ijah1oXr3ckVp44PQdqXjce5rUnIxpQ5QRR5MYnuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzQCkfBN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C94606A331;
	Mon,  9 Nov 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzQCkfBN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADC11F0089F;
	Mon,  9 Nov 2026 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242381;
	bh=XczfXdyyzzvBMaK7H65uC8tHQp56fcZp9lsoW/OvEfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dzQCkfBNoJ/MVAxSdeMblCLGbyp28LvZG01v1zKrZrtXTBVis3aecojY4BHBAI+SB
	 Q/6wVxPELdYDD6h3Q/LQ3/cLXZJL2iG13cY2wqB+16w+S8iGlSZ5sslPD8l7f3vDWJ
	 kCpMiUqqqSJCQVsAyJkGRnkWXSOhUsZRYQj3gpyzYSlXvzYZtNEwmDvy1N8UGBv0KU
	 XZkgwntXskeFWHQeWIGoTcqTFBiGGiSCF04ngPGuIl1oN3qXynibboHUHkeV8FAbFJ
	 jKzflO/PU8SW2T00yhydFwJQJQkJz6vZsCvQ/5bum7BmzY0DkOtMUSy1tKgfj2CP3F
	 t5LeqTADIH3Ag==
Date: Mon, 9 Nov 2026 11:39:36 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-input@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Input: apm-power - Rename to apm-power-input
Message-ID: <20261109163936.GA1608140@ax162>
References: <20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org>
 <e9cf3745ebc09bf04ce0bf75b67a31f0@gmail.com>
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
In-Reply-To: <e9cf3745ebc09bf04ce0bf75b67a31f0@gmail.com>

On Mon, Nov 09, 2026 at 12:09:33AM -0800, Dmitry Torokhov wrote:
> Hi Nathan,
> 
> On Mon, Nov 09, 2026 at 01:25:26AM -0500, Nathan Chancellor wrote:
> > When scripts/modules-check.sh is fixed to normalize the module's name
> > like name-fix-token does in scripts/Makefile.lib before checking that it
> > is unique [1], there is an error due to drivers/input/apm-power.ko and
> > drivers/power/supply/apm_power.ko having the same module name.
> ...
> > Rename drivers/input/apm-power.c to apm-power-input.c to make the module
> > name unique and clear up the error.
> ...
> > We would like to take [1] for 7.5 in kbuild-next, so we would appreciate
> > an ack to take this directly or a stable branch that we can pull in.
> 
> drivers/input/apm-power.c only reacts to EV_PWR/KEY_SUSPEND input events
> to queue APM_USER_SUSPEND via APM emulation. The only in-tree users that
> generate those events are the legacy Sharp Zaurus ARM machines
> (spitz/borzoi/akita on PXA alongside SHARPSL_PM, and collie on SA1100
> via locomokbd). None of them were converted to Device Tree, both
> mach-pxa board files and mach-sa1100 were marked deprecated in 7.3, and
> Arnd (added to Cc) already has their removal queued up for 7.5 after
> holding it back from 7.4 LTS:
> 
> https://lore.kernel.org/r/e4da2f9d-d3b9-4267-9b64-b0f2cb43402a@app.fastmail.com
> 
> None of the remaining ARM platforms or other APM_EMULATION targets emit
> EV_PWR input events or enable CONFIG_INPUT_APMPOWER (and pxa_defconfig
> already dropped CONFIG_PXA_SHARPSL in commit cc7852314abd, leaving
> CONFIG_INPUT_APMPOWER inert there).

Ah, thanks a lot for doing this archaeology!

> Since you are targeting 7.5 for the modules-check change anyway, let's
> just drop drivers/input/apm-power.c altogether instead of renaming a
> module whose last users are going away in the same cycle. I will send
> out a removal patch shortly, and either you can take it directly through
> kbuild-next or I can put it on an immutable branch for you to pull.

Sounds good, I will reply on that patch.

-- 
Cheers,
Nathan
