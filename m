Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDB37BE6B
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677529; cv=none; b=twgMsNQARVZtORDDkp2YMVgFqPusdZS3z4bvcTfeuUsPQNzI5e/Bcw7aVMT3wLz8NnCr6N+ZLFtlsHGYvd7FyI1iSfeR8fcfxF4mJEgO/iZYkZRuzb8ZpKV5m9BNalTVpyHVsW2h4LpqyA6nVUrtxO/nZ2pRS/0eSpfg/Socr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677529; c=relaxed/simple;
	bh=azD26yiQNPU/p1yFpKDui4//CMQZvxbCQYRnod40ADo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECIh2lMT0aBFHPVeJ7sUoohPaqTxDBxtH8UDYb16769riyGlJmPgujBYJo8FN0Tk6B7XRfPBo7jMBPz8Rk74vZovPn8Zz14Fqwkmb06J7FdIJ41QUekvfAZ4LoMUFdKjxObtB2NsneDZ5rO6bwVRxGvW8nXdPaG0IPvcjJNVG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WC/pmLF8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRYqGxf5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC/pmLF8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRYqGxf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788677526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFAyqu/vjWVl9+ogYvQ74BpZIagkpPa2HIVHVUx9n8A=;
	b=WC/pmLF8XZX+T6aS00R559+fczg6hAefHq5/Mir9jo98+lnanfI7uwOd5GAfUol0hJztSk
	9PAi2jMBO37ct27SjUHpAGS2umJAyQ7QjYRjtPHBNgC5s/aIekxsiuBpDuMQSVhsvtUZl/
	ubJrburrjzP6vB/NBeBNuJxESKha4K0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-2KPYfRFoNOemguqVClC4mw-1; Sun, 06 Sep 2026 02:52:05 -0400
X-MC-Unique: 2KPYfRFoNOemguqVClC4mw-1
X-Mimecast-MFC-AGG-ID: 2KPYfRFoNOemguqVClC4mw_1788677524
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495529a93f9so22520595e9.3
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788677524; x=1789282324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RFAyqu/vjWVl9+ogYvQ74BpZIagkpPa2HIVHVUx9n8A=;
        b=iRYqGxf5fa55vS2oLqVWYDIfoa05K+wOsXfFu4QeEHKcMXgxdaP3432tVk79/e3QYX
         OKeYapsYeFbZ9a/8l61H+H39unKRiOiQ56r2q3+SCKqM30+HfTwh5yYBdy9L+fhEKDTO
         +T/8gK5ToREWB3lwjBfYj/Pz1iaoEd3OdlhGIM2UIxmomvxPYn58qw/okRXTvlHHHwjl
         RSf/Z5F7NR3P/Dv8pwYG1C/Ys1I1Laze33VM8UMFevSGuHoaz7kW7/2zBuSjQ2cGamF6
         LexhDwmVYp2Sdtc81M50ggU54Xgu7Ff860QiLMOUbjtZczJTtN/OvfglGg/yXb3Pr+gH
         wYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788677524; x=1789282324;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFAyqu/vjWVl9+ogYvQ74BpZIagkpPa2HIVHVUx9n8A=;
        b=nXCu2vxEBa8yH+Fyp6tTCk1T8GOkHPYzUNCHnynSxzetCsKJE/HBLYawmXynR7W1I8
         PAi0JdOHslttDDU9kdfNYsOVZYci4FZ33gBa2AJvq775OjOb2eSHhTmAy4wgBJabo1kQ
         y3RfD8YZuHEIS/QZrnyIN2gp0j2pYD95l62FXGGrD5AEcOiG49uZhEmBQ5TtYViHvN6D
         UG96XwfoTt43QrAS5isFMeJxE5fu8c0ggwLYum7iLlPpZ22Rzhkq4T0NsJ+T9LXo56Dy
         HtCU/HBgWUsDrSR8Eqx993m6K9lr+0F6Y7m3TaiNSqTNuGOpkfRA7DnzaXY8QwyOfxs1
         M6IQ==
