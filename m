Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082129;
	b=zZ3exKUCjIaOtw9oIzgNioGphX7/zKwhUmIWlp0cirUHVdADKn/uC+wNAq/VCCtJXQYy
	 cQdFO1gyS0E3JiWmRPoub+7sZ41PlbuhafnP3tpy/IaVCGwM7xzr0bOWRNojnHZ53KSXK
	 8U3L7BahwxMxTnn1nTy55AhmcyMwFvfMhbejQ07uEyoMsobfTtXVGW9KWdIeHyW6jTEGa
	 phSqaIkh/0p+XfpxNIwCUKDa+c5BtXPWxVBTwktiMl6YOmQ+4Qb1USssP78dGFBdaWszn
	 HJgqhJkIcnQqfSBYU5cY3Bl51A/V3bWtUJChD2Kg91g0Y3UYUMtO2a5cHh/Zt0IuQhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082129;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zYuYV9k/OCUdFVcBP6hgrMsxIeQ2TmANARLgmjBz7hU=;
	b=kfh3Xc0pTM5ZRpddcyJH3W2oop8WItXTD8CxDRS0PYR8Jfgg0+bQfxQ+Rk+R9IFtT4jc
	 EAAj/Rld0hEnqBX9XpZEAM642rEFq+cz1+MoPLFX9PwbCHZe0wCuVLVqrSB2UAzExLaXI
	 jbrqhs/3VtCEA54XhMiWOi1iiRr1V175aPWoLBsosURcZWxiO/UAzm4yPKKJc/dkMlM7q
	 gSQtnN1vHb1l8Zxd4JsG9f6hos5Yv+Lnt4OYH3xfup4dyBqlB/1wh9lUHn5M008Itg7jl
	 4pLTg95BsHuf8jB3F7Tgu3YbKgf+lZHDrSqH+07niWAImvntuxZSwaluGYzZNS4EVNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkbhddL0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC241606A326;
	Sat,  7 Nov 2026 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkbhddL0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D431F0089F;
	Sat,  7 Nov 2026 20:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082128;
	bh=zYuYV9k/OCUdFVcBP6hgrMsxIeQ2TmANARLgmjBz7hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kkbhddL07qM68VUlLnGi3nsedhFKcseD14gCl50f4mk9FmadfXJyHMSNhizvIqifX
	 Iqe6Ox8UjNpZILJ+tFy9OcHPwxOgFTWyIDbbJM5w36QExJqHhqICHxw+KN7sjywD5V
	 SpZvy+h4qcoM8ZcXQgOOJjzuYPhzLoJRMIIp/DVdhzIohkz9vQ4i3N4WEr/j1/9Vhf
	 fVngDQiktg/2OUglvrJoL2JfgmaWZWG3YhMKtfrTZmLHmfKAxPFN8PXh/O2vc8FBqX
	 alFTUFQR+x17mirE0V97/yxyjrQkvkwJnPTgOnimfFGsr/VF6kyfDVX/gtlPsbc+HR
	 gZEfqVQmsh5Qg==
Date: Sat, 7 Nov 2026 20:08:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 simeon@maryasin.name, lixu.zhang@intel.com, crofts@kernel.org
Subject: Re: [PATCH v2 0/7] HID: sensor: custom: use-after-freec after
 remove
Message-ID: <20261107200840.2de08565@jic23-hlaptop>
In-Reply-To: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Nov 2026 12:13:56 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

Trivial but freec in the title.  If we end up having a v3, please
tidy that up.,

> This is v2 for patch " [PATCH] HID: sensor-custom: Synchronize
> misc-device teardown with file lifetime".
>=20
> This patch series is essentially the same version that was sent to
> =D0=A1=D0=B5=D0=BC=D1=91=D0=BD for testing.
>=20
> Following a feedback review conducted with various AI models, it was
> suggested to break each change into individual, separate patches. This
> makes perfect sense, which is why this series now contains more patches.
>=20
> Additionally, these reviews identified issues in the adjacent probe and
> removal code when active sensor instances are present. I have addressed
> those issues in this version as well.
>=20
> Srinivas Pandruvada (7):
>   HID: sensor: hub: Synchronize callback removal with raw events
>   HID: sensor: custom: Set owner for misc device
>   HID: sensor: custom: Disable sensor before hub close on removal
>   HID: sensor: custom: Fix state lifetime during removal
>   HID: sensor: custom: Serialize misc device reads
>   HID: sensor: custom: Register enable attribute after misc device
>   HID: sensor: hub: Remove clients before stopping hardware
>=20
>  drivers/hid/hid-sensor-custom.c | 121 +++++++++++++++++++++++---------
>  drivers/hid/hid-sensor-hub.c    |  27 +++++--
>  2 files changed, 110 insertions(+), 38 deletions(-)
>=20

