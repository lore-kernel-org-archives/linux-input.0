Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898126;
	b=bvuvRc1MBDD2DsnF9ebVWOp8rlb95VExvhzDOrJYHNA9RGJvBB1w2lVj0iT92gLNkZXf
	 rL7k158aTvAzMFTOWaEQHan5qN9MWDuXP6ih3Un3oOlZUOEFwzd1SsL/GG99NUTsXfE85
	 jDw/+5tDIDykY8aGyVwMcUajs4QJ2TKF6M+Ob5Z3oGdjM7V69LBAhrDPmIsCeuX73zFRL
	 HzoBqP+1tMXQ6lzPQeVgdnVoPaqmw6JQlvLT7JiYm8MNMQwsKaJT8DmTOOaT8slVw/Wd5
	 5Zu2ol3r1X0d63z9dXR5gnKW5VbBcW76+eXlZBi2PH9uHtRxTIB1+GFr9yN9JnM/yvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
	b=L4DbdlxtcI5xvvuJD7XNu3VpPeeKH1CWwI6Lfnu0jrSiYSemsA/eN86CCli92IJ1XgWW
	 kva2KBwg0iWT2WwiBFkIUPf6+mSPbgH6ihONc+8QQi2iiOzaUXa6nOf05KgIVSAlARUPW
	 f12WfN6FaGWbkMti8HMheGU7zJkEkH8vCCU+j7xKpI+hYURnbxBBUUpQcx6HvcAb5VAUy
	 gh7VZDZpfLWHA7c9kXEynJkLG4HesrYJD13Tvz4xlgEfG95PFMQ2aeAFJSafIFVKOjXwR
	 cfv2G+bPgZ3McuNh0W+uGgmj2Pr+1alPNMM2vi4gXLPXmDJyRSNiyQsI6suxsp5BCQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="UT/D8aSt";
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01F606D816
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 17:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A01F606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UT/D8aSt
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso1351514137.2
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793898125; x=1794502925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=UT/D8aStYb7dPEp/Z1PTR1znD76pBm0Z1nPlORuFlgDbzwSX/aHEaMIKgxREgduhMs
         7b184i+9WuyWU3kP4ECdvxL5tqJCBp+sE58xftFr07RVMuYSe2D0AHX1L8wkHJuC4lcP
         6d7IEtulMVc64pTkfBc/dFTnsuyCXdHVpF//V/K2Xgp9mPmSNI4/p7tLi2H5V42yljeY
         GtO1ChQ2JjqDeaKC4B9biWxL+z3aUuPX/f+FWBrD4U/FW4Q80YjAWhMK/Up13oskn2O3
         3V6ObKXKjzYpPS1tL8mHYVexmV3sD/kfJUj7ToJWfvaytzTBimAL6fO0bssiuf+AQf9l
         4B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898125; x=1794502925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=lc1+O5njtXx3l1ybDYsfOBb/7tCra+tqPmMsWNktvbPcFp50w3sDWPYFL48GyDl23g
         NV9+TkREsiZOOZR5UCpYodIEZLsl0nQI18HEqw0lXgGD/nAKliYD/c932nyOmzVPKlGr
         LDxFAW8MRKBfrxG4JQU/Vz/cWTjMKx1b8zyzPlo2W7Frijtt++lryzHpD0kBdrM/T4ZC
         9QbQOVjTGPKSX/yX+pDL+lkdeNYcsHPhNwHRUvCIxEvrNHucZ25XHfWOKmnM11yIuXN0
         dDmM/w8T3Op/rSW6YtR0CBSz3PHdwJNcRGxqNG+jG4bFzi4ujYsvWqb7FXnUmVwsmQg/
         g5IA==
