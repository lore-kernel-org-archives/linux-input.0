Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AE04756D2;
	Fri,  2 Oct 2026 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932455; cv=none; b=swvUBnFedmZH87/OxMrKTQNOnfw2UbCGh+Kmq/RgQcSbAbjL5itbZFXWQgK6d3zgwgz5530UtwMfpd7eHX/4syo9CAnQ10glMiTVnLz8KzwGoB6PCIe0y+rjyqXQtocYKkxIqg/8t3gOY8XaoALnrb5WPt36GIXJIenOv0El8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932455; c=relaxed/simple;
	bh=aw6uSXbLMy74qOQqoHeSC7diKmQDCzC9Q7cGoNVP2F0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ydwzx/HHs8lfWIXZMjdZwBTew1hhhMCXyZbGHWFRxz7vkxpJ1pSZDcNEQzXcQiCmg5lcrhimSLkX/mViT5neY5Cqcsa0ihfEfbGZZ7P4amnHLXoyfFCjgrltGqAUV4C5QB8JfrkbCl3ryibnJU7ODqYCEoiEFPdhKFYuRS6Ik7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOsOB+L7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOsOB+L7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3981F000FF;
	Fri,  2 Oct 2026 09:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932454;
	bh=yM9BHlNT7vQR0P89DJMJO4npmT/W7+z7KU1IZUDfCrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DOsOB+L7pBTP5Q94Yr2TOVufOROlHqQbtuWTZ+mxDXZR7BdZZCEkFnu3pTpQEepoY
	 cJmGF2hX72pIUT92LjD/zvJuo5JzeVlQWtO8Vxxd8pHMxy3eVnDP+o7w7Q6dypvId8
	 2ZKT4ECaLBcWL8o4LJZB2BQ7gk1y0w1Fnd8xwxiDVr8A6UYIUizF+TEubamJmHtgc8
	 7DNHgXuuvPEdaAZ/YtUanpWe7sl/hzasNJHEC6wqDKJr/rcPOklJ5M6iAdW20T9CpY
	 UMTzf5jyNGIS+dJZFDqz6R+X2f2kA1EQlw/4iLCRTx3mFeo/Ur1ZdRVvFOB3Wo68Qx
	 KTHRT9v691UUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 09/12] bpf, trace, net: prepare
 CONFIG_DEBUG_INFO_BTF checks for a tristate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>, linux-input@vger.kernel.org, linux-modules@vger.kernel.org, gary@garyguo.net, linux-perf-users@vger.kernel.org, sched-ext@lists.linux.dev, linux-trace-kernel@vger.kernel.org, ojeda@kernel.org, dmitry.torokhov@gmail.com, bpf@vger.kernel.org
In-Reply-To: <20261001225214.12351-10-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
 <20261001225214.12351-10-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:13 +0000
Message-Id: <20261002091413.9B3981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kconfig: bool options depending on DEBUG_INFO_BTF are disabled w=
hen =3Dm
--

commit cc56fafe832c4d8fb30d0a4f3b0686d5906ac2ec
Author: Jay Wang <wanjay@amazon.com>

bpf, trace, net: prepare CONFIG_DEBUG_INFO_BTF checks for a tristate

This commit prepares the tree for CONFIG_DEBUG_INFO_BTF becoming a tristate
by updating preprocessor conditionals and Kconfig dependencies so that BTF
generation works correctly for both built-in (=3Dy) and module (=3Dm)
configurations.

> bpf, trace, net: prepare CONFIG_DEBUG_INFO_BTF checks for a tristate
>
> The next patch makes CONFIG_DEBUG_INFO_BTF a tristate.  With =3Dm, Kconfig

[Severity: Medium]
When CONFIG_DEBUG_INFO_BTF becomes a tristate, will this cause bool options
that depend on it to evaluate to 'n' when it is set to 'm'?

For example, looking at DEBUG_INFO_BTF_MODULES in lib/Kconfig.debug:

config DEBUG_INFO_BTF_MODULES
	bool "Generate BTF type information for kernel modules"
	default y
	depends on DEBUG_INFO_BTF && MODULES

If a bool option's dependency evaluates to 'm', the highest value it can
take is 'm'. Since it is a boolean and cannot be 'm', it is forced to
evaluate to 'n' and is completely disabled.

Does configuring CONFIG_DEBUG_INFO_BTF=3Dm unintentionally and silently dis=
able
module BTF generation and all associated BTF-dependent features (such as
SCHED_CLASS_EXT and BINFMT_MISC_BPF)?

This would seem to contradict the goal of keeping module BTF active when
CONFIG_DEBUG_INFO_BTF is set to 'm'.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001225214.1235=
1-1-wanjay@amazon.com?part=3D9
