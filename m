Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD522882A7
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769978440; cv=none; b=MTnbUP1XjPtHRRYSi2tMSl15MUbvz0w6LgdNPtOveVJHcWYZC7JWFiSsPgk1WdznVM8aFDPQH1mlYqKtMot6Gt8QLj1Auayuf6UuMWqTKTP3X8QLfTrNCMEPsoOxb0UrvgNxWD3a8HbCP6uJkH9zSdZQONzTh3l838dTZ6Q1/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769978440; c=relaxed/simple;
	bh=C8qG2GyNg+8v0pV/Gm7iEjfkSjPC2wBDY+ozQE9voCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwPvdG4KIXscpViK+B6hPkUZhTXFzEsAEg+wnXoDjuM3c9ouRGX1exMi9JYsEDLwZ2iCtsLlKG1UVs7rPPccMDhNwZU1Bn4y+ST6M2KyDMD80rekGdKkuSPbgs+AA6xStvN7KMxjP6A3lDw2sxR5gX/uLASSjzCrwcIrA+xSt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=EiC1RcZ7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="EiC1RcZ7"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c52c67f64cso359969985a.0
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2026 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1769978438; x=1770583238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJHQuz4I598+LhTVZjOstxuYO0msUwyDAHZS8cCKma4=;
        b=EiC1RcZ7yLkP7LH1H7EzVOKVYSrvKFXV9RSBLwh10XpA0ZcoJh8u7/lj5XWNxx45hn
         /CnrtcmCJ2xk5lEYLb6en75yHQvHS9rwsNPrHkJ8Qfe94yc2QHxEPdxsUZP6WL8oAWTc
         P+hfuDg5HprRX1J9MJZW9kHibxuqzvnGb6ioBoL67mMUImbByN5W7QGFx7D6mdKGQsOb
         Ruqo4AihLdylr313AlzYp4un2vtS/tH0d1gFwLebNpc80nj0d5V6clGQFmfcLukRGrEq
         WzkYR0Oa2Nxb0dmni5AbVmIyVeusZOcufSv7bxflx4OIxW4LnVJ/sR4PV2/IeMSrz+sS
         HQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769978438; x=1770583238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJHQuz4I598+LhTVZjOstxuYO0msUwyDAHZS8cCKma4=;
        b=A9AGkVB8NGybYDR9pTL+/vPnInfvLB9CtxgJWUmyTH7T87WhY/NYDB4eeVV6w5/pGg
         8Gr3HElJtQE6eS0aXXb2nG3dGcAdCMxlHPE3zlcBk8y25FhA5Pb3L5l2NmBgRb5vBQCg
         K5s5QU4uhlxLU2TQPW5QDkVkcIQm7Y2f0VznmeoQAp07PO3KTHFyPCsesDGLv0gxnWZH
         WTTtivtMp2PPlhk9HfJkDyzN51BjQYNTdgjxxnRnxe7LqtAdOYF09bE7Yacb/PXkIF+i
         wX92yUP5VKShuiGNEXa5Uc7/IxA0ZFIAuLoybGnlSre5IBgVQP+eeuensBWvx4Z+Gugg
         HLaA==
X-Forwarded-Encrypted: i=1; AJvYcCXb9fb3XganhFFa5u179Gk74RSLc1LB2NyP03rCHb+hl6MPOOTwB6jaVPD8lDOklBGrgSX8Fl2j5w94qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1TyvcqlCIcBJ1ESfNjyd9GbEZ+Ai7fjjjA4M58NPLktTLq/s
	OTpNJf47Z8zI6CyG2WspuGNhf6NOmn0bbBsTfs+/Ysti95++PV/QkoTq4Rv0LkrCdw==
X-Gm-Gg: AZuq6aIhYXRU28hCQJmqCRTnKTDBQ1kvye6IeoWDSpkHKcr9oqsfRVnIt1yj4pkoTP6
	1vOeg1f2kyBdQQCWJbR9qXrm9Y+ThTzIqxSgdqzpB17fQRK7HrMq1lJDIK3EaC8nHpnJnVZiFyA
	bsKHP/GskWChRxdJKkLnNg1xolEFO6FRceri7J0j9OjFUYdQj620LWptaM8ktA/6Z4IHIYMfGDi
	v3N204aLRGsv6z47dJU/cdv2P3J1DYac2o1nBWJEDmJewIWbTWDSm9QJhycrIqC1XIkfjzdqjvC
	dnr1RrNUTUeFJ7aRXyaUAK66quUlnVdvdEPYcRLbs9JIIM+5z+WAN26gwyrKA6HHoPkFHjh71X3
	Yic9wg0MkWbygI524VJ+4PdENtcbB0PHZZq+VcJxI6AiscDU024FCuMf17Mq6vwim5GucMaCyzR
	KYhw+i3I81OmqS
