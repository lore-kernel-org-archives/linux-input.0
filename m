Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539864;
	b=JVXhr1XzW2YKIY1DehMguyHgDorA2qqtwnwBXEFGXQq7cxXqKnvKw/xlzEihhVVm856L
	 bGGqKA1ZT0hGJQlpwuijOQHZnm8pEUBgRS4hE+CA0rBxotcVfQ9GhhZotbbTIb49ZIOf9
	 keraDJWVon6SuIWk6uhCQN0daal1mhCUoFY+kwtwu3wM3Z5AKVktWmizwn3TzfYD+/02B
	 CfaQyQXwWheOXliLRcUhnd4L28v59LrOFlystQDrbz6xn/bTG0nGAWXTc1lkCiClJt3ey
	 KWm7+o8TiwxZUbNYxL4ilHAzkwzaLUgT4YPv7iAWkwcvDRbV9DTbLvoXKolITFBAzug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539864;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YSLDat176ojzdJPVNxPM4EYVRPhG+FShCalXT567sAU=;
	b=GoB9QLv5HVqcG2GKYIJT5CZ4kmZcDctoliQfDO9B/5S+mXyH/MmQfk2Ls5K4j8gOgp03
	 IQPWgKLMm+HsIN5MopV55HdtwvWVXRjkq5mZvyi9W+TqFGTDsQV/f29vEDN+rFp2Fd6om
	 UgpDZQfv+T/JOdkK46q1bJCGsuxL0venE6ZyuVubO6NXlNI69D8YUlhEZLgJgZFX+wZuK
	 EYpjjtP1Rw3/8l0iYLsfNfQzxvO5iSCJL8iD66PVL71IBx3nBfggegy2XyQ0IXyoWRNLv
	 Wk8W5WanQWdCUZjKc2mz0yfzRGluRBYbft3LpSPYhTQ9JAmyPh/IWuJWpWzpURU7L5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVYJr8B0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFA606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVYJr8B0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20991F000F2;
	Tue, 24 Nov 2026 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539864;
	bh=YSLDat176ojzdJPVNxPM4EYVRPhG+FShCalXT567sAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PVYJr8B0omgpFbGZi30RJlGobuT8LO0knsY6N0WwO3f/DHvdJVFTfSOCjTgJuY82o
	 VFjY7Jr8buvHDhk9z2vLSo0i43glNlDc2T1WfRF9bhbw0GZl47cz4OLAhk3BevatO5
	 Fdv8GUo4ZRh7/uVVEjXyxhMALt4FW3/BUKsLzQnLlZfSEzQWL7E8WAa8+vRFoHp9LH
	 IZ516wfjXm+CqB/bo8/y4Vdip5ljG+dvI+jUIwGyKuyzjq7DXhrSU+TK3htLp5qaP3
	 3BQwxplN53zAn5NQN7VteOmYNsWk5WbyeLo8/Xnq1nbNxYfI8Z3XbgVYjd4FePB4I0
	 7zURZys3oQGig==
Message-ID: <sashiko-outbox-231650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] HID: haptic: Get rid of input_ff_destroy() in
 error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Zhang" <i@rong.moe>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261125-hid-haptic-kmod-v4-1-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
 <20261125-hid-haptic-kmod-v4-1-03713a89f656@rong.moe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 17:04:20 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: haptic: inaccurate Fixes trailer in hid_haptic_init() fix
--

commit e6d3c5552e5a0755862fb250069c54d74d75f7cb
Author: Rong Zhang <i@rong.moe>

> HID: haptic: Get rid of input_ff_destroy() in error paths
>
> It's painful to have error paths after calling input_ff_create(),
> because input_ff_destroy() frees too much things but does not restore
> some other things. For example, every error path calling
> input_ff_destroy() frees ff->private, while the others don't. This
> divergence has caused quite a lot of trouble.
>
> Additionally, the driver's get_device() bail-out path calls module_put()
> right before hid_haptic_destroy() calling it again, causing refcount
> underflow.
>
> Since commit 2ae35f090d02 ("Input: destroy force-feedback device on
> input unregistration"), the HID device is now guaranteed to have a
> longer lifetime than the FF device, making get_device()/put_device()
> unnecessary.
>
> Due to the driver being unable to build as a module since commit
> 083a4f3f3cc7 ("HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC"),
> try_module_get()/module_put() is needless, too.
>
> Remove the said calls, so that there is no error path after
> input_ff_create(), eliminating the call to input_ff_destroy(). In this
> manner, we don't need to restore dev->flush and dev->event either.
>
> Fixes: 083a4f3f3cc7 ("HID: Kconfig: Fix build error from CONFIG_HID_HAPTI=
C")
> Cc: stable@vger.kernel.org
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Link: https://msgid.link/f44447354f28c295e79a025bbcab7a4e@gmail.com
> Signed-off-by: Rong Zhang <i@rong.moe>

[Severity: Low]
083a4f3f3cc7 ("HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC") only
changed CONFIG_HID_HAPTIC from tristate to bool in drivers/hid/Kconfig.
The broken input_free error path and double module_put() in
hid_haptic_init() were introduced in 344ff3584957 ("HID: haptic:
initialize haptic device").

Should the Fixes: tag point to 344ff3584957 ("HID: haptic: initialize
haptic device") instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-hid-haptic=
-kmod-v4-0-03713a89f656@rong.moe?part=3D1
