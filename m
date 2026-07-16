Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D8381AE4
	for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223193; cv=none; b=I2jjHJBjDT0jPivh8w7ruwYBXmTPXuF/fwy0+DdRmbEV3VEZNv0UOHJnjx6zjPfEMom5mYfYLV99mnHi1Ho5nyQCLdTTmWsuQjQTPgC/sC0tGsm8wNO+SHHHmGlWsR8ox0mN97E/bCQ3sDOwIxS/jxGpzFfF5RCowrQ1wSdy/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223193; c=relaxed/simple;
	bh=14Cq1umL0Y6RBF2SkI1K9PaiHWJyUXEl/l/NTRstlkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNA0LJRahmekR8RGuhBsh3vFq07nr8MOWNMHDfuRQYHITuL4akMlYaYBlmFY2oLIqs5jB1rHJsjZKE1X1e6Vdnj3v2K1S4ESnvyPr8rQEvF77jeiWPSAlvVMUISpwhHHTzAJ7gVovYSVSBPvaxt+fVkbO5PK2dAfgwPgd01XKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiz2TXaI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiz2TXaI"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a2dcede83so4967741b3a.3
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2026 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223188; x=1784827988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-description:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrxnv9tUHFGYCrkcPFQu3jVeHPBv/ZazS8X/HiiUaCM=;
        b=hiz2TXaIpXBXcgGSa3SksrvE1HkTf7NNmBkDfyY9m64q008ZMt84dDI0QRqzFx9lm0
         B4fizowr6GfTvY4SIgtV40fUJG0QO0YuMS2+efsthg3EBZCG5YnBYBGKMhc5QX1fdwhj
         KUgUU2z0hsjceLKl9TyenmyPrK+/7T2rNfOV27/d/4UZ/0+jf8z+1vhiAu82Qpjj9wjn
         G5cTyRoNDzTcIfDpvmJipKCfW2xJ6L8d1e5v7ywLBITJ12YuacPtFhYMFY/Eet3mMAVO
         baX/YeiWrG4epEXBIEGjeKQCc06TxXaor7oZQQx8MLaR+ntKqGlqHNRLfUHl/dCy9IHw
         SU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223188; x=1784827988;
        h=in-reply-to:content-disposition:content-description:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrxnv9tUHFGYCrkcPFQu3jVeHPBv/ZazS8X/HiiUaCM=;
        b=ouzNLimNJUWGeJyBwOfhik5shETXEKH8pfjHyrQkqvrD9th/eVNn0fwpBv9BBQNrbF
         kZ1tbbRgu6EklD2yRBXA712g4fWSCvGJzH4Of4ZyDjToyTudkO65f0+SSglRagx2B7bw
         ztnksu45rVaSNCe5c9K4UBg1d+aNj+s7t4lomQcv0Pl59KIJsX9rm3MXKXvlVL94jwyN
         CHjlLeHeLO5jJMA0liY9xMdfMlqROnH1Oot0orzgRpoip+YNR1/dFwdZvd8WfXfF3mCI
         +nPya5eWMHt0UEN5G7JaQzxtBVeuNAiWsFbvZCMBOc/cq/ZSrzge7tQalHkvIMPyaAsu
         nLHw==
X-Forwarded-Encrypted: i=1; AHgh+Rq34PlGTI/yys5FwQxJi5/Qpqm/YC7EpIhkbZBj8EtSpZabYlCdXZyOqC8Z1+QXhx6jVRxd1Hsj9zYvkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywty1XHLuGfiVTx2yli8CNrlhOaF7L6aHeaqZy9al3h15WY6uuI
	T2NTecBFJpKDMglWYuZDqQVYRqtihpffaePd9ZCJOZKaEIV28zXwHlfX
X-Gm-Gg: AfdE7cmOkbKDbU2JvpyWmTwZ1SpA7pjzLcX9TDLu/ASsffD7FrIsUAXdoAQS34ns3i5
	ILLNGcUxXR0UGwPkK4K4xx0EHEkwUVFqffoYTIUdqtyxjnffLcplknzwaui2d4QfSm6KtSel0ka
	JW3wg6lJuGC3mW3m+LNRDY05S8kilfRst3tBTOhEfhQCNwyqScGaRB74bU//lxEPUVDKZ5aYRLp
	fweLHI8qdYzdLCWArx7j61BEVZNXyXgFkhFpK3OoR3XEcYX49E2Ict+jgWjFC9Mgr15cBO5Et+c
	U0aKNH5oxmgd11snc6mxoHmikfZd0qoA5uAgswrW9LDWf4ZmPGCsZO4D7fyOHnV1EXK0a8yot5c
	n1KlJQqGBTMedLPR3vyZR4QnlLcYiYD/XsPeYe/7rqIJgFOiPGT8zyY4QcgyjL+8ShTlCTcGPHl
	PwQZVxn++huu9ohZfVWDMwN9sXmfa0xuEOFeIjS4hH7RE=
X-Received: by 2002:a05:6a20:244f:b0:3c3:9557:3b56 with SMTP id adf61e73a8af0-3c3a5e12181mr84522637.72.1784223188091;
        Thu, 16 Jul 2026 10:33:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:38ea:b937:53f6:928c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm10258037c88.4.2026.07.16.10.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:33:07 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:33:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hari Mishal <harimishal1@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Message-ID: <alkU66ViqO8pnjQQ@google.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
 <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
 <20260715120911-mutt-send-email-mst@kernel.org>
 <alfPcWKMGL-S9BRl@google.com>
 <CAMmC+=DXS=xs0CZyf+N-71NT8D51xQYatBv=dfVQC1aBohDdmA@mail.gmail.com>
 <alkTnRb9qhgcMGGi@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: avid@kernel.org>, Henrik Rydberg =?utf-8?Q?=3Crydberg?=
	=?utf-8?Q?=40bitmath=2Eorg=3E=2C__Xuan_Zhuo_=3Cxuanzhuo=40linux=2Ealibaba?=
	=?utf-8?B?LmNvbT4sIEV1Z2VuaW8gUMOpcmV6?= <eperezma@redhat.com>,   
Content-Disposition: inline
In-Reply-To: <alkTnRb9qhgcMGGi@google.com>

[ Just realized that CC was dropped in the email I was replying to, so
  restoring and resending... ]

On Thu, Jul 16, 2026 at 10:28:36AM -0700, Dmitry Torokhov wrote:
> On Thu, Jul 16, 2026 at 12:34:57PM +0200, Hari Mishal wrote:
> > > What is the failure mode if we keep the ABS_MT_SLOT capability? Does the
> > > kernel crash? And if this can cause crash then we should fix
> > > input_mt_init_slots() to reject requests for 0 slots with -EINVAL.
> > >
> > 
> > No, it doesn't crash. I think every place in the input core that touches
> > dev->mt guards against it being NULL: input_handle_abs_event() and
> > the mt_slots check in input.c, and evdev's EVIOCGMTSLOTS ioctl
> > handler all explicitly check for NULL and degrade cleanly instead of
> > dereferencing. From my understanding, the worst case is what the
> > original commit message already covers: the device advertises
> > multitouch support it can't back.
> 
> So what? I still do not see the problem. Let's say I have a device that
> properly supports multitouch and has slots, but then never sends any
> events because firmware is buggy. How would that affect anything?
> 
> If there is no crash that I would leave the driver alone.
> 
> And we need to remember that we are dealing with a hypervisor here that
> normally had higher level of trust than the VM. If it messes up we do
> not have to clean up after it. This scenario is different from user
> attaching a malicious USB device to their system and getting owned.
> 
> Thanks.
> 

-- 
Dmitry
