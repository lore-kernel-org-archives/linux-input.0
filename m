Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2D3EBF24
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338795; cv=none; b=MRxPRmcH02SGF6/Bv3/ODyefDBqpQ7wb9GBQsDC02sIbegoBhdXXS30sfPZmaMVdGtwJtQaz2H7yk3Z5KZS21nL3DnmbB5XoN9OUEiIioP/FT0zYuRUswgEYNspSMeqmiG1+6ihf7//wwkWsExO4c2bzGOwVKud9l+kljkxnj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338795; c=relaxed/simple;
	bh=hfinmS7LxtGPsI8sB2v5neamafqQiHYTnsw1ZTsh9KQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AbpB7wYPPFtHmAcH5firfOWXLyp8rhB2IbRJLr+HgCjNy9ef38B/Ux3las9/hGiSUCbwxUD5CBRdzYxmn+MIPuLwcGv3jPgfWqkcnvlMJcNDF7VIBnBFhwW2wmnV9cYgfTxYqo8/gIAkqLD/2kNyY+t1931H3cvHV2hSq0l/eaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ5FEoG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ5FEoG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD931F00898;
	Mon,  1 Jun 2026 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780338794;
	bh=IrmAtEJfJzUcPIeNSpsR45e4ng04o1+FX2zZga+xxvA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BQ5FEoG78fCXf4dCiCFVtFJPWPVA6mZswWU+o8hdm50pnEdJyfOLiBGItZkc1DHHR
	 3u2qGO+b/9Yx7sCDrWFyWtamhoSSpKynu84TsyQJCQLa7i/M5R/heiMFuAeaGWicm5
	 HXvA8qTpuQOe6Obh6eHiKpmqRXCOSmUa+OHb5g9QZQV8U3fStu+Bs5MXAs92tz+A2H
	 y6ftszfw1/na+Y4RyyqxlVbrzEBLbCmAoTyaMjVa66Mc5jFBo8SASiEzugwh55drgm
	 gGkvXMuCgKv3li2e3qslXZSg1J9EX90dFPj8TJprh/W5JgG5xvw/yjceIvnAY+DXGC
	 DIC+PoP0Gfgzg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 86BBDF4007F;
	Mon,  1 Jun 2026 14:33:13 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 14:33:13 -0400
X-ME-Sender: <xms:adAdauyYsrqagDhrEx_uggR8z_TuxMHY5FFS9lJTpI8MnoFSjBLM8w>
    <xme:adAdalH4jXDdotyWQOGCbLXvo8TY43KMXCYsbM9IIYcv7lV62Hi0PIVQtImhfZQWM
    qflBIqG39ADy4VJMi34-zeQ5oPHv8gN7lSG3IWXRrRXc45kcITodjM>
X-ME-Proxy-Cause: dmFkZTEVbPm8Q2RnrXoI3zzNekE7UJk2dx7scpcbzaCBA8w3GR5cZ/Xa8ijNwmB1xdwEUv
    I3SUimJcck8HgmOUlUIxyNq0gdql1aiMWXgPamKvPpjG8uc5zJr5EswfgUPHad7piNeUPI
    AHvmh/AOdWg1FvAWg+PuTZAqkUkfGq+2Jr0VCmKRE04YADMTGUKXg+fiLrr7Jl9VtBcpkA
    LJiwd2mzxCAzawGZpJVbflsuja80JXdITBEVDsM79RrvFUCHCdXbkUltgnqllWBpWrMMzW
    SPQayIuW1MNPhltuBxHkLbZQlakokKjeaZu1m+uDNamVat7vEnJZj0Wy+eD0O6doaUYILj
    xqLqNwUdvtIAuHpyByw4bqR1m3K4GMpAxCaGCVMU4x0+7jKE+WO3tEGUb4l6gTno4ITb4H
    YIOA/1Bl0PwrHMvFk/tgwZHypSdPBu0Cmq0I7KD7ou9m7eGAuhhmzvL3iNss6L0K1pENOG
    PT7aV1njmYp22hKaUICXEwcBYLuqz/YCZ+KhQtwszVFv3XE2KyWurpzDQjtiW1mgUR3na9
    q7l4IJeFpnJ+2MaDCFRLq5imZlwsZpTOjiafUnWZZgAA3ztVBg3HrZp8UoleYwtxPI0cWg
    Mz55yW3cG1bwNAEdRKBBDTl6IN071Qj4DzS/xaAoQ56gMJj8/rvm4uOTgdlA
