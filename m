Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795398614;
	b=WQU/G2pVplfjOdJ5PrVU+2jjlJ4UetO9LeqXAPu7oRXD1342styBs5B99kfBV1A1zSaP
	 x3iU17NZeyolWAG3k1vQJUMJ52QJCK2H//KDQxylH1ChLOQFWzc9Y/d/6szKovPQGA28p
	 iQPW50jDAKvx2Yt8Zp2RFW5EZcUIOgCzBqBxn4OCGuOjPd8OsVafOQcJBNDBxa2FRrO2w
	 s4PqqRD50S/asDOxCaw7nKgcfPdv2waZnursZTs8+2LvczJvwLpMXwY+tZLekVy7AxJe7
	 eG0r1Ah3LelH1e3EH5pyohNkYPDRZI4BbUsGCtIIbq4qW49Uuz7vVwRmmdhsbLDtBoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=HPgiKAKXJD1IfapqnG6OwznXuOp3qOSKSxNr/yY/XDo=;
	b=jbVHjn9CiNzDcdu7TuQg96dFA468q/drcp76rzzY8eL2J2YS8I4a1kreuLQzWw0hIvxs
	 QgjQRWB0ZQAHpI1ATbuJ3Y0/DA2JIxm5uUSHm5KKQRItchd6wdtbwYl7v1fL5+L+gIf2C
	 7y1qHlaKLcuYfv8Pd69aoxWV/HK0hkSU3BkW3mJcg1S3IqpfYAyYuVrSbgCvljmnELSqa
	 InfGcgqCdgVBkLEMtey3mlQuVEBflX3tw7ZYG/b20Gsns9WcGsP3r+zRR5AQgj9VAK+5U
	 L1vFM2Yws4tGIUYt07KCSzUBR49kzGDZ2+PjA0iNSPuL9bCiMrhBU54DJGE6nT8+YGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MNA1EOOg;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91AC606A31A
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 01:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MNA1EOOg
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so4135667c88.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 17:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795398613; x=1796003413; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HPgiKAKXJD1IfapqnG6OwznXuOp3qOSKSxNr/yY/XDo=;
        b=MNA1EOOgy6ZBUuhdD/ZBI7Krj7F286wnIncjH3RvwMa9Lc6CVzlP3UWssD/jKo8kN7
         184A5ipSF0KxnBffvHbZUN+7mGJxIAZqrn4T/nS9fYIOIeVXd1Xfe58RDS3ca8MxmdlG
         f7ip3ojQ3TguSeO2SPj0EX9SjMAZLOpzJI7OppbJeoTT+ksGEU/4zTxb31E2/b+LE1ky
         XZR4ZxT+5e3Ks+ZDfQnGbk5ix4v6y6AlYras45QHR/82UCqVk5NvRExUoY/e7bjEGuid
         1axATOXDH4WLjGw3TC4bdTjr6UJy04UtiZyYcHA4T8SfZsYNl3mcJ3kKl9XUgaLCMnRq
         vKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795398613; x=1796003413;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HPgiKAKXJD1IfapqnG6OwznXuOp3qOSKSxNr/yY/XDo=;
        b=S0oZGbLoM3RrY9lFoBl8PGAWSxzuJkI3zanAycR6HEO1jPrtOY9/n/cw5qc2mhk62+
         YTLKtlGfWyq3PpeFjAfbxPklXBrdjVfvINXYlotfwZkZymRibHSBs7/ceMoeFtwuP7CU
         +xC5OKXfiKNp+CjthkbfHPeQZD0M4NXs1oFV/tD3xdh8SJd24uUN2cDLvr0DIdgU9JKv
         XR9JLIjTvEgV+ojX+OC8SIJg/k1Oc0m3tgOzgu9IudDXNOofY0jpifItyqMDD6Flzbmb
         +QS+AIdMQyK/ElF4Js31I/aWjCOuqW8708TO1jegYtobo54i9RGAVSA5+Mdh6XvXZu9Q
         3gGA==
X-Forwarded-Encrypted: i=1; AL+hErESJe7moWemKJyqR/16Z6oiXUdQZwDkVAxXOpO3eOaAfKtqBhI3b2mVD31SogHv1SY5X+9+Mk8DsFj52Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/3SxMQt8pGb5fXHL912rxI/oRTfoLpZH2ei+2plEnpEPR6xE0J
	tPp877XwTX6bFrdcCjpzJAx0M9ns1FuxGb4C8MPvQs6EXy0e0ou2BA4A
