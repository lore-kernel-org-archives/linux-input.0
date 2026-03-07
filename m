Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9493A4505;
	Sat,  7 Mar 2026 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772895867; cv=none; b=O82BwU5eqzPVgKGenRZGLkrnGswKymP4luK0FlQG37ykznCqY5OMiT7bQ1UJW0cokOT2ePxXKFVas+S1y8Tg6SB6Dh+ozOiT+G+4l+1VxFiNWNx9Q5FBx/aMOfIr40GlifEEOgUHrrOzikI4QlTz/AZhnfrgjmzKGjstDZnFEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772895867; c=relaxed/simple;
	bh=oCfkRjhztakwBoRUIlo4c4xfYh6OciAHaZzWwJwhHWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnzbS3DICCbS4tM24+Kjrcos89akankdFrp8Q1JzGpcYfZirDWHkLdE1M6lTbLzI7WZfNI3HL/iX1HygA4FU5SdVi1s4Uc+dysEwC7xY9qQs9L+aMrL+nl19dwp0bIDGu+zVTiywmMcOGHTl9Teo+yGyjMWkadt67W4VGFCmIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDbxv9Ds; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDbxv9Ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43197C19422;
	Sat,  7 Mar 2026 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772895866;
	bh=oCfkRjhztakwBoRUIlo4c4xfYh6OciAHaZzWwJwhHWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDbxv9DsATZ11dBfMILI/t2am5ClvAF40FJqSfHCikzMfW0aHrXr0VO56g13BnB08
	 7wKm/N7a3WfRNon/eprTWUGK4ZE4zWeMxUmffKWE/Y+lCXdy42IJONdJ7FHjQCp5BX
	 omLNwzvYzlRFnnE/4HRBD6LYPVsTtPDE2uJVKP0C7SxZa4dXyz3XIvM2wlvoUEbAz+
	 TJwJFtqJUCnfM4ZpNz+uMjew7MACArz+joSsuJuVZdBUo6SHD4I5DbvBMGwJ6d8/dy
	 znHksHALaCJBaYHyz75/DpmGBjZJFzypLFBS3YAQI4FPEreldLhBbWtm/bU3PuWa+M
	 WNxQsjcC4eVWQ==
Date: Sat, 7 Mar 2026 16:04:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Val Packett <val@packett.cool>, 
	Gary Bisson <bisson.gary@gmail.com>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/7] Add support for mt6392 PMIC
Message-ID: <20260307-sensible-enigmatic-crab-7680d4@quoll>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>

On Fri, Mar 06, 2026 at 12:03:04PM +0000, Luca Leonardo Scorcia wrote:
> The MediaTek mt6392 PMIC is usually found on devices powered by
> the mt8516/mt8167 SoC, and is yet another mt6397 variant.
> 
> This series is mostly based around patches submitted a couple
> years ago by Fabien Parent and not merged and from Val Packett's
> submission from Jan 2025 that included extra cleanups, fixes, and a
> new dtsi file similar to ones that exist for other PMICs. Some
> comments weren't addressed and the series was ultimately not merged.
> 
> This series only enables three functions: regulators, keys, and RTC.
> 
> I have added a handful of device tree improvements to fix some
> dtbs_check errors and addressed the comments from last year's
> reviews. The series has been tested on Xiaomi Mi Smart Clock x04g.
> 
> v2: Review feedback - replaced explicit compatibles with fallbacks
> 
> Fabien Parent (5):
>   dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
>   dt-bindings: regulator: add support for MT6392

This is incomplete - where is the actual schema for the regulators?

Best regards,
Krzysztof

