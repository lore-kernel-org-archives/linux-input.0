Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918C366542
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712369; cv=none; b=RV/VI1pzTyaJ6XzACHQTacqpAi6vsW2ck4YiGREdiiduWDDTRrHXaLCfmjKwOQRo2QIPoiKL6nJ3f52YB0fdk6stWqHHmgtMxZcpfo7mRIgdId4Sh/kcmu00mGkoQWRW3DvG/ePKsD48gBICSpDp9r69q9LR3x2qeABzknBhwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712369; c=relaxed/simple;
	bh=VC9CS50hEkPgNN2KRwyNAMzImJHMiYhWfiuDpnpliw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IThogdINeCbbBL2ZEVzHZ2c7Ey6eWKOaQlFuhLggX2dpvhNgha0ON+SLpPua/89Z/i6ACm7rEVQWxjqWNsYkC8xtWUwbFOnq65Ix2rUztlaroZ720E/DL2r+xu9lK8FX/ViTuqQpw03s1ikzc+c2MzkqpwUkxYoWRHisNX7/sRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaRAjTK8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaRAjTK8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso23361495e9.3
        for <linux-input@vger.kernel.org>; Sun, 06 Sep 2026 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788712364; x=1789317164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=;
        b=qaRAjTK8Gl9qdB2NOyEyV9nOSsFGJeUA9eZ/2aZ06snn8uHZ+JTqqP9KEYdvEetq1K
         ks2p/PxsJ0P7cY9wOJq77cghACviGLg4vtBEGYnzkS3OuZi6yt7teb2zLbsqJdulZxNC
         n97SiAFduflUhXxPDIZTzC1Z7iPU9mrsrpsQXPKhsLsmb86Z3m0uXq0CSJpGx+fopu9S
         wvAvdt+SqsWW/l/T18gMcN0qwQKxdqdAJa8b2lmVAb1KJ/N3sH2mkkJPz75lUMmtVIqZ
         51NmQjr+VBfU+mOPsSOiK9uFBE+XNwkOmKhBA2PRBAmFVSG3sgAyDrPlz/DprkqsF7bu
         V0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712364; x=1789317164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=;
        b=bnYJ6EwF294AyK5p+n6SQ/ii8bB/qLOe5UgADuVPbqfEpNeesV4oQ4p3JldxmbeEGJ
         nWLS0YGU7ZyvxAZiUFo9KtmncEtVVJIvqf2pI52Od0XOCaKFSJx2iyzZyy+ak97/++xt
         XxAP0bnpeF2+aGBp4SQqSzUWAR3G1ib5r6wjdEx36zjk6PaNgffrXvv93uTZC52xReoZ
         oRwSVlnWrGNVuQ+0z+fHB3QCzT43zNCrKsEE4NN0G2ycpJbFFBackMip8RzXHtqSsTtJ
         LEecaCoHDxHb7g2Q3O1ZhvkZS6THxwGiVDs8/isZk4x1EnvsMgBf9RSw6cyHp3mYEWcK
         A0zA==
X-Forwarded-Encrypted: i=1; AKwUvBz5lnXKb5DUZNtSkCVYNogW3ep0vqNlNoGWnx45RUyo5LmdJMbcF6kLzjg+MCLaj4veZxsSnpm7/9K2Sw==@vger.kernel.org
X-Gm-Message-State: AFuF++lB4bwlRM1nQda+rvjqmGXTFeLeofMLKNUe3+/7fjrt24n93YjF
	n+g1N08iNFOqCbYg2jgPgfa0DMqobdpCnkoPjiL+iAAXb+m9fLKv7gve
X-Gm-Gg: AYBFou2UlCucYomuqlX5RvZscopNi5TIfzS+HUsla+xCkaDMH1DFSpIdCw/vGXTZeR/
	/ISTBIL6qQVBoe+lnAzekk6NbTdrPg3kjlZ+qNMU5fb34TmqQHeDnYuQTqTeB1++yns+kjjevDy
	VL7zt4QBIHErVhO1XBpi5TqD9bhFvZTuplpGe5RO/mOIW1ALiC1JV3B2ZU+U5250BSt4KsNz2S8
	jdCUTONKMxOL4vG9cMJbCuc0PgOWKybKIcUo06LLN1T5rx66hrTBltHmvyGRCj3lTTmIEyoicXl
	u/dqiZ89HZJa8Vdi4Plye9eFLXL8xH8+AT1x94RDUGOkcYMmSYRhqb3RN7mYn9E5BY7u7ufstGd
	WiO/Kon8FXrWR6EGj6/w+ezR50w8mU+3VKRn0cdpznrpDibPvoAfsIB91bJPhcyRGIv1icbnCR7
	vkQOE3nqe8Lt+Sr80fQFk9hbBOp8C+dibW6HW1WBTBeGAC3YqErhP1oCfe5auSxvjeyp5s5j8IK
	EH1Mnlr9fDQempbxzT+vYux04taH50SY7gzacCsg4HUKLgvSzAvkcI7gUxQQiblPEXDRznwt7fF
	mma+DlgOU7EweG3PwyqcG0M0SXtFMs0J6HLHZWrkSwgXx+GvWjEdGKy97zeJOBMiCmeQ/fCjQPZ
	n3siQ
X-Received: by 2002:a05:600c:8b04:b0:49c:fc6c:be11 with SMTP id 5b1f17b1804b1-49cfc6cc0c3mr138648845e9.23.1788712363826;
        Sun, 06 Sep 2026 09:32:43 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm21761428f8f.8.2026.09.06.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:32:43 -0700 (PDT)
Date: Sun, 6 Sep 2026 18:32:40 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <ap2VJkoIsBbsqcNm@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260906025249-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906025249-mutt-send-email-mst@kernel.org>

On Sun, Sep 06, 2026 at 02:53:05AM +0100, Michael S. Tsirkin wrote:
> You didn't send patch 3.
> 

I resent it to just you now. Mail must have gotton lost somewhere.

If all else fails, it's on lore:
https://lore.kernel.org/r/20260905152059.89560-4-kmehltretter@gmail.com/

Thanks,
Karl
