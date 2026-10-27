Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104593;
	b=Z5jihnNvZLFvbTC4UqI5Kr2npJXWNpDfzf+AzE6V1FbFPkqRP/tKl8pSSpCa2HL6VExR
	 Ukx8oHQll+34EACvNbYDkKV2ayK/he19Sc0iDlaNE0VmTqBEY36pueyMA5pja+Znh18RD
	 Zs290bsP6DO1IpRNENNElnU6FkP5KxupMxMezu9Rzoa+T0aT7Ukrjs8Ys/30KnJqLsTid
	 PQRrLb0E+e9f2+LU1ki4RtHJvrXkw/alwTuJWDYDpJwCHN2O+CbJdQ15t1Xow3oCP0Qqt
	 RkKXNQ1klNPFinNnclvJvwBq/dafGJk00/WvpiwwfextADiypqwn2cWxvi1VzDcYxWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104593;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=VFKhT2ZU4RX1ef85zqHI9nW/qLYEYoyfLgUH95UA1+o=;
	b=jxKvIXsYakBHDUwOCY1vwarWl6UXmIuBfUIi7O/q6YDFYy0NnrkdatnTHuakMDHsR/ZN
	 A4PSGf75zJnsL46etgaY8QsMgAl5ohs6vcq3E4rvBcF32zFDjQDduMCBxKycZptx4gLOE
	 hOPSK6Gbx5xKX3/FpM9LCSd8fDFXaP266HuOQQdKMsSvnT3My7RdzJXMVIP0NEzqwh50T
	 UClgZMO8rGUyI0T1o6a88CRVS7+ACGfKmwMnKrHhoVxi28wzwOk3EDMXB0O8VGdx96Zbp
	 PUmAft0jGLIwSffgFFhCT03qdCBhLlegcj2QzQzgaWgXLgOIaeTMmJlHONwYPFIY0mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=maryasin.name;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67154606A31A
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 12:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67154606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maryasin.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4301e334ceso267023266b.1
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 05:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793104592; x=1793709392;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VFKhT2ZU4RX1ef85zqHI9nW/qLYEYoyfLgUH95UA1+o=;
        b=e1XQDwvzdiA0VaqjXvLw3rJn6Vtjiu51JiHpu63xwMKZ25nqJ1uUyRwLWrmP5SgLeS
         EmDURxFCHEK+i1ydp47eOjXDGQzIrzlEtv2nGJPtGKydlp5n3ckpNpAsQNkfpxSAHsNZ
         wOvZmA2REF5L8eAlh+GPnEI88N012l9yY/cSXfIgiPh8yDaKb+I/PzUrhZut/rDL1KS0
         FV7T9zR4nqXOF2sSqW9M6Ymf+W0Cb0Mf91OvzZZyeui8zXGJJSXqXNaumQkdGbCO8Ahu
         2PcfFx+yot69ExSN6kpsB1JJRi5w8JKY9RjtnW7XW9qqAF3+u9+hTwImbosoeZN2wTXT
         lLsQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8jeP4cxlhUVm4yVKZhLCgVYvttLiHgV3kavGtJ7NDDDTUOp6ocsuK1GyYZSPSsZAFjMDtWJPbtGmuug==@vger.kernel.org
X-Gm-Message-State: AFq9FYJtR6YPz9zkZQirqrZ9F8rqaIuKMjQUKi0O/qFyrTj2BnJCs6XJ
	1AC0vBmfpLS8fpxCjDgBcvX+gpFBtHHeFP+q+F2KNkU8ONdGjBOovn2CtinLO+DrGmZ23w==
X-Gm-Gg: AYBFou2s4sFIl4V385heA3K/4+A58C9DDYb/9O7wcoZsqHe4jvPvcXh3bTL9DONrkfn
	6Vok/rkagtfQVGzcwLMtCAyN5Qkt19tlADzIVypG0EL37H/64Myrzfib3OcomHMRxGJyDMr6RR9
	/lbiTUcnnYpngIm7WaVoBh+6ELE9/keCFqHQF8iQTA8FO1Onat6Sf1Bu/7FJ9xxpkHldlmyOEkk
	gcJoBSpcwqqvXbui9LmBel1lvJsNXxBdGoCVDpX8fNDLeouleN94EoNZ0V9v7VQ3FijGwMK0vIt
	lQnGkJ0hpttt/KxuXJfCO7PbageKtI5//XXTp1lzNrIGNA6ckzHqDgh6s59r4qqfjKu5M+HKDd/
	NCo3ZGro6tX/32bNJBjgax1QDnKgcA/YgH/oSk552zYudvCa+oyiaqlxGcofLzUbDqBE3pr6DH2
	UlbqrEyT/mFobpLVR40+HTOmikECOLXtkwvbhvTouKPwdes/uwmV9HxaX1e0ms4sk2CxJoIME6u
	0Z9jBeqoMvqfe9PUdwc0UH8zNsF3oXaOyWdmlqwawofM+RLHtSr5nIdd05PRR3iUgcysiHDk5Eq
	fwAY8DXD2cESajtIEpwYbE3n9h1JmkeaVpWnDsTBX1o2JNbpXp0Dajkgvaiu+UQRuf5njKwScpH
	l5bo7Dxk96+a+rU9ZwEsaz0kALj6Mi/6jd+COsz9K
