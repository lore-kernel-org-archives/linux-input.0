Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0827FB1F
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777349684; cv=none; b=uFPeOIzSaHACr5Z7sHRc4bv5I2KKLmPleOVgCpkAPkg22mBbtnUjFaYaVPALinqj+KaQBWV8ux3GPed2RVh+HqjpLoa1FnO0fjDn5rmVPuiJT1f6t18LNAAvcI2tXMhcTkShqELDr98h2DGgc8O0aGpMm8QvL+ZSg2oGVg1cBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777349684; c=relaxed/simple;
	bh=dIyVXV1vWjWkWQ8ruG4jjcBiCKLroMm3AaMH2Co8U/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvjOoI9DiBM1D31olE4qXg8VN6R187dH0zsgAzBvE5dE2EOeZEFbvTNTLeSVsGrKOzTXPG8psQuCFJyAZ0h047oIXtF+Sjw2ccYb5gocPMz/1W/mSyb1QOykVa3zBPkqJl7h2hw818jksGJ4HvESfobq8Yb82QO2HU4BX4T6+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfC4WT/f; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfC4WT/f"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ed0a45e970so419433eec.1
        for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 21:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777349683; x=1777954483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEz0oDUdcTpFuThs6YX23JY5C5KbjbJBY3HgDPzdlsM=;
        b=ZfC4WT/fJJpZvEc6wpGFwfi8GMKcAJybsGz7JqB8sk40gvTnEA47n0HZI/HVh5d5ZC
         W7g1VoPQ9oBNjlXolezxvo5Al9HBTooTJsLe/IqRoRDPWnUOHJwJpiKh4TQtYgTQxyPb
         CcgRs18UAQj/MgVkorkqsUJLNNs5w/sZMlYf47ZKYeO5NQgcjUj17eY56ILgWYsoRK1F
         eAso6/f5UBe6H1p947qiD4AXYcLYrE7EwuE9X9o3vzuQXHwmdht1hfbKBo8Beu5Aru/Q
         RzARFFXZ1WVkt7mxmsDBgAH3Ikrf9+qmVfJndoCEvmTFktWVAqvRngXtXdsI6dVIDBr7
         my0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777349683; x=1777954483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEz0oDUdcTpFuThs6YX23JY5C5KbjbJBY3HgDPzdlsM=;
        b=NLS55iho8zpaX8wH/tG2llWzmVE+OpourhRjFuSSOMwD3rqxO4GuJGHePOtxztArd/
         MqEVx8bYeMlVVMmrU5FITjdzjxbwFsPdwegxOnBsFIDRKrb+IAg1/H5+P1RFTJsOySuj
         IIvp2RTDwaFkKsLE2ANExkVwFpU1N4/uJePqCB1hVO7WtG6FILgoYnt1r49O4p5xuCPj
         ehJMRJD4z9mUvikCV0BDks3Yf5jpmrGA1Zc9K6q0untO3nQKMt1B14gr1pLyp4tyK6Mc
         4RAsp8FUDlv1uNdkZYFuTi2sygXs9PbR/nn+hszjGLA6RO5hKxqewfGpWaTjEVLpYNwO
         KTag==
X-Forwarded-Encrypted: i=1; AFNElJ8srIEiiPB6D85XpPzYIT0L9mBCFjJDQechOsr2uiqdGKauarISOessuriLpGtOpGdYkn82R3mBciS5Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7lVxZCeLyCnvq3xHF1sCiMJVklTsveDRh1NAd5D5w0QGZKik
	WQWk0jSQA2EnMsHZDNOcgQH4jfEqRbua5ztsyQy1iIsSvPCTVvbVVPXX
X-Gm-Gg: AeBDiett0s+7hU/YSsI7npkhhmZP0YNC0ABfp0X+1TxdP6xKBAwr4Sir5XXUNZxtwCq
	7eRRPIs4642zfFR7s35xw5Njo53ZzHDkLFR9T3i4ySBRxov5mvCHyBBOAhyZIrHODOqug7tJQL7
	I3cUVXsBOvByahd9gtNC5ywxvujCJcc6CySW/kP1YifsHN07peV9EnmQSo/UnyIkNNM3UNHrvBI
	1zdk1YioCtfornVVe/eYj7KCA29tq/5Pp0LxdHRnXG7T91UlSN5DNwaHKVzn9GaYQXWF5pKw0r3
	FJtI6Pyh1jmjX4lEwO/6vvHRcQy6gtlKr5O1b7Ur06hR6KiTJT1mYT1tspxp4J2SSZpVrvf4hVr
	ZEx4zky89Jsq0WE9+VM+S0q4uv8lpHadEXSZDXIZd8qlGnVMgdkWH5xY2LG4HIbvkJdJfwoImO0
	5NfuD1UZLfoMEKNvg/cMP+W71MljAPLYSFwxS3dFUn/9aoR4IfmS6NXyczYNxQR9H2P3X9i8Tmg
	rHM764WElhx8Q==
X-Received: by 2002:a05:7300:6147:b0:2c1:7afc:df06 with SMTP id 5a478bee46e88-2ed09f92a3dmr773004eec.5.1777349682735;
        Mon, 27 Apr 2026 21:14:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e678:f42a:a63c:516c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a10650esm1250234eec.22.2026.04.27.21.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 21:14:42 -0700 (PDT)
Date: Mon, 27 Apr 2026 21:14:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Gatien Chevallier <gatien.chevallier@foss.st.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Andreas Kemnade <andreas@kemnade.info>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] input: gpio-keys: make legacy gpiolib optional
Message-ID: <afAz-UQY0aCaThV3@google.com>
References: <20260427143406.3020992-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427143406.3020992-1-arnd@kernel.org>

On Mon, Apr 27, 2026 at 04:33:49PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most users of gpio-keys and gpio-keys-polled use modern gpiolib
> interfaces, but there are still number of ancient sh, arm32 and x86
> machines that have never been converted.
> 
> Add an #ifdef block for the parts of the driver that are only used on
> those legacy machines.
> 
> The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
> passing an IRQ number instead. In order to keep this working both with
> and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
> the gpio number if an IRQ is passed.
> 
> Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: skip the fake GPIO number passing from mfd
> ---
>  drivers/input/keyboard/gpio_keys.c        | 7 ++++---
>  drivers/input/keyboard/gpio_keys_polled.c | 2 ++
>  drivers/mfd/rohm-bd71828.c                | 1 -
>  drivers/mfd/rohm-bd718x7.c                | 1 -

Let's see if my patches to rohm drivers will get accepted and then maybe
we can remove legacy gpio API from gpio-keys altogether.

Thanks.

-- 
Dmitry
