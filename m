Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7393D7D7A
	for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119080; cv=none; b=Xy0GmkLTizFSyOlBhBPp5V8t+wShekNk1ZKlprkKZM6JLZl4wq7/Ee8pISJ3YTnTPup1a4FyoS8vSCAU3gGyS4jxwfaJna7X365ywKP4YPkpu0NRfrnAhdxXRIGbywszCp1OHAKl71C9hn14mOid5x7CB3trLnaj/Xxr0n5ft6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119080; c=relaxed/simple;
	bh=Mp4bY+SIE4WzqGxnt3eeNiii86edlptv0Z8EbEZNUF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHYSQ3Xn/qgGUSOeVl33Y8V+wN7ZynzfxX8DrFd9io56diCwkLEDEGKtZkfTvVNXn0+VfY5KnZbokcIH2Qyf6OX2g01MO74nW7NsalJWOgmRQheYvYSHLEy40fXm00VFyW1guRRCxY3cKYHWc1LOihpSmJyVB/KsRySVDVwZBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFdfEAHH; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFdfEAHH"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e4993e00aso1003225e87.3
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772119077; x=1772723877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkchahuH5JPn+hl0IYCH3bdPiod8EQI7Sthay6EeVQI=;
        b=XFdfEAHHcufmlDHvYbfN2Jni/+PiP12ULJteHC3dymo5a16GUj1nxVSgPkH84E22Qh
         9RmVB4ZSfkiIpnBhGRc2swxCt5oY0lWjVUtWvhYMQANmfC9fTUSU6cV1cc+41Uz9pOUt
         yqDpp9pXPp1dy9LQBIWURS0XT5tYBvgiVR6vh2B1C0fdoIyGniKLKRMYF8innKukt/+L
         HLpUxh6Lv6E2xNOV2Ec8HGLyrSVuDE5PMqlRfNKmKHf9uzSr5qY76F8AnIlOgwFtbjIv
         WwK/c22WwHBTMaCcRR3oYQVvVhMzKnmstbTzXfuPT5mIbfJsL1vNPR/7v/VsF1KtcgxV
         7GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119077; x=1772723877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkchahuH5JPn+hl0IYCH3bdPiod8EQI7Sthay6EeVQI=;
        b=ngBlyaHDogSnyheKG1v6WOG23fGVtw1v2lpsuJQQOlNJbFdlHeWkpdCQVLhkI1Hdrc
         NcWVMSH50POPoUTfDZ33fmc7hK7+OSlJJZgcX/d3ahxAbuEC9OX1corGu5Mr218yWyl0
         v5TxEReAt6lbrQHouR1WToEIIn7gzmSxAOzfxR75/NJA5wqGD6b+Zdy1kfA9NeIG7EoR
         8hdwowSPyufe49ztgtnOznbr1/HJBujW9ixFMiM0TM0xcL02MKpOlZU4DXRQXCvsk1+L
         8cQ/hWTOqQ1U5gAe37RkPF2+wPZiR1o7SnpaETuSUus2oBMtAiKolWxoGKS82P5zmZ0e
         Vf/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpJQMGshVsv5FqG5jgI8xo24T8HIcqJ5fXs7gPjtNyzg+ymgnh68Y8R9YCkA/u9Y2CplySivbM/BOFcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCBJ+X5ENOvIFo4fBb95/ydHaVyWyu8Q4hUpmDuZvO7Me1Uku
	puPFgoJsnBcHn3ymzLyZbxPEgugiBprriD/jZUeAlNrnmvaw/9n09bAV
X-Gm-Gg: ATEYQzxbKodl5GDC9OKNYfAAnOvUwjhWmj6uy6V6XKxwyFEDB5LnJq1iSxxQf1RPrPn
	WF/Ihan0HGviZxirjoTL9yniFhAXBPARHwsyRSVjmGs3JvNCXiX5eatvYUQjfEiP6Q0bNmepJyU
	lKnl83e0514H+3ZtzS9CwkU0tO6YuDNZg0WkC5migors57Qb3s5msO9T2o70h08N2TNGqvIPYQ6
	8fGQwa4nGmcWn0X9rug/X6i2ly3d8HDqdPLUyU+SAybipl4zWZ2kt997f4uiHLD88U2rsfYfXmI
	F+ffw5JihPXzhVcCPsbz/r3KgLzmuKxECuIbdse2RBW704YRhFHSOPAjm2fw8zksrnLFtwzTztY
	44Nn26Eoh/cQm4tBjEYt7O+y2xk665DomZeGTSc8XK5bafueHL83JHZHYCXVr7PM9gc+5moAxrQ
	sxCKAjk9/ZKeDtvZyOYA5z9ZoptLC9nJMh/UXmag6ubPZrvEtuUhx5/7A+
X-Received: by 2002:a05:6512:1291:b0:59f:9091:9023 with SMTP id 2adb3069b0e04-5a109a78f44mr955747e87.16.1772119075000;
        Thu, 26 Feb 2026 07:17:55 -0800 (PST)
