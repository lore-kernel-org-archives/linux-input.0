Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8D47ACC0
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436393; cv=none; b=XKhfi1xhBDtlgz+yV4rX1WmZBLhcwnFIwDI32hp7PZLeavwuYD+b6ijmlzA568Ys/i599J12VDhUGl/G4Gc9GyWO1uQjIvWMT0kQ5kU+cuN/BqrdWiTofrXPEpW0cMX9GJiM0Fmfe4Xe3FnkboledZecdqtehyojdQPzYPlU4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436393; c=relaxed/simple;
	bh=NXdwaN0ZLM9X4EiI3vGfuaCSH/ohhs7TAIZQWzgxxSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2DzQqecQjDtIVyrTub6yfrco0ewtPTT0LtIQ1EageUVQVxkAuLF3wG7VZZ2D6yhgE2JfXg2S9uqb7T0RrnKrq6Sej1pfu7Z5+f/V4gh312G+hffLjRazT4rZzHD7JtQoBJT6Ukv5k7ZuoGMJnNyEuxkJdTCXM4lkpz7QrpbtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTqGY2fR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSJWg+Uw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTqGY2fR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSJWg+Uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788436388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zt5TFwXrVFNhjDyjDPH7hfKRxLknQjHaFWOGKgUQ+7s=;
	b=JTqGY2fRMNPXsUrhYqtgi5lmOx4faRPVd0RhOkWIXCVLOmaUi3mzrJUpSWXvBdARSPukf2
	S0H9Ckk0BJfvTbPk61NLUHXfFMlEXVVkrC/B/7qfx17QwWdOreIf/gd+nq5YriAM3C9iW5
	Hk8kLq32ujBCvn5737Mxc8TahrbP2wo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-cLyH31nxOHmfqjZ2H041tg-1; Thu, 03 Sep 2026 07:53:07 -0400
X-MC-Unique: cLyH31nxOHmfqjZ2H041tg-1
X-Mimecast-MFC-AGG-ID: cLyH31nxOHmfqjZ2H041tg_1788436386
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cced8309bso18623575e9.3
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788436386; x=1789041186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zt5TFwXrVFNhjDyjDPH7hfKRxLknQjHaFWOGKgUQ+7s=;
        b=HSJWg+UwLdFx70G6p8NRWYydcRL/sLRBWegSeaivfBIOX8AIia7fF8uzo/uziuIrUF
         8kHDPU89ehrspTBN2VSbwGrXlpK8Czw/UvHz/lkdRNAV+Z2uQ43KGR87yswdzP4TUhk+
         u8WsZjB84XTW6flkqRXew7dGmHkXacR+6PkYPH/vXYQ9MEP/Odpuq2DTnhhLIvQSTJut
         XwOUL2qL3dRKtKoWmOpCFA+sQguzWbTDSbikWxUmnJLM4LIhYcoWHx7cmznXrUpf/zUt
         OdGrEGaF9QFuNBRm/MQ3WlooT0GrZwobRnh93CLlJD4eeiY8EJ3VKfs9R39Kgzihojz0
         VSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436386; x=1789041186;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zt5TFwXrVFNhjDyjDPH7hfKRxLknQjHaFWOGKgUQ+7s=;
        b=HtW68OpBEcTTLueGPywjzOg4aR4yCWokH8fwuYES+l0YKq41SFm2bJtVOBwF6u2N1D
         4ybFib02LET+a8bgnmq5P2j/JqfqfG/kodcGDp/bEN/pmPWv7pojWfz33GpXdgS2NKm0
         Ikuc+TkkS051nQwQ53o25iZevzHzRcfvQOORk+ZepuvupZI8TBHRK8EiH+olVPXmv7v7
         08mHD2yA7RDPvU+u28z/N/+0Xi37kxiY+bfGATSg8uCL4MmjJ/Wo1eQLkh4ktz7cVyvo
         I0kiN++LtPH0r8GlS/jEzwVpWwJhqa/qS1jqEoXfYgPbp3Ac6XB6grI/2FaR7LKhUSlk
         U68Q==
X-Forwarded-Encrypted: i=1; AKwUvBzxI8nTk768d4DTMZ1EA/Drx35jOctBSof02o1YTV61/MCSS+wTlr3/V8Jk/FzymTh8ZjXagd/0MsvzWA==@vger.kernel.org
X-Gm-Message-State: AFuF++kg9o7DhK39L1GkNbxXl2qCLSPWqkON083oOzos85LFRzde1WnQ
	sZ9j3yxzWWlkEUu8VMJwDfMpn3YO30CYwKZVwozSLZiz/UJ8uIB7APVi0kiqiGoMEKMEdw3C1E6
	ivLS0O5LKN0uygj0I33u6Pi9ppGE6X8U7olqsWD8zb2egOBT4aHtGMjtXD7h313JN
X-Gm-Gg: AYBFou2tHI5NQpSWSs9m14bZ/hX3oMuaMWA1A1sQcyTVUlO6RtfSaj1xpaaTADr1Kh4
	C9g/ecSNeFQ7hunF1sKtSFjJllO4P0ijmfW5Bl3k80KVUKPCYWyBuxb0T9WbsJ+X9JoyHwKQSls
	4lBB+FT7OQ1DRsJPsGbhmtUhxw8xQ4FTf6t5N3oxiuZIJ26ISuwGoOJ6c7wBpg03/p2Jl+AOv/H
	jKni+A4qPALA4twx2YCLB7itrpeenvFFVufv7Q8eT/46W2p8EnjbrfsmtsSWWv/6dsQpD6Rc48c
	3cg6dyiqu+USJq2icBu+88aTbU7ur642vFG2FikpGqxF0KvA5Cmso8d4OjQa2PGqih9/Cjt20FJ
	0yoX5yAsvUS5ahTP/xfGIEUE=
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr146699055e9.4.1788436385766;
        Thu, 03 Sep 2026 04:53:05 -0700 (PDT)
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr146698175e9.4.1788436385256;
        Thu, 03 Sep 2026 04:53:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm85689205e9.0.2026.09.03.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:53:04 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:53:01 -0400
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
Message-ID: <20260903075247-mutt-send-email-mst@kernel.org>
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
> Together these patches fix the use after free on virtio-pci

pci has synchronize on reset already

> and
> virtio-mmio. Classic virtio-ccw and other transports still
> do not provide the documented guarantee.
> 
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

