Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40E471CE9
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856278; cv=none; b=UG2vkYGYa1BMry/vsI4xwVtMH5hZu8VIIWBRNzlc4CbKluOXBrJ/UiGovBa1ViR/+l3x7bFk45pkbVB3R/Q+fBsELTrg9kS8IuCh3drBZrFlXcL5rn0cjabE52TWLFvoPlsv0bHOreamt6lX887dxUJnyWQCqXQpB7YGK3LYDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856278; c=relaxed/simple;
	bh=bQVGmZsh54EPXaCbHVhqpE0sv9MCdcZelHyuzt63DU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLbsQumVYa4qeQme2F+CvMz95GvJueYgGL6OAKSH3VhE3wzTNjjQKbNaOGb7rsgC2xDOdJ0II9OhEU73OyBWUN1lUiDkMn1EKk/GXzwU0uJQCYgtsA3dUVxAYt3/QNJYBG7LAEnijzRM7wxGXScStUdZjAiThMSB+SHzBb+EMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIXkID83; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4Wz5U2K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIXkID83";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4Wz5U2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788856274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3vwxLtyfH5eqXgdY8WBSA5geJ/rIMZ7KgxZ+JZp1ZA=;
	b=aIXkID83FZBzMOs9IqwVsy7SQc+CVjXRHwcbm95LcQe34Re7gpgkJHpvslfDmtfBKHYpvG
	W3G0cCK6ifKsr87LR3xkb0J+uB9u04/tFUDlVCgBdQEjOK7edTig5sbjyC0FIM307GB1md
	pubURypBHMY+HBcNyviio9LgUPqddyI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-76pJZfztM_GjMI2fl7cyiA-1; Tue, 08 Sep 2026 04:31:13 -0400
X-MC-Unique: 76pJZfztM_GjMI2fl7cyiA-1
X-Mimecast-MFC-AGG-ID: 76pJZfztM_GjMI2fl7cyiA_1788856272
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49d0ae342b9so15843195e9.1
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788856272; x=1789461072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x3vwxLtyfH5eqXgdY8WBSA5geJ/rIMZ7KgxZ+JZp1ZA=;
        b=b4Wz5U2KOyMrnAtSl98mTj+Ozbh3aJ5e3/08o8lIrd481/XCZIHgWRuZ6tvrjy2z0f
         tIf7jXhRO9uyNHJ0/pLXM27W2Bt2KhB6xI7kPquEwV02pkQXIlJye4gJPKKVe677R5bd
         SWu3W75QtfTGygcguksvV/wpDZU2wVtTV2xhsm5AP/xL8Hfu7fQJmLDCiyTGF7E+e9EO
         0VR4EUvja7X//qqt8OWoiW52KTQYFZ9ENNwLvTYLxwsJ3XBmIsckdKzCKJvlW/Exa6gU
         DQ/pJaUbW98/ktBXlO11PLuP8olDGHzGNukSe6QUa6+ySKKomB2Lq2J6ozgn4IZvXkRK
         Xy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788856272; x=1789461072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x3vwxLtyfH5eqXgdY8WBSA5geJ/rIMZ7KgxZ+JZp1ZA=;
        b=bNMDIH3XdzL8S2DlQcnN2/UtpnEqjA7flghdkqlKeKeSuprsLq1CMLbqQj3nSadID3
         p3s9zXxaQfdPzS/IrS6FVKFxJZhuh4QVFuJX0ALox0HsVcz9+Y0Lj128eKqpnpC+uqeu
         1AR7GpXm76x5ciz684GySKvUYD/Augsh5MchOlH0G4Y35Q3AErwvHZdBnYYUkxVcW0eV
         BYYzNK8mI79Mob2tR5yJqWnEliFZHTXa4HmW8oqAGw9n9x8ac1Aun0GIii2wh3Rn2b2S
         k4sqU1CwcVm915ORvFdCkaZVxYVHMfpRieqdVghqINRUnRc70sEcgsUuE17W7HN4/fKA
         4VDw==
X-Forwarded-Encrypted: i=1; AKwUvBxmyzR3mpJs731ezbbQKa5VKtTEGB2DZqoEKFqA6Fr8qWI6HLqzdrKH6NwXYJvKvOeDp/w8PHP+huacVg==@vger.kernel.org
X-Gm-Message-State: AFuF++knqP0YGJcN6p5wtRb4uzL0xKo1eBJiTatMOrr3Ntdi9iFKRfGV
	YOUVl7MTecMDDdMrvxO65JNv4fhW1ldrbieEcOfw8Yw7MhQyB2zGsn1zCE2Mq4hVVa82uEXbAbM
	qMpYFv9d63TGccT/ksutAX4wT0B7wX3waK/BqYxl5MD6NGm9wrMvH3LkgKqp0dL0l708YZ1PY
