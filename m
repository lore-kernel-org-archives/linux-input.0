Received: from outbound.st.icloud.com (st-2002c-snip4-11.eps.apple.com [57.103.78.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5493955DB
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611668; cv=none; b=Gcl/CG5jD52kpy+hK+ZChnPebiXmDpT9/S16J4iMfzA5Sm4aAfe7H/hN0ReOdNo5JUDoZwtIY/ZS7iiXco8eF/rN2YeubMEPFdCOa8+y/257zIB84liG/qoE55YFtxIZG0eknsfwzk7mhJc21X55Fdi4ngFCqm5MEG3NfsuM+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611668; c=relaxed/simple;
	bh=eCfmNO68x2HqBtgajhLKojpFZReknXfY/BJoF3G/KVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBoiVHRT1Nzhrf6gxzWBCYtg3ZxguhY1DjkPF1JJsm7NQYMEtrhGMp3cVBLhY80BuFGaRchlx3pkncxE0bMWe2jzG5oTKhLWzltC3oirbMWsdHjYlPhXdHBd5gefSaJhONGmQA4VwT6jlbSfOJMZ9s7uWkLVaJDWnRCc5g+zaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me; spf=pass smtp.mailfrom=matias.me; dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b=Cr8m2sdB; arc=none smtp.client-ip=57.103.78.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matias.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b="Cr8m2sdB"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPS id 4C50018003F4;
	Mon, 24 Aug 2026 22:47:42 +0000 (UTC)
X-ICL-RepId: 01a035f5-475a-7176-84f8-602da927dcd9
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhAAkMDWBxCCE0dXgdLVxQEEFYBWwRyHVgMWgxERV8VGR5XUFoKRhlYCx0AUktAEwROEwVSB11NVg1HD1geXBQXC0dDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXgxDAlMDFxVWTVoCVk0FSgNfAVsKQg1KAVkAWAVeAE8CWQBGA11RHV8BWCtfEU0RUh4ZBldOGQxKHVJWUQVKDFwAaA9dHVgRXQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matias.me; s=sig1; t=1787611665; x=1790203665; bh=D+2ZXtNmJkUI6Ur4TvayRld6RnD66YEwnzSJoDqbNaM=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=Cr8m2sdBf/JHLcO9W0mrYNYsL+HD65E6ZEOc7+KatOWqibfTvXbJpQIVRBwUjLMnKHgA2Qp5GzCm6+AMPPHxEoKT6xZp0xr3HR0Wx5N8dGGguzizXb9/XT95evTEGOSzckFG6+r2ElcL0HBCuH3keCVwvILf/1CIrQ4vHuHV2K0QqVaIC2WbzAMNPsgYqYsQR72n1G/9IsKYcjj9ixr5LtScnQ9Csfm6+shhEgQJWWnRakxay89MOJtygXIXVU7awv2Puh/cudsyx5DSIMUrI12uoueokeps4SC6F+nmjh5F9j39/qot5oIUaTf/sGdWFCj3o2sCRIqOKcqQceXgPg==
mail-alias-created-date: 1705102286191
Received: from localhost.localdomain (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-1 (Postfix) with ESMTPSA id 210C618001F3;
	Mon, 24 Aug 2026 22:47:39 +0000 (UTC)
From: =?UTF-8?q?Mati=CC=81as=20Marti=CC=81nez?= <hello@matias.me>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>
Subject: Re: [PATCH] HID: ayaneo: Add AYANEO 3 detachable controller driver
Date: Mon, 24 Aug 2026 18:47:37 -0400
Message-ID: <20260824224737.97147-1-hello@matias.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAGwozwECcyX6vxJmiBhfO2DfOE6VbkURCArY6gvaqgXJEkA8BQ@mail.gmail.com>
References: <CAGwozwECcyX6vxJmiBhfO2DfOE6VbkURCArY6gvaqgXJEkA8BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ykon6qiFyMYApIz-AT-0HDkWuGlGkicP
X-Authority-Info-Out: v=2.4 cv=cY7fb3DM c=1 sm=1 tr=0 ts=6a8cca0f
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=5SbzXZmFT2pBHATuuVcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ykon6qiFyMYApIz-AT-0HDkWuGlGkicP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE5MyBTYWx0ZWRfX7mMpFDUZfznF
 XCzasbFdxfHdeadrE0I6RLdAiiTE9716qwemLGWYVknUmOmrt/N8ptFj12fZs3MJJL/I9SH+4QY
 Iy2ANnP2p2MRvrpWufP/32VJMzIKaGzLBWDqExuuZyJ+Jd9r+73j+zEEqXoHydMIZe5bJYBLeX3
 vzDen3vonqDqWREaA6qiZEXS/L14hTU0i3gNOWUVznJ8DjMTdVc7S4WEdGB9q4ilX7tAJAs75sF
 otE9pr/cMo0/pg+1uX3x1SQFj8RYEpveuduUAoYweBeCcDLgeF52njFa/SWD3V3TSTHtOnb/0WF
 ICfMmAl0ZKQMEAbetEVH75hLYECMARZWYQXXIR2lUfg4y6QK+/M42W9jFHq61k=
X-JNJ: AAAAAAABJB+dgosi3FW0kQGwU5HcoeDqgoO840ok96XofEbKA7X6umYV9BPDufx6WHL6fSYFoUqWCJ9hUlypkY/q7v6olSAH4s0tK9FVQXEsH9uwQDVs4UiiAURAXI9jHdRXjtPMuOQWBKCTw9r6G6/YwHsWslr5t4HVRUCkaxi8H6QLnkIKWlpMTNZeqlGRE3iaepT7C0X19Phcp1f1CLGiZJqzqaw44GtAF2yprRg5TpWv3tz0t0dI1djO/Jx2lRmmioGWeUybP/thAL08DTMIdVXfPlzHXr1Qybwkjox46lBhJ90p7T6dy1aLqRKbi6chhkQb9+OOkVqsNIAvMgm11Om/SRhcAS02KfwgaRFXrM8HwOHj7NiPhAeVqoaalUKwFTMCkTsPM3gGMxbiJ2835rM4v+agjGMQFs67wx8LUyU8q0lFZ3x7XdrWwDvyx8ABdIRXIakWNhTTsciwLGelOkKZQcZ3LFVnFCboe2e0rkWp7u5yQEpXtd8FHkZCtH0IDYZRJvbqUnuQzQc5Y7jmqTbbIcwBhubSi4yQoEKKAlEhrCq9+S53p+M56w1Hmyfhq6TUxN043MwYzVp1x1vxWzK/60vYuAfZWamoqutbet+SN+xb1H1H+KT72aLdWfOf+0bfEBUQFScqMNdG7TpKa6Xk41PyK7s+Mnzj7cJiaoKiv01eJqtaCQUFBrV8MjFq942dJdi7xH6Hzq4maftIEhp55mCjfnxf9kMYfAHEkn8nATBtN9UanPuZ9+EwFB/ZR1LnMMewXjj8J15SlamMAtKQGWKKtILt3580iZmdftiH0W2Q3prT1pN5lzPm0pD/hjOT/eDCslfJbbZ+O6iQ2mnilRnD/R/kzp93zv37i17j5kABfpZJ5i2P76bnx8gBZZasFVqrXu5pl2/XgRU2ua8t04h6CYX8Z4ULsPeqxviE2OyhFsFVvyk8+/aCV9fZ3ZyhzBNNVATOcZojEUGyGHcCpvY
 vI5z4cdTsjul2fciTlGnSphCZISkFK1tr+a7gUcBhUNOeYOd7e9pSm2Jgd0gLn7HA8qP7Xowi0cRv/s5amGDe06DsvmqIyzW9Bh4ed6fz5aYAmh4v7pgIj5NRmARXYTb/EFWp0sanneYIsdwOgEQ0MQqNbGH5DxXGh3VwdGK72LFW7H5uiIIgRu8rcyDQOIr2NUBlWcRgcH+j7C1x5sc5pFxdcZvK2Ii1xDKuWmR5V4/Q8g/8OYaZDYJkFZGSaPYrI7PFjcuhO4HWK0TSWDAzEPqY5u1VRj9gGz8dU+enDfg7HLiNPfhLmABhnTuhHvb5LY/iXhug0SvjoTj28gNN

> If you need userspace coordination anyway, including the multiple
> timing hacks I had to implement, the question of having to route this
> through the kernel arises.

Fair question. What tipped it for me:

- The RGB wants to be a LED class device to be usable by the existing
  stacks (InputPlumber and friends consume /sys/class/leds, and with
  hw_pattern in v2 the breathing mode fits an accepted ABI). There is
  no hidraw equivalent short of every stack reimplementing the
  checksummed vendor protocol.

- The protocol and timing part (reply matching, retries, the eject
  handshake polling) now lives in one place. What remains in userspace
  is policy: when to cut controller power and what UX to wrap around
  it. That split also lets the module/eject controls be exposed as
  narrowly-scoped sysfs attributes instead of handing out the whole
  vendor interface through hidraw permissions.

- It complements ayaneo-ec, which already exposes attach state and
  controller power on the kernel side, so both halves of the flow sit
  at the same layer.

Working on this also flushed out a teardown bug that v2 fixes: a
brightness write racing a driver unbind could queue LED work that ran
after the transport was gone and the driver data freed. Reproducible
memory corruption under a write loop, and the window is reachable in
normal use, since the controller power-cycles on resume and on module
eject while userspace may be poking the LED.

> Overwriting joystick sensitivity is a bit problematic. Can you see if
> dropping those four bytes still allows RGB to go through? This might
> be preferable.

Confirmed on hardware: with bytes 22/23/37/38 left zero the firmware
still acks the config command, and RGB (solid and breathing) and eject
all work. v2 no longer writes them.

> Consider implementing the pulsing mode it offers, there should be an
> accepted ABI for it somewhere...

Done in v2 through the hw_pattern trigger ABI (pattern_set /
pattern_clear, same two-step shape as the sc27xx breathing pattern):
"0 <t> <brightness> <t>" selects the firmware's fixed-period breathing
at the current colour. Tested on the device, with an ABI document
added.

(v2 crossed your second mail in flight, so two things are still open
there:)

> Almost forgot. Magic value.
[...]
> Magic value. You need to justify those.

Right. Both are empirical firmware timings inherited from the
Handheld Daemon implementation (its reset sequence sleeps 0.5s
between the reset and the config restore, and it polls at a similar
cadence during eject); both are validated on hardware. Queued for v3
as named constants (AYA3_RESET_SETTLE_MS, AYA3_EJECT_POLL_MS/POLLS)
with a comment stating exactly that. I'll hold v3 briefly in case
more comes out of the v2 review.

Thanks for the review!

Matías
