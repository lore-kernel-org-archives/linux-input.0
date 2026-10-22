Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679259;
	b=3daL3GzURYUrg9N6wSp6cc7rhNW1TEr83NAZXpBcVm2q0gsO1huQwb7JFgR3nNnaliE7
	 pMXR30GW3HE09Ku7k+aF5Y05i6PIUZNC2Gw3ywLiv/tB0PdGDkg3+Cx9e6ykMdcnibYAx
	 j73XQjo3TL5Y6zbjtS7JnwDk0RRLFkU9CpNueVRTXYaN+8vYvXw8gYycVV/sABkSYri1j
	 ZTF247pSvhAVLbDExwicxEfG909nyDmrrDFd4Wwe32HyqHdcrpocuh/v3Ru9yl8g+SKDE
	 QErw/pmCV2W0oj+1t78xs0perWdXXNxm9YRUXBBAjhSO/GyjTLLbt4JpN4wbxGdGUMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679259;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1F+WXwIUgn8Z7PfNJIGCLSTej9s0HQVsqZZkzwyzrbY=;
	b=eHY/nhDr4MvLjIeRhReeiLKF3Tx4qBl0NItPibItt+9R1jcHU8vuORg8++UBBjuKQKnU
	 Kd/M/JDntus2TUhHJMbSDf2c8BkdFZt1vqzZO1KU1pAB7K5w7iyZan9oDBMMNF64DJ2Uy
	 EqIWDbxewuwYRe9jhtWaEmv1WV1TMCaa1Ai5OfqPJOJqFmzWIOcXH7S56Krd60z27kbZG
	 DLwmPRoNNeSDCFFFRQN5SgDB38nxA8WajNkzq6X7V3XpL5fXzJnxUmNBbNYTUZQ1tTAgN
	 nVVc1Mk7kJZ9InCBt/lTvT88M69IKR6jNvX6stYrGsPof/YYrEyooyiRQwas/rleG3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDJMfFsl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C741606A319;
	Thu, 22 Oct 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDJMfFsl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEC11F000C1;
	Thu, 22 Oct 2026 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679258;
	bh=1F+WXwIUgn8Z7PfNJIGCLSTej9s0HQVsqZZkzwyzrbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kDJMfFslI4Qd6ehpqIY0YskwRgML83/hEr+vYNIXCk2WMy77XGUj55irhrLdBL+tQ
	 lgA6SccW7UrUS7i4uFK9PaWGIMzuPPFojvuAOHtEScWdSixJExzvRRUlBYeHoinc4E
	 1qZQyH/GIniUaIQxK2J0FBjQ1U4/0tCpjRv1Fa9kBwD7uV8s17oMT2C6+SxZEF6Uat
	 Hn+NIk3bjJirB7Y2FYpACv6KodQkUlDaRweqgas20Tzf/L1FHtnEogoHVbvwuINwhE
	 s9lvQbor2far9z64u3YO7nU1h1wzNke5q0xTiVVaHK0woRbN/vpPJ2TPxLyPfs6TUE
	 KSC1Y/bbadZBw==
Date: Thu, 22 Oct 2026 09:27:37 -0500
From: Rob Herring <robh@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: input: Add compatibility for Awinic
 AW8695
Message-ID: <20261022142737.GA1207636-robh@kernel.org>
References: <20261022-aw8695_haptic_fp4_driver-v3-0-ac8c14377e82@fairphone.com>
 <20261022-aw8695_haptic_fp4_driver-v3-1-ac8c14377e82@fairphone.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-aw8695_haptic_fp4_driver-v3-1-ac8c14377e82@fairphone.com>

On Thu, Oct 22, 2026 at 11:19:15AM +0200, Griffin Kroah-Hartman wrote:
> Add the AW8695 haptic driver to the binding documentation for the

s/driver/device/

Because bindings define h/w devices, not drivers.

> AW86927 and AW86938, as this binding needs the same properties.
> 
> They are not compatible though, because the chip identification works
> differently compared to the 86927/86938
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
