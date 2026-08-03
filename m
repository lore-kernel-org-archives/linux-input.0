Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57938F945;
	Mon,  3 Aug 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786149; cv=none; b=krdgglwHNepIW4Ahfhf2LjARWIjXEclDPOggRRidft2uhYhp6RKORB0pas0EH+iaohyk8WLumwz3WFY9bRNDhXNDb139weMdIYHndPWzt/5TXxSB9VWAR41DrNwPFZeaXtm0Boq2fiuYcB4fStjR+DlmHN2+LGoELQuj6zaCtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786149; c=relaxed/simple;
	bh=UZZxPuYF4VskiTorbPtrxUYQMq7QIuTMmu9jn1T0B6M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HqsfqrKT5EpkojsV94KkqcE3n3zHxqPJ73JSDeyCiQYisZqEB1xT63OCLKcmT5Y3cWCILr+tKFfv+dYpRJUeh2V9VzpiE76qe8kuOnrbXtlZppKoYIXRpyy1kTZF3pd8wFW+QsBRF2r2Mn1p66+nVfVnc7UfCujpNOTn+icJbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erzYjX/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erzYjX/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B351F000E9;
	Mon,  3 Aug 2026 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785786148;
	bh=uKDvb+7BjDjbIZbK5so1hZN87PZxzHZIdme5WTnNNLQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=erzYjX/QDpMBE2wq8I66ydu+uHJp5S72tG7WoB5U5QUmMeDpMvgzUmMTTcX3d/T8M
	 qQeHKRHHpQRn0COKGCHZ4Jf+S44ER9evY//vw9daPbFv2uu2hmhUWp8eEY/wFjNQSa
	 +w7FXMn42IyHDVSB7OUT14ap9sJo+Mg/o6DsaMfiiAaiqbMJa/Ru/7jjFCMdWn8Vx9
	 f1dWsGLqP6UjG6i2/2LppWXgxQ4i2ukQ/b+gNsGrR/yfQ79amapg6vjHk5v7/eHF4A
	 kHSLR9Sthx1pc36fOekvEwBFmTLRu7sPcRdMhBddtNMoEnHeYdW0d/NJkD+dAKDaRV
	 ZygQSECGznv4g==
Date: Mon, 3 Aug 2026 21:42:25 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    Denis Benato <denis.benato@linux.dev>, 
    Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 0/4] Add MSI Claw HID Configuration Driver
In-Reply-To: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
Message-ID: <n7so4q55-1699-6s6p-qo38-4pr7055202qs@xreary.bet>
References: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Jul 2026, Derek J. Clark wrote:

> This series adds an HID Configuration driver for the MSI Claw line of
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

Now in hid.git#for-7.3/msi. Thanks,

-- 
Jiri Kosina
SUSE Labs

