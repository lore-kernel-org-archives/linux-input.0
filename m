Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899480;
	b=Q0+2GzKo7FYtal9RMomuHwVtoOqOePbm9jN1bpQ+PFZiS1JubJ6n5OXw3aeCA+U/EjgJ
	 ZIx6iZ5BdPTdkgmxeom2Xp3dCsUxTlY+5/TijAB5idURDdiQnscdBhJC2/vITTdswsrPm
	 jKUVkPjZQEg+viKMVPyAb3HHUG3plv2BbokPn+vVduDI6GkpvYgcRljb3vYb5goLeN04q
	 nQg8B4iXREd+cfabyLnvbAG1wurA6UbZWQ7Kx2KXyu8viUJy3u4aa+64uV2z5bECSjizk
	 Al0RaZJI6j03QdUkzS4VKbRrcTZL1/a8OfgezG23lPcx0IGYQ3MUAUVqpvHSHoWM+3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
	b=0bUP1a4PEQ6fu9HBoacM03F6PezFWCJ8I63AEhrFBfwimlrvB04bjmbvBWevnaDANxwH
	 0xtwsbYFg2Y5xMGRXrB6+98DPg/rYupgZu+t4rgEDEuMKgC3sKaXonvexkMVszImzjiol
	 ly7Ze6QcEFlClx6Z86Jbk74UjxKRlQ3VlcSWUqchpNbh5X3trlVg8SCqlkVobeWBZl8Nh
	 xu3lcp6Z+W8fyQF6sHFUXbm5Ps7PmmsrQ7a7bm80vQpfHCfqafr255fItbshgT1F8VvwJ
	 Ybriod8IA0vS/cxI28TmI1LC4egZcrbQECzPhA30/+zs9ClTRvMdPt+S57qgozS4HUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=OXXcUxth;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F50606D83C
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 17:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77F50606D83C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=OXXcUxth
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53c4b82919fso26190041cf.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793899478; x=1794504278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
        b=OXXcUxthtyymPU3fwfbcr40/daOdZ4UuV0IOhK3r7k3BfuoZd0x2qWahN2YNfUretu
         Tvwnl0KFWoKOeZb7Eb3uBsqzIqq8J25exR7V5CgkLuEPZfnZT4ED35Z0b9rlaw575Jgj
         FQy6EYxV5onXU0wpKN8YyESt8CkDTpTTkNBn9V25Xj56jakQJCIeQ+jbdgqM3xEfnuQB
         l6A1FG/uOsFRxdidxCtIsyNflhv6dRW8a6chHrMU0u2dgaNP3KFe01+lBZywKoRsUbeP
         mAwXyFk8XjT9tW3AtUvUEUaho7CfMrUWwbB5j2cn7aptAgB87xrCSo1TqcjbSZYZh8xc
         JpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793899478; x=1794504278;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Sc9yPGaNTmoDAc39XzEsbXpXvtl7Fk3dFBI/g/ZPmw=;
        b=NCeq3XbW9QhRbslSvVXa1tYrU6uuUYPnK99AAyp8QfIruS3SRnnfHVqD0R0M3cryLh
         vHcHGmbXr10AXCyYPmz4sMG9JykOs5TDbWz/zVsDyPmrZmDmk/bQ5nsMON38aOG2RQzc
         LDz1vS7wZXcGRFRw4iT4yxosu3YUDoItab0a7IrqmyoC6hptmr5AbI47+ExWWqQlzEfD
         8ClrHia3crG5jpKGqS9fNK1/9CWkF9xMMPMkxzQS4DqwylFiNkMeZd7HQuOCFMLbW+yr
         hyT8vX6JCeDaaloFNZtfm9Uj8BOhbhgNXXVMcHhLVDv+MxE+oiiTfLkY/vBMZ3F2Hi/l
         M+iA==
X-Forwarded-Encrypted: i=1; AKwUvBy/4qNV1fIk2PIGSq+/SzXqJeeBfKlVB1Vqf8PaUGho4F20aHivIVPwxOoOq6Cdk9VnqGX8X3AuuYlqww==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ebm17VmlDw+6nP7UG810EvpFoJSey450102r4O32JpEGtdQP6
	Mg3Q7AIFxKlKwkx8LPTpRPZ+qZeKLMTEVWyRZyQxSLHnulXJww3LlP0iyP8uSHblxQ==
