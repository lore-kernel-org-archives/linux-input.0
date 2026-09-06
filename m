Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B2374A01
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677395; cv=none; b=e1RcSDBMmmjwdElX+7Tl3lRHy/c0KsifjNUXWNg1zHmWfpPplBdEJCQmKynx1GIOtaDjVICNsB6MaVsA2zX1Gv44e/+MM5/+yDIDzwICo7QFuP7QcboPkaJsV82icLo4bQD+K/F0Pc4GmafPg+ao92eeGxAXS6fjLAQ5IOdHLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677395; c=relaxed/simple;
	bh=dj38t1fGfgwRkmHhPJzLsp5lj0Rjo6qLLi+LSOdmRUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MypZ3Fdg3YI/ToY2yyDEJgiHlwT6yfneYnqoJKLx9ntB/2yIsK6wj0dWdHFcx5g+d1JfeVG7Bl5iF7HH3SAB1yMpQmnjSN8Os/gBv1efm4hkx6Z60H+t+lGewf4K9uHSVPbTunUKGtYtMrwnehBERBDCKxQNKs1YArq1WwQ1jiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nvsk+3yp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2LG/4qW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nvsk+3yp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2LG/4qW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788677392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FxBlOQKm+7hXSGCdUjsbD2NtO6PNO8MI4ARMWfWmlJ4=;
	b=Nvsk+3ypdgOPcwV56fKcUCv66OnXdyUX09nzPcxKXZSstbyYPHJ0dzzRnjosYUaQQADN/n
	Lnsa1ggCRPnLjfTf0hAJxINRtayeOuQc+pKN5v7wmhB8QhSw1OmtxfPtWBu44NJ6iDa6iB
	pBL6JNADtJMbLTTVjKg4udURjmjQS2Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-G2CeD8jzNmWaZcVu0xO3eQ-1; Sun, 06 Sep 2026 02:49:50 -0400
X-MC-Unique: G2CeD8jzNmWaZcVu0xO3eQ-1
X-Mimecast-MFC-AGG-ID: G2CeD8jzNmWaZcVu0xO3eQ_1788677390
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so36677935e9.2
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788677389; x=1789282189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FxBlOQKm+7hXSGCdUjsbD2NtO6PNO8MI4ARMWfWmlJ4=;
        b=T2LG/4qW1DwsxpVYw/RsqLWcY75Ivhz+6AqEx1AQqVadEZVAl9fo9cEXABWnsk79e7
         tfjbFMp2mCSGcMpdIOMqPE2K3go4f5X8kh7lqouyt33ABRczHGuQvOx1ijBDGRRgjJh9
         JnAuWNgS4pceEMsKtT+cMpEHabOQLhpg33vWlMKgzfqybqO0O7h1Rr+vRq7B41MMXTHG
         vCCq5VtlM5tT84TX56nSrnfkpiJVEzic2HiOOZYW7ZcUrhR+nAvKEPEVWDBQszy4BQaJ
         guHDv4EgjREZ1JTRSPa44WgfLx9XfjIM5MqETyfdkPWme3ahsbonTLxcYdLYzxsufgtA
         3lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788677389; x=1789282189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxBlOQKm+7hXSGCdUjsbD2NtO6PNO8MI4ARMWfWmlJ4=;
        b=pczYXV0kPBL+mAWQ3qbO9N4p9n+R4MeDQ25O51t8t+23CsQBX2V0W2uTEBUgZaKhoD
         zr8Y+HJWUCyZ6B90gZq5RzVrmPFIO/CHghK1+Y00/WopG5+Fzg3t2XwvQQYhlwJOgNYO
         cl4YuBhjt08PmLCX95U7BDCB9uEoOlnq/YNrmS7YfF3f9Qh5vtECIiFxyugbLkTA3hW3
         zPJzWORfWNDHW8WjdRKJh5KatX5yv19lVX+5qoNRFnaT/+8CubXjeW5T0A8ZSvIevffE
         hDCsmbatH/IPVCxQW3pc7/0Nx1qCU5NmwlzovHOMnsXgXRlOnNo8phSrfX5ywOT2FRIp
         pQOQ==
X-Forwarded-Encrypted: i=1; AKwUvByngEBHsr77VFvzoGqPYOtGkohmKr8kG0iMX+QfoJo1SBZSl+1I0P8a7P3Yzn8OlVeM27jkuglwq+PKPw==@vger.kernel.org
X-Gm-Message-State: AFuF++kHb7ov9P3L/ocYL41JH6MBny1eAnOW9Uqymb/yC1Uhpujg+gkT
	unlUYucmEzoMT+8Q5awfunOYeIXtiDFZBVPiQrfQLw26udrRk+aeGI/pWLC7dd1Uy+TXFCoYvUT
	SZ1K8Unch7i6WD3gPTI23Tmo8g7yh5rrIWaM0BVQhc6lRQ/QLTP0T+6+PooPhNLpY
