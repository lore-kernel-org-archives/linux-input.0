Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C949E5E4
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436697; cv=none; b=H9u0AhkOvLZRnt04vKqN3ClEKmwdwRRrELdhyDKCrfwKy9wwwvR7hREKj6O7P2bzUnpvsS8RzFC9L9LOOZzd5TRAswApQeGkMy6KByGs5vD6M53FP/Y81b5bGNEwNQOiiok/lrkD9kdIJp5k5ikSdLpUbgJ2/7xCaZ82oYIt9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436697; c=relaxed/simple;
	bh=tjJoksxTvSLbsKZmff396bp3cikpK+RKhQh5gNozOuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7tekNkgDfM7qrj/IGel5jPWF2cIbHQu3+3iWFrm9thubXaQJNW5hvKNJvdXruHJXR1hvkQwpmdo+LLt7Svwc3n3qjZ/NJ9H4NmDrdxxqSauDJBJDQWgov56egZI8Wufk4QE4BcYz2pD8gRwa9JjQhJm9W2MyGTnpYKIgTSwbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYUL7wiA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pCt+9wmI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYUL7wiA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pCt+9wmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788436690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6plMdGLtlll1T0+Y+lYtkLC4Mp1xA8NIwqcOehU8CJo=;
	b=bYUL7wiAHMID0z/eZqBat+0NAA3vnAmA8yFj23QzstY3Y7paS13+YHFxm6pZfYF0ZSH0Hi
	w4idjX0MvLgCqJa5iE6USbMGSN1YWuqYQB536Y8VtfsWvJl4opCEjwc8glKF4/Wrk/s/bP
	WsA1UL21zQQGUEzfTwlAwNjpygJeH0M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-jqVZHyQXOcKPv_HBLan-KA-1; Thu, 03 Sep 2026 07:58:09 -0400
X-MC-Unique: jqVZHyQXOcKPv_HBLan-KA-1
X-Mimecast-MFC-AGG-ID: jqVZHyQXOcKPv_HBLan-KA_1788436688
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b7c1dc61eso20834085e9.3
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788436688; x=1789041488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6plMdGLtlll1T0+Y+lYtkLC4Mp1xA8NIwqcOehU8CJo=;
        b=pCt+9wmIXgqh9k4wSJiiMvHIq4vOYcmM9UDQ0LjWOdvz++XSPG9DNzbKeVeVonpxxv
         uOYMVsIeARt36u+KWQfnaMYj7rp6Ti91KyobE9unvSp78useCws/tRCGhMGsHJKf014/
         iMhJ4rt8s6LD9reNORJwW9bIuizBytgtOg1DkT+OXC45wM0BMYw38C1IuIfDe1JA6U3N
         fa8caXf/lrF7WU/y77reDfj6PDfxecrRWWNZn2b+JCcwt2rJhctlbEsDoD7UEI5zxhH5
         kmUVM2SRM4nX/tzVD/ROnLWf1VZ4T0i6VQbf8k91k4eOTznSkfquLsdRWpd2WwOoSqqP
         XvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436688; x=1789041488;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6plMdGLtlll1T0+Y+lYtkLC4Mp1xA8NIwqcOehU8CJo=;
        b=ePxDexYxCBr+RO2kJICb9HYqqFBDOsX+RIFu8+sxF/rzb8kua2iA6WQ/Hpc6kDOyIf
         NXl22nBvwJPDF8SAuOI3ARG3BfQlmXJYvggnJvb+5+0jqGif8aGcB7eJF9u7TymXQhv5
         mXFGrr27IGl+R1mpmZp5yBshdNbqsMjl69XschLtmMehjqc3IIVmXnkOaIUcUgGUJ89a
         RkYUelYdIOtdzRryu7ztqS0cOlJmZLvQZpHKLcLAxwk0PNuBVTZsuJrGdKDBj1AMVRej
         MpzKzOGnmcRwdMe3Epmu9v0UNsBmC7eW/bF0mXbssS+KtaN2mg1UNpJIXtv4m2Ggi1of
         4bAw==
