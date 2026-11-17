Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794887053;
	b=CeninZ7vSF6oVYKswmGYI4NybaqgxDWF5bs6GHxegInC6Wl5cCrM58Kf2t/roPp+f6RI
	 HXJ/r43PRV4zeOuUVAPVx8d5PDW4TI488dGLG7WnqMkpsw0fxJwuijJWeqW1TNwJB0WnZ
	 CfXyI/ZmccYTuTHMhgKNDuhK0ZGHSiaVIBHmCND/O4HhswXcRrLDMCVl4SpAzw0CD/c1p
	 R5DNtGh2J8kSXiRf2daLs5zxTjl4cUhq2s954jLXVe/KvGUQQJB5Sn7+UUH3GTr6njfO3
	 5AIVkq9xATwMV+M5D3WBgC/zYtHZ1l84qai4ejWzYIu5mcEi23ZwGqCAJZphtRAFUWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=C4WE6lvbRm2tg6GIEGvDJsmiQH5bZTXE6oQATuM1VIM=;
	b=ivFtipSZXyF1nrXGkEA4QFyA4VN4Jg6Py1b2A70omMSvxfFXAPxG7NwgTiVes8Dxw9lw
	 Cwu3XzUBcKL4N0CG54A4E4oUjAkBoil0eQ5oZujGWXeYFukM1lg3o4ORv3EmO5N6Dviua
	 4p6rDSGAuOY3XOwFPe0GI5NyIHPtRhwkcFhqn7UA+9S1iSUwKjg84B7Evnp8dr2w/sBnZ
	 VIJGSlN4dYdxYAOFcYpLBDcNOm+pGd9gLt0cn++AyhPGptSQiVVRz8RRreM6bA9YjN/20
	 UL3h2VGTgxs65ep3jCRZQy25DD4VW7nJ9zqJ2/HWhC+/gpg4THbtiUoYqifxB6ooG3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EC51+VkK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.73
