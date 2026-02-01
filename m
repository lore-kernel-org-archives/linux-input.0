Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF74284B54
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968639; cv=pass; b=gfu5tS7rFK/KFmQDWN4dKLkIumlF9kW2GMW7rjyx96tkU0fSKo+wX3qVWAqoy8N8m014PruRUv5GcBHnnXOLmhf/pdo7a/5m9Oq15pyMQwQFPxA/y5f+izsLKQzJqDZRepQruddxhrE5veYKpDcJLeMhDXBj6kzMa7rLzZ7MJO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968639; c=relaxed/simple;
	bh=fa25L8AlmjGKyNwk5g2KbIzpLlnikpLyXTb7yO9Rhf0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SH1XL2l5fhLekwi1bhUUGNFmmQimgyjXIO0IFunRP4+KGaTOcvVEFWk9ZyAjmar9W6jtKrGYLjyzU8xPpwJXceTF9CMQmzjVxPGTxC/9D2NV9pCeFqa8aY8gNT5GZGoYVQHF/SX3hNnYQrPOtdmhwAJ/f9vO4j02ww/AEGVdjfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGLDbGmY; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGLDbGmY"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124b117776fso2333886c88.0
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2026 09:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769968637; cv=none;
        d=google.com; s=arc-20240605;
        b=GaJdKyZ4Y7hOhXy7qONMpq22w191lXUjrKfSaSZJfgfdChtA0JqAV3OvRh3pPiRHHg
         ZcK47qZH64hzeGKOqunrSF9v+JHi/w/j20sPWDEAU+wUNM1n/ly9Scs0RROB41nrisMn
         +2Gs8ZSWbZmvYQXOL2IA6g+Dx8hKkylFKWJ/6M5mUUYIv1b6dF4HjDCAi/dgoSI9ZNyw
         tjF33zG9allkRu2WWg1j9detXQE+043qG2CqQv2ifb+OCHqk5jQ/F0/MbE7SHKyyc2Gu
         NS8lmZW4YvOhOcfq+TBnKhIons6XxUlZ0wU1U7c9n5ad7RK7HPQjy/6qlfXv7toVEHE6
         d9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=I0lQ6Sra28jclA5GRK++dfxuP4PJKDcI77hQng+Sses=;
        fh=k4g+BH+55tr7ehc64W7H7B78o7fKpRIhkccTOZIFE0A=;
        b=k8sB3gp8LOo6bhc3Y4S0AbKQgXTCd/o9mh4nVzM5B75ywSQWZhsibt7cNA1lakgxD8
         a1cIFjQhBMy6t9Nb6fPuZK1KEnWr3ZAjHFtVMVEtuMglkUjqK7b1FxKmUoHv9E5jLVZd
         UOdk1HLIi5VWD73JeMihGxa6Chtr1ItVqRVnUz9e6cy/XbovOtmNYY4wvBxwiuKJyw06
         U2YW6+HsHlQjCgA3RJSY/NuYTlcw/rjo1aWTtj6rWtgvSZi5jpM8hR6zx+Lt8fbwZrzI
         0gUHNrh7rYcwOUSLo2MDSUTaBYxTtGpgC2FnE5lkVfEXBZ2/+bNHnqvbqubJsbfaFJfs
         whSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968637; x=1770573437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I0lQ6Sra28jclA5GRK++dfxuP4PJKDcI77hQng+Sses=;
        b=CGLDbGmYwsrv1f/uGkxMj1Ttskau0kZIZzkfBfyDbiWBbGBlwMjenkmra0onhZ0ol9
         LGZ7vdJ9DI3FBx3ZQTUFvo3CR3ekAXyvLJ4t0WMcEhfBl8CaTkBab83g9cdeL0jihcc2
         s7g0H6vVYs7AzSBCkU+YE8T98PYfEwc5/mhUdPHUC1KIbGZZCmgOvX52ekhorvYoZpzp
         Wy6zz5cdJbyjcSg6TZyhwr4t/GJjEAJGh8X6Xk06B6mN7xTqSQhaMlPjgCqU+3BUCfRv
         AQz5YHqta3g6T9UeEiA31SxwttslaJ8YyVh4DT8YrquaVMqyGpSr17uMZYmRrREeWT4S
         Pz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968637; x=1770573437;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0lQ6Sra28jclA5GRK++dfxuP4PJKDcI77hQng+Sses=;
        b=TPlrHfgAiO5QjhbwAX1NWv/hLr7GPRjcPt2Mn0B05gGBR2omwvJ3gWV0MHAdAySWBU
         MuybTL1Ue8oly7JQZoRkXAglmxR0CyaF0K6jpPu4DDJ+ur36vJxc20Nz5Ev9Ow8TD1l3
         +roszbi94iGsIW/bi6dKPr78WYhDNl8QPoimnqkPsb7TUvP/W4cqynx1wVwiyubxHQxx
         6h1xDilq6FX7S41WUFt9qqogUnMmtv3M4/F0YhYRhNGXUIb6LKvbZbxgclzQtfrnHMPi
         cRlwJB9msSfscS5s0/y/vr2AANC4fbQEXzAjMmkFLaZFEMt4mRVSfBdgL4QlhGAChTck
         dDIw==
