Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABC23504B
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388494; cv=none; b=dcevY0pEdCZfLF5e3cLOcRqzFlwhoHg0jF7qdqw9FdgkRzz/cbWYyVTF2NPfG+l4tdKLcpuD6pLHQYgQWB92r7hYe+lcOMMdPbXwUh9ZTAV1UA0RkA4O2bUWSdgJEw3Tz3wc6TRUx9/kebBx+K5i0tTXSDgyBnLEdhoiXQh0Lfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388494; c=relaxed/simple;
	bh=nLpPzCe2ljuL0sRb2p6KAKmnsPQb+LnUenFd07PXUys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuaK3YDBcrpcgxbHf6DNW9M+Lrq7t4mgJzT+hdkT2+p/k8Sh5Q3YY2RuLf7JBomKl1exhDRjghXJANf9/cow2rb9n7h88iF0ypDlawRT/4xEENYp/AoMWyjhGfakYu0GYm2AZu6id2BwyuHM7oKVh+ccklYXhipcXBXNXTsIc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pS6dVqXv; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pS6dVqXv"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ed0a45e970so969502eec.1
        for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388492; x=1777993292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=INMBOsmLdoiLumBVRra1XlRsxSOZVzfiWs4rBqTbmEE=;
        b=pS6dVqXvYd7yNReifz9gEY45F2SHZK4C3LRGd1RpCQLA5gbRJQc1f0SKANQ447ZwEc
         CPF/TGJZklmk6lc6t25CtGlhWAvIIyDm5YjA99p+uWQaXjSPvc3VmNj1BXzgnU5lvebB
         ONBaFMQVIVGn6NvbBWxoPzsspWktJ97frJimvpb1kf0Si8ITjg2utpn9oj0nmdtLyemy
         aATH15gECz1Rhou2+xjd0Xs9R8GMf8k3rOavZwQ4JPDya+YdDXDwHQzyAbV4OO0rMAl6
         Lw/OHITW5qAU9gBsxPTWotmOU+4rtjNF3KJs0lSIuV4+wD3NACudtqZbwyEuuf3rmy3V
         3TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388492; x=1777993292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INMBOsmLdoiLumBVRra1XlRsxSOZVzfiWs4rBqTbmEE=;
        b=Be2rSqpOX/8q48TTm8vf7e+CBlQRAXWbVstqPGcKMFYrJbW7zvnJMrDn8g96d+TbEs
         E3cIdx9v/vJ3ihgKKJATWGwmNUuuulvG1/gq6bWbAJtHborxkMzyIYyCDt5/bfGe6n+i
         jyFgUnW9CjahKXAc1nl9//t5MngZUN3+uscot64+gaB5Fcj4PL7lowikPeIUsWdH4eB4
         g5EOV5BUwMd9WEePvO5GFLIwe1rIUEMNB/1jpU1mB5PET++udVPOVi145AXXfDRcEyq7
         aVIbls0mco1cohd+UkOhLNzOXJQopeguais17xKmfLsV/uEPkyulJ7Cx0k2Luo1GAE3I
         UYBw==
X-Gm-Message-State: AOJu0Yxx7CXh2xN4JtID2yoPqNBtozApL4ouVowUi1GBtvWRV8WfRopX
	BXkLgDuNo43LNFim+CG67EkNf8zb44ix1QN34NDoE7t+kUKC8lZWCC4d
X-Gm-Gg: AeBDiesBi17uuWt5E4mZujQ0OfiFNDJTlFXv2nHdzfdfi5Bkp5bZ1sNZAcDR+t5llvw
	+4DLNgFzWbesLflo2gxkgVHnYDd8IRKK2QJOF1clXVMD+xAd+i2Ja2QxmqJOFIEEsNOfNXz10Uf
	bdKFf8AlfcfNB+i40pMRjmUpV+Gee8+WUc67pFuVkZru/Wk+UrHgfYJ6c56QG4MH7WIfTEh7R0C
	/5xBzFLGALaYdan0FWmkcg8TUo86IGNTHWfhhiGyNWesZKMXP/3KJct7lU126Jo4+OKkdDpbyvQ
	dzTUarxBT8SdGVFom0uK2K5pLmsJnYiWrpkXjTZTE8EErk/exHeSbZrT02j/TJ/2R7izx6Vj+fX
	k4ImnlCqoNkaEbPfrPePesjVwiN/NRtFthMkwVu/vCGmOQh5gZefjKeKnmNcUZxOCMSBZGfwiYt
	pWmX1ZoqbVgvNrBpQblEOX6w+hL+TWqUtcXbaAah/u8zdMWbUneUvwhe2UsEHhD0tqbHgMAWrMF
	5I=
X-Received: by 2002:a05:7300:2319:b0:2ed:e12:376b with SMTP id 5a478bee46e88-2ed0e12877cmr1147727eec.33.1777388491554;
        Tue, 28 Apr 2026 08:01:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e678:f42a:a63c:516c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09f8a909sm2669108eec.4.2026.04.28.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:01:30 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:01:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ginger <ginger.jzllee@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [bug report] Potential order bug in 'drivers/input/misc',
 particularly 'ati_remote2.c', 'cm109.c', 'keyspan_remote.c'
Message-ID: <afA2VUnd1GxWs055@google.com>
References: <CAGp+u1aFTivN-EC5QQaQ=j21GaGHktunHEzWQ9e2uASsE40svQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp+u1aFTivN-EC5QQaQ=j21GaGHktunHEzWQ9e2uASsE40svQ@mail.gmail.com>

Hi Ginger,

On Tue, Apr 28, 2026 at 12:18:46PM +0800, Ginger wrote:
> Dear Linux kernel maintainers,
> 
> My research-based static analyzer found a potential order bug within
> the ' drivers/input/misc' subsystem. I will use the potential bug
> found in 'drivers/input/misc/ati_remote2.c' as the typical example.
> The similar potential bug patterns are also observed in 'cm109.c' and
> 'keyspan_remote.c'.
> 
> Kernel version: long-term kernel v6.18.9
> 
> Potential issue:
> T0:
> ati_remote2_disconnect
>     --> ar2 = usb_get_intfdata(interface);
>     --> usb_set_intfdata(interface, NULL);
>     --> input_unregister_device(ar2->idev);
>     --> usb_driver_release_interface(&ati_remote2_driver, ar2->intf[1]);
>     --> kfree(ar2)
> 
> T1:
> ati_remote2_store_channel_mask (registered as the device attribute
> function and exposed via the sysfs)
>     --> struct ati_remote2 *ar2 = usb_get_intfdata(intf);
>     --> ar2->mode_mask = mask;
> 
> In T0, the interface is nullified before its get deregistered. Thus,
> it is possible for T1 to still get the usb dev and access it via the
> interface, which, however, has been already nullified or even freed.
> This similar pattern is also observed in 'cm109_usb_disconnect()' of
> file 'cm109.c' and 'keyspan_disconnect()' of file 'keyspan_remote.c'.

Driver core is supposed to remove sysfs attributes before calling
remove() or disconnect() (see drivers/base/dd.c::device_remove()) and
sysfs ensures that all threads leave sysfs show() and store() methods
before the call to delete the attributes returns.

Thanks.

-- 
Dmitry
