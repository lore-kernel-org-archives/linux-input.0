Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14729D29F
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472923; cv=none; b=U9yySY9Lz+QA71o6GQtTbg/jLsRQpBMl9prjepRc/BEy9Lwln6W8YAPFAAeK7QCRDbPYqYMJqYjdGfcCp8yIkdnLplhjh93MAIBXE48AkcVutbOeA4EBJ3/sCTakgzAZ3t9U3Aq13hOS6Io6UraalItbarlvZpLy8mxnlb4Li+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472923; c=relaxed/simple;
	bh=uq5dAQBgUlv4fuqbOf8/PJcw7d2cLX4l7Buv5XYVS24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0ieJyO7/vrNZ1QgeCyu6REWVgyQjsq7X6H2t0+UmQJcwpzwxswe6BvGX/iOa1LhuA42mEXWN3im2Xn0uvaMnd/OBbsOCywc9AGi/Uw5/xhyRAGPFa+0d3zv9M86gR7ahyUl5RVMvaEzwjWA6nC/dPW3SiU9RYc/FIEEnVHyezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORnl8K5m; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORnl8K5m"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4859b1fc7a8so2022101b6e.0
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781472921; x=1782077721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvgAYyCQGx+STgxeSTHJf5dS9VjipJF2G2cnTNc8eVo=;
        b=ORnl8K5mkHKs8eDLA+R3WqECgc46k7N/AP8JXO9lOkn6pqQf1jBgyOpvC3Ih6vRHlO
         dglUtn8A2ZVdOWljq61+cHMluJunmW2GT4t6M5TH6zkHfBY+axAoTLererJSWAW0Lgcv
         jzVnSdsygVt1sXWYCjMuGveAvua+Wyz0Nne6RFWuerp+HNRpR8uqsrP5Whc3Bvbv8TL0
         mnAYcqnOwPpyiVkibFb+/DyDr5HTPA0msHgMH8t1LfXg73T8rUxPI3+NxnHmmEl4OfiA
         wBWyq/WOqViuSkrZWiTlQqqyXeTEpa1gN4xRWWFRcMhKEm7deTMmZumw9TtMZwuBm1M1
         rFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472921; x=1782077721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bvgAYyCQGx+STgxeSTHJf5dS9VjipJF2G2cnTNc8eVo=;
        b=RziZ8WzBpYbQ0t+1a4UOuFw1xLvSUnmraEpq7rXDDlaicNUax/RDMF+G2MAAlCZS+l
         kloOQv8eBEtl77vOuEdta7JYe3cYjrUnLx3hQSbggwCf1Sc9z00K9eYDog1spk1nVnaN
         rM7zPmAOCFN8yXOg6ApDLEX/TDJyrqY67nHzkuJgtPrQOND1YodcQDsh1qhPrPTtIcOi
         wTSWDATpFnVSi4q/YOY8DRNTc/Hljwwj7a+RdoXir0Di+AdmUAmceGnNKrYSo7JJ4tlJ
         hiEgUuetKTfiSSZR1Ga3sLLj0slzNYqS4P+0wpKOpAVv8MnAYTVtqGgS1Y9F0GHWTC1e
         gGPA==
X-Forwarded-Encrypted: i=1; AFNElJ/UuyA57AX2kSEkg0cx0cnbVy9fvediSM7hnMmkeKYExaAz8WKCxnc8w/ZktF3WIkFZM2XlVy7uzjfV+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMpTF0i94MqzDpFI+x/Z65pxrO2Of37GWNU8frKv1Tyc+qodSc
	UfevG6NxTOKB3H4IXO1EsQdgrEhUOgE4kqp0s4fjQKtkqUL4bTI+FWKB
X-Gm-Gg: Acq92OGdPXHcTBVPgJkDS+svQIt2PBOBYtspuxDQyfiE9ooRjOvhKMrZPmm23aFDMxC
	KHiEgA9Nw01QRl5/vzk1hyeoZuSeDWmtZH91V5wc0NXsEDSuh4A0P/4qtKzV5hqRcHZA5Z/FiwG
	VbBwtWdztXG8ynuM1r6cuX8Dk2UOpch3Vt15pE82AjnQi1opMPN4eFkNuXqTCsSbNqCunk+KJdw
	UcJnnE5SM8L5ZjQLh09ZeJ/18fQAd/OTekBN4R2QTd36Bf73lHi+WJk1HIQUFNLu0Oo8hJPlUt7
	uoCTRwPJbPV4Hyk+Uvz+XDtZUW0L68t0180D8qJQi3BG0+vI2RkkT7hEvrT662OcAPs1+XOxBhR
	sreAkbW80YBo9Qfg39MXVI8Pozko5p6i819Q1972V9zokbwkioxAzBqoihrRNwTVzLqu595Zh4j
	LFrMs9qqh+GUwEUgdp+/MTX3e4JQBLmB5GqBWkqms0voLye5vfmRl/
X-Received: by 2002:a05:6808:c1e3:b0:486:498d:f500 with SMTP id 5614622812f47-4872f380b4dmr8274028b6e.18.1781472921015;
        Sun, 14 Jun 2026 14:35:21 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfe4a89sm1628361b6e.18.2026.06.14.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:35:20 -0700 (PDT)
Date: Sun, 14 Jun 2026 16:35:18 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Shuangpeng <shuangpeng.kernel@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
 hid-sensor-custom
Message-ID: <20260614163518.2a265172@linuxescape>
In-Reply-To: <C79160E7-5244-407D-81E7-2A1B14231B22@gmail.com>
References: <178144969601.60470.12928355382146160896@gmail.com>
	<20260614160213.085e1efc@linuxescape>
	<C79160E7-5244-407D-81E7-2A1B14231B22@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 17:24:12 -0400
Shuangpeng <shuangpeng.kernel@gmail.com> wrote:

> > On Jun 14, 2026, at 17:02, Maxwell Doose <m32285159@gmail.com> wrote:
> > 
> > Hi Shuangpeng,
> > 
> > On Sun, 14 Jun 2026 15:19:21 -0400
> > Shuangpeng Bai <shuangpeng.kernel@gmail.com> wrote:
> >   
> >> I hit the following report while testing current upstream kernel:
> >> 
> >> KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
> >> hid-sensor-custom
> >> 
> >> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
> >>   
> > 
> > Is this correct? It seems to point to changes in HPFS.
> >   
> 
> That commit was the linux.git HEAD where I reproduced the crash. I did not mean 
> to imply that the HPFS merge introduced the issue.
> 

If you have (a lot of) time, it may be worth trying git bisect to get
the exact commit. No worries if you don't of course, but it would be
incredibly helpful to the HID folks.

-- 
best regards,
max



> >> 
> >> The reproducer and .config files are here.
> >> https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967
> >> 
> >> I'm happy to test debug patches or provide additional information.
> >> 
> >> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> >>   
> > 
> > This bug report also seems to have nothing to do with IIO after
> > investigating the call trace, seems more like for the HID/input folks
> > than iio. HID folks, seems like it was caused here:
> > 
> > [   73.163547][ T8356]  hid_sensor_custom_poll (include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)
> > 
> > before _raw_spin_lock_irqsave() gets called and KASAN triggers the slab-use-after-free.
> >   
> 
> Thanks for checking.
> 
> I agree that this does not look like an IIO-specific issue from the trace. The crash
> is reported from hid_sensor_custom_poll() in drivers/hid/hid-sensor-custom.c.
> 




