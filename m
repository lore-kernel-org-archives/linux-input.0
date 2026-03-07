Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F37342528;
	Sat,  7 Mar 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772895802; cv=none; b=TzBe5GB4eWycxbdUXvPoNCYZ6wKbmlP2ghpLpBjoa4GfdR4ZTr66Zy479PxA6dy0yl/51+liLp8tikvF2von+NADYvMKFewK+NyPqt4kxdRFBOBmGSKqXIxcPfxekTo6PwUw/jCCkgcuTBB3LTN36yGQsBbqO3Zgqyd/aMc+L0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772895802; c=relaxed/simple;
	bh=o64ZE1f3g+BnlE5R+s6CnrQ3G4jfhxqxgh+suF1/YdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPdRyKKK+nzQ9wbz33jl9QulUWvkDduNEgGB0qVMSJn2mlRgU0ZopKbpk14wRIVu9jB+kgSonbPLnv+ugrkWii0B+8xflNYa0K/Svbl172G06sm2E0kb0azzEyUEl9UtR9PyGmB+ykIzwSO0eGXG0GkmCnWKlPGQQ1suKlbBbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoQ/qCK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoQ/qCK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E006C19422;
	Sat,  7 Mar 2026 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772895801;
	bh=o64ZE1f3g+BnlE5R+s6CnrQ3G4jfhxqxgh+suF1/YdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoQ/qCK7pIefywFqN6Ir54AlsgukbbK6qLqq5tpz2OHPhnw0E6dWsZtgMOox0iccz
	 LLT8et5uTFK0yO5WIjUirUYPMUrMjD9cGKvMlJUbzVSBF43gRHxa4IVZYlpvR0VDiK
	 jTOXDusGwJ7LlSQZ6k7beLgk9ftpOVSgN9f3dK73q1dcnSOj+fGDyn9Es/stIMjtLK
	 CujWV9NWkhC5IFsQ2UKZisWhVpKwrCSF+CnqT29oMkgkBBF1y4032p2OLUq/c1qdaB
	 5RyhU+Sf07nJV1EfTTk3pnjtp2YFJW03kSd9kWsu2Gp8uqi/AIXPNtlGYrU472ZHId
	 6VpatgeOEYUlQ==
Date: Sat, 7 Mar 2026 16:03:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Gary Bisson <bisson.gary@gmail.com>, 
	Julien Massot <julien.massot@collabora.com>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] dt-bindings: regulator: add support for MT6392
Message-ID: <20260307-wandering-granite-petrel-719b7c@quoll>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
 <20260306120521.163654-3-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306120521.163654-3-l.scorcia@gmail.com>

On Fri, Mar 06, 2026 at 12:03:06PM +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add binding documentation of the regulator for MT6392 SoCs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
>  1 file changed, 1 insertion(+)

That's a mfd patch, so should be squashed to the patch changing mfd.
Alone is incomplete thus not really correct.

Best regards,
Krzysztof

