Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887440;
	b=ESVrmCpxF9bZBC/aABWdNQsRHFpuGZPWLV5hyH/ornvBo9KO6rPtB/s5PuVNry9Y7n3+
	 AUWIlW/FyM5G+9rMqA8uDjcgEXREK4TwtwhIr3V0UPLP8fy+cDQGIwJV7ZpguV7kvys7t
	 +hpnaWbcxCTlhq8Gfe1BySy6xu23VEeAVpAHlnG9zDlHEgvOb/NlQagvW5B/Az73Nmd7Y
	 HFYmGr0xahimd8CvSgj9iVVkySCbti/Gkj/fCJq1+WBf4umR0xBpHCJlK0lFqwREr8YKx
	 SG/R8Hdgjr9bikUQVtyLNh5sXLzCTnfZL9dPfiZ6K64xhtmcXEdcP7bIn1h4SflEDeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
	b=13u9+6oISJYrtuBrrYy5GaLOmDOaQOZSNi0YU57fm9ZNgaCQXXbUZEI+WTt3B+VtqFa+
	 wghdTuWy5M9owXQfOEnL8vxrOypnuLBGFklMuF0nFAw/LZFB4T+UVqkSHWBvFj75cWoZJ
	 zarbB2MfvN6CqvBW2254ZMVAk45QIEgFcoH9jehA/8gHOzevpKKIhi4LilNOmWBbUWAmb
	 I2FPhOBGMfVxt12p/HseHcYNnOR3+yRl8wGlIbnVfSttTlpk6ZNtw/9o2X0NWHDVjMQab
	 XO7jtJrvCkyAllk3QVVOFCVFzMVKH/AWRco3YNztGMAmbxWfOi5kpUB5hkdqk3xBA5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60642606D80A
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 14:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60642606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-999b2b06bd7so683053241.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887434; x=1794492234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=kz1XgIBbrvBVV82jfLwzl2boDjAIVUbeNVQas9Wo1Dk5Xdi6H+C3KcpCevzEdclNJ0
         lzsSeS+uRFo6w/gIJIYGLA5nYX/ZA7GDEfg8ye+MEqBYoDAQ+XWmrXIScd3vjjxi3P0s
         TM9V8bmM9C1gt69mu+eIyGDX/aC+cI4xa87K7AUD6ZNwyr7bJjPSJ34eRy3oL+DhO4T4
         z9GIW8q+b2I5fYq6rzeAUUwY6D1cOnVfqLouPYFCQGVgJUGlc0n72Hhgr3e5/i+LRsW4
         Jqs+IOHbUmP6UlpI+ifiIR6Yqw/evL4R0NFbQH8ocPPe+5gcxWg4oty37gZrialLDEod
         LNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887434; x=1794492234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=xOkfbVvg+vUZF2hr/8DpQnBBU8MzV4DVSbkbaiyl5RNqp35/Ls/AMZImOxgR13uzZo
         uRdoSfNx0ud9MAV9L4+Elam3fWX0d2TODxYo9BbDptn7mPbA1venSWJF9OtkxncyjG2N
         w2XwDMwV78V2PUZ8+yzKzh9V0qI62r3I34DQwKLZdvzrDzoX14hqqtBbvmSkSvekYLW4
         e1Y34HMCJ793dfxGCpEYkrSdNGr92HkofJsxb7148ZDYfyylmaj6O24+PH8eaR0FqNYZ
         KF6iGLIHzswaEh30VLyDWyRojQ5NVw/8I2OLsbWoVaDngq2qQ5LbYYuLJzbqdvVudEEQ
         VadA==
X-Forwarded-Encrypted: i=1; AKwUvByNbjd6vSHw4K/nzV0RCvgVu1etpgofJvlj/H1S39dGsajaB37V99TbOmps9f9mRHzoTQ76EUG5Z0pNyQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9x5MrTHgyotEexOu07GPpVtZIIBsW0k5u+Go6E/Ws7XybMK79A
	ZRXGyrR6XcrtKWTVBelrypkymwNpwIrL2rR8Ry2vvZRSwXHEJuPrjfFPETzoxqNbdMw=
