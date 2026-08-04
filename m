Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1833A425B;
	Tue,  4 Aug 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838396; cv=none; b=e/IBZ71sGVR41lWpBqYQKn9DFZ1rKzDPhbYleV33VuZLZwE3aIfLYbufFObE5CM6kL86FJJ+lqmmrGtWTDH/vCfT+GQf8+FoAC5VnSXBbDJoAKdr2bPrR9ckmYPx/bsQabznofmSKx9euAOra3N1JTiFNE+mz8U/Q5rWTg6Kg/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838396; c=relaxed/simple;
	bh=T3aRuf7UWEnBc+l1ZA6aIZIqNdbg5gRbKHEL8flCt8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ce0HDChmhyMPCb2bteYFBByaTEvQgHtcpnpe6VXqNE1t6dXQ4kbr7QLTL8qBt622ut9PR5ZqpAqtBRauT+gJQiIfcxC68ZjBKFotoPPWHKcZhmH4mF8HpxNifQIEtXxCUbhaaUBbZNuvG1ZmQdSbqbtFggdxos992Xg1AOpxi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZGWA27Rz; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZGWA27Rz"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hDq2814sSz44X2;
	Tue,  4 Aug 2026 12:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1785837984;
	bh=T3aRuf7UWEnBc+l1ZA6aIZIqNdbg5gRbKHEL8flCt8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZGWA27Rz8GZHWlvgcUbWS9aAHnbFTjvmmYNYF56Nm+YjfvMKlLD12bC+zQUs61hD1
	 MES9FbM9IqiKxQpFqn5ctCcL9r39Clr291cCsHki2fNBJjE/C3D7S+3/yE4nkL+gt/
	 s4vyVs0EL9KehXkkrlEtgJcUbeIvhBJTv07L3TYf64GRdc72V9U6soQDPEGw5KFv0Y
	 ++qeEK0M2nRa8v2SpHCByDsBQWz+T7/Xg7kc99X7LIAwyzqNaqhs9+zwi48qfH07+3
	 h85re20UM2F6YrR/V4xyXmyZV/C078HNIBa0el1y6oT42lyuDpU7bcOapB3Scf0edm
	 mrckfDKzhs9+Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hDq280MN6z44Qg;
	Tue,  4 Aug 2026 12:06:24 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hDq265nlPz8svZ;
	Tue,  4 Aug 2026 12:06:22 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 1990E5FBA6;
	Tue,  4 Aug 2026 12:06:22 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <325f80d7-e305-471f-886a-30a58f834efb@leemhuis.info>
Date: Tue, 4 Aug 2026 12:06:21 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
To: Jamie Stephens <jamie.stephens@gmail.com>, jikos@kernel.org,
 bentiss@kernel.org
Cc: regressions@lists.linux.dev, gregkh@linuxfoundation.org,
 stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
 linux-input@vger.kernel.org
References: 
 <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178583798250.442885.331590974917260654@mxe9fb.netcup.net>
X-NC-CID: P7pXfUOUcC/5blZoPE5R/V76NhRQJUppgFr5SI99vmUuWEOw/oA=

On 7/30/26 21:28, Jamie Stephens wrote:
> 
> Per the recommendation on Proxmox Bugzilla #7850, I’m reporting what
> appears to be a Linux USB/HID regression affecting a CyberPower
> LE1000DG UPS.

Thx for the report. No developer replied yet with an idea what's wrong.
Unless this changes I guess you need to run a git bisection to get
somebodies attention, as the root of the problem might be in one of
various kernel subsystems. The process is described in
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
or
https://docs.kernel.org/admin-guide/bug-bisect.html; if you follow the
latter you might want to first check if mainline (7.2-rc6) is still
affected.

Ciao, Thorsten

> Hardware
> 
> UPS
> 
> CyberPower LE1000DG
> USB VID:PID 0764:0501
> 
> Affected x86 platform
> 
> Intel Tiger Lake-H USB 3.2 Gen 2 xHCI Host Controller
> PCI ID: 8086:43ed
> 
> Problem
> 
> When connected to the x86 system, the UPS enumerates successfully and
> is bound by the kernel to hid-generic.
> 
> Kernel messages include:
> 
> usb 1-3: New USB device found, idVendor=0764, idProduct=0501
> 
> usb 1-3: Product: LE1000DG
> 
> hid-generic 0003:0764:0501.0001: hiddev0,hidraw0:
> 
> USB HID v1.11 Device [CPS LE1000DG]
> 
> However,
> 
> sudo lsusb -v -d 0764:0501
> 
> reports:
> 
> wDescriptorLength     504
> 
> Warning: can't get report descriptor, LIBUSB_ERROR_PIPE
> 
> cannot read device status, Resource temporarily unavailable (11)
> 
> As a result, usbhid-ups is unable to reliably communicate with the
> device and NUT cannot reliably monitor UPS status.
> 
> Kernels Tested
> 
> The issue reproduces on:
> 
> Proxmox VE kernel 7.0.14-5-pve
> Proxmox VE kernel 7.0.14-6-pve
> Ubuntu mainline 7.1.5-070105-generic
> 
> Reproducing the issue on an Ubuntu mainline kernel indicates the
> behavior is not specific to Proxmox and appears to exist in upstream
> Linux as well.
> 
> Comparison
> 
> The identical UPS, USB cable, and NUT configuration were moved to a
> Raspberry Pi 5 running:
> 
> Debian 13 (trixie)
> Linux 6.18.34+rpt-rpi-2712
> NUT 2.8.1
> 
> On the Raspberry Pi:
> 
> the device binds successfully to hid-generic
> usbhid-ups initializes successfully
> NUT communicates reliably
> upsc ups@localhost consistently returns complete UPS status, including
> charge, runtime, voltage, load, and other telemetry
> 
> This behavior has remained reliable through repeated testing and reboots.
> 
> For completeness, lsusb -v on the Raspberry Pi also reports the HID
> report descriptor as unavailable. Despite this, usbhid-ups
> communicates with the UPS reliably. The communication failure only
> occurs on the affected x86 platform.
> 
> Troubleshooting Performed
> 
> Tested multiple USB ports
> Tested USB 2.0 and USB 3.x ports
> Replaced the USB cable
> Tested NUT 2.8.1, 2.8.5, and current development master
> Tested as both root and the nut service user
> Verified udev permissions
> Verified USB VID:PID 0764:0501
> Reproduced the issue on Ubuntu mainline 7.1.5
> 
> A Proxmox developer suggested this may require a USB HID device quirk
> and requested that the issue be reported upstream.
> 
> Reference:
> 
> Proxmox Bugzilla #7850: https://bugzilla.proxmox.com/show_bug.cgi?id=7850
> 
> Please let me know if additional information would be helpful. I can
> provide complete dmesg, lsusb, and usbhid-upsdebug logs or perform
> additional testing if needed.
> 
> Thank you,
> Jamie Stephens
> 

