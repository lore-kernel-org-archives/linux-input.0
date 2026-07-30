Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420245FFBE
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439703; cv=pass; b=IXTIC4wDYMiR6RCpCcf0dMFwxF1ngTYHPtHOHDW6DDOc9r+jlx/M5kuPDCLm2vrKvl3V9PFyJr69UIufpGUvYlCI8egJFnlcuf8EQ7NI/qSXgJ7RdRK8S/ePoCBjuDPZkdP0mXLK7LwM9NVGCaGSX+NW6Vu8qJgdWXwTNxenI78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439703; c=relaxed/simple;
	bh=ll/FaK04GC8vCwFkBBQHSFd/0rrd11opybKM/RHi/Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDpRdxH3nJp3ad6aJozQyDlR5yvj7A3ME0vLO07DIUdupJzvUKOTWL58/HLwyZeFmHvwoLQoRQ7mpYvaQ2hXkTuvpE/L51Lv16YjIVsFsS3jneWhCut8BsLO7FVZt19JxXe5gIFg1RJnyX5Vix02zsJflCjld0MzZNRe98Gfbno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDTO8Fba; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDTO8Fba"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so43849a91.0
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 12:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785439695; cv=none;
        d=google.com; s=arc-20260327;
        b=UXnxiDU5lg18vTI1HbBlnOdYuFNMkvD5BSGB1Cb7Yl06EAhRjxgwdm6PGcWc5JJtXx
         q7cgz6D0Q+dk8xe4tAfUMaMJ+v0mIMCj+tvghMNXuX1MdGnCIvrbV0tPDhnPGgYLWbpZ
         dYA4W+5hn1xAQ6alvikvsNcoDbc8ujDqnxlv4R/sVNYllZvEQdQNlBIZaFZj+nlVl+ir
         zhEWf3LPNyRLkQJlwLekLDk42LwCDg8EcLDeXwoPUN52EAHlVuCowkQCqk9zOrjIhFSO
         dPYevub8d4xT19/90wxSC6R5cJPNTq8NyX4C3DVzE5p2+yF3HNKmK2MSkhQofC4jIJXb
         YIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hs3O7+0+O1BzynlCu6bABVAxk2P74JiftgV+5qL8qh8=;
        fh=AixnZChnQQCgr/B7uVIHCO/p9qIF1As8zqS/66kZ4Y8=;
        b=TR3gUVPtK85QgJfJmFRZ4MyudcpviR/8LtWzKvMWWTWLpz0Cz7/8s0iH3WStACr/uy
         dbVazPu2LHRuIb/5uryn9xkIPamTUcjlyzixisgiv9wRyIMcb+3dLbvDUDEFPMEgqZHN
         RJCop0rNA879sChbz/XLj3rVcVqNwcE89uLQX5OTDWy/VYA8xe8Dh/e8MS9rIAmKzXSD
         SIwHqmO0Zso16LRRAA3eEYyEP3gtFVenxgByMQyz+4UgrNwfNTI87gd5QjTQGVGlaK8d
         K2h4+lFoaFRHXNP2NGo9CkG+9BpkmrL+8hboVGfmh//JGglkj2urd2VrRD6Pc9Zckxmz
         tGJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785439695; x=1786044495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hs3O7+0+O1BzynlCu6bABVAxk2P74JiftgV+5qL8qh8=;
        b=KDTO8Fba/EqjXNBQZACIfEE6OX698r6ac6Rhy+1Jr3GNSzF/wyiyO5UGEdBuxeNGJI
         0FmReaDwEPJNp4sJ2jKyRfYG/PtZeH9ldIl+xPnUw6mptx+ukGjzYDf9zQ/lw5otqvqH
         n7IhzLeRll721j62b/a47gx1UqDm3Sbz70iU0bPVVQZAG3CAKrZg1FCCwDb159HiEuCy
         1gRlaSXZLShIBUojbLXYlroacPMCEmmcpGvLwOnVryuou7b5XHefntgd40Cqjf3gcX0b
         t29EyMNlITuEe2+8SkYw3lLdXdxMfwyL/6pGxnN7qq9acPFJuv68HEAuOYTw16oRE13c
         FA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439695; x=1786044495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hs3O7+0+O1BzynlCu6bABVAxk2P74JiftgV+5qL8qh8=;
        b=as8eDzbvBfedJV2ym1auhVs5uy4KP0isUhk/3Abds3ftBDgUORdH2pVHL0ahh45AKp
         TlK7lbUD1A5yH543OOOWxe2KArwK1YrkzZc4X8k0lEmUwmOuQ3YOJztKFKe/q2Vs0eRl
         7NZOj6lJqXrtAuK2P/mPteGLjTFC14RQyo0NJb1ByIpg4BOvfBTpRHCHejWx7uDXdPyZ
         5uisxeDtqUA2LsjHVq+I6FCdQXUAoiOCSRDCgFf4Uxns56r0Iv6lu+3NiNoROsvjVP3j
         B7NSE065h4d/LF+Ze7Lg3Dq6H09iiqL65IaF4GPEuchFix+BM9aC5JmHjjR3pK1ZeagS
         Hp8w==
