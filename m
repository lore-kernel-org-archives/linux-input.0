Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255D2288D5
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677000; cv=none; b=bWGcTyhep9/Cc26BU0AbLyKI1gFrkmbpUatd8nTw4BYTUaLj0yIabr3wy4eFfOLKypsnREuIxjAfRdHOyQON6YbTwYfneaZU3ln8XvuabL5FMchhokaxsSw2+rmoUM6xh4aoqDocR514Ayy5cnUweXIRThDbsaQm+w+OFhS73Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677000; c=relaxed/simple;
	bh=aeVqNouzSdYIpv4jAsF0eK1ZF0yh+/lKYMq2kFn1TlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMjl3HlpwcVEqfv6Zw+P/gFHklPOHGMh3ExzDQmya4dVaiqDEmdlTmb1Br/+1Cmy+vIXJ+GAWvjqZUzjytS1sAzbdPpeKIZ+KEGCDc0hyqXzQMAJ5iueuV+OpTf4iBin4AMEmxupa+Ijy6Ix5GD1kZ1Un0VvhVDxb1G2MnBLMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONy6hOgE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e76uvMN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONy6hOgE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e76uvMN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788676996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=;
	b=ONy6hOgE3huIey7MJOO14ivtvBR27U/OLdppJqZ7sSIgQNQ4NJcx+EspRZebuQLk09rrzE
	mPCmmNXbsoH80/hDo0zDKrejgIKvniBW+0/dAqGP4As/q5D32Dyx2x3S9Y1rWtmdQaIL0e
	IU2Tr1gw3ggLY3GR8O9DTScrbNfuGrU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-2MW5zfNNPNelA06_8EFiTg-1; Sun, 06 Sep 2026 02:43:15 -0400
X-MC-Unique: 2MW5zfNNPNelA06_8EFiTg-1
X-Mimecast-MFC-AGG-ID: 2MW5zfNNPNelA06_8EFiTg_1788676994
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48439ef42d8so1988579f8f.2
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788676994; x=1789281794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=;
        b=e76uvMN/r/dP7T8o9AgGkgX07dH/nOKOpM+MLklyO+yHm3k1xaGuvt03Jp5Hpk75hy
         0EsAk2DVMruJNBn/7QtAAQtdgNDwrT20+L92Sf7BuPmxV1lemgt8OduLrGbXzgFZ1C0z
         //BlS6m05TEnfIbUMQJv3YWfnYV3VD7TeTx851XUvgxvjC6iMmnqgTlWXMjW7j+I8wCH
         tYL18eoNb7XMF7jN2x33buzCxshD5oEIwYlJ+wWrdc2kgHr1R/R1EkBcy0qLBPrHNu5y
         zIo5bemiwXNxreBKKyJwPnI3qPtVMB1uJ+rxjBcyx/yzWYEtswyfDVeOdSHjkVx+kt/u
         G0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788676994; x=1789281794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=;
        b=LNXeCQZR9hbBJLBwKZu+U8ndZ0dr5PWLJN/ucrmLxgWsFRwR3HUdO4jlzZGK4ozteT
         xs3G2GR0J3ikqOsZ8svioSoWeKcQxEQdMrW/bBxHaVZPE1xgbPYmwsHQ4AqFNyScRmSH
         fFS0fWH1NWkADjVYCsxLSWJ9HMZ/IrlFd4zYiNzq/VmLOz05tG9Rc2SQSBvxGIuzQWlm
         84cLdxoEXxEfMRM5zSWC8wEhzffSpHR1VsXq0JePgVWBM/UlwERUMtLi1bTg3iAuJRb0
         IAwowTy1DKYrHGEGkx5MhHm9wrCFq0KQwKCe9TqNxFGvmGy4EQ5l4Xk6JafZNZ2CDPpF
         /H/A==
X-Forwarded-Encrypted: i=1; AKwUvByv7rTy7R9Ci4W6BIaRk2LzlSX0GvihLOn/Uu6mZFwteY2c5knH/yzqK3FbulntrgZFeNDb5i41kcln6A==@vger.kernel.org
X-Gm-Message-State: AFuF++lyRvmOngkEKWt7nHAvCPquVyOfsl0VobByBowAuep6k6VIIasO
	CAeDWexHdda5oBeu3m/g+sed7sFsgzZ38J4xS6FGh9CTOClLaaB+1bnQVf4wiSp9S/dZM/Ctzrq
	qMTJAf0cd2vqobN+XUkyylBx+lJCQ2JLV4ehP9Nz7NBPLPKDjEHDkWKY9eI8xXz8u
