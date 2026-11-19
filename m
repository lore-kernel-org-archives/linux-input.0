Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123984;
	b=3PNm/bKRUpdPZXMYULAd/G4Y/Xg8dLeuXwWsVobXsH/G6kkEvWpWUIJDvKztPj/hEVhF
	 AyO1MXIdNPccUUv8QSi7cFqamg6bMLjnj3i4POrAMecabP/TNTT+lSv/TN+vqZcROksE6
	 HXUeA8XNwPyzYKlajp36TNJA47bbiFbkoF0Xfu2OswlsGCa4f2mUsY7f0xRJ9i+J2ItCK
	 lq3Mq7hHkyFhHzhXLfUz9XIJmFMh0WhYNqaVlZ/aOr4vWWXJUSC2xFXZviqqVJWGMCfdu
	 XFl2XtYejT0t/7vpEN31j6zJzReODryg8m6655oWzdkyzU8jPmHWCmdg/sELTD8AvbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123984;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=SC81BuHeXVj80H5QlJ1WuJDqeQh+wFEHRLFZ6bh/nNs=;
	b=O9Xc+wmlx9e3fDKuJLi1y6XAWYfSsDM8AHyUfvj2MugMMsZ9GnIqd4FG/GlFSaSM4k9c
	 VUQxJc2D2lyTTfiQX4d0WXqLzdDrZ428KfaQ08CE+WOUNGipohTZcSNnEXEiZ0Df/m7wu
	 goCjE3ALR3OC1kTPa7ytUCWWTaUhLhqj463yBCNgdYER1hDtpWC7vQhyvhET1v2LS6ZqE
	 tRPbM4lX6pjdbi0XLx3sNYSteo3QF+ZNYUkDgGz8FqEmsQZc8v03t5HZn+vDXGDAa5aYo
	 hMWNN+e6UFui1lUNCX097aIVV+r7k54m1AFpLax2lfcTgKSKbRkZpBTM/HhdW2e1UPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJjLyGp4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3D606A320;
	Thu, 19 Nov 2026 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJjLyGp4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B23F1F000C0;
	Thu, 19 Nov 2026 21:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123984;
	bh=SC81BuHeXVj80H5QlJ1WuJDqeQh+wFEHRLFZ6bh/nNs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oJjLyGp4nkj70ABhsIXelD5NBI5nsuOiClDKgCPP++Qn6Zjl1r0FEL5DuIlAtrYqz
	 gshoGMTaAgFCWHZ9yb/0YNB7G+oLLA00z2MPalnPBh3HMb9EKTFpxuM1dHQxPkrJ8Y
	 vtPOOG2VyUls7sb+dFJGS8CnZybOldhJD2Hu9XLAEOk7oOI058hqShRLE1CsW9z4/+
	 hc3Lq2GjLNAukXq3WeAXP3OGLZOH2MF2ysE+2yTphtgpZulCp0GZwUaFG21L+Vq1cO
	 C0k7e+RkCH3wpe9g2FABO6yrhqLAixxGPOsf+Qz3brLG/lgfzyoS0/DVazds1sMarc
	 wXs5wH3McJbGQ==
Date: Thu, 19 Nov 2026 22:33:01 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: oolaa@proton.me
cc: basavaraj.natikar@amd.com, bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: amd_sfh: Add DMI quirk for ASUS VivoBook Flip 14
 TP420IA
In-Reply-To: <20261019-amd-sfh-tp420ia-v1-1-eb5d0b5cc89e@proton.me>
Message-ID: <on14o9p2-1s60-or48-3320-3op08135rp8n@xreary.bet>
References: <20261019-amd-sfh-tp420ia-v1-1-eb5d0b5cc89e@proton.me>
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

On Mon, 19 Oct 2026, Artem Suvorov via B4 Relay wrote:

> From: Artem Suvorov <oolaa@proton.me>
> 
> On the ASUS VivoBook Flip 14 TP420IA (Ryzen 5 4500U, BIOS TP420IA.305)
> the MP2 firmware does not answer sensor commands sent with interrupts
> disabled, so the sensor hub finds no sensors and the accelerometer is
> missing (no screen auto-rotation):
> 
>   pcie_mp2_amd 0000:03:00.7: Failed to discover, sensors not enabled is 0
> 
> This is the same problem as on the HP ProBook x360 435 G7 and the ASUS
> TP420UA/TM420UA, which already have a DMI quirk for it. The TP420IA
> reports the DMI product name "VivoBook_ASUSLaptop TP420IA", so the
> existing TP420UA_TM420UA entry does not match it.
> 
> Add a DMI quirk for the TP420IA so that interrupts stay enabled.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222143
> Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Artem Suvorov <oolaa@proton.me>
> ---
> Tested on a TP420IA (Fedora 44, kernels 7.2.10 and 7.2.11) with the
> amd_sfh driver from v7.2.10 built out of tree with the same DMI entry:
> the sensor hub is found, accel_3d shows up as an IIO device,
> iio-sensor-proxy reports all four orientations and GNOME rotates the
> screen. Without the entry the probe fails as quoted above.
> 
> This patch itself is against hid.git for-next, where the TP420UA_TM420UA
> entry was added; there amd_sfh_pcie.c builds without warnings (W=1). I
> have not booted a for-next kernel on the laptop.
> 
> With the quirk the log also shows repeated
> 
>   hid-sensor-hub 0020:1022:0001.0001: Event data for report 1 was too short (15 vs 14)
> 
> but the accelerometer data is correct.
> 
> AI disclosure: Claude (claude-opus-5-5, in Claude Code) helped me find
> the cause by comparing with bug 218104, wrote the DMI entry and drafted
> the changelog. I reviewed it and did all testing on my own laptop.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

