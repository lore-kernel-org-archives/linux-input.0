Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767085;
	b=XszEyUiLuW6Hk+aEDv547VfJKYhbyvdAK6v3qbRgivjU/TY3PR3X5n0kHybmE9hnuupw
	 hoHw/qbGu4tGIm64pUaLftljGSlFhgZZsyIJUXVv587NtnrUMTNaAM8QQB4HJl4p4XcXW
	 K+Sv4NViFpSgG7znncG0VbsqKP6vUYXPsVCFOT0DjlMhtQiKWZliEUfy0raJcjN32nTrS
	 6pc/uHRsY9gkx0lF7a7MgiCf5SUeusbI1eHSr8ZUUBSlJcSd3qxPff81XuJbjnJTg+/et
	 T1L6Yo+rlXM9GsSClYbWNkuCA5yQIHnLVu89fag2Ivo7j2iaGH8sQb56yfBykhcT+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767085;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=06uaxjYb61RL2OtkDz5Lhi5Ab9g1aDhrY0x2xqtBBQE=;
	b=EVgByOQoY1LQaXlXx2URfUjvSb8u8F6y16CkHV+Evr9tn+m7uzHQJ8Ql38vODvpG7bFl
	 f6WZ63ezU9YTuSYgPmtlTUaugK+9h3szyRibssOh7D2YTPAZ3XRXTZkz1EoxdEA/ySYGb
	 N74SjkldBZlYYD+sEeS5266r33Z4e0acGuzyrnQ/ybpTPs5wDvExeO2dfhbaw+SSfAG47
	 gpMU2gRmPidQVePrATCViKgOVDFLg7GFm7hWa63jsGlBXxX4CvErJ24eb6aQnGF8sRm7J
	 PRHVTT3pjomyHsP6+p2d+qMgbLbkSY6oRqMgHZZkTNSsPxW9vu5p36ckVfEc1yqaPxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kuU/Kp/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC372606A323;
	Fri, 27 Nov 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuU/Kp/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B7A1F000C1;
	Fri, 27 Nov 2026 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795767085;
	bh=06uaxjYb61RL2OtkDz5Lhi5Ab9g1aDhrY0x2xqtBBQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=kuU/Kp/SsQywfqqQvxZ43Sa976h4DUopOeKQXo2VEg7nLTvbUBpODnycrmdPciu6o
	 1ksnIs/CAMxGGY3031sj5dt76OYJM+M8fsekP8097GdE6CTf3Eg2/uCOqUBmf8bYGM
	 0Fd+BhStk97xZl4XM18zsXd0r6A5WQBav8NEA1CpMOSItgLHR+GkS7l6Ut/4KmRdFU
	 LeubVqdzYNJX541Q9g8NjGJrL+6LZEWqTCEiNaQt9xWMMIoN799O0JEUWOtxA/DWm/
	 l5gmFCdIl9pE7wrq204Q8WaXbwZa+VeYHMncEp7VlpcHo7uyPcNzQ/mHqGYXvsGWx4
	 hH4OlXfE58F8Q==
Date: Fri, 27 Nov 2026 09:11:22 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Ian Rogers <irogers@google.com>
cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
    Elkin Cruz <elkin@google.com>
Subject: Re: [PATCH] HID: lenovo-go: Fix reset_tx_dongle sysfs attribute to
 be write-only
In-Reply-To: <20261119170418.1511770-1-irogers@google.com>
Message-ID: <721qoq9q-rns4-q082-5qr6-6nr72s5n84r0@xreary.bet>
References: <20261119170418.1511770-1-irogers@google.com>
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

On Thu, 19 Nov 2026, Ian Rogers wrote:

> reset_tx_dongle is defined with LEGO_DEVICE_ATTR_RO(), whereas all other
> FEATURE_RESET_GAMEPAD attributes in hid-lenovo-go.c (reset_mcu,
> reset_left, and reset_right) use LEGO_DEVICE_ATTR_WO().
> 
> Because feature_status_show() has no case for FEATURE_RESET_GAMEPAD
> (which is only handled in feature_status_store()), exposing tx_dongle's
> reset attribute as read-only makes reading it always fail with -EINVAL
> while preventing userspace from writing to it to reset the TX dongle.
> 
> Change reset_tx_dongle to LEGO_DEVICE_ATTR_WO().
> 
> Found by enabling Clang's -Wswitch-enum on an x86_64 allyesconfig build,
> with AI coding assistant help to audit the warning and prepare the fix.
> Build-tested with Clang; not runtime-tested on Lenovo Legion Go hardware.
> 
> Fixes: 82cd9bc866e1 ("HID: hid-lenovo-go: Add Feature Status Attributes")
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