X-Gm-Gg: AYBFou3ST/ojnIkG2L6wEmnKBT6QS8eq1V/36a7s/jNt6Xc9/FeqfV7PDXeVkXxcUXi
	c49CklXoP/as7jjCyjBKyQc2In3CguxnkAw12UDefi8EwEiUAV/Q0VTNvzbVYr1WoysUmKSmC26
	YV0PoGGGC8a6cpGzB0hfe2qLj2Yxal2s7nrWNmcSxdDLRgkEoebJHZSlsd1Egie5+C5C6kUPO7A
	TRqrMgsLkd9aiyhI3M7tM7NPAEr4bs2cFYvTgwQwTkLgXHq5RjZqvEdAAB62Em3koXtvTFxik6k
	hXdAj/+htgJRRiT9T2cb6vCufhxmUR0EVnj+t1pWtYJfwSc4ZL4zFZZanIlMN/yCgzIY3P/P9po
	twsgzckuFRFYI+OPBQsWaMYLe1CtG1AfR0B029FulLu+2IDa/dngDKWdddRhlezejJjm9DMOcP0
	5IE0rj2S103H5v6nicMILYJthO0ekORfEuOTgLEkybKJpml4LpJbTLmKtXtlL4E2sBlKlAMmeYm
	Tsmwkc4ZU0Aw25JbUwIHgLYgf2KIUf9xXFa4S8E/Mp0zntBMjnBWedBNkND5BS0oeoyOJmMc34N
	UEGT6lCBEdBgOyet1+h+bjFC/jsBnnQ6kvkXFH2RQhXNDgolxjJGIdLgFu8WKAm8uDWU3QMUY3Y
	vcJpH0F3ZLg==
X-Received: by 2002:a05:6122:8f88:b0:5ea:cfd9:8fbd with SMTP id 71dfb90a1353d-5ec689b0f30mr9760208e0c.17.1793887433885;
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8de4908sm4235128e0c.15.2026.11.05.06.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy4G-00000002ecj-0pCb;
	Thu, 05 Nov 2026 10:03:52 -0400
Date: Thu, 5 Nov 2026 10:03:52 -0400
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
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261105140352.GF3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
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
In-Reply-To: <20261105131856.GA8298@unreal>

On Thu, Nov 05, 2026 at 03:18:56PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 08:12:51AM -0500, Greg Kroah-Hartman wrote:
> > On Thu, Nov 05, 2026 at 01:42:30PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Convert the PCI specific untrusted to use the common device trust
> > > level. Adversarial means the same thing untrusted does.
> > 
> > What about for USB?  Will that "move" to use this common trust level?
> > If not, I don't think it's very "common" :)
> 
> It supposed to work for all buses out-of-the box, at least this is the
> intention.

You mean DISABLED/FULL should work with this patch series on USB
right? Meaning the core code will not bind a USB driver when DISABLED?

I was wondering if some of the broader things we are doing on PCIe
also apply to USB, like device authentication. I don't know alot about
USB, but I got AI to help me find some relavent spec information.

 https://usb.org/authentication

This looks like the parallel to PCIe SPDM device authentication. I
would expect it to work broadly the same way as PCIe if anyone wanted
to implement it:

1) USB discovery discovers authentication support and creates an
   attestation subsystem device for it
2) The struct device starts up with trust = DISABLED
3) Userspace runs the crypto flow through attestation subsystem. This
   is extremely similar looking to PCIe SPDM:
    1. GET_DIGESTS -> device returns a hash for each certificate chain
       slot it has.
    2. GET_CERTIFICATE -> device returns its certificate chain, read
       in pieces.
    3. CHALLENGE (nonce) -> device returns CHALLENGE_AUTH: the chain
       hash, a salt, a hash of its descriptors, and a signature over the
       challenge and the response.
4) Userspace inspects the above and approves the device
5) trust = FULL, driver is probed.

But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..

Jason
