Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA331813A;
	Fri, 14 Aug 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717953; cv=none; b=Mf95XiwkgE1F06EsbM4uzGSjAzshX/0h5P0FKoXseGC/h3l/LemtutshbMKfTjgqv5Po+eHpUSNOxsx7GvuVbuzOX31Rw4p820wHMqpnD232XyVwGwZP9uyoyMSRuKKtIVGNg3eyBMEW8DSVkZaXoVH26chVUMJrCMXDbfGsRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717953; c=relaxed/simple;
	bh=anZcQCT8qIsuelZJvDML54mDz8lAWoxAIv0TFPsd+lc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q3PJXVOHESiTyX2bqiurdHr0X9mWc46zkdLHomT397jQ/FenQEu+3p8cDlVy0VYPWVGvgUcB0N2AxDMl1NamCaglEiV0bXZVSvWA2v3+kJF0xApc5v6GY2TEw6MntNBhLczxxYjSAnP/qpvlYteoTrmvos3gYdPA5IQkqBt2A7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWysoXJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWysoXJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE081F000E9;
	Fri, 14 Aug 2026 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786717948;
	bh=1nITOYWNgBh2dRjiTSZd8lIOZORAwyy2hmR8YYBT2pA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=XWysoXJ0aGNfvtP9mX+c84ZPnB+eyhP0K3ug2+O4aVCBQ6ms+aH9jiHxlFj56CWwH
	 UZXg3fAh5dDRK6qY4Tuukg79ydqX8j/5ec6i/MTa4kB6DHFB12H/sdzZgbBj05yyaU
	 9mVPFkGXTzbNM/STyhwZsbj/FeBqT3G7YyZobenHwSIt7Csz40hOcXXJhRv/+5W9Nl
	 42UX57boyDwL0Sm6LKmhnRxNUeo6nAHGTvmUZm9jKoXlkHtOW3WwlM9y6ClDta26nb
	 zAgczthdhc6PU2wF5fxFaECrqZnjFRyc/BRTUa+y07IiOdl9mqfG83dvNYpbOCWpxt
	 iOB0XG+1mCXnA==
Date: Fri, 14 Aug 2026 16:32:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Anssi Hannula <anssi.hannula@bitwise.fi>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: tmff: Use 64-bit arithmetic for force feedback
 scaling
In-Reply-To: <20260710102314.190094-1-lilinmao@kylinos.cn>
Message-ID: <2s1poqrp-2419-rnr9-o3pq-6rp1s2p62865@xreary.bet>
References: <20260710102314.190094-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Jul 2026, Linmao Li wrote:

> The logical minimum and maximum values come from the HID report
> descriptor and cover the full signed 32-bit range.  Subtracting them in
> an int can overflow before the force feedback value is scaled.  The
> subsequent multiplication can overflow as well, producing an incorrect
> value despite the final range checks.
> 
> Use 64-bit intermediates for both scaling helpers, as done by commit
> 48d1677779ad ("HID: pidff: Fix integer overflow in pidff_rescale") for
> the same arithmetic in the PID driver.  This keeps the arithmetic
> defined for the complete descriptor range before the result is clamped.
> 
> Fixes: dc76c912145f ("Input: use new FF interface in the HID force feedback drivers")
> Fixes: b27c9590ca0f ("HID: add support for Thrustmaster FGT Force Feedback wheel")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

