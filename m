Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718585;
	b=gremXeleSSiBV6FucVfwiD1VDtkPLYvIuuoCCBKZ8jA9c6zjXib333BAbT/MG4fpIsU1
	 QxL3ZSNhKvBdNHlFcEEgvmSdTgYMW/aWpF29gYXW85BY6j04xC12lTnlY5/5aSvLkl+Mq
	 QxYZTstkstmbbD3H7TGpa0ZQ3wW6cx/qTc07QLS+Z9LGTW/wJaUUn5mIME65AKUyzshmI
	 ILTS3weeAQ5UFOB+PXgWWqoOUwDEdjD+74scxAigK4f29SaYlE8lq2acFXMYFKZhBkBX8
	 XlW9S5SN50FjTZXDdD9Ts6XM/L2Qnjt6sgGr3WDxqhFJFkVV5grZFpaxQzn64PHDxbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718585;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UDbbd2s1kje1R8JXsCA8wjTjZn+i3rEJu4K17fxuP2M=;
	b=G7tNcmcXqiJIrLt9zLoGvp7UppYWdS0xI+xcrvyvarjuaMJp2/RSPW1IssK9gnrTNRhw
	 1s5S7SjpVyodZdoHD0hrsnWpqOcyBrcV5PurMc6n7RId0oxW6+n1CS53s7/DRB61kZ3Qo
	 pZJcluJbAJImfaBokjeNdENoPpdOj14Y9qqcsvrAEKHNOlkPRzhfUOhtBAPOnKfNMWNDB
	 Nne2wdFYAiIxB4omNoBkxTjbwrgel3dN6Egck+uEUg7ioFrJLPDaRmjOp8qpJdNBoNXSJ
	 SuTo4/iD6s4j/tJXZhrfzsr2xRJMlXj0XYVBlQwPkVhMBhWdXiqq4S9dhmUs6VByoPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbqzLtDf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA0606B255;
	Tue,  3 Nov 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbqzLtDf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D291F000C1;
	Tue,  3 Nov 2026 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718584;
	bh=UDbbd2s1kje1R8JXsCA8wjTjZn+i3rEJu4K17fxuP2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RbqzLtDfuoS+yk3Cb9NL+IELKSZJt5jyCcuWm3dyPp2z77xlQoGsnAiFaicmfoOrF
	 3tgpEeKBcAqoNvTQovNT6CrpXBmMMM2iV8B9lFhp3KZNOIJhrSy8Bd0rotbMBLv3LC
	 +KnLNaHF5xU7Gm9oRwo9GghzU3Kwp2hul1uCUPrmsDDGuE9oDVNcjOetBn13FDuJSP
	 VuZNdd720uPcLjizBpMDdLoO83Aq6TNCWalB9VWUfyu1zT+rbRsjpq30wJ2kYu1LRe
	 7yvTOetvukkh2IlBcVrCOBnLjRttzzCYUyPXbkYfYGI+AW7om0VeLAPMy1OEm86zWQ
	 Z84ArQ3Wl9KRg==
Date: Tue, 3 Nov 2026 15:09:36 +0000
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
	Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v11 0/9] Add support for MT6392 PMIC
Message-ID: <20261103150936.GB792264@google.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
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
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>

On Wed, 21 Oct 2026, Luca Leonardo Scorcia wrote:

> The MediaTek MT6392 PMIC is usually found on devices powered by
> the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.

How many more Acks do you need now?

-- 
Lee Jones
