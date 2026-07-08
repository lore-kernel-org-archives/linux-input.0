Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC723A63FB
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471834; cv=none; b=BHkOHv5DIXtwVUIZrdmU/KahuubsvJHR+7ny361K0zYlBYT7IlnHPIQZB7KZx2mojkPJ+V4+qGk03rFKa78XttfnGonc5xYcP4QDMJTXRTFHs6qVTf+83EcY2m64kDDD6Ajc57NrTNTK1ZPyFTGaByjIXytUdF4dQ8EQVVx1USg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471834; c=relaxed/simple;
	bh=vIVMwL29UTtjJWpGEzB36DlL34Lh4GkOZd+aNhnq7Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPbM4B+8X8EvQoMTjeD6xDUzBUbXoMzNCnvL2o0GwuB/YLUMfZKb2+koMSmSkLeop3xSjgPXTPgtDXp5+e3KU7b8ifsVaCt/NQQMZdfvNXz0Q4wHEv2mXFmw34w8/zLr8sTjHte63+OpAY/Myj6dHR1t10Qaz1K4e4yuBPqgyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw+BNmEH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw+BNmEH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38426d04bb4so97995a91.1
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 17:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783471832; x=1784076632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW4won5xrg7JVxpPSnTAkNZ/C4zW78C/w6G3Jylbcw4=;
        b=Zw+BNmEHnRhGMiz+NlYhTTqncY9YRltTqJPOz1ffh7LRli5CP2PbcUP7ewVtt7HM61
         rwAf/8ZYrK/XynGgoEnnGzIo4G/w0OCCuZ89KeLK0tR+kbSF2B16O7YxDEjzU3rv76Yv
         rVCAJVGVTUEJgJB4c8bVUDHqRYkbS5hWeXyFKZ3PCPqDugsLB79WLie0E3DYgQIV0/UA
         4LUNgVASIh3QNoCf6FQT6GcYkSeIEpdR7VvjVjyL5a4aPHnHIGE68t+xjTi0TOLzSNJ1
         0wltikxTPwphOVIUr83vizZ/fmhA1PyAuxKCgcYH6qPBZEikahmDTXb8/UjOoWjWh1/d
         VPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783471832; x=1784076632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dW4won5xrg7JVxpPSnTAkNZ/C4zW78C/w6G3Jylbcw4=;
        b=RYag5kjaguJ8B8QANfzrQ81qLfcR0zTZ2oOIQibbufOoN1DfzFgXB80fRj17tC/RpT
         XoP9qlBlwtOdkhIj+2l7JJ4VActl7Z1X3ejvs4kO1P9ESpGnopfY23GS/dXz7cSq0DCC
         G2kXYd4H9GIen+NzDLdGqHLHJWOZFN8t6xMInCz4HSWwnAVaDN6ppTg66wNvjGe4PCCj
         TT90UGqWnYwBApu9OMClEqKp3QbzTnTtW+df/B5XotuKH3l4Sm6PoNBmbc0Btk1tr2O6
         SMdgBWZ/NyQuehtnqEkDprKVBsTfYGzTwGYIyAu6ypPxfUW4vV9ITKwr+w7Og6VQEJ1a
         kjbA==
X-Forwarded-Encrypted: i=1; AHgh+RpsdSkTRCWCzN5MB5W9KtiKfWawc8aF/C5fgz6rBtXzvu1p68uSGM0CvBT1DXKw42K3zJ9bnugzyE1WZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+XMZuZgxabaJzI2IaLhJCZcTBlExjm4p2seI1wV7TsXy7V+W
	TwwqFRYp2nzCq0Jti1IUWDPluqqNVAG/HhuAq2bBHsGQ/SlhkeP5QLim
