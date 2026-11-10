Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316970;
	b=SXV4tTwS4wr8XqBhPaKTz8lb4LrtYQ5N3iHck4zo7CLqZ938oNJbUKNuvu968Jilwth/
	 k9+7UIJt9lxk0yGxx4xbW5eol7dgFyxKAiBXmg5wSZO8Z9VHBlP8MmNu1DPgNy6U9SKyq
	 4M7a7yriPVqwHnf3hCrg+dcBD3FZesT1N2zUmD8OosiHLeGfu1OjjSIM+j37xfuVOOxY7
	 D9c/LYSzpwtgMgk1tGKUc6DtbYu/DT2JteT0lmxFzf1ZJpCNmE9d8oGpB3zKlaSY3ITEw
	 F/HA4xUKZ7mkpiE7/9Ipwgu65XaaXSiyRdWmdcCBzDMESQ0MqPp/JnVg15dS7xj1LtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KtBx36UBDrfpFx+VxUMkQATj5rmFEq4BGC1xm5D4fac=;
	b=2tCJ4P1tYpoJeGlzXWVmg03HXVFZR55qG6bm1xQEIvfy7icAUWtxw7OQd35+6n5HAGOf
	 afbbKu7/RwBBdss4OZU1q8SXr5cvb6HxY0HgoxX3y0nvSutXi7/3lmx18xRwBPxcZmU1H
	 8gtFzLmIEk1Y1eUsDuoX+4go3SvL0eAZyK2s7Z3kMpdWVFyzzl/2j8pQ53YLAmnjT3FFw
	 +0vpLEcbEUFd7JMsZuP86q5yMwOVRmvqmMV0csaN+5b1OFpIYzhRRZofeIcUyR0gPOUXV
	 f1OtCpOW0WIR+ZkhYzMpsKjvVx2jLhxcY5u3E8uxCfjUg7YEe1sAz+sm8Ru/q0uFNMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izFZQUIj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E15B4606B2D5;
	Tue, 10 Nov 2026 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izFZQUIj
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3CC8E1F0089F;
	Tue, 10 Nov 2026 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316969;
	bh=KtBx36UBDrfpFx+VxUMkQATj5rmFEq4BGC1xm5D4fac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izFZQUIjNGDTgyp5H8Lj+/KfWVP9QkshatS6aySNYvVvIkxgaJFnSDsf/aIXtQBti
	 LGOoT2zSR86wBAnLb3xa63h3EHnLm9oLb17Vft8x4w+jphOiYE/3viywZJB/pm5VGt
	 uv4LwW/bt2a9VaXec+UVRDUmUttYVtZkX+qN4aRw8f+PmMOaQGwpIOQ5poHrP3HPoS
	 s+uJ0OaDiN5TOVxBe+oMBezKYCKgv77GMhT3nLT/gPVaT8ygtpABc8b8XB2I3XsHlT
	 75f0mefDjWbNJtIi/lKAUyfriTrvlKD/433F+VGqgut10Jtc8t5gA4Mu059iFibcc9
	 2Ux+T5B9ePIJw==
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nicolas Schier <nsc@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Russell King <linux@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: apm-power - remove driver
Date: Tue, 10 Nov 2026 14:22:39 +0100
Message-ID: <179431695096.1779189.14927773083935970456.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109080944.3802916-1-dmitry.torokhov@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 00:09:44 -0800, Dmitry Torokhov wrote:
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
> [...]

Applied to kbuild/linux.git (kbuild-next-unstable), thanks!

[1/1] Input: apm-power - remove driver
      https://git.kernel.org/kbuild/c/7f705c0a

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped,
reverted or modified (e.g. trailers).

Patches applied to the kbuild-next-unstable branch are accepted pending
wider testing in linux-next and any post-commit review; they will
generally be moved to the kbuild-next branch in about a week if no
issues are found.

Best regards,
-- 
Nicolas

