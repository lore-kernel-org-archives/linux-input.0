Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121548;
	b=eyCxswCsqYw7Ff/9JwNz43rgOoscvgm/oAm8TVCyd4YrhYtOHbRoG///1qmMqCmgU9gG
	 CZVzze+rx5NGzc8JVUBeFIyn0ByR37E2VKfr5nvtq00Lil5zTzjdExQsQpBaRe/8eG0FL
	 vETSAK7/F+hl5tV+a49WUkgQ9ThnI7vjGSP/FC6t6k2qsQm5xgYX+ygEgW/6bP6gq/H2T
	 1r49MKIyYICNusPDL6VzYP1wSDdwSQhRwFlfivTwv4BPAO7JZzNiBJVQztFXbhmn0RaKZ
	 p2q9hrKPP4jaJ7BwnQqKsluMRjCS1rTPALPxO84I5r5mX+5NOVA6ORiBoapLRKaWnvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121548;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=FJmvMFDcyGQCXOCIHAhT7RJ/i5rH1OLf0MHq1diJsgU=;
	b=w06h10Erdy7VE7a0v1TTs4NxN7GmyPn4xtbfWxTRrAFbIj2j3PnKGc4ROf/iRTBHbQZ6
	 H/XthzJwdvX5TjFpSaK1GJj89GCqwFeDeFBQH7gvXI7D6uDH41dbbZ2NeBB9no3Wrf5WJ
	 CcM6J2rJ62maKVSFtGnRYwhe+06rpkfKeP1fSFFO/d3e4+WZr7+ipqFUg0xFdsQy3ZSuf
	 O2a5eStWQ3zeS6A+L0yThEs2hb8mrB8da9Q1MS5ZyCnthYL25oA5Vo9PwLBUkKSCvjzmx
	 lV8TuV+/1Wgp08s7EzIWyciD/9OI1QccokM9nhZvw7TaTpp5vn9qSBYrC77chdmlLGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNpc6c42;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5A606A337;
	Thu, 19 Nov 2026 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lNpc6c42
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1EB1F000C6;
	Thu, 19 Nov 2026 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121548;
	bh=FJmvMFDcyGQCXOCIHAhT7RJ/i5rH1OLf0MHq1diJsgU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=lNpc6c42XCW/cM1OX30eNLVmgMH1UZ7VkmPm81oxj8NcxqjAn/jke+896rdftb6nl
	 0oi087XRQ5D1LubnK9nZDh9AYzbgzl0LIk3F3s2xPIvaM2icZi73Ho5Rb5r9jpOnju
	 jA07WSjfR21YY5vmX5wVdUoivpuR8+d9lQMNcEbvVthXyrzyvEPgkUc27ZKJpVCULs
	 YOyB8VwRRSttXWcM18MkCoZiv179gkkxyz1xVW4lmssZCgdF3/z4wgvQQACZrbj0M9
	 3flPzcbZ8eXlfaWYGtBAeddyNhBaYGe4sLx1JEEFoSzGQ/ezP9tWHpDtMS54Np/FjP
	 HlRmjmT8dyLTg==
Date: Thu, 19 Nov 2026 21:52:25 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Hans van Essen <hans@kilurion.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: asus: Resume the device before sending feature
 reports
In-Reply-To: <20261006-hid-asus-autosuspend-v1-1-0c3df3121063@kilurion.com>
Message-ID: <34rqnq66-8885-op7o-649q-43p893474qs6@xreary.bet>
References: <20261006-hid-asus-autosuspend-v1-1-0c3df3121063@kilurion.com>
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

On Tue, 6 Oct 2026, Hans van Essen via B4 Relay wrote:

> From: Hans van Essen <hans@kilurion.com>
> 
> asus_kbd_set_report() sends a SET_REPORT control request through
> hid_hw_raw_request(). usbhid does not take a runtime PM reference for
> raw requests, so the request fails while the keyboard is runtime
> suspended. On a ROG Zephyrus G16 (GU605CW, N-KEY 0b05:19b6) with
> power/control set to auto, every deferred backlight change from
> asus_work() is lost:
> 
>   asus 0003:0B05:19B6.0002: Asus failed to set keyboard backlight: -108
> 
> Wrap the request in hid_hw_power(), as hidraw does, so the device is
> resumed for the write and can autosuspend again afterwards.
> 
> Assisted-by: LLM
> Signed-off-by: Hans van Essen <hans@kilurion.com>

Applied to hid.git#for-7.4/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

