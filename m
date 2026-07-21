Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7F18C02E
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630569; cv=pass; b=WJjqCmxg0vbEWQUKpwtfU1nvDJucHvZ6pL7pLnRF+6cCxKAJCTE+1vYWYmjT2d3I0FbWhFQSS02rxJn2GcMfFJzREF8apT9pNqxUlkpqOC60ReJ+reDZqrEMjPiovGDF/lMRJdk1ImOI5138ZprD0icnROLgCUqpnEnibTRCTeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630569; c=relaxed/simple;
	bh=s7Sv44dJsqAFpIPuZKy6IKwqnLbr+yfy5ipG5K17i5c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fEnPTtNx0cOC6f8PaziIKyquogPkX3zBEufEpC6Ej4/y1dPQdhPTDKblHPZBmifyYrAsqNZPoPT9oizzi+tKUA+B7z/cbEMCH5m3GYWPWdIv05FVZ5JxFjcuaXRCToVZzEs75l9H+Stkud9CjUc+YmWsT80piEyH5BECYS6SkA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY5CVgFS; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY5CVgFS"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-667971437d6so14720016d50.2
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 03:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784630567; cv=none;
        d=google.com; s=arc-20260327;
        b=HcDAyHFzMTEpxfk9eds0RbCr95eiICsLZdnT+ZJhLe3Uotyg2lxSSczL28MAg4BqNJ
         Q3a3vS0SmfV4DzUrpyWr1WuCWz3mkNV2sqm+G0Orx4C80r631WMfQHStCbnvGfJaj5Wb
         n3ACIUpf0hcUHfqPbtCTAiJzXFZ38ZVKGHsf3y7PVH/RanSG/fMbe9kw1abG9jiL7ZXn
         vGWdned3JiejmbGifUfBlmB5A1R/JcfrCUiYEVVBjzobKEAkEQfckRxDj/7ZPXLRm9ES
         L/RnYZME+TI9h6rvrWHo0ZnARj4wCrcXlbGo0ENx27m5sOshkRfoCEQvKIN4diEb0DH3
         aLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=A1sboYn+PLqx0GjgQRMyl0bLfsK7YBG4P1Cv4h1Q/PY=;
        fh=fA+P+T7lM7dWhk+Q4KBNosiYPr6hUp0jAFg1srfSrvI=;
        b=rksr2WU2FQvtKpDnsg+tqVlVkm46qUqkdKuR5vB3JvrBuqYnqZyZI0rsKopKFNwijH
         UKaSzpdPTxwLzNaJRdDC36ptRGMbSsB6vugCshsIc+Rgpm86fHHTrEEOPZA16G+nTvmw
         jciW1ZdCgfrS1x91PI2DCjwgb9m2PvJDy0D9/kWsyr82zINX5JDrGaNfvdnt0x37Zcq6
         CC20GX3FFtRf5gAr3ddhnPcwqrgCsMH0nQ9osuJcUmxzroMb2kKcgXJI1ap/3jXuL2jm
         lHrEzjmzgZhDIiplxq7v7mddmuwLF+9LFe23r8z8K0Az79H3KjOvOvAVFbQ1dVQDaahm
         tAfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784630567; x=1785235367; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1sboYn+PLqx0GjgQRMyl0bLfsK7YBG4P1Cv4h1Q/PY=;
        b=hY5CVgFS7WrsqMUI0LxvF5jKF+4J7d8Loh7T0vYZ0mP0Yi8mwWnMT7mJr1txGIXsmJ
         qozCazEQqxh8Y2aZzm/fPLTNE1VgBWQNnec3GBkcUZ0g1sEjqGbeO6I3C8ZnUh/i+t+s
         QMeKartf7Ccg5p7Zf+X5gAFET3vzTsEI1W0JokMGjLNsvMMcAcngR+FtIxpzrTaeEQBo
         h7oi8zTd/d8xd3FyV2suUvKdrD//7qSpCwzbDGl4c7yImz5PUp4MjN4Cazd0SNy19m4y
         Pzw4H+mmNG6Tu9TMCt2N/XMKKnZ/NsZ72ZWneBKcoYyl3olNwIIYzgW86aXPWv3PKxP2
         muIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630567; x=1785235367;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A1sboYn+PLqx0GjgQRMyl0bLfsK7YBG4P1Cv4h1Q/PY=;
        b=HdNu8lPvbEf+7MLpwDfFu6bNrqOEZRnqcyAC8sM+yaZwY/xgS/51qREnMqzPx8ygda
         4L+ciuSBXNQt0YocRsGl10xLGuq4OBMKP0Dmy/9JtcGlsh3kPYzBeW8C26aK3uVZDlEw
         h8lpHO3ihey0M8kzLT4x5co38oF3/cIasa57umsXgMwwawuO3V68+I7nl8F/dkLYyJ09
         PwCsqb6conid1sDhye/KBcDM4qVjqD566jxTdx/WyYj5m8JFYL8mgnrSYA7y3h5bAHZf
         8dYoFtGqeKi3G0fte7UEGbKmMH6LF7HkwFwq70kXB09qByS+17efGVhccspfKRGLp57M
         ZmXA==
X-Gm-Message-State: AOJu0YwJN9QXw0u4t1Jm9kA2Fy1qA3Ii6w/b82bq3y13/5c3ZcpVDMi6
	csBFsWgBkMsQtGRFy0qTDc0tqolSmnCbGu/1JzBkDWecBuX9liOGdQvTlHxNlrQ7AXXlaIsOfUU
	WjwtqV7zVEFORB9Ag/RYwxFrwMqzkhlyoau+iYg==
