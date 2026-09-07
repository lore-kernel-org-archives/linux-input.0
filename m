Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF326437107
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817287; cv=none; b=tGyI+2qmO1HA1kmJM2XLHrze+J0JqWJvPZ7+CFaE+nDHr3HJcotFusf9bW83LrwVHR4yDRjoE24ZF0M4R4+/4bfoKzkFHOx8LUHbW1gM2W9CRajpNF5eUjHv8pPAQohDGiefTcyeErJ8IZI3My0K2bXL4ldmNZXdtJfxdC7p9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817287; c=relaxed/simple;
	bh=1i31BeRMFT9Vp3AcAN/RmvKH0I2VjZNU1gijNLV1tQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4ZrBk7kBIl5blZOmm05CFg3wa8vzp2XnyftIR/hbxigM7jvFet+pzI3COyWlVzenT7QGJI4a9sEWy5eSd/fKTNbrOQ6h+y49gLPV3Ot+gxDqw/cift65MWT4W5ykSXiA5jM8pjNG4/8gqz/Uvcsi3p1Y4O4FMbU3qrlqhC02+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAKIKa1Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwbZ/tou; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAKIKa1Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwbZ/tou"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
	b=cAKIKa1ZYohFm/NhUl+RG8nJyjM+r8RcUeq4UfqyixAgMboSjp7T8ydcjktr1rURruCSXP
	arTs/cHbaiFjWflxndWbwgjlJzxvq0mk/CX9uxR+cVjmx+l4n6FV9nzSv9IgReOiCTwXYD
	C20ACJFffn2Q91m/Oqniige6GyrYEVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-5N-fIcBfPX6cHc_BkV_TiQ-1; Mon, 07 Sep 2026 17:41:22 -0400
X-MC-Unique: 5N-fIcBfPX6cHc_BkV_TiQ-1
X-Mimecast-MFC-AGG-ID: 5N-fIcBfPX6cHc_BkV_TiQ_1788817281
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccf17d3b0so27672565e9.3
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788817281; x=1789422081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
        b=KwbZ/touk+AoUhpw0CA+kuWP4KJaWRcAs0VioiQxmHKxPu3u2ryvllNKDnaMU1GWu3
         U1pvRlogoiJOzpRfgLS1XYugdwusm4fV32DY63FJwQOndhcRbD6css1FjEgq5muyJMrm
         rodi7NG6Vsxa71/PB6KOwoVUDzb3cka4Pobt+euydUgxhycKec9zbo1CuzwB31lHlO1n
         zIllMmJXB0vgkrY7Lw+Gu9QxW7QIp6z99phXK3b33/GVYptr4qxyC9lu8a1LKea3BcQU
         zk9Rs1JO8+xIPDqqhGuNW+Bk77hTMpTDUFbY5Hvl/YGOhhNpGV8DPQqARGwNiiyFCkcX
         1+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817281; x=1789422081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaECoODu5PWLeAxmwxwy2TeJHbPjZIpe/fjVw/Ok5Aw=;
        b=cpp0TTBnkPSP3YARJ6Al//nc3mUwvKtfjJhHrsoTxwl6h2eqV3hS2iScM/1qqlkwD/
         M/fAJDpqR7wp4Etq4iLlh3pfeYvOK/yn3gFnDL17trXSzj53wPoNnVZvphrBkn1Cd9fQ
         CFlG10IeG6prZ+1XIX0b+qtlxOJE6LsgRu8HRG1AM7A8186NMJExcLUhZn99PwMB5oCO
         CNsDvyxGkvsh6NKPtz62ANCMz/GrnBxtqFO97fkDu6MugWrTiUZrm99MxIzSVRCdG6s4
         IMY4plrVncK+cxNFbkY8JGcD3QRx1WfjuKkkQOwmeq5sY0R7if0I0c9FMxv2ypvnaE7W
         gt5A==
X-Forwarded-Encrypted: i=1; AKwUvByE+KxdVf91RGPWw4ZhQtzvyITuUwfRdTuwsDr5Mz3M4+e/HSBz1eBIgB9K0H7RFc5AV+Bci5dfeCoCmA==@vger.kernel.org
X-Gm-Message-State: AFuF++lQrnXWcRdu43CAaFlnHKr0E6ZJpzwv4IkVTe1DxtH25K2Shc4K
	TQ2KdxHU9Esogy2lL2cRbmRhTpTs7of5dt4VJv3q40wbF65Ig6VTJoc5N7Pu9iqRERIzERI+8be
	FnGhCjYG3I+bfr8SgOv4Jl8p1zq2HXtJmZZpgnRviRdM339WkhT2Yt6CSqyU/fj8b
X-Gm-Gg: AYBFou33FLotA9kOE523FyyXPA+y6nPhFcmKKIEsrzj1Vjax3ACwxJwsBQOXxJSz3PU
	I5NnQfMRmmulrAS3er1h5TMj1FkS4Xc/7Sk3gAwDYc6G97hSUNmQxQN+3VKz69mClQ8+9tbsu7Y
	kEv2ovim+zFkkm8PiJK4IaQ0WBEKXz/ia8s76zF+J8fSK++qrOY4ZrjFDZGm/sLDLZRvb+Ch+Rp
	8Pa4bSp8dATWcBCKxyYBPTAs+gz0omk3IYzTtApi2pCEErY9ERm8SOJeo9z3mJfXuX3x7LMWNH2
	ix6Y6JXqRECarXMJMfWRTueCiVN0NNsxaWjcjvEuef3KKe1ZfeuOlg2pleXNVYTejJLOZdAPKKn
	xkX5OOjGl6y5nARgvVPQjEv0=
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765905e9.5.1788817281003;
        Mon, 07 Sep 2026 14:41:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3d92:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49d0726cd2emr320765175e9.5.1788817280462;
        Mon, 07 Sep 2026 14:41:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm892607965e9.0.2026.09.07.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:41:19 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:41:15 -0400
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
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260907174032-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
 <ap8rCQII9fASEosZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap8rCQII9fASEosZ@gmail.com>

On Mon, Sep 07, 2026 at 11:23:19PM +0200, Karl Mehltretter wrote:
> On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> > got all 3 patches now. it's a good start, thanks, but they need
> > a bit more work, in particular addressing sashiko comments.
> > I'd also prefer patch 1 to be split: moving code from pci to core
> > is separate from ccw fixes.
> > 
> > Pls write or at least edit commit log messages yourself,
> > after reviewing Documentation/process/coding-assistants.rst
> > 
> 
> Thank you for the review and feedback. I'll work on a v2 now.
> 
> Karl

FYI I picked the virtio input patch, no need to repost that.
If you want to fix the evt leak, it can be a separate patch.

-- 
MST

