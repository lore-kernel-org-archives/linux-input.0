Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242670;
	b=3oW/ytBEvnndUJxhAbVNEKR8a2iYeRaBa6mmdPTFvJmD4RrbUj35Nzqm764pUOkJEnQJ
	 xjPa1SDDGKTxtZk7jiw8Jo3YEDUW39rY2PDJ/xykGN0dypPEFO3pAkUHFAsJlDl7khrpV
	 PoY1AOAhJFHHUSsDSZLnB6icdA7ipseWbrkuapsEXaTxY3RxpVKQQCrRj7i51T0XzQIRe
	 jHv5HYbJOWeQZi+cyNcDAW0gCq/8ebi6+xFAVby/Vk02QeGE+R1a+8tyJLaBXBuKckdu1
	 OheJEz7tLT7qRmUq+GOzs+sJSi5iU1yo5efbLvakHZP24bHG8bZcjrtX931rIlU6uCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242670;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pqc2L1WzcvzIZX23ze7NEAQi3S+/FWCxRg0BqVfI6Vg=;
	b=3GciM4Uj6saNxWVSQ7zh52Mm5pwxA5sbcZONF06Ht1k1/V+OfjmfaAp25OdgO8oDgXUS
	 4fRmikOcvdGgtxPaud5LZBHpgUKYqSpEyDP7YQXS4OUyIvUMOGiGj1Dts2SN28Bjwp6we
	 QHVJiBAnzrjOBE+HXr1/2kshM3MnRTOwz2Yc5I97j6RhJD4Y6l6z1xBzXBLTwwVFlHogk
	 vfBbvZdJUvOMvIKMZ4+8aWeRV/GTsT7Wl5C/h9EA7d7DGrNwoE2pPwszaMz0LzLMTyqWY
	 2K1U0LA41833FvhplIPgTIYONGZ7crJWQcxEFZ5hwoRRWk1KfkkItZ5tXhXQfFLWx4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwYrWyq9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C29606A321;
	Mon,  9 Nov 2026 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RwYrWyq9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6DB1F0089F;
	Mon,  9 Nov 2026 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242670;
	bh=pqc2L1WzcvzIZX23ze7NEAQi3S+/FWCxRg0BqVfI6Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RwYrWyq9onaHDWrzcgUAnNT+SCoruSQGm9pYpLkASnNzt+eJw6UaP/20lLzCx53Tg
	 Wq/fzGQuKca+BL62LT2ecyreaIjmIcz1jp30nfdV++sUhfKFKT63PaTdjKFfDyafEr
	 98bjeO0KYM4XsracQeh3hGCrUI4SmuGqKunKrLyeAPTyqW9tfaZxcRwJL5ATMQ9lQa
	 XMSohEDAX5THIp9B+tYk3akCt1kk3PX4zT3DVK50IjlwwQLynszpFmdpQ9R/SUmz4V
	 uy8S+96lC7Ed1ISDIhV4df+jGQMzks7Ar7XQ/Qm3powg856/HDIl9f5zyAz6yLg+84
	 zi8dbhTRQ83cw==
Date: Mon, 9 Nov 2026 11:44:25 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Nicolas Schier <nsc@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
	Russell King <linux@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: apm-power - remove driver
Message-ID: <20261109164425.GB1608140@ax162>
References: <20261109080944.3802916-1-dmitry.torokhov@gmail.com>
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
In-Reply-To: <20261109080944.3802916-1-dmitry.torokhov@gmail.com>

On Mon, Nov 09, 2026 at 12:09:44AM -0800, Dmitry Torokhov wrote:
> The apm-power input handler solely listens for EV_PWR KEY_SUSPEND
> events to queue APM_USER_SUSPEND via legacy APM emulation. The only
> in-tree platforms generating those events are legacy Sharp Zaurus ARM
> machines (spitz/borzoi/akita and collie), none of which were converted
> to Device Tree. Both mach-pxa board files and mach-sa1100 were marked
> deprecated in v7.3 by commit cc7852314abd ("ARM: PXA: mark remaining
> board files as deprecated") and commit 7d92e50ceacd ("ARM: mark
> mach-sa1100 as deprecated"), and are queued for removal in v7.5. None
> of the remaining ARM platforms or other APM_EMULATION targets
> (MIPS_ALCHEMY, PMAC_APM_EMU, and SH_HP6XX) emit EV_PWR input events or
> enable CONFIG_INPUT_APMPOWER, and arch/arm/configs/pxa_defconfig
> already dropped CONFIG_PXA_SHARPSL at the same time, leaving its
> CONFIG_INPUT_APMPOWER=m entry inert.
> 
> Normalizing dashes and underscores in scripts/modules-check.sh for v7.5
> exposes a module name collision (apm_power) between
> drivers/input/apm-power.ko and drivers/power/supply/apm_power.ko.
> Remove this obsolete input bridge to resolve the collision rather than
> renaming a module whose last target platforms are going away in the
> same cycle.
> 
> Reported-by: Sasha Levin <sashal@kernel.org>
> Closes: https://lore.kernel.org/r/20261108225808.1809266-1-sashal@kernel.org
> Link: https://lore.kernel.org/r/20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org
> Link: https://lore.kernel.org/r/e4da2f9d-d3b9-4267-9b64-b0f2cb43402a@app.fastmail.com
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks a lot for helping with this.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Nicolas, do you prefer taking this via kbuild-next directly or having
Dmitry take it via the input tree and giving us an immutable branch? I
assume the chance of conflicts or follow-ups are low, so we can probably
just take it directly but I don't want to assume your preference.

-- 
Cheers,
Nathan