X-Gm-Gg: AYBFou1VrbM3FKsfwufV4DOs+Nd+xdbVsIX07rPT0wirG61j75WIzov0ThaqFSWbNtn
	5SK5VDRKeiUfn1WMrIAC1lW4PCNRzdzaRIZ3HfE/tyB/1KH7rc3/BrSxvCiRE6r9Bq37Mme+p2O
	0FEbhT/ivIm++fauOGU1/SlrTDL1BbCgUMlDPonMitCGF6tE7XFCHrFHhs+LDEJPIrIBhAJsPOo
	PlD0Zaj0Dwr7BYRmIodr4j0kzJmgtrq/w0pJpWXxyvyetRIHboNr+svlxJn8Rruq3rFtuGvgFSY
	09Ldq0e6S3GwsCQ7zR1YNR2kuKfI7FPi9fjoukMO7NXDZtJ6i2epjbTS4FUL4r/oWZpVyAezu3A
	dtD+qi3Ycsd3jOgStpsI++FI=
X-Received: by 2002:a05:600c:3b18:b0:49c:fa21:1c8a with SMTP id 5b1f17b1804b1-49cfa211d97mr123999795e9.31.1788676994379;
        Sat, 05 Sep 2026 23:43:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3b18:b0:49c:fa21:1c8a with SMTP id 5b1f17b1804b1-49cfa211d97mr123999575e9.31.1788676993918;
        Sat, 05 Sep 2026 23:43:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm648354005e9.0.2026.09.05.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:43:13 -0700 (PDT)
Date: Sun, 6 Sep 2026 02:43:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260906024233-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 05:20:56PM +0200, Karl Mehltretter wrote:
> A virtqueue callback can outlive virtio_reset_device() and race with a
> driver freeing the state it uses. The reset helper documents that no
> callbacks remain in progress, but that depends on the transport:
> virtio-pci waits in vp_reset(), while virtio-mmio does not.
> 
> virtio_input has a related ordering problem: it unregisters the input
> device before resetting the virtio device, while an event callback may
> still be using the input device.
> 
> Patch 1 moves the callback wait into the core, using the existing
> virtio_synchronize_cbs() operation. Patch 2 fixes the virtio_input teardown
> order. Patch 3 adds the missing synchronize_cbs hooks for UML, TmFIFO,
> remoteproc and virtio-vdpa. Remoteproc uses one SRCU domain per processor.
> 
> The new hooks wait for callbacks already running. UML, TmFIFO and
> remoteproc still allow new callbacks after reset; fixing that is separate
> work. The event-virtqueue DMA mapping issue is also separate.
> 
> Changes in v2:
> - Patch 1: move the wait into the core instead of fixing only MMIO, as
>   Michael suggested. Remove the duplicate PCI wait, preserve its shutdown
>   wait, and fix CCW callback locking. Drop the MMIO polling: reset polling
>   for v3 and newer is already in fa8833c085b6 ("virtio-mmio: add support
>   for transport version 3").
> - Patch 2: keep draining completed events when ready becomes false,
>   instead of breaking out, so teardown does not truncate an input packet.
> - Patch 3 is new, at Michael's request.
> 
> I reran the 120-cycle unbind/rebind test in an arm64 KASAN guest with four
> vCPUs and a 5 ms busy delay per event. With patch 2 alone over virtio-mmio,
> reset returned with the callback still running in all 84 overlapping
> cycles. With the series, it waited in all 103. Over PCI with per-queue
> MSI-X, it waited in all 66, including runs with threadirqs. No KASAN or
> lockdep reports. These runs predate the per-rproc change, which leaves
> the tested MMIO and PCI paths unchanged. They confirmed the missing wait,
> but did not reproduce a use-after-free: with evdev attached,
> input_unregister_device() waits for an RCU grace period that the IRQ
> callback blocks.
> 
> That version also passed QEMU input, rebind and shutdown checks on arm64
> MMIO and x86-64 PCI, including arm64 RT, KASAN and KCSAN builds, and x86
> UP/Tiny SRCU. A legacy INTx NIC was present for an additional x86
> shutdown check. The changed objects built with W=1 without warnings on
> arm64, x86-64, s390 and SMP UML. The per-rproc version built with W=1
> on arm64 KASAN and x86 Tiny SRCU, and passed six remoteproc callback and
> lifetime KUnit tests on each, using mock remoteproc devices.
> 
> Link: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (3):
>   virtio: synchronize callbacks during device reset
>   virtio_input: stop callbacks before unregistering input device
>   virtio: implement synchronize_cbs for remaining transports
> 
>  arch/um/drivers/virtio_uml.c             | 10 ++++++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
>  drivers/s390/virtio/virtio_ccw.c         |  6 +-----
>  drivers/virtio/virtio.c                  |  2 ++
>  drivers/virtio/virtio_input.c            |  8 ++++++--
>  drivers/virtio/virtio_pci_legacy.c       |  2 --
>  drivers/virtio/virtio_pci_modern.c       |  3 ---
>  drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
>  include/linux/remoteproc.h               |  3 +++
>  include/linux/virtio_config.h            |  6 +++---
>  12 files changed, 86 insertions(+), 19 deletions(-)
> 
> base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3

changelog?

> -- 
> 2.39.5 (Apple Git-154)

