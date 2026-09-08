Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1441F34C
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855965; cv=none; b=idcHuUvS4CcB8bNjP/mSApkNlP+njUIIGdLkfMY91ZhRbdNsMK1vlwHGl5qYdEHuNfhFEy83EL1cekyR7SanNlHsEsF07JIb5100d2Bx9pOgagOCMVqC15HOxaSnm5Zh7AKZv1ECZaPOASb5WZGdO+l1fAKKHFwNCt4ouPSNB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855965; c=relaxed/simple;
	bh=mtlzNqSHslbgTL1E+s1EGrdbdVuzUh95XoEfQxCcoHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVxwh/YOXxa2II8GZoTNjq9Z6Lu8Dfd83BMQjfvSAI+gVQbxQbCQPRbGBFZpVCKVyZh5VFFGvahaHfLOi2F2ibeaxgw1XufpuOheqJkkrcsnJZkqmaiyXJge9hgfZ+96USOEoGlmDyYkGFhBz0R5oKLoZOSXs/m4sMne6f/eG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUKW+cRB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=blHQ7m7q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUKW+cRB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="blHQ7m7q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788855962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
	b=QUKW+cRB1vgNMh8fgJCHLMmXMprE18hgjlH8ruQ4mKP0QEdME0Bd1bp6oFUehRhSOObasJ
	J7EmHViJb1sqrLkkZGzcUu5I1kKHZvnXtnF8P6Ekqhe3jfIfD5aRcz6JqZzj3963hxYzOu
	DKEer3pEpYfvnVv+cuhlM2gVxZon2X0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-r7KH-Mq7NtOLb7jdLBPmhA-1; Tue, 08 Sep 2026 04:26:00 -0400
X-MC-Unique: r7KH-Mq7NtOLb7jdLBPmhA-1
X-Mimecast-MFC-AGG-ID: r7KH-Mq7NtOLb7jdLBPmhA_1788855960
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-499913d1a79so29150085e9.0
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788855960; x=1789460760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
        b=blHQ7m7qqboFW3r6pTJA/NJjuXOUcG3Y9jU/uGSV8i2+NXm26ccxZXSXFlN67Azz4v
         oxM8bQat53/aYMj0lbrhefkbLS7J0pfdt6hRtaPJA0eV+l6qEHKT57tH/4ucCnNVZOyn
         ttLKh/yZZ4s9hsUptbven/he7AO4Fi2Wn7Eje4FHcC+6T6DLPVYCNFNgMK4ZBOEJGqf9
         lOH/AXFL35a6CF0xLC2ilTJ9J2EwVm2ddCB7Bh2GLxAS3lWpxuZgjrZTg/GdT94R34Je
         XId37U9W27Mitf6e+aZ2jhHRbgRgnlcnWnztjalp8Po+czyD/UaSXQ0zhRFcVgg5qMbx
         R7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788855960; x=1789460760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
        b=htOIfORAatoyZHlXK4OuOpqIXY/O7jUfcSAE4eL7sekFRgRpxf5lmPtgHiWzMhBwkH
         dOeh6napLa1APYHuYgmEiOCHU5YEADtevzDXJTnYXdKNUtpHKiyRGlRc1YUJKjDGx+LW
         npkVetYLkT+1uFxVGREia6W52uu8zyYxkPgLsvCl8Am4iNwuwGMk1gYPWD/MYUpkf+mH
         wMzQl89FxKwQFAoCif6070LVoU36K/uQaa+ocsCx7ZjuCeuBo1lqNKYqJ8nqXCs1Qmgl
         5192gWJ1QKGLtoJfJf++AgPTx+l76KZlFpp8ZqPcRM5BOE0IURNMKegkVGUVGN3kaCTU
         Ypkw==
X-Forwarded-Encrypted: i=1; AKwUvBxwNErf24fAVrEMw04Gt5KglrTZeXhAV7PuQRonCRd/erSxDir87edI2XtOrP2PHWanlETjmN5AUwyFvw==@vger.kernel.org
X-Gm-Message-State: AFuF++m0Iey/ygkEhN7gqsJg2UdOPsYjfKz6wG/GDS0ptXsKcjbVVOcv
	2emIi7ASFkLd2d8AqPkYrlaFQ0tR9VrQX8wJeU/VYPRil9L2zZlo1p3X5aGrQnmFBILZ7R4OBx5
	DG11+WUTRhSs6o5ERVtuKXt7HiAerV/kpeFpO9ras0hx5Rt7mFLorxIvbudooJTNk
X-Gm-Gg: AYBFou1kRf7soe5jHy5gk8MWFhszRskIXSY91yIpBAXzEwt8J0UY/92uUQCgwj3TcXf
	h5ly6ajkGAtl6XzIynb8K/Uy/bEcXZrMKpxAMHSSIVlzPn2s6krUdcfR0buR2UkDS9mxGZhTm4Y
	9N9V+ONeCm/M6cWT3DQk+v+pUNZOhiTbpZuDHUJKc0weAzRfP9QyV1a4VO/JhY827HiYHVXs19k
	mZJ+X58YjXguLD74JU67EZnn7QacXNcGrNtGK1y0RwCNDXIPSBRvARuhxWQbMlRk8RcCsrLLMCX
	wGwdEvKG6SnF3uiWtzocB019Q78lZV4gzhhiRAaWXnXMrBel3Ph/q7Z5QhSK8mN+XUIvPUSuOcL
	KWey0uQB1fFFoyOPkDs4DgFg=
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr469629365e9.9.1788855959386;
        Tue, 08 Sep 2026 01:25:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr469628205e9.9.1788855958792;
        Tue, 08 Sep 2026 01:25:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm275644125e9.0.2026.09.08.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:25:58 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:25:53 -0400
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
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] virtio: fix and add callback synchronization hooks
Message-ID: <20260908042440-mutt-send-email-mst@kernel.org>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>

