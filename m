Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0B2236F0
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470940; cv=none; b=uxiTq9FWWt1HIaGroa/KGvszGJJivlnK068Veo+Xvg92mgedk6xbWEtr4k4E/yb/hD2OLS48Kvi/FlKu+crSmKOKiywxxYjBk35W7mDvABWUL5s1RM0TkJbFbfqudOqmLIo9rHTqzdXFQMZnCjOs3TGSpy5Mjmf3EkusJ4Oeh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470940; c=relaxed/simple;
	bh=2ArQg4qpmjrrQ4mc9mt0ZHUq5+4VQZKyKQcrnZMbXoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC3EkIypocYCcHHRjy0sP83atJi4tPxWmTtfhz5l7OOUDPDCssZDNv2N8xildOIa+ROcHLnQbL06wZJQXVTlDUsTMeQ5sZUVZH+kRHjVl1zZdMPQTyFQrywsopv0eqyR4QcEOP9RrZZdmbygu96Trl709TVazjinDwfQ9k1X7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2J/dw/7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2J/dw/7"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4865e953031so2949342b6e.0
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781470936; x=1782075736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjMi8Y8lFnHLL3o/H7uB9bLrXirUVEIvzNEJJUwIoY0=;
        b=U2J/dw/7+UCDN1i5yaEwC1aWglLde4qMTSzHUR84NDNKm46wRvyBzI8UKuNPcMvazS
         jNesoGOTWWVjgwxWojYTwhzAAW//iNnjIQFAgZ6/vK7yADzQ1vSymf/swDxjuMP9WrQB
         IOe505r4ohZ+oDWH5fh89zyXjs5uS5Xi7opPMweNLa46rAgModHzUjWBOcXdOLKHkHoS
         zPsxKwD0cDvOGzbuC5VZp/oPZopzuN2R+HNSaX+0n0xBtgAO6y7mS37H9XLp550D0Eht
         JIko2viRZnP8qNgtRr99Qi4x+3+0j0aUqtvbpTc3lRjH9Yo2/q0qKfGzUidOMlEWdTfd
         sukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781470936; x=1782075736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjMi8Y8lFnHLL3o/H7uB9bLrXirUVEIvzNEJJUwIoY0=;
        b=EQUglQbsN+uOXruWlCQTyNXT6tl95l60BwuvV9ZFzU6J021NiYD2SpVUFD98jswjHl
         KHny9NOkswh5OgaLvra7zijAq8xtgAcv7ArUy+T4kfmXDABkTmCWxFIIiqyzBWY0G8ww
         hVIkZaKvj5ml4CxA/kJ6m3lHQMb/qi2+ioJJlT8s92vZrQ4O7B+88rYnW9E1cIz4haSh
         xYzWeZP09wqCshqtO7JHCNtUoxDI0s701N9qMFd1yGXHOESW6O2+IWHRrbzraz7V3VRi
         ZuPJdwwG1b+Fv6OCL7DRDMFhySS5m0mDw6S+f3SL3y+nKKIy5GMUGTrY+udnvf/jiewU
         1Vow==
X-Forwarded-Encrypted: i=1; AFNElJ/x/H5jIxI3hhz2wU+kDHB/Y+gWBlT/SCJnnsBfzptT/2nzz2DwQKtyWzlPewXdyXpvPl0PR1/zWZUzQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxga/gxEeRIdeqFXvjEMqrxZV/94zGlkd/lG7/Bkpc1RjOjcs+s
	dDGUsvaKh2+CiRqzxfEF/4zrQnS1hF6YJROH2uua1iDayFqiPsUuEign
X-Gm-Gg: Acq92OEOb+897/nkSRfo5tpaZEbGNHyJC6NkdzL4dSsaX6A5L1QFfjDPRuG4mOVDAY8
	fMNH7XiJIxjrrtIiWBw9yit8qbpOxtq5pxfbgO60j+dQiplw1B4eSD/Uj9fXCItsqhkEPp7/fwn
	PSFUYCjQS8l5i8jsafATOpxoWLY4P035Zvmy2gyoF7I8ChMjtaHGAJdrKL6WJzoHd1Q0vSf1UBS
	kg0qOOCZEV91vR5OEqI3FpesOxpnv5BrObK9ZZyxQ4H11Wy59eLr6q12qoroSgwoRMmyw2vWKFo
	Lk2+pp3YpU5kDpBz5PiFvHBFyuP0ejhMPQhnUWuSueacAWlpy7gtlc8NqwIjxsHEY6O3HiMr8MJ
	vlw1xDm8DVakTm+v1Wt6FLlG4KYoEakvNFRokpQmJkHxwz52+a7vWaxLeJYU0nHir5uIO+Y9oAh
	C3kc/+Ry8+dCFORbxEzeA86hvayufTAZqQWNFp+M/K+DThvXUlNsZy
X-Received: by 2002:a05:6808:2221:b0:485:29c3:3269 with SMTP id 5614622812f47-48731451d8cmr5988583b6e.21.1781470936508;
        Sun, 14 Jun 2026 14:02:16 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dda5f7csm1536090b6e.1.2026.06.14.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:02:15 -0700 (PDT)
Date: Sun, 14 Jun 2026 16:02:13 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
 hid-sensor-custom
Message-ID: <20260614160213.085e1efc@linuxescape>
In-Reply-To: <178144969601.60470.12928355382146160896@gmail.com>
References: <178144969601.60470.12928355382146160896@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Shuangpeng,

On Sun, 14 Jun 2026 15:19:21 -0400
Shuangpeng Bai <shuangpeng.kernel@gmail.com> wrote:

> I hit the following report while testing current upstream kernel:
> 
> KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
> hid-sensor-custom
> 
> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
> 

Is this correct? It seems to point to changes in HPFS.

>
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967
> 
> I'm happy to test debug patches or provide additional information.
> 
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> 

This bug report also seems to have nothing to do with IIO after
investigating the call trace, seems more like for the HID/input folks
than iio. HID folks, seems like it was caused here:

[   73.163547][ T8356]  hid_sensor_custom_poll (include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)

before _raw_spin_lock_irqsave() gets called and KASAN triggers the slab-use-after-free.

-- 
best regards,
max