X-Forwarded-Encrypted: i=1; AKwUvBydj4dTU0D7PYO7AgQ/I+yUWuXYe+CRO9yfpCdFcwy72B+rZY3k/X9EOBIb3lRg/h7HiwCUyJCnCG7IVg==@vger.kernel.org
X-Gm-Message-State: AFuF++krWhnpFvIUcTzhotfL4dN1HOrezQklHTnfgpTZ8woUkM9z7qX9
	A6JKuVSoPCnOCNGWEfep6mZy3ALrQSkgnd0p1kfGGryxz2ryN8zUfRsEiJU9H9wI+WbORIOFea9
	wihMtcbfswYNijJQXSNs01c386omq0jYYP+YHMl+u0O7bOSEeLmt0aamo6S9tELRDZQZ8I9+g
X-Gm-Gg: AYBFou2xrF+trBATR+YDKEk1+0tZtHTpWtELz2s9tSrjdTMMpYLHNBUiogrCjdBgZk1
	gVoXEdiEp9gY0EvW0FffnqjcQTzKSKeEqbNsc++YySHaygvJmteEhuKLMZwaZySYhoJhZDnnvRP
	aN9hI4ARXBrPG1UKrYRdvKL4bH+VDEIGOPAgVhmgqpfwP5QwXQ9QHiPzx/Mx7urpnBNHr7ZuEbQ
	/k6RW7OwBDh4u1kQBvLdwl4NBGYhhBrjyZqNxpcIZdJ4wUFNIGCX6nRzybzHfqRvpiiovGDWDHV
	Y2NinJqT4rV3OrVASJZxXqojBqLH/vNW/0bH2WY81u46aeFnp2gKcNqqU/R4GD4ylqcyTGY+vUV
	WgMSeA+pbAtJwygSasijtj14=
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr177241095e9.11.1788677523936;
        Sat, 05 Sep 2026 23:52:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr177240555e9.11.1788677523479;
        Sat, 05 Sep 2026 23:52:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm16190990f8f.2.2026.09.05.23.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:52:02 -0700 (PDT)
Date: Sun, 6 Sep 2026 02:51:58 -0400
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
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <20260906025002-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905152059.89560-3-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 05:20:58PM +0200, Karl Mehltretter wrote:
> virtinput_remove() unregisters the input device before resetting the
> virtio device. virtinput_recv_events() drops vi->lock around input_event(),
> so clearing vi->ready does not stop a callback that passed the entry check.
> It can still use vi->idev, requeue buffers and kick the queue.
> 
> Reset first, as virtinput_freeze() already does. With the preceding core
> change, reset waits for callbacks before input_unregister_device() can
> free vi->idev. Recheck vi->ready after taking the lock again: keep draining
> completed events so an input packet is not truncated, but stop requeueing
> buffers and kicking the queue.
> 
> With evdev attached, input_unregister_handle() currently waits for an RCU
> grace period, which also waits out IRQ callbacks. This masks the lifetime
> bug on PCI and MMIO, but does not protect sleepable callbacks on other
> transports.


And now I am completely confused. So it is other transports you are
worried about? Which ones did you test? And why don't you worry about
fixing other transports in 1/3?


> Fixes: 271c865161c5 ("Add virtio-input driver.")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>



> ---
>  drivers/virtio/virtio_input.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e682..7b654af0a42c 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
>  				    le16_to_cpu(event->code),
>  				    le32_to_cpu(event->value));
>  			spin_lock_irqsave(&vi->lock, flags);
> +			if (!vi->ready)
> +				continue;
>  			virtinput_queue_evtbuf(vi, event);
>  		}
> -		virtqueue_kick(vq);
> +		if (vi->ready)
> +			virtqueue_kick(vq);
>  	}
>  	spin_unlock_irqrestore(&vi->lock, flags);
>  }
> @@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
>  	vi->ready = false;
>  	spin_unlock_irqrestore(&vi->lock, flags);
>  
> -	input_unregister_device(vi->idev);
> +	/* Callbacks use vi->idev. */
>  	virtio_reset_device(vdev);
> +	input_unregister_device(vi->idev);
>  	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
>  		kfree(buf);
>  	vdev->config->del_vqs(vdev);
> -- 
> 2.39.5 (Apple Git-154)

