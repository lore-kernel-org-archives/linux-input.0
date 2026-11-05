Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887599;
	b=xYK6HLep4bHKMZAzEDxUCty/GPl6CbiCVwkAtu0JRyWhG1TE5IkHTu8EWzphATjm9DlK
	 o8Bz1bxy6kZXS4Rmlh1zCDxY+/viec76tepgpsTmyZ7j1xZcNIeUWFScf5Gssp2Kg81Zy
	 mgsqGGROo9PBfLJ/ZGJTVwsgLvllb5kXxsPLhPP6NkejaD/rjuoSmbr6v1RK1hyDp4GJA
	 55SH8pcHN6H4CJh97uohV77ATYfMz9zGb5teEwErcEaFR0g3HZT8ARseZv0DAduIwGg/a
	 xGd519mr/+ZgppEMbKQXmkxILVWuFghcsL5sCnHRI9VMer9kdM4kTsNZ3+gT+UQpLeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
	b=OZ+mVb/uRMhGoVTG6yudJO7IcBxCGH0XMN66aHHo8+AEBiEmXMskbYf9777Tjbgcmt7S
	 vYo0VJt7z0CEyYgqM7LUVilJv3Kf6bJDotbN8rg3VirYhkccRnSsvKz+JRs4V18GtW1s0
	 ZBddvwaO1RIounuDDzJ76bM5//3CQnoNotjhiFIp5WtQNDid97ZyGW0WI6qse8X+AcscC
	 4MkaxqUtTutNF7vboXNNt9+b5eg4py8qQp+57Fl3ehgIDDwYY8CJagN2skZsyheGLnKFP
	 wU0s2ft6PZ3l7iaaUOQjp4dkrGhjLzxMB8or/DiyFeKoa04S11PhaPqH3f1/yKSYz4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08858606A338
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08858606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9908c849564so508166241.3
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887593; x=1794492393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=RnR9WnLw6ZCMoaFK9OfD+Z3SyEdhvj+uf0rMG8hHCJ508GqyJ6ANwZoUk4+aGiOUw2
         /BkiFTe3GFbXdlDhgGNTyo1p8KbFcLTeuViDrXT0G8rPqBzVVo12Ao+p4Nr1qmRZcl61
         4eaArBRyBLbC70PWW9D8DSwCjUpFcwxnrtfrVG8awSc3G2DLBl7ue9/tyD5BZlfo0PwR
         zdxT7MPa5WtJxCqrk+LMM1B4PGIKPha9YDx2d3ZgVPNqHnLfPw9K0SbdoIeozyBU6kJV
         fXJaMOJT5b2NTv+4F4NS5Cw1swAwWPhfu1r6zxddYwAc/lzTbX1ed12Z3pRWm4FFq8m7
         OBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887593; x=1794492393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=0msYro00vyKaT3G/FVQEyE470fWNnOF0u0IWvv7vbvhlJeC+OliZNfTpGE4S4E6hxB
         TFOWyfOtQX97dNLhoZ3CwvtzRH35+x/fIDBS83kvrYLLhzSqcRR4yGvqwSA/3ezXDa7Z
         OK2RE/eDSvjLvwvA2sekgeUllifCfEHBEf+5m74Jrlvb4ebB8iAbOl5LQku/KjFb3+Zg
         qQGCEWVgmw9mH/BICAdzhOYBee8x2SmEbjDo7l5fzqvd0yv4d8v+y+DH2k9JA1Eak/k8
         Wm4U9cdhOYMvnNBLI+dZxn/NWmCJdggj3s8JOruahuL4q5KoKFv7JrV7viihcEDwySAx
         9Wxw==
X-Forwarded-Encrypted: i=1; AKwUvBxgJvkQSKrD6vgjLmo7noZba+722EYWJ4n9UDDwQtlDi4HD2YiFXnTjXAL3A3ffI6eFGrewUW5AirV7Eg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8k92QtpANurKIDHIdSwgeSyAwduvgwNovivTQLk9Vfd2hCBU0
	N4O2PMtUomYYHsGOB2U0K1u5MmQ07P4v/oAKvaEDbXL7IHgLUSTjbVOeZKCcV67Tu1I=
X-Gm-Gg: AYBFou3PXQL72kAq8DKV1NlFdx9K+RZJuZ+KFXkwcD3tQHpINBrR2PLi7HJgE+2Yhbi
	P/7n7GkFed39rzsGSi/3Etfgkkag2UZp/+9wdTSkgWbaGOmtfW/Fru3DZPZ5qb2s/RIM6gijLKM
	ZkLie3YECo5h+p7Wzj3r+SCCewUWICjjHoomkePHtOZw/BdbtP/fV15E3KoN+GbJC3XDRgu4WcK
	68lBPsWit1eS7yuYfGb7QEXIM/3FHdXoRQc0EtYHCPOlVUL1jtCW7pSZ92q2eL+Tk1J1mqed3fj
	/sZT0sfMALeW0TqyXVY3svdd8NHvLHIHVI5YGnvclkmhqpSUtESbqpmfd4q+gzylcuihgIvvaVI
	pKvXataog4nnIrqK//s1fijLuodbwz6czSvOZtNTzW+2YX/UqBzt8KXx6lX6Dz+MMDyyTEKPMFP
	NhXAMb6GlQJyn9NlcDsAB/ZFW8bJJNVH3sZigvPhQZYDqD9OXgmlCFVVkia+oiLrVNIGulZ2Gf9
	HZtjKIRh0Nim9PI1Rk7FVhiyu9pNqkql0r/ZDSzhfiMnBnOaxf0E2ygw/zcVpNm2l4sRdw4SxtB
	FZLsMnZXNK69Lgaob0OxGZANL92YWyl2zFGzUVmaxANZMQJdONpncXiEhNmJ5j31Uixhb47U/m2
	aiHk34NnJ4w==
X-Received: by 2002:a05:6122:4f9f:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ec68949c50mr9274698e0c.17.1793887592873;
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm4161881e0c.8.2026.11.05.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy6p-00000002ezu-00ao;
	Thu, 05 Nov 2026 10:06:31 -0400
Date: Thu, 5 Nov 2026 10:06:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105140630.GG3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
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
In-Reply-To: <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>

On Thu, Nov 05, 2026 at 01:59:20PM +0000, Robin Murphy wrote:
> Yup, and that's true even in the PCI TDISP case - there's a major amount of
> "communication" and "configuration" involved in that. The principle which
> should (hopefully) generalise is that a bus/host controller driver can
> always interrogate its child device to perform whatever attestation and
> general configuration is appropriate, but we won't hand off any _control_ of
> that device to a specific device driver (nor enable potentially-impactful
> bus-level features like DMA, interrupts, etc. if relevant) without the
> requisite agreement between the bus code and the user.

+1, I think that captures the idea very well.

Jason
