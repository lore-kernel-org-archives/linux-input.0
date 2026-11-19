Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123910;
	b=JgtjzH8X5CmPxYgmvkMud8MZV15HTVptnTxTAyuBXVejOqG9JSmI8M2GO3xDA8epAOas
	 QcjdK4lsYMRJqNbr9M0hT4Pzdjq47W4Vk0cbur6CxU5UTDzdIvUK3MZi1HznvBzNH3sFx
	 psQBqEeuSZzDMIYVDx2MWGEhvhQC5W60EDMlbxbltX2375tf/ZD+a/VToA0hQKSAR/X1I
	 N8r7XbCaUrcKyq8i6ROcp27krhzMDhEcsdWsPrk40Zj47Za8CMMvaKwec7bq/7JHT1S4o
	 7oo3/enZmt6OaK2wnnjU3raGTEXFOzuTjUN2LoJB5w1gVKqvDX7qT+FowUrB/Njks4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123910;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=hR/0TtpGv+lHBP8MPeHswSPhOSJikXAppFHSJ5UID/A=;
	b=01hynFclAV9jD9Xh3x/bOb6eBrU0QaZ3AwP/FeVdxGZ2HbfnqLEK9yhzczOjCGjPlwfD
	 ka8+ZlGn5UWqWDmsFnLZSYURLUHxFScOv1QgjeFULuLSdU6hkE6VnCad9Y9F500Hdi+Rf
	 eMkQEUJYciTl9HOF3v3ZyW2+pNCEPpZaINiTGNVMOn1qKwhVI3fXl67BbYki/FMwLD5gP
	 ngYO7rf/3xVxboJ6S2WG0zUctA816gMm3XQgGBR+id4rLN6uzSziod5iPYeKbOSJXYlVS
	 SI6nGwEGmRS7V/6kHvu2Jdr93yVjWeoLzs0OQzLS15pVEGTjeVPzgJdnHj6v7c/hyag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A0jp2Cfd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2524606A32A;
	Thu, 19 Nov 2026 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A0jp2Cfd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD89B1F000C0;
	Thu, 19 Nov 2026 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123910;
	bh=hR/0TtpGv+lHBP8MPeHswSPhOSJikXAppFHSJ5UID/A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=A0jp2CfdEkPJOk+/kWokrZXyO0S7f2oMbPTys7PUeAPJmzGUMywz6ooyBKdWBiRLr
	 F9qAuirGMCy3///ztX0OHjAMQlMDOnPZm7E1/o0PGx0YnzU71Nk006UcCU0P8EeG4a
	 hO4da2Ew2dup27AbPJ13TXbvn4V5kREGbeXhw78nRmbrUPUKKfrbNJVRfIvmFQvGdq
	 x9y5lmYy2AgTTM2pRl+cdh0hSm7klZCDZSthl4bshOVE8A7xaqMNIvC2ygp1nXmvD+
	 7qR7c9Htkx8+qQYy8AfRBHQUbONawQpOOndeONkh80bPSaK1OktgvaghyjnoHHQ/C1
	 9CVI3xtNVpyPw==
Date: Thu, 19 Nov 2026 22:31:47 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Paolo Pisati <p.pisati@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Denis Benato <denis.benato@linux.dev>, 
    =?ISO-8859-15?Q?Rebecca_Mara_M=FCller?= <rebecca.mara@posteo.de>, 
    Luke Jones <luke@ljones.dev>, 
    Joshua Leivenzon <hacker1024@users.sourceforge.net>, 
    Ivan Levchenko <me@livan.pro>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v4 0/7] HID: asus: ASUS Zenbook Duo keyboard support
In-Reply-To: <20261020092423.36380-1-p.pisati@gmail.com>
Message-ID: <op1o5n3o-s3s4-1q2o-65pn-onss079rn780@xreary.bet>
References: <20261020092423.36380-1-p.pisati@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 Oct 2026, Paolo Pisati wrote:

> Add support for the detachable USB/Bluetooth keyboard of the ASUS
> Zenbook Duo line (UX8406MA, UX8406CA, UX8407AA): hotkeys, keyboard
> backlight and the platform profile key, over both transports.
> 
> This patchset is a collective effort, gathered here:
> 
>   https://github.com/NeroReflex/asusctl/issues/25
> 
> Tested on a UX8407AA against 7.3, docked and over Bluetooth: hotkeys,
> keyboard backlight, Fn+F profile cycling, and the touchpad staying with
> hid-multitouch.
> 
> Since v1 the series has been reworked with the help of an LLM coding assistant.
> It was used to analyse the review comments and the code they point at, to
> draft the changes and commit messages that address them. I reviewed every change
> and tested each version on my UX8407AA, docked and over Bluetooth.
> 
> Changes in v4:
> - Rebase onto hid.git#for-7.4/asus, now with Denis's "improve the
>   driver support for laptops" series.
> - Drop the delayed handshake re-send: Rebecca measured that the
>   keyboard stays in hotkey mode without it.
> - 1/7: check one quirk per branch and the transport in a nested if,
>   initializing rsize_orig and offs so that clang still sees them set;
>   use u16 and declare new_rsize at the top of the block (Denis).
> - 2/7: shorten the comment and put it next to the mapping (Denis).
> - 3/7: shorten the comment (Denis).
> - 4/7: only handle usage 0x9d on Zenbook Duo keyboards, and take the
>   worker lock with guard() instead of a goto and a label (Denis). The
>   IS_REACHABLE() checks stay in C conditionals rather than #if, as
>   coding-style.rst asks, so both branches keep being compile-checked.
> - 5/7: list the report sizes of other devices in the comment (Denis).
> - 6/7: move the entries above the existing HID_GROUP_GENERIC ones, so
>   that they do not conflict with the T302CHI dock entry in for-next.
> - New 7/7: keep the input device names the keyboard reports instead of
>   renaming them to "Asus Keyboard" (Denis).
> - Add Denis's Reviewed-by to 3/7, 5/7 and 6/7.
> - Drop the Assisted-by tags, following "docs: remove Assisted-by
>   references" in linux-next.
> 
> Changes in v3 and v2: see the v3 cover letter.
> 
> v3: https://lore.kernel.org/r/20261013104033.36079-1-p.pisati@gmail.com
> v2: https://lore.kernel.org/r/20261009153459.124752-1-p.pisati@gmail.com
> v1: https://lore.kernel.org/r/20260513163248.16483-1-p.pisati@gmail.com

Now in hid.git#for-7.5/asus, thanks.

-- 
Jiri Kosina
SUSE Labs

