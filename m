Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357C517BDA;
	Mon, 19 Oct 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419285; cv=none; b=R0N3p0UO22e9NV7C+xhSs8YQ3Uhqd7060VHtxujV06pZmjPVzRR41w6B5PQV7OqnVSJFeTBJNO5wrDfRaHvySFlo4LQ+UZJJB/A0esnFVxTeBFjBjHOcG/h2BWjC4LPYye/bjPD2LZr4Zam5d96mA7Xx6UBgtU0oObIdxFO6a1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419285; c=relaxed/simple;
	bh=7TrOWvJdr4ZYeKMAdVNki72IA/NykHTapzzHHydK4MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY8XeDODqKWkhL07qSb72RutSUZywYCwwHsYB26xGdQZJBYnPFz+cHykiztSMulU+AIcGXt6B6RdrTTx/XuaW/N5H9uoLmgjYSbE6Ig1wiHJSQmBVVnIzHSPT4e4ywBl/PDdcU72QqwVJGaTe3Za34X98POQF5od7VWg+Y2vmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space; spf=pass smtp.mailfrom=timmermann.space; dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b=FM9SJLpg; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timmermann.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b="FM9SJLpg"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j7cxM4fPMzMlN2;
	Mon, 19 Oct 2026 16:14:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
	s=MBO0001; t=1792419271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWoutUeMhowA/cipLRcwpKdrrczuzzstTuE/CSmA4hI=;
	b=FM9SJLpgUbXCjuJYfDwkpUT5we9FdMfdivEU9sQjw05tdwBkvuPPlbWJrneWYnrw34bViS
	000VywhTR5vtp0UoBmbj+nV6EiN/hLoDXuxodJhGjM6x3Uh+I/BMyJn74s0YNZf8CwUubM
	YRm8I/QEb8vAIWfrFRc75Rj/x06vkPWCAedeThvGLjNJ5DN6A17AQy79g2zheDnrmkxuNz
	XYlAnwLFmMotGYbDjgSdcj02V1h/tZQpF3Iqj6OndXOiXrTXM2hnRYKpFVKRWizrn5vyHP
	Ekver87u0iLZLdV0oSA7llOv+6VuTpuImOAlgpPfAv9p9XnAaJJaNf53a9UGKg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of linux@timmermann.space designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=linux@timmermann.space
Date: Mon, 19 Oct 2026 16:14:27 +0200
From: Lukas Timmermann <linux@timmermann.space>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Lukas Timmermann <foss@timmermann.space>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: s6sy761 - split into core and I2C modules
Message-ID: <atYkR_nJnsKtTTE-@archstation>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
 <20261011-lat3st-google-raven-touch-upstream-v1-2-2a9f55159b9e@timmermann.space>
 <asy92cwqv8Xjc2PX@monoceros>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asy92cwqv8Xjc2PX@monoceros>
X-Rspamd-Queue-Id: 4j7cxM4fPMzMlN2

On Mon, Oct 12, 2026 at 01:04:36PM +0200, Uwe Kleine-König wrote:
> On Sun, Oct 11, 2026 at 02:44:57PM +0200, Lukas Timmermann wrote:
> 
> Please don't add new usages of <linux/mod_devicetable.h>. <linux/i2c.h>
> is enough to get the definition of of_device_id and i2c_device_id.
> 
> I didn't look into the other patches of this series in detail, but I
> suspect that the same holds true in your spi patch. <linux/spi/spi.h>
> provides of_device_id and spi_device_id, so don't add
> <linux/mod_devicetable.h> there either.
> 
> (If you want to go full iwyu, use the subsystem specific headers below
> linux/device-id/.
> 

I see. I found some mails from you in regards to that topic. Thanks for
explaining.

> > +static const struct of_device_id s6sy761_of_match[] = {
> > +	{ .compatible = "samsung,s6sy761", },
> > +	{ },
> 
> No trailing comma after the list terminator please.
> 

Noted.

> > +};
> > +MODULE_DEVICE_TABLE(of, s6sy761_of_match);
> > +
> > +static const struct i2c_device_id s6sy761_id[] = {
> > +	{ "s6sy761" },
> 
> please make this: { .name = "s6sy761" }
> 
> Best regards
> Uwe

Thank you. I will include your findings in v2.

Best regards
Lukas
