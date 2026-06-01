Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEB286D70
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334533; cv=none; b=eldYjtzsmdNFoHP2FUqi2g6Z9f6YDis+cyfUnIrhHVKXl6chB6boDtRj3TYxNlHVv+gFFwKAdzVKqdtJBlt6pRFVush3P2xIrWEuxiybmp/8eZpOvac+2TUssLDuZfhYsVVfrxnzAxtjHSiKdQSRksfFZbsryaNxpJAZfTHiZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334533; c=relaxed/simple;
	bh=p0dr/0e+RMT5s/D1XookegKIZ7osYLZWSo01y86wFB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mha1aaLwVe+BBG1Q3qVAn8LK+bJWpng7u/nrgsHD1yj0QNwFdZ71/c9kDihL1wQBALYSWyL7uS07uQP86rfx7R4T47KChNgBLgfVUEtiJ708iakGvXTkOslMIJDKwRCSWv94wSh870ZIWc3pzlJVEDLi64dtBC3wBEn4m08uFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMYFVG52; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMYFVG52"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304fb780deaso2538470eec.1
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780334532; x=1780939332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCZDq71K/7B9NPxpLRXInuFJYsdHo8MGWlsxr1hrqXI=;
        b=kMYFVG52inQBvoGWMvnWxzhXMxwdroQ4mSQFU90irauPN9529KhtJnjYurdr/toE6k
         hVleq7fa1d3mUCWj5X5L5VwebvKpU0z71F11GXDMssx1loyXI8T0xIrsu3iyEVf1g3+A
         Eb4rATpsxtxpJY2xoeJWgL6OwZl5yaIEsxe/O7CDoNZlZ9irXPtFKe9E4uUmg9Eut+g8
         VxaPIcd/Gv7Cw5COoOEgSmZY99z0GB7ddjYrgu7uqe13i6tUdlkCIekFZTMU98BX+UoT
         3cjCVrorz/UDMM30lFx7tN1/HlS8msOX5nvb0AiFyg7/r4Hyoq/1Zglj0B/t+1vk88CR
         Fa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780334532; x=1780939332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCZDq71K/7B9NPxpLRXInuFJYsdHo8MGWlsxr1hrqXI=;
        b=M3vXt9V0z5Cz/37SI6gmuhmyXbH1ob5nsMjolyzxsSoiGHlFoW9IiL6c2IA7XNC8g0
         Ea+KbI7pjqoIod42UvRxfOR54I1aQLuRevRgXEL2hEHLhwMHAXcXzZnCSoaCvO6VQcnc
         CdBSfz2ePt7FMhEJbTOmnlomJ0Mqyei3vLNSGqXUJqSB8Ct6Mqew4c7QbzPC8t9abzJN
         g8B6OSV/ur5jy1vack/mvhzrJWak7D3JmZybHTfCf+dtS5qnMzVca9qsqnpMxUYveqB9
         UhaJXp/Hm0opkmVdeHckXDRXVgsp1BeepLFrH5WP98MBu0FA29PsImBK42U8D/Ef9IlW
         19iw==
X-Gm-Message-State: AOJu0YzHvAiI6Sa9ASaKkUf0nIdRkZnyYMLjY359STU3d5LM2Q9qA2Eq
	vFhi9/1FSPCm4ejszq2EwJHPQFwJunndyfNbPpxiAjx+C5CcNL+9+dHI
X-Gm-Gg: Acq92OGmMWrspYtOI2dU3kIPASIZl6AjHSRU5U/1IcvU8DK4XNtVrABRCH6VGRysVia
	JL2L6Asa6OTCJdPwU137B2zdJHyqj78mz+4HqteBZrqpJwE8g558dUI+ABy5pljA0Y6noHTOreu
	uXTjMGLOQ00UyODK/TJ+0zOY0eHfq/OT8Q01M1wm8ij/oJIQf+mcePeG+o7Xr3QEJWloWyuGSgU
	5V3riW8elkoC4qY4sO8u4aATJiD0BD3fuVb5wEBEmoScVVPkok3b3feCyXP2kPoHhSdIIu06+yf
	8oF4OliDHXC1qJmKpfGzYZMhgYxYClcp7n8BTTytfKR3Tgh12GHcm+fCpYrpLdvR3+VJipW/4Zp
	5K5/y6Ykg523UUju3otrc35voU8EqTiZSOIyk9ob++ivE+yrB+/NHhG9w5gX7i4FidkxvBPoRXz
	0X/jXBrj6dyy/YieUVh7X34SMdhC0NSubzmh/TkQAA6PLkHH8thUKQrDTNdCR4TpLbtwp4fC75z
	SYczqlut4qmAQ==
X-Received: by 2002:a05:7300:724f:b0:304:4f23:457e with SMTP id 5a478bee46e88-304fa62cc9fmr6202558eec.22.1780334531524;
        Mon, 01 Jun 2026 10:22:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:50da:22ff:eb92:9530])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c10c1sm8978536eec.1.2026.06.01.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:22:10 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:22:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ginger <ginger.jzllee@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [bug report] Potential atomicity bug in drivers/input/joydev.c,
 between joydev_0x_read() and joydev_ioctl_common()
Message-ID: <ah2-X1_innZZTAMZ@google.com>
References: <CAGp+u1YARE-sqwuNtbpG7E4TO-Nt1KQEeWiHn6pjoLz5kmt8HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp+u1YARE-sqwuNtbpG7E4TO-Nt1KQEeWiHn6pjoLz5kmt8HQ@mail.gmail.com>

Hi Ginger,

On Mon, Jun 01, 2026 at 03:07:05PM +0800, Ginger wrote:
> Dear Linux kernel maintainers,
> 
> My research-based static analyzer found a potential atomicity bug
> within the 'drivers/input' subsystem, more specifically, in
> 'drivers/input/joydev.c'.
> 
> This potential issue is present as of git commit
> eb3f4b7426cfd2b79d65b7d37155480b32259a11 of the mainline kernel.
> 
> Potential concurrent triggering executions:
> T0:
> joydev_0x_read
>      --> spin_lock_irq(&input->event_lock);
>      --> read from joydev->abs
>      --> spin_unlock_irq(&input->event_lock);
> 
> T1:
> joydev_ioctl_common
>     --> case JSIOCSCORR:
>     --> write to joydev->abs[i] (no unlocked)
> 
> The above trace is meant to demonstrate an illustrative example of the issue:
> IMHO, in 'joydev_0x_read', the 'input->event_lock' is adopted to
> serialize the read
> accesses to joydev's fields like 'abs' and 'keypam' or input's fields
> like 'input->key.
> However, in either case, the write-side accesses to these fields are
> not similarly
> serialized.

Yes, there is lack of locking in joydev. Some of this might be OK (if
we prevent tearing on reads/writes) since the data may actually be
obsolete immediately after we read it, while in many places we
actually do need consistency, especially when we adjust key and axis
maps.

Thanks.

-- 
Dmitry
