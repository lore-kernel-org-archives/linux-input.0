Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BF3B38AD
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855274; cv=none; b=EXeR5JQ2/DfHXIht3M8663qdsYXoglOw3nUCJHRfkv4Lbo7W1X3QGkbUw2sVv9edr+/1MWZfLwg+2vZGdrEtq/tkfdf4pdTH81Ukf6bKs4jqciel6ziwtgrINWJHS1e7ua336tVhpg5jBwSPM6/+Mc3EqO7U45HzI0A5ynme/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855274; c=relaxed/simple;
	bh=p0hrqdChiW+STst7BxkT07ROO3GuAhUQ7F3vjs7ZfoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzCdDg8NaVJ/gxPRNiJMnQpgtUABz/f0RbyozGTFqUY2Qo3sUzb0i8ZwdRXX7H/b/MYKLgARBy8cvwWJie/jQc1b5l6gWcX7JcXSJ8zGgdU7UVb125YZRRs6xxCCFkPNID5RvipMhxtNbWhP5CEdk7GlG7zZqX9ZHwGCwfdWX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US2RD10N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tIkOpaQA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US2RD10N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tIkOpaQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788855271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACV6/WKaVrWxyqCJOW8h61Ofi+NiZkidjU4efmY89RE=;
	b=US2RD10NfJiVcig9CjDIZn7gC7Jk7Bi8IpC7raPuFpNgkfbx40xUH4wYQiimO6fXsTAmdH
	F7GAYqGguxsO8YHem4Hfc8TCEL3HsWjF1DUnrd9zpl6tntamHQXZKrcStwMzovhcW5B206
	g+zFHDBOYPF6xWNyAerjYTgBZLi+euU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-IABbnWvBPHqHUnsKh5eEwQ-1; Tue, 08 Sep 2026 04:14:29 -0400
X-MC-Unique: IABbnWvBPHqHUnsKh5eEwQ-1
X-Mimecast-MFC-AGG-ID: IABbnWvBPHqHUnsKh5eEwQ_1788855268
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482e538ad9fso3875920f8f.0
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788855268; x=1789460068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACV6/WKaVrWxyqCJOW8h61Ofi+NiZkidjU4efmY89RE=;
        b=tIkOpaQA4bpiwesQcqIMgAEcODWW9jUXf/chPYhRzMff8k2gNT3/EpT7ubGZR4GuVJ
         BBb802Rm0Z4fFItBjK3nbILtOQTstCpJUls5R04RYvTX8y5SMTXC0T6IeQ3pcAnfXC/U
         rKSacXQDymF8H9SFD+pOp2S+N1gCrSav0O8n+ivOvyNC2H4f0gaNRqU5+1DOcYAiYBkE
         85qdCepjD47XePVAd+DuRDX1RiMaFxkErpXrYsfGBlTkerQ44U2Sk3IMV5wz6PFDbhEq
         /M+YegBLeH8OCZa10sBMN0wGLo1D2P7lVTAKPJClhbwRHauLanDzflIcslDBGAb/ngZ9
         9k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788855268; x=1789460068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ACV6/WKaVrWxyqCJOW8h61Ofi+NiZkidjU4efmY89RE=;
        b=arWlZqW6vK2oljmZKvuGYvpLZS2igZ5c6c9u7FnGWlNDBd4kY2jTAnTGJ7zYGamuXJ
         Ha7Nb5RWH/vbhtltrCmuULpx716k+U1TzJhk44KOaifiqwTyRdIlpvbkpOQvDobvamDz
         u6cL9+9dxaTlp9JYeboX/W6v86I+fMqnmj4OuyULgIpYSxvAwp2+dO/CkC4/dKM12ETQ
         azrtfoiFmpVeWGq1kp7vJXXzfAyqqYB6H0zw2hWCRvWdEiWzjUx+P7q1JHah0LmoSfuL
         NK9LCZFbJ8703x12I4XNUxOI8RgzBTVQwmskFoim7M08a1qCpUUKZFr5GicQriLKU4q7
         dqVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTwsbnoynv7BedS8M+Vy5Zq+jkBjWOVaJkgqcVhVIWbp1uZr5JVkq4s+6Tdp7pdZ8DSVuvhk7u5cKM6w==@vger.kernel.org
X-Gm-Message-State: AFuF++lxoSHAJgtQWnXtiBYInOCyMkkC59UioVV0d+lCnAGFWIcPjrpV
	yqnIHds9u2H1cFUISbF25CFWlqGJoEgIXQUH14uIIzs2QezZtuJv+UMzBpGm167VLfYPg4qNG8D
	pS2JnoiXohz2/5RDVWOcf607AL6hs/VNDGZgKnUNCTUM7y9Bg672aAHirapuNQjH+