X-Forwarded-Encrypted: i=1; AHgh+RpEQrUNgSrPl3S1ihKrRccd9jgkdZOEZNZt4xvlFx9j2Wwcoud3/aTfU/8vAsgpPe9H+yJP+oh8hL+DwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOPwPtnqZVY3yGhu6M0PvOZyBrF4BRzAwnJLR48dGqdlor00s
	TsmvVybcoaS4BcZJKCGIbeS98NqcOZ8WI0XW+NW3VL9vcRsKa3HXf1Dadw6kOfc01AjBAup06aS
	gCwoeT8t0Evf1PfV4wVtsGqg7afZeiVA=
X-Gm-Gg: AR+sD11F64oCMyp499icvnyCM8uW6ZIrvqIbnprTIZe6eG2G8OaSI80rAaRoeD13mml
	fvEP1sWAXnBlWjP6z0R3sKxVq9EEbRE1Xiv1ex3w7U3tN3p5iduvRaicm7vclrDbFy8CI5ElkaP
	DYcXc4qYCs8Ix02fWFNHdNB3Mt3+KSbUXIbQ8iDPBATr/6WgARdgGTIiLFFRO8RuDrW+G714SWk
	H6yqU2rVnu1tmw7NqubVwJKi33kuyKdFKTBqcKYPXNkjrx0jgmrBk+IW1SHy5UGeuguUBWLMzsC
	kQDajyCNT64XsMn//Kpf8YNoVKdnXJtxmUMRUDakPViuDYneFYnlRaKAVgd0NkTPL42cCM9Yc2Y
	xF+aV7OBrhkPpILrXvMC3sVUKjy4=
X-Received: by 2002:a17:90b:4c85:b0:387:d5bd:622e with SMTP id
 98e67ed59e1d1-38fa7824b05mr937031a91.17.1785439695076; Thu, 30 Jul 2026
 12:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
In-Reply-To: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
From: Jamie Stephens <jamie.stephens@gmail.com>
Date: Thu, 30 Jul 2026 15:28:02 -0400
X-Gm-Features: AUfX_mz_8J7N5cSdJsnEi7DuUMOyhEc8gY0WtMhugK0SpmdWDoQhR3Drz3IuJAo
Message-ID: <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
To: jikos@kernel.org, bentiss@kernel.org
Cc: regressions@lists.linux.dev, gregkh@linuxfoundation.org, 
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Per the recommendation on Proxmox Bugzilla #7850, I=E2=80=99m reporting wha=
t
appears to be a Linux USB/HID regression affecting a CyberPower
LE1000DG UPS.

Hardware

UPS

CyberPower LE1000DG
USB VID:PID 0764:0501

Affected x86 platform

Intel Tiger Lake-H USB 3.2 Gen 2 xHCI Host Controller
PCI ID: 8086:43ed

Problem

When connected to the x86 system, the UPS enumerates successfully and
is bound by the kernel to hid-generic.

Kernel messages include:

usb 1-3: New USB device found, idVendor=3D0764, idProduct=3D0501

usb 1-3: Product: LE1000DG

hid-generic 0003:0764:0501.0001: hiddev0,hidraw0:

USB HID v1.11 Device [CPS LE1000DG]

However,

sudo lsusb -v -d 0764:0501

reports:

wDescriptorLength     504

Warning: can't get report descriptor, LIBUSB_ERROR_PIPE

cannot read device status, Resource temporarily unavailable (11)

As a result, usbhid-ups is unable to reliably communicate with the
device and NUT cannot reliably monitor UPS status.

Kernels Tested

The issue reproduces on:

Proxmox VE kernel 7.0.14-5-pve
Proxmox VE kernel 7.0.14-6-pve
Ubuntu mainline 7.1.5-070105-generic

Reproducing the issue on an Ubuntu mainline kernel indicates the
behavior is not specific to Proxmox and appears to exist in upstream
Linux as well.

Comparison

The identical UPS, USB cable, and NUT configuration were moved to a
Raspberry Pi 5 running:

Debian 13 (trixie)
Linux 6.18.34+rpt-rpi-2712
NUT 2.8.1

On the Raspberry Pi:

the device binds successfully to hid-generic
usbhid-ups initializes successfully
NUT communicates reliably
upsc ups@localhost consistently returns complete UPS status, including
charge, runtime, voltage, load, and other telemetry

This behavior has remained reliable through repeated testing and reboots.

For completeness, lsusb -v on the Raspberry Pi also reports the HID
report descriptor as unavailable. Despite this, usbhid-ups
communicates with the UPS reliably. The communication failure only
occurs on the affected x86 platform.

Troubleshooting Performed

Tested multiple USB ports
Tested USB 2.0 and USB 3.x ports
Replaced the USB cable
Tested NUT 2.8.1, 2.8.5, and current development master
Tested as both root and the nut service user
Verified udev permissions
Verified USB VID:PID 0764:0501
Reproduced the issue on Ubuntu mainline 7.1.5

A Proxmox developer suggested this may require a USB HID device quirk
and requested that the issue be reported upstream.

Reference:

Proxmox Bugzilla #7850: https://bugzilla.proxmox.com/show_bug.cgi?id=3D7850

Please let me know if additional information would be helpful. I can
provide complete dmesg, lsusb, and usbhid-upsdebug logs or perform
additional testing if needed.

Thank you,
Jamie Stephens
