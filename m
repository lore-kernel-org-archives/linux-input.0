Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC432B981;
	Thu,  2 Jul 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005285; cv=none; b=aeZgPsMEr9LBPF48peGUuShJg8jJcWNXIxQoFXnf8xIMP6zW32GkRVXLUj0e+ytexoj0LYykk+D64t8aN7NvJcIu+GcN9qwdnUGVrvi0Nl5FJOboaoWomARHNR0ozy4wrf0j3KRR3L8qAeTejG1v2IWCCL8BxkeOmkofg0ZchpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005285; c=relaxed/simple;
	bh=d2YVhtbaFzSgYBANw71BSYMMHHk4SZ1Y76sHIatqV1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCMZAInsOHZcFmsgTcvCEfXU5RBXYinMbD6aEoUJkDTEFyb3NPLLjYJWBiiaqE9KUdZuMyn+SFIiI7TeSSzn9MfVaJD0bkitECgpnmpoZT0kU6KCJZwf+rmIUAwOVIG5f2B1OVSIwH+rsjt16AR0+GusVlwZn+4pdMG3skRZvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUo7JOYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUo7JOYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A251F000E9;
	Thu,  2 Jul 2026 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005284;
	bh=c3jiJOSpZWo7w985LQh4Y0OVG7Wd0IptXa6TBfu7SkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HUo7JOYaEFRyzC9WdCBlCVlgDUpNNKf60fUSfKcmOEFfPx6Gx/TIWQAqNaTgJ6l95
	 s5d7UbA2rhO7yf1OJWfXmqRbEwUHh1HnVQAz2Y6AReUm2EsqWMUDsXogc1B/cSOmZT
	 b0ZygJ6FBQJf0LlZ+3TSRNuxTcyx0QQj47zR8yUANchvZx5BArgFp3liFOTvhrSvBu
	 mHLHeDFfxw2YKCn16UpvqX4MFOYxEGGYjCoJiYXpUXNT86DCanxssuXq+Ei+I/0B0b
	 Vuo9qq1SewwmZlNtoNtYxp6f91VkU0YZdAqrkBZ32Q7yEYqjzZM7VrbUzHh4AD2Vv6
	 yH01KvWQjWDFg==
Date: Thu, 2 Jul 2026 16:14:36 +0100
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
Message-ID: <20260702151436.GS2108533@google.com>
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

The MFD pieces look fine to me.

I'm assuming this will go in via MFD.

Just let me know when you have all of the remaining Acks.

-- 
Lee Jones
