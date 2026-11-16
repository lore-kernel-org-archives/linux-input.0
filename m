Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844785;
	b=QZ3beqYNDZodyJpZxq1FpAIOMJxEPY7tc6hye54D+XC/ml3l1LhvX8p4yXUOcbJRqnoK
	 j0afa9tiYjZCbWeeW90v4UwZN5pck/qcj4gn+47bCIrvuFbpFLiTsKuEwfwH8RAAYp4d5
	 icLJmca8hDOvljctO34LrKX4840LIo1FtFOat7wXNkGIJhYP8LOMB31WQJXkOzltmhZPW
	 xrTbD4KNbrlvNnoVR9kk4lnp/JicQFHa4gjjrvIvlGqT2YTVl19pdRa1ezW7OpH4p1Aol
	 2y90gPNkVoDihXkOmnD286aRYuzNHT513+OWGJaGzwSMEL/LMvKyDsVbquA1pGEFeRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
	b=MqfOZqfl1qjaVjWXtFUYbRQcGGrDRQzNPJJO8zgOfzQgYYEXXvk+KvMf/nNeeIhXt/nH
	 p5xA9y1vhNvmFN1ZPYa5XUJEIfkSL8BTS0f23kyqonqL2PgWFsjDtKPIpcwSzY4TJOZqP
	 YH951HGxU4cQrTl71X7Z9gPjNaXJ7byA5Q6d7kHYet0EJI/QLu2xyPXyT0dpTKMZjPteU
	 mQYb+/782drwOUISUvJj7ZXSsXuBKSXnTsM+OJPESZBLxfwetmWEj6vqj/kPMw1L949tQ
	 7318eYxROUHstSDJbNWfka5KR3YGJBkOwmobeUAjch0WfVabpjnoYFbbEK85HvYPk/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="T4EaFVj/";
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4141606A329
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 15:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4141606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=T4EaFVj/
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91eb3fea2a9so42080346d6.3
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794844784; x=1795449584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=T4EaFVj/Db2Oh0QQIN6fEsneaLWasSmYdaomNevHcWQV9XfC0eku9uiWRA8yiTc/gq
         beN2zhlEBUDpPwvlJXNnJXYG7SLeGP2RUl/CIxz8vHb+CRPGvwOGP84P37zc/ASqwdCv
         a2ZImH/j9PEIljcRTrH9YjQx1m9XzvHX9w4v1GGAYhpr16oDLUf0JwGEJPe+tOCosZjE
         d53ULE5uBklWCIuWvycUfx9hIvJ8w6anXEcNacgC3MbLl4k/Apkhq6kLpk0rmKpAkcTv
         Trqjo9GQ8ASe6EH/m27mrq6sK/GeD3Uc4wVkpatMXBaBSojYeEkRpq+DgrGx3awVmJv/
         hg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844784; x=1795449584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=rjmdIW6mRnMlMoqpOMd+g4aMh1RJPmXfvbvZqFvBapWOv2geBjzgZiTHrzcGuq4Cme
         4dgS7P+fPzA7VmYY9mqBGQBRVdxoPS1EHFk4thTj/Xncp6gdgR3YEKJtF5s+2woEW89g
         fANZc1CLrS8OaO8LBsZ//MV0cd6IE5jYgNgRCPMcuafYcdPqauY77op0fkkZoRtLqR7L
         p6bPCv9SKaMLVAXqCYX/M8bQxRZmqh0vL5dVM7CZQgqAJuSRbijwdTWke8UeULvN/m8V
         BhZgbf6Nc5TSkP7/j+kcLCiwEwR+ZHZC7jCZlw8VDSs7umoOuSAmf0TvQxeVLEs/Lip4
         +wow==
X-Forwarded-Encrypted: i=1; AL+hErHHquRY3g7sksUIT56b1+sqUO+SAqP3GBXKbjausePc5KgDdYAK1jnhwB+z7CvNvUfh1dBFHULUJGPMqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1wPvMb5vWeW7IWRnzd4P890t9D8diz8pIyPvv8shLOwylEGtZ
	n0T0PkKo7MuT3Glcf9FLpTK0BbaCghLqNJr/OVsM0EqKjUXlbscW9H+MPShyqO5waok=
X-Gm-Gg: AZFdTZcRmfe6BH/wQ08AkyZxQOsQVqLNd5WUXByibP/OfIyTxoQqeg59zZp7CaKlUlq
	YtjWe4iKlLOFRjrSJqb0NizdgDObnX6c7PEL59d6fDHAzK4Bnyh/x/QJMmTTJQvMXKjBf5ZgZbR
	WwUM1Uki5/LY0zXd26eMFW8YvmdA/ud2ZVp2w+DsyxX7g3TeWxt1jXB4oDl127vmt4hMOlhVuEu
	uCstGD/VK2z1TbIyPrdsrGPIDC0gRMzvbVES2kGKmXzj4Ail2Dvmaypov1odn9bgRXfrAGN5m3h
	1FeFberuryWytld43/uVIsrbUhKIZUGtsOtqfeC3DdqgebaiTok4g3Ck0x0XOd1TxqUoAjzbQny
	Hv3tCaT7KWQbRYujZ/eMLdy5IKJHeugwvkXKgfVQsQz0BW+LBR5XEgAjmQspd5sSVtgo5dtMtJo
	9Lv8mVOmDLzWuUn10gZpuAuMdrAHhQapUFh7YANj17r5/4FYrdclyuppIfRcfRoCe2vYMK8itjA
	bw4Qw7KeUft+UoIKlCK1OJ/RGNnt7SgQMNguF2rzlwzNo+KvhHNIQZB+s1BMf1dioaB4yK3LUU7
	6Th6cw==
X-Received: by 2002:a05:6214:2467:b0:91c:7f1f:2c9e with SMTP id 6a1803df08f44-91f24209db6mr171122396d6.55.1794844783992;
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d93f10sm87735096d6.30.2026.11.16.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSz7O-00000009eOI-3Mx3;
	Mon, 16 Nov 2026 11:59:42 -0400
Date: Mon, 16 Nov 2026 11:59:42 -0400
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
Message-ID: <20261116155942.GA2299285@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <yq5aa4n8ydsk.fsf@kernel.org>
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
In-Reply-To: <yq5aa4n8ydsk.fsf@kernel.org>

On Mon, Nov 16, 2026 at 09:22:11PM +0530, Aneesh Kumar K.V wrote:
> > Once you turn on TDISP you effectively activate DMA, just like turning
> > on the IOMMU.
> 
> We considered two options for doing this:
> 
> 1. Via the ->accept() callback in pci_tsm_ops.
> 2. Via pci_dma_configure(), based on a combination of device trust and device acceptance.
> 
> If I understand correctly, you are suggesting that we stick with the
> former?

It should still be done in #2, just with nothing to do with device
trust.

You can't run a TDISP run device at all if DMA_ENABLE is not done,
there is no half step here so it has nothing to do with device trust.

Jason
