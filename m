Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890796;
	b=bI+KfzppYDJ3ISVwFqP6m4jSfcnoDvtwi47/pZFhscqAYP1IE8HTjSn/oQRkjSElKiKx
	 Bn6FKXJ4ntFHQcOY/d8IQ6hpWy9ylvsWSfgCylsq7kHbpiQYt9t6oYlK5TOYQQlTz0YrR
	 8tm6zQoTXq6/pxtKPfM+C8LNyFgeJANc0L21FYnoCRxxPcmpF00mAgxcQFOF8L1cLSII0
	 dkfuJq3qxE7agFJ/xyWNrtGw4oLYJQF8LxOAwYfQtTrEERAqbOONOFantfCnN+qyCQUYj
	 u5fimMiwKTLbXYsDWAAC8rlWdY7b+BAEtSlhUkpQWlP6exUdgKO/03F3jpvdLk3jCUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
	b=IzNeIn+TyslCSUclJe+I+Azax/vN049rdnIrY1Opc+puJWAtCmk50ioFDnrieLW7Mn1J
	 FhNOJjxlFWS/drk93iXixcZYRp3KpeWKi9nZh6yvxfNqwMCGXNqxRpep2RhSbL8qAIF75
	 9MZ+9y4wr4kqQaSQ2miZNT5czg6++3021070dBrzucbo99+aZAuCLnT6RjG1JJm5KV5AB
	 IyW0FPLlD0y5nenm8sSWv7x3FbCX9pkFfK/awnH3P/Ri0p6LQtT/B//5nTH7cJOsLf9yQ
	 5Hen/QO87gG4wE52yMs8cnM2vgLxJmLMYlRQrnlB9SFMqoWfGrCMu1z2QsmXdd9cCRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bpBlGkKK;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED926606D802
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 14:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED926606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bpBlGkKK
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so637506e0c.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793890795; x=1794495595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=bpBlGkKKYmX68RAsE9EkcMc+aPwep+Jt4D7c/OZg3kVQeHpZyfmkntRrTHho6EP8wd
         Ydil1svNY3g9CpIhj2GHYQ7d434gL/SpPpSr+DXV/upiAZMCvC9nreTgfts3zuhMwCcm
         Qskdy4s4owr7KaU/9VifToG4uoaZc2rkAAcVF19z0f6dAbM64dHUzvDPxywg/TCQt9WF
         2ooxRy05KElc/DdqHagH2RzabKyRAsKGjv0e7Kqhd2EeSxnmqf8lncs0n6nLDm8+XKat
         ++mZs0G+SfgC2WTprHf/u2SbYhDe7xP1yG7Q6zYRZWtdxX3hRx/GELgc/Kk/Jaz7fcIZ
         8CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890795; x=1794495595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=Mymab2veigwQRwxS+d+uPStMmf30Gska/E/g+b/EqpQc9B8ougsgIqAOrN3ynAvGPz
         nv08BaPNsd3BDtSTQkEjepr0TFFwQ0pzDxQlsqZ5IYlMelVXX1Rl0QvTzFvHV9OxTzud
         YLNBgcAZ3yaphRZxBjUdI8MRoCF1egZ84rZ3M+UKudBf8SHvTx9aKRbe2NrEfMatU/pk
         bIk2t2kMZeHoao80DWjeHSR2LekiA/Xk5TFmxoN3zllWFv2MWu1fAUDqfQrGNFdohzBv
         XElz9Wv2f9tUg/MUz4DPKVE38tIGIcR9aSbS74asWBuGiGB5BjroUASNcczgcKdSxXEp
         Lm4A==
X-Forwarded-Encrypted: i=1; AKwUvByqJONxZutjE2gCbyvdOb9vZcRZQbc9qPkHC/D56ccMHsgMiTVIVHERhd4wwDtYj7byylWMkCU+r7sdSA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/vd1CEC88Mgb3bi50XcaDNwpN0DVQU8Sr/RROkFi4tkHA+36TD
	PIYIwlq5CyQDxOjGj9HveyQDy9ITr4Q8dfKxbHoImLT3XnWm8jz1wtyzKAzNVjJaM/M=
