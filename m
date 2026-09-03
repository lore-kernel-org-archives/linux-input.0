Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125649EC4D
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436563; cv=none; b=avrR6s4IzcC8u2r8FtAGqN525NWdiao519//inUzeMY9IW9Qxl1wd/H04KTTnaeGp4dKyZxnZHFuYyjMq9AqQsowlebwOxpptFN0Hw/lTaAN8YXHHJICwP/LSWbjgTIrO8n9GaXT8ajcF7ZT3dQETh+7AuJaplBYExc9asOFRr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436563; c=relaxed/simple;
	bh=CdAz7fh+1ltkQ4tM2hXdLcQnn+Tcf3gIIBOSSClnYDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9J+tFiqSy0NruKrY+iICXMIWYzpJ3Pn+YFlzW1+XuProbYs9Z8wQ7gSxHhSngHYZHJJMkDNvTl6M3ItGh6/XYoh8GhB4O/J+Jhj8hOAJko/RD2LFfm8qrp6DNklWRgm1jDChdoODsvE2q6xQ9E7nSo7+J0NVEXc6Wm9mdZG1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOrS0f8P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGWmApPG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOrS0f8P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGWmApPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788436557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bcb5WjUE5AVdlBj8rvAyCS6YYznNN90xNsiTu4NwOR4=;
	b=OOrS0f8PTc2QfrvRIg9w35KPcyZ+X1KZwgUtvGtncnM8l+7VN60HpIS9xLydaLJQMg7wOh
	dsqs2/t1H47rwQX3b1KFZxMj1n9m8N8kRzwB3k7RVriZEW7oodO1rN9rQAcXQhMzjYMUbx
	KLxxUg2g+arJWfSc4zj3Hj9yEsn2g5E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-pPTco8YoOUeFc6lQAzawXQ-1; Thu, 03 Sep 2026 07:55:55 -0400
X-MC-Unique: pPTco8YoOUeFc6lQAzawXQ-1
X-Mimecast-MFC-AGG-ID: pPTco8YoOUeFc6lQAzawXQ_1788436554
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4843d9ab895so1988117f8f.0
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788436554; x=1789041354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bcb5WjUE5AVdlBj8rvAyCS6YYznNN90xNsiTu4NwOR4=;
        b=UGWmApPGVbza/KKKxURnGQvARKhI+9JCImUbINxSP43fOA3XsqNvRJttC05Neq5wNn
         uyXuB/khwUdN5kHxTq49uu9CfI7yYyXK0ouXaVyVdi8revtO9v3Jp3oAVXCbaCDp2rHf
         aJfGuVaFdHQHzIY+TUsK+xGOchx8LzL7vzsKNjsDySST3TDp0wwBe6uSlfJ342NMLFqa
         +trl+vEwcYHPImIwklidM23/e+FWgz18bEhbbo7l5wB3RY9kqWsNTIGxKOsAJ4gde08l
         1/DMaWZN/kFjq+8OoyODT769gWolSbC7gWgNk9RewB9NuGiXUn8Bs20VYJWTfJvHae7o
         IyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436554; x=1789041354;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bcb5WjUE5AVdlBj8rvAyCS6YYznNN90xNsiTu4NwOR4=;
        b=Jhg1tOXNgPyT9cviJLYz4gJTQGo54p2vKxOnb91JlPJjcV1SO+vh/e1PJKQVbuTlEw
         wc8LIZIwd+IZ2HUAFUl0dcYnCA9ocC1lJeisbWrXwYugVIHO91EwOxz3Plbk0ZO4n7Ar
         aqved6ZBVe+4aW7S10Hiji/D6TQCH6qVdiFjsZMCU3gwqrm6sKQrydjDtpqaJ5vxh56w
         7kQ7W45xTa6xKn9CJLnqJ/GqdE6vOPsOK81VduuPP6UKrHxuGKb9lmXZT7hIFPhaAHHV
         w/xhLvRs1hvw9lXxg7KVeVK5YcyOilqYBhahfboW6doAZWo6ZWq/ethgRXBUZtMiRs+r
         GCww==
