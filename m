Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794639422;
	b=Uuvyl6rlOo8pAifa78Mu0OXAM1Z63z6Y7SWSuXVt9bZeohS9QGNclcPycAUth7cZynlY
	 hx5Vqa3XMp0UyQiKTD3Ws6seGYPPHCiODUOMz6V8tNh3baXdmR7Kg3vHMgaZ9ueNITGa4
	 0bWhzX7pkmdhAWYBmq64TxA6fiwOVlEn5CwgtIOLHXZYK+OT6nKE0lDLuu3omJRFPpvcH
	 KVGH9AGa6Ljr9awViuOkEKfLi+2ymmUPfG0cp9VDWh/x+pwNZsQHFGfQRiO0wTWs+PMNa
	 I2oHYnWm8VYuKWITSATad5NrFW7mrvTgUTSrIX5lGjSE5FAyF6Gvv0mcIzhmmiG08wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794639422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=svEXNKANMptFL+nn+FJmTq7DF0aaAVsVt5sHrxZKFpg=;
	b=En5TVYYP3ZN6r/IWUK8XVxqv9COzRqlceCDKbnJxZEkQVZnDJQ72GfCCud0dD4728twc
	 C51vfDAhCu3JeetJ/pkwkJnbl5oRgsCdikTrXLi0wP+0aXSub60wNHyLz+9wPHoFfKSr4
	 wX0g2+47yia9Ubo2OZIz3InlcIioOA0CVeLO/6pguhtYazmuOVDPpZiNaG4gjgL5kNlsO
	 VhmYnEVGlAcR5hVvNhnBG6Vl0RBaOdt3WfQ5oSj7B+5FY8ZilwBbJ42Th6TpVMHaPfyUc
	 nbvPNqfMHEQw6f46oh2iRHyLjTq0kzy2H/QOqQWlAiJMonl/rRVQdYpOfDNpjyb8aww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvB2odK+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F69606A323
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F69606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvB2odK+
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-94961b68685so57365485a.3
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794639421; cv=none;
        d=google.com; s=arc-20260327;
        b=W8HpkznJXuVtbCuvZsuUys1tgmoEoyhdOpDyetgv6uFC9uzoIMaWxubFEd1hG7xron
         X4NwCUKikIsRIi3fZ95ZtSnM3gbUH3oG/f+2N6pWKcuBmmIb8zozgXvLFOVEDt2Tf/C0
         qR3ky2pTL1N+2A51wbEwIUMQuI5LiWxCXd0rzTKVRHahlb4bk7XYAo5orWU9Amn/cd7a
         lkFLQYGmYjc+Hl5g5yAu+KIy0lUUfRiwpz5PKYT/CXS7lnrbdOG0ZB8b/akKA8HFqjtC
         5qFbe4vHvJUT+95ouKBo94c+LgwMczJF5sehj9YWVfQCDZIu48x/kOmZ5nuOPIju2DG8
         xbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=svEXNKANMptFL+nn+FJmTq7DF0aaAVsVt5sHrxZKFpg=;
        fh=ktILtpnh8AXB+huSjgLqwIZrOXtEysOZDtRPFQjY1eI=;
        b=Eb/xzLWaBnZrVU0zZJ/AskXytKL8yg4pF1bIUOCuYC8EQdZ1UiizmIa05kXrgb+8DJ
         iSqIyz8XKwpWx0Is0kYg1JRV7fGgBsaDshKkdXm+WBFlHjPRc2QwlSflAPu3SsjITw1C
         sPOTfAh4pm+zosl4nSKXcZsD/5QMqLCMKi5yrmi/k3za461QQBX3xYBY/h1uo8rEShld
         csIjKXnvKndLWVtcFZ9v7PJLkbEHkzfeuRVUaR62Toz3I0SHrhqaXreqGqgDRChM9wYu
         x20w1w24dvgIRWOcYfaCG4wF+zgS9sdIcO4YNBs+Gkqa0nc7PSU2ilxAh94YhcwASLgB
         1KFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794639421; x=1795244221; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=svEXNKANMptFL+nn+FJmTq7DF0aaAVsVt5sHrxZKFpg=;
        b=XvB2odK+rlvsOicIPD7Eh2suXbYQXcWAaM3/WFbcpMt5n2fmV6bXojpxu+nAw7/2OW
         mxP3KWYG+Ynd8mOfyL+65f9xlwH8TgKYS9nVc6xotrfLN3TqpPia8+9tAu7UxhkfDXEx
         gN8O0a11z3FX/8QlVihS7x+W0dv6VWSsEAmflynsI8FRwWl2Y4p8sr99kf0kPpmXUDAF
         wmyjCOWcmPgUjZ5arKn5aWc5JFDTxfrIUGCBKGXYJ46Z/O2oN70nHOzCCxsAmIxiq+op
         kAvAVsmclJ+SYg+ZKutBw13DVutYJyGmhYTkCgzgdl7h9nY9ggwZ1Rw7918BAcREiU3k
         7CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794639421; x=1795244221;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=svEXNKANMptFL+nn+FJmTq7DF0aaAVsVt5sHrxZKFpg=;
        b=sWtD3RESM0hlhu41AJ6Kmn2sCDdICgdqI54wyWfelCG+gr8M+SbRq9FwqFuGIos2Vr
         A/+B8kcllftcg9PcTR+dETw1g8agtN555No2DvdmjyJq1qU0fGGPZdxhGdpNQCz+482s
         USKnB41jeWV3x5KTGBc9VmAg/CwjWuC74dLqgiZo8ix6icAWr2sgM7oDjfRZraGSlovC
         apc9Dyz8geI+cVECyzOurGF9D0HTmHbfbq+XRN816JjziMBgmUBqyjYZRBtRXgzsTM1+
         Ly+LeAYDximijRI6lgV1W8YCqZYYpAoH21V4lNTDd8iwBdaKKK9qKrccssoUJkUj97KJ
         JKIg==
