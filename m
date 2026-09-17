Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F02DB79F;
	Thu, 17 Sep 2026 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657573; cv=none; b=IPfHKue/NdvyrHy0lAihpUhpjAbqK2+lqchsSQFqBcSEIMoXsXh6oATGu78yU/veWdd6zbRatuGyjZRAnsGrdscoxt301mCukby84Qr8gOsFzzbGT0b1xLyYKu9GoBZ6D2cXaiWFKzpg72hTve3nXPzA7g4KDSUi6OfCtD9xEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657573; c=relaxed/simple;
	bh=/OfWtIewPY5C/r0HMIf+o2IIttSmiKU4y8rC/hzPssc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iO80uC1r1NnqpHlw964y69eSmHgTdNwxPTlyW+glOz51ZDYdK+9sDxlGZXYR2tMj2C8WrhZ8nr31YVSO6FokOSL7Elw4sH9akx+E1eec/8pXf3VvmrN1DJ9BYFbuZL09CWWkl3pMXsPdpenLhWv4nXaQCBuU6+gZjSZ17NaxspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ngBXbn7/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ngBXbn7/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C4B9BC5CD7A;
	Thu, 17 Sep 2026 15:06:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46CE460649;
	Thu, 17 Sep 2026 15:05:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C35C211C7B08C;
	Thu, 17 Sep 2026 17:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789657549; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/OfWtIewPY5C/r0HMIf+o2IIttSmiKU4y8rC/hzPssc=;
	b=ngBXbn7/ts81Rynz7n5bSN7vmTTpu4edcR52tEjvtmzV0mtJnaTqQaaGTaP6UXbcZcuttd
	OmHSxedWnPBXZuzpLcrjJddURZ4iBxRQxqWuUXqCtPjgw44XdjtUZzeb4ixeueEh/Pjs3x
	/eWz9LcI5bxvgzjpghmVc+XOtR8IQ3BUPB6X/utwtHLYoy1NQVdzrmV/b3RW+jMtn6MkTh
	+P+X9EUacmGoXpVXdFe93bfZwrZ5ww11hjFw5RlJwwEHjnY4K+Lzz34RW8ywCr6zBFQl5u
	wZSqY+rp+UjM2V2g8x9tD4szg7BX2Co1MnCeqc+BhGY2Fm25gVBYVqzQV44emw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Daniel Matyas <matyasdaniel006@gmail.com>
Cc: Lee Jones <lee@kernel.org>,  =?utf-8?Q?Andr=C3=A9?= Draszik
 <andre.draszik@linaro.org>,
  Ulf Hansson <ulfh@kernel.org>,  Liang Yang <liang.yang@amlogic.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Jerome Brunet <jbrunet@baylibre.com>,
  Martin Blumenstingl <martin.blumenstingl@googlemail.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo
 Pieralisi <lpieralisi@kernel.org>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  Manivannan Sadhasivam <mani@kernel.org>,  Ray
 Jui <rjui@broadcom.com>,  Scott Branden <sbranden@broadcom.com>,  Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,  Will
 Deacon <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  Vinod
 Koul <vkoul@kernel.org>,  Thierry Reding <thierry.reding@kernel.org>,
  Jonathan Hunter <jonathanh@nvidia.com>,  Liam Girdwood
 <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,  Jose Abreu
 <joabreu@synopsys.com>,  Ray Jui <ray.jui@broadcom.com>,  Scott Branden
 <scott.branden@broadcom.com>,  Atish Patra <atishp@rivosinc.com>,  Shawn
 Guo <shawn.guo@linaro.org>,  Dmitry Osipenko <digetx@gmail.com>,  Thierry
 Reding <thierry.reding@gmail.com>,  Ibrahim Tilki
 <Ibrahim.Tilki@analog.com>,  Okan Sahin <Okan.Sahin@analog.com>,
  devicetree@vger.kernel.org,  Paul Walmsley <paul.walmsley@sifive.com>,
  Palmer Dabbelt <palmer@sifive.com>,  Conor Dooley <conor@kernel.org>,
  linux-rtc@vger.kernel.org,  Ricard Wanderlof <ricardw@axis.com>,
  patches@opensource.cirrus.com,  Lukas Wunner <lukas@wunner.de>,  Chunfeng
 Yun <chunfeng.yun@mediatek.com>,  Eugen Hristev <ehristev@kernel.org>,
  dri-devel@lists.freedesktop.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-hwmon@vger.kernel.org,
  linux-iio@vger.kernel.org,  linux@analog.com,
  linux-input@vger.kernel.org,  chrome-platform@lists.linux.dev,
  linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com> (Daniel
	Matyas's message of "Thu, 17 Sep 2026 17:40:28 +0300")
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 17 Sep 2026 17:05:33 +0200
Message-ID: <87tsnnj4ua.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 17/09/2026 at 17:40:28 +03, Daniel Matyas <matyasdaniel006@gmail.com> wrote:

> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-strings)
>
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.
>
> Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com> # MTD
