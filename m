Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA133FE09;
	Wed,  2 Sep 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363985; cv=none; b=s/wfbzrpK0b7c4ahZq4gBiL31qHHquYnaeUNeGnkGZHyvGV43+8tmCuKxpUvvajj20JOEGV5OPl78jiTsSjVcGeVatTgSckCC99JeYXLCXnHaq8I+fXrBe/bGyrt7lqK9sgd0uVWsidIUyVvyDVQI+jZqzq7CGB0Ax3O493RE+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363985; c=relaxed/simple;
	bh=MQ8xTVp7HshBdUhAkX6oincjrniBJdbslFzdsi95Ulw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PB9bZL3JOe+7bP6VHx2A+bUyv5DKFbLRr4VWeveyG73njyTWNFQRuuyWEdBTTI/ZYAgpThMcMqL1020kF9xdDOydzqM580lT9LEY/C9B9Xdva39O+PXhBqFChEsk3QhmBD63pq+Yz+6oxUpBut++ypLoIleNk/sNF5X7GptrzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBi2W2yz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBi2W2yz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B461F00A3A;
	Wed,  2 Sep 2026 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363983;
	bh=eGitWDIlcZr9zvSU+hzEEYkqYzd83UWvS+OZwK2+CsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lBi2W2yzrvXVJzPMlfdStn4bFVddJWTcU1CGAX/PCOWtbs/dxRiGEBTDLppEkGwPo
	 mnHglfgSQ48apYe+/FiB94hboWLnfvkPiiX6Xc7QGSkTymnWcWLnLUAzxEmFNTDIOP
	 pjlLqEClBZ5lhswXBhsgo/i+TpNQfDPmAZPw9GIzH0rVC8+UfHYjDZ3jrKXEQa3F6O
	 x9F0qcCuSziOz+InMP8gQqtlqVGu3l6EM3wOX3rgh8rnH83UbbiL65FfwkmLh2BIpc
	 OnbJTg/rpBHLBD79ilKfEVw1MO+LrCkJL2zQMfVOJxTd7Rr6wqgljdQSyQ8ZQUKf+N
	 zCEsUuWG292qQ==
Date: Wed, 2 Sep 2026 16:46:16 +0100
From: Lee Jones <lee@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH RESEND v9 0/9] Add support for MT6392 PMIC
Message-ID: <20260902154616.GA2133376@google.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820122242.120039-1-l.scorcia@gmail.com>

On Thu, 20 Aug 2026, Luca Leonardo Scorcia wrote:

> The MediaTek MT6392 PMIC is usually found on devices powered by
> the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.

What Acks are you waiting on?

-- 
Lee Jones
