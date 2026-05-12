Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B83CC316;
	Tue, 12 May 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602390; cv=none; b=YQ/TaaOK+OC+zA0+ku19LB2ku0I3tqOzVIR8qtX3AJ+zqHO2J0jmgZDwMc8Rmxzm5AKxJ7nSyZIm1SbLRNnnkK/QNwzHaawhLTJuE7kZKrIPt9M9/zTGgpiT/GSSqLmRLqinyHNFY7jXPl4GEPwUhS7Th/2eQ4CkVy/TvQ/rqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602390; c=relaxed/simple;
	bh=aW7ED6qTn/z0l8eu4OvO0G5sEE4weAz9OFO+rdRexK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bC/EKoF31iR1zpJT1Rqu4EW1sKE3VQkbBR7wrMyAPddq8sopAJRi+EevB817C/yKPV1RHGDh+7f7bmxl1m8d+oTgxl1eoRb82QlcBQR6xr3e7eoPkS3VwdDdc9gb70flWlTOpjtfoVcCMCgBYc1v3wIzg0NK4b7pER2iAVN8NNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmXCyWMQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmXCyWMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D91BC2BCC7;
	Tue, 12 May 2026 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602388;
	bh=aW7ED6qTn/z0l8eu4OvO0G5sEE4weAz9OFO+rdRexK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lmXCyWMQDPWkvmG/q09a1kdw3z9hRJmi1VdEo6oClUBrP14YXCV3nuUp+koxIGJxo
	 TBwzZJCw4vX6zp0QJhwOEylUi7T1Priz8aNpwMEl30e+pREjtJN7KgXVFOp8XZIFc0
	 tP8rD3/Hk2zZI5tkHjuvNnPqJGmSWtatHjYKtRWQKhsNRrK4i4G5uEYert7wPe6sqq
	 J7TtQ9hWYLdNLZVb616PnEtQi9dYzJwsq06t+8NneKvK8sHC0nPpGrQfiIGKp/U9Wk
	 kKaJSdr73nXBRdh/gQfL7C25V/QImfhXPDjPtWer4cu//sHudfmp2T91mhbxQ0NbQc
	 lIJeYK13GnzyA==
Date: Tue, 12 May 2026 18:13:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    Denis Benato <denis.benato@linux.dev>, 
    Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add MSI Claw HID Configuration Driver
In-Reply-To: <20260510043510.442807-1-derekjohn.clark@gmail.com>
Message-ID: <n533qs94-7o4r-p5r0-04p1-68q1398n5785@xreary.bet>
References: <20260510043510.442807-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 10 May 2026, Derek J. Clark wrote:

> This series adds and HID Configuration driver for the MSI Claw line of
> Handheld Gaming PC's. The MSI Claw HID interface provides multiple
> features, such as the ability to switch between xinput, dinput, and a
> desktop mode, RGB control, rumble intensity, and mapping of the rear "M"
> keys. There are additional gamepad modes that are not included in this
> driver as they appear to be used in assembly line testing or are
> incomplete in the firmware. During my testing I found them to be unstable.
> 
> The initial version of this driver was written by Denis Benato, which
> contained the initial reverse-engineering and implementation for the
> gamepad mode switching. This work was later expanded by Zhouwang Huang
> to include more gamepad modes and additional features. Finally, I
> refactored the entire driver, fixed multiple bugs, and refined the overall
> format to conform to kernel driver best practices and style guide.
> 
> Claude was used initially by Zhouwang Huang to quickly parse HID captures
> during the reverse-engineering of some of the features. Since Claude had
> already been used, as a test of its capabilities I had it implement the
> rumble intensity attribute after I had already rewritten most of the
> driver, which I then manually edited to fix some mistakes. I also used
> Claude to review the driver and these patches for any mistakes and bugs.
> 
> Assisted-by: Claude:claude-sonnet-4-6
> Co-developed-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
> Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> 
> Derek J. Clark (4):
>   HID: hid-msi-claw: Add MSI Claw configuration driver
>   HID: hid-msi-claw: Add M-key mapping attributes
>   HID: hid-msi-claw: Add RGB control interface
>   HID: hid-msi-claw: Add Rumble Intensity Attributes

The driver looks reasonable, I'd just like to propose that we name it just 
hid-msi to follow the usual HID subsystem driver naming standards, so that 
it can later be extended with supporting other MSI devices.

Thanks,

-- 
Jiri Kosina
SUSE Labs

