Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AE839769D
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632776; cv=none; b=lzc4GcpP9ZRK/7uSjYAYo0vIQjDp3tc5Xfb9KtlBkEGD0kKaubDRg1FeOdPfYtZb6/42ICSH+hlYC2VGZnp8+VCC3a2o9p6x+ReOqRvs2AVEYMCAHMGkykECnQi4h3qZCHTPuvIDHvARS6zbrWvDvZbiSuQ1Bg1grm5TNPs9Vk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632776; c=relaxed/simple;
	bh=s7Sv44dJsqAFpIPuZKy6IKwqnLbr+yfy5ipG5K17i5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nihgQNIbpLLdwP0lfGPdtn4Awns8llrmoI/at3RFw5VFyqmwvzFJUEn2dG3BK+hw3HMje9jtSXZ/gJFnwlB5ThAq+velIhJmsUImY9iJslWN0IjMByDrc7W1BQ0jakYSJACnuAVbzhPZDP3KTEv74KAWMOA66WcitmCKVCFRWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsarD2ki; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsarD2ki"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38759bcd877so9847764a91.2
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632773; x=1785237573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1sboYn+PLqx0GjgQRMyl0bLfsK7YBG4P1Cv4h1Q/PY=;
        b=bsarD2kiV+X8gLP/LrQGzyI8MxbL6NknViCOMXSxcSYOYhHxG27yvpQ2BzyymAdMdY
         S9M+N5Ow4jf8I5PF7rSNbgpkVe2/7Myq4ZAjkeG3+kBccg10GFhGv3WMJyYym/EIyWSf
         s7WjbhvgyuKscn0MQ3DgcoYUF2afFMHi30fVBLcv15BLfwX9scfIHUD7l7tiMRd5mQqW
         5LvaetHL4v5yPqrpQ6VB9XP1lt2dPWknQlJi+o9yzrS9LA+/VjKzoPzQ2CtsfGF/78Lc
         o9gSbli9romWwsp6nDPLvl+xrBdBaFiLpIO8ugq/SQnHs6GZc6WXKjCYME4smC/MbK+B
         hREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632773; x=1785237573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1sboYn+PLqx0GjgQRMyl0bLfsK7YBG4P1Cv4h1Q/PY=;
        b=mz5MbZGF2tVKgmKcY3MYjTa1Vl3quCFCYKY7zLly1uQDuyAcv6RQfcMNQzQg6i3zcR
         uWkLVYw2X+Q1mULbF96GhC2EDhm7OoCwuGJ0ciVcAWBc6VOUHEgEjhVWi9HPNsMGeWRh
         xFjXuUR16EWMxla76+mYP34ECwxWn1Wv5lD15PwP54Dtaa3yPzagR3UUGCElxyJ8GUOm
         NGF6FJHAK7rrjhBvPkueVVCJGTJmC5YQeuiqjjsLF49hq153cNjB+hUxYJO5wDvYPJ/v
         1ESVM5vNhfIn87n4gIQKY+/jjqX/L4fCux1fcePPAa8YWFOfHntUf4+MKNAJrghLCDiu
         2h+g==
X-Gm-Message-State: AOJu0Ywk5uBL4izXpgtoHHnHKLfL/NQSjpmzIbQbsPuVGfYfE5Myvjso
	+kAKOgTeyT4wcjzAkKyFTYaDo2v2ZSptG8oFbKV8WBDjlEMxNEHGWNddp8gC9BY=
X-Gm-Gg: AR+sD128+Q9EGHFQbZrfA2xZZbChS0S2Mcw6cO6zdQfZdVFsaLZzXQUCGp4+0usfmCn
	idvSeTfEwVDXmoyGGC0D0lVZqMQpWiJhP25E8KoUeNvRDXTbgPTK5hLOqm1zGuH9QBWaUdw+TCL
	0p7o3Kt3mKFyL18o/+PTu2xg6nM+nWYwGmFnPdY9EBQJlvAeNH1s1381DwUk/SdwPGXsLwg4G3X
	6+guRdfrkWleMaLj1w3DYlwVtjuVvAftMlRuNRSBcO8gB+h/TZRZcH+ODLQEjPH1s/9eWt4i6d3
	VmKu3FplFQKitoftwOt35CG/JVoyDFS2VF0YplMj9Cxea0NnY+Jltu41ZqQypQBkPdopQEGrSMk
	IT9gnTYX0YydIYlSNlTZ9wJtkHbm5uiDI/Xu/7CiThH0qc7t4AG0FdisCRmacVbjmrzbAvXR3nQ
	zHcPtrl9E2xC9Saqdo+dQAL98FXkddFTTj1Ve/6k8=
X-Received: by 2002:a17:90b:2890:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-38e4b434f04mr18890851a91.5.1784632773222;
        Tue, 21 Jul 2026 04:19:33 -0700 (PDT)
Received: from HPavillion15 ([2401:4900:8fe7:398d:8029:e3b8:bece:5845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29ffb13sm40281251c88.6.2026.07.21.04.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:19:32 -0700 (PDT)
From: Barath Kannan <barathrk11@gmail.com>
To: linux-input@vger.kernel.org
Cc: Barath Kannan <barathrk11@gmail.com>,
	linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	bentiss@kernel.org,
	jikos@kernel.org
Subject: [BUG] HID/input - Input misses when rapidly pressing consumer control keys on Logitech Media Keyboard K200
Date: Tue, 21 Jul 2026 16:49:15 +0530
Message-ID: <20260721111916.154338-1-barathrk11@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