X-Gm-Gg: AYBFou0g9fcxt7dgXhktOJakr624fx0pL2FwjK/blZ1CMgM2bfC/M7h1OBcOgwhkGJt
	KVdemzy3KqGjfIBoQqPhoIQxTJucex7UGTWJKTSRqeUYTEKtomfQZbGds8qDHayz4vCK/rEJYGG
	agQnLeIDMaZWMN1NVfdbaDi4FhWd4IKcBthIxC//woXVboOFUOnj0gtUKQ6+HVyBjzQ0Vty/vNr
	CYwncOtNB9yMDVgPVbsarehCfqatCA8GdG9e9Rjhuz47RXDaMipC4NVEkzrkO31L5pCz2CXwl58
	1nHuX2TkzipZsVjVHDYiqImP6uW51tSN+FtyGqROyAMJ9c5eyr5xC29Jk/uxhkerTYp6IXVonKm
	S23IHaFW1/8XRfUcdUv4li0ZW9hfW2r+HIPS8n2NG28/n0ph7q60sE5tJbQ1gtOGXMONcyLMRyl
	m0EdE8LP2hMLFd+03Hn2bJUTPrPQe90VE5jLkIPtxEc7Db8QyIZsN0UpzbcrJiOatAF0JDbbRpb
	UJYoExsSFBazxeEPxzYSGK+Heq0N2JgS9Hv4GekkMNYzxnCfasbPz7NP2Q92cPJZKJPMPNEseJQ
	aN3R8Ev02wX3+85ejL0KvBLc8bNn3CVUOq89k0cz5XHUHBKiOUa6mWQCCpKQ5Htr8Bprgc5c7DC
	fMiFfJT4vnYg=
X-Received: by 2002:a05:6122:6c0a:b0:5d9:302a:8243 with SMTP id 71dfb90a1353d-5ecb429571cmr1423011e0c.12.1793890794801;
        Thu, 05 Nov 2026 06:59:54 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8df2a38sm4234612e0c.16.2026.11.05.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:59:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOywS-00000002o7b-2oaN;
	Thu, 05 Nov 2026 10:59:52 -0400
Date: Thu, 5 Nov 2026 10:59:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105145952.GA663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
 <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>
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
In-Reply-To: <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>

On Thu, Nov 05, 2026 at 03:43:53PM +0100, Andrew Lunn wrote:
> > Yup, and that's true even in the PCI TDISP case - there's a major amount of
> > "communication" and "configuration" involved in that. The principle which
> > should (hopefully) generalise is that a bus/host controller driver can
> > always interrogate its child device to perform whatever attestation and
> > general configuration is appropriate, but we won't hand off any _control_ of
> > that device to a specific device driver (nor enable potentially-impactful
> > bus-level features like DMA, interrupts, etc. if relevant) without the
> > requisite agreement between the bus code and the user.
> 
> Maybe it would be good to list subsystems which the bus driver can
> use, and cannot use.
> 
> You list interrupts as potentially being dangerous. What about reset
> controllers, GPIOs, regulators? At least in the embedded world, the
> bus driver might need to enable power, set a clock ticking, and take
> the device out of reset via a GPIO, before the device pops into
> existence and will enumerate on the bus.
>
> I don't see why interrupts are dangerous, which makes it hard for me
> to determine if GPIOs and clocks, and regulators are also dangerous?

IMHO we shouldn't try to over think this.

The overall point is to give the userspace a place to inject policy.

Bus drivers should try as hard as they can to contain their child
devices. Like PCIE should activate the iommu, disable ATS. USB should
limit the messages it exchanges, and so on.

When userspace accepts the bus driver it also accepts its containment
capability. So if it accepts one that uses gpio, etc then that's fine.

We are not the point of trying to describe what threat models various
kernel drivers can support. Userspace has to figure that out on their
own.

Jason