Received: from osama ([41.232.219.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a109df8576sm982458e87.67.2026.02.26.07.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:17:53 -0800 (PST)
Date: Thu, 26 Feb 2026 16:17:50 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzbot+1b327485934adf39955b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Input: evdev: fix data race in evdev_read() and
 evdev_poll()
Message-ID: <aaBkHhEYcSAf9iKV@osama>
References: <20260208194516.172227-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208194516.172227-1-osama.abdelkader@gmail.com>

On Sun, Feb 08, 2026 at 08:45:15PM +0100, Osama Abdelkader wrote:
> Protect all reads of client->packet_head with buffer_lock to fix a
> KCSAN-reported data race. The race occurs between:
> 
> - evdev_pass_values() writing to packet_head (protected by buffer_lock)
> - evdev_read() reading packet_head without lock protection
> - evdev_poll() reading packet_head without lock protection
> 
> The fix ensures all accesses to packet_head are protected by buffer_lock,
> matching the existing write-side protection pattern used in
> evdev_pass_values() and evdev_fetch_next_event().
> 
> Changes:
> - evdev_read(): Protect packet_head read in O_NONBLOCK check
> - evdev_read(): Protect packet_head read in wait loop condition
> - evdev_poll(): Protect packet_head read in poll check
> 
> KCSAN report:
> BUG: KCSAN: data-race in evdev_pass_values / evdev_read
> 
> write to 0xffff888104842008 of 4 bytes by task 8439 on cpu 1:
>  __pass_event drivers/input/evdev.c:239 [inline]
>  evdev_pass_values+0x387/0x4e0 drivers/input/evdev.c:278
>  evdev_events+0x8e/0xd0 drivers/input/evdev.c:306
>  input_pass_values+0x123/0x390 drivers/input/input.c:128
>  input_event_dispose+0x248/0x320 drivers/input/input.c:342
>  input_handle_event+0x9e8/0xa20 drivers/input/input.c:370
>  input_inject_event+0xbc/0x120 drivers/input/input.c:424
>  evdev_write+0x224/0x2b0 drivers/input/evdev.c:528
>  vfs_write+0x269/0x9f0 fs/read_write.c:684
>  ksys_write+0xdc/0x1a0 fs/read_write.c:738
>  __do_sys_write fs/read_write.c:749 [inline]
>  __se_sys_write fs/read_write.c:746 [inline]
>  __x64_sys_write+0x40/0x50 fs/read_write.c:746
>  x64_sys_call+0x2847/0x3000 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff888104842008 of 4 bytes by task 2991 on cpu 0:
>  evdev_read+0x157/0x5e0 drivers/input/evdev.c:572
>  vfs_read+0x1ab/0x7f0 fs/read_write.c:570
>  ksys_read+0xdc/0x1a0 fs/read_write.c:715
>  __do_sys_read fs/read_write.c:724 [inline]
>  __se_sys_read fs/read_write.c:722 [inline]
>  __x64_sys_read+0x40/0x50 fs/read_write.c:722
>  x64_sys_call+0x2889/0x3000 arch/x86/include/generated/asm/syscalls_64.h:1
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x00000002 -> 0x00000004
> 
> Reported-by: syzbot+1b327485934adf39955b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1b327485934adf39955b
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/input/evdev.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 90ff6be85cf4..eebd59d190f5 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -569,9 +569,13 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
>  		if (!evdev->exist || client->revoked)
>  			return -ENODEV;
>  
> +		spin_lock_irq(&client->buffer_lock);
>  		if (client->packet_head == client->tail &&
> -		    (file->f_flags & O_NONBLOCK))
> +		    (file->f_flags & O_NONBLOCK)) {
> +			spin_unlock_irq(&client->buffer_lock);
>  			return -EAGAIN;
> +		}
> +		spin_unlock_irq(&client->buffer_lock);
>  
>  		/*
>  		 * count == 0 is special - no IO is done but we check
> @@ -593,9 +597,12 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
>  			break;
>  
>  		if (!(file->f_flags & O_NONBLOCK)) {
> -			error = wait_event_interruptible(client->wait,
> +			spin_lock_irq(&client->buffer_lock);
> +			error = wait_event_interruptible_lock_irq(client->wait,
>  					client->packet_head != client->tail ||
> -					!evdev->exist || client->revoked);
> +					!evdev->exist || client->revoked,
> +					client->buffer_lock);
> +			spin_unlock_irq(&client->buffer_lock);
>  			if (error)
>  				return error;
>  		}
> @@ -610,6 +617,7 @@ static __poll_t evdev_poll(struct file *file, poll_table *wait)
>  	struct evdev_client *client = file->private_data;
>  	struct evdev *evdev = client->evdev;
>  	__poll_t mask;
> +	bool have_data;
>  
>  	poll_wait(file, &client->wait, wait);
>  
> @@ -618,7 +626,11 @@ static __poll_t evdev_poll(struct file *file, poll_table *wait)
>  	else
>  		mask = EPOLLHUP | EPOLLERR;
>  
> -	if (client->packet_head != client->tail)
> +	spin_lock_irq(&client->buffer_lock);
> +	have_data = client->packet_head != client->tail;
> +	spin_unlock_irq(&client->buffer_lock);
> +
> +	if (have_data)
>  		mask |= EPOLLIN | EPOLLRDNORM;
>  
>  	return mask;
> -- 
> 2.43.0
> 

ping
