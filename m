Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DE37BE7F
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359606; cv=none; b=hQcA6khTON9DR9HFjOyNArBsyKg97xP0maijfWBXZvmjoaATUAW9JjY99tWnF2XtGlsp2wdv2dswIsGPU/8Rj7z/GuIaFfskIZETRixr/nWvARMsU9iH4BTtSu4pvvnly4xGcYorzW2mX1h6ACuFvYXMIjSDvRxMwNW7WRx/+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359606; c=relaxed/simple;
	bh=gB9UGxCWxD/PtBMHenHcj06EGocK8eI8EN2Vt90PtuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMrCs61Ntcwqlj20pbOutg8CTyONW/slfmRPscPnlhxFCmNgLrgKEv/O3B1gYU8+z+koVH90Fo7NvoOp9Fq0LeYDu4DLv7MyAh3qSd9PraoIxvv7EZY2TQrx9BIZReMN19Xa0FVH3V6T/1iNNX0uDxJIrtbkWuO1XF5zaAsgYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=bGV68UCs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="bGV68UCs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb20bcff5aso472875685a.3
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1774359604; x=1774964404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8FPgOYJRQg2TdSQ65IcaLDL29XA7DW6gJZHjee2pCc=;
        b=bGV68UCsFF4FxRtVW/vq1xVoHoWI8wwM81iNK/x0W7LnjtdStUC9tWPUxSdx9Fifbj
         evBnsEItgui46b0YA0p+Ot+HJzC3qQFPMi4ISsfgcPZNdnn6JibogN+NqhhAxTELOYhT
         005ldLSoFwG7tBVf6VhH65pp55bo2o3QDfAtRft7JVe+bS6paoGA/WYZXfkDELJBmCte
         xtxlkTG47zUGBmLbytUvI/GEag5RfDAQ9rzoIz73ZaHCGG73HTJyXKpeGY/cNsf2L6F/
         Zvy9/Our6dpdxwuPos76S5hYZgZhbjs7wrGJuO/4X/q1ulSpmvCc3oCMt72DCehMWbRG
         IOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774359604; x=1774964404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8FPgOYJRQg2TdSQ65IcaLDL29XA7DW6gJZHjee2pCc=;
        b=f7mGkz8uFZLa4B/BFC61aKOI12FFHe1vs1zRTC+U6xuQ2xUiXCswq77soY4yw+XMqO
         INwO23+3xmmtlwsJB/mrZYQZ1zZkb6n/miab0lB/M6H0hu9Ca40GQ9uVtU7YQHHVvTIf
         rpApnxIRu8dMOD/he3Eg4vy52VuvjLgGAgGlV4k9qvDwlOPjUvBjX/IufgFvqMCPuRlc
         LoK6fXpGbtShD7vWPP9nkPSRvDwrEQgiqM+e7mQdFlaFk33ZJ8rk1yWtOC3Pzd9gfT2F
         9r29+pBHl4kLcpXjk8Fh3jcar+LhguVHRQoF1T9pEoY2ct0daTXmYlbHveB50OSKN40I
         vA5w==
X-Forwarded-Encrypted: i=1; AJvYcCVpTqDP7WSHlofnkg1dsiRvfiqoxmmp+RmiMn4fDLbbuCoXJgSElCFAu3C/LMg1GQRTshKSS6375J+E8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pE4e61wVQjtkq5uqIBS859YVr7lQR7SiyNJ/eyiUJmnMrWSC
	dDqE4IQA7+jfgkYanZoOKUjXRbkYv9r46onUsjVQeQm4eoK7ts/4AOuI9m01OmF9Yg==
X-Gm-Gg: ATEYQzxqDDd8JpKYZJojsGlx3aJPpEhu3Ig3wUbIrNZPMg03KnETfwa+YJbDWMs9v3V
	P4Z00pv7Ww3WAJP2kFYiw6cqJf44HfQ4+Tqxcd+uvptlCriT3a4/3yiaFKaE0OPE08BaUdVxWb8
	03jWazx6l5guK/wxwOKyBagQaHr+y7wrpXJX3exHeCaHROMqfk+Z0OWpqaAxJgbYNI8jhZrH0+k
	JbTtW5dJ7JEwFLmSs/Z1++cbtONquVDj5yMGxTKZGdnjsvEa72SaQxyTxADALwfggld4irgw+nB
	r/i0LVo86jht0OVSTnh1GBm1YXaHAxuWQCzq9kZrFleaMVXHhYAjijKN5jGnnA88lxqr8mnEIm0
	o2qBDWT+aufnH/ZK1Vs6iYinb+B9oEfhMLGFKQvekLmNDdNVQyylUehC4k5jgloWxfrFQ0BAbxj
	oUgQDEziN44dGgtLUqvUNeBjg7
X-Received: by 2002:a05:620a:28d5:b0:8cf:e0fe:f21b with SMTP id af79cd13be357-8cfe0ff1025mr1325658785a.16.1774359603620;
        Tue, 24 Mar 2026 06:40:03 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::9c76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90ba89fsm1046907285a.40.2026.03.24.06.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:40:03 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:40:00 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: USB list <linux-usb@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: Question regarding error handling in usbhid
Message-ID: <5ed78115-abbb-4ca7-ab07-2280019f6ab5@rowland.harvard.edu>
References: <8d665258-6dd6-404a-85e0-a2f3420cd992@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d665258-6dd6-404a-85e0-a2f3420cd992@suse.com>

On Tue, Mar 24, 2026 at 10:57:16AM +0100, Oliver Neukum wrote:
> Hi,
> 
> hid_io_error(), in case it decides that a reset is necessary,
> schedules reset_work(). reset_work() in turn calls usb_queue_reset_device().
> Why? Is there a reason usb_queue_reset_device() is not used directly
> in hid_io_error()?

This is partly explained in the changelog for commit 8f507ef522d5 ("HID: 
usbhid: improve handling of Clear-Halt and reset"):

    The way resets are carried out is also changed.  Now the driver will
    call usb_queue_reset_device() instead of calling usb_reset_device()
    directly.  This avoids a deadlock that would arise when a device is
    unplugged: The hid_reset() routine runs as a workqueue item, a reset
    attempt after the device has been unplugged will fail, failure will
    cause usbhid to be unbound, and the disconnect routine will try to do
    cancel_work_sync().  The usb_queue_reset_device() implementation is
    carefully written to handle scenarios like this one properly.

The other part of the explanation is that the reset code was added to 
hid_io_error() before usb_queue_reset_device() existed (2006 vs 2008).

Alan Stern
