Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8F3C769B;
	Fri, 16 Oct 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143616; cv=none; b=LciOw371RLrjaDVYGmWsmWdgdIOL5kAQ6reJ3XBXCFfmF4PsnNwImpkDL4+XC9T2jsldRJ/rlUKtclzbnfLObgPvqmvaIFe6xi/u9dGBLRdtXliic+/crg1orXelT8XOOEcqe3ymEbBe8zTCB+kiA0LvfSzym/bO7t6k0fQlzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143616; c=relaxed/simple;
	bh=87hBvvTkVrB1+oH25+2z0W+4Uo1Y5XZjUIjFDdCGplQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HoOABhsj+Shifbg2fSOodkh6VyXQq1a7JTg4m6NHyIpC1HaXmiT4JhATV+jIPu8EwzLKHRy3dw0EsIiMp414pJIyLJmYuntJRzk693AxWmHOyjYcMn8SfdsdcT2whvUTE3vINdKasQryE/25UUvlKWohiF6JsbAX//YAqCUnQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZtby+uS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZtby+uS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD431F000C4;
	Fri, 16 Oct 2026 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143614;
	bh=mNqVn7E6IzG2yYAEwxGNcrT0x+aC2uFLmBLaT7Z2NVw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=VZtby+uSiLnVaHhf8t64ejfccqOtGPJCWv3BfC5bDvgRVj4le7jq/y+OjrMC/3wJ1
	 40RbWvrONpG0WHS75liZRtWqRLOiPUOdLMoPjeq7P4Tp0rviJjunjXhy1Rzv53I565
	 nV9XPftEufEJzREyzbHyxf95139VfYX3eT1CLZEyb0BvyBm0qyGrXJ5Sv0nSPiv+5m
	 t7vd4qknyq1KbxViIaX11uYQdzwzNhFnvNZgl/gzUzkh7uFIfQqnUMfyCRHYZqBAV0
	 gcDgppYdKqNEc9BkbWkmHVEIPjVaHraxROeVcUdcsdf4VC2V5Mf1JGdGvNR29MkNKM
	 NQagq8Up9pRTQ==
Date: Fri, 16 Oct 2026 11:40:12 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>, 
    Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v2 0/3] HID: asus: improve the driver support for
 laptops
In-Reply-To: <20261009114921.5242-1-denis.benato@linux.dev>
Message-ID: <22327453-966p-o133-1pp8-842q1os8s12q@xreary.bet>
References: <20261009114921.5242-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Oct 2026, Denis Benato wrote:

> Hi all,
> 
> Antheas has requested reviewing the XG mobile patch on this cycle so
> I am re-submotting a modified version that is a bit cleaner because
> it uses LED_CORE_SUSPENDRESUME instead of re-sending the LED state
> manually on resume, but it's functionally equivalent.
> 
> I also included a patch to fix a pre-existing issue that was flagged
> by sashiko-bot, albeit I'm not entirely sure if it can really happen
> in practice, though it is safer to handle it correctly given the
> actual code change is so small and leaving it documented helps future
> changes.
> 
> I also moved some code to reduce nesting and improve the resume path
> on ROG ally and other N-KEY devices.
> 
> Best regards,
> Denis Benato
> 
> Link v1: https://lore.kernel.org/all/20260813144736.2477941-1-denis.benato@linux.dev/
> 
> Changelog:
> 
> -v2
>   - HID: asus: add support for xgm led
>     - Solve an impossible error reported by sashiko-bot regarding teardown on error

Applied to hid.git#for-7.4/asus, thanks.

-- 
Jiri Kosina
SUSE Labs

