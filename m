Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A80472798
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131031; cv=none; b=nCSNpr7yA50P1YncHKwK2WyaOppP4ZCUn1Gee8+sTKDWMFZOSfiayeAVoxpb69PsI3vakXkmOKYUVAx3aytW80AcKYZtT+6BvRxeX5Zhsff+nVXpxlGjpPpikPk6FGl/zmkgckQTDhVjVC5QLU+femaERCUaArMRf8ZxEvtRFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131031; c=relaxed/simple;
	bh=uv/zLXnCvLIlm5SSXwTVSkUYz8GZAW9tYkJKFd4w0vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR9fQHH3xBCJJg4yxa6spUNh3ThxbLexobOJcEvR7avWlUICDGAFeOS7BRtmgBpbkhr/ayfgcOVNMwBKACO6/sxVV2OwkgtAs8RxQ2k4wG4kqB/yWw0qugvWkhLpY1NP42L+xeUXPRMh/DLtGM5Zp3GsBF2h5PkrEAtoMWzFod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8EB40I2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/DR6Xda; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8EB40I2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/DR6Xda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784131028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QucJ8nQZseawvH/pWqtNGkyG0ZJfjIBnQLKskMGohYU=;
	b=A8EB40I2G4NZqQIzR0vTN0o2F88BianjBtm9tZwrJaHxPF1ymJHFKA1lNE5ysxlxXuJu3w
	5w0/vZnn3UPKG4OO1XSnFyv7yhD85zxG8TNLtDTM4Y1xowiuwVs2fehXS0ZSgGhkboBczp
	mRWRRotBdDGfiTfTxiADYfBst+rZohs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-AOt2S61SMimoveplTB9sog-1; Wed, 15 Jul 2026 11:57:07 -0400
X-MC-Unique: AOt2S61SMimoveplTB9sog-1
X-Mimecast-MFC-AGG-ID: AOt2S61SMimoveplTB9sog_1784131026
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso42695365e9.3
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784131026; x=1784735826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QucJ8nQZseawvH/pWqtNGkyG0ZJfjIBnQLKskMGohYU=;
        b=b/DR6XdaajLaL6gRKx+M1hLJEyXDErTNEicTWNKT4QZlj4ZXTfnJP9HfAMhtozJ5CR
         MwMi2JKPC8Z072Hm8yqt+TdAJABqJdmP2Y5tU7JXUJiHmpcU8OBfdmUnKsjpD1Yg8ubc
         jJw4kZwtrWbcmkJp6D2enPZys5iNhhcis0Le6Qy+EOh8A5P9gyYWGVp2GVrjZlBwKGUF
         52TZoaV1GY7ZpZyWQF4UpqCzRptrMchhl4zOO1OQoEy0h3EX/y52wsqdv9CTf2X8SgSW
         svneBPKac6XCTtgfyG6xZeYr/1Q3izu4D7uNPb0ommGxaLXTOGAg2gtrFZl3VB8d5gFO
         IDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131026; x=1784735826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QucJ8nQZseawvH/pWqtNGkyG0ZJfjIBnQLKskMGohYU=;
        b=K6G7/OHgJSzBZSa4G4san2tdlQS2sZmj8SLmo8vr2EBbEHLCDA+tggS74TlopvGLwg
         CxcAeu47hOTMCgSLmJ7zRVP7+tgm1ggo8OTfLXfSmZ6yfu4Z4Cmz2ygL0A91e3Px++TC
         4Ovf54v6BaCf8aJzB9ak+3FqyaCYsboeheeNHr+9cpufiZ9bjv6AKT29ZWIf45zOiPgZ
         4BGMnpdj3pbH/9FDCTCdwITT4nsM7q66mCnVeORjrvIoagcHAYkAW9Yp+0LYKfvrrnlX
         H7Tt3WrupUld0eOZBdja7Cz1bKFjaoneetWj5bjcGSztEGjqWW6aa4NyBSx+OATPURr/
         4S/g==
X-Forwarded-Encrypted: i=1; AHgh+RrqKwgpzqbDUsj7CJn+aWOs3nC6hRrSND5YZrHBSE4r7arEFiup28DBmdUYBCbs6mSXlnaroOiQVF1m5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrauM3D48UVku/Fzky46eggP1K0ShuC9+ZHx7xRjKMaMp/fTUg
	9eRC7ieB3mndWMR/AMyqj9xxFKybunQ0I1pnlNSKxSeIRylc2AmPyhSFyU6HUbqDEAJZdANOmFd
	OMizmf7ZRqjaP9wZjgiE9cleHMipSdLeJOzhOcgRuyoyEnwPbhZAxUCnXvM16yK1X
X-Gm-Gg: AfdE7cl4drqYWWH3t5aNQig4J57EJA5La3JXbxfq94WBeKSLQFYXi5MjzSe8NCUabiJ
	yueaTqgyZziViXpy4sMw25U3dwzjb9tALaz1UaSFiZcIUdEk7Ignvtvwz1UAbUKidUe5Qdl9Qz7
	w4qw8Ax2PmOu498jciHvJPxHh5EguY1LeJEKRb8GDhxhFNqpZnnurh+unJ6EEWp2dI/ZezYsTYB
	SnKnmq1goZUkWAdbGvIPOuLSI1vtVpZU7QyeUX6tMC1rTnhwGWaWrpsoqnt/wfd9E32zyf9uauA
	Fjd7PnhirwyREdv6oTw7hCSCB7Fd6wjFK6XxaCo+5MQoo64y2rbD2GzBwWsJYvlCDBjdMDVTRna
	wyZfLYIelpf9u/05MOUpNYQ3nd3eMyFt73gw=
X-Received: by 2002:a05:600c:4e93:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4953c286bbemr40012465e9.26.1784131026028;
        Wed, 15 Jul 2026 08:57:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4e93:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4953c286bbemr40012045e9.26.1784131025583;
        Wed, 15 Jul 2026 08:57:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508731fcdsm140971355e9.4.2026.07.15.08.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:57:05 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:57:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hari Mishal <harimishal1@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 1/4] virtio-mem: validate device-reported block size
Message-ID: <20260715115206-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-2-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715142337.22811-2-harimishal1@gmail.com>

On Wed, Jul 15, 2026 at 04:22:40PM +0200, Hari Mishal wrote:
> The device_block_size read from the virtio-mem config space is used
> as a divisor and also in ALIGN_DOWN() further down the code path in
> the driver without further validation. A zero value leads to a division
> by zero, and a non-power-of-two value corrupts the ALIGN_DOWN() bitmask
> arithmetic leading to a misreporting of guest usable guest ram, post
> crash. Reject both at init time instead of trusting the device.
> 
> Assisted-by: gkh_clanker:t1000
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> ---
>  drivers/virtio/virtio_mem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 11c441501582..43d12ec7c323 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2847,6 +2847,13 @@ static int virtio_mem_init(struct virtio_mem *vm)
>  			&vm->plugged_size);
>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
>  			&vm->device_block_size);
> +	if (!vm->device_block_size ||
> +	    !is_power_of_2(vm->device_block_size)) {

0 is not a power of 2, why do we need to check twice?

> +		dev_err(&vm->vdev->dev,
> +			"invalid device block size: 0x%llx\n",
> +			(unsigned long long)vm->device_block_size);
> +		return -EINVAL;
> +	}
>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
>  			&node_id);
>  	vm->nid = virtio_mem_translate_node_id(vm, node_id);
> -- 
> 2.43.0

