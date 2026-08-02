Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFA393DC7
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785661241; cv=none; b=EYSZevSxVVYjo76q1U5cdMTEgHXLfKVYGX4GY3sTQ/XYFhrGkLfQW81Pyjos9WWK2CEdPENlPsoZwLJv3dcVnJ+8h0Gzf2EOjWDbcLAOyCJCqoDTopOGhkJq0uwWs+yhXww97R7+B1SN1yJVSXrzJ6QrVXE65UpELULk3ZX3cG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785661241; c=relaxed/simple;
	bh=zVG5OlkF06r4tnFrHekV1DM4DTSKT06LgbL/3A8h9c4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YbuzOPY+C90VM7RZZS4qpfmOtqSI+XhQh8Y3qbTJ3GakSdSKtLyaZl5clXRpsBe/pKo6szIPcnhmiNAWeuqgdPpDxM04wXb6OKv6DibwJbrK27JYNcq0MGdxkeSDk3M3NZNFgooRiMUiDdBmLpd7ABemoqhQ4kpDDQLWj15wAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et6MCmUR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et6MCmUR"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so2067377a12.3
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785661238; x=1786266038; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czdmTchxrTbFlogZspc8ZgTLyFsgN5rd/bZg0oMSNo0=;
        b=Et6MCmURV/wWDcThWytOHLGhN9+r+dW89EcmviLz+FfYVmCXngEbCAaXYlcowN8Sii
         QUVeRTM9tirP4QdWs8urOFJhEQfa9sy+N/UmhHQehgJT9Wl/L4DigDJhYY0OlIhK7B2v
         Tya0Vbsx5gd3UXJAef7eRod/pMXvSlYlkWWEJD6rOaVk9SObZV0LzyKXygaDKayuhnqo
         60IAf4zRRMhzkqknDY7ruLXltlnTntHamZ2r2k0PVK1l4uxp98NgDWb52KMaalv06VuE
         RxnJlsJwKRsiMwNXAcIS9rD6kQYTgaFYLsqVUSAgLlhRFTXjXAe7I0rNwcFQqdkNjoqO
         Tx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785661238; x=1786266038;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=czdmTchxrTbFlogZspc8ZgTLyFsgN5rd/bZg0oMSNo0=;
        b=Hrk0dl3q1JgMgdABE1ZdnquylqOIQcqsasDcDGZn9wMxBkOeOI9EK/IzVWekB3ipxC
         k7gQOzJ1ohGutnGfiQko34baLK9t2zUkVEU5nHuKVATD7sSqIsUwKvu9XK4x2SYJ0gD9
         UQqfEd9kWb3wpKXW22M3pPQUpi5ZgaLABSpMyvLYWz81Icvu0VtLbeZNGzxESjUuIzXG
         fsO7EIEsogIZ7r2SgP/cwdjH3VebnF6frrB0IEsmzwSZo2femQSZDwD/wUgJBx/9ljm/
         O3/LESw+rQA6EIjiu93vEcJvdq3Uh+zM5rqcR/KqcAaRZ+KxgQc8zugjezWb1rmmQHmh
         AiyA==
X-Gm-Message-State: AOJu0YwDtjh/XKe/SQ1jjvbH96bIfoCN8lQv2VBmJ3pq86PX9zErK5X5
	ZZMjDpys0dqcHROszkFTudve7zqkAnFm/5/E6PZ9oZGhhBMOKryn/utClJ/VnHZhE5zWpw==
X-Gm-Gg: AR+sD11yxw3jYFjGjbxVni4Wl4M51xutVR4Y6qnB1q3jW4hhZ4gOLivhm0lMq4D1Sn8
	0To0ZxjmFuvlXN1xx//mkqKhSRAgP5kEn1iOik+9ZzYEcNevhKCCbAvqUtyXTnicVIf9N0fMSsY
	M9Aq0K/0/jgDCWxmyUeGZwMbV9S5vAqhMPNNSpgc65fMorWu2Kpw+1yZxpwcczlN/rHv/8PADRD
	OZWSChNWkKpB7SWRcoRbTdxAjrZt5Wl8FI8ygQJbWbhDx976Niz6VnB3Jv7dNihp06TQH33vr9Y
	/nlZQnSmwJsT3ug+UrzUWJQQ8BuVAV4KY9+ljeaAopO7qkeO0oYxqXsNdYAei4zJEW9ejRVzw91
	wZ2kuoCcouipPwIKdq3sUjSk1uKLfjYY0jnixYoJpRTuhHm2e7zOg/68VzvCK6hUtxFmLewZb9Y
	ym6dtu5bBnB5Utzs6bgtD+gExOEkyPou5wiLlcI3rukFMjz0fZASquzv3/TKqOoww=
