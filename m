Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207762F8EBC;
	Tue, 16 Jun 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617163; cv=none; b=cf0w49C+2yAOqvwWe99UZZ9ZIMOwXPm95fY8dP6v9VcQFJr+7g4Qnil67oY9KPplSWj2pNqJ7o/oPjbzw7TU7Nht+QTqccHfx5OpvcGAx+BNuR72nTho2nz8eXcuI205Kpnt6O+zuSo4qPf776YJCIzENp8qFm40nnQnVZZ2NcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617163; c=relaxed/simple;
	bh=nDz4B9L3SDyaBiEtiSjHsqBiHTic1OaPqnG/cQHYh24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqmNtxMxr/x173C5XVoaIrOPEGf1SPWR+twl0KAI5x0Yq+y8eIZ1soQL0lr2AZdSFVzZLPgkvIOwgcz18sMUk16aP4AZaHtQjZi1XNPxj55Nl8XLllxTs6/RUpCK9j8DA+qqSewsRnwJNmH4pfjJKrwbdBJZAGunwMC+cokD6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVV1whSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVV1whSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F1E1F000E9;
	Tue, 16 Jun 2026 13:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781617161;
	bh=I1IUW0YuXoQNF3mkk4e2D/l4Tl4n61zrxX8gulenhgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XVV1whSQWB41WuVV1r4v3yYfSlR3mLMRp55Cntega8SxOjPogc0mfXP8WT+uhaSJW
	 JgCbQud8QVViPyJM3lGeIUU6b82GiuTGTzcoAmAacoo7rIgx0JPvUZFtEml/CpqtN3
	 GDzWakcjqblyxEXbrRmCuU7IsJrdoP2LBmUMawy1hmOGk4t3c2dYOoAlXqxLRKbqyy
	 2+4dFRnTFIveE6FMeVdpY+8W3kkHhtgZ1/5/Myy8nh4U0GRbtPuozs5iqmIaQlSvbO
	 6tYm4XgttPiE+yDwx/dTSL7MgsX3vQMCtp+2qOcKdL+I2WpaErWkhn0N1ROZeI7qEK
	 ESYhQD8eAGkhw==
Date: Tue, 16 Jun 2026 08:39:18 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Val Packett <val@packett.cool>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC
 dtsi
Message-ID: <20260616133918.GA2335264-robh@kernel.org>
References: <20260615071836.362883-1-l.scorcia@gmail.com>
 <20260615071836.362883-10-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615071836.362883-10-l.scorcia@gmail.com>

On Mon, Jun 15, 2026 at 09:16:15AM +0200, Luca Leonardo Scorcia wrote:
> From: Val Packett <val@packett.cool>
> 
> Add the dts to be included by all boards using the MT6392 PMIC,
> providing support for regulator, keys, pinctrl and RTC.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6392.dtsi | 75 ++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

Nothing is using this so it is a dead file that doesn't get tested.

Rob
