Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835249;
	b=FFXfKU76wA1YV4kY45XDAJd9/Fa7fO3CWyh+jf+3biyy23u8TWc78CaFAEry96qFNj2v
	 Njqa1HIIg2/UHReef7vvWDE+g7JyMZem4H7OBOXUZ116SN08V3j95nFMrkTY0epSZFfxT
	 zL+CBWV+PFZTvCNIR8rO2rbXoZoBYqPUrI8cUtCA/kqQRjdxh9GhPn9WOEGcj1guDONS5
	 IbwDPrxwccL4jvUVxXr6VRttkmR8kTsbCcRXw+nd7+vBlRgMrhAmUs1AXZrNpeo6/A4m7
	 ocBNj0ruUu8V3bo22OlaJ1ZcT3ZJjwyoG5z03R8r0qQARDTgcaTvvVUejxMnZioJ24Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
	b=qHQtnsofJTEij0j0ykyzG9r547Hpv4VODFUYZlsPVPoPDk0oMU4+qrkpv4co05YjpR6J
	 2quvszrzn/7ynXDFr8Pvg0J/OMW3uVxj23Yg/woOJzcgNxhI5zLZ/eNly83JSppNgLjkk
	 +/cWyIaxj7Vi2lpfx/LRUdsn7hadj+txglLsFUGZMCWdzFArd9pYYSvFEQ5s0xEOU2oh4
	 DDK9tEF3idY20Y8QyOhR6rSnTtgUDZemQkv3jsVedaQqUsWS4XIbAF3dX8Pe+TXhcUml/
	 kxlqCQoavMyHwOZPukZyNMP3d2opydszWFApOrNRnhK2rIDpDEFlgrBSCYZtMG4rdug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F00eXo5h;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203C606A32F
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 13:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4203C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F00eXo5h
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91f1e3dd08cso13821756d6.3
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794835248; x=1795440048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
        b=F00eXo5hK7MhiGIzcy2xEZvXaOlU++0SsxWdg8F2eYgLj0IP/wqxNHSj70WYC1UCbD
         vmKPyn8zqLHpLHOvxkTPyXLn/laMAvSaSbXM05SN4tjv6Cx+GcVaR0GxUXpMgXzGykx3
         FokKvpAfMx6w/qg4Q5h79shuv6MexzGsY/vmut+9b8A8pQsaE0GfSqy0kYc2aGWEaEae
         3xYzyobXgBsc03sh3wdT6H/0kLtFYOlPUaVehm8clJUf4d9zj9Hfn5kvjyTiGQDD3sEC
         6wk4kHeXw7a4jDhfFMIm7aNEb1ZQhwAt5xztT2KrBS1HRA1ERCFKDcAKt5g1NH70HZ/q
         daJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835248; x=1795440048;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pW6Ljdl+VPjn0HqbJ5aXeG19kylCTPtUMbKY6fBA+PE=;
        b=neCrY9FBKtersgwo+WO0cwX/RkzBmyY8pl7T5IZ1rpDDr1ZJZbJJE71IVjP16Co6ZQ
         Z/1r2LXT2NSKfvhV95rHm2gSDjy8qNjZHNETcHgWnPRTTBl/kUlKISU2WPo0qnzHXyqA
         4YrtbBFFhmz5jXuOujAlXvGUP+6K5wVEAoG6OIFmjEMKXw+Oz6vzSzDAag2AwAfjZeOY
         Rxc4k+Xzf/xEKZu81IbH16ygtI7ROJTAb8sOawexnl2NlgB+toU2w5BYwg+aeiSJ+cex
         lWD6Zct6kwBWwC7+vkT64fgaW/K5cdbEqqx0YhIOGDBGfU1cQMIVuU9kN9HRWxtQ0CUg
         wdJw==
