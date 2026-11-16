Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794796274;
	b=zxN0HOawqA6AaIjki6/iiZONZ+ZmBPCPUiJapbEfkpSs+ruW7GO1yyI7UvdkMzjznhR7
	 SJcAvolF/NFUqoPdyy68RpkkE5LHD0qN7swe52ZBWo2bmfyFZKBg7Ju+tdglu9ABfbbBn
	 J2yEjc0BP0tXnQuuemvQbBAG72A+CivqCc4XL6SvJgEpB2GqSs1pwDphqsUSKOUFmSS0m
	 z23lzzn1I5SGmp3nX2TF4nMB0TVrG27JZJ9Ump/xyc23kqGFGHFQswOzRusxHnGnfP3fz
	 1uMntKTnhFJkckUQjRsdfUICap/pBbqx/ROU4QKz5FbcV8uEW3rbFt9mnIjzWOBbnJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794796274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=M/kpY+kx4cXKju3wCspeQj86Yh+9+P+FTV3zEb/PvMQ=;
	b=jYWYV0Zo6Q9Ra8ovWf2yZXld6K6J4AcLM/fQxS9MO38jAUTpZXvxFRNqdpuoZzch0sA6
	 VZfMD8AWzlB1JtPwOjoDsGZjctP6tVGKgWL8wH4gK1blZdSUTqy7J6SEfVn1cnxhrnYiC
	 yoAlRemGIm5yDQJAW8IBNGBZ/FqRU/3tOpT5sFpXb2+A6XUeGrwaBPwAT/5P/U8/ahuJy
	 //HtIxVxmTO7UF0nNaX7lYobvPRd0pA3GfVAvfPEA6QDWaA6wY8dW9AHGDZlKwoVnyQ9i
	 3tmzVSUqOOvSxM2Pm2nhYho+GGJNo3gFNMGESeHjXAu4rWf9pY5u9nvoaeiBE632aKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wVhMnFbT;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30001606A31C
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 02:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30001606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wVhMnFbT
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1438d9363fbso1378465c88.0
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 18:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794796273; x=1795401073; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M/kpY+kx4cXKju3wCspeQj86Yh+9+P+FTV3zEb/PvMQ=;
        b=wVhMnFbTWzew1EdxrzV3plENC+oSQ3Jwnk4agy3vtWWU3Y4J3g7BVJLPEUUgd03Zlw
         Lf+eA9xTPjVLES5MgfDPO7IUqBefF3xD25351/wOFVsXifdp2Aakix4/vC+M+IQVHe4r
         uB5DE6LgJ4nUDqMx0fs7qL0q26cOtjx8c0hHIM/aHEw5silTgDUOEg22SBEGnw6Xipjv
         Ex3CBrj6bDevrPZbDfIYs4KcXJ1lRP+n5QrZHooHwZWJZWMQVrrk/RW6/FjSfcy/XYZf
         +dacHLYtoSGwXWhinp9imcamk/NWMJTCXkdIZJwO/0swU/OB4EwAtTtsvbwJrjJHDGqh
         E1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794796273; x=1795401073;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M/kpY+kx4cXKju3wCspeQj86Yh+9+P+FTV3zEb/PvMQ=;
        b=uQTcU3Wux0DRU40jnLRrvQn6DwscuabFdDGrqvkYuktl07nnpIo++ZRovZilM7VpxQ
         3aWFASx59y8U+cN+C5MLc01Ocy7RE/C82IZ2p/3G9Hlecbcavi/+fxO18vN8/nAuFKkx
         ncGvq4Bt8WccxwRAjojTTW3AQAcVscak100vYWd3y/vVY3Al1N5CbVc1b9WsHZlOQc7t
         0OnTr00MbLItg2/3vBkS8iWLjan4WoqCDQwqkTcBdbf2f662Uc1wTBWMfJJw1MDOF27W
         imbxgB6Zly02w+ueAEv1i4kgOv/L0jLwiLlqGv5Mg7HTdpHVsE5QT9qnhUmOtZxxlKh2
         /YsQ==
X-Forwarded-Encrypted: i=1; AL+hErFRD0jVttb4cFoecHtHvtODKL1Tn1m6sEHHNoplCe3D1QXaFzpZLwwyjYrBB8bMCdHRUDGiVuoRttCe1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+eKLNYhRPrLyIdTqPEpiO51PiKN8ijkTBcNwe03vBB43W4s1rf
	+xSusjA1BksKVGkpz8x+kUzoP20MaVArYxvsb3ixxgSmtd7fcX/iAV66
