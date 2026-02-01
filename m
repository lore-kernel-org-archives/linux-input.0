Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826D26E173
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769982676; cv=pass; b=DxiF6qfa95LU2F95DHhDintJhDM4eHWGVY4VU+72o6KvyRldXRHTHh21sjNJlvUSKwmkgi38siDz4QZSoKmYaLdTWk5M3+8PwEkD7gXH/f602Qmy4KpSqfRATAzMpSG+ICNMY7hvQIFnpIbuf0EnuKme/WoWsup2hGQYgBWhs+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769982676; c=relaxed/simple;
	bh=kwpfg0ZVrz567GYf62txLzegDx4FdKLKozNj2UWgs2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7qLrFUTMzrdbpHgbZdWjLTkvOopVFZ8iDJBSCsh6TLzUr5hy/X8i+F8r/HML1ej8ByTI6hkEjJ5/rz8euCRZmDeTtFWlNV0UPzZOYwAjI0fQDgDLDR5rDws1RaWZPzqz1ndFQg0c/dp1PfdXEhN19iIFbrSTdf3IcMyUut1kcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXqDli5I; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXqDli5I"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12336c0a8b6so2162936c88.1
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2026 13:51:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769982674; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/w1mH8me1UKACl/tOq0o0ne8bbhmcFbK9jKZ6/Bcg0LEpkFDh0LCpySR7mo5QZvhI
         bWtXpI1YDUJFZu8MXRCUsI7FMra1XG6Bm4uvYAV7piL/OKsq1/Q3b8Z+W++mXbRtQmjU
         8H4MwEXQcwnDgqnGgPuwj20YYLca2c5BMCiYfYMfN+vJH1ycjKUP2Qg5FwcvcZ/7ApZd
         ELgTAEBUOzWWHl4E15xwqMMnwSfqL+JFRTIbEp9cUWeaTU47Vo6h2OAT80Im9BnSSIhh
         Cq+sEg3mj2/ouhhnzdBUxIWmZtx6ID2XAyBhNOmjjtUsdEXS4Gp9Kk3bmBprqSdBRdbD
         Zp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XeKA7cavJtekB4Vvd8t/pKrhDnNoXuIB+ADubn+vkJ4=;
        fh=/ys5B270Tp6ILbZ0yWHIygLJxtFm0z4/SMGCYMc2GnY=;
        b=QZ2nYOfGy56h4AgJFJJJCx2fMl7/tQXZBLM4NMonQdyratwGrkALc0CKIbv83aeRVP
         kBAw0U3Tw1D757k5fFg4dTdYlVup97WIP21+QZB/I26o9A549waPB2O14hi9qeJl+paN
         D82sZnuKheRAve77zo4kFjnNWnfntcDvr2/9bPmXjX1JLmQlENjMUXOhGgWg0EHCOMA1
         WgC70a+0lTj10cIqu4gCvJcQMZkw5zPeEh2u1PBwN/7ACZ/knGaCQ3aOno0B42i81R07
         zg1JGgYu9PmnTKlo6lHzGZPW+4EA3Weg1id8BgAsgcXhQXQHxw1Y5DoUljx573aGzDZ3
         t0EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769982674; x=1770587474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XeKA7cavJtekB4Vvd8t/pKrhDnNoXuIB+ADubn+vkJ4=;
        b=DXqDli5Ik1ELrHRrxi8hWv61bfprjoDMIvIw5+PWqRy/VD5/f8oCwCTUbQpcHAePiu
         QaJivYVl7g1Evf11n/YmfFkTt/vE6YGXywQrD862VQDvHoS+2yqkV9LhimsciWInAiNH
         EKcYfsvyR6yj6y7MP4qdKHfkkSqPBacQacTecNzNi8saXrYUN22Rg+ab1gGoeGH1UEUk
         mdNd+lkdHaVpbHvcQho0mP8NQOhhxTCFZTEenZxmB0SQZFx+rBFYZa+jewrG6xu2IGg6
         q3kUG2E/bwR8FXDHpyV7rNRcKhLaAeVwFVt2vcOx1MyLqOxxByXZEIx5RL8Lw9Lfn0a/
         rXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769982674; x=1770587474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeKA7cavJtekB4Vvd8t/pKrhDnNoXuIB+ADubn+vkJ4=;
        b=RN4dg/Bvat+yZcKKZtLh1tZGftPbcAiqZ4z++bcM6pKj0DXt1qRxaHxmt4qBxFAXmZ
         H76ut706CpTaAbUBHDUedAfL1or41blApDzuVcxMJsKNO6YDngGfs+7JZb8RY7s3Xsjy
         eQGJxaou1pZrhSjlZ/PYeyf4T+eO8IwhblpWoE2Wny+FbxHLlCG21eyWbwFX4RVibmK4
         BfNMSSMMnhJmHjVqIG5JBMfUwM1UAL08X3Zmy5eVU6Uz1c2qmuaIupyEu8ruxiI5xME6
         Owxqtg7h1/RVS5wk7kj5ZwJu6pwWv8DyhuXhzU9Km862sCdechd8QCOLS39XCdgaq1XG
         xxYg==
