Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320737;
	b=v9vgiJkn5lEtRTm43BGnIC6YaTkFMBtr2p44B5lU6Eq5q2bc8eA+yS97gXtaKdAc07iS
	 2fVGTjQViiPzRHEJaZv5W0DyWnhyMJ3GenlIk17pC88nJXGI2zy6BG7zY3BoYEzxjMvYS
	 UHGPJFFkoU+/TckY9fVhy7/F6V8iM3vQjOz55whsNIa7NZkL7yQSmDWpG5BDK75cGL+uH
	 4LiLGJHZXvOmSjXFYZUlco4YATXFRAeNADNMDr0gg+0PnM7h4tD/Js6XM+fjVAOplFaXG
	 F+5X4sj4mHqc4DF2uX3rAgn3MoRsZXI++D9BAuDbFmCZ1TC+nJjHyUjj2C8NjNkNS+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lkAP1m7U86A6D3jq5FI3LtbBiJBALHf/XTrdqm7iRv0=;
	b=OI96iNG4jTrYQthJIqd3JBQekShCOJiBnlQ4hbNvkvagwgoykYbTJyRrTxyCK14J0l+l
	 TLIftAZd4UQFiRC4jT0U9PlnI85SKzrGi+o3OIEisHCly0cJgDbRj/KJ6cQ0xXZ+oQkM7
	 8g/R/oI5d5WhGUQBODGq4qGK1PQ27+xbVJkpScnPe/lGjx3CCEi1vC2PF2uS0pKXj3Xy+
	 WgPNZZXfplkLl79IvwA+3ydvtQJei4LLyqCKuCKsIMJ/bEjX+cwlcguyMO4eTUn+D+fTw
	 z4rgDKaumnlCDHAmhDIMOkpt9d0wZukMoAzuCSY1k3rmfFANpjwD2Ar8zloSypS568Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YHCNwWvx;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42B606A9BC
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 14:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA42B606A9BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YHCNwWvx
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ecdaf14beso20152206d6.3
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794320736; x=1794925536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lkAP1m7U86A6D3jq5FI3LtbBiJBALHf/XTrdqm7iRv0=;
        b=YHCNwWvxZ2i5OqHQ+YUqQLCC1rzv2GgovdQMVYEwKh33tRosyn7GSIJuDa41qmh/kW
         zi7LyeKhFQOPYEl+gUniDWgNdaawKzYRwoS7Dq0Cx9eafD18pzSWOBgk0COIE+DG118i
         S5bwR2UJTtx2uoqYAeHAyK/dxjo4bAnlVjVlKAp5uCve1qemG+leX9AgPW5FTMSGevza
         aK8L0rcHuwhC3z9DNrC7UjQwC0QG7d3DQfBuriogPZkFVd264tz+6Hml+iB06xl4HH1G
         y8/vRZyBHrGKwiKkupF3SKK0bECjiQV15fzHQ3Z56gBpctujXKC1iL8VZGRRSe6K9b4t
         6xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320736; x=1794925536;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkAP1m7U86A6D3jq5FI3LtbBiJBALHf/XTrdqm7iRv0=;
        b=aylDz2eLzfhO7wkZGuZn64Mj7qPdR75CXbUYT1c/eXDJ31riml6dol3JLgxr0Web4C
         iZnyGeXoaJ+/0l+jyt/qgTSrp5Eb96LhI2fxBgBL47qJC0z7QvGr3eOn4IupV/pyKb1t
         gFlSMuqDy79kLw8rCBR4Q1ihNBMtOSRfsF7teYi8DC/aXxBjh2/PaDEPNjqeVsVEFT9q
         fD4anQ1mUUPmIQlJBa8f79Of6XByrAaDQT9Aln0bHW/ZYVxJUefd/wg9hJDfSeBKX26L
         Qm4vr8Q3Ro0VBoxNwTrgR0rqBoZ1jvzki9l0Zkfxqkzm+aU/wNdTTBNv64Ba4Oiu9nJe
         2doA==
X-Forwarded-Encrypted: i=1; AL+hErGu2FS1rLj+6bdm5MBbUZ0rEFsY1VcgaMdwOqXlZ8xegRkAMkqBA+q7cXDIt/o5J4rAGWMtLQmw+/Pmbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+cqVQ4WZvRXf92MnVWI9FS08q1Jbe9VU+jxKQqeHJNzn7fjf5M
	mY4F110guLbWThrKiKlK46a+lW5HoqsQg/cArnISTfqgKyVhtbQ+P5SSi3JzXz0LAzA=