X-Forwarded-Encrypted: i=1; AKwUvByWe0ZJ1s7PbEIvJlPZmagIfteeJ4VX8P1ckHKHkh2m3L8bOzKF9xTq7s5YOyz/BwQ9CylcWreq4sAk8w==@vger.kernel.org
X-Gm-Message-State: AFuF++kjznqMFi8opnlIfz+5YIFzLz1lQKCT4UMRrfwQO88Z0h0EAI6Y
	EnBM/iGI0obcpooiIiN/BlOYj+uNnw1mLryPsd7aZpdlP2+T1l4fdWDMW17N8X7P+FLvYAG4Vgq
	I/f6VwCpXJQxk5K3ob0AsS1ObwCvbNDkqD2iPVTH3eSi3je3uXMQjO00suMkSeZzm
X-Gm-Gg: AYBFou0eHWIUPxQMa4ETE+Hw1L8PPTsrtP+aNJmk1/eDcra+PxXFfiCJ9AwOBMdBp4Q
	xF2Gm4wKOS9/TNkFuOtwGe/+7wzf3fL5t4iZyk7FjYMHb6jc1GVs8SoCbl0X8ZlqYVbbTPMNkWp
	ZUVEZHCLQy2ICzGoECYcH5/jYh6z+HvU/Qf1epeN8Ptp/46Edvztv9fAu9l0D6eL4auuOYnCKqR
	1p1kMIswckG4fpwVnWw9A3my+ByQdXpuBBTZLwI9NHaMYHV4F/98DDco+w2FpJcYLv/V9V1LhT1
	h04yPm5A/CW5zUPyN3Q6lKyTCWlTPUnpmWLmZPke6cMuWODXfu7DHuqvx83thqilxlmWvQD3qK8
	bHfxaH6tOq7Axqov+FAS4W2w=
X-Received: by 2002:a05:6000:2086:b0:47f:96e3:530e with SMTP id ffacd0b85a97d-48488efd18fmr19364413f8f.8.1788436553761;
        Thu, 03 Sep 2026 04:55:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2086:b0:47f:96e3:530e with SMTP id ffacd0b85a97d-48488efd18fmr19364312f8f.8.1788436553272;
        Thu, 03 Sep 2026 04:55:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed38cfsm12369287f8f.19.2026.09.03.04.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:55:52 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:55:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio-mmio: synchronize callbacks during device
 reset
Message-ID: <20260903075143-mutt-send-email-mst@kernel.org>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
 <20260818040433.66986-2-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818040433.66986-2-kmehltretter@gmail.com>

On Tue, Aug 18, 2026 at 06:04:32AM +0200, Karl Mehltretter wrote:
> virtio_reset_device() promises that vq callbacks are not in progress
> once it returns, but vm_reset() only writes 0 to the status register.
> A callback that has already entered vring_interrupt() keeps running
> while the driver tears down the state it uses.
> 
> Wait for a status read to return 0, so the device has stopped raising
> interrupts, then synchronize_irq() as vp_reset() does with
> vp_synchronize_vectors().
> 
> Fixes: edfd52e63672 ("virtio: Add platform bus driver for memory mapped virtio device")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>


I htink we should  instead drop 

vp_synchronize_vectors

from vp_reset

and instead call virtio_synchronize_cbs from virtio_reset_device.



> ---
>  drivers/virtio/virtio_mmio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 510b7c4efdff8..a2ca03dbe803d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -55,6 +55,7 @@
>  #define pr_fmt(fmt) "virtio-mmio: " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
> @@ -254,6 +255,11 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +
> +	/* Wait for reset completion before flushing callbacks. */
> +	while (vm_get_status(vdev))
> +		fsleep(1000);


only needed for v3 and up

> +	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));


>  }
>  
>  
> -- 
> 2.53.0