X-Gm-Gg: AYBFou26oS0NS6ke2poqFzBvmojHpnb3r9XA/TuNH6vNVK5oHsIxZ2vatexqaGSXZvK
	cGFdVxxlq98Ylww9cgkmJ2nV/7OfHRygLOC2yxrKyd4TLnI3iDNXP4NSGBdYN8E2eVppyQWwwv8
	4Z+LGg3WmbZy4PbscwdnN8cocxFbpugjnjxm/O8kn4PbgMhJaYR9RjDLSg3ee/IJ4BO2ZrAAq/M
	FwC7yGSv/0aPWpacezMD5O/VDh/ol8sbUWiginATfOVV7Icfjf/2wO3LI9otgvZu3MUzHnGcFfU
	VRnlcQnQoW31iq8/UbfWsorkJCtjTjUoG15cLACPxa5Am1aQh29Pta8t0/Awf38Ptts+9Pwx02h
	qB7Kmvn5YYjpZN5OVNdA8alI=
X-Received: by 2002:a05:6000:1e4b:b0:485:85ed:4911 with SMTP id ffacd0b85a97d-48587291427mr22863830f8f.25.1788855268353;
        Tue, 08 Sep 2026 01:14:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1e4b:b0:485:85ed:4911 with SMTP id ffacd0b85a97d-48587291427mr22863786f8f.25.1788855267857;
        Tue, 08 Sep 2026 01:14:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm34253540f8f.14.2026.09.08.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:14:27 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:14:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>, dmitry.torokhov@gmail.com,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v3 2/6] virtio_ccw: always take irq_lock in the classic
 interrupt handler
Message-ID: <20260908041323-mutt-send-email-mst@kernel.org>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-3-kmehltretter@gmail.com>
 <20260908055148.B600D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908055148.B600D1F00A3F@smtp.kernel.org>

On Tue, Sep 08, 2026 at 05:51:48AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The virtio interrupt handlers pass retrieved virtqueue pointers directly to `vring_interrupt()` without a NULL check. A malicious or buggy host can trigger a kernel panic by providing an invalid indicator or interrupt vector.

Buggy host crashing guest is not something we worry about.
Host denying guest service at will is exactly how cloud providers get paid.

> - [High] Lost configuration change notifications due to clearing the indicator bit after processing.
> --
> 
> commit 40545ed73d4381a07a7934fddf3ac60ecd1f90d7
> Author: Karl Mehltretter <kmehltretter@gmail.com>
> Subject: virtio_ccw: always take irq_lock in the classic interrupt handler
> 
> This commit unconditionally takes the read lock on vcdev->irq_lock in 
> virtio_ccw_int_handler() so the write side can properly synchronize with
> the callbacks even when notification hardening is disabled.
> 
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index b90299205698b..552d779980129 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> 
> [ ... ]
> 
> >  	for_each_set_bit(i, indicators(vcdev),
> >  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >  		/* The bit clear must happen before the vring kick. */
> > @@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >  		vq = virtio_ccw_vq_by_ind(vcdev, i);
> >  		vring_interrupt(0, vq);
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for virtio_ccw_vq_by_ind()
> to return a NULL virtqueue pointer if a malicious or buggy host provides an
> invalid indicator?
> 
> Passing an unvalidated NULL pointer directly to vring_interrupt() can cause a
> kernel panic when it is dereferenced inside more_used():
> 
> drivers/virtio/virtio_ring.c:vring_interrupt() {
>     ...
>     if (!more_used(vq)) {
>         pr_debug("virtqueue interrupt with no work for %p\n", vq);
>     ...
> }
> 
> Similarly, in virtio_airq_handler(), airq_iv_get_ptr() can return NULL which
> is unconditionally passed to vring_interrupt().
> 
> Could we add a NULL check before calling the interrupt handler?
> 
> >  	}
> > -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	read_unlock(&vcdev->irq_lock);
> > -#endif
> >  	if (test_bit(0, indicators2(vcdev))) {
> >  		virtio_config_changed(&vcdev->vdev);
> >  		clear_bit(0, indicators2(vcdev));
> >  	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this sequence lead to
> lost configuration change notifications?
> 
> Because indicators2 is shared DMA memory updated by the host, if the host
> triggers another configuration change in the window between test_bit() and
> clear_bit(), it sets the bit in memory and raises a new interrupt.
> 
> However, the guest will then blindly execute clear_bit() and wipe out the
> newly set notification flag. When the newly queued interrupt handler runs,
> it will find the bit cleared and do nothing, permanently losing the event.
> 
> Would using test_and_clear_bit() before calling virtio_config_changed()
> close this race window?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908053817.26065-1-kmehltretter@gmail.com?part=2

