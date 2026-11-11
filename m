Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398829;
	b=3wQn1FaJaA0Ll6tcmWZgOlIGRdP7xaMZBcdj40yTuxccvA1wkKQXrV9mx2naSlfeAGM9
	 82moyKA1NWQ42ViqDNj2/CYSdTIp9Kx23RjluYwKT/7HLipu19SbxeInFu3U89Go6JCA0
	 8rycY780WeIJDAjLRX6lzhTLgW821bYJKMHYnIABpRPO1W5SxqEZAdisbxvkZtbyfXyOH
	 CnpWrbz78FRR441Exm1R6fTX6HA06uK38puHjGRTTdKGj5zQxcPKF05xNAKKFPOkFabF3
	 QWh8RoPQ3f/LOysKdtlzSvDSfNbv9kmI9rH3WVcJhiYWS25cnkEmvVX/G2trSGktDYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398829;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5fUNPrhOKvJLMYas2fRW7JSnSgbzO0rAbfRdjqJkRIg=;
	b=DQjmIXnNTfSJM6O/20v+wKJyCKrG4N4JfTUyyqCLeq1UM1o8HwiPfqsg4i0ZN+s4VKH1
	 GoN90eo83aOtpl10orX4vzYh462V8zzB+xLzyGbfjos3CIFd49D8Y6reW+obUMvyB0ZTg
	 JIU+kJ89ZKawV89/zwRafQbt/6zjCiLOQMH0vRnZo4baqrm8tI/eDHsvq2VIM/g4A3Uxq
	 AmEG52OCqrGWnX/Z5hGPOb/53jXS0PrTTG3eaXrgqFrOokzxbhQZGftO474bnC7SwOnIm
	 WoC+Fl/Qa4eCIIoi0nqkjDTJqaarxNEFLHAL03HsbUV6vT3yhf/AnjGhlsqtws/QXgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzjYbcow;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23447606A321;
	Wed, 11 Nov 2026 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzjYbcow
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48751F00A06;
	Wed, 11 Nov 2026 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794398828;
	bh=5fUNPrhOKvJLMYas2fRW7JSnSgbzO0rAbfRdjqJkRIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YzjYbcowNnBxk4Pnp+DdrgXvzLjtsn6j+DUYyM9C5J1uy0DCtPcgOzTYtdCP4qyP0
	 Cm+0h8p/iF3r4inmBkczdy/y6/WzLlScbYaWurBkx/FUS9fYMRZ3YFRLA8zQ1M+fGD
	 vqZhCY1OvRmPUV+9+/DD25aF33GYfWyJyYMLnrt2AH9OjRBKqAxacqorwCrvHfjSrT
	 iZ/JmMGp7Miphz9cbR/PYdmyJweY2m1PW7J0rVwcScdFvi/kTP/6pXMZvOTEE/4bcZ
	 gR2L07BZLp4xU9HMHi4LYrfLcPhSocMm7FHw7PeppX7HtCcqKQjp5PKuK+duMR9BMV
	 yui17QjDUPz+Q==
Date: Wed, 11 Nov 2026 13:07:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, jic23@kernel.org, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, mfd@lists.linux.dev, 
	linux-iio@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Message-ID: <20261111-noisy-antique-potoo-2b2dc0@quoll>
References: <20261110141934.42490-1-festevam@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261110141934.42490-1-festevam@gmail.com>

On Tue, Nov 10, 2026 at 11:19:33AM -0300, Fabio Estevam wrote:
> The interrupt descriptions added during the conversion to YAML do not
> match the ICOLL source numbers used by the existing DTS files.
> 
> For i.MX23, Table 5-1 of the reference manual maps source 36 to touch
> detection and sources 37 through 44 to channels 0 through 7. imx23.dtsi
> lists these sources in that order.
> 
> For i.MX28, Table 5-1 maps source 10 to touch detection, sources 14 and
> 15 to the threshold interrupts, sources 16 through 23 to channels 0
> through 7, and sources 24 and 25 to buttons 0 and 1. imx28.dtsi also
> lists these sources in that order.
> 
> Reorder the schema descriptions to match the hardware documentation and
> the existing DT ABI.
> 
> Fixes: 009528b5aa13 ("dt-bindings: mfd: convert mxs-lradc bindings to json-schema")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

