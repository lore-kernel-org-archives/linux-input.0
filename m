Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCF222580
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774234066; cv=none; b=J28xl6SyYFnwYlOnzuGGVARpx4XWygUST7EZoYo7eEKYFskj+R4Rq8J2S8maAEc5isMDGpQuzlwQA1/5Cwq0b2hAXZz6C6hh7PLx0oSmdAixux+aHfBV0ivFJhhowC4JBUj+uNplUaFzr6kr7FYc1jHrWKCdsmJzE8f0T2w1SYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774234066; c=relaxed/simple;
	bh=uGt1822Gs4JX22LdOGOly/rmWuNE9tMIJScOYjWcIpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5EvBn330kGC4SqF3bzqvK85sWbCkm43EN7GN63XQq/wsTZ5+yzmv2gqFuN30F++/AfWY5WT3+aJvZxBrNpAzcUAOg95/LvoVBbndGeNiVUqeKxSVm5fcmmA+ouHTANRUZ6hh0RTpS59ICB6ukg0ov1SeC+e5dG4LzBc4ZQegVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/BH2WAb; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/BH2WAb"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0bb213b16so6664577eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 19:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774234065; x=1774838865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMsYmw2dDOcnd+1GHXLJahL+aBwqfC4EnffKGWzIRoM=;
        b=T/BH2WAbUPT3sx2GDny9p3zUY94lzbG2TLhJRzFTsvNyYHA+5UCjS9Xp6KKEmyGVwg
         aqV5FyYsii3FAlgkK1gCZyCQaYywjohR7s4E6IMk0DVKsJGjl6o86PRgQ3WUTV2oRUzH
         fhYMdY7mCWRMRK+IQvsR72VobTrvRu7AWkxVDgR85f9P0Fa7p1K8D5xj14TcD0XpgBZY
         UwnvmaOzYZqoXtnoGZu2OE0KiwGnY4pC3Ck8hc4hFvdwvVY4s2xwjSOclaGKB476gNpo
         HqKFOt5mK0Lqk+j5B8Ujt3ca36CkhIlb6H/F0tbxqjjKUKVN9Rptr/Ul3y11MzMO1X/b
         zKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774234065; x=1774838865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMsYmw2dDOcnd+1GHXLJahL+aBwqfC4EnffKGWzIRoM=;
        b=SgtG6/zcVg+QFe6Do+ZSQJjN9du1ontwfR/sd8b8o/JaR8GFu51CnFjRH4V4YDGFqr
         0GbgpDSA/PHXyEvMyaHxeC45yvTPh1mdtLPDWQ6bHdcD/Kp4dk7RPuS5cup50i6LrHl0
         I8gK4H+CUoB9SQAmWHGO3HyZ+Y4JvM89vYEkfOq4lR4PUUQvnxgbUnIv6Y5Qncjzf3JM
         6M8q5Rt545d0Sh6dj1vApxEQkwI7iyxSr2JTl2Yo0Yuonnad1vDKo+MJ92OPk9UiEWiL
         3ACJLrVWq9/wLCgRUmvtOXZHDgXE+JH5hwTl+IRvNnc3cmYVaOhPHN9rJLqlAGL6vjiH
         5m1w==
X-Gm-Message-State: AOJu0YzGpTJ9k4wxQN+P3uLS7RTadsl1y8bKEPVGlU/opsjVRSg83b/V
	uP9J+u61ieSt9JTpwecTntJPzGFg1ucsIuk2qTyzcZGJ+DFPPfkbzS67
X-Gm-Gg: ATEYQzwOuyFbahp7U9rSmSBpNsmLiEBqstq67lg1ooI8ugsDhOvNJ/GB2PW8xv38NDA
	r7PQaifHNSpvMWD1PkUuMfebuma8QV1rxx3ui04vuo8eAfuhAkXiI0/zdO0YFTVojhlAlbNWsZS
	yLHJFnMBd3zZSzHQer7DXpDS/WnIm8nN3XO6nAbcF4UsVEZSBGjglWiAYs6WUxQEdIZwQHRCY3J
	WTDKZZCwecfT2cgeFOIVINVsD+pLr7ZoeVpI+sm+AhCNZS1oDPgsuZn9D25uwilL0xNtFvweP2b
	xbxEbtYltbJ9WKj+UQbBCu91y9iiF+yd7esA+Yqrr40cjhjBFgLOWTNXsGAHRhE0jpR7sLjotoO
	oAiJ+B4mPSDZw5DDc3Jfa8KDNVbVdQ9cKlnwUkRrFVTdqL7MeB0c0MnSFbwl5gBeGK6Fji8k/MZ
	yKKaC4gURldScBccm8w6Pc6xlgrqrYDQMU/EOjRuUjzwikZ3b3QfBBKyPA2G7z4Vfw
X-Received: by 2002:a05:7301:eab:b0:2c0:c5e4:605f with SMTP id 5a478bee46e88-2c109760fbemr4923608eec.24.1774234064561;
        Sun, 22 Mar 2026 19:47:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm13158435eec.24.2026.03.22.19.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 19:47:44 -0700 (PDT)
Date: Sun, 22 Mar 2026 19:47:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix circular locking dependency with
 ff-core
Message-ID: <acCpW6McaPOE0Jq5@google.com>
References: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>

Hi Mikhail,

On Sun, Mar 01, 2026 at 03:36:28AM +0500, Mikhail Gavrilov wrote:
> A lockdep circular locking dependency warning can be triggered
> reproducibly when using a force-feedback gamepad with uinput (for
> example, playing ELDEN RING under Wine with a Flydigi Vader 5
> controller):
> 
>   ff->mutex -> udev->mutex -> input_mutex -> dev->mutex -> ff->mutex
> 
> The cycle is caused by four lock acquisition paths:
> 
> 1. ff upload: input_ff_upload() holds ff->mutex and calls
>    uinput_dev_upload_effect() -> uinput_request_submit() ->
>    uinput_request_send(), which acquires udev->mutex.
> 
> 2. device create: uinput_ioctl_handler() holds udev->mutex and calls
>    uinput_create_device() -> input_register_device(), which acquires
>    input_mutex.
> 
> 3. device register: input_register_device() holds input_mutex and
>    calls kbd_connect() -> input_register_handle(), which acquires
>    dev->mutex.
> 
> 4. evdev release: evdev_release() calls input_flush_device() under
>    dev->mutex, which calls input_ff_flush() acquiring ff->mutex.
> 
> Fix this by replacing udev->mutex with the existing
> udev->requests_lock spinlock in uinput_request_send().  The function
> only needs to atomically check device state and queue an input event
> into the ring buffer via uinput_dev_event() -- both operations are safe
> under a spinlock (ktime_get_ts64() and wake_up_interruptible() do not
> sleep).  This breaks the ff->mutex -> udev->mutex link since a spinlock
> is a leaf in the lock ordering and cannot form cycles with mutexes.
> 
> To keep state transitions visible to uinput_request_send(), protect
> writes to udev->state in uinput_create_device() and
> uinput_destroy_device() with the same spinlock.

Thank you for the patch, it looks solid, however I wonder if creating a
separate "state_lock" spinlock would not be better than reusing
requests_lock?

Thanks.

-- 
Dmitry
