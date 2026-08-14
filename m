Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408C466B0B;
	Fri, 14 Aug 2026 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711678; cv=none; b=uhPRTLE/VVi6/t0thOcSljfyighuaYr3vZXhGe7QQ/55oz1TUx24mFNKcZkFM8aPoPh+f+k6l/o4v3d6AQo0cKQnbURt2nNvsYYyaxBYX0DxmLlA7at1Ya81hCcfInkqPYDfANi98pa0l0ojmwwTgZVL2Cgoh0sgfCOuJAynmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711678; c=relaxed/simple;
	bh=wNt5LqwidsRRl0JKphZ70gL19AzBw36ECDcKtIJqAYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NMI5Fyg6h4JbADAKXnNvqN+9k0pp91GVTwHi4Wp2g9JHEc7M93zcxzZZP7B8te6/Sz/uM3mj8RZ5SdLDyha2dYo+F84WPSY7dpy5u+dakfv6T2nUSlcN/nUeBlcl7Gc4YgQeWOiIc2/hTIIoXZ6qEahtQiq+Zxm1qarbHrhiknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyoXp32P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyoXp32P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468031F000E9;
	Fri, 14 Aug 2026 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711672;
	bh=06mLJwL4Uya+skJAcclFI2TzrZHJaJpAths2EEz7XYc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=VyoXp32P1pzGzPEZpQ3UdrOHsBe8F4RZ/VcG6z7lWrptZnBI6HVhBjCkczInb5kkW
	 pvolnzCYndEqnBvrK+Bc0PNeLc1M0WlDhfdpR665VUQnuNBjLyAWYdIAiYMe958lPN
	 Tdve2Oe7Mx6lJi75AdAVcJU5cK3qtJWFFK6Ji2VQKy41MatbjhV7wLFfU+U9doaLl1
	 0pCPAauqg+plmY6czC7oEoE40kOuWPzwHuHP4UWqDnUcC9Cod4IoqvJ579KGyYVbAq
	 I+l2zdouktMo+efInjFXFkCQr8qTpP5hM/23gDqV2B4tt9Ih5l8aaXYJH/1yPPRdnA
	 6a1QG2gu4HFxg==
Date: Fri, 14 Aug 2026 14:47:50 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cocci@inria.fr
Subject: Re: [PATCH 00/21] HID: fix racy force feedback initialization via
 .input_configured()
In-Reply-To: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
Message-ID: <56p6654o-p626-s2r8-9429-9785065865rn@xreary.bet>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, Dmitry Torokhov wrote:

> When a HID driver calls hid_hw_start() with the HID_CONNECT_HIDINPUT
> flag (included in HID_CONNECT_DEFAULT), the HID core immediately registers
> the input device with the input subsystem, making it live and accessible to
> userspace.
> 
> Historically, many HID drivers initialized force-feedback capabilities (via
> input_ff_create_memless() or custom workqueues) in their probe() callback
> after calling hid_hw_start(). This introduces a window where userspace can
> open the input node and trigger force-feedback ioctls before the driver has
> finished preparing its private structures or workqueues, leading to potential
> NULL pointer dereferences and race conditions.

Hm, this has probably been the case for ages indeed. Thanks for noticing.

> To eliminate this anti-pattern across the subsystem, this series:
> - Enhances the HID core to automatically handle driver force-feedback
>   initialization during input device registration.
> - Refactors individual HID drivers to perform all force-feedback setup
>   inside the .input_configured() callback, ensuring the input device is
>   fully prepared before it is exposed to userspace.
> - Adds documentation and a Coccinelle script to prevent future regressions.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Now queued in hid.git#for-7.3/core.

Thanks,

-- 
Jiri Kosina
SUSE Labs

