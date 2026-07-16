Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B83B0AF5;
	Thu, 16 Jul 2026 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217354; cv=none; b=P8gtVsedSb2Wr68pm++GqtPKGYKWx4cduiUj+mpCIvZ4siWXVlOtBJdik0OAxX00oCB3ooA9QPa0LBQNitLb9mNcaUq5pHZUbh26S76dlNnpEc/lkdLWKlbhsX8j2wPmi+6enW0LQ/1bw6br9Fbid3Tw709C8vwIJ3mW7NjK0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217354; c=relaxed/simple;
	bh=1XS6FW50nNnjSSD71iJMDs+rvseHAxRAmfl3d2AJ0sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+SSaYkPsUkNBiBI0bzWGf7GkKiV7l7oCJOQfOJw/PrZPKjWc9v8p87GsSCiEPi4u3w5sB8D0pjniLEAt3Cjq3kk/KflXuPk4P3WlOR+oqHECf3E2RPrQP8wigMgT4QBtuGc1xXIoH3rWCXwlsxI1LF1f29ghd72TMMYh4saGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbJzWwhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbJzWwhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC00F1F000E9;
	Thu, 16 Jul 2026 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784217351;
	bh=XmkTh4nBmywdMj4d+gE3vGiM5cD808vx/icZxJquXbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZbJzWwhOKOayzVY7tzhzQQPJYEyygebk0aTEk99PP+vWsbOzTefHWNjLtbuyeY4bR
	 x4NRKtoUS9LREkHYM6KV9+GBQw3o7z5nZV8twpSWGR8DXZTrVPZueEaykP6esZKGi1
	 AvntLNZu67J5sw+N27AcHwBr9t6ZILZfBaVrUK+4rwqjjGPSVJpGZacxtWiYbtW455
	 YO7MbJWZTICm3YeaHI/jWYDXA1QnY88MkeBlpLcP9z61uBwdi7bR3tkM57itruOApx
	 rFo7wmnoeAYc2ACC+lRPZO4W8GdOpeF0C2zOYyBMB/7j6vvDmuiLYPWQfyh7l9T/iz
	 agJhbnEElJ9Lg==
Date: Thu, 16 Jul 2026 16:55:44 +0100
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v9 0/9] Add support for MT6392 PMIC
Message-ID: <20260716155544.GD1424265@google.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621081634.467858-1-l.scorcia@gmail.com>

On Sun, 21 Jun 2026, Luca Leonardo Scorcia wrote:

> The MediaTek MT6392 PMIC is usually found on devices powered by
> the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.
> 
> This series is mostly based around patches submitted a couple
> years ago by Fabien Parent and not merged and from Val Packett's
> submission from Jan 2025 that included extra cleanups, fixes, and a
> new dtsi file similar to ones that exist for other PMICs. Some
> comments weren't addressed and the series was ultimately not merged.

The MFD pieces look fine.

Let me know when you have the rest of the Acks and I'll merge the set.

-- 
Lee Jones
