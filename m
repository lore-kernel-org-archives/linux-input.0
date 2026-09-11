Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4142327C08;
	Fri, 11 Sep 2026 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136230; cv=none; b=LIJAcosFmnT81tBpwC58xUsagGE4wXsSmcJJp2aiadEX3fdGnJIsq+eNqEn4N83L1G66RTjwtjtUXdYxChPtuXjnyFLAMy9dJGJ5eJNizoofy9NbFJtzwuCKJ8EkORWlr4ztyhR3vuevuccb+4MW1fdPuoeCHr4zo4MH6XddLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136230; c=relaxed/simple;
	bh=llOpMKPd6n4XN5ctZFTPec8iEm6JgmQbmQOBLopQ/VM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X9bpx7beNgfcx6PZPUcKdcIuzd5S+F5WtJDIV1aCtNdmR3B0TQw5MVFAuf0hs3Zs4q2odsWQPEOHgdjAHtpnpgX3o+1N5lyhx9JnpYdxLCNfx89mHsTmFczvveRNK/6zZhev8EpqWYODTlNlafQ4cF4Y9OEWMzQYioKXuVUVSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ0Spz65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ0Spz65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC97D1F008A7;
	Fri, 11 Sep 2026 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136229;
	bh=ncC3E9rNdGy+vU1B3THWDfoyW/XiZdbGfBK9ZldJwdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=gJ0Spz65S+I3pzpqRi4IgtTtwsfI1SsU7gKEkxqUUprAeDVCCIPgBUm4RU6PzbuXa
	 8D1+cDM+w5TlXoUe2bFR1JndeMh3nn4T6zdb/KGWQx7XXYL6KVDyJgxd4ghebtk/T5
	 6AdQ4v/MSuSxJ3IImjD/3HpwH2NRBRuYjDiZjgDPR+ifpDlL7fy2PB3+vLc2MsJoyi
	 EBCZF7vVziB4/QYv+MIU3aCMPXnJRPEV+Z1QqxbErpUIbM3dq4Xdf6dZFhFLKtQ0zH
	 TeqfEOAhFXEsB2nKYeHw6/Ldd3B7fsfNuXbPivWQhJbQOWMPpZl7/LYCWIAFeQvjSi
	 hgGvQkh9PazhQ==
Date: Fri, 11 Sep 2026 16:17:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Onier?= <f3nr1l@me.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Ivan Gorinov <linux-kernel@altimeter.info>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: winwing: fix use-after-free in force feedback
 teardown
In-Reply-To: <20260812171359.18135-1-f3nr1l@me.com>
Message-ID: <20p1s353-6233-srr8-30ns-psqron4r17r4@xreary.bet>
References: <20260812171359.18135-1-f3nr1l@me.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Aug 2026, Ren=E9 Onier wrote:

> winwing_init_ff() passes the driver's private data, allocated with
> devm_kzalloc() in winwing_probe(), as the effect context to
> input_ff_create_memless(). The memoryless force-feedback core takes
> ownership of that pointer and frees it with kfree() from
> input_ff_destroy() (ml_ff_destroy()) when the input device is
> destroyed.
>=20
> Freeing a devm-managed allocation with kfree() is an invalid free, and
> the same object is then released again by devres when the HID device is
> torn down, a double free. As the allocation also embeds the LED class
> devices, their timers and work item live on freed memory and the slab
> gets corrupted. This triggers on unbind, rmmod, hot-unplug and on system
> suspend, where the firmware cache walks the now-corrupt devres list.
> KASAN reports:
>=20
>   BUG: KASAN: invalid-free in input_ff_destroy
>   Allocated by task N:
>     winwing_probe
>=20
> Pass NULL as the memless context instead and fetch the driver data from
> the input device in winwing_play_effect(): the HID core already stores
> the hid_device as the input device's drvdata. The force-feedback core
> then owns nothing that it must not free.
>=20
> Fixes: 42d020b54edc ("HID: winwing: Enable rumble effects")
> Signed-off-by: Ren=E9 Onier <f3nr1l@me.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

