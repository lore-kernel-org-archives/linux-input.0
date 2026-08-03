Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72040DFD5;
	Mon,  3 Aug 2026 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779508; cv=none; b=j7M5VQ7AiE+EXkuYfepl9pSAh8fPf79f76mkerOAB21RFx3GlyGTWH7H2tWzAnJMCPdvNCT98JDoK7HWBUr0AABLCovJecsjOwZ+Pkuvqy/cGMujH1Ui94CWa+h4/92j0ZOvVFiWMFcrolrLwdFvZI7NS7INjV0c+21qpqa4x6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779508; c=relaxed/simple;
	bh=wN25sKGFgVh/TobytATtp2qo5MdhUMdu94BpHFYKMOU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pK0JVsvZvf7v8rKEwochb/1cGudJF881p+ep9kbLRgVjjlrG4wA/NTGSs/lKVJ3pTqX9f9Zc8uNAy5zHqUQ1ESidlzv1zBSnvDC8xL6cGByJK7wTagfTxS0Sc63wUI/5BCEo7O+66AgRX+Cd28cqorjlL0TgJbuLegN6nMRcwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc43MR0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc43MR0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCDC1F000E9;
	Mon,  3 Aug 2026 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779506;
	bh=wN25sKGFgVh/TobytATtp2qo5MdhUMdu94BpHFYKMOU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Fc43MR0OzCuTop9hbY3JGFY4j1H+P0rEtG8lxg3X7ff0eHWB9yBfU+FIDlGQEulPH
	 Eb8TQi+dxKIpLyVu0+lHL1mjyPLbKGuNmL6sYDP+WNSJu6Vkgw1XPNrbvDRtvDUCa/
	 HPitiYPJjAGKLGjU0bLOU7qkFIUWxGOjr84os6y9xcEh1KZ77SUfW5Gv6KjKMAhut1
	 IXAE2EwVG2JqXi6flO2z9pcqH0i5t40azbxF9YiPGV2Sf0yAI2DhFKWsyfuEQWGRjo
	 XBVd81v9d08LWNjGu/QVaMXKL/r0+gjK4DvPAkihtlwzS7yt5F/DQyIt05gTE4baQs
	 +WLpljTw9E5cA==
Date: Mon, 3 Aug 2026 19:51:44 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Jose_Villase=F1or_Montfort?= <pepemontfort@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: prevent unbounded recursion in
 magicmouse_raw_event()
In-Reply-To: <20260715053526.574725-1-pepemontfort@gmail.com>
Message-ID: <11op08r0-95q2-q2r9-o3qo-7949r1n4p081@xreary.bet>
References: <20260715053526.574725-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Jul 2026, Jose Villase=F1or Montfort wrote:

> magicmouse_raw_event() handles DOUBLE_REPORT_ID (0xf7) packets, which pac=
k
> two touch reports into one, by splitting the packet and calling itself on
> each half. The only guard against runaway recursion is a "size < 1" check=
,
> which stops zero-sized calls but does not bound the recursion depth.
>=20
> A malicious HID device that matches this driver can send a report startin=
g
> with DOUBLE_REPORT_ID and filled with the sequence [0xf7, 0x00]. Each lev=
el
> consumes two bytes and recurses on the remainder, so an incoming report o=
f
> up to HID_MAX_BUFFER_SIZE (16 KiB) drives roughly 8000 nested calls. That
> easily exhausts the 16 KiB kernel stack, leading to a stack overflow: a
> panic with CONFIG_VMAP_STACK, or memory corruption without it.
>=20
> A double report only ever wraps two normal reports; it is never
> legitimately nested. Refuse to re-enter the DOUBLE_REPORT_ID case from a
> recursive call so the recursion depth is bounded to two, while all valid
> packets keep being parsed exactly as before.
>=20
> Fixes: a462230e16ac ("HID: magicmouse: enable Magic Trackpad support")
> Link: https://lore.kernel.org/linux-input/20260706181347.700DB1F00A3F@smt=
p.kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Villase=F1or Montfort <pepemontfort@gmail.com>
> ---
> Noticed while reviewing hid-magicmouse.c during the discussion of the
> parallel Magic Trackpad USB-C battery work [1]. The recursion issue is
> independent of that series and is sent as its own fix.
>=20
> I also considered refactoring the report parsing into a non-recursive
> helper that dispatches the two sub-reports iteratively, which removes the
> recursion entirely. That is a larger and more intrusive change; this
> minimal guard keeps the diff small and is trivial to backport, so I went
> with it. Happy to switch to the refactor if maintainers prefer it.

Looks good to me, thanks. Queued.

--=20
Jiri Kosina
SUSE Labs

