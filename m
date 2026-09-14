Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FC38DC43;
	Mon, 14 Sep 2026 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365588; cv=none; b=Iqpz+ir4h7sYZJtSSY5khVmQOMHvo3fOB9FDrIHEhYGLiWHzR9hLZ6L7DbhsrIrL+xHpc5OIWEPiV7oFGJjCOhV8dciRAXfMlTFLFejtS3DHApnJjs4DW5hyeB0DiDZE+A8bqt7htm3cQ2cPgKxrEkexOyIUiR0EuLIbDviZNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365588; c=relaxed/simple;
	bh=pBh966lODtpbh0icAJ5LQuJV8RVZqXy67eLTo61PdeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/MBIuzJYSe0B8fTvxVk5qHxGZ4E6QvH2rm31w+ch9B7GPNzjbiPsInVjN45g2RQdFgvrdhscscA6Ya0nmqIUDoo23lNs1F3VIEr11kjTsJUIfQemmwkLBvcqVmn5tj/NZPSGjvhyQtzrglcQTbVxlwKtc8EKpLOax7pvBk/MOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=NmSo4jER; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="NmSo4jER"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id C15F91FB7B;
	Mon, 14 Sep 2026 07:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789365577;
	bh=CFirnp4rcQADvcn62AmTmPFCZMeve+7sCvYxo8PgTBg=; h=From:To:Subject;
	b=NmSo4jERgiI/C62kJqShM5aU4chxp0UiSj8dx2VAVve/2ktWG4e4BLLu9sX76L/p/
	 fT5cQ9CgqUDuXg9uts3P3U7dAYauLencxLImbUI1/3YNW6J1qNJKhuK3rQSjtumbhB
	 6HvvgVKWagPTK1yruXU5QJ7dd08aU1Maz3W2uw+cYb+sQ4ytLI5pHsDuSNi6FoOK9J
	 QOHB6focBBS9uvTVfBg4x2Ga68x5Dkna316fBnDogkawHZnv0L9/8h1ZfM5StOP7qt
	 3TL/kmqAeQ4VTg0D2a/Ehue4iLrOzkQF8TvmBKCsK6Ei/QQMJQlv8p9SNGKFLGPEm1
	 Agm1sEaaMHD6g==
Date: Mon, 14 Sep 2026 07:59:35 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Kendall Willis <k-willis@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, msp@baylibre.com,
	s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com,
	vishalm@ti.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: gpio-keys - support wakeup pinctrl state
Message-ID: <20260914055935.GB19835@francesco-nb>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>

Hello Kendall,

On Sat, Sep 12, 2026 at 04:33:52PM -0500, Kendall Willis wrote:
> Add 'wakeup' pinctrl state to support separate pin wakeup
> configurations for GPIO. Upon suspend the 'wakeup' pinctrl state is
> chosen if it exists. On resume the 'default' pinctrl state is selected.
> The 'wakeup' pinctrl state allows wakeup from low-power states if a
> specific pin configuration is needed.
> 
> On TI K3 AM62 family of devices, the GPIO controller is turned off in
> suspend to RAM states, so no interrupt can be received by the
> controller. This prevents system wakeup from low-power states.
> Alternatively, the pins can wakeup the system if a wakeup flag is set on
> the pin by using pinctrl.
> 
> A corresponding device tree patch using the 'wakeup' pinctrl state can
> be found under "arm64: dts: ti: k3-am62l3-evm: add wakeup-source for GPIO
> button".
> 
> Tested GPIO wakeup from suspend on AM62L EVM and AM62P EVM.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>

This is going to be useful also for verdin am62 (verdin_key_wakeup /
k3-am62-verdin.dtsi).

Thanks,
Francesco