X-Received: by 2002:a05:620a:7103:b0:8b2:f090:b161 with SMTP id af79cd13be357-8c9eb277ec6mr1174709185a.32.1769978437643;
        Sun, 01 Feb 2026 12:40:37 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::7a0a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca02eedf76sm337064885a.55.2026.02.01.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 12:40:37 -0800 (PST)
Date: Sun, 1 Feb 2026 15:40:34 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Liam Mitchell <mitchell.liam@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: usbhid: Intermittent EPROTO errors trigger USB reset and
 interrupt user input
Message-ID: <1ebf9d19-7293-4902-857b-164fd4d21f25@rowland.harvard.edu>
References: <CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com>

On Sun, Feb 01, 2026 at 06:57:06PM +0100, Liam Mitchell wrote:
> Hi,
> 
> I'm trying to understand and fix intermittent keyboard/trackpad issues
> on my 2013 MacBook Pro running Linux v6.18.4:
> - missed/repeated/sticky keys while typing (this thread)
> - trackpad stops working (see "bcm5974 trackpad broken after USB
> reset" in linux-input)
> 
> The keyboard (usbhid) and trackpad (bcm5974) are interfaces of a
> single full-speed device behind a high-speed hub:
> 
> /:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/2p, 480M
>     ID 1d6b:0002 Linux Foundation 2.0 root hub
>     |__ Port 001: Dev 002, If 0, Class=Hub, Driver=hub/8p, 480M
>         ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
>         |__ Port 008: Dev 003, If 0, Class=Hub, Driver=hub/2p, 480M
>             ID 0424:2512 Microchip Technology, Inc. (formerly SMSC) USB 2.0 Hub
>             |__ Port 002: Dev 005, If 0, Class=Human Interface Device,
> Driver=usbhid, 12M
>                 ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad
>             |__ Port 002: Dev 005, If 1, Class=Human Interface Device,
> Driver=usbhid, 12M
>                 ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad
>             |__ Port 002: Dev 005, If 2, Class=Human Interface Device,
> Driver=bcm5974, 12M
>                 ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad
> 
> Logs preceding one of these events:
> 
> [19607.563871] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> [19611.523681] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> [19614.550685] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> [19614.563878] usbhid: usbhid 3-1.8.2:1.0: retrying intr urb
> [19615.050802] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> [19615.067673] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> [19616.822636] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> [19616.835934] usbhid: usbhid 3-1.8.2:1.0: retrying intr urb
> [19618.126656] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> [19618.126711] usbhid: usbhid 3-1.8.2:1.0: resetting device
> [19618.126728] usbcore: bcm5974 3-1.8.2:1.2: forced unbind
> [19618.129942] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb shutting down: -2
> [19618.155292] usbcore: usb 3-1.8-port2: not reset yet, waiting 10ms
> [19618.217146] usb 3-1.8.2: reset full-speed USB device number 5 using ehci-pci
> 
> Both interfaces receive frequent EPROTO errors. I collected statistics
> on the error interval over a 30 min idle period:
> Interface, Count, Mean (s), Std Dev (s), Median (s), Min (s), Max (s)
> Trackpad (bcm5974), 631, 3.21, 4.75, 1.74, 0.01, 35.62
> Keyboard (usbhid), 71, 26.82, 24.90, 19.34, 0.92, 107.74

There should not be this many EPROTO errors.  The fact that you get them 
indicates some sort of hardware problem.  Have you tried swapping the 
cables, hub, keyboard, and trackpad for different ones to see if that 
makes any difference?

> From debugging I understand these to be missed micro-frame (MMF)
> timing errors in the host controller. They require URB reset but not a
> reset of the whole device.
> 
> The bcm5974 driver simply re-submits the interrupt URB. This is the
> best behavior for these errors on my machine.
> 
> The more "correct" usbhid driver will delay URB re-submission and even
> reset the device if a second error is received within a 1.5 second
> timeout. It's these periods between EPROTO error and re-submission of
> URB where keyboard events are missed (missed keyup == key stays down
> and repeats). The default error retry delay of 13ms is relatively
> small but a full device reset takes about 200ms. With the frequency of
> errors I'm seeing, every ms counts.
> 
> Can we improve the usbhid error handling for these cases?
> 1. Reduce first retry delay from 13ms to 1ms?
> 2. Reduce the stop retry (reset) timeout from 1.5s to 500ms? 100ms?
> 3. Require 3 or more errors in the timeout before resetting?
> 4. Ignore EPROTO errors for known hardware/quirks?

It's possible to do all these things, as far as I know.  However, it 
would be better to eliminate the errors completely.

> Are there ways to differentiate these safe-to-retry MMF/EPROTO errors
> from others that may really need a full device reset?

Not that I'm aware of, other than just by retrying.

Alan Stern