X-Forwarded-Encrypted: i=1; AJvYcCWkTTFR5csPdmajCTzI+k6GWRLDqObcQ2TVX10irOhyAcUPFmlVcJz7A78pNVl9KGNzSuaKSTJlMFbODA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznvDf7mKI3LXdjSoNhOOfzfkvgvH8A4MAMPWzkLu8RH1KlThMF
	jNv3KuAP+3B9ywpgFpKRibwzMNGU7sSpwIFHsEzS3i2U96munSHSIWTIgvIuw+NzyKLeoDN+8h3
	r+13ci+LCkfwgepbSfT8R+VVkAPa6YB4=
X-Gm-Gg: AZuq6aLjDZJH/eqb4zgiOdgVZJMdzlG+GsqLMn1gpvvsPztfiVqa4ZN+d90h0Zm88Fi
	KusrJzIKOHTRhWKpI1RDcIJrslnaGvQpka3yvHn0E6FeGljaPSIxzewO7P7H2fedQNw7DAKv33I
	LCEeuD4Gp7fIwfBnUTK4LIieGHkKCOhRi71vLIjtnEKh1igDnH+6bWTv7qahx37NxNcAH0YFCvV
	O+XCJeZfV5F8wt9BDM+j6sqsxGUx/RRPoW7HTP8n0qkHW8PKYVEceGhW9wL+WVOZKD4NghtM7sN
	DBDqWj8DJB6LAKov/ik8OatIx2u5
X-Received: by 2002:a05:7022:fa2:b0:11d:fd26:234e with SMTP id
 a92af1059eb24-125c0fad94amr4583788c88.16.1769982673719; Sun, 01 Feb 2026
 13:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com>
 <1ebf9d19-7293-4902-857b-164fd4d21f25@rowland.harvard.edu>