X-Gm-Message-State: APuU4Z+6ij2uillqMe/gXNtSArYvUoMnxJj2sZuA0A3nOciIXKjkAvb4
	9TKD/XDBAx3jZ0ZLb3cvUnqym/Eq6vzAUlQK9W4EpHtGL1aLRoVz9r80lxsyJ+3DHQSIewzMWNp
	I7tfZ+uYqO1q5pr+nACw0z8lArNGeX308F/Y5
X-Gm-Gg: AYBFou3T3ZgoXW1vScMZeNd2WY7Xh51JVKISalieSjHAMMOffK/DoCYf4u2nBAN5Pct
	pTqKb+vtsoBZZ9iIOkrOXT+KFy2iNeWpgJbK7dA2gminkQeg4LDkB8aCNRm6NWMBBrqOVkdwicl
	xL6pTWyy4mSwn6S0v2heXu29OYuWmM+fWuDlvKEr5Dt4ZMVGsjTntiJN4qZQhI49AiifTubLB6x
	V0Gu7krk1OdNLTUXX1NT6EYmZwF6iJuuvat8rvsqtsC6Z44zOkOQX1W9Q2WRylPULBY7Yzlf8t6
	AIaA5ROR3wrfmGNpT98tIGkVmOQavQGSIQIyAuVncBqo4mfGtj+QBCDMcta2ucj5TzNOzCZc2gY
	lsMgOQovD7qlmhck2SUKzvm4+uaVP+9MVGg5gnB8r/mQ8UjkH3d5l7GSCgVWietOqJ4KNCNA=
X-Received: by 2002:a05:620a:8908:b0:93f:47fa:b722 with SMTP id
 af79cd13be357-9494bb858b5mr741838185a.13.1794639421226; Fri, 13 Nov 2026
 22:57:01 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ali Lin <alexlin901107@gmail.com>