X-Forwarded-Encrypted: i=1; AL+hErEOoDrTKLgv+i/ICw03E2DM9dSr6JhjieCQhABjTQraJjk00d9SX5qm2b0XaMw+p6kcBxUv1N/d+/8/BQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/WGjx/3E7uR0kWvZM6AoVk46XmB44mnw1kvBbqdOvRdXLM5WA4
	WpLrSI+OGynDne4rdBeOHJMCR+TJcH+HQDYgU17F7psF4y/e0xMw7sF9gGK18SC58Ho=
X-Gm-Gg: AZFdTZcI6RXRHIXxdHCayPv8Ac0/S1XYZvDRMmz+8mP9K7n1HF7nzea1W5q4/rOTH7u
	ukAnr2kZPgMHz8cqz/+KJ6EKM185rlnnXNnUAPgjRPKRsSYSHLLFOsVb44LvVMnLkHFxyeKpXu/
	y83KXwIL0M/nU81lB29ksqaoN7W9FYRgE+rBT+EFw71Lt+TpcdC6LKm2i4kFIhnxq7Y/kXMD9+v
	VPD4exWxA1QtR+8JRnVPkgAahni/d0OlV6yVHAMPmC6qbIjMHGywT4doaA0QNg2G2fdtL1BSKlD
	+iihiRSSsfDqUeboKyjMqVyQoeEgcZNZpLvkYj+Uqqrht0qap1mIZtW43TmRghuqI+RWv7x0c+K
	jztyaQCMh0dTA0tSwC9N7hGHMWpXiZOKKON1AAywlq2v0bo6YIzeMncKmztr2EDIhUuCltC31gT
	CR/nNPJDnQxBW/MW/2S+/2rBBP1EkoecMHAVpN63TWPxVaIdh6Mqr+Uc5oI2g0//i3njMWkzZra
	WXk9CVRfgKbRa+zgbVtrPo3sL+Xv+D+i9zHcw9yq6sXIhLX9Y2i+PLJ08XkXwunRU3wFDxL43o4
	IzRl0Q==
X-Received: by 2002:ad4:5744:0:b0:91f:3230:2a4 with SMTP id 6a1803df08f44-91f32300351mr126741416d6.53.1794835247815;
        Mon, 16 Nov 2026 05:20:47 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm85758876d6.28.2026.11.16.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:20:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSwda-00000009KhK-1awf;
	Mon, 16 Nov 2026 09:20:46 -0400
Date: Mon, 16 Nov 2026 09:20:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116132046.GI2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
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
In-Reply-To: <yq5amrr8yldi.fsf@kernel.org>

On Mon, Nov 16, 2026 at 06:38:25PM +0530, Aneesh Kumar K.V wrote:
> > +static inline bool
> > +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> > +{
> > +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> > +
> > +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> > +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> > +}
> > +
> 
> Could you clarify how this series will work alongside device acceptance
> and private-memory access?
> 
> In particular, what should callers of device_cc_accepted() use under
> this model?

Who is calling device_cc_accepted? I thought we were keeping that
internal to the DMA PI?

> My understanding is that trust describes the operating
> policy, not TDISP acceptance or DMA access to private memory.

Right.

> Therefore,
> neither FULL nor ADVERSARY alone indicates whether a device can access
> private memory?

Right.

Once you turn on TDISP you effectively activate DMA, just like turning
on the IOMMU.

Userspace then gets to choose how the rest of the system behavess. You
can still run a strict viommu with an adversarial driver even if you
enabled TDISP and can DMA to all memory.

I don't know if many people would choose that combination, but it is
there.

> You also mention that once a trust level other than DISABLED is set, it
> cannot be changed during the device's lifetime. If a device initially
> operates in ADVERSARY mode and later attestation justifies FULL
> operation, is that transition intentionally unsupported for the existing
> device object? As documented, unbind/rebind and reset preserve the
> committed level.

I think it should only be for the duration of a bound driver?

> It would help to describe how the trust framework fits together with
> those separate mechanisms, including which pieces are left for follow-up
> series.

The main thing it brings is the pause to allow userspace to measure
the device and put it into RUN if it so chooses before any driver is
bound.

It doesn't change how any of the DMA or TDSIP flows work.

Jason
