Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A88392811
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130649; cv=none; b=GRfwtEoaXLft0r5Zxz3WAd0wLBIRLbxBfK+3PHXUykZy4TNYnn3aw+c43KT3wD/ZanYHrhfZIJ/B8YcJSXY5hEe1CFLoj0timKW6WGaP9RMBGYydfux8xS/EHaVNVVTJp/nBUEE/GSLVUiRfBIAeDNwvvhk4zoEVcnFw7m/ftNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130649; c=relaxed/simple;
	bh=LHK/h0jlYYgt64s5qvS++l4vkfvf6EbWr3VKP/sRdxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIp41JozlzNUt8I6QSzueesV0e77n0ohf3Jxq33MVyao9d95x/XzJWDPmuPMEjDx8bq+x/vys+lVg4Nrhw447Be8VOqfhWIovA5NslTqwcvg8ga/Dtxry3ybzaMxqI8nKrPLMHVznmyRpZstLwv2sTifjcllmSyUAJUKUij1Oi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX3D3Zxi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3l6OYNG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX3D3Zxi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3l6OYNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784130647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mni4VjY2tUXuoqxcvmSaYl6Cq9LKNjDkA1J/Ott64Og=;
	b=JX3D3Zxier56aR/NKlZRE989MhizMfVvvRSCCin16hPbdN8Ejoa0I4o96VCMT+MMPYc/hV
	J/AT5f1rCavISg9RoHOv2eDB0EYSP1KnSp3YxvzueATapVe/48Rg2pkn9a3aCDfj9Okrtp
	RAalXuknDKby9jwkgc098+/vr0hEmCw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-pchUxeKkNMqdYqij0V2RBA-1; Wed, 15 Jul 2026 11:50:46 -0400
X-MC-Unique: pchUxeKkNMqdYqij0V2RBA-1
X-Mimecast-MFC-AGG-ID: pchUxeKkNMqdYqij0V2RBA_1784130645
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46fb9079a04so2885157f8f.3
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784130645; x=1784735445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mni4VjY2tUXuoqxcvmSaYl6Cq9LKNjDkA1J/Ott64Og=;
        b=c3l6OYNG4qRXIs8Uc1MSLVkJDFLQGgl7h2QUnWLmrtHRIhrXdK0lf6k6GGmeoK8WRj
         pMHyZCwbZvWR42DJGqi+Di3L+M22JWLf0ZcgZO7wCwFyOkXzjQmsvvBEdibv5uNkyHBA
         GUtGzuBrwl3D83/vTVzhB1cYmdLmTwT9B0jjk8s+90OQpT5W58xl8pZoteVlIH4LbtIu
         vR6dCYnMP9fJKXRcIJ/zMR+6Ms6/TBtwXlj4nySq/7PIjf4SmgMszbtGb3KX8+ts/Eav
         qZPbV97WEOlBIzvNsIEogrtX0h/67Fn4NTQW8Kafyps+i3CsXaKldqgarXHBA4Ht6S7K
         3xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784130645; x=1784735445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mni4VjY2tUXuoqxcvmSaYl6Cq9LKNjDkA1J/Ott64Og=;
        b=rktpI5Do3Cv6eUas6CIRVo+R0E9VB/qwvEns57CcM2jlrsWVMVzfP+GsIn/Ge5GKos
         L48pQC9NWJ8GyOj542Btw/T8Y6vW0j0lvi8XNE3WX7qfMZEinuBZ9F0tBgH0025PeWXy
         e3VUtCHyLyGC3/wtm0lS8AQ0yrFjaGdhpd4zBvG59zgiwUwLAaKy8LygBvm4iFmnHU4Z
         SBrPbn8pnKKKX8xENaKKYdt+8A5Y9Uai+YZRyIDQ4MRpiuWRRjF6YZW0EGdU/UDx2po3
         3QUA7btigSyRyXRk9fihHxnfGLwdyRwHyvGnqYur8eBkkovqym7fI7kT9NfNB9QkhJYY
         rOvA==
X-Forwarded-Encrypted: i=1; AHgh+RriSjj+vdP0LsKd1bnYmu6yWg/z30yjMUc1ni6h/Hzrv0gCU6qXPeM59G9lDaetc3izv/GTlzpB7lxn8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2pEwaSAJirU/ahMs6M5mecJC7PA/Iszl0n4cQM70qeB3IXjRb
	tJxAv1HIvkD8wQNBJsTjfoDW7KoubF6kM++uNl5saH93dZW4chHjZhHPz8A6IRyN7iHaKN34zRf
	2M7qHkU3mAjBtcauB/gM4aysJ3zRAzM8XsliE6TGDXbtcMJv/OV0e8myNSmzeOoSX
X-Gm-Gg: AfdE7clkRmvQUBkD6R88nZCkhcLCZAwVsogDb4jjQRridSoLI5WkDyuivyaVH3ddKUA
	W7mW7HTKVacgOa36CJ1wg819cuBr1bZk6fhOLmKbULLilr/Co+XgL9sxFgWUjgUgvz31o3b94xU
	HFh1DfFnlBpm9tsopD7bHUBf3+uyFjjpp+oArYoIhm1VsS/v7QgjOOVAXvECDenfntMYGnjZo74
	gd94M8V7GHHE/90Romg6rtHYsYsaE+PiAIuhA42AQ494GEISsOZ5QphqCbNxMU5iSdc8xcEyOMR
	FMJxvg4ICIElPg3uPDMFf8PtcPPULlFydvn5qUVKLgmCAnV5vKZH/MJGaAGb2gPt1tlnOalDlCS
	P+ZnJiB+kBq9jRW6QBksYGLfso2W6FQe5QSY=
X-Received: by 2002:a05:600c:46ce:b0:493:b811:e549 with SMTP id 5b1f17b1804b1-4951830a532mr99082285e9.29.1784130644836;
        Wed, 15 Jul 2026 08:50:44 -0700 (PDT)
X-Received: by 2002:a05:600c:46ce:b0:493:b811:e549 with SMTP id 5b1f17b1804b1-4951830a532mr99081795e9.29.1784130644279;
        Wed, 15 Jul 2026 08:50:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a33a926sm147346705e9.15.2026.07.15.08.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:50:43 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:50:40 -0400
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
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Message-ID: <20260715115018-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715142337.22811-3-harimishal1@gmail.com>

On Wed, Jul 15, 2026 at 04:22:41PM +0200, Hari Mishal wrote:
> nslots is derived from the ABS_MT_SLOT maximum reported by the
> virtio device. A device could report a bogus maximum (e.g. -1)
> making nslots = 0, which input_mt_init_slots() does not reject;
> it returns success without allocating any slot storage, silently
> leaving the device registered as multitouch capable with no
> backing state.

So let's disable multitouch instead?

> Reject non-positive slot counts before calling
> input_mt_init_slots().
> 
> Assisted-by: gkh_clanker:t1000
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> ---
>  drivers/virtio/virtio_input.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e682..2cc19782cdd3 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -312,6 +312,10 @@ static int virtinput_probe(struct virtio_device *vdev)
>  
>  		if (test_bit(ABS_MT_SLOT, vi->idev->absbit)) {
>  			nslots = input_abs_get_max(vi->idev, ABS_MT_SLOT) + 1;
> +			if (nslots <= 0) {
> +				err = -EINVAL;
> +				goto err_mt_init_slots;
> +			}
>  			err = input_mt_init_slots(vi->idev, nslots, 0);
>  			if (err)
>  				goto err_mt_init_slots;
> -- 
> 2.43.0