X-Gm-Gg: AfdE7ck6h++KvnMzU5ctV2a0NouEzUFkSjk7bwAQZO58ZDQANylKNiB75BpwwTjpQGZ
	XqkTrdtFsmoT3o3W/aSfoMKvpOfFuQHOhhCzmxucfYXRiR9XOFTq0gSXFEsnYhK0LqE71rnb5t0
	zzF9re69Z1N6/H4/nT5sa4KOeSVUPMqcpqg6AQUZp636pJoAFHJjXKkVw2HlWG6HV0x84biKJox
	MzG+4nJFGAu/TkiqouXhvTcMBWWMPidsYcU3YB4p9Hu0GjMkKy57b5pWZL1vErU+28vyzN0cC6O
	1hzD4fcXIVLES5DmKCn1pgnzFlXvEIZBLTuH1IaUyqKpPoteqdq5Kvk+MwaqGyamelPWiJkZvT7
	wKUg0qiz3FxsqyN3N3ylGwCcqvwPwrtHnvSc7qulhdn+r0tTo2Y0d7JrS1sNOcRK+0k36a3q6Vf
	uc9gy0qj6N/IueDY1rVAILnlt80w==
X-Received: by 2002:a17:90b:3a48:b0:37f:ee3a:12a with SMTP id 98e67ed59e1d1-387d6b978a7mr5302610a91.2.1783471831915;
        Tue, 07 Jul 2026 17:50:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a92eccsm12471259eec.23.2026.07.07.17.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:50:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 7 Jul 2026 17:50:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com,
	bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hwmon: prevent packets from going to driver for probe
Message-ID: <563e9ee4-b2f2-4b3d-90a4-3a11e9f43f97@roeck-us.net>
References: <69eed7e0.a00a0220.7773.0026.GAE@google.com>
 <tencent_BB7C33EB9EA41B7B4B5F1B8B25C0BA13BB08@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BB7C33EB9EA41B7B4B5F1B8B25C0BA13BB08@qq.com>

On Tue, Apr 28, 2026 at 12:12:26PM +0800, Edward Adam Davis wrote:
> A race condition exists between hid_input_report() and the point
> immediately following the execution of hid_device_io_start() within
> corsairpsu_probe(). If the probe operation fails after "io start" has
> been initiated, this race condition will result in a uaf vulnerability
> [1].
> 
> CPU0				CPU1
> ====				====
> corsairpsu_probe()
>  hid_device_io_start()
>   ... unlock driver_input_lock 
>  hid_hw_stop()
>   kfree(hidraw)			__hid_input_report()
> 				 ... acquire driver_input_lock
> 				 hid_report_raw_event()
> 				  hidraw_report_event()
> 				   ... access hidraw's list_lock // trigger uaf
> 
> Consequently, when corsairpsu_probe() fails and hid_hw_stop() needs to
> be executed, the io_started flag is first cleared while holding the
> driver_input_lock to prevent potential race conditions involving input
> reports.
> 
> [1]
> BUG: KASAN: slab-use-after-free in rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
> Call Trace:
>  hidraw_report_event+0x5d/0x3a0 drivers/hid/hidraw.c:577
>  hid_report_raw_event+0x311/0x1730 drivers/hid/hid-core.c:2076
>  __hid_input_report drivers/hid/hid-core.c:2152 [inline]
>  hid_input_report+0x44e/0x580 drivers/hid/hid-core.c:2174
>  hid_irq_in+0x47e/0x6d0 drivers/hid/usbhid/hid-core.c:286
>  __usb_hcd_giveback_urb+0x3b3/0x5e0 drivers/usb/core/hcd.c:1657
>  dummy_timer+0x8a9/0x47d0 drivers/usb/gadget/udc/dummy_hcd.c:2005
> 
> Allocated by task 10:
>  hidraw_connect+0x57/0x430 drivers/hid/hidraw.c:606
>  hid_connect+0x5bf/0x19d0 drivers/hid/hid-core.c:2277
>  hid_hw_start+0xa8/0x120 drivers/hid/hid-core.c:2387
>  corsairpsu_probe+0xd9/0x3c0 drivers/hwmon/corsair-psu.c:782
> 
> Freed by task 10:
>  hidraw_disconnect+0x4f/0x60 drivers/hid/hidraw.c:662
>  hid_disconnect drivers/hid/hid-core.c:2362 [inline]
>  hid_hw_stop+0x101/0x1e0 drivers/hid/hid-core.c:2407
>  corsairpsu_probe+0x327/0x3c0 drivers/hwmon/corsair-psu.c:826
>  
> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> Reported-by: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9eebf5f6544c5e873858
> Tested-by: syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Applied.

Note that it would help to copy subsystem mailing lists and maintainers
on patches like this.

Thanks,
Guenter
