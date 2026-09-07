Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44C421235
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820378; cv=none; b=l2jKy2voFnn23ZcMyPUqrDvaHu8QdYTTLuUc9ypRMeZLtsc9TxeJEh/IVgFEEgCT8+b7Zf/BFUfX/ZTo61B5e3fEjRUAw5IiOZi4F50zoQG/wJLzDhiX09FLhhboKkVCrtfeNsuyuax7IE+L7rmhtqhoWW+y2IHddIfdT1fph7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820378; c=relaxed/simple;
	bh=9RNlViBMP5gSfl6YGM7J6Ko4HkVsFl5+nPinarDZvEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blAdLGw2hXyT6hZXuV6Jem+L3UYt0bMeNCONp7YoTrb27XGeMM362lR61oyptZODAM82KVn5rO3ju1+WR9NJyR1H/YgedT3vrb9X4dBHKYj4S/2a+K0W9+mVQmmYg7CX9ELWyk67FDvS0sJr5oNZwJjyhfglYY96keYNWx7BE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWm14lAR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWm14lAR"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495590dde14so57178735e9.0
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788820374; x=1789425174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=;
        b=UWm14lARKYLQM+ND1gFensmfZyfXbYFhflN8KeZsSjpLigjKDh89DrUCkOrImEbPTF
         JR9nLfnLiSVriZSXzabdDDA6LPWs5IAaAHFEuhGIRkdC7nIPNTT+Gq6t+uqZ3dyoVBj5
         94mHUvmvPGJIPNcHogt1cYmeXsYkoQXixg/RxNUCa9rXuTjz8cr9Z6EhFnsC+71MFl8A
         xdE/vOWoJ1vcWYd5/BsQ4CSoyk5H+1FbJoBzdBmilX5EKX+7Ga8xpjJFqPxELpxUXMXs
         BwllPAFP2eVxdks/aBLXMO4h1e0Gioh6kbwG+YsZwMZZQO8wgyUJCI9S7FxqR/uAnthP
         Wqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788820374; x=1789425174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=;
        b=iZGsMFWwHiR58/+89XSAVGvutfQ38SqmRmd3wlpdEtNPj6SmXmEgWPsUPKP4cr3O3p
         wWGbOV3eZ9Cc9Soh3/GuwWjpMkPdRrwBY/+t6I0himx0ckLs59249CtYQ21wCWY0OQBD
         ngLDEcaiYaLQuFQQtHWYClj/C3WyBtxb0DM2x4omyjHCUEklsIV1bb0SEp3hvpKd1xJ5
         PZhXKc7YeHCxxAQNSsElRwTu+MfdlpgSSmCYeGlUiMFEqf4kb/OuCrqKANiEEI5Fjxz1
         VVww++2ukMxrnhL2R0/A6kAy178joZ6ue0iIxfZQE63eNSKJBLVtezqI1HnoYhGPzFH3
         3Bpg==
X-Forwarded-Encrypted: i=1; AKwUvBxN8RHP3cq82kng5JT9C1P40dkbawzz9Sg7imxy/cLygnVsCy5+UEVWUwM0m3tsnRDICHCKznvYf8dgtg==@vger.kernel.org
X-Gm-Message-State: AFuF++l1em4wPf4Og6gtd2e5t9jomN31q8H/vUegY3dmndHxMJOOEwCo
	dNRlYRzc4lSZIY2wK9Z8vT6tQY6gfeVQw1vjPTgVkrWXVpoE8XfJOA9I
X-Gm-Gg: AYBFou3bSFuGPMQWKZ4izfS82088uXbTlgfqlWIwKsB6GPhtY7XVUqNUrjDHmsn3R5V
	mPZjm1DrkD58ZKjF42khbMu5Xau60P3uQPyGIPusXZDN9WvForvDr5z90uCnBv21o7tS/6EVK/L
	PmygHLcpuJ5Pfe0eG4mYj1Z5300HkF3kYCoD3462fuSouGQrO05Rdxwz1oOnhmaYiqdP4z5bHfz
	CpZK+IZsqlyyjenvA2ln9Zg+fn+GzGiNLME6HdBlUyGYwyrixrArL81xaH7f+Oq7VB5ppJiCGlk
	rAjw8Gac09y2I8G5UDmpvF3Ln9YWaA8lHavaMh8Xck+8jl3Lr7lUh+TxGTfFbN9vSv60ERFPkjE
	+TEuAaNyY1v3exgzICXlj1J+4yPv4LtRxhP/J20R3GWy85k/iVBX4o1iQ8/H4CwjJr/sXC8OP1g
	dKlD0f0gjc1rB1l9X6vJVW5MifI0KgPLU16TfEo3hCVCwnItDvtCxXQVToZEnirIUmGe2reZL1+
	15E7gnhDJmgkG23hTCttvl2O8xVj14mteej11+hT/qgYS2dBpsZaYvpXtYdDz1Da83TndoHoWeN
	Ca/KaWwOII2PCw9c/oJE0wlr4jJzP8+RXW7cdcwsx4Sgr/lfOHubWvJG4f+VNw3q7xUDuF+jslA
	G
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr448618745e9.4.1788820374459;
        Mon, 07 Sep 2026 15:32:54 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce551bf7asm289518525e9.2.2026.09.07.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:32:53 -0700 (PDT)
Date: Tue, 8 Sep 2026 00:32:47 +0200
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
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <ap87JrBAxjbPe_jX@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
 <ap82pFlX8enNG0gZ@gmail.com>
 <20260907182153-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907182153-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 06:22:09PM +0100, Michael S. Tsirkin wrote:
> > 
> > "Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
> > gives now.
> > 
> 
> really? not what i see. in which version?

Since v7.3-rc1. Christian Brauner proposed the change here:

https://lore.kernel.org/r/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/

which became commit 816d9992d9ed

Thanks,
Karl
