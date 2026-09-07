Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8737F724
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819322; cv=none; b=mzT0bz6xtJeOdbC1KC/Q1mkl0lvMmUJB+/MGSrvJ/zAwDPSWUTuEng1RWh6KLFaD9GMM8Ch6YbchbWaJ8aq01788VFFfzChEDRFVUzRGU5LiiOmBwSGtb4mMHrGh2WPVrsL6ZuHYbTqsiBRPtI4oh89XfI0jKV+WFCtvBnlIBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819322; c=relaxed/simple;
	bh=xWQKezu4BREhy3j/blXwxCRCfvwvHIXrTtHnHeeaEXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk+9zLsI2/mkQwV0DGlNotuJnLNLWaJkijMxwnv2j7DpMFfc5il7f5GwHr3bDosEOybsdyBy1XVC+IRArwzJwY4CCo93JNoC1L4EJX4Y8e5ekhY8PKUrvTAVFCGFRTCvDGPixrO4He0/fTSN35aSs7/wSgprAgvbHQ6QogyEqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJqnduyv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJqnduyv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so55593685e9.3
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788819318; x=1789424118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=;
        b=rJqnduyv3+GKruEiOn2qVV1C7znyq5QrRRS8m9CUavzzgCz57d0/XAd8J+yUQrhg3O
         F0GCmdNrqMi7ytL99Rnq4dFDA58FMM9YfFX6s78vnx07rs0ylnylBPDT/qU8kkOBktKz
         yC8rRFqMDdP4lxGY3fvArsigYGjlylSkxKzCt3lVKDTLpWb2q9fCuZgzrZ2v9HAXXMpY
         RzL3zjzfevdli53ZcpxkIU6hS2QkZSuHgHOkt1YtMcnaty4fQzT2TwEBmQMAkVQ4etd9
         D1dXx3OwuRL5WVEuXzTf0xpLuI6Q6CGwc62QzAJzVWS3oY0n1RFIkjwDj+ij9CvKeAgv
         dl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819318; x=1789424118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=;
        b=tMj44U8ZHvf9uj/4RbvGY5Z22ZBvONN84RiT0x1AXYnWidhd8f30TDR7o7r5t1m74q
         +qqS9RpUQfMjQGVO2awtYfM9jlkOc2L1B4A7eo96zR5qBGrs1Uk2yhmTtEscRa1y/gOi
         Wj7mEVaR66yBSmDxReGM/C9ROke8UGwlwlpqUnPS4W7cqMBnRbrR+vRhb17ZJd6D2B0Z
         qPSgVwB20kuaCi8AOvFiyKq9LjMKZJchgWuV9fipEq/xiRKo/zVGmJy9TfmDfOAGZhND
         cBscldU86uAxtwZcKsvu3EPIvLEM/0LubuK5H4gC+6AyJxRwBf00I3u45Tom1/aKn4Vb
         7fkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgujLWbPB/vAXSM+oeGmLznmcSn2ilF5Az3aHReyCtj9Aex7RlduAfFDubqhJPPl0nOmd49w1XHSctVg==@vger.kernel.org
X-Gm-Message-State: AFuF++kWg3XWeNn0eDfjBAQwCyG+eQzkk0iJsDuf0IvKdxoDEBngwQKA
	4+4LOzCraRAC2LjYR7OB02MOYS0LsO7dY3ajdWVqEZ3KRsw73PBPIzl7
X-Gm-Gg: AYBFou1wmSdx8xEJ6ree0LCgwhsznaDI/dTUiDnEFRdBcNQIkzMg8G7tuwO0lQwTq2p
	HN65paCMMC32n4e0Vv9gp66/8otNnNtOCmMPHF87DNcD4+hhZ/Hi0EYZMEVw+7J0Xzua/HRNmjI
	/6CUk08GtU4L7lMaXLwbEuHboAPuwvqXtvMeG0d+Be6kGBsWicUSzAabjC913HpeJricwE6oepD
	H+8PAzZZIcxOhgOhXcZhrrAXtqbZLhIl+WWhcKjudCFY09OhD/CLRlfbGN+qx4PyIdU0An+UBNQ
	I/bD0JCzgjucDmfLKpz1xMGvbAC5OSE/gYvSJCIgV8d/4iDBB1alBqMbWGhSvYRE7xg5iAXqtef
	/UouBQk2eqTqmZNZCCF9z84oxHWoUc0gsxKvYcyP5s39QD8Nl/ZRimBApmsHUQ8pOmZKM6bhvw/
	zs8a98aEAnEr7jyLImMGukBrEHEyMJKs6dUb9OEhTB764TzkmC5uSaRM0TYE1+EJbJQyNxJ/s5O
	ROxYgl5klzkqz0pX97qwLsZEQR3g/6ULX1NqPFvg+MWEeQGM/dNVaEbIX6pM9gMIYhiJqiHAS7E
	IQivPpEXt9B/gzBWyxxmrSVU2Igtp4jYJvchxboquW2fnZdeKee828Il2dSq8/UuRS+qEUzDYK5
	t
X-Received: by 2002:a05:600c:8012:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49cf826818dmr259779075e9.11.1788819318162;
        Mon, 07 Sep 2026 15:15:18 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm29993570f8f.8.2026.09.07.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:15:17 -0700 (PDT)
Date: Tue, 8 Sep 2026 00:15:14 +0200
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
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <ap82pFlX8enNG0gZ@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907174559-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 05:46:07PM +0100, Michael S. Tsirkin wrote:
> > Assisted-by: LLM
> 
> which llm and which agent?
> 

Claude Code and OpenAI Codex, each with their current models.

I switch between them and let one do review, the other
helps with implementation.

"Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
gives now.

Thanks,
Karl
