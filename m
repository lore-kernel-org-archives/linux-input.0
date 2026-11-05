Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896023;
	b=K9j5+aumxtL3GvPb7nDA+zlF/s/n+27JxOIyGcds/FagGVtbkWFEx+8vqVCOAVhgnDRp
	 na5+cEBghrOrWwyd6Xedgm07AHWiBa/p/oKRR9seo2yfyDCuCiKJofn1yjmJkhGayOgNx
	 45KJX8S/HYK/mQPahkLTKRfXpprruaUj9OXSGaT+Ylvazl7A9h1wQxrSuVCZK2T0VDPzz
	 aOK+5oeD3GPSIFMVtOfp44/8iMgvQtSCg6Eou6kJ81tU309afXsVkASrZRHkH6AXZASem
	 XxpwdjYLp6aO6D4VTPNVE9QTFR1jjnnU6sU8sV1mfl/Z8WhNRO6weS9DbntElYj+gSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
	b=h5wPYmJdu/HIBv+dfT7r0GtSrr8/2OxAYdF0hvh/58BczcQV+eyJEb7ZKDXpDLcbIsz4
	 8fH2bhMxLx569RsTkQDWWnIJuLZ/zVCtuVuwaEB4Z93fho+D3l4eyr+59hd8qEFx7q1qB
	 7IEdcjB7QmSbsGCy03kkWCFmpuy9kMPyScvLDLiGiYRS2J2jrTA49GXaQ3DTU/8ewQ56S
	 lKkKN4iAaa1NLIe+hRp5L2Cuz0NU0etO4HD2wHkYo6rLWJ8BqL7WLoC0vlvyRPnSlYTr9
	 rbxt7SelUVD2iUAMY4Q8ZksBtl8jV0VTFGQqEaLeKixzCN/sB6ja2Wc48eGeLwihH4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705A606A33D
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8705A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso754295e0c.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793896021; x=1794500821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=TH080M2b2W5GU83fC4bkAl8rc89cXnFJ2JUZ1DQM2E1G7nxV0uZ+iMHWJDX5M/hBR0
         v8Q4S1dZz9e+Wy709/pkQPJoJ382ui88GBuCa7YwB1Pwv+V08ySzbQGdCs4et9sFRxVX
         1a78LWa2r/qDmkC73yn92WJjnMydzWl2HaDmNekF7y5RHwsZB7YPGLTTr3xjjmuI4LbR
         sgpTrG1DSTm++FzIJZEq0knZSmQ9xxE9IezNyVfi/1ZtU95O+iPlQHI5LWAc3/YmXStT
         Vgy3IZE07Q/+XWoEa8k60w3BygO7yb8zhuyYBqBwOLPUaUevbalW8R2MAA5wjUpSFz6r
         zz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896021; x=1794500821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=Jg060zFCgsncLj/pM4PI8cdeaCIXYtNlSawL8o61m+Qf88dugUCKuLQ1Ey7ADXKuLk
         mmz5gLoR2rp11TpUsMY+ENDXDoS/mfSsYpAPwjn08at7e7s4Hyp+4++PXpW6e/uYs3IQ
         4S1JbLKsSpXoK1KRrAEvRv4/6wbtRBIuqD4cVoC+zx8vC/UUHu8+xISRyJ3VbqCKoX6Q
         hZjLyikLdzSdbQrbfK9q+448aPTPYGu55sCtlG6+TUHlfe2k4XqIQ/hxAX5cD/arU7Zt
         XmrdQ7i699sEoGMV2k147V/TON+tj9f/bS+PVDrdSNiqlG9GDi6VGUkZps47TwZZJc7Z
         Krwg==
X-Forwarded-Encrypted: i=1; AKwUvBzoyLVnraFEYEEEt+CoDfM7amyQ0gSH1t+CppGj05N2oOakh3DGVhwtwND8rWsehpo+m3vHlsDMLxCCLg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8adIr1XrOvZpS5ECOH1XX3HdUCxwNw59qwydKrAl6C/e4MAAFa
	W36ZjSrjsdBNUlwyh4NxoiyJuhcDJSsosC1sPDnmsBy4aaa5k9Fnp6K9hx2MGq+ysDo=
X-Gm-Gg: AYBFou2W0bvj0M0AzfyvPLSIc3Ec7oAUMIIBjqI67Z4GwttAHX+RiWdJZAZV/z13rM0
	oIdoo2VjDUBn0Hbak/joVfPeybxP7hgRDy0UIItXiZP2LnxaxoEDdC3Uv2A6i7uVytnr/H3lFjm
	jsrxal2Yk7wrw0KX6aVlDztzpeo/51Pz4/SHEwidNqGIU4Wcu1Mpel50tZUed7PY6gR9+kHwwus
	L2SlAP2BLdmYEiv0L3tpP2j7tIdOxZnnvUtBT7LrtFPXAzefpLyBrl92O4uE0lLT5CrEp2eiYtq
	4KnZ8u0IUpKSPgPcIPfG6SnUE/slmNa54/D36FTJgPXMLCTydesD2UYevUPxdUGIffcMzC0GkHE
	Qk7B4Bhjyv6JDEdytcs38MQRCsy5aIRg+Qu2slwqXUtkwb7+00NeRnQe3DJhUNVcNR/trMSZXzF
	0aV7r9VmFzMtr+7D4TZovAfcE8VxQvcYkbjU7Is6ygUil78hJoxYSepC/lUfIp7APNcXOXE0t8O
	sUF4+rMD8C6pLWtHroWWOqob3k4SVSyVhWOaiVCK20/zWZcYwsp2rlv0P3XswHKLCpYRdXhHDbN
	nT5keAjeVj1sKwfZghSfrzztJzjb8CCujaUREGOz7L3Bj2AWFP/fKu8BqncJpKeMb3gldfox81C
	c9j8iBifv3pe+JnZPsgsXeLQ83agBTlU=
X-Received: by 2002:a05:6102:3f9f:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d2a15715c3mr29296137.15.1793896021174;
        Thu, 05 Nov 2026 08:27:01 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm4667110137.11.2026.11.05.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:27:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0Il-000000032XP-37xT;
	Thu, 05 Nov 2026 12:26:59 -0400
Date: Thu, 5 Nov 2026 12:26:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>,
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
	iommu@lists.linux.dev
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261105162659.GB663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
 <20261105140352.GF3889730@ziepe.ca>
 <2026110558-tartar-juicy-036a@gregkh>
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
In-Reply-To: <2026110558-tartar-juicy-036a@gregkh>

On Thu, Nov 05, 2026 at 10:43:00AM -0500, Greg Kroah-Hartman wrote:

> > But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..
> 
> Yes, that is exactly what I am asking about.

It looks like that does the same basic idea of delaying driver binding
that this series does. Hopefully Leon can harmonize it to use the
shared trust level flag instead of a usb specific flag and retain all
the uABI around it.

But, even with this v1 the user can choose to use the generic trust
level and ignore the USB specific authorized and get the same
functional outcome.

> And I know there are other types of devices that will want to use this
> type of thing (i.e. SPDM seems to be spreading to other new bus types),
> so it's good to have and get right.

Yes, we are investing alot of time right now in trying to get SPDM
uAPI right when we bring the general framework into the
kernel. Everyone needing SPDM should be able to re-use it.

Jason
