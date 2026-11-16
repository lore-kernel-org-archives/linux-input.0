Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840359;
	b=CMj3x1gEveyjDa2GndWarBcUVhUc3CglN//8itpODcxbl+FmH02exCzEzNWgLcCH42fK
	 nFa1hpdLxF29jwVaULviV8Gve8XyxIdqTzcdKBHRonEFVxXktKEjgYTMWstk6e6FGJd6A
	 K+b0I4qVz+ydIQl5AiYgSCKAWgkk5jOTffThGVhIrLiQDfYCFklGubRcoWfwh5C5m2SOU
	 udhwpGhgq5RZwWctDWs3YgLrocGTv2G0x80EqLtCi+fkBMSjNpC9pZ2AGcDGkYqSUZmyQ
	 xzxE1N4YWSVZfb7YYjY8PH1ZryL22KY9/8VTsZgAoHhyNBK8586BZspsjvNyyzpLNiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
	b=c7W3sCgj/oM0TDgih5CzuRTQxs2P/WUTFs4p05tcKVOY2nTsBClBT2h4VFjVeNOlXVbj
	 A4X01c5s1hasPBy4rdzZfkcQ25D2tDOMmBCj3u1wHMX4qdU3L5wmQQ4tqnVxEYcA9APtL
	 GmyqHHteu8GSEhIAfu+iXfVzfv+lsdOvO5oy2OBonJ4DaZ0tHwfLfdK5C2m3au1dwMaTT
	 ecIDMDNx2jyzHZci2sEvg5eHqWxqZAUg1sIXJhuSvBIDRJ40Pth52kPw7zpkhZDt8cuQc
	 h55EJ8uRmMoM+G8/ec6CfxIYbvDShKHonAMQgMRcwOeha/UXdCap0Du7RzuNeErGHmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dLdJyonb;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92037606A337
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92037606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dLdJyonb
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9496400270fso215429285a.1
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794840358; x=1795445158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=dLdJyonbx/GT9GciisxRrbnKJNPmXRO37SMr0DcL0fOWPt4npP7q6oSEFPRBxyhYBG
         VwQv88je59xwJGF1tzvO02VHIK2UoI2gFnHM+RoqxVUasg9DyQA32ToeKqV0tOS8H2/F
         utZ+RQHXMciPdHoqR96pmDBV9oFbAflIPtcSFhX2+r9dDE0rLhaGZCPsZ1j517doL9zB
         RpfAbapy98a71EK1akS809jjM1beUX7TmDUaCrtYNcz/JJbJ2sGjj2UfCKl0NoQ68uWW
         NnufbW7FWZvXAJBZh4GXQ7J60xB7eIn/T76+zn9Pq4vvTPBJTSoxoiKRgL0R3QgrjVbx
         3mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840358; x=1795445158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=NFfNx1HjJKVcYk7joF7ocXbQU7xw324skmpI1cgOWDU2quuBISCd9NUeL1p65LYA2i
         Q9bdumK0vDPB63Sa5aYALJDCqlJKX6qP0nIZqu9UN1hIT9Yhgu5cRkRrINK738VZAKkW
         NHW6NHiM6jKaus7VDNpljR4CbUQRgfTW1AkIcjyAFS19EobQGLddMD2o+T5D3ulFVbm+
         soLg1Y0Rvli/o+6uNaP4BCFvXDWAv1V/N1EQUlUZL6S9oz6b0K2FBnx+5bPe282FMBwk
         ZGlLeLx2As03PD2XTi9kd1kMpL8awxoniq0X20YegTins1ndvgZwsdLXHHQ3grrE1lav
         F3uQ==
X-Forwarded-Encrypted: i=1; AL+hErFudelFd5TcFApPjUrt0BgMKJ7jIrXStBE6hu94wKTq6V7qL9xR3uMps0QtfG7xHXBz9FUpqhvdn/Ij6w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/HhbaEHzxTjf3BJO4bc+TGliJ7dDm3nZ2PSOUcxf9pRuNOxGzd
	eFp4GWCJoWAUuMgKLK9md64eLJTAstJaejFZ6q98ffULvx/8PWlR3VrF4ahWM8jZMcY=
X-Gm-Gg: AYBFou2prswe7WrvJIWjNwEykKnnyHXIlEG1enceKNppZboTfxnlWuEdiZvh9noAS3h
	g+XdlKJVT0SvLpKIpuMRG9qGKnX6unC6n27vaETmNChAZO+JkRR+dykK1CKJ/CbCFCcuW1qflbw
	D5L5PShAMwuHxtMT/g7/bB40v5GnrXfanI8DyNRFCKL45jrvx7il4Iu+PrSZeCfuc4KAai5h3hg
	r4OP/O4LDlh4XQe3E02rum7D19oW8JVBp8LB52tLtM3Edf1+/imgImCndPg1IiwBCsZ9iLzlWpa
	TjrPqzo0r9X2TPC9eV8PmKHH/elxQiy8eeIfVkMEsHGlfBrA4QtolGVrqAWWUHFWuGSc8BcBWn0
	7HJlWmVD7zzVPq0HA2ezmQdhWkrzv2w6S5cMMVAzHouU6SdJ64t3ywekgYiILCoV2KQbOTapOCE
	EwPKwG8+ULjS6z2yrAUBfLNN4Bhzyo7iCHYgHFJ3ac7ixXMI0KPhlQekP0G5+6SPtXfFfRTTxaz
	Q5V3bVQzx5MiYQ1XwozQRVkN6piboxaToLmYtGDd6mMyWc+qKu4mOxKcMpUHxBWen8iu/7jbkAr
	G2SzRw==
X-Received: by 2002:a05:620a:a41a:20b0:949:5872:be1b with SMTP id af79cd13be357-9495872d3c0mr1015844485a.39.1794840357475;
        Mon, 16 Nov 2026 06:45:57 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836079sm858473985a.18.2026.11.16.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:45:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSxxz-00000009V73-1sJy;
	Mon, 16 Nov 2026 10:45:55 -0400
Date: Mon, 16 Nov 2026 10:45:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <20261116144555.GM2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <20261116144103.GU11319@unreal>
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
In-Reply-To: <20261116144103.GU11319@unreal>

On Mon, Nov 16, 2026 at 04:41:03PM +0200, Leon Romanovsky wrote:
> > I think it should only be for the duration of a bound driver?
> 
> For now, I decided to disallow state changes because the IOMMU may outlive the
> bound device. Unbinding does not fully reset the device, so we must quiesce it
> to ensure complete security.

When we refine the lifecycle for the iommu this issue should go away
too

Jason