X-Received: by 2002:a17:907:c1c:b0:c29:5172:6151 with SMTP id a640c23a62f3a-c46bdeb248dmr1131218566b.45.1793104591256;
        Tue, 27 Oct 2026 05:36:31 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd79eb05sm448188366b.79.2026.10.27.05.36.30
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:36:30 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so4465334a12.0
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 05:36:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwXsWG3RyvXc6NWIOs0C8Hi7i9SacNGA+Uo4XztuXarXNFJe0vbqCeTGT5AHYreblPmvHYi3VlEsDY/Jg==@vger.kernel.org
X-Received: by 2002:a05:6402:1bcb:b0:6b4:1df2:2458 with SMTP id
 4fb4d7f45d1cf-6b44300017emr7271084a12.40.1793104590385; Tue, 27 Oct 2026
 05:36:30 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAM2dg7eZJEii+fJT1TG8XME-TJFqDtURCsr5XS71E5-5-mUV0A@mail.gmail.com>
 <CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com> <f3f50abbaea73cb84e43bbf811065b866fc4d7d1.camel@linux.intel.com>
In-Reply-To: <f3f50abbaea73cb84e43bbf811065b866fc4d7d1.camel@linux.intel.com>
From: =?UTF-8?B?0KHQtdC80ZHQvSDQnNCw0YDRjNGP0YHQuNC9?= <simeon@maryasin.name>
Date: Tue, 27 Oct 2026 15:36:17 +0300
X-Gmail-Original-Message-ID: <CAM2dg7dDTQDobkOfLt586ex9o+v0eQqGouyYdpG1KPdfD6uwyg@mail.gmail.com>
X-Gm-Features: AclHuK9boCFFGtgh0KMXv3WcoMVlU8UMjOnleyXVoFT-p7Pv5w5BvvSmEFHoORg
Message-ID: <CAM2dg7dDTQDobkOfLt586ex9o+v0eQqGouyYdpG1KPdfD6uwyg@mail.gmail.com>
Subject: Re: Fwd: [BUG] HID: sensor: custom: use-after-free of sensor_inst via
 open misc device after remove (hard lockup)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Haoxiang Li <haoxiang_li2024@163.com>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000028204e065ed1b205"

--00000000000028204e065ed1b205
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello! Tested this patch (had to adapt it to apply it to 7.2.8 kernel;
attaching the adapted version).

Without patch: xxd running while intel_ishtp_hid module is removed ->
xxd hangs, system either crashes or at least logs "hid-sensor-hub
001F:8087:0AC2.0004: timeout waiting for response from ISHTP device"
With patch: xxd correctly closes with message "No such device", no
error in kernel logs, no crashes =E2=80=94 checked for several times.

