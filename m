Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516788;
	b=fSsxSybObMT/EaSjSmSuPtrFGQPHkFJwnlQa90yQ2mQSR5v/K144jCjcjOm3E8scjA8N
	 JM4y004JaTN9QMA/8Yy9ECkQ1n0lZrSCmPY2aNRmbj8W8FCxiQ/wE6JHvqoqUO+pg7OkE
	 dd9seuOg/J6z8hkt6k49D7ja+EB2fkRGYxApESYcA3vNYFA0DN5Fa61Unhrqf5l8Sm4ed
	 QZcrX5L2K0d/zVp7Qos0nclDpq3xxbsBCM7mHWB5KakzFHG2YgrJ/q4T6bM4qUVPZVSZU
	 dnLGmnQRKt8579uWkGwqLeJLDR7h3GO9Pd+IzcGiKoU08xzNcUXvutKQqiLBh+ioE8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
	b=xuOsbcuRiPYkh0HddczBqteGcorV/5nzmeHuPZeyGMp2WDYIK2j9esP0QzeQ8zxZJto9
	 9oRnhhT+IiEUqr9dhgvJyNFirrxW/3QfqZbaMlmk3sC0a6Ym8oYnYSPBRaudEUI71NsL7
	 IFDfruyRI3O2m9nKRK0Lu6hUVGFzypYgK++UotZQ6ktO/D7T6/vppfRepJHvhmmsS249a
	 GwPx7LrKZrrFgxFNaDQeYeO6bRGsaYhx6imfVG9OSKfDK8PknyiRasBeyDQXxprsO7ESg
	 vjXG2Riq4O1Bp2iW4PmufyuGWunpmX2cCKsoppNRM6FLiWP2+J4ikqSFE+cln2ripTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KjiX7YWe;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C8606A326
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 10:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 228C8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KjiX7YWe
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso3655046f8f.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795516786; x=1796121586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=KjiX7YWeSkA9Dw0WA5xjWaOqnyEHCedD00sUzMhE3sKEAvQ2TPIHmIyS+enWPn9hqU
         UHnNtz+vsI9HdnLLJLRNEHpW3n0qDPjDGGb+MMmUEkY4+DtknEToZAEEAwd6ErlDRM4U
         sl6ks9V8P+KgBQBXge6XtIwqjU1IX32GeqDZpfsQ5053CJLA98ICyRMFUcjrF7GwSx6y
         mLBhDMnek6X1+TiwUBOkVQB80sS1Z2oue9zDTiR4H+wlMmpVb+6EJ+EZoBBfGsOtxa1G
         85CHt1w3B0RFKCYDolOV20zywTKINPHyMkeAAvRZwyufXjasNY7vVq1oJTMaEgpAJPJ9
         588Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516786; x=1796121586;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=CEsVBYwfHwhUiBpSrQes7ZrSCZ3aorK/DD0znAQvilJGLGMWvI8foEGSfCePfyb3gP
         GcP+gHunuQiw5JDUTuI9v/DbkjbuH2r9ik8gvajDJu/lgDyCXcd7F056kFeby8seGj5P
         krAsSQIj5A3Ko7qBR0Vmlf9uBbedUhFc2Hjl5yWNTfcmy5gBoSoJBRGeu7X4t2TLUwSn
         PGRsPqFfQNCoLXHOXb0aaEwS1smWjFLvYjxkPNsO2PYHKLeMYOZvuU16z41jGABq9MZp
         M4FM9Ja+phYUI0C2xz7vwT6C9uxjoyGl7YoO2rJtWxDRHFc6IKKn3tZT0Sn4mXr33o4d
         U1BQ==
X-Forwarded-Encrypted: i=1; AL+hErEOwLW2rzhDgWXnIr8n4Fdok2HJjA9E0R8aZ6fltrv46oPD005er7CRkOI10NY5LK7Mbdvk6O5HItmEvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/KLy9xyjNLGbt2yET1EHkapEN2f7uGnG+dmmP+qOjJSF0a62nL
	9mkSqpaX/8zfBM4Apd2mZPsDc8hxmgX3Gy0kIOEXJPGyiZZdVbdk3APzeMSaPqwuvY8=
X-Gm-Gg: AZFdTZdKDMP4qGQzxxMeAiVMUveSo1WlS+gbsd6lx5qA0teNm1h00QxRyJKrOUYM51J
	mOQPZaAgwGQSn3Y/YEM2IE3CSi4ALmVni0g+QpjMkF0JefS3UiAU5qz7EBma0bQZtLpJLFTV+ph
	egKUID4HdKL58WLZU23f/KJIBMKP2nNo6jZ/feQB6DWk2d5c0n6RcfnzVikx157TMQEF6VjEq5C
	tezyg61PLxIgDdSbuJTpIE/J7OvXqaZn5pTbTHL+0VxvROylUVaUGcvx5Qbkk0yK2bwq1BiwV6X
	RPEbZ9RG/gg0GJYTw1yvqyhbqvmj03B8HWEOiTZUOcxb3jk72LBiQvFEhUOwt+e4crN51vow2f6
	GID3SDvPwSmz9/85OlwUrAirUh3RgTaq5DHrVxGN/IRampFZ2q08Qt6Drwgf3lC1lVLSbip/Ehc
	82gcifA6jQ8JyxN/Y6VEbtToEVd4dgC3YrocS0ZDDZwwG2he03+wAhwK2qBwRUsB0TA9QpPJFub
	YgDj/X8w5bT0qnNYxYYndzP+hKbeQ4gUf4rGIEr5CFcSV0JpuqxBwbofk02Q1kGA+SMSFoCPPRW
	y78jOnhaWEV6Ei7bJEzINsYtLB/MDqIBFzdlWntWpMatrAD3+Pc0ViOXwe49w54MYuiG
X-Received: by 2002:a05:600c:64c8:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb8881d141mr281064655e9.26.1795516786433;
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Received: from ?IPV6:2001:a61:132b:a401:6cb8:7c28:11e1:499? ([2001:a61:132b:a401:6cb8:7c28:11e1:499])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm425218335e9.5.2026.11.24.02.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Message-ID: <65749362-927a-492d-8bff-573c277fe456@suse.com>
Date: Tue, 24 Nov 2026 11:39:40 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/33] Bluetooth: btusb: Fix MediaTek ISO claim locking
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Chris Lu <chris.lu@mediatek.com>, Mans Rullgard <mans@mansr.com>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
 Jeff Garzik <jeff@garzik.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Bart Van Assche <bvanassche@acm.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.11.26 10:43, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> MediaTek ISO claims are performed from HCI setup work outside USB probe.
> Locking only the interface does not protect the claim against teardown
> of the parent device. Unconditionally waiting for the parent lock can
> deadlock with disconnect while it drains the setup work.
Hi,

your patch raises a question. Can usb_claim_interface() ever be
used safely outside probe() without this kind of locking?
If the answer to that is negative, should the locking be integrated into
usbcore?

	Regards
		Oliver