X-Forwarded-Encrypted: i=1; AKwUvByYVNI8vdSnQFAqptf6x//hXBf3DJG8qG70crm3pqAsiPAOFHFPZ1zE7XXN73wVg2c+YTNSm1HBpI/7OA==@vger.kernel.org
X-Gm-Message-State: AFuF++kp5w7OB0oKAHcyAz0sw85tkc4GvLJ4t6yV5SF6VUgPVMJqtSTb
	jHmMPe5vs09fzQIEoG8yyh6i9iPkBDE2E2qt4L94lVDjADlWnYpLDd+LENZgKCZNgsDB/PJKbbS
	dAnODfHJJS2Mg1tXdIVrNb0tcYjuPFD1ijmOKA6rWFnuPjXuNcFKqDqIoKHsiiCBe
X-Gm-Gg: AYBFou27j3QZB+elxTzOAmmeRbISJOOh1H4ddZ5tjzHTQjYmgQngEx4TIGl/syUQQT2
	gl0WgAmZxkyCRAsDxqVaW2KcEW6nl3JlRVmTDmWKuduzzv4mPJ9NIW5F54Wtf30WDeq599T4ZvT
	ofFUO/3n7ds/SHoeS8cB8h8Ejxi0aJ+uwsYfBscLmZWb7OecR6h5pyiECQU/xqlpjP0+BHgExLt
	GsFEsKGSGhHLRrt8W8Owyqevq/6bOJuanD9oc44Ac3gOS9OdVxqOy5XYvvizC1eEuib+OsQ4+Zd
	Cbw/HoEDCKQpbISjSvEx2FK8HUmhC3TGiYxGNzbe5Gqp9YpjicoIzoR73FUv9/tgl3YI/fciUHt
	7NMA0lXE+g7XZtkoH2pJGjTY=
X-Received: by 2002:a05:600c:5489:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49ce58092a6mr182266405e9.6.1788436687830;
        Thu, 03 Sep 2026 04:58:07 -0700 (PDT)
X-Received: by 2002:a05:600c:5489:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49ce58092a6mr182265495e9.6.1788436687320;
        Thu, 03 Sep 2026 04:58:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed37c4sm11621446f8f.21.2026.09.03.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:58:06 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:58:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio: synchronize callbacks during device reset
Message-ID: <20260903075709-mutt-send-email-mst@kernel.org>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818040433.66986-1-kmehltretter@gmail.com>

On Tue, Aug 18, 2026 at 06:04:31AM +0200, Karl Mehltretter wrote:
> virtio_reset_device() documents that vq callbacks are not in progress
> once it returns. virtio-pci delivers that by ending vp_reset() with
> vp_synchronize_vectors(), virtio-mmio does not, and a driver that frees
> state its callback uses then hits a use after free.
> 
> Patch 1 brings virtio-mmio in line with virtio-pci.
> 
> Patch 2 makes virtio_input reset before unregistering its input device
> and stop its callback once teardown has begun.
> 
> Together these patches fix the use after free on virtio-pci and
> virtio-mmio. Classic virtio-ccw and other transports still
> do not provide the documented guarantee.


so with my proposal virtio-ccw will be fixed automagically.

other transports will need synchronize_cbs callback - pls add that as patch 3.


> The use-after-free was reproduced under KASAN with the race window
> artificially widened.
> 
> Callback synchronization was tested in an arm64 QEMU guest with a
> virtio-input device over virtio-mmio and four vCPUs. The event callback
> used a busy delay, not a sleep, and an in-progress counter tracked
> overlap with unbind.
> 
> The driver was unbound and rebound 120 times under continuous input.
> With patch 2 alone, virtio_reset_device() returned before the callback
> finished in all 109 races, each in under 1 ms. With both patches,
> vm_reset() waited for the callback in all 111 races, taking 24 to 86 ms.
> 
> Karl Mehltretter (2):
>   virtio-mmio: synchronize callbacks during device reset
>   virtio_input: stop callbacks before unregistering input device
> 
>  drivers/virtio/virtio_input.c | 8 ++++++--
>  drivers/virtio/virtio_mmio.c  | 6 ++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
> -- 
> 2.53.0