X-Forwarded-Encrypted: i=1; AJvYcCWB/iRtq69UqaHMutACoL8Iy5LEmoeLc/Ie2kvmwk5+dKgfyfphlYWDMF1UGW4w4I9RXGjG/ZlqngbTzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4eTsfvABFF5f2jX+FwfQ+ZngzYd7fW3aZVYQQfXFhot1QGte
	XuPPAHF5I5dEGAf2G9DljIxuvcgN80vca4Eryow389vgfmJ0bIV9awx25eV6ap7PcIyvlq+camX
	Ythu6VshMa1JB1Gf4z7VMrwzOdsrcx5BLad73
X-Gm-Gg: AZuq6aKIBF/Igs9rrQU8digZQELDYL/9IDxiXXWv7UnTqKbpTFtLRhvc+WlJWeZW0d8
	tlQa4AmtfHgL1a9OdtD86iPD5TT0RvrH0c9xVOfdcgmBdd2cYqUgbddYjw5YChFlu6OoV2tNugs
	vkHLVwZb2RituNGWhBcjO0Ba4JpL2lhy867zQ8DJLRF6WSgly964MUGhB7P3NgasbJUT7B96VXu
	LBVog6s6GeGe2RBdKUBYckNq+S5/Yl0eBm2TTWUdxOknjHNt302lKk+iyIkkSf0E/h99AHb3W2r
	Fff3EXKRqIs1H8od4Kr3atrS/LrA
X-Received: by 2002:a05:7022:660b:b0:119:e56b:9899 with SMTP id
 a92af1059eb24-125c0f0fa92mr4125675c88.0.1769968637147; Sun, 01 Feb 2026
 09:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Sun, 1 Feb 2026 18:57:06 +0100
X-Gm-Features: AZwV_Qi_TlsT3yJLwTp9P97_Mloszcjkr-mJoGdoaDLKcd8u1m7BdRJvGEjI-JI
Message-ID: <CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com>
Subject: usbhid: Intermittent EPROTO errors trigger USB reset and interrupt
 user input
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm trying to understand and fix intermittent keyboard/trackpad issues
on my 2013 MacBook Pro running Linux v6.18.4:
- missed/repeated/sticky keys while typing (this thread)
- trackpad stops working (see "bcm5974 trackpad broken after USB
reset" in linux-input)

The keyboard (usbhid) and trackpad (bcm5974) are interfaces of a
single full-speed device behind a high-speed hub:

/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-pci/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 001: Dev 002, If 0, Class=Hub, Driver=hub/8p, 480M
        ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
        |__ Port 008: Dev 003, If 0, Class=Hub, Driver=hub/2p, 480M
            ID 0424:2512 Microchip Technology, Inc. (formerly SMSC) USB 2.0 Hub
            |__ Port 002: Dev 005, If 0, Class=Human Interface Device,
Driver=usbhid, 12M
                ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad
            |__ Port 002: Dev 005, If 1, Class=Human Interface Device,
Driver=usbhid, 12M
                ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad
            |__ Port 002: Dev 005, If 2, Class=Human Interface Device,
Driver=bcm5974, 12M
                ID 05ac:0259 Apple, Inc. Internal Keyboard/Trackpad

Logs preceding one of these events:

[19607.563871] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
[19611.523681] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
[19614.550685] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
[19614.563878] usbhid: usbhid 3-1.8.2:1.0: retrying intr urb
[19615.050802] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
[19615.067673] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
[19616.822636] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
[19616.835934] usbhid: usbhid 3-1.8.2:1.0: retrying intr urb
[19618.126656] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb status: -71
[19618.126711] usbhid: usbhid 3-1.8.2:1.0: resetting device
[19618.126728] usbcore: bcm5974 3-1.8.2:1.2: forced unbind
[19618.129942] bcm5974: bcm5974 3-1.8.2:1.2: trackpad urb shutting down: -2
[19618.155292] usbcore: usb 3-1.8-port2: not reset yet, waiting 10ms
[19618.217146] usb 3-1.8.2: reset full-speed USB device number 5 using ehci-pci

Both interfaces receive frequent EPROTO errors. I collected statistics
on the error interval over a 30 min idle period:
Interface, Count, Mean (s), Std Dev (s), Median (s), Min (s), Max (s)
Trackpad (bcm5974), 631, 3.21, 4.75, 1.74, 0.01, 35.62
Keyboard (usbhid), 71, 26.82, 24.90, 19.34, 0.92, 107.74

From debugging I understand these to be missed micro-frame (MMF)
timing errors in the host controller. They require URB reset but not a
reset of the whole device.

The bcm5974 driver simply re-submits the interrupt URB. This is the
best behavior for these errors on my machine.

The more "correct" usbhid driver will delay URB re-submission and even
reset the device if a second error is received within a 1.5 second
timeout. It's these periods between EPROTO error and re-submission of
URB where keyboard events are missed (missed keyup == key stays down
and repeats). The default error retry delay of 13ms is relatively
small but a full device reset takes about 200ms. With the frequency of
errors I'm seeing, every ms counts.

Can we improve the usbhid error handling for these cases?
1. Reduce first retry delay from 13ms to 1ms?
2. Reduce the stop retry (reset) timeout from 1.5s to 500ms? 100ms?
3. Require 3 or more errors in the timeout before resetting?
4. Ignore EPROTO errors for known hardware/quirks?

Are there ways to differentiate these safe-to-retry MMF/EPROTO errors
from others that may really need a full device reset?

Appreciate your thoughts.
Thanks,
Liam
