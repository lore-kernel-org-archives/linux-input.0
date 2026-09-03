Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320042589D;
	Thu,  3 Sep 2026 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423894; cv=none; b=XYu8CJRRDs1k3IDwxxJZF6+mqxvxZb2opcpQn9r7yOPH45vpsojyeDWIBMlG8oJtY3S3lKkKYYQBPUPY0brrQpuXEon5M5Zdulwe6DF+G1Af/7gyAnUADrbwgqY8hma8Re4O+8pzCO6D63t7JD+LPCx+yHx+jv+7WTw+j4to9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423894; c=relaxed/simple;
	bh=bAmuj0O7v/xqEPt/dezy6Thdr4Kyk/d8UQ+n7ukuJBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewFbQX752SsXMyRvzir8+rBvh5hh203BnUTvYY6v3yBo+eGr7J0FZ+8fnDexLmosQio+C4Q0s7/ycM1wKZ1S/UXms6FNk36040pcKmlna9uQxNq4qCXIB0KEyTgsj9myLUFh7ADH0tJikWSALn9l1NmdRWktD0ikW9OyIAONrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zla5GHHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zla5GHHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349611F000E9;
	Thu,  3 Sep 2026 08:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423893;
	bh=fbIaSZueJ9L7aZ2SFykAsrRHq34CEJ8hDtg94f4lxLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zla5GHHcxSaHYLPcV7hDLgmsoz99LeWBz4LNzJGRDna/m4IQQN+EEDM1op7tVD2Lm
	 OkYqsNGRl2ZFvclRMCzqO2geS3EHyWwFGN9eiVXLz7ibSjlrS3aG2y8AdsdVklpXql
	 TTCs5EEVlAsYYTAW8jVLHvBJhfWPjsZlmwcw6noz/kePfzDRDtqWJLnQpu7WHT3HCw
	 Z6S/3xlKd/iXYSekmNL+Mw3yDWCk4PYvN4YpDsoV4YwO15Enzpz5iRIl1yxaX6NG7i
	 tFu1e6SBmaaR/dgf0DovIlUEEj4uwNpL3AD7HhyPHNg5GqLnxEXVSNkuw66CgjO+5H
	 EgwDen6DuDT7A==
Date: Thu, 3 Sep 2026 10:24:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Julien Massot <julien.massot@collabora.com>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Message-ID: <20260903-normal-electronic-bonobo-3f71eb@quoll>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902193351.185771-2-l.scorcia@gmail.com>

On Wed, Sep 02, 2026 at 09:25:37PM +0200, Luca Leonardo Scorcia wrote:
> Describe the MT6392 PMIC and its RTC and regulator devices. This device
> is mostly based on MT6323 with some similarities to MT6397 and is usually
> found on boards using the MT8516/MT8167 SoC.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
> Previous version of this patch had the PMIC device declared with a
> fallback compatible to "mediatek,mt6323". Sashiko pointed out in [1]
> that it would have been wrong as the fallback device is not really
> compatible with the new PMIC.
> 
> Since the change is significant I have not included the Reviewed-by tag
> that Krzysztof Kozlowski kindly provided in v9 of this patch, I hope
> this is the right thing. I really want to get the bindings right as they
> are harder to fix in later commits if the need arises.
> 
> [1] https://sashiko.dev/#/message/20260820125850.3B34D1F000E9%40smtp.kernel.org
> 
>  .../bindings/mfd/mediatek,mt6397.yaml         | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