X-Forwarded-Encrypted: i=1; AKwUvBzdEgUAzn5cwyJBc2q36DWQM2wOc1z0ODKLMebHRAsM9sLNcxksOaI6+YxSNZsmXtDQClr1AE9c2m4dIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/i+Ri9oZ5DJk78F7a0+z4MIuVMbDz7ClTy3K7bP3ZksYNvzqRF
	SI89kST2jB3OhHQ7f8/30uvrc9kIUFb1cDdol5ymnmTNkc/Tj8+HB65hLnLb8AnJ6ek=
X-Gm-Gg: AYBFou2cmxLD8pVeQwJKJxgOkM7cHRj2Zn4Gl763Zij54c91I7HvpZMrJAuaUR0OUEn
	bzwlyoTG5HUlO1or3XyMtzdLNNmMvWAi5mR1E43ReLa7yJ5FEg7/wa+Y8G6bPU2Jzcf3/QMFgE5
	ipnPvcwYBwPB+I/V95cAK9xPkY1sRUYinFW9ud7Y4XRb2KtlJE3jUAzkN1HebV7q+Vkfz79mlFH
	UhD4m/JtIWDfwPKHF/Iu5Pn0JqzXeJxipXsjP0HV3u/1m/DuzYb4ONGboLQvUbeBvISTiEC6uxI
	KSU+v+4YqMN/XjqnkBPhX5nI1QpxKxD3gxry7XYAvneOzR2VlVQCeq8hQfItqaBp+PZbRXO2yXM
	R1F9fo2pZFjz1GBXZYoTYuw/JFVM1BZE51/JV659vsbAx68lf+A/f/EtBhtMeriO8B5hfmDpjkI
	VMOt/oanfcst6WWs6gBKafbORXxCzHkaXSU8H1G4MmhRvl8pUfGSeEY1lo9j4wF2vledF2/fVX3
	6Mbgsm2rgKHc88M9pWYd9CEQI4tPHar2NJZuR7ycY2GbCJXu7hHmKXKbCn4/7R8A2MaweaXWRew
	Ymmt0LfAa8ykDV4D2s46+xiNVh0jW7L98HFZKebwgQsesAlZzu6OgcY4KpiuBF3Y5TqeYa8XahU
	9FqSOiKpPfrmCIIK1e53B43PG0hHOVhg=
X-Received: by 2002:a05:6102:2c1b:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7d2a16c7f35mr120203137.33.1793898124846;
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm4619225137.3.2026.11.05.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0qh-0000000388I-28Zd;
	Thu, 05 Nov 2026 13:02:03 -0400
Date: Thu, 5 Nov 2026 13:02:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
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
	iommu@lists.linux.dev
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105170203.GC663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:23PM +0200, Leon Romanovsky wrote:
> +		(RW) The requested trust policy for the device. The initial
> +		value may be selected by the bus before the device is
> +		registered; otherwise it is "default". The policy is resolved
> +		to an active trust level before the device is probed.
> +
> +		The values are "default", "disabled", "adversary", and
> +		"full". "default" lets the bus select the active trust level.
> +		"disabled" prevents a functional driver from binding.

For making this more general:

"disabled" prevents a driver from binding and informs the kernel to
provide containment of the device. For example a PCIe device should be
unable to DMA to memory.

> +		"adversary" requests operation with the restrictions that the
> +		bus and DMA layers can enforce for a potentially malicious
> +		device; it does not isolate DMA by itself. "full" requests
> +		normal operation.


"adversary" informs the kernel that the userspace wants to opt into
any security defenses the kernel may have to restrict and further
validate interactions with the device. This may have a performance or
functional cost compared to "full". As an example the DMA API and
IOMMU layers will avoid exposing unrelated nearby memory to the device
during DMA.

> +		Successful resolution to an allowed level commits policy
> +		and operating level before driver or DMA setup. Both remain

"before driver startup"

> +		fixed for the device object's lifetime, including through
> +		failed or deferred probes, unbind, reset, and driver reload.
> +		Later binds must resolve to the same level, including when
> +		the policy is "default". A resolver error or disabled result
> +		before commitment leaves the policy's writability unchanged.

Not sure what "resolver error" is.

Jason