X-Gm-Gg: AYBFou23pEcHBDNWILpF8iwCOcubhA43MdPXg1/s24b95W1e882rQG2jXAoXJIocGXU
	CocvLSdmrAd5JJTT7Pi2S/rq+XCFvw1xaw17A5aDd4ChVkeVBx+GaHhJt6L8Mj+r9PkCNeCpobF
	CP5FKb0ehaOMjN9Xdebdhh0WiYHVe1yuu2eFm1ituDXthDajI2HjpCaqQ0m4Moko2ouAnwjiuwr
	9Hsf4blXCDmr8z8qI0j0Soraa0vJFq1Uz3XMv+qtClXMsokoBvNIiNtPDrwJtqn+kHR48UmRRpA
	EZI8kUsQgJf5Sp3FK54ndo8UFxKyBPgImn3HocIbBrsXY/9ism7P1GDlwGgPjiKx3etwVwYes47
	F3fKRPERE9/KFGqfBKUAq5+wAKVx6jJVEzbyNC+cLWTKK3+m0MrgmNEFVT0cLwPSXOOoLB2doOa
	3mvH7bv/9slyQWaNbMEpdCu+rKJT9VGZ59R4/+4CSGQcFi4uzjH0l0OYMqP/MfI8TpSG48Ye3Gw
	OuDn8YREJvWwnOZqTRHrqmQ99vWBtrzNAwkal/E3msP29Phou8T4Fq2Glmru+7Wml120QVFikbk
	DYLhQwrz047Nf4UZRLd4zPGGXQ4S
X-Received: by 2002:a05:622a:2515:b0:536:52ae:d92c with SMTP id d75a77b69052e-542b6e55bebmr328898701cf.35.1793899478212;
        Thu, 05 Nov 2026 09:24:38 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a6ca24sm57130131cf.14.2026.11.05.09.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:24:37 -0800 (PST)
Date: Thu, 5 Nov 2026 12:24:33 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
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
Content-Disposition: inline
In-Reply-To: <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:18PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Interface claims hold the USB device lock, but device_bind_driver()
> requires the target interface lock. Without it, trust-policy writes can
> race admission.

This says nothing about usb_driver_release_refused_claim() and the code 
related to it.  It is an incomplete description of the patch.

Note that nothing prevents drivers from using an interface they claim 
before that interface is registered.  For your scheme to work properly, 
you should make sure the claim is authorized when 
usb_driver_claim_interface() is called, not when the interface is 
registered.

Alan Stern

> +/*
> + * The driver core refused to bind an interface that a sibling claimed before
> + * it was registered, and dropped the claim. Let the claimant release the
> + * interface instead of operating it with a bound interface but no driver.
> + */
> +void usb_driver_release_refused_claim(struct usb_interface *iface,
> +				      struct device_driver *claimant)
> +{
> +	struct device *dev = &iface->dev;
> +
> +	device_lock(dev);
> +	if (!dev->driver && iface->condition == USB_INTERFACE_BOUND) {
> +		dev->driver = claimant;
> +		usb_unbind_interface(dev);
> +		dev_set_drvdata(dev, NULL);
> +		dev->driver = NULL;
> +	}
> +	device_unlock(dev);
> +}
> +
>  /* returns 0 if no match, 1 if match */
>  int usb_match_device(struct usb_device *dev, const struct usb_device_id *id)
>  {
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index a738d03c23eac..d35a7710c8ef4 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -2264,6 +2264,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  	 */
>  	for (i = 0; i < nintf; ++i) {
>  		struct usb_interface *intf = cp->interface[i];
> +		struct device_driver *claimant;
>  
>  		if (intf->dev.of_node &&
>  		    !of_device_is_available(intf->dev.of_node)) {
> @@ -2277,7 +2278,14 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  			dev_name(&intf->dev), configuration,
>  			intf->cur_altsetting->desc.bInterfaceNumber);
>  		device_enable_async_suspend(&intf->dev);
> +		claimant = intf->dev.driver;
> +		if (claimant && !try_module_get(claimant->owner))
> +			claimant = NULL;
>  		ret = device_add(&intf->dev);
> +		if (!ret && claimant && !intf->dev.driver)
> +			usb_driver_release_refused_claim(intf, claimant);
> +		if (claimant)
> +			module_put(claimant->owner);
>  		if (ret != 0) {
>  			dev_err(&dev->dev, "device_add(%s) --> %d\n",
>  				dev_name(&intf->dev), ret);
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index a9b37aeb515be..293340a48b6c5 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -49,6 +49,8 @@ extern int usb_set_isoch_delay(struct usb_device *dev);
>  extern int usb_get_bos_descriptor(struct usb_device *dev);
>  extern void usb_release_bos_descriptor(struct usb_device *dev);
>  extern int usb_set_configuration(struct usb_device *dev, int configuration);
> +void usb_driver_release_refused_claim(struct usb_interface *iface,
> +				      struct device_driver *claimant);
>  extern int usb_choose_configuration(struct usb_device *udev);
>  extern int usb_generic_driver_probe(struct usb_device *udev);
>  extern void usb_generic_driver_disconnect(struct usb_device *udev);
> 
> -- 
> 2.56.0
