Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474A598BFC;
	Thu, 17 Sep 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655709; cv=none; b=hvackuupe82cquFgTGtqcPL2rQ096o3wGupL6a+/1/SEf9Tcon0mycv6zxtjJQRtx9kgC4qETHdbcH/+pbulpyZwnvMA/CFvdj4cz/Jk8Z1MpzDO90ClzzuCJpmAhbpg5Rn2lACj361+jb+x0FcpSx5P8+BVPU3oD992DO3cDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655709; c=relaxed/simple;
	bh=oHEcxGPbqlL9hjLXSrtzoTPL0z3gJsKKK1sUG5fXUO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKGG4qs1Uy+8fFcTdOdGh+s/ZFWR7J4Eq0lHHgAIvPnBaf/bdNMtV4+INLoICC+KEKkxBfKEfJlVaK60JrhaB/tEMcoL1NTk0nN7ZcoTWVeDynU1Korr4Q1uLINpoc5fwnZrMwl83RQm7RKE+Tv014HIzOhQKal29j+kwB2WQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jydHxNrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jydHxNrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D04C1F000FF;
	Thu, 17 Sep 2026 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655706;
	bh=r3xzcniINwmNhao4JPYypMLpsM0T7MDf9VsyZorh4es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jydHxNrkXXLvYhfsxnObq8GaWczu17QwuQeJjv+FWdQkLqAIYmuS2NHFVguaojqd5
	 qk/jR88SXU5WWmiyRsysJ5jWw/Wq1LO8QkEdkPtIGQ1RPg9cijBisas80vrcNd7g23
	 4rDqgp9OIwknkVUaSh2UqqBKlc35MSEStS3aeTF4/6YttMACiMcdPDMWLisD1XZvCS
	 U4rc9Y9dWLuJ/i4Jzr6ryqWJ140A7ZxeS87Hj4U0WYl8bHNWvWLYVBEr3KKI/NoXEa
	 z1uNScJ/UGQYsJV58lwGXKUJgvf8228J51OXdfx1PJ4/eU9ygskNlltplmYbGVhMlD
	 uLBv272kmbNzQ==
Date: Thu, 17 Sep 2026 15:34:59 +0100
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
	Julien Massot <julien.massot@collabora.com>,
	Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v10 0/9] Add support for MT6392 PMIC
Message-ID: <20260917143459.GA2348773@google.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902193351.185771-1-l.scorcia@gmail.com>

On Wed, 02 Sep 2026, Luca Leonardo Scorcia wrote:

> The MediaTek MT6392 PMIC is usually found on devices powered by
> the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.

Still waiting on Acks by the looks of things?

-- 
Lee Jones
