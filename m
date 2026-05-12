Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A13C37BA
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600386; cv=none; b=DI5hG/krfuk4MRipHIaNCgvzjeWwWWarGVJdpubWUOyiewPyrTFyo0CXAluskU6mbEb6FkikJHO0PTBCFwmEqvtob0b5eC6Ypvcq4OIiDYOio87t/AiEIW26uFJJqYNNpAcgOnrnkDGsipJKUf9spYaczCJi536MPGo/xWgXdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600386; c=relaxed/simple;
	bh=ntAojKWua7SVCWueOBM0A4gFHE6Sf1ClZdpTPKqm19Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bUNYrpr6XZunqvGZ0EouJTk3OqIg83P6up2GHyadHi48Q9Z86zbIKakV1TbTJfTTmH4df9uHXD56vCGJxlI8Eg1TZUtWtU8aZqfqOPMi7BAHi4eB0Z9CqkahlE4ETSc4raATIg8uYtUaoxk466h2O4j8a5vsRe88Nn7XWqd9ZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5wC4irT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5wC4irT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE45C2BCB0;
	Tue, 12 May 2026 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600385;
	bh=ntAojKWua7SVCWueOBM0A4gFHE6Sf1ClZdpTPKqm19Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=m5wC4irTJC87U3juwncWpELZoBZqki2UKbo90FujSEpM4rXN2lJhkwRF8EaqqC15P
	 rSWjPaHU36VOhua/aUndWYdUn+ETOjA45iEsTa5rYdBF7twSRfvNMx/gJzW4bKaRGA
	 QbZHshEF3yStr5Ov9w1E8mfQ473eNvSk2Iy+0o6JXkD4gSYCumadiDfgyafkZD5A4L
	 00uzAeuUpeb//9B50Qdbak6mlL5UCohBZ/r8kJOlKNI06q4SVk9WbLMGm6fpzDWVHl
	 NisZ1BUUBBM9vqjZaM1PpqHq2jE3hAWWWFWu2hWGVCvZER1wkD0EJ/hugrXLBfbpFK
	 lMusGPpl5o8qQ==
Date: Tue, 12 May 2026 17:39:43 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dave Carey <carvsdriver@gmail.com>
cc: linux-input@vger.kernel.org, bentiss@kernel.org
Subject: Re: [PATCH v2] HID: multitouch: Fix Yoga Book 9 14IAH10 touchscreen
 misclassification
In-Reply-To: <20260413125803.46792-1-carvsdriver@gmail.com>
Message-ID: <364r776o-6771-o29n-8ss3-857n32071op7@xreary.bet>
References: <20260402182937.388847-1-carvsdriver@gmail.com> <20260413125803.46792-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Apr 2026, Dave Carey wrote:

> The Lenovo Yoga Book 9 14IAH10 (83KJ) (17EF:6161) firmware includes a
> HID_DG_TOUCHPAD application collection designed for the Windows inbox HID
> driver's Win8 PTP touchpad mode.  On Linux the HID_DG_TOUCHSCREEN
> collections provide the correct direct-touch interface.  The presence of
> the touchpad collection causes hid-multitouch to misclassify the
> touchscreen nodes as indirect buttonpads, leaving them non-functional.
> 
> Within the touchpad collection:
> - HID_UP_BUTTON usages trigger the touchscreen-with-buttons heuristic
>   that sets INPUT_MT_POINTER on the touchscreen applications.
> - The HID_DG_TOUCHPAD application itself sets INPUT_MT_POINTER via
>   mt_allocate_application(), propagating to all touchscreen nodes.
> - A HID_DG_BUTTONTYPE feature (report 0x51) returns MT_BUTTONTYPE_CLICKPAD,
>   setting td->is_buttonpad = true for the entire device.
> 
> Additionally, the firmware resets if any USB control request arrives while
> the CDC-ACM interface is initialising (~1.18 s after enumeration).
> The Win8 compliance blob (0xff00:0xc5) and Contact Count Max feature
> reports in the touchscreen collections trigger GET_REPORT calls at probe
> that hit this window.  Surface Switch (0x57) and Button Switch (0x58)
> feature reports are sent by mt_set_modes() on every input-device open and
> close, repeatedly hitting this window throughout device lifetime.
> 
> The firmware also leaves a persistent ghost contact in its contact buffer
> (contact ID 2, fixed coordinates, tip always asserted) on every enumeration.
> This ghost occupies a multitouch slot and prevents KWin from seeing a clean
> finger-lift, causing stuck touch state.  The ghost is cleared when Input
> Mode is set via HID_REQ_SET_REPORT at probe.

Oh man, what a device.
Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

