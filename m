Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0144DB72
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933109; cv=none; b=lCj10qkioSsX7Elk/nMQQH4YJmL7GaA/XhHHaV41Vw0Tp0k6i+FMv6uZe4VSqalpmYC/P/mUDDcm/ue/NYKs6GYgO35gOE/dF1dtnqYTM3uzuCMZi7LLtp/YB0zyf/fDCDjXGsnh2tBgKFkTNTisKnTulVMrRVyigrKT5aQGiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933109; c=relaxed/simple;
	bh=JQ6I/dBlxIgIcUf8A4aJYdiBdj+YWBI7b9V02+wm2OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOYxk0nE4ftx/xDc12XW9c4x+ekjWJaFhC36TA+QIhcRWzi8Pe8tMIxrOXZNw/vxxk19jbbmSChDuqMpGKPe0RKDhHF4E7jZFZxo6LgUrdXpsvDBjRld5q9Wdtv4FeFqtUBczbnp1dvaCaOB6nkONwdEjBmOz6Molg0pRyTXKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTZhU6ZH; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTZhU6ZH"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1233bc1117fso76924c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933107; x=1769537907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQYJbZTQw+fm+D6c7DbpOogrd49nWeIx/pC/U0uBVeI=;
        b=GTZhU6ZH9v8EqrJ1r3eD98hSm7vRyapMBXymXQL40TNaf20Hv3L2reKmEV36juICgK
         7tsoFYViYkh3jYUkGIflljvp4Mm+FKgLDQ1cYTA8lJSOVc5b54CifW1+hMox7OMCv3sn
         oqHki6s7+XryS4sy2x+X2jQTVcEQsT52YJTsiZcX5I+40pML3UcbZEeHYD4BZT5/zUcu
         Vg/ahpWF9Dwr2QZ+nmrtJebiKqDHd4gNI5/x9R+UFmCRLiGebyL8EbMjprOVilb4pN6O
         kXaTEuE9Ngm3NTmC8yVRnsS6mZ9yDPyH+f+TdCCTUJ1/5j5FOd3VRg/4nDPWhc8ahOBx
         PkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933107; x=1769537907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQYJbZTQw+fm+D6c7DbpOogrd49nWeIx/pC/U0uBVeI=;
        b=VlNKbjsmsvzIFnBbkYzYfscTAH8ubF/UbyVkSvvPQ9VluQEPgfRy47mQ5sZSMZT4dQ
         Oyd6U7LbiDvI1lkYfVA4THEHmz8Y8GdZWXGmgpfNVtQfvuAWtAFR3HpgR80w4Gl7h1PS
         fZ2wFtYMAn/40HwnspCMbqPTfu8KKg1nVvrL/4E8wjkrzgNoQJexQl1CgACKLwvyZnkI
         U3GvZLKjYvzsKeQ3QnSOszxrI4Zv1SB9iuuvTmoVew/85wJv0lsH7wRQL3Ok7fiWF8uT
         0Ec+6Hva7NXnuiQ3CBqgE+FKBmJxqZxosi0C221LQ5IVyg3UEIdU5xlP3a+KTJkvzPkI
         jlVg==
X-Gm-Message-State: AOJu0YyJZyvpRKNkLxiJbEpUWalOWtOxsKiSAVTltfQ8KzM3KGBvCbU8
	rJkehKbqSekBClwQtHMxiTiUkPlJZQT2TXvt/qK8qf0/Rp5ltWK5XC4I