On Tue, Sep 08, 2026 at 07:38:11AM +0200, Karl Mehltretter wrote:
> This is v3 of the callback synchronization series. It is based on
> Michael S. Tsirkin's linux-next branch at f49e6cf91942 ("virtio:
> synchronize callbacks after device reset"), which already contains the
> core change and the virtio_input teardown reorder from v2.


Thanks I applied since this looks like a net improvement.
Pls keep iterating on the core change.
If you want to take a stab at some of the pre-existing issues -
will be welcome.
Pls do note which patches were tested and which were not.

> Patches 1 and 2 fix two bugs in virtio-ccw's existing
> synchronize_cbs() hook. After a fallback from adapter to classic
> interrupts it selects the wrong lock, and the classic interrupt handler
> only takes the matching lock when notification hardening is enabled.
> Patch 3 adds SRCU tracking for remoteproc callbacks, which can sleep.
> Patches 4 and 5 replace the RCU fallback with synchronization against
> the UML IRQ and the TmFIFO callback locks. The fallback already covers
> these IRQ handlers and spinlock sections. Patch 6 adds SRCU tracking
> in virtio_vdpa so callback synchronization does not depend on the
> context in which the vDPA driver invokes the callback.
> 
> The UML, TmFIFO and remoteproc reset paths do not themselves prevent
> new virtqueue callbacks. UML and TmFIFO only clear a status field, and
> remoteproc does not wait for the remote side to acknowledge the reset.
> Without notification hardening or driver-specific teardown protection,
> callbacks can still start after reset. The new synchronization hooks
> do not fix that. The TmFIFO hook also does not synchronize with the
> rest of the FIFO work item outside the callback locks.
> 
> The virtio_input loop change from v2 (continue instead of break, so
> events the device already completed are still delivered) and the
> event buffer leak are sent separately.
> 
> Changes in v3:
> - Rebased on Michael's linux-next branch. Dropped the core change and
>   the virtio_input patch, which are there already.
> - Split the virtio-ccw fixes out of the core patch, one per bug, and
>   the transport patch into one patch per transport. The CCW and TmFIFO
>   changes are functionally unchanged from v2.
> - Patch 2: added a Fixes tag and described the existing shutdown
>   case. Removed the dependency note on the core reset change.
> - remoteproc: read the queue pointer once in rproc_vq_interrupt(), and
>   synchronize with callbacks in __rproc_virtio_del_vqs() before
>   freeing the queues (Sashiko). Place vq_srcu next to rvdevs so the
>   hunk also applies to mainline, which added attach_work after index.
> - virtio_uml: compare against UM_IRQ_ALLOC instead of a bare negative
>   check.
> - virtio_vdpa: use SRCU instead of a per-device rwlock, so the
>   callback tracking uses per-CPU counters, and cover the config
>   callback (Sashiko).
> - Rewrote the commit messages. Corrected the RCU fallback description
>   for UML, TmFIFO and the vDPA simulators. Dropped the claimed simulator
>   reset race: the simulators disable bottom halves around virtqueue
>   callbacks and serialize reset with the worker's mutex.
> 
> Changes in v2:
> - Moved callback synchronization from virtio-pci into the core, as
>   Michael suggested, and added the missing synchronize_cbs() hooks.
> 
> Testing: the changed objects build with W=1 without warnings, with
> clang on arm64, x86-64 and s390 and with gcc on SMP UML, and the
> patches also apply to current mainline and linux-next. The runtime
> tests from v2 were not repeated on this version: the input, rebind and
> shutdown checks on arm64 MMIO and x86 PCI covered code that is
> unchanged here, and the remoteproc and virtio_vdpa hooks have only
> been build-tested. No remoteproc, TmFIFO or s390 hardware was
> available.
> 
> v2: https://lore.kernel.org/r/20260905152059.89560-1-kmehltretter@gmail.com
> v1: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (6):
>   virtio_ccw: fix synchronize_cbs() after interrupt fallback
>   virtio_ccw: always take irq_lock in the classic interrupt handler
>   remoteproc: implement synchronize_cbs() for virtio devices
>   um: virtio_uml: implement synchronize_cbs()
>   platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
>   virtio_vdpa: implement synchronize_cbs()
> 
>  arch/um/drivers/virtio_uml.c             | 10 +++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 12 ++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 37 +++++++++++++++++++-----
>  drivers/s390/virtio/virtio_ccw.c         |  6 +---
>  drivers/virtio/virtio_vdpa.c             | 34 ++++++++++++++++++++--
>  include/linux/remoteproc.h               |  3 ++
>  7 files changed, 102 insertions(+), 15 deletions(-)
> 
> 
> base-commit: f49e6cf919425cc55f10fd7cda7e0fc895df4cc0
> -- 
> 2.39.5 (Apple Git-154)

