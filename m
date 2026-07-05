Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AA2288B8;
	Sun,  5 Jul 2026 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783213692; cv=none; b=BYEgfV6F9Kq1hjmWKdaW234gDnWqhjhECztYcW/bxlMHSWLhhPN3BWtWpe3iE8DOl0ypWOauf9zyrEOG4IzBWLm0gLZ5x0g091G2Da70ahe2sqjkNpMXt3E3iRBh2bl1egSpprPHd8uTYdH2N6eCmcrR0VcFte32Qj66wLH2N+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783213692; c=relaxed/simple;
	bh=awuH/XulbEDqs59Vh0utt3MvxPA6suHkTxBELRtA09I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tF4uzpFTD985dSIxGFi5YmZ8XEGIf4E8jPtpsQ4opIR5ZlIrfzltVVUfuzrtSfMaaDKP+ScrpF0gYs8Pw2pNVRTCpyrVKmwdc+HvCT+uiJ+cl4gELQjhj3pD+Q2UyzjiXWoBd/bG8hfeJ4Ebc39IVUF0P+kxYI8zwuJLidr41mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBkPSMZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBkPSMZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2BF1F000E9;
	Sun,  5 Jul 2026 01:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783213690;
	bh=3duzwyHdi6RgshCaFz1ynAPla1JdMO1NFXgABI7Eh3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RBkPSMZz/BRsU6kDJgLsvltCHl/7nmfEQhY9exVykMN2oKxRiBkjx0bffH+fLPUYH
	 2ck3iltRsWHYzSENjgVtJrOJreGEUuUNSVj3Lw6/17RResfLk3hMjVq8SFBY9BhwDf
	 sKGEtqWnoWO1tu5pP6nXAc6xmwVh8UNIja+d2sdcRPZaulrROXaGk/79+rxatMNbsr
	 c2v95I5UOD7pAE9DXeaUhAJJOM+Z8Ue+In01tEjX7ZGwWogIhtIPwhvb1sf0fVcC/Q
	 IwJtuFvlG/z8wx2ctp0O4Cx1DHR5NHBJURe7Lg72aFRhuLvN9Mldzb+6xKPfPOkOCm
	 T0vQCQ2/MHtEg==
Date: Sun, 5 Jul 2026 02:07:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Guenter
 Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Kevin Tsai <ktsai@capellamicro.com>, Linus
 Walleij <linus.walleij@linaro.org>, Eugen Hristev
 <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Hans de Goede <hansg@kernel.org>, Support Opensource
 <support.opensource@diasemi.com>, Paul Cercueil <paul@crapouillou.net>,
 Iskren Chernev <me@iskren.info>, Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Matheus Castello
 <matheus@castello.eng.br>, Saravanan Sekar <sravanhome@gmail.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Casey Connolly
 <casey.connolly@linaro.org>, Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Amit
 Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sylwester
 Nawrocki <s.nawrocki@samsung.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@foss.st.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 2/2] iio: inkern: Use namespaced exports
Message-ID: <20260705020758.011f4f3c@jic23-huawei>
In-Reply-To: <20260603182052.7d23c067@jic23-huawei>
References: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
	<20251209-iio-inkern-use-namespaced-exports-v2-2-9799a33c4b7f@bootlin.com>
	<acBr-W2ILu9tnMyd@google.com>
	<20260603182052.7d23c067@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 18:20:52 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 22 Mar 2026 15:24:21 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Tue, Dec 09, 2025 at 09:25:56AM +0100, Romain Gantois wrote:  
> > > Use namespaced exports for IIO consumer API functions.
> > > 
> > > This will make it easier to manage the IIO export surface. Consumer drivers
> > > will only be provided access to a specific set of functions, thereby
> > > restricting usage of internal IIO functions by other parts of the kernel.
> > > 
> > > This change cannot be split into several parts without breaking
> > > bisectability, thus all of the affected drivers are modified at once.
> > > 
> > > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com> # for power-supply
> > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>    
> > 
> > For input:
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Thanks.
> >   
> 
> For anyone wondering what happened to this... I forgot to apply this at the
> beginning of the cycle and by the time I remembered we had too much queued up
> so it would have been messy to do an immutable branch.   Anyhow, I plan to
> sort this at start of next cycle.

Immutable branch created as: iio-inkern-namespace-ib based on v7.2-rc1
on https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

I've merged it into the testing branch of iio.git so if anyone else does
need to merge this to avoid conflicts, perhaps wait a day or two until
I've pushed it out as togreg for linux-next to pick up.

Thanks,

Jonathan
> 
> Jonathan

