Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6F3890F0;
	Thu,  2 Apr 2026 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116365; cv=none; b=Zd0VRdGbfOw++2fsKatfSbmnLU1nE8I/mkyuyzZfIPQGg8PtvRcwgtEKUpi2UtrvoGAd2OEzGSlDiTHqIcdz/8Tv25C2Vhs+/DkNhFqI98Hj/qvjvmg2AMGCHpNOs6ev11x16abs27jLRJZXLwCibPN9rLHuPC88Wh9nRldpUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116365; c=relaxed/simple;
	bh=UWiMeGXQfNypsb+rddWd0JoYBgN9E5HtRry5MonXx3A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VbUsrPh7/uNNGs5YW6WpYHaC8VYFvf0bdfiOzGaYlDsq/CT87MC7o97CVYKRM50oyP0wcsdwy3rNhd77qHvxf7gg6FO1/eFgn0+/7hcC4OVxA+uRmovAiaBRN2k6SV9JTedARoFrpNGars6TNjAnacawYAna3zTfQ6MyOpubCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LudHFXUi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LudHFXUi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB5BC19423;
	Thu,  2 Apr 2026 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116364;
	bh=UWiMeGXQfNypsb+rddWd0JoYBgN9E5HtRry5MonXx3A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LudHFXUiErrqykbAeQZButdM55+SJpA3bRxLnDlY68aLOtTSgbKu6glhRnVNgpuG6
	 hrPG9ylIPoUWfdzqoDEFzz/CCDNCbbFUFUghFrHwFwfCZjhg+nTsnVTwuqCwH5P58N
	 Fb7xZa6Fd7J/Xi1yKbgzU46/mAgODLTdJ9NB0skC2aPjFIMy3n8MXNmKuagiDMXSkk
	 V0wnE3GhDmUWNuFGUL4Yc6UsFzM1YakvhRnNitWhfISaTM+VAW8uBnklywkEmjB6aF
	 D3muxBHfkFcf1BMA03FPcTSaZTBP2gkfM05VPZEEOPvJbK5KxGtKfGr7KvXkQUvajF
	 w/7WgJ/l4msYA==
Date: Thu, 2 Apr 2026 09:52:42 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
    honjow <honjow311@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] HID: gpd: fix report descriptor on GPD Win handheld
 (2f24:0137)
In-Reply-To: <76510dfe-d6da-4398-a78c-a02c596d6f75@linux.dev>
Message-ID: <n39314o3-o1r2-s709-9p9p-6713pppn5q2p@xreary.bet>
References: <20260324013847.68024-1-honjow311@gmail.com> <6268c55d-2f1b-473c-b82d-1de1416d14b0@leemhuis.info> <76510dfe-d6da-4398-a78c-a02c596d6f75@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 1 Apr 2026, Denis Benato wrote:

> > Hmmm, why does this need to be a config option? Can't this be enabled
> > unconditionally? I ask in general, as it's just another point where
> > things can go wrong. But I mainly ask because it's a regression fix =E2=
=80=93
> > and from my understanding wrt to what Linus wants we don't expect users
> > to turn some .config on to keep their hardware running (unless it can't
> > be avoided at all costs).
> >
> > Ciao, Thorsten
> >
> Perhaps the place of this, just for affected kernel series that are out
> (assuming stable has the bug, I haven't checked) is to do this on hid-gen=
eric,
> otherwise it's a change of driver managing the device?

The problem is that the device has a broken (violating spec) report=20
descriptor.

We got away from it before the change, but with more sanitization having=20
been put in place in order to deal with potentially malicious devices,=20
this device (correctly, in some sense), stopped working.

The way around it is to replace the report descriptor with a fixed one.=20
And we do it with a specific driver for now (there have been other=20
proposals, like request_firmware(), or it could eventually be done from=20
userspace / BPF, but none of it hasn't been yet implemented).

I have also been thinking about having a config option that'd link all the=
=20
HID drivers into one huge hid.ko blob for those scenarios where people=20
don't care about memory / disk footprint, and want everything to "just=20
work" automatically (thinking of distro kernels, for example).

--=20
Jiri Kosina
SUSE Labs