Date: Sat, 14 Nov 2026 14:56:50 +0800
X-Gm-Features: AclHuK_n550RFKQmfilUV4kBLWS5ExtF1OorDlMXfULnnkZLu6xhclh-jCwQLTA
Message-ID: <CAMX8SmaXHh-dzH2n6pRhQr8q=iN=Ui7T3TC42e35LBUjvMaH1Q@mail.gmail.com>
Subject: [REGRESSION] HID: Corsair K70 RAPIDFIRE interface 1 times out on
 Linux 7.3.4
To: linux-input@vger.kernel.org
Cc: regressions@lists.linux.dev, jikos@kernel.org, bentiss@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I would like to report a possible Linux HID regression affecting the
Corsair Gaming K70 RAPIDFIRE keyboard (USB ID 1b1c:1b3a).

On Linux 7.3.4-arch1-1, the keyboard works for normal typing, but the
Num Lock, Caps Lock, and Scroll Lock indicator LEDs do not function
correctly after boot.

Unplugging and reconnecting the keyboard restores normal operation.

The problem was not observed when booting Linux 6.18.63-2-lts on the
same machine.

System information:

- Distribution: Arch Linux
- Architecture: x86_64
- CPU: Intel Core i5-8500
- Motherboard: ASUS PRIME H310M-K
- BIOS: 3204 (2023-12-14)
- Keyboard: Corsair Gaming K70 RAPIDFIRE
- USB ID: 1b1c:1b3a
- Device revision: 3.08
- USB speed: Full Speed (12 Mbps)
- USB host controller: xhci_hcd

Test results:

Linux 7.3.4-arch1-1:

- HID initialization timeout reproduced on two separate boots.
- Normal keyboard input continues to work.
- Lock indicator LEDs do not function correctly until the keyboard is
reconnected.
- USB interface 1 fails to bind to usbhid.

Linux 6.18.63-2-lts:

- One successful boot observed.
- Keyboard input and Lock indicator LEDs work normally.
- Both keyboard HID interfaces initialize successfully.
- No corresponding HID initialization timeout was observed.

Relevant kernel messages on Linux 7.3.4:

[   36.929377] usbhid 1-4:1.1: can't add hid device: -110
[   36.930405] usbhid 1-4:1.1: probe with driver usbhid failed with error -110

The USB topology on the affected kernel shows:

Port 004, If 0: Driver=usbhid
Port 004, If 1: Driver=[none]

Additionally, the USB descriptor collection for interface 1 reports:

bInterfaceNumber 1
wDescriptorLength 29
Warning: can't get report descriptor, LIBUSB_ERROR_TIMEOUT

Additional observations:

On Linux 7.3.4, the HID timeout occurs approximately 36.9 seconds
after kernel startup. Subsequent USB devices are enumerated shortly
afterward.

On Linux 6.18.63 LTS, the keyboard HID interfaces initialize at
approximately 1.3 seconds.

During one boot with Linux 7.3.4, systemd-udevd also displayed a
stop-job delay in the initramfs shutdown phase. The system eventually
booted successfully.

I have not determined whether the delayed USB enumeration and udev
stop-job observation share the same underlying cause.

Steps to reproduce:

1. Connect the Corsair K70 RAPIDFIRE directly to a motherboard USB port.
2. Boot Arch Linux using kernel 7.3.4-arch1-1.
3. Observe that normal keyboard input works, but the Lock indicator
LEDs do not function correctly.
4. Check the kernel log for the usbhid interface 1 timeout.
5. Unplug and reconnect the keyboard.
6. Observe that the Lock LEDs function normally after reconnection.

Diagnostic logs:

https://gist.github.com/Alexlin7/65e0705265c7c369d83f9d4a7515faed

The Gist includes:

- Linux 7.3.4 kernel boot log
- Linux 6.18.63 LTS kernel boot log
- USB topology
- Corsair K70 USB descriptors

The exact kernel version or commit introducing the issue has not yet
been identified.

The affected computer is located at my family home, and I do not have
regular physical access to it. I can perform additional tests when I
next have access to the machine, although hardware testing responses
may be delayed.

Thanks.
Weibo Lin

#regzbot introduced: v6.18..v7.3.4