In-Reply-To: <1ebf9d19-7293-4902-857b-164fd4d21f25@rowland.harvard.edu>
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Sun, 1 Feb 2026 22:51:02 +0100
X-Gm-Features: AZwV_Qhs-WY2_60cX_c9YRVlzLK2U4abGWLUMcy3kdEuDKMm80Vfms8FqliBrew
Message-ID: <CAOQ1CL7RpygHvzFhPLFsiVB7PFOh2t+_piO5vFJ5V9LCBC_LWg@mail.gmail.com>
Subject: Re: usbhid: Intermittent EPROTO errors trigger USB reset and
 interrupt user input
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-usb@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Feb 2026 at 21:40, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sun, Feb 01, 2026 at 06:57:06PM +0100, Liam Mitchell wrote:
> > Hi,
> >
> > I'm trying to understand and fix intermittent keyboard/trackpad issues
> > on my 2013 MacBook Pro running Linux v6.18.4:
> > - missed/repeated/sticky keys while typing (this thread)
> > - trackpad stops working (see "bcm5974 trackpad broken after USB
> > reset" in linux-input)
> >
> > The keyboard (usbhid) and trackpad (bcm5974) are interfaces of a
> > single full-speed device behind a high-speed hub:
> >
> > /:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/2p, 480M
> >     ID 1d6b:0002 Linux Foundation 2.0 root hub
> >     |__ Port 001: Dev 002, If 0, Class=Hub, Driver=hub/8p, 480M
> >         ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
> >         |__ Port 008: Dev 003, If 0, Class=Hub, Driver=hub/2p, 480M
> >             ID 0424:2512 Microchip Technology, Inc. (formerly SMSC) USB 2.0 Hub
> >             |__ Port 002: Dev 005, If 0, Class=Human Interface Device,
> > Driver=usbhid, 12M
> >                 ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad
> >             |__ Port 002: Dev 005, If 1, Class=Human Interface Device,
> > Driver=usbhid, 12M
> >                 ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad
> >             |__ Port 002: Dev 005, If 2, Class=Human Interface Device,
> > Driver=bcm5974, 12M
> >                 ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad
> >
> > Logs preceding one of these events:
> >
> > [19607.563871] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> > [19611.523681] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> > [19614.550685] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> > [19614.563878] usbhid: usbhid 3-1.8.2:1.0: retrying intr urb
> > [19615.050802] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> > [19615.067673] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> > [19616.822636] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> > [19616.835934] usbhid: usbhid 3-1.8.2:1.0: retrying intr urb
> > [19618.126656] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
> > [19618.126711] usbhid: usbhid 3-1.8.2:1.0: resetting device
> > [19618.126728] usbcore: bcm5974 3-1.8.2:1.2: forced unbind
> > [19618.129942] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb shutting down: -2
> > [19618.155292] usbcore: usb 3-1.8-port2: not reset yet, waiting 10ms
> > [19618.217146] usb 3-1.8.2: reset full-speed USB device number 5 using ehci-pci
> >
> > Both interfaces receive frequent EPROTO errors. I collected statistics
> > on the error interval over a 30 min idle period:
> > Interface, Count, Mean (s), Std Dev (s), Median (s), Min (s), Max (s)
> > Trackpad (bcm5974), 631, 3.21, 4.75, 1.74, 0.01, 35.62
> > Keyboard (usbhid), 71, 26.82, 24.90, 19.34, 0.92, 107.74
>
> There should not be this many EPROTO errors.  The fact that you get them
> indicates some sort of hardware problem.  Have you tried swapping the
> cables, hub, keyboard, and trackpad for different ones to see if that
> makes any difference?

Thanks for the reply,

These are the laptops internal keyboard/trackpad/hub. I would have to
remove the glued-in battery to even unplug the internal cables. If
it's a hardware issue, I'm assuming it was like this out of the
factory.

I haven't had problems with external devices, they go through a
different USB controller.

> > From debugging I understand these to be missed micro-frame (MMF)
> > timing errors in the host controller. They require URB reset but not a
> > reset of the whole device.
> >
> > The bcm5974 driver simply re-submits the interrupt URB. This is the
> > best behavior for these errors on my machine.
> >
> > The more "correct" usbhid driver will delay URB re-submission and even
> > reset the device if a second error is received within a 1.5 second
> > timeout. It's these periods between EPROTO error and re-submission of
> > URB where keyboard events are missed (missed keyup == key stays down
> > and repeats). The default error retry delay of 13ms is relatively
> > small but a full device reset takes about 200ms. With the frequency of
> > errors I'm seeing, every ms counts.
> >
> > Can we improve the usbhid error handling for these cases?
> > 1. Reduce first retry delay from 13ms to 1ms?
> > 2. Reduce the stop retry (reset) timeout from 1.5s to 500ms? 100ms?
> > 3. Require 3 or more errors in the timeout before resetting?
> > 4. Ignore EPROTO errors for known hardware/quirks?
>
> It's possible to do all these things, as far as I know.  However, it
> would be better to eliminate the errors completely.
>
> > Are there ways to differentiate these safe-to-retry MMF/EPROTO errors
> > from others that may really need a full device reset?
>
> Not that I'm aware of, other than just by retrying.
>
> Alan Stern

Liam
