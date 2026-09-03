Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D8456DF3
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434940; cv=none; b=kU9vaZfXegmpgQzmlrm1U9kh/jO7GYik3c61sjJ+J6xKpVVElIQvYCOVr+3BlLb9QQ8QEOGhiN15Y4ItosWwlH/e/j4Y9i5jmrpYTRdGFdL9SWiUXOT3XvIGjXNafHMgZweyZdndq64La4jtG6y7KEabFTdGaU4RQEEPsRPxLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434940; c=relaxed/simple;
	bh=izIoxQQPPhWNBGA2zN0F8lnUVzBbBYH0WQkACSGnoZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiXryt/tDODvc8VY384iXvdIjR6tdpMtaIRElMD0gvgtP0LPWrLO74yrYvuehcCC2ScxJT636iKRIrba1eVid8kMw360JjGQ8DSBtwW5mnRuzK06H1qskDEYQljvOZClypM3zomnwMARsF7DEKGAYO5VBqvQ0S1LmGO1Dsq30S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E55vgtrm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mBiJN+kQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E55vgtrm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mBiJN+kQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788434936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7VfWNLPahHWyir7K1ES/2Ml0Y11JC1XZzjOhYDml2w=;
	b=E55vgtrmuFTnJv5nT2Xik36meiJYuJ+Fqnwd4yo9q/CQ2F1/pQb3yMLrpjr/ZQII1n+D7E
	sEEerm6HVHP6IYyKLoq1e4VBNx/f5jlS3KysxMZ/iUaReXPKV78dJpHf6zXyDJEsLjpi3K
	hpw+noYgnWZkHQ64nG8dY6dMDD08yEw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223--u30YNXuMQC2AZyixqMBWw-1; Thu, 03 Sep 2026 07:28:55 -0400
X-MC-Unique: -u30YNXuMQC2AZyixqMBWw-1
X-Mimecast-MFC-AGG-ID: -u30YNXuMQC2AZyixqMBWw_1788434934
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49b0d7a07acso24465545e9.3
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 04:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788434934; x=1789039734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S7VfWNLPahHWyir7K1ES/2Ml0Y11JC1XZzjOhYDml2w=;
        b=mBiJN+kQCJmMiEEXkDgOC9YcE9yTwHgFPLSZ93qjlVs/RTljHaqhybSE617rXQaN14
         GXxxEUCqC+MxJt9mXmfVG/ngl50asEegZgpKl2ttGUCLRSH8yGutK8yir46MutrJUgRt
         hxxbVbXkoUTaAHFvBuVt7nTA5YICOCVUfHduQdE84dPU3bLuDkHRLoVPVtaeOs+tggBq
         PGNnY95XBfKSInAf5G3g8oMvVoXRhH8YFpZYfe4eti4EU+ooL153fzySk1hv9U9NBzv2
         cQ3UaxNSNH2XM6Y0NRei1NkJSXd/cbjP15ktRjKqPXHvk1XJvC4x9aD3RiFmlhmly2ZN
         RuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788434934; x=1789039734;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7VfWNLPahHWyir7K1ES/2Ml0Y11JC1XZzjOhYDml2w=;
        b=b+PcXrjZRC+RNsMR5z5W6111Rx4unGRrHS3TIO2oP19Axvka7x5cK55MoYLEi9sJLD
         5eCbVXLXrk/T/Y2G4ZBOw10xNTBimmsDH1x/S+3jT6mBnIeWqGwP+z/7l+SYAnFRbGxm
         teqwweTKtfX+TZQn5YuQiba+y0WK121uOodogBPVR1RNmxty5SfJjsRI2WbcL/2cWcsq
         2txpvhJIQ4mJPbHFwH4HcxlEoMFmrIRi6eS1bs2w30rjxo3dCNgjv1gwVGAQPYSneIz8
         OinhAURkZjr+NzhEEKxnRcAY6G6S5UAxp7DF9nySHncMltkQLvKS4okVTbMH+6dcY82c
         uHyw==
X-Forwarded-Encrypted: i=1; AKwUvBxBZnOrLiAmNQndur5tOe+Tp2uwS4xwbU0poPWTI+yXB8Q2sV3cNFIIaSf0FziNDTDV4E8cfgphMVcYKg==@vger.kernel.org
X-Gm-Message-State: AFuF++mQ8DLwLdKa//nq5shzGT3k+YQiaun+9tGuU7vAf29bIV4GzT2S
	8yuXsqPq+lEqwE/FXbFqJIeZ/2bkVgbjH12DJDlQ6V/KP/NAnK1OGRVkzRVXHDwQcsEitVWVGSM
	qVExvWRkaQO+9Y5Qw2TOWYVYBCuLtr7f5JX0zhVapoWx9dNkvSgGcrqSAXolmDNXX
X-Gm-Gg: AYBFou3fAMFcVQG0jwqf3IIT2MpQO7jHoe+K9dWvn/DG6bPjMPjKfb1TSXzUkV3Ewya
	nBNvx+RbtYDSEoe+sBk2GLZZcYbFed0/powwgPkg6dLheR0wMd9UW4W3vLWEXP4TiQWGWnraXzU
	jj6fH8mKdCtuBkNUJfk+MKx08slOuP4Ekd4rYV+A2/O2j8j+5vIpsPB5TV/h2LlY5Vqh5C9Ipu/
	hqwc2Ct+YyES8HeXWOvZgf1xTXlplIFNuGOp6OIeAc9qTBy2w1hUMrmp0jXwQnuIJzgdHRmsdC/
	L/0vkUqSGUQJC5nREFfsx9vDDOo//HVQIHxWTReq3iESe+vLIpq8W5nYQHGmgRIkfV83Am4zOqW
	wMqrEeVYNdgdVu/endQFTo3o=
X-Received: by 2002:a05:600c:608c:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49ce5826c6amr235855335e9.16.1788434933511;
        Thu, 03 Sep 2026 04:28:53 -0700 (PDT)
X-Received: by 2002:a05:600c:608c:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49ce5826c6amr235853945e9.16.1788434932899;
        Thu, 03 Sep 2026 04:28:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023edsm62587755e9.7.2026.09.03.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:28:51 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:28:48 -0400
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
Message-ID: <20260903072404-mutt-send-email-mst@kernel.org>
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

this is only required for transport version 3.


> +	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));
>  }
>  
>  
> -- 
> 2.53.0

