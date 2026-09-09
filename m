Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E5430302
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985656; cv=none; b=oLAVDQstUaoMvXAnZQ92moH2XW6Jd69kzUJzitJRpDj3pqQjzTTHM9ouWtEvxuSsxxG4W0kl9+3oNYhwrpfx7GIpL1+kh5XVyZXqkXk1Szf3ET97if6efwkP7qtal6q5HvRd6kyOE/XTtylkXBJv8jMbdDZtui7G8i/slb735AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985656; c=relaxed/simple;
	bh=QwhogU0EtLUZ6ngOGdOZVnFb3o8VkGZfi9CXG4Khs/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpuXWWlsDB8oYg4+CY/9lldAeEDgnOQo8VnDW5wQtsemd3kaj3lA15FrAD27b/Pho9w1xl+3Zsvlbk/QtguaLwiOZ+Ci3mJHwSOks2k+2CpyNezwH34f663pelo1hxCGZtCrglchg34uIqiZw162pLqMJtC91MU3Rj9EGLN8yr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/j00O8M; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/j00O8M"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso56158265e9.2
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788985648; x=1789590448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2NRvs41+5uPFlOeoWPYyoihSNfHIDwMg8K54gWzgpRo=;
        b=Q/j00O8MYPiim6h9ESKjmpBRcrr9UWgDUIlo/sb4mo8bv/zek0bBWQAf7VmVZh19iN
         sSpxx/MDJBb/y0Tuh28DRdTtTqgvJLkLPlqwFLIBouCT79sDMsdJb75Y1xbhNvbA3s5O
         XRXdhKJs/iUNWtw1h3aT8G+XoxCWiZphaYxDiK2KwIY5LQn22fwnZoSseDE15JFpIlEq
         dp8igHbohlHSUhiuHhkBFI4fCkE9vb5OymFaDATCW1XrkPE8x/6M7cxqb3+MfvXdVZ9d
         H2vgNTgAeFnsAaZLjorjixrKLqpfAg6HYpudb0jEtdcrGpXKWELVY2WwdoXoxxHiezy/
         hLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788985648; x=1789590448;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NRvs41+5uPFlOeoWPYyoihSNfHIDwMg8K54gWzgpRo=;
        b=WfHf7HEeGn/fcaW9s1w/AJQKV7DeQQLWAZJ8MKsrSntHioOAfgZy4/JMFVsIVqH0Am
         UN4DdgjuU1Y3T1IgI2bOUN3hKwBDx9Aw6lwV3suGBwfkdxIyBsTXSb+mnMEaydgV9w5l
         mbJVJXZw07baGRC01/HdCasJcm28oul5iW3ZkKwM/GPDtKNrpT4qz/kyr0czPAuvmYGq
         2Px6pp8Ip3mnmFSy5Z5UCw9UfHMLvPF7x/sVUirt+RzcrX9KNmeZlFde9iN6OD10v3QQ
         eXP1xAyCQkU/jiaxOHWpOI8cwzqFwAGMIOqEd8Q1f8hg3EVzDmJVrd77IQUfQRZTFmlo
         KW0w==
X-Gm-Message-State: AFuF++mFNKyyvaQGbBiPArcPl6Zt4W3mM62CrZvxYTxas0k+E9arlQCq
	494824h6iOKnyWCYjVitHxHQue/BgWQ5baEc6Vnbe0YZDMAsRymDiUlH
X-Gm-Gg: AYBFou3BC+Iu1owW1DwNEbxmuUKVLYAeEQPmLtigZTFsHr2JGI3v4KouGgDe8saEq/6
	pU1xYjqUcHgwxt4BjLNBK4stfefvPqOMUxuea9B4GuoqJzpGeD3P68r52PU911rU1Mty/SPXk5C
	/utu5hNahKVyYWzMydz8pGJIbKxAubwNxnwvXsnV9PJIWrMnYdF0IGq9yUvh/5G2EyJQ52E5jMn
	6oE2kNDu7eauLOvImPCmkWmDkjpi45nL1nhTKKT04A0CBqfmtO4XQteWiYFQMJ4LgQoDp5+sjj3
	bln5pFHSAo7gSExMNhjQ5rmaitSMo173jdczzUwy4Tl4LVCwdd2ZTS8gY6UyERmFv5SkkER4JFG
	SF77u7b2n216GRlEpeR2dKvFiwPjPVYpDit4BUNclQ3sq+fGhZ0RbyKTxP558Xq/kOYsoVBOCmx
	h/0vuo6o6uoWfkRUdx1xqRKARenUlTQ313vmBCCCZntKRWKHkb/eH4pKekCbMyl4N/X56XDxJ97
	LI91dHD
X-Received: by 2002:a05:600c:4e45:b0:49c:f504:2af5 with SMTP id 5b1f17b1804b1-49cf81dc3ecmr412646735e9.1.1788985647953;
        Wed, 09 Sep 2026 13:27:27 -0700 (PDT)
Received: from foxbook (bfg95.neoplus.adsl.tpnet.pl. [83.28.44.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm172698495e9.4.2026.09.09.13.27.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 09 Sep 2026 13:27:27 -0700 (PDT)
Date: Wed, 9 Sep 2026 22:27:24 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Quinn Schive <quinnschive@hotmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] HID: logitech-hidpp: G502 LIGHTSPEED loses hi-res scroll
 state after S3 resume
Message-ID: <20260909222724.30fc8f52.michal.pecio@gmail.com>
In-Reply-To: <CY8PR14MB59809F95431FC6FFB0D0A56DA0B02@CY8PR14MB5980.namprd14.prod.outlook.com>
References: <CY8PR14MB59809F95431FC6FFB0D0A56DA0B02@CY8PR14MB5980.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 09:58:28 -0600, Quinn Schive wrote: 
> After some S3 resumes, mouse wheel scrolling becomes approximately 8 
> times slower.
> 
> Turning the G502 off and back on immediately restores normal
> scrolling.
> 
> I captured the failure before power-cycling the mouse.
> 
> During the resume that triggered the problem, both PROM21 xHCI 
> controllers reported:
> 
> xhci-pci-prom21 0000:11:00.0: xHC error in resume, USBSTS 0x401, Reinit
> usb usb10: root hub lost power or was reset
> usb usb11: root hub lost power or was reset

Hi,

You could try if this problem is fixed by the following patch:
https://lore.kernel.org/linux-usb/178832755831.50581.1058201741431375556@gmail.com/

That being said,

> My interpretation, with the caveat that I am not familiar with the
> HID++ driver internals, is:
> 
> 1. Before suspend, the G502 is configured for high-resolution
> scrolling and hid-logitech-hidpp stores wheel_multiplier=8.
> 
> 2. During S3 resume, the PROM21 xHCI controller fails normal resume
> and is reinitialized.
> 
> 3. The LIGHTSPEED receiver gets a USB reset while USB persistence
> keeps the logical receiver/HID device present.
> 
> 4. The G502 appears to lose its high-resolution wheel reporting 
> configuration. In the affected state, one physical detent generates
> only one raw increment.
> 
> 5. hid-logitech-hidpp retains wheel_multiplier=8 and apparently does
> not re-run the necessary high-resolution configuration on this
> recovery path.

this still looks like missing functionality in the driver.
Needs to handle reset_resume() perhaps?

Regards,
Michal
