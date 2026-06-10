Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA432BF41;
	Wed, 10 Jun 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108775; cv=none; b=YF0JgK1DUllGnNYDGhABHS6soKnDqVM1J+xM8HJrRqBdLmwGslFiOBSmEBJoIcxRmaHDDnlgvVbZaq8YfO2upx9iYHbb0h1obq11kI9nepWEb2tDMw4+yiHndqFYTzpK29St7D/GuMtryTZVmdd8KnX39hP5WJcUUserXWZCZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108775; c=relaxed/simple;
	bh=lWPWAaKcQCrq22bYN+oAHTAzp/J8hjQCOWWVD9TzxMw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mmRTBcO4HZfg3K+te56vW6HTJ6lfKW84O58GKQgonllJmFldgUEd2cNT7diZC441/vsNF19Zn8h9Gpo6g1ulXj7z3/rHF1sPya/fwnRLj+d9Q5+oyFImecd1W8CXhEguoiLxkJ4DcK72xgUWmf/xxVirGqvzpTPT/FUyHaxHzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTGON0bn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTGON0bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C2B1F00893;
	Wed, 10 Jun 2026 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781108774;
	bh=v1Y8VuZ+WAA4XeUchUJkz8T9aRlWHSuunnoP7umpYYk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=bTGON0bntkxfIWn2kRGgEwX8jjJjTDjr6vG3+n8+WDWNw+mn4XIIt85R8dc0iFalA
	 bgy23zxzN+UC3GX7APnYeEUCR7oZMaWkgVO7j3c2afErZOaYcqQy2kUqjZIDl7Qlub
	 KM+4z+WsOmdRIhfQ/26zYczGvvGHo3zf6UKc2wBV24RbebhJGp27E7PC29Za3/6vVt
	 OfFT/5OXZD6w0LfIF6oMj6d5g+cUeOGjiSI32li5/nVV8a4Si1Iku3l2G8Wi8u93MX
	 CNJV6rgsYBAvUuQRD4uRqGXiVRnM7Wq1MCUWrtfqlf2JGUztPK53T49bbwPGfCrTlJ
	 rWVTqfYZH9VZg==
Date: Wed, 10 Jun 2026 18:26:09 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Christian Fressl <christian@fressl.at>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: magicmouse: add haptic click configuration for
 Magic Trackpad 2
In-Reply-To: <20260514171524.110189-1-christian@fressl.at>
Message-ID: <n0o5o6ns-42s5-6107-q790-q06o3so0r817@xreary.bet>
References: <20260513001649.E9EE5C2BCB0@smtp.kernel.org> <20260514171524.110189-1-christian@fressl.at>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 14 May 2026, Christian Fressl wrote:

> Apple Magic Trackpad 2 devices support persistent haptic feedback
> configuration through feature reports 0x22 and 0x23. Add an opt-in
> module parameter to select either the verified silent-low profile or to
> disable haptic feedback.
> 
> The default remains unchanged. The report payload format is
> reverse-engineered, so keep the existing payload bytes fixed and vary
> only the known 24-bit feedback value.
> 
> The USB-C Trackpad exposes multiple HID interfaces. Use the one-shot
> actuator output report 0x53 only to identify the interface that accepts
> the persistent configuration reports; do not use it for the persistent
> setting itself.
> 
> Tested on Apple Magic Trackpad USB-C 05ac:0324 with Ubuntu
> 6.17.0-23-generic. Compile-tested against HID for-next.
> 
> Protocol information was derived from public reverse-engineering notes,
> then independently tested with local hardware.
> 
> Link: https://github.com/mwyborski/Linux-Magic-Trackpad-2-Driver/issues/28#issuecomment-451625504
> Signed-off-by: Christian Fressl <christian@fressl.at>
> ---
> Changes in v2:
> - Cache haptic_click with READ_ONCE() before applying the setting.
[ ... snip ... ]
> +static int magicmouse_apply_haptic_click(struct hid_device *hdev)
> +{
> +	unsigned int click = READ_ONCE(haptic_click);

Can you please elaborate on why the READ_ONCE() is needed specifically 
here? I don't get it. 

Thanks,

-- 
Jiri Kosina
SUSE Labs