X-Gm-Gg: AY/fxX6YFEtxI2PyWhlBmSiIkvVg6pLBZ4wKt5oc/YphamoA/c+VgEHfoJ+JiGnuzme
	G0IUg6GjACOBAqB46CcJ5YdIO+2XCRZpXdtpVUWVKS3mHHyf3hOm24y95uymUIo+ddf8+M3NrUD
	IWdjVtGONWdMT8lJz6OMFvzj314XG5wL0wSrL/Pbd0+AC9BpAHpwRpsdClAaxuKZ7ogEyPMiZOD
	uLjXbJOPGGtWMJ4WQ3Ur1diLmvEbgQrgBBokTymp6zguG4XX3yhsBgYglsNqcTQtHSJNLP9DdTe
	YpiICydhQVA8MJ10SeeXyglOyD8QHd9/7+jjUrZzc+gmIpGY2jwuXH+F76bzoM3F4Tl9T6b2AXA
	mArecEMsk8YOqOvWyYS+/O90Ho3u6BdnX4hGmeDXGnE3d4aoolokS5i2Uhy0rMsLjekexJXSiyv
	/QuXaxl1piJ3oII18dN+dlFC6GlEYFzxTrlumIrj/hiE/cRRKuOX+MY1LakSYkUVk=
X-Received: by 2002:a05:7022:258c:b0:123:3c65:d724 with SMTP id a92af1059eb24-1233d116ce1mr14616987c88.25.1768933107050;
        Tue, 20 Jan 2026 10:18:27 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefaf0asm19040938c88.9.2026.01.20.10.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:18:26 -0800 (PST)
Date: Tue, 20 Jan 2026 10:18:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haowen Tu <tuhaowen@uniontech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: appletouch - fix use-after-free in work handler
 during disconnect
Message-ID: <qg6meqq256s277awsoo4xulkdthfimvhlowp7bmuk2annscm6q@hqtttyufeonm>
References: <20260116031113.1003940-1-tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116031113.1003940-1-tuhaowen@uniontech.com>

Hi Haowen,

On Fri, Jan 16, 2026 at 11:11:13AM +0800, Haowen Tu wrote:
> The atp_reinit work item is initialized in atp_probe() and scheduled
> from atp_complete() URB callback when the device becomes idle. During
> device disconnection, the current implementation calls usb_kill_urb()
> in atp_disconnect() but fails to prevent the work from being executed
> after the atp structure has been freed.
> 
> Although usb_kill_urb() terminates the URB and its callbacks, there is
> a critical race window: if schedule_work() is called in atp_complete()
> just before usb_kill_urb() takes effect, the work item can still be
> queued. Since atp_disconnect() immediately proceeds to free the atp
> structure without canceling pending work, this leads to a use-after-free
> vulnerability when the work handler executes.
> 
> The race condition:
> 
> CPU 0 (disconnect path)      | CPU 1 (URB completion)
> atp_disconnect()             |
>   usb_kill_urb(dev->urb)     | atp_complete()
>                              |   schedule_work(&dev->work)
>   input_unregister_device()  |
>   usb_free_coherent()        |
>   usb_free_urb()             |
>   kfree(dev);      // FREE   | atp_reinit()
>                              |   dev = container_of(...) // USE
>                              |   atp_geyser_init(dev) // USE
>                              |   dev->urb // USE
>                              |   dev->intf // USE
> 
> Fix this by adding disable_work_sync() in atp_disconnect() after
> usb_kill_urb() to ensure the work is properly canceled and cannot
> be rescheduled before the atp structure is freed.

I do not think there is actually a race. The urb is only
submitted/started when the device is open, the work in properly
cancelled in atp_close(), and the input core will ensure atp_close() is
called for opened devices. In fact, that usb_kill_urb() call in
atp_disconnect() is not needed at all.

I see there is a potential race handling dev->open in the driver, I just
posted a patch addressing it.

> 
> Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
> ---
>  drivers/input/mouse/appletouch.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index e669f86f1882..aa2870a87eee 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -946,6 +946,7 @@ static void atp_disconnect(struct usb_interface *iface)
>  	usb_set_intfdata(iface, NULL);
>  	if (dev) {
>  		usb_kill_urb(dev->urb);
> +		disable_work_sync(&dev->work);
>  		input_unregister_device(dev->input);
>  		usb_free_coherent(dev->udev, dev->info->datalen,
>  				  dev->data, dev->urb->transfer_dma);

Thanks.

-- 
Dmitry