X-ME-Proxy: <xmx:adAdaqnC4JlAdiV-gzO6LWjX3dv7TTcXn2c1YzkQDKuo0cflqmkPwA>
    <xmx:adAdalj502yA0IxVpoiUVlM4P6DXB1WtRqzP5k529kHoTMRIoVkY8A>
    <xmx:adAdaieVKT6VB038ApYtXsUY1BCEEGILla-EbMMuMAcQu5Yz4Sjyrg>
    <xmx:adAdalj7lgn_O-B6jFdL7jZ0x7oazQgPa9l-DkCalP2yUH3Ph7VlMg>
    <xmx:adAdaqzjrya6RrJdCT1l_mKWVHCbpkyR5vdOowoi54CQd9KS6zFymRSc>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65D49182007A; Mon,  1 Jun 2026 14:33:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArrYli9DFPON
Date: Mon, 01 Jun 2026 20:32:31 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>, "Jin Yao" <yao.jin@linux.intel.com>
Message-Id: <dfe153e1-a3d1-4dca-a59b-59899082c4e9@app.fastmail.com>
In-Reply-To: <20260530004519.1C8E81F00893@smtp.kernel.org>
References: <20260520183815.2510387-3-arnd@kernel.org>
 <20260530004519.1C8E81F00893@smtp.kernel.org>
Subject: Re: [PATCH 02/10] [v3] input: gpio-keys: make legacy gpiolib optional
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, May 30, 2026, at 02:45, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does this change break legacy devices that legitimately provide both a valid
> GPIO and a valid IRQ?
>
> If a legacy platform provides both a valid GPIO and an IRQ, this condition
> now evaluates to false.
>
> By skipping the GPIO request entirely, the driver falls back to treating the
> device as a pure IRQ button. This forces the driver to lose hardware
> debouncing and rely on a simulated release timer instead of checking the
> physical GPIO line.

There are only three drivers that provide the ->irq field. Two are the
ones that I'm changing in this patch, the soc_button_array driver
is the third and none of them set ->irq and ->gpio at the same time.

>>   */
>>  struct gpio_keys_button {
>>  	unsigned int code;
>> +#ifdef CONFIG_GPIOLIB_LEGACY
>>  	int gpio;
>> +#endif
>>  	int active_low;
>
> [Severity: Medium]
> Will this cause build failures for drivers that assign to this field when
> CONFIG_GPIOLIB_LEGACY is disabled?

Yes, that is the intention of the patch: nothing should set the
->gpio field unless GPIOLIB_LEGACY is set.

> Other modern drivers dynamically create the platform device and pass legacy
> GPIO numbers by directly assigning to this field:
>
> drivers/input/misc/soc_button_array.c:soc_button_device_create() {
>     ...
>     gpio_keys[n_buttons].gpio = gpio;
>     ...
> }
>
> When CONFIG_GPIOLIB_LEGACY is disabled, this results in a compilation failure
> since struct gpio_keys_button no longer has the gpio member.

I previously included a patch force-enable GPIOLIB_LEGACY in this
patch series, see

https://lore.kernel.org/all/npijagtgyad33xxlq46b7kwzydhcgt5tkgd5ihsjl6t4czbqyf@umovipwh73i2/

I made a mistake during a rebase, so my older patch was still
included in my randconfig testing but not in the series I
sent. All the other changes in it are now redundant, bit
the soc_button_array portion indeed still remains.

Hans, Dmitry, do you already have plans to deal with the
soc_button_array driver to move it away from legacy GPIOs?

So far I can see four possible ways we can deal with it,
but none that I actually like:

a) delay the problem, apply my original oneline change
   to 'select GPIOLIB_LEGACY' and fix it later, so we
   can make GPIOLIB_LEGACY default-disabled in 7.3.

b) add a gpiod member to struct gpio_keys_button and skip
   the intermediate gpio number here. Clean it up later.

c) always pass the gpio as an interrupt, as the driver
   already does for some machines

d) add dynamic device properties that duplicate the
   information from ACPI/DMI, so the driver can
   stop using platform data

e) disconnect gpio_keys_button from gpio-keys.c and
   register the buttons to the input subsystem
   directly from soc_button_device_create().

Any suggestions?

        Arnd