X-Gm-Gg: AYBFou3cMG6V4aHtNlZh+jt955b7tZJAlEwKAu8OOFoYC3WWnnDPE3zZaMeQ9CxQTou
	3qfKoxBXWMfI+ujaVmBjcmY8KYjkfLh0VLS9PmHQ4vlGweol0XFCp4zJGU2TUtyxDIIDCIpZ7wT
	B+PToCe0QJ7aPUGzET+OSZKhtaz2Y/HbjD5S7kx9LavWUXMZ5OFOmRYVqV+dnq7vVdOtRraocfL
	5tU7xrWdLxK0qOZQ8bagazEeC9PLOOOqGeINd2ocdjkqJGh/Up5S2odwzsTRhU5Cd2KVJ9U50L4
	B8bJtC8WwavRauJB1CAA1jU3DJu24dWdkt6buOjBshe0iHCKFcOTqy09Aj3lqzLkl3e2xgcsBMv
	Od5ImQlWG/864lDse4n6B6SoYBOskL1jNLfLukBB2A2iYmSsihDhSvQBQk8t1W1u5kNpyAob32g
	xt0sR2NAV8rKfYhl4Aun0Q/mH66WPENYx97PBieMatamEFfuFoYqm5V15lku3KCtB5jw1BRhN9M
	o42NHVcrI5yRo0F79tipKyDgm+yoW7XdIGS1BR2UsbKEBJ8hlqcn/yBaN9wdZo5q5/MSkJ9xwbR
	5CAvsZu/ppNpzaNw3GgfYpCikZrMxnceh/Bw6aWTGUDlqKzs9kNKIJ1ei8B1vgcRzuGu8rn/Tnd
	dICrMje5D/Mpd
X-Received: by 2002:a05:6214:5281:b0:91b:87cc:6d3e with SMTP id 6a1803df08f44-91eef628900mr47274136d6.1.1794320735682;
        Tue, 10 Nov 2026 06:25:35 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0501c1csm21854426d6.30.2026.11.10.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQmn0-00000005tbF-1WYc;
	Tue, 10 Nov 2026 10:25:34 -0400
Date: Tue, 10 Nov 2026 10:25:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261110142534.GY663069@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <d0999161-3b27-4c3b-9d66-1d117c4836fd@arm.com>
 <20261110122237.GG8635@unreal>
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
In-Reply-To: <20261110122237.GG8635@unreal>

On Tue, Nov 10, 2026 at 02:22:37PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 09, 2026 at 01:53:02PM +0000, Robin Murphy wrote:
> > On 09/11/2026 7:33 am, Leon Romanovsky wrote:
> > [...]
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index b486b8bbd1fcd..8be2a246d4903 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
> > >   static int iommu_get_default_domain_type(struct iommu_group *group,
> > >   					 int target_type)
> > >   {
> > > -	struct device *untrusted = NULL;
> > > +	struct device *restricted = NULL;
> > >   	struct group_device *gdev;
> > >   	int driver_type = 0;
> > > @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
> > >   		driver_type = iommu_get_def_domain_type(group, gdev->dev,
> > >   							driver_type);
> > > -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
> > > +		if (dev_is_pci(gdev->dev) &&
> > > +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
> > 
> > I think this should be the generic device_is_adversarial(gdev->dev) now - in
> > fact probably all the dev_is_pci()/to_pci_dev() stanzas aren't conceptually
> > PCI-specific, just an artefact of the current "untrusted" flag being so.
> 
> I wanted to do the same, but iommu_get_default_domain_type() may be called
> before the PCI device's trust level has been set. At that point, we are
> still in "disabled" mode, whereas device_is_adversarial() checks for
> "adversarial" mode.
> 
> The below is from AI, I asked to present me the path for that:
> --------------------------------------------------------------------------------
> For a newly discovered PCI device with an available IOMMU and a new IOMMU group:
> pci_scan_single_device()
>   pci_device_add()
>     device_add()
>       bus_notify(dev, BUS_NOTIFY_ADD_DEVICE)
>         blocking_notifier_call_chain()
>           notifier_call_chain()
>             iommu_bus_notifier()
>               iommu_probe_device(dev)
>                 __iommu_probe_device(dev, NULL)
>                   iommu_setup_default_domain(group, 0)
>                     iommu_get_default_domain_type(group, 0)
> 
> For a device whose initial policy is adversary, its state during that call is:
> dev->trust_policy          = DEVICE_TRUST_POLICY_ADVERSARY
> dev->trust_level           = DEVICE_TRUST_DISABLED
> dev->trust_committed_level = DEVICE_TRUST_DISABLED
> dev->driver               = NULL
> 
> device_is_adversarial(dev) = false
> 
> The active level changes later, during binding:
> really_probe()
>   device_trust_prepare()
>     __device_trust_prepare()
>       WRITE_ONCE(dev->trust_level, DEVICE_TRUST_ADVERSARY)
>   dev->bus->dma_configure()
>   call_driver_probe()

The ordering here is wrong, this is a consequence of splitting this
into different series. I don't think we need to fix it in this series,
but as a followup. For now I would aim to make 'no functional change'
and still follow the ACPI selection during default domain creation.

The long term goal is to detect that the trust level is disabled
during iommu_probe_device() (ie we are running in a secure booting
mode), attach the device to BLOCKED (which should be a NOP) and defer
allocating the default domain.

This would preserve the DRTM iommu & ATS blocked behavior through
until driver binding, giving userspace a chance to do an attestation,
turn on link ide and so on before exposing the system to DMA from the
device.

Once userspace sets the trust level and binds a driver then we can
allocate a default domain using the user set trust level and avoid the
above problem.

For the CC VM use case today there won't be a vIOMMU, and there is an
indepenent control for DMA ENABLE in the TSM driver so this doesn't
matter right now for CC.

Probably put this detail in the commit message

Jason
