Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613766;
	b=p0VXW7i/e48bv8EoILB2dAj9kf1O9AcGAzaUkmOj2fGyJU6VzA26FbJuHLf3OrVC1pvV
	 OEJEPO0Bv8OYTamnEjQK6Hb26PgnuLo1xHUXgR21Uwkx+0YvJDPdDFrDNZ5vVsq8czDxS
	 +JM6sbxOSTzIL+VjpwmBbAxc6CrnRADv6isase2e1125vU1TT49LsIWNxXzl/+N3r4seB
	 msvGOIzyk8Csv01cwkjPA7FA+p/sK+gT07YGtIL1ZIxiWhZDeVgnHDCp5F2AykCH43wRr
	 q5ZnIvuD3Spc0eqxAlaTKRuE9ADMUGn5GIxbaElSITM1he2QCSdOZsWqBUhjygy+Hig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613766;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=jMC7lBuD8CSwX6fWkX03dnfYB3y+9oak/mBhvnHkgoU=;
	b=rnFveClr0DkIrPsjJKHHoTTz01awMuaYi2xIrP84JxU9Y6ILSUEVjDLO5EFfYJc33csA
	 8A7FlyXrb7auch8H4foTHQk7KlLvOxa2vr+Xz2DaEg6KJdC7tONp8oZfgF5/18CI+HfWE
	 FWcdG5cgBToZs+MM9I7AF8wcgvS6uod1hec9BVBNloIwqbdfhi+p6I7npbzkmpRNW9Uv5
	 fHuYhkbAcKbpscr8+SbdSCGYgZMRiesKTEB3IB6hpjY1C6yRJ8lokK9NOnd9x3Polszkw
	 Y7IvBDKKPvS5MiwWdmqNJEg/zRwhPhg+KIVCe1vwSxKKlfA/DSdQsKMSEVfnmcATCqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzN+ig7m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD151606A327;
	Wed, 25 Nov 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzN+ig7m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694D41F000C0;
	Wed, 25 Nov 2026 13:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613766;
	bh=jMC7lBuD8CSwX6fWkX03dnfYB3y+9oak/mBhvnHkgoU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=hzN+ig7mvo+/VqHGVoRFloQ0vD1qfxCATkApPJTx017ngYNPhW8l1HgcR7hTARQIw
	 trCMh6683hZva8ecnjW8wqT9+UTXbh5brfidvajxhxKvqNDetXc/AHf+xOj2JxxHA2
	 VuTid6crpz2Fus4vSpmzZ3SELLkSy4znqalsAV0JnQkBAJg0x5YEvYzc0+mXHjHF1N
	 DX+wEGP3nUJidkEDeFS19THRGDbRvkvLCHgQ4/SWti3XCjV3OFD7Tl/he1LRWVCIop
	 5iP5YovAhCLGaDiZlmKjlbgb1d2y7oT2JBMElrzVTd9vkJD2ucnFLoNn2ADZlsz1Ig
	 g+wP9Tfvmk2UQ==
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] dt-bindings: input: touchscreen: hynitron,cst816x:
 Add supply
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oleh Kuzhylnyi <kuzhylol@gmail.com>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20261122093405.70406-3-gerard@teslabs.com>
References: <20261122093405.70406-1-gerard@teslabs.com>
 <20261122093405.70406-3-gerard@teslabs.com>
Date: Wed, 25 Nov 2026 14:36:02 +0100
Message-Id: <179561376276.84329.17283482689187377686.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-22 10:34 +0100, Gerard Marull-Paretas wrote:
> The controllers run from a single 2.8 V to 3.6 V supply. Boards may
> switch it, for example along with the display panel the touchscreen is
> laminated to, so document it.
> 
> Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