X-Gm-Gg: AYBFou0loqFBeI/hRlwP7pIT3tmq5u1GbRkifWyBoQEX3djC9gnq3RYsE3+o18hZBxx
	Ewc36wjNErCOJeZFnFRwPOl3ihiiB9ZyurWsWacSOrh/ApG4lJl3whTLSaXfS4MK/o/wfwNj8hr
	zhLbYUoHxYvmOzLMk3oazMEC0kXAHqBTY8wTHW4PfByr4lVhlmdgmS0U5o+u9StOpvJVtMyJMK9
	f3MolWHyfYml7GOQeYWEtjbfKlH3QraRv0gcnNefg+46syLe+0BnSdEypl/RA+M2o90j3lINpa7
	gxBR8ePveUpN/hB9aqIpKCACkkUdK2F2xLaOsFTvsWgxFbLLAd8YqNoX2ctVWbhmGsSSPa/9jcX
	Q71XiZcSaVCFcWdQn9uZJzvU=
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6e:a3d9 with SMTP id 5b1f17b1804b1-49cfc6ea7b4mr252851885e9.24.1788856271958;
        Tue, 08 Sep 2026 01:31:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6e:a3d9 with SMTP id 5b1f17b1804b1-49cfc6ea7b4mr252851425e9.24.1788856271518;
        Tue, 08 Sep 2026 01:31:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff81c9b5sm254295465e9.4.2026.09.08.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:31:10 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:31:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] virtio_vdpa: implement synchronize_cbs()
Message-ID: <20260908043004-mutt-send-email-mst@kernel.org>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-7-kmehltretter@gmail.com>
 <20260908055159.E49DF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908055159.E49DF1F00A3A@smtp.kernel.org>

On Tue, Sep 08, 2026 at 05:51:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Possible Use-After-Free of virtqueue memory in callback during find_vqs error handling
> --
> 
> commit 05a7e5947030bc4c942e05c96bf1d657ed426d56
> Author: Karl Mehltretter <kmehltretter@gmail.com>
> 
> virtio_vdpa: implement synchronize_cbs()
> 
> virtio_vdpa relies on the core's synchronize_rcu() fallback for callback
> synchronization. This commit adds an SRCU domain per device and implements
> synchronize_cbs() with synchronize_srcu() to cover the callbacks regardless
> of the calling context.
> 
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > index 6bcf4567a9292..f9559b6b2e0b6 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> [ ... ]
> > @@ -123,8 +128,22 @@ static irqreturn_t virtio_vdpa_config_cb(void *private)
> >  static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
> >  {
> >  	struct virtqueue *vq = private;
> > +	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
> 
> [Severity: High]
> This is a pre-existing issue, but could this callback be invoked
> concurrently on a freed vq, leading to a use-after-free when
> dereferencing vq->vdev?
> 
> During driver probe, if virtio_vdpa_find_vqs() successfully creates some
> virtqueues but fails on a subsequent one, it jumps to err_setup_vq and
> calls virtio_vdpa_del_vqs():
> 
> drivers/virtio/virtio_vdpa.c:virtio_vdpa_find_vqs() {
>     ...
> err_setup_vq:
> 	virtio_vdpa_del_vqs(vdev);
>     ...
> }
> 
> This tears down the previously created virtqueues. However, the callback is
> not cleared with set_vq_cb(..., NULL), nor does it synchronize with pending
> or concurrently running interrupt handlers (such as vp_vdpa_vq_handler).
> 
> Could a spurious or device-initiated interrupt occurring right before or
> during vring_del_virtqueue(vq) race and cause virtio_vdpa_virtqueue_cb()
> to dereference the freed vq structure when accessing vq->vdev?


IRQs are not yet allocated then are they?
Looks like a false positive to me.

> > +	irqreturn_t ret;
> > +	int idx;
> > +
> > +	idx = srcu_read_lock(&vd_dev->cb_srcu);
> > +	ret = vring_interrupt(0, vq);
> > +	srcu_read_unlock(&vd_dev->cb_srcu, idx);
> > +
> > +	return ret;
> > +}
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908053817.26065-1-kmehltretter@gmail.com?part=6