X-Received: by 2002:a05:6a21:7a82:b0:3c3:9557:3b56 with SMTP id adf61e73a8af0-3c92a992c4bmr6176536637.72.1785661237982;
        Sun, 02 Aug 2026 02:00:37 -0700 (PDT)
Received: from localhost ([154.192.129.76])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb51asm31628997c88.9.2026.08.02.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:00:37 -0700 (PDT)
Date: Sun, 2 Aug 2026 14:00:30 +0500
From: Shehriyar Qureshi <thatdevsherry@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org
Subject: hid: dragonrise: map gamepad buttons to BTN_GAMEPAD?
Message-ID: <am8GOnuoT_7Q3jr1@thatdevsherry.pk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have a Ucom ps2-style usb game controller.

I noticed that the controller exposes BTN_JOYSTICK events rather than
BTN_GAMEPAD. I first noticed this when using raylib/glfw, which treats
BTN_GAMEPAD events as standard gamepad buttons.

One possible solution would be in userspace. However, I was wondering
whether `dragonrise` should remap it to BTN_GAMEPAD codes or if the
existing joystick mapping is intentional.

I understand that mapping based on the HID descriptor to joystick
events is expected behaviour, but I was wondering if this device should
be treated differently because it is physically a gamepad.

Sharing details of hardware below.

Hardware:
=========

Controller: DragonRise Inc. PC TWIN SHOCK Gamepad
USB ID: 0079:0006

Kernel log:
===========

$ dmesg | grep -E "Microntek|dragonrise"
[    2.268782] usb 1-3: Manufacturer: Microntek
[    3.653949] input: Microntek              USB Joystick           as /devices/pci0000:00/0000:00:02.1/0000:02:00.0/0000:03:0c.0/0000:09:00.0/usb1/1-3/1-3:1.0/0003:0079:0006.0001/input/input7
[    3.654013] dragonrise 0003:0079:0006.0001: input,hidraw4: USB HID v1.10 Joystick [Microntek              USB Joystick          ] on usb-0000:09:00.0-3/input0
[    3.654018] dragonrise 0003:0079:0006.0001: Force Feedback for DragonRise Inc. game controllers by Richard Walmsley <richwalm@gmail.com>

USB info:
=========

$ lsusb
Bus 001 Device 003: ID 0079:0006 DragonRise Inc. PC TWIN SHOCK Gamepad

$ lsusb -t
|__ Port 003: Dev 003, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M

HID descriptor:
===============

when bound to the `dragonrise` driver.

$ hid-decode /sys/bus/hid/devices/0003:0079:0006.0001/report_descriptor
# device 0:0
# 0x05, 0x01,                    // Usage Page (Generic Desktop)        0
# 0x09, 0x04,                    // Usage (Joystick)                    2
...

evtest reports:
===============

$ evtest
Input device ID: bus 0x3 vendor 0x79 product 0x6 version 0x110
Input device name: "Microntek              USB Joystick          "
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 288 (BTN_TRIGGER)
    Event code 289 (BTN_THUMB)
    Event code 290 (BTN_THUMB2)
    Event code 291 (BTN_TOP)
    Event code 292 (BTN_TOP2)
    Event code 293 (BTN_PINKIE)
    Event code 294 (BTN_BASE)
    Event code 295 (BTN_BASE2)
    Event code 296 (BTN_BASE3)
    Event code 297 (BTN_BASE4)
    Event code 298 (BTN_BASE5)
    Event code 299 (BTN_BASE6)
    ...

for comparison, this is evtest report for the xbox style controller.

$ evtest
Input device ID: bus 0x3 vendor 0x45e product 0x28e version 0x110
Input device name: "Microsoft X-Box 360 pad"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 304 (BTN_SOUTH)
    Event code 305 (BTN_EAST)
    Event code 307 (BTN_NORTH)
    Event code 308 (BTN_WEST)
    Event code 310 (BTN_TL)
    Event code 311 (BTN_TR)
    Event code 314 (BTN_SELECT)
    Event code 315 (BTN_START)
    Event code 316 (BTN_MODE)
    Event code 317 (BTN_THUMBL)
    Event code 318 (BTN_THUMBR)
    ...