=D0=BF=D1=82, 23 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 17:12, Sri=
nivas Pandruvada
<srinivas.pandruvada@linux.intel.com>:
>
> Hi,
> On Fri, 2026-10-23 at 13:42 +0300, =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=
=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD wrote:
> > Hello,
> >
> > hid-sensor-custom frees its per-sensor state (sensor_inst,
> > devm-allocated) on remove while userspace
> > can still hold the misc device /dev/HID-SENSOR-2000e1.N.auto open. A
> > reader blocked in read() stays
> > queued on sensor_inst->wait in freed memory; when it wakes up,
> > finish_wait() spins on a garbage
> > wait-queue lock with interrupts disabled and the machine hard-locks.
> > Any read()/poll()/release() on such
> > an fd after remove is a use-after-free as well.
> >
>
> Please give a try with the attached diff.
>
>
> Thanks,
> Srinivas
>
>
> > The Sashiko AI review already flagged this as a pre-existing issue
> > on Haoxiang Li's "Fix fields lifetime issues" series
> > ("The /dev/HID-SENSOR-* character device operations do not
> > synchronize
> > with device
> > removal,
> > leading to Use-After-Free on devm-managed structures"):
> > https://lore.kernel.org/linux-input/20260707071545.3087073-1-haoxiang_l=
i2024@163.com/
> > The applied patches don't touch it, and the current mainline is
> > unchanged. Below is a real-world hit.
> >
> > Kernel: 7.2.8 (NixOS; drivers/hid/hid-sensor-custom.c is identical to
> > current mainline,
> >         including ad8fb82b0442 and 3789d0802ddb)
> > Hardware: Dell Latitude 5420 (Tiger Lake, Intel ISH), BIOS 1.49.0;
> > Dell's vendor ISH sensors appear as
> >           HID-SENSOR-2000e1.N.auto (e.g. an ST VL53L1 time-of-flight
> > sensor).
> > Taint: O, from unrelated out-of-tree WWAN modules (qcserial,
> > usb_wwan).
> >
> > How it was hit
> > --------------
> >
> > 1. echo 1 > /sys/bus/platform/devices/HID-SENSOR-
> > 2000e1.2.auto/enable_sensor
> > 2. xxd /dev/HID-SENSOR-2000e1.2.auto        # streaming reader, left
> > running
> > 3. modprobe -r intel_ishtp_hid intel_ish_ipc && modprobe
> > intel_ish_ipc
> >
> > The hub went away and was re-enumerated fine; ~30 s later CPU0
> > hard-locked in the still-running xxd
> > and the hard-lockup detector panicked the machine (log recovered from
> > EFI pstore).
> >
> > Presumably a minimal reproducer is just a blocked reader plus
> > unbinding the platform device
> > (echo HID-SENSOR-2000e1.N.auto >
> > /sys/bus/platform/drivers/hid_sensor_custom/unbind),
> > but only the module-reload path above was actually tested so far.
> >
> > Log (trimmed)
> > -------------
> >
> > [146608.877730] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> > for response from ISHTP device
> > [146611.885959] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> > for response from ISHTP device
> > [146614.893909] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> > for response from ISHTP device
> > [146617.901872] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> > for response from ISHTP device
> > [146619.972550] ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}:
> > [hid-ish]: enum_devices_done OK, num_hid_devices=3D3
> > [146620.031441] hid-sensor-hub 001F:8087:0AC2.0007: hidraw3: SENSOR
> > HUB HID v2.00 Device [hid-ishtp 8087:0AC2] on
> > [146643.503266] iwlwifi 0000:00:14.3: Queue 3 is stuck 46 70
> > [146648.924391] watchdog: CPU0: Watchdog detected hard LOCKUP on cpu
> > 0
> > [146648.924796] CPU: 0 UID: 0 PID: 1316004 Comm: xxd Tainted: G
> >    O        7.2.8 #1-NixOS PREEMPT(lazy)
> > [146648.924804] Hardware name: Dell Inc. Latitude 5420/03P5X2, BIOS
> > 1.49.0 09/01/2025
> > [146648.924808] RIP: 0010:native_queued_spin_lock_slowpath+0x64/0x2c0
> > [146648.924851] Call Trace:
> > [146648.924855]  <TASK>
> > [146648.924857]  _raw_spin_lock_irqsave+0x3d/0x50
> > [146648.924872]  finish_wait+0x3b/0x90
> > [146648.924886]  hid_sensor_custom_read+0x102/0x150
> > [hid_sensor_custom]
> > [146648.924901]  vfs_read+0xbf/0x390
> > [146648.924934]  ksys_read+0xbf/0xf0
> > [146648.924939]  do_syscall_64+0x134/0x6b0
> > [146648.925010]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [146648.925083]  </TASK>
> > [146648.925086] Kernel panic - not syncing: Hard LOCKUP
> >
> > Also attaching a full dmesg log (with only wi-fi noise filtered out).
> >
> > Analysis (line numbers as in mainline 73bef5)
> > ---------------------------------------------
> >
> > - hid_sensor_custom_probe() allocates sensor_inst with devm_kzalloc()
> > (line 980), so it is freed right
> >   after hid_sensor_custom_remove() returns, regardless of open files.
> > - The misc device's fops reach sensor_inst through
> > container_of(file->private_data, ..., custom_dev);
> >   misc_deregister() does not revoke already-open files, so
> > read/poll/release keep dereferencing it.
> > - hid_sensor_custom_dev_if_remove() (lines 751-758) does wake_up(),
> > misc_deregister(), kfifo_free().
> >   The woken reader in hid_sensor_custom_read() (line 664) re-
> > evaluates
> >   wait_event_interruptible(sensor_inst->wait,
> > !kfifo_is_empty(&sensor_inst->data_fifo)), finds the fifo
> >   empty and goes back to sleep on sensor_inst->wait. Nothing tells it
> > the device is gone.
> > - Once sensor_inst is freed and reused, the next wakeup of that
> > reader
> > runs finish_wait() on the freed
> >   wait_queue_head: spin_lock_irqsave() on garbage, hard lockup.
> > hid_sensor_custom_release() similarly
> >   does clear_bit() on freed sensor_inst->misc_opened when the fd is
> > finally closed.
> >
> > Possible fix direction
> > ----------------------
> >
> > Tie sensor_inst's lifetime to its users rather than to devres, the
> > way
> > hidraw handles disconnect:
> > refcount it (kref: one reference for the device, one per open file;
> > kfifo_free() and kfree() on the last
> > put), add a "removed" flag set in remove() before
> > wake_up_interruptible_all(), include it in the
> > wait_event condition, and make read()/poll() return -ENODEV /
> > EPOLLHUP
> > > EPOLLERR once removed.
> >
> > The same review pointed out two more problems in this teardown path
> > that a fix would naturally cover:
> > remove() frees data_fifo before sensor_hub_remove_callback(), so a
> > sample arriving in between is
> > kfifo_in()'d into freed memory; and an enabled sensor is never
> > sensor_hub_device_close()d on remove.
> >
> > I can test patches on this machine.
> >
> > Thanks,
> > Semyon Maryasin
> >
> > P.S.: sorry for a possible duplicate, I think I messed with the
> > headers.