X-Gm-Gg: AYBFou1JR6OFIlS065TZBF9MRmi2dA4bH10XbpFZr6VsAFEJlzCJEvozCdNi0LLAh5F
	tCTIy4Xr0QgeggbOy5Dp7CotclfeI7Hbr1CrKMDX4smaJS0xYnyT6mykY3+q4G/1uAJCoEJQb2c
	ddkV4jWL9UT4NhXyVPrgIPlm42tgFyZy5Lb+TeB1+JHdudV9fYcclqp3aeaEEpurW38G4bU3YLY
	r7j60zyIOXl3R5XeGeWVOuzME6ZObz3X/Cx2vQqbzBo7gn9oxL/mZuI3NvD4TOymptB7FvqHKqF
	J8ciA4ooRzXqNIQCsvrKjvMVDZW2JSGf0uKzLFzoIq6WO2XlN6nfUn7Cf6HXpCyQErYsV/SZF5i
	lY+rNQ1UgodJk+lwPwVN3j90=
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49cf825a530mr183997905e9.12.1788677389140;
        Sat, 05 Sep 2026 23:49:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:49c:cf18:494e with SMTP id 5b1f17b1804b1-49cf825a530mr183997325e9.12.1788677388522;
        Sat, 05 Sep 2026 23:49:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf772692dsm252344165e9.10.2026.09.05.23.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:49:48 -0700 (PDT)
Date: Sun, 6 Sep 2026 02:49:43 -0400
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
Subject: Re: [PATCH v2 1/3] virtio: synchronize callbacks during device reset
Message-ID: <20260906024354-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-2-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905152059.89560-2-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 05:20:57PM +0200, Karl Mehltretter wrote:
> virtio_reset_device() promises that vq callbacks have finished when it
> returns. virtio-pci waits

it does not wait. it synchronizes.

> in vp_reset(), but other transports can return
> with a callback still running.
> 
> Call virtio_synchronize_cbs() after config->reset() and drop the duplicate
> waits from both PCI reset methods. Add the wait to virtio_device_shutdown()
> too, since it calls config->reset() directly.

so what, if it calls reset directly? what does it have to do with
virtio_reset_device? is there a bug around shutdown?
if yes it's a separate issue.

> Keep the pre-reset call under
> CONFIG_VIRTIO_HARDEN_NOTIFICATION so callbacks see vq->broken.

This kind of slop is what LLMs write. u do not need to document
all the things you did not change.

> 
> Always take irq_lock in the classic virtio-ccw interrupt handler so it
> pairs with synchronize_cbs even without notification hardening. Use
> is_thinint to choose the lock: airq_info can stay allocated after a
> fallback to classic interrupts.

I can't even read this, half sentences out of context. Can you pls
write the commit log yourself?
I suspect what this is trying to say is that synchronize_cbs
is buggy on ccw and this is trying to fix it?
A separate patch then.

> 
> The transport reset must still stop new callbacks before this wait.
> 
> Fixes: d9679d0013a6 ("virtio: wrap config->reset calls")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM


codex likes putting this in but it is the wrong format.

> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c   | 6 +-----
>  drivers/virtio/virtio.c            | 2 ++
>  drivers/virtio/virtio_pci_legacy.c | 2 --
>  drivers/virtio/virtio_pci_modern.c | 3 ---
>  include/linux/virtio_config.h      | 6 +++---
>  5 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index bab6cad3fd5c..552d77998012 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1062,7 +1062,7 @@ static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	struct airq_info *info = vcdev->airq_info;
>  
> -	if (info) {
> +	if (vcdev->is_thinint && info) {
>  		/*
>  		 * This device uses adapter interrupts: synchronize with
>  		 * vring_interrupt() called by virtio_airq_handler()
> @@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  			vcdev->err = -EIO;
>  	}
>  	virtio_ccw_check_activity(vcdev, activity);
> -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	/*
>  	 * Paired with virtio_ccw_synchronize_cbs() and interrupts are
>  	 * disabled here.
>  	 */
>  	read_lock(&vcdev->irq_lock);
> -#endif
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */
> @@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  		vq = virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);
>  	}
> -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	read_unlock(&vcdev->irq_lock);
> -#endif
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 75bb4ffe3b87..ad1c50b8a94e 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -264,6 +264,7 @@ void virtio_reset_device(struct virtio_device *dev)
>  #endif
>  
>  	dev->config->reset(dev);
> +	virtio_synchronize_cbs(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
>  
> @@ -424,6 +425,7 @@ void virtio_device_shutdown(struct virtio_device *dev)
>  	 * Some devices get wedged if this happens, so reset to make sure it does not.
>  	 */
>  	dev->config->reset(dev);
> +	virtio_synchronize_cbs(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_device_shutdown);
>  
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d9cbb02b35a1..8115aa39e01e 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
>  	vp_legacy_get_status(&vp_dev->ldev);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..c9e21317c51a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
>  		msleep(1);
>  
>  	vp_modern_avq_cleanup(vdev);
> -
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
>  }
>  
>  static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 69f84ea85d71..8684a1e268ee 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -71,9 +71,9 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> - *      The function guarantees that all memory operations on the
> - *      queue before it are visible to the vring_interrupt() that is
> - *      called after it.
> + *      Wait for running callbacks to complete. Memory operations on the
> + *      queue before this call must be visible to vring_interrupt() calls
> + *      that follow it.
>   *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
> -- 
> 2.39.5 (Apple Git-154)