X-Gm-Gg: AYBFou0zK4L8byGLyYtfwB9oJC/YmLOc97shADhgmKN8/RcMAYfCYMuleh3cFfdyP3U
	m6oO31JIZV0Y6p//tQpT2ypWYywCydW0VMoW7W7cebLhXxmvVli96lIlubPlJHV6QLI+u+EH1aG
	lbZDE1993lDaYB1m5jd5VIseS9WV/MWGnApNWpGOmi+Z8LusXFOqyBE6yIWJFFQzZqE2z8SvfDC
	EhE/j99xhwSnyhC1b+6hoBIeu/o3AhUkwsZy8ADSWtWTwiLSV/miB66OEtshzOqy6cCClDnXJD3
	sVekjcs71QtNaoXhnaj6TNS9fVxV7U/T+InX3JkuA/F1k9c5lZXlfFLVvjz2iKL8npEoK+fm/DG
	sH9+rKOanDwPAs0efXCw6JikfaRjCKJsBqZKM5pwEu7YveD46bmhdRie4HYG2jK+6CEbf4D9sdD
	PCQLdE+gTY32nZbbMI8rwQpEtTmD6lhj8L/ki0wpwVaU6uOn5w9iOI4yfiRhTBjUAjD+yREpGlc
	pHITA3t7elCJfxZXgHdqXYXFk4Hd79j7wiYeGv9gAutsFgJUQXBzw+JEQ6PHoqSlKzVKI4yZV6J
	SpxG9sTZ1BGmDRsGV1/ebqtgqcdqPx7sAsM0805LDTbx+FYw6n0JkDAqKy9iwLhPlgLU
X-Received: by 2002:a05:701b:4301:b0:181:8948:f022 with SMTP id a92af1059eb24-1b5030cf278mr7558074c88.21.1794796273178;
        Sun, 15 Nov 2026 18:31:13 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:203f:d9b9:dda8:24e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm26762374c88.2.2026.11.15.18.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 18:31:12 -0800 (PST)
Date: Sun, 15 Nov 2026 18:31:11 -0800
Message-ID: <aef5b22471cedda012e99a7dc82c6a20@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 04/12] HID: rmi: fix device lifecycle, suspend, and reset work handling
In-Reply-To: <sashiko-outbox-214211@kernel.org>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com> <20261113-hid-rmi-v1-4-afc43d97d766@gmail.com> <sashiko-outbox-214211@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Nov 14, 2026 at 06:21:03AM +0000, sashiko-bot@kernel.org wrote:
> > +	set_bit(RMI_SUSPENDED, &data->flags);
> > +	cancel_work_sync(&data->reset_work);
> > +
> 
> [Severity: Medium]
> Can rmi_event() still queue data->reset_work after cancel_work_sync() returns
> in rmi_suspend()?
> 
> Low-level HID transport drivers such as i2c-hid and usbhid invoke
> hid_driver_suspend() before disabling hardware interrupts or stopping input
> URBs, and without holding hdev->driver_input_lock:
...
> Neither rmi_reset_work() nor rmi_reset_attn_mode() checks RMI_SUSPENDED, so
> reset_work will issue bus transfers and reconfigure RMI functions concurrently
> with rmi_driver_suspend() or while the device is suspended.  Using
> disable_work_sync() in rmi_suspend() paired with enable_work() on error and in
> rmi_post_resume() would close this race.

Good point, using disable_work_sync() and enable_work() across suspend
and resume avoids the race with rmi_event() and also removes the need
for the RMI_SUSPENDED flag. I will update the patch accordingly.

> >  	/* Make sure the HID device is ready to receive events */
> >  	ret = hid_hw_open(hdev);
> >  	if (ret)
> > -		return ret;
> > +		goto out;
...
> > -out:
> >  	hid_hw_close(hdev);
> > +
> > +out:
> > +	clear_bit(RMI_SUSPENDED, &data->flags);
> >  	return ret;
> >  }
> 
> [Severity: Medium]
> Does jumping to out when hid_hw_open() fails leave data->rmi_irq disabled?
> 
> If hid_hw_open() returns an error (for example, -EINTR from
> mutex_lock_killable(&hdev->ll_open_lock)), jumping to out clears RMI_SUSPENDED
> without calling rmi_driver_resume().  Because rmi_suspend() disabled the
> transport interrupt via rmi_driver_suspend() -> rmi_disable_irq(), the device
> is left active after resume with data->rmi_irq permanently disabled, dropping
> all subsequent attention reports.

hid_hw_open() is required here so the low-level HID transport is open
to receive read data reports while rmi_reset_attn_mode() and
rmi_driver_resume() talk to the device. If hid_hw_open() fails we
cannot communicate with the hardware to resume RMI functions anyway,
though reset_work still needs to be re-enabled so the work disable
depth stays balanced across suspend and resume cycles. Beyond that,
RMI4 suspend and resume handling in the core and transport drivers
needs broader rework anyway, which will be addressed in follow-up
changes.

Thanks.

-- 
Dmitry