X-Gm-Gg: AR+sD13bQQKj+ktkDzyuQDTQVQ/SKSKrltsSO9QJt7AKjoTCiPIThjK0KGPVaXB8c0m
	6+ird96Ga6rFc98IxnHw9KwTJTMMf0goWtr2ew5feeacSzpj0Ml7kMugFQbN7T4DvQY+ThjTNMO
	DTTP848tzSMkSWmtHvp9JILoNlsBfSXHwc3ml/a7IOPdQKumnjbmErwkBaGabImJfiGZz362Tmt
	R2ljYFXYL9+1xXTXUV7qNVG2gk0HVfSHX+noQ3wzHM/vxwfa74FELExru3+lEymQ2XQ1CwfEYB5
	kW/G/H2RRyGYcqAk7EOSE56T8jMwcOpTgMLhFbbi8ZocbibwMak=
X-Received: by 2002:a53:d9c9:0:b0:667:aa5c:d2d1 with SMTP id
 956f58d0204a3-6683bc57102mr3797769d50.38.1784630566669; Tue, 21 Jul 2026
 03:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Barath Rk <barathrk11@gmail.com>
Date: Tue, 21 Jul 2026 16:12:35 +0530
X-Gm-Features: AUfX_mywUEDGDcSPDZ_AFrMt1jG0xjZJtBG5J6ZJglc9HKSz_SVx8DbnFI0e3KA
Message-ID: <CAOa_tyZ4zxV_LJ7V5w31kqqAwnUxZ_2yT5k-=pWLmtRNYe4Tug@mail.gmail.com>
Subject: Bug: HID/input - Input misses when rapidly pressing consumer control
 keys on Logitech Media Keyboard K200
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, bentiss@kernel.org, jikos@kernel.org
Content-Type: text/plain; charset="UTF-8"

Description:
When consumer control buttons such as volume up/down, pause/play etc
of the Logitech Media Keyboard K200 are rapidly pressed, most of the
inputs don't register properly.

Environment used:
- linux kernel 7.20.rc-4-dirty
- qemu-system-x86_64 version 11.0.50. The arguments used were(This
passes the keyboard through to qemu):
    -kernel "$BZIMAGE"
    -machine "q35"
    -cpu max
    -vga std
    -display gtk
    -device qemu-xhci,id=xhci
    -usb -device usb-host,bus=xhci.0,vendorid=0x046d,productid=0xc31d
    -initrd "$INITRAMFS_CPIO"
    -m 1G
    -smp 4
    -no-reboot
    -virtfs "local,id=lkmpg,path=$PROJECT_ROOT,security_model=none,mount_tag=lkmpg"
    -append "nokaslr"
(this is a slightly modified version of the qemu environment specified
at the start of the Linux Kernel Module Programming Guide)
- Qemu itself runs in a distrobox container running an Ubuntu 26.04 LTS
- My host is Fedora Kinoite 43 with kernel version
6.17.12-300.fc43.x86_64(where I first noticed the issue)
- The keyboard's vendorId : productId -> 046d:c31d

Steps for reproduction:
- Run hexdump -v on the appropriate /dev/input/event entry
- Press the volume up button on the keyboard, slowly
- Given enough time between key presses all presses cause a change in
output with corresponding press/release entries
- Rapidly press the volume up button on the keyboard
- Notice that output either:
   1. Doesn't change at all.
   2. or after some time, it sort of gets flushed and you see a bunch
of entries output all together.

Expected Behaviour:
Each button press/release should correspond to an event.

Some Notes and Logs:
- I concluded that this isn't likely to be a hardware issue as the
expected behaviour was shown on    Windows 11.
- I noticed this issue first in kernel 6.12.12, and later I tested it
in 7.20.rc-4-dirty and discovered      that the issue still persists.
- I hacked on the kernel in an attempt to figure out the problem
myself, adding pr_info statements dumping state in evdev_read,
input_event_dispose and hid_irq_in and saw the following(linked is my
raw dmesg output without my changes, output grepping my pr_info
statements and my .config. I have delimited the 3 sections by using a
bunch of '=' characters):

https://pastebin.com/59FsWsvq

It seems to me that there are a lot of unnecessary SYN_REPORT calls
with a disposition that triggers a flush of the device's inputs such
as:

[  110.907511] input: input_event_dispose for device Logitech USB
Keyboard Consumer Control of type: 0 code: 0 value: 0 dev->num_vals: 1
dev->max_vals: 11
[  110.907543] input: input_event_dispose for device Logitech USB
Keyboard System Control of type: 0 code: 0 value: 0 dev->num_vals: 1
dev->max_vals: 10
[  111.035339] hid_irq_in device: 1133:49949 status: 0
[  111.035412] input: input_event_dispose for device Logitech USB
Keyboard Consumer Control of type: 0 code: 0 value: 0 dev->num_vals: 1
dev->max_vals: 11
[  111.035431] input: input_event_dispose for device Logitech USB
Keyboard System Control of type: 0 code: 0 value: 0 dev->num_vals: 1
dev->max_vals: 10

...but I couldn't get any further than that.
- Also, I noticed that the polling rate for consumer/system control is
set to 255 ms whereas the main keyboard is set to 10 ms(I got this
from the bInterval value while debugging).

Would appreciate guidance on this.
