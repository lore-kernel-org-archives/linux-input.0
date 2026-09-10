Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8753D954F;
	Thu, 10 Sep 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032529; cv=none; b=UD0DIKHtBN1frGH8dpgyGm4A6km5FyevBQFnaxO73uxRP+tfItP1L+0h/2A/ug1osTSi7IMSOaLcmuEzAQD5YmPmRYCA0yu88w7evAYHnhADFGHDsck1wBdyiz3eeTuqJrLy4k/G0++HTmnCXIVS+b9CvreWvqUJpMT94RQBFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032529; c=relaxed/simple;
	bh=wrE9sEz3G4FHPQGOCMyNvKfMBxghaqX8RPP6/l9aNH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZgqt0AFOXQZ+bC/FBUiWOnLhR4DVqOw4PtqOofRwqbwaSiaJaUc7lQ/iEt4+zypBHCdClX1TinHrae0ROVTkI6CzNY9DteBjKjyM+WdGq0AzOR9Ba1wxvV7gZgxgfs1zJDLy9WtH1kmu/o7rCcmVKsGoGFuy79p9Qe5yk+p/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5qXhXMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5qXhXMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B101F000FF;
	Thu, 10 Sep 2026 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032528;
	bh=Z5qIrcJzme0NduXyrAvDrLG2NE3PhTF+gf/58fAEq9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M5qXhXMha99KD+SAUmY4c0ZGSM+OpKh9JL0zlPOoByw22ty92aTGlxTDK4x6rsicC
	 11f+PGVWnEHw8AxbzqmHqGscOSVN5PrAD1hwPqzZRdOTRtLUlslIgjNNB5SSPqdkHt
	 yIT5ZlIAQN1Eumg8FE/yJdhZ/k6Zfp0SRw5rD/ZhxUsMUz2sQEpaWYIssfGfqOx/jq
	 HDN1EmjYdpNIlpzldwiepJT0iQw7gksXVc6UI5aJl3iWQ83Ldd4ISafSmZdEIUMjeS
	 OFdO1Fqu+1bogKmLNNwGg+dz22+7iJeYC48wBW13enJnQZRT8kXDwvcKM6DNdF9V5U
	 hnVfXtMtzo8yQ==
Date: Thu, 10 Sep 2026 10:28:40 +0100
From: Lee Jones <lee@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v3 07/10] mfd: wm831x: support software nodes for DCDC
 regulators
Message-ID: <20260910092840.GN2133376@google.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
 <20260711-samsung-kp-v3-7-b2fcaba77aff@gmail.com>
 <0306eaba-b59c-4f8b-9151-9f39685398ba@kernel.org>
 <aprLYn4VzSTnZWuw@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aprLYn4VzSTnZWuw@google.com>

On Fri, 04 Sep 2026, Dmitry Torokhov wrote:

> On Fri, Sep 04, 2026 at 03:41:21PM +0200, Krzysztof Kozlowski wrote:
> > On 12/07/2026 04:12, Dmitry Torokhov wrote:
> > > Allow passing software nodes to wm831x DCDC regulators via PMIC platform
> > > data. This is useful for non-DT/non-ACPI platforms that want to
> > > associate device properties (like DVS GPIOs) with the regulator devices
> > > using software nodes.
> > > 
> > > We add 'dcdc_swnodes' to the PMIC platform data 'struct wm831x_pdata' and
> > > have the MFD core assign these software nodes to the buckv cells.
> > > 
> > > Assisted-by: Antigravity:gemini-3.5-flash
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >  drivers/mfd/wm831x-core.c        | 47 ++++++++++++++++++++++++++++++----------
> > >  include/linux/mfd/wm831x/pdata.h |  2 ++
> > >  2 files changed, 37 insertions(+), 12 deletions(-)
> > 
> > I still need Ack for this from Lee... and the problem is that you did
> > not Cc him.
> 
> Hmm, indeed. not sure wheat happened...

Always worth a try!  =;-)

-- 
Lee Jones
