Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316155;
	b=Jbh2RCeOEKl8Jd1wls6y84gA4QkYJ0/QI0+9QFrfzfBBhmABIV22+HPScWnkhog8dSbx
	 3b5/CXfG9VpxvnQUFB2yeF3HhxhUEBRxZUJZsbCQ5Vt+LyxlCa6oB2Oc6jwa+afWHqbuJ
	 0NW03/nUNWnUdV2y8bmQ/fVDmnDW9GsDsFCs8mZBmf6hORame8P4TUZBB4x1n+UQ45k/I
	 TtQ/wRe/IMqWcHACQHpbZsy1qBWMMpao44dgx40nhnWevBY3ClSLagreok5R8uMC8RJcV
	 xxZ5Aj6vdoWuVW5vDRq+zx/oOScqcKSR9K5xW5ODMtpqLKkfLuZVkygAMujqP/eqdpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316155;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=19XAClVuc+eajfIp7Ht34SDxVSiFZnDdEKutUwZPCB0=;
	b=gW17icOAz2XqzF8j/GaXUDhdWfJxNYvkt9TyNj0RMWwLF8XZ6m7tFpFiH14GQre6e8Wg
	 F1df0VtZ6Nj3ZAdiUsimNGBeB3ZBCXiIE1WKBHxsa3QTYS92a3/NalNdADn/MPYZorDin
	 BJ6slo0PFRde2rkMBo2jRuuWgbaI07bOZ+AlE0V3QWbeRjWvZSDE8siiM8yFTNY5mo1Lp
	 LsZYtA366XSPnNaFFA2N2NjWCh9KjMuFNvrQxOd6R0uRmDJITR748BN5e2Oir4qhPrQsG
	 1PeAuJZXaKzACPMcOsg4+Sj/RQu54+aYoo6yCfViK9zgZFABuipKV2goNdh5LowpN5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiHUAz2g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 11A75606A32A;
	Tue, 10 Nov 2026 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fiHUAz2g
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 64AD91F0089F;
	Tue, 10 Nov 2026 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316154;
	bh=19XAClVuc+eajfIp7Ht34SDxVSiFZnDdEKutUwZPCB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fiHUAz2gGOKSx8xziKopAJOHkhaXvZ+7Tcum0sZ0/6S2Op2IKiuhktrnDNVuS7+1T
	 TtItHcfwP4/inoOgJppZzDcuUvhjwDggPY2ZoJLFpivbPIz/TFrL+MNUgZWM0oy/OY
	 3xnPuUaoIqtjaH486n0lCjbhXgkBvh+0PpIyrxFpkEBlAML+mfeOAIrgvMt+ibFeDz
	 d6r98nQ+J6tL+sVruA8JTd48YAlctQoExvy9MV9eoU1DYT8UN47rX+AhcyYSV+wu12
	 V0voJnb9+IrTK7NY0tYecMkSXbGOpVzsuy0E6Ik7i4WYYLVK9lrvYBBPGrTdxj8aUg
	 jTAUjpaRr1tng==
Date: Tue, 10 Nov 2026 14:07:56 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
	Russell King <linux@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: apm-power - remove driver
Message-ID: <avMXLPuXKQGWoqL5@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
	Russell King <linux@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20261109080944.3802916-1-dmitry.torokhov@gmail.com>
 <20261109164425.GB1608140@ax162>
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
In-Reply-To: <20261109164425.GB1608140@ax162>

On Mon, Nov 09, 2026 at 11:44:25AM -0500, Nathan Chancellor wrote:
> On Mon, Nov 09, 2026 at 12:09:44AM -0800, Dmitry Torokhov wrote:
> > The apm-power input handler solely listens for EV_PWR KEY_SUSPEND
> > events to queue APM_USER_SUSPEND via legacy APM emulation. The only
> > in-tree platforms generating those events are legacy Sharp Zaurus ARM
> > machines (spitz/borzoi/akita and collie), none of which were converted
> > to Device Tree. Both mach-pxa board files and mach-sa1100 were marked
> > deprecated in v7.3 by commit cc7852314abd ("ARM: PXA: mark remaining
> > board files as deprecated") and commit 7d92e50ceacd ("ARM: mark
> > mach-sa1100 as deprecated"), and are queued for removal in v7.5. None
> > of the remaining ARM platforms or other APM_EMULATION targets
> > (MIPS_ALCHEMY, PMAC_APM_EMU, and SH_HP6XX) emit EV_PWR input events or
> > enable CONFIG_INPUT_APMPOWER, and arch/arm/configs/pxa_defconfig
> > already dropped CONFIG_PXA_SHARPSL at the same time, leaving its
> > CONFIG_INPUT_APMPOWER=m entry inert.
> > 
> > Normalizing dashes and underscores in scripts/modules-check.sh for v7.5
> > exposes a module name collision (apm_power) between
> > drivers/input/apm-power.ko and drivers/power/supply/apm_power.ko.
> > Remove this obsolete input bridge to resolve the collision rather than
> > renaming a module whose last target platforms are going away in the
> > same cycle.
> > 
> > Reported-by: Sasha Levin <sashal@kernel.org>
> > Closes: https://lore.kernel.org/r/20261108225808.1809266-1-sashal@kernel.org
> > Link: https://lore.kernel.org/r/20261109-apm-power-input-rename-v1-1-0609e7b91825@kernel.org
> > Link: https://lore.kernel.org/r/e4da2f9d-d3b9-4267-9b64-b0f2cb43402a@app.fastmail.com
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks a lot for helping with this.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> Nicolas, do you prefer taking this via kbuild-next directly or having
> Dmitry take it via the input tree and giving us an immutable branch? I
> assume the chance of conflicts or follow-ups are low, so we can probably
> just take it directly but I don't want to assume your preference.

Thanks!  I'd like to take it via kbuild tree.  Please complain, if I
shall drop it again.

-- 
Nicolas
