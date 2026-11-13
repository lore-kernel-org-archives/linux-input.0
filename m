Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592254;
	b=HZuxJu7eyVvxuVouGOxGIbJgbHjALTkNTzKnMDyAe1f0IM5FZgRZU7oO2ngv7ZZ+7Pdr
	 +9qhBNjLeCM20e7XUDniTz7CqPNwQ53eRVvMzCsHB/7BqwJz9aJ85+rAh53BoUA3fR+bP
	 FaNdVAlSJYTJeQpQtdseNEMpiN9tRHD4MzZk5BiCAugVRuaHYWSEPoHl8FD/WRu2AZjpf
	 VbhV49LwfBINvOTFCjC0Zd43nZGhsXvGP+hlUI4/w//BoFSauKFkhZHC6VMuMfQUCI4e0
	 cdp8+Ug+0S+TG/OfkSUzsxsrXVN9cqoJnPlR4fCPMMCnxAyyUZPoeBRyTZ/+gYfS0/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592254;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=6h0Dqd6RFqs20ugxkWa0E6efevDQATF3OOGQG5vDX9E=;
	b=Xs2d/cZ9iC4BqzTEPCzennzrYJP78/oyURxJMOFm/HS5fcQ9bwWZofoXqrt2/2Ba9j3e
	 P4ZoZZuB4HnLx1uNiHZhMshCI/cFAyhQl7qoqMNaV2bAnUWHBDNBU/ysfEHOTG5IhIPXs
	 v4oJzTF1j6sDXEoufImIQUNnIgtVdr95FRVFX9FrCcdKxDRKeXgKRaet6CqjwVL7rKeV6
	 oZ/TvCmv65UviVIZeviEkn8K9lgeZNSbqQ3H3IEVOoJXeqTo/na2QZqY5C6f/0Qg+isu/
	 Bze8wOlliITfeK0JrBHFntZe+fWhA3NXqqkiBa9pPmGSCAaf6iL7heXfj4kjR3elcuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ibjhmY4D;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C0606D489
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 17:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 709C0606D489
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ibjhmY4D
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E9B734E415AD;
	Fri, 13 Nov 2026 17:50:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A0D2F601F0;
	Fri, 13 Nov 2026 17:50:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 561B311BC12A2;
	Fri, 13 Nov 2026 18:50:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794592247; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6h0Dqd6RFqs20ugxkWa0E6efevDQATF3OOGQG5vDX9E=;
	b=ibjhmY4Dn2tURhTrqtGtPu8gNw82Ui+RZy0Yt98PWN259aeg897IKBTUcITcGEvrW7wwn9
	1fO5y4X0k0HqrmMMa7u8a+UJW3xl/JHWBIDW+LCgxMI0cJZAql0PuT6zK/Gomq/FdAYNn5
	TqfhDwBA0EOu8JNSaFNINtgAg5raHVqeI/2l2LFC5EXi4oKCdfH4gEIIrIFYX/MT2B0uqt
	wVVViFZh9M9znX2iKYCwGBQpRHbIbaIqJ/KJeVY9uA1Prk5Q8pvPAlqauPat1U1/4OisOZ
	m4otyYcG125i7g5fWqP0e0N9DpGR7D4GUwQ0a5+qoo+oJBNQZ2g5lngk3Djtrw==
Message-ID: <5a68f043-7c9a-44ef-b297-2821886bdcfe@bootlin.com>
Date: Fri, 13 Nov 2026 18:50:22 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/27] mfd: Assorted resource lifetime, teardown, and
 error-handling fixes
To: Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andi Shyti <andi.shyti@kernel.org>,
 Andreas Kemnade <andreas@kemnade.info>, Andy Shevchenko <andy@kernel.org>,
 AnilKumar Ch <anilkumar@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Binbin Zhou <zhoubinbin@loongson.cn>, Brent Casavant <bcasavan@sgi.com>,
 Chong Qiao <qiaochong@loongson.cn>, Corey Minyard <corey@minyard.net>,
 David Lechner <dlechner@baylibre.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>,
 Gyungoh Yoo <jack.yoo@maxim-ic.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Joshua Kinard <linux@kumba.dev>,
 Kai Svahn <kai.svahn@nokia.com>, Kevin Hilman <khilman@baylibre.com>,
 Kumar Sanghvi <kumar.sanghvi@stericsson.com>,
 Linus Walleij <linusw@kernel.org>, linux-crypto@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
 Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
 Mattias Wallin <mattias.wallin@stericsson.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, mfd@lists.linux.dev,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Milo Kim <woogyom.kim@gmail.com>, Ming Yu <tmyu0@nuvoton.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Pantelis Antoniou <panto@antoniou-consulting.com>, Pat Gefre <pfg@sgi.com>,
 Paul Burton <paulburton@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Qunqin Zhao <zhaoqunqin@loongson.cn>,
 Rabin Vincent <rabin.vincent@stericsson.com>, Rachna Patil <rachna@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shi Hao <i.shihao.999@gmail.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Stanislaw Skowronek <skylark@unaligned.org>,
 Stephen Warren <swarren@nvidia.com>, Sundar Iyer
 <sundar.iyer@stericsson.com>, syed khasim <x0khasim@ti.com>,
 Thomas Bogendoerfer <tbogendoerfer@suse.de>, Tony Lindgren
 <tony@atomide.com>, Yinggang Gu <guyinggang@loongson.cn>
References: <20261027093306.2812695-1-lee@kernel.org>
 <179458365250.76424.12505088783548230611.b4-ty@b4>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <179458365250.76424.12505088783548230611.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lee,

On 11/13/26 4:27 PM, Lee Jones wrote:
> [26/27] i2c: cgbc: Propagate hardware errors when polling read status
>         (no commit info)

I noticed you did not applied this patch. It conflicts with my ongoing
series "Congatec Board Controller: Add storage devices support". For the
V5 I rebased it on top of Krzysztof's series that you applied and this
series.

I don't know what is your plan for this patch. Will you apply it? Should
I pick it into my series, or should we have to deal with I2C tree?
Please let me know.

Best Regards,
Thomas
