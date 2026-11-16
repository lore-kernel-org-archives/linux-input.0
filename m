Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859754;
	b=AWl3etyofcAXi64sZ19POWqKmMS/zEagXwzZPUpLc+BFlQVFrgYZuTg4KzX89sMctN74
	 4wDugTXA023F/qJSjImwCUNXPPnkXqeEndtAJQvgWgmma5C+VCUDqnVxKl0HaMjVYcslG
	 W9hN0mC38gi7MNQJ914v7OB/SjlLPn832ruNio4bzOHmHaw/ZABxDGES8yxau5rFPJJUh
	 gnI97xl7chBax+/TMuNulX9UnrbuJs4iRGcZ8xALSw40f5ZQcKwK3K+8OCfpSP4dV/+c3
	 uNWotjyiFjdwb/uptMe8e20phMW3D+FPioxKG5KrAJz4SGw2hNWq8FkBibqhz3Xu0ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
	b=Fv71yHM/fpFpaXG9efRpybz8Kv71fVtQvr+uCac2tdjhfop40fpRvZY8leIl9KYNH7rX
	 12vEaLqKR7IhiN4x1aAgNkQi6MejixDbA//97I+LXJUdYA8LDv+JX/1oZj38b7lakrNaO
	 /ZRtriDT+hKg6Rurb30tbD7+0Mck2RkB+VW+7lerTbT3BLZZ7gPNCQz220IhIsK846iUJ
	 RKrbUWUpvv3TvZ4B0aOjb+QtkWgzrFAJc/Wgx2EsGX7TyQZ/aHhticUh4eqS6nJYZrMvm
	 OgnfT+wCpQ890gVMIm2/DWTm/5GESSbsjGp0b46xvaxoQWokMkvuEQNZ41yqQshqJ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbZUyxTk;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A9606A33A
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 20:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2A9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbZUyxTk
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-536717a4d83so40754561cf.2
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794859753; x=1795464553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=nbZUyxTk1xDDi9/JiN9In9kNH24m3xvR3W8MPaMB063K/nb6P74sDih4ebpP83k2np
         SjqTAYuPLCHW+FRVrjLKSTbDX5aM/IVbZZxu+ASYJ/ssH0gDFbMJvSJmLcdHAAsDSEL+
         FG47SOuU8PRulqvpOebFRdp+iKyncNtYeoKxWrzhMSjcb9i+1jD4cThvDUO+7PnMd3zc
         ImV7NXhI8pI4k1LW/eM2oLltJhXP6hUveoFekGEVH6+oWgooyZkYdcVCIAs0jW9hoXxW
         5IGbSHDAmwoeFMTug5VO+bv+VKknP1f2hoIrUsvWYeNqALAO8eTePO8ZOjSwRNnR3p0b
         L2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859753; x=1795464553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=LRv/S7H5yyC1LBL+V1XUl0DXoDPROs3qKWaLfYNEP87IA5gNcbSFPeAqruIFSG9o3a
         ObpsjR6SsX87uNOoea+zxGGpEi67SG8ahPDsn7OSMC64JLtDH8wvZ3AhbJljhO9gxYVj
         wajAaXa7iCn83GVYW4ypuRcYic9Lj7Wmd2SEn+uxnxI2BkraDhpXZwF5Ozuf5wleBugA
         OjInvdpiYF4fSvR3U2nZX9l69Xy8e+bBuOE2akuOX4veGUfgZHG/48UUYhqTRReYiLCl
         v9jdZxE5eCGM8yQIHnJ54N2c/NEsPpoHTfDuZSIplI0zEu/LMerV11WAOABtySFOwrza
         Fybg==
X-Forwarded-Encrypted: i=1; AL+hErGG1QeqUN/azM4UozytQKsfnrYHR2f0RkPAajQROKCoMNVkz7aLXiHzWW3PHLeDlNQgiEPtCW/DXcbETQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bjDTNesyAYw863En7jqEmCg0sIwvg9mOA/rBGbDI9NKsdRSEH
	qL7NGZe+nOhh5mP+G/oikxdR5Zb3M3ITbPHoYORMBi9GCYJ65nl//u+CJ+Z+Yu+XVok=
X-Gm-Gg: AYBFou1oI9rBGPFbpd/Ba0irgkFrHfQ7LZe8c1aoaiXoyou25/KBocBh//8zaTtfRpQ
	eak11xba6kH+zy1LgjDIvzobAn39WdLKOtoXZuXQOy+lVd9NdAUXiKyXHur0/phWNL6RspyooVu
	UweQwm8cMcIw+EChq7HoCld1zEUmUx399ovf6iar6cM5TVesh5puyZuA7CnQ0enFs0GN9+0Ok+4
	Li5hLIZCxc3kzoQDZIetJ8WQ4cbTSLD5NiLwVzkR5zOKFctDsc27hJnpUWl/JzuhxlHEFvRQLNB
	f5DXPjJP+XDR2uersdQ0rNzs/DD/3z7ml+cIvufX2AFNvLeOGV4cVvmOuWb5UZdv0LHrrIJ7Vgc
	K4xGJV3JuFNNNrFw5WIGkQap9ao+Bh+AVjAy7cnscuUYXB6fUDBPRoW/fpPg2KNTWj2ol+CW0Zi
	fMzPlmuApa48rFVBLB5JUiUDZaCBYrSMOuwYd1XnVEhkUm3C1b+aKtRPKN0Bgs87dOQk+K+O15y
	pziOfp0zTqnPriQSlr8hnRJrQyWm4h4rC0r0fl85u1Ji01ZU2+iDnq7VuwiOmm8X92IdFYEgJxF
	Cmrmng==
X-Received: by 2002:a05:622a:5144:b0:536:98da:f790 with SMTP id d75a77b69052e-55ac43909femr187873791cf.6.1794859753196;
        Mon, 16 Nov 2026 12:09:13 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d445d1sm92856046d6.8.2026.11.16.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:09:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT30p-0000000ANtb-30lh;
	Mon, 16 Nov 2026 16:09:11 -0400
Date: Mon, 16 Nov 2026 16:09:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261116200911.GA2473219@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
 <20261116190417.GD2299285@ziepe.ca>
 <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>
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
In-Reply-To: <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>

On Mon, Nov 16, 2026 at 11:24:17AM -0800, Kameron Carr wrote:
> >> My scenario is pci-hyperv in a confidential VM with a paravisor. The
> >> paravisor is inside the guest's trust boundary and owns TDISP. It locks,
> >> attests and accepts the device, then answers a VMBus query describing
> >> which BAR ranges are private and whether the device's DMA may target
> >> private memory. Before a driver can bind pci-hyperv has to:
> > 
> > Sounds like a user in such an environment just wouldn't use the trust
> > level mechanism at all.
> > 
> > What use do you see for enabling trust level but having all the
> > devices unattestable and accepted already?
> 
> Previous iterations of device trust used the trust level to make
> decisions around DMA bounce buffering, etc. Is that no longer the
> case?

It is not, this is now just about userspace attestation really.

> I am looking for good hook candidates. I was hoping that trust levels
> would end up directing DMA behavior, etc. but maybe I am
> misunderstanding the design direction for these trust levels.

I don't know, I broadly expect some flag in the struct device to
indicate that it can access private memory, but how and when hyper-v
could get involved to set that flag I don't know.

Jason