Received: from mail-lr2-f9.google.com (mail-lr2-f9.google.com [74.125.230.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74441606A323
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 03:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74441606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EC51+VkK
Received: by mail-lr2-f9.google.com with SMTP id 38308e7fff4ca-3ad31c004d8so21329261fa.1
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 19:44:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794887051; cv=none;
        d=google.com; s=arc-20260327;
        b=AQB2utMyuGlGyg1+kLMNjcIPA9AFAFLrRA1srBYiutipQGGh2ObD6JIQ6+OqDY81cF
         Mv+ldUADmmwtiVqva179QWqF9lYhHy71upFm4xiui4HVlxDIFXuz2DINLj+I9K9rNRlP
         7Xp7Tef/taW0CU9DYECsUjMbKjxwgym8da6geF/oBTTlj4h+O+3kLRAxjN1FSiccxILo
         hcRNDkFCxsrpxodPyBnOaVAU/F/B4763xq+odPy+lQFOVLBYKmiLDoDoZiKKcsiFI2ei
         bJXHzsXkY+cMQXRBVmqX3hs0JactGGej2nxhxwYZ3TlndSh7pSu7I5gbqgrgIqEP1pnc
         s1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=C4WE6lvbRm2tg6GIEGvDJsmiQH5bZTXE6oQATuM1VIM=;
        fh=hUB4kOWznsxbqoTk6k+S0GZG034Qx98ngI9nQeAirEc=;
        b=dLe0ET1DibF3Wn7yyKe7pNQhW6T+tKmvORQS3lVtWoDoZNQ9C5xygIrs/mkciYny7Q
         4hMTmcJMDikPxUOD2bJj4OSM+86ygW3P2h89qRBgs0jV2VZH9MJPhRzoPcHl59AZ2rL9
         /UCllBfiw32YWS/3+Y54wOPiR+ewgipN4m+p0/4eZL6Xhu75kKCvkTfimcnf+PM6qbAQ
         lq2huGy6lKh6pRjp5OhR/eYzCjkJifu3Qn7vmlv5bZ+MfaXsR0N38oa7wWkMmLaRbhRO
         GDJW0azhCnERDiv+nhUOZvyqP9KnAsDvr4mYnhTe/b2SAMaYqWzzcp0OGe14o+vpet1u
         TQXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794887051; x=1795491851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C4WE6lvbRm2tg6GIEGvDJsmiQH5bZTXE6oQATuM1VIM=;
        b=EC51+VkKhcCEziOH6+Eqj1/0rMDeYpe0mcMeXO3WRqZmITLC7vWVzx/i3SPL1bVJug
         /jbNoGjgKWYVLeC5vURKfC9x+kdRODRTcZ/NqwWHxFeDgfyy2B+Ovu5QFzoUR4h43Atm
         sey4P+LZw7kV5Tqz70q5Xww+QkyY+fY/v1uEBddEmrBhCHBs0WAtK8IQZlSJ3TJ4zAXa
         uwBj5T+ytIXcWj11QwcLt6mqebQtvsnNqbDH9paXG+79ENmbEqA/R81r8RJ4UFpB8eJH
         NTbf8JS79xbjW4las8/zq8hoGpC39St22sl2H7jnWW2Qu8u6Poa0fCw14oS7vQIi93Yp
         Xghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794887051; x=1795491851;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C4WE6lvbRm2tg6GIEGvDJsmiQH5bZTXE6oQATuM1VIM=;
        b=X8HUZktzOJaHsKvCu7/MBFx2rOjboc6wnB0TmakntS+MNpg5Bx/zTaDO6VQpN5xjGO
         eirYwLsgQgmpZgA7+V1rUd9VoobKLXGQwOGtPfi3IHJ9+PmtYIvsZYktc3JP1WZdF+3D
         twLDsnL4+O1W+E+RhfREHTtmtUs0xszD2pHfElItF4dDm9hBSFzl6egegPsqk2dyamNf
         E7KRYosfiOWt6vN3BuL80StIpNkrB4XOFHKNVz9t/tN+FUFE1ae4XemF5XczR9Sfrbja
         3d8L0we4dX9hakftWkOz4Um87BmfALl4vcQmO3ChbZi3G+IE0uacRMaIwyKzHW8mUoZa
         HSdA==
X-Gm-Message-State: APuU4Z//7ugiHGSDyKKWACPtfUeiP116WObCAcMGcY0Ujmyu5tY+rhPE
	ozuLe1BaQmrMJMP3ajG/5pLi9ComFb3OssNyLgbbMbbVUr07PafiRIPJia+ZpWNM3jZgCKTAeXu
	cmIfCkIgy5oDN0VujeUps5k7r6hZSlQU=
X-Gm-Gg: AYBFou09Jx5K1TDoFVfTYuHjqOnL69rRfvfgLkgPfFOJrnMlrCTLQdp/lMk/rcGCxFN
	KR+Hh61WiJjdTtkK/cYq4AUb3WCGIsTSqfMAmdJFo+MMI1iW2bN6PsOBmiV53rfkowahOPruPG4
	+A5fX0pvf+cmiQWpbaE1TnicvVDN4g03YzpY8g3idvvWCWuWm6TTvEW/dr3LuNDWssWqfV29itF
	+6eyFRXEFpdBzhVZKi9wmnFY3+aWEh9Mjo3gPqFUMKeMb20S947GUH0mCnX20lS3/7O5cGCuA3W
	evItdHbV4EpB0ILMqOJmxAS1iKCw5BTAqy4cUXMPrL3d/xsJMt/l4VW87vnWAUd3iUbdMG5NjaM
	cVuR7Op7NJX52cEpRLORxkQhkY30MvGwxqjR0+UX1O5Vp7Dkdc0HhnW8+N27nmdvEEJSANlRoMc
	k0t9Yq1zbYOD8a0A==
X-Received: by 2002:a05:651c:502:b0:3a6:6f81:1027 with SMTP id
 38308e7fff4ca-3ae2b531493mr38348591fa.24.1794887051332; Mon, 16 Nov 2026
 19:44:11 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Zheng Zheng <fengaojigui88@gmail.com>
Date: Tue, 17 Nov 2026 11:43:57 +0800
X-Gm-Features: AclHuK841NQw71Pm0HHoozBnMA4yabK9zjfXO_9miNQ1BHUNWG1VHD5_WFWcnW4
Message-ID: <CAO-4RZ0262Z+oTx05f8_mD9eJu7wYE4UNZgHe79dR9m7pHvvCA@mail.gmail.com>
Subject: [BUG] WARNING: ODEBUG bug in corsair_remove (drivers/hid/hid-corsair.c,
 v7.4-rc3)
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Jiri, Benjamin,

We found a reproducible debugobjects warning in the Corsair HID driver on
v7.4-rc3 with syzkaller. We reproduced this warning on an unmodified
v7.4-rc3 kernel.

Key log excerpt from the rc3 external run
(logs/external-verification/run1-serial.log, hit at 93.23 s):

  [   93.233905][   T11] ODEBUG: free active (active state 0) object:
ff1100017cebb2c8 object type: work_struct hint:
k90_record_led_work+0x0/0x210
  [   93.233944][   T11] WARNING: lib/debugobjects.c:629 at
debug_print_object+0x1a0/0x2e0, CPU#0: kworker/0:1/11
  [   93.237255][   T11] Modules linked in: dm_multipath(E)
  [   93.238355][   T11] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1
Tainted: G            E       7.4.0-rc3-kernsight-kasan #1
PREEMPT(full)
  [   93.242242][   T11] Workqueue: usb_hub_wq hub_event
  [   93.242850][   T11] RIP: 0010:debug_print_object+0x1a5/0x2e0
  [   93.258269][   T11] Call Trace:
  [   93.258659][   T11]  <TASK>
  [   93.259006][   T11]  ? __pfx_k90_record_led_work+0x10/0x10
  [   93.259685][   T11]  debug_check_no_obj_freed+0x3d7/0x520
  [   93.262901][   T11]  kfree+0x3ff/0x660
  [   93.263373][   T11]  ? corsair_remove+0xff/0x2f0
  [   93.263953][   T11]  corsair_remove+0xff/0x2f0
  [   93.265130][   T11]  hid_device_remove+0xd6/0x200
  [   93.266372][   T11]  device_remove+0xd0/0x170
  [   93.266925][   T11]  device_release_driver_internal+0x45f/0x630
  [   93.268915][   T11]  bus_remove_device+0x2bf/0x570
  [   93.270799][   T11]  device_del+0x39b/0x9e0
  [   93.273129][   T11]  hid_destroy_device+0x1a9/0x240
  [   93.273736][   T11]  usbhid_disconnect+0xa8/0xe0
  [   93.274289][   T11]  usb_unbind_interface+0x1ea/0x9a0
  [   93.275595][   T11]  device_remove+0x12a/0x170
  [   93.276150][   T11]  device_release_driver_internal+0x45f/0x630
  [   93.278564][   T11]  bus_remove_device+0x2bf/0x570
  [   93.279884][   T11]  device_del+0x39b/0x9e0
  [   93.281551][   T11]  usb_disable_device+0x35e/0x800
  [   93.282146][   T11]  usb_disconnect+0x2e4/0xa10
  [   93.282725][   T11]  hub_event+0x1ea9/0x5010
  [   93.294782][   T11] Kernel panic - not syncing: kernel:
panic_on_warn set ...

Critical call chain:

  debug_check_no_obj_freed
   kfree
    corsair_remove+0xff/0x2f0
     hid_device_remove
      device_remove
       device_release_driver_internal
        bus_remove_device
         device_del
          hid_destroy_device
           usbhid_disconnect
            usb_unbind_interface
             usb_disable_device
              usb_disconnect
               hub_event

The ODEBUG hint is `k90_record_led_work`.

How to reproduce:

1. Build vanilla v7.4-rc3 with:
     CONFIG_KASAN=y
     CONFIG_DEBUG_OBJECTS=y
     CONFIG_DEBUG_OBJECTS_WORK=y
     CONFIG_HID_CORSAIR=y
     CONFIG_DEBUG_INFO=y
   The bzImage used here has sha256
   0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882.

2. Boot a Debian trixie x86_64 guest (6 GiB RAM, 4 vCPU, KVM) with at least:
     root=/dev/sda console=ttyS0 oops=panic panic_on_warn=1
   The full QEMU command line is in environment.txt.

3. Copy syz-execprog and syz-executor built from syzkaller commit
   853b104bb454141a5b0fc0e4218ec78e9f34ffb1, plus
   reproducer/repro.kernsight.prog, into the guest.

4. In the guest, as root, run:

     syz-execprog -procs=8 -threaded -repeat=1 \
         -executor ./syz-executor repro.kernsight.prog

Expected result: ODEBUG `free active` warning in dmesg/serial after roughly
90-100 seconds, with the call chain above; panic_on_warn=1 then panics the
guest. We observed the hit 2/2 on fresh VMs:

  Run 1: 93.23 s after boot
  Run 2: 94.27 s after boot

Analysis:

The Corsair LED work items are queued by k90_brightness_set() via
schedule_work(). During removal, both cleanup paths do:

  cancel_work_sync(&...->work);
  led_classdev_unregister(&...->cdev);
  kfree(...);

led_classdev_unregister() turns the LED off, which can queue the work item
again after the first cancel_work_sync(). The containing structure is then
freed while the work_struct is still active, so debugobjects reports
"free active" in corsair_remove().

A reproducer repository is available at:

  https://github.com/Zheng-zheng-codes/corsair-remove-odebug-warning

It contains the syzkaller program, kernel config, guest/run details and the
full rc3 serial logs.

Best regards,
Zheng Zheng