--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=
=D0=BD

--00000000000028204e065ed1b205
Content-Type: text/x-patch; charset="US-ASCII"; name="test_patch.diff"
Content-Disposition: attachment; filename="test_patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mvqo5y5j0>
X-Attachment-Id: f_mvqo5y5j0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMgYi9kcml2ZXJzL2hp
ZC9oaWQtc2Vuc29yLWN1c3RvbS5jCmluZGV4IGMyYjQyNWEuLmZlNjdlNGIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMKKysrIGIvZHJpdmVycy9oaWQvaGlkLXNl
bnNvci1jdXN0b20uYwpAQCAtMTEsNiArMTEsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4K
ICNpbmNsdWRlIDxsaW51eC9taXNjZGV2aWNlLmg+CiAjaW5jbHVkZSA8bGludXgva2ZpZm8uaD4K
KyNpbmNsdWRlIDxsaW51eC9rcmVmLmg+CiAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KICNpbmNs
dWRlIDxsaW51eC93YWl0Lmg+CiAjaW5jbHVkZSA8bGludXgvcG9sbC5oPgpAQCAtMzcsNiArMzgs
OCBAQCBzdHJ1Y3QgaGlkX3NlbnNvcl9jdXN0b21fZmllbGQgewogCiBzdHJ1Y3QgaGlkX3NlbnNv
cl9jdXN0b20gewogCXN0cnVjdCBtdXRleCBtdXRleDsKKwlzdHJ1Y3Qga3JlZiByZWY7CisJYm9v
bCByZW1vdmVkOwogCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7CiAJc3RydWN0IGhpZF9z
ZW5zb3JfaHViX2RldmljZSAqaHNkZXY7CiAJc3RydWN0IGhpZF9zZW5zb3JfaHViX2NhbGxiYWNr
cyBjYWxsYmFja3M7CkBAIC02NDMsNiArNjQ2LDE1IEBAIHN0YXRpYyB2b2lkIGhpZF9zZW5zb3Jf
Y3VzdG9tX3JlbW92ZV9hdHRyaWJ1dGVzKHN0cnVjdCBoaWRfc2Vuc29yX2N1c3RvbSAqCiAJa2Zy
ZWUoc2Vuc29yX2luc3QtPmZpZWxkcyk7CiB9CiAKK3N0YXRpYyB2b2lkIGhpZF9zZW5zb3JfY3Vz
dG9tX2ZyZWUoc3RydWN0IGtyZWYgKnJlZikKK3sKKwlzdHJ1Y3QgaGlkX3NlbnNvcl9jdXN0b20g
KnNlbnNvcl9pbnN0ID0KKwkJY29udGFpbmVyX29mKHJlZiwgc3RydWN0IGhpZF9zZW5zb3JfY3Vz
dG9tLCByZWYpOworCisJa2ZpZm9fZnJlZSgmc2Vuc29yX2luc3QtPmRhdGFfZmlmbyk7CisJa2Zy
ZWUoc2Vuc29yX2luc3QpOworfQorCiBzdGF0aWMgc3NpemVfdCBoaWRfc2Vuc29yX2N1c3RvbV9y
ZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBjaGFyIF9fdXNlciAqYnVmLAogCQkJCSAgICAgIHNpemVf
dCBjb3VudCwgbG9mZl90ICpmX3BzKQogewpAQCAtNjU2LDIyICs2NjgsMzUgQEAgc3RhdGljIHNz
aXplX3QgaGlkX3NlbnNvcl9jdXN0b21fcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3Vz
ZXIgKmJ1ZiwKIAlpZiAoY291bnQgPCBzaXplb2Yoc3RydWN0IGhpZF9zZW5zb3Jfc2FtcGxlKSkK
IAkJcmV0dXJuIC1FSU5WQUw7CiAKLQlkbyB7Ci0JCWlmIChrZmlmb19pc19lbXB0eSgmc2Vuc29y
X2luc3QtPmRhdGFfZmlmbykpIHsKLQkJCWlmIChmaWxlLT5mX2ZsYWdzICYgT19OT05CTE9DSykK
LQkJCQlyZXR1cm4gLUVBR0FJTjsKKwlmb3IgKDs7KSB7CisJCXJldCA9IG11dGV4X2xvY2tfaW50
ZXJydXB0aWJsZSgmc2Vuc29yX2luc3QtPm11dGV4KTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiBy
ZXQ7CiAKLQkJCXJldCA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZShzZW5zb3JfaW5zdC0+d2Fp
dCwKLQkJCQkha2ZpZm9faXNfZW1wdHkoJnNlbnNvcl9pbnN0LT5kYXRhX2ZpZm8pKTsKLQkJCWlm
IChyZXQpCi0JCQkJcmV0dXJuIHJldDsKKwkJaWYgKHNlbnNvcl9pbnN0LT5yZW1vdmVkKSB7CisJ
CQlyZXQgPSAtRU5PREVWOworCQkJZ290byB1bmxvY2s7CiAJCX0KIAkJcmV0ID0ga2ZpZm9fdG9f
dXNlcigmc2Vuc29yX2luc3QtPmRhdGFfZmlmbywgYnVmLCBjb3VudCwKIAkJCQkgICAgJmNvcGll
ZCk7CisJCWlmIChyZXQgfHwgY29waWVkKQorCQkJZ290byB1bmxvY2s7CisJCW11dGV4X3VubG9j
aygmc2Vuc29yX2luc3QtPm11dGV4KTsKKworCQlpZiAoZmlsZS0+Zl9mbGFncyAmIE9fTk9OQkxP
Q0spCisJCQlyZXR1cm4gLUVBR0FJTjsKKworCQlyZXQgPSB3YWl0X2V2ZW50X2ludGVycnVwdGli
bGUoc2Vuc29yX2luc3QtPndhaXQsCisJCQlSRUFEX09OQ0Uoc2Vuc29yX2luc3QtPnJlbW92ZWQp
IHx8CisJCQkha2ZpZm9faXNfZW1wdHkoJnNlbnNvcl9pbnN0LT5kYXRhX2ZpZm8pKTsKIAkJaWYg
KHJldCkKIAkJCXJldHVybiByZXQ7CisJfQogCi0JfSB3aGlsZSAoY29waWVkID09IDApOwordW5s
b2NrOgorCW11dGV4X3VubG9jaygmc2Vuc29yX2luc3QtPm11dGV4KTsKKwlpZiAocmV0KQorCQly
ZXR1cm4gcmV0OwogCiAJcmV0dXJuIGNvcGllZDsKIH0KQEAgLTY4NCw2ICs3MDksNyBAQCBzdGF0
aWMgaW50IGhpZF9zZW5zb3JfY3VzdG9tX3JlbGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3Ry
dWN0IGZpbGUgKmZpbGUpCiAJCQkJICAgc3RydWN0IGhpZF9zZW5zb3JfY3VzdG9tLCBjdXN0b21f
ZGV2KTsKIAogCWNsZWFyX2JpdCgwLCAmc2Vuc29yX2luc3QtPm1pc2Nfb3BlbmVkKTsKKwlrcmVm
X3B1dCgmc2Vuc29yX2luc3QtPnJlZiwgaGlkX3NlbnNvcl9jdXN0b21fZnJlZSk7CiAKIAlyZXR1
cm4gMDsKIH0KQEAgLTY5MSwxNCArNzE3LDIyIEBAIHN0YXRpYyBpbnQgaGlkX3NlbnNvcl9jdXN0
b21fcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKIHN0YXRp
YyBpbnQgaGlkX3NlbnNvcl9jdXN0b21fb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
ZmlsZSAqZmlsZSkKIHsKIAlzdHJ1Y3QgaGlkX3NlbnNvcl9jdXN0b20gKnNlbnNvcl9pbnN0Owor
CWludCByZXQ7CiAKIAlzZW5zb3JfaW5zdCA9IGNvbnRhaW5lcl9vZihmaWxlLT5wcml2YXRlX2Rh
dGEsCiAJCQkJICAgc3RydWN0IGhpZF9zZW5zb3JfY3VzdG9tLCBjdXN0b21fZGV2KTsKLQkvKiBX
ZSBlc3NlbnRpYWxseSBoYXZlIHNpbmdsZSByZWFkZXIgYW5kIHdyaXRlciAqLwotCWlmICh0ZXN0
X2FuZF9zZXRfYml0KDAsICZzZW5zb3JfaW5zdC0+bWlzY19vcGVuZWQpKQotCQlyZXR1cm4gLUVC
VVNZOworCW11dGV4X2xvY2soJnNlbnNvcl9pbnN0LT5tdXRleCk7CisJaWYgKHNlbnNvcl9pbnN0
LT5yZW1vdmVkKSB7CisJCXJldCA9IC1FTk9ERVY7CisJfSBlbHNlIGlmICh0ZXN0X2FuZF9zZXRf
Yml0KDAsICZzZW5zb3JfaW5zdC0+bWlzY19vcGVuZWQpKSB7CisJCXJldCA9IC1FQlVTWTsKKwl9
IGVsc2UgeworCQlrcmVmX2dldCgmc2Vuc29yX2luc3QtPnJlZik7CisJCXJldCA9IHN0cmVhbV9v
cGVuKGlub2RlLCBmaWxlKTsKKwl9CisJbXV0ZXhfdW5sb2NrKCZzZW5zb3JfaW5zdC0+bXV0ZXgp
OwogCi0JcmV0dXJuIHN0cmVhbV9vcGVuKGlub2RlLCBmaWxlKTsKKwlyZXR1cm4gcmV0OwogfQog
CiBzdGF0aWMgX19wb2xsX3QgaGlkX3NlbnNvcl9jdXN0b21fcG9sbChzdHJ1Y3QgZmlsZSAqZmls
ZSwKQEAgLTcxMiw2ICs3NDYsOSBAQCBzdGF0aWMgX19wb2xsX3QgaGlkX3NlbnNvcl9jdXN0b21f
cG9sbChzdHJ1Y3QgZmlsZSAqZmlsZSwKIAogCXBvbGxfd2FpdChmaWxlLCAmc2Vuc29yX2luc3Qt
PndhaXQsIHdhaXQpOwogCisJaWYgKFJFQURfT05DRShzZW5zb3JfaW5zdC0+cmVtb3ZlZCkpCisJ
CXJldHVybiBFUE9MTEhVUCB8IEVQT0xMRVJSOworCiAJaWYgKCFrZmlmb19pc19lbXB0eSgmc2Vu
c29yX2luc3QtPmRhdGFfZmlmbykpCiAJCW1hc2sgPSBFUE9MTElOIHwgRVBPTExSRE5PUk07CiAK
QEAgLTcxOSw2ICs3NTYsNyBAQCBzdGF0aWMgX19wb2xsX3QgaGlkX3NlbnNvcl9jdXN0b21fcG9s
bChzdHJ1Y3QgZmlsZSAqZmlsZSwKIH0KIAogc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMgaGlkX3NlbnNvcl9jdXN0b21fZm9wcyA9IHsKKwkub3duZXIgPSBUSElTX01PRFVMRSwK
IAkub3BlbiA9ICBoaWRfc2Vuc29yX2N1c3RvbV9vcGVuLAogCS5yZWFkID0gIGhpZF9zZW5zb3Jf
Y3VzdG9tX3JlYWQsCiAJLnJlbGVhc2UgPSBoaWRfc2Vuc29yX2N1c3RvbV9yZWxlYXNlLApAQCAt
NzQxLDIwICs3NzksMTcgQEAgc3RhdGljIGludCBoaWRfc2Vuc29yX2N1c3RvbV9kZXZfaWZfYWRk
KHN0cnVjdCBoaWRfc2Vuc29yX2N1c3RvbSAqc2Vuc29yX2luc3QpCiAJc2Vuc29yX2luc3QtPmN1
c3RvbV9kZXYubmFtZSA9IGRldl9uYW1lKCZzZW5zb3JfaW5zdC0+cGRldi0+ZGV2KTsKIAlzZW5z
b3JfaW5zdC0+Y3VzdG9tX2Rldi5mb3BzID0gJmhpZF9zZW5zb3JfY3VzdG9tX2ZvcHM7CiAJcmV0
ID0gbWlzY19yZWdpc3Rlcigmc2Vuc29yX2luc3QtPmN1c3RvbV9kZXYpOwotCWlmIChyZXQpIHsK
LQkJa2ZpZm9fZnJlZSgmc2Vuc29yX2luc3QtPmRhdGFfZmlmbyk7Ci0JCXJldHVybiByZXQ7Ci0J
fQotCXJldHVybiAwOworCXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyB2b2lkIGhpZF9zZW5zb3Jf
Y3VzdG9tX2Rldl9pZl9yZW1vdmUoc3RydWN0IGhpZF9zZW5zb3JfY3VzdG9tCiAJCQkJCQkJCSpz
ZW5zb3JfaW5zdCkKIHsKLQl3YWtlX3VwKCZzZW5zb3JfaW5zdC0+d2FpdCk7CisJbXV0ZXhfbG9j
aygmc2Vuc29yX2luc3QtPm11dGV4KTsKKwlXUklURV9PTkNFKHNlbnNvcl9pbnN0LT5yZW1vdmVk
LCB0cnVlKTsKKwltdXRleF91bmxvY2soJnNlbnNvcl9pbnN0LT5tdXRleCk7CisJd2FrZV91cF9p
bnRlcnJ1cHRpYmxlX2FsbCgmc2Vuc29yX2luc3QtPndhaXQpOwogCW1pc2NfZGVyZWdpc3Rlcigm
c2Vuc29yX2luc3QtPmN1c3RvbV9kZXYpOwotCWtmaWZvX2ZyZWUoJnNlbnNvcl9pbnN0LT5kYXRh
X2ZpZm8pOwotCiB9CiAKIC8qCkBAIC05NzcsOCArMTAxMiw3IEBAIHN0YXRpYyBpbnQgaGlkX3Nl
bnNvcl9jdXN0b21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlpbnQgcmV0
OwogCWNvbnN0IHN0cnVjdCBoaWRfc2Vuc29yX2N1c3RvbV9tYXRjaCAqbWF0Y2g7CiAKLQlzZW5z
b3JfaW5zdCA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKnNlbnNvcl9pbnN0KSwK
LQkJCQkgICBHRlBfS0VSTkVMKTsKKwlzZW5zb3JfaW5zdCA9IGt6YWxsb2Nfb2JqKCpzZW5zb3Jf
aW5zdCk7CiAJaWYgKCFzZW5zb3JfaW5zdCkKIAkJcmV0dXJuIC1FTk9NRU07CiAKQEAgLTk4OCw2
ICsxMDIyLDcgQEAgc3RhdGljIGludCBoaWRfc2Vuc29yX2N1c3RvbV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQogCXNlbnNvcl9pbnN0LT5oc2RldiA9IGhzZGV2OwogCXNlbnNv
cl9pbnN0LT5wZGV2ID0gcGRldjsKIAltdXRleF9pbml0KCZzZW5zb3JfaW5zdC0+bXV0ZXgpOwor
CWtyZWZfaW5pdCgmc2Vuc29yX2luc3QtPnJlZik7CiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgc2Vuc29yX2luc3QpOwogCiAJcmV0ID0gaGlkX3NlbnNvcl9jdXN0b21fZ2V0X2tub3duKGhz
ZGV2LCAmbWF0Y2gpOwpAQCAtOTk5LDcgKzEwMzQsNyBAQCBzdGF0aWMgaW50IGhpZF9zZW5zb3Jf
Y3VzdG9tX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCWlmIChyZXQpIHsK
IAkJCWRldl9lcnIoJnBkZXYtPmRldiwKIAkJCQkicmVnaXN0ZXJfcGxhdGZvcm1fZGV2aWNlIGZh
aWxlZFxuIik7Ci0JCQlyZXR1cm4gcmV0OworCQkJZ290byBlcnJfZnJlZTsKIAkJfQogCiAJCXJl
dHVybiAwOwpAQCAtMTAwOSw3ICsxMDQ0LDcgQEAgc3RhdGljIGludCBoaWRfc2Vuc29yX2N1c3Rv
bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQkJCQkgICAmc2Vuc29yX2lu
c3QtPmNhbGxiYWNrcyk7CiAJaWYgKHJldCA8IDApIHsKIAkJZGV2X2VycigmcGRldi0+ZGV2LCAi
Y2FsbGJhY2sgcmVnIGZhaWxlZFxuIik7Ci0JCXJldHVybiByZXQ7CisJCWdvdG8gZXJyX2ZyZWU7
CiAJfQogCiAJcmV0ID0gaGlkX3NlbnNvcl9jdXN0b21fYWRkX2F0dHJpYnV0ZXMoc2Vuc29yX2lu
c3QpOwpAQCAtMTAzNCw2ICsxMDY5LDggQEAgZXJyX3JlbW92ZV9hdHRyaWJ1dGVzOgogCWhpZF9z
ZW5zb3JfY3VzdG9tX3JlbW92ZV9hdHRyaWJ1dGVzKHNlbnNvcl9pbnN0KTsKIGVycl9yZW1vdmVf
Y2FsbGJhY2s6CiAJc2Vuc29yX2h1Yl9yZW1vdmVfY2FsbGJhY2soaHNkZXYsIGhzZGV2LT51c2Fn
ZSk7CitlcnJfZnJlZToKKwlrcmVmX3B1dCgmc2Vuc29yX2luc3QtPnJlZiwgaGlkX3NlbnNvcl9j
dXN0b21fZnJlZSk7CiAKIAlyZXR1cm4gcmV0OwogfQpAQCAtMTA0NSw3ICsxMDgyLDcgQEAgc3Rh
dGljIHZvaWQgaGlkX3NlbnNvcl9jdXN0b21fcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCiAKIAlpZiAoc2Vuc29yX2luc3QtPmN1c3RvbV9wZGV2KSB7CiAJCXBsYXRmb3JtX2Rl
dmljZV91bnJlZ2lzdGVyKHNlbnNvcl9pbnN0LT5jdXN0b21fcGRldik7Ci0JCXJldHVybjsKKwkJ
Z290byBvdXQ7CiAJfQogCiAJaGlkX3NlbnNvcl9jdXN0b21fZGV2X2lmX3JlbW92ZShzZW5zb3Jf
aW5zdCk7CkBAIC0xMDUzLDcgKzEwOTAsMTEgQEAgc3RhdGljIHZvaWQgaGlkX3NlbnNvcl9jdXN0
b21fcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJc3lzZnNfcmVtb3ZlX2dy
b3VwKCZzZW5zb3JfaW5zdC0+cGRldi0+ZGV2LmtvYmosCiAJCQkgICAmZW5hYmxlX3NlbnNvcl9h
dHRyX2dyb3VwKTsKIAloaWRfc2Vuc29yX2N1c3RvbV9yZW1vdmVfYXR0cmlidXRlcyhzZW5zb3Jf
aW5zdCk7CisJaWYgKHNlbnNvcl9pbnN0LT5lbmFibGUpCisJCXNlbnNvcl9odWJfZGV2aWNlX2Ns
b3NlKGhzZGV2KTsKIAlzZW5zb3JfaHViX3JlbW92ZV9jYWxsYmFjayhoc2RldiwgaHNkZXYtPnVz
YWdlKTsKK291dDoKKwlrcmVmX3B1dCgmc2Vuc29yX2luc3QtPnJlZiwgaGlkX3NlbnNvcl9jdXN0
b21fZnJlZSk7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2lkIGhp
ZF9zZW5zb3JfY3VzdG9tX2lkc1tdID0gewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLXNl
bnNvci1odWIuYyBiL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMKaW5kZXggNjQ3MGEyOS4u
ZjI3MGI1OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaGlkLXNlbnNvci1odWIuYworKysgYi9k
cml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jCkBAIC0xNzMsNyArMTczLDggQEAgaW50IHNlbnNv
cl9odWJfcmVtb3ZlX2NhbGxiYWNrKHN0cnVjdCBoaWRfc2Vuc29yX2h1Yl9kZXZpY2UgKmhzZGV2
LAogCXN0cnVjdCBzZW5zb3JfaHViX2RhdGEgKnBkYXRhID0gaGlkX2dldF9kcnZkYXRhKGhzZGV2
LT5oZGV2KTsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCi0Jc3Bpbl9sb2NrX2lycXNhdmUoJnBk
YXRhLT5keW5fY2FsbGJhY2tfbG9jaywgZmxhZ3MpOworCXNwaW5fbG9ja19pcnFzYXZlKCZwZGF0
YS0+bG9jaywgZmxhZ3MpOworCXNwaW5fbG9jaygmcGRhdGEtPmR5bl9jYWxsYmFja19sb2NrKTsK
IAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNhbGxiYWNrLCAmcGRhdGEtPmR5bl9jYWxsYmFja19saXN0
LCBsaXN0KQogCQlpZiAoY2FsbGJhY2stPnVzYWdlX2lkID09IHVzYWdlX2lkICYmCiAJCQkJCQlj
YWxsYmFjay0+aHNkZXYgPT0gaHNkZXYpIHsKQEAgLTE4MSw3ICsxODIsOCBAQCBpbnQgc2Vuc29y
X2h1Yl9yZW1vdmVfY2FsbGJhY2soc3RydWN0IGhpZF9zZW5zb3JfaHViX2RldmljZSAqaHNkZXYs
CiAJCQlrZnJlZShjYWxsYmFjayk7CiAJCQlicmVhazsKIAkJfQotCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnBkYXRhLT5keW5fY2FsbGJhY2tfbG9jaywgZmxhZ3MpOworCXNwaW5fdW5sb2NrKCZw
ZGF0YS0+ZHluX2NhbGxiYWNrX2xvY2spOworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBkYXRh
LT5sb2NrLCBmbGFncyk7CiAKIAlyZXR1cm4gMDsKIH0K
--00000000000028204e065ed1b205--
