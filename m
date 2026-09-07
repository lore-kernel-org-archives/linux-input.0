Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148F3CC9E9
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816204; cv=none; b=tbh5fXKKlUShiMNVSQvdcKIBBl/w6Kmt40/ngaeOOoVDwA9fqCy8TxFaT2LucrboUedomk8DFJU2dDCbp1A2rQYUmm3Y29GuLuSZa+LWJgxPCDZVKOUfRo39QK3YZhbUffS6zzeH/iJnHrp97QR2YA/LWGLrFM/V6Osy+HaRl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816204; c=relaxed/simple;
	bh=Gzcz3Zkq6mIgF9nN+/RZpdn2G6QVcg2SErOL9iM3Lwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/cTtrO03d/LeH8Hx1Ums9GxXjKlsQDKvuhQHFLUm17YH8Z7nOuKUE9UGcc+wjjZCVSKqofKje1NjuSNn63yTTGZLonleZrMPHHjtYjcjC+p+IuuIfBAdzGkSVKtNCGUAF8RY1Q00ct1bswdmW1CJopSyowHsQ7MfEldc+1PLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB90dpFH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB90dpFH"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f96c5b722so2752879f8f.0
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788816201; x=1789421001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=;
        b=dB90dpFHKckqTrmJjkDD5EUcDaUVt1xE4+JqKWmDR3ffIvrgUgRi0TAZJOpGZIijr3
         r/gJhz7hTnDw0qeQtUWHPCJyMvEL5GJYheAVws5eMPQ+/xr0LhAuuMOsXifE3Ev3aN7p
         yr25BWL5Y0XVgpuO5hLdUZU7udToKuVTxl0DxeCYuTOPpeqADHaqXa4AOQLR1GKxqPPE
         mIaJEwlUqTmTEvBkpxsc/uOL8JUdoFiMsBzIKmjG2zLo2S04A396WnRs+D19swYmLDHr
         s9E/nQut36rJRvxtRVcaoXwRTSnjMNWeIQYjAE5zGTXq2mGfq/awfBiz04y+azvUSlL3
         Siag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816201; x=1789421001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=;
        b=OjBuhBgyXdDieOBZY0fDM38R5uI6Re5uKUp5jIrF1m7/DxNuPKjNZ7wa+ffFM9b6AQ
         BX5NSD7OdI87EvgB8n+9ujIUd6EZ4Ugl6z2Rrt3efnAPyeXXTsFKwrINfVYkd4YbS1hG
         IYV4FjUHxLUAL3YvpGK49T6zJqAy63lZ7diGXOV9LzH/3SKcmFzsGLod0YNF80dRTp78
         mmnI1/OM+goeMQ/mlno02tGF0QqBZ2xsczPB951tYtFp/866SgQPCEPOb/ZmGnSKSDb8
         J8cmUoOz8Zve6QiYLGWYa1LAytuYdz6uiG4SmZ912eSUXLcC1QfHC8hMXwF/njYFXjHe
         3FHg==
X-Forwarded-Encrypted: i=1; AKwUvBy7JyrR5sSB1wpeItI/Vy8HfnGHNdyqLPqR9hXtjYwHNpx8OFqEgt3zbnoIvF9FijrjlIrDMlIhrNTWzw==@vger.kernel.org
X-Gm-Message-State: AFuF++mtiwxdWYBijsnJnO/EK3T5dCML4p+f8/e4AUzo0oL6gxUEXLdS
	otXt/uLImdsgnBHw/EcPPSMw1ptA1kaI+1CfUhbCiqCL4u4TOgZTXjNp
X-Gm-Gg: AYBFou1Bhij4Jhz0cHLPDLHGGhxH0af5JsG56ybi4scDZexaX+dL6/vRurwlCHMX06u
	CXpG3rEJlYOMWv5wlbUJOZcfEIk3ijmDsV259o+J+EzR3MWHCBSsYUw2LBt73FkErRnl2PkX4eg
	jgoGyadQ4X+gV5ww2798P7YF6AJRH+8buy+YNaXWn8hW/IuuAVL29AmewGClyA6XM1dLffrOA9Y
	lZGjrKRbHRgCCMGHgDG4a/ftCEnJGn565E8dA6bwBAr/hwpC7EGnB6VKxe4li5hSSrBVBC8WBrY
	X/FE2c5K3suALYrzEzutfAPEa4v3MyniEXA6SEgRONJh9DD+bkpgL1sZx+rT4Xt+XtkRhdUVZA2
	HY5o0LKxGmbE1XcioMcEy5uem0oJspmqxi2Syicx6BEff/YdXVf3Y/HkbafNQi709Bpu3/bNjrS
	MMfbMrqESFDKzNJNJ50EH2Iy3d5++vwqyrqCEOPLDOLsoRF5jUWCyei5vJ3rgt1rWlRru6FbHjK
	mAO3qWs+yl47SlZAj0zGHpjZUclRKgA5VbhzvQp98tJmgov8G1eU2w/h+K0vdiE18n3vb5vWI96
	WZB3P0M7j7puQlIZnfB95FvvaVoBe/u58EwYn0e4JqMpfw0M3XC4nultrUp7KMJp8lUUKmj3/lg
	lZ182CxgyyPU=
X-Received: by 2002:a05:6000:4a0a:b0:484:3310:f39b with SMTP id ffacd0b85a97d-485872e05f9mr26354952f8f.28.1788816201067;
        Mon, 07 Sep 2026 14:23:21 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ac2b4cdsm29964718f8f.16.2026.09.07.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:23:20 -0700 (PDT)
Date: Mon, 7 Sep 2026 23:23:19 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <ap8rCQII9fASEosZ@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907091033-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> got all 3 patches now. it's a good start, thanks, but they need
> a bit more work, in particular addressing sashiko comments.
> I'd also prefer patch 1 to be split: moving code from pci to core
> is separate from ccw fixes.
> 
> Pls write or at least edit commit log messages yourself,
> after reviewing Documentation/process/coding-assistants.rst
> 

Thank you for the review and feedback. I'll work on a v2 now.

Karl