X-Gm-Gg: AZFdTZeboVmUFSc/gF/4DhLxHs3Q7eTF6jjAtYUSgoZ6IAfp4CcH/QhLO4p7dIt9X6n
	kM6aWIcgLk0BtcSGcaQ0pUsu6WPXeup5cgVsaB92wfHJYLKXkpr++9qEPOO7dcPH9Z6sBQNhYeA
	hD3igXnsdpn+qlrljKbqUMBRT0ZrFWpRIb4NBQeYpiaeTYMt40nCXJek9jJ480eOMJ5pDb5xh3B
	Dy1CJkPbmbmG3qyumMAgkFSalUx947QZAq4aEL0Y+IgW11YLYOFC35c3hofXn2weSGS7J34Y+Lz
	fwm55MFkMkbqXUoINUTNJssbdFCgh9256niYGyXU3dMxQ7I69wGdV3IZKf5gCq2t1uubyjNFWS9
	i242yPH0dPz89P5g8g8XbY/EFvs6yxQiXoQGqQdRD99VtSCPcpKhLzV9zrZTENEdzy3Q8Hd5RXP
	uEuug4wMaP32vue24TA8YExDdm4Rd+bp/JRHh0VFAWs1Ze+fhc/90ccepIyDizoszT1e3mbP4kZ
	zFwkVoQ/gyrAtqQ0kM67rFsqtnDFxgBniZ5SEHkSOd0porOWgCgiPQhWXsYmLOTYqUKKQKGwrNb
	QoUZ4gVYEPJXR5Bf0ZDQ5nWyN/U4b2YeeWQkCeROMVFQRPFrVHIc/XiB1iznYrb7IhqNdg==
X-Received: by 2002:a05:701b:230b:b0:1b2:4da6:bccd with SMTP id a92af1059eb24-1b5568feaadmr8740253c88.34.1795398612828;
        Sun, 22 Nov 2026 17:50:12 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm23364703c88.3.2026.11.22.17.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 17:50:12 -0800 (PST)
Date: Sun, 22 Nov 2026 17:50:11 -0800
Message-ID: <8c2d4920319771e3f7edb083b2e831a9@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: Mark Brown <broonie@kernel.org>,
	Jakob Unterwurzacher <jakobunt@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Joseph Chen <chenjh@rock-chips.com>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] Input: rk805-pwrkey - enable the wakeup interrupt during system suspend
In-Reply-To: <7bec766f-14b1-4eac-96c7-d7f1cf38021d@cherry.de>
References: <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-0-cb12621c1fb4@cherry.de> <20261029-dev-tiger-v7-4-pre-20261028-tiger-suspend-b4-v1-1-cb12621c1fb4@cherry.de> <avUGEQhSKlko0Fm9@google.com> <7bec766f-14b1-4eac-96c7-d7f1cf38021d@cherry.de>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jakob,

On Fri, Nov 20, 2026 at 02:42:57PM +0100, Jakob Unterwurzacher wrote:
> On 11/12/26 01:25, Dmitry Torokhov wrote:
...
> > Sounds like this needs to be solved in PM core rather than hacked around
> > in individual driver? Let's CC Tony and Rafael.
>
> How about something like this, copy-pasted below? If no immediate 
> objections I'll post it as a proper patch.
>
> With this, rk805-pwrkey can use dev_pm_set_wake_irq with no issues 
> (tested on RK3588-Tiger).

This approach makes sense to me (and matches what several I2C controller
drivers such as i2c-imx already do), though ultimately it is up to Mark
Brown to decide for SPI.

For rk805-pwrkey, please use devm_pm_set_wake_irq() in v2.

...
> >     Take a runtime PM reference in the regular suspend phase and drop it on
> >     resume. This keeps the controller usable until its noirq suspend
> >     callback, and since it was active then, pm_runtime_force_resume()
> >     restores it in the noirq resume phase, before interrupts of child
> >     devices are handled again.
> >     
> >     Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

Probably worth adding

	Fixes: be721b451aff ("spi: rockchip: Resolve unbalanced runtime PM / system PM handling")

as well.

...
> > +/*
> > + * Child devices (e.g. an RK806 PMIC with its interrupt controller and wakeup
> > + * interrupts) can still need the bus during the late and noirq phases of
> > + * system suspend and resume, while runtime PM is disabled. Keep the controller
> > + * runtime-active from the regular suspend phase on, so that such transfers
> > + * work and pm_runtime_force_resume() restores the controller in the noirq
> > + * resume phase, before child device interrupts are handled again.
> > + */

One nit on the comment: rockchip_spi_isr() does not use IRQF_NO_SUSPEND
(and pl330 DMA suspends in the late phase), so arbitrary transfers in
child suspend_noirq()/resume_noirq() callbacks still will not work. What
this actually enables are PIO transfers in the late/early phases, during
device_wakeup_arm_wake_irqs() before device IRQs are suspended, and once
resume_device_irqs() re-enables them at the end of the noirq resume
phase. It might be worth wording the comment more precisely so nobody
assumes general noirq transfers are supported.

Thanks.

-- 
Dmitry
