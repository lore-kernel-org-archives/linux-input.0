Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793577118;
	b=Wk2uXXEXxDL4jfN6rSnlNLnKcaQk+qDJhLE77EruearEnVDTbgmqT9xbd/dCiXY9pYyM
	 odGrSV5c7PybQ1I7sDmkwAm0eXTlDZ+zAa71qrUKAFhk0EAj9otYNpuo+3ZAvTqEMCloR
	 QX0sEpUQx5Z5Na0MnVUMbl9HfgLueoDOgVAR8WKQVvZWk0ttexbKPbHT/uCSVJluVqZMV
	 2RctQwtV+RFqykgvS4DxeBawh72fs2ogxENOCe1KGqD4YIz9fSJpLpv1f4zuytmJg3T2R
	 8O1NIyoi3j7HHDAuOKfQEKaCi7EOha3OSOPfcmjnw9c98a9h2B0wLtd90E37GNSo/Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793577118;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IJgMuA+ECaJ8z8cHKxX/ao7zT6HhAj4YFvOVHgNIgIg=;
	b=cU5Ax+XMRMSGibrtYDQy9jqDKnlJNNjylsSmPAOg6u0pZd/lG8tJJDcU+oFAICs3ngky
	 TqvQyHoz8dO7bOcsNUUUiGBCX4rm8wVnEvVGScaqXu/aBYiHk7TgMsVKzK83FDTsJ6gKA
	 SpFEiQp7ZsO/4NhMAW12ngIiMsb4fYe4dzDUJf6dwxrQi1OqDt+qGyv2uyJEFnQVcAYS+
	 B8mnvojL+9ZCwCIOzQ4xtmXC9r6tGXGcKQlX1IBYYyOPZAMW6mgbXIB3/gOpKNFgCxY3+
	 BOaA7T06TR1zxTZyTgVJDF2QVJBXJLVen2yw/iUegmpRDgxg/JhASnezx3TLEpUCE2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BYu7sw/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC6606A329;
	Sun,  1 Nov 2026 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYu7sw/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03FE1F000C1;
	Sun,  1 Nov 2026 23:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793577117;
	bh=IJgMuA+ECaJ8z8cHKxX/ao7zT6HhAj4YFvOVHgNIgIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BYu7sw/Y2U6aEwK6PZPtJ1ZGT9oMGgW/xr7vm0zmx1qrReN4+MNaOwuoLYuIsi8gL
	 0ZI7/A8kliC+oaoLJWyGF3R9N+uj2JZ/XRBoe471c0X2WXT+QMkgJ9rkIatCOZSw/X
	 cI232pyKzIwY4L5k25hYrCHwY8DSfS5ouxNwGviHJXS8/dWYNzzzom8cPDWVCrzKvZ
	 1bQAKhXyf35XGXxPAmvv0lP/IxU2I6dduI7gNl5W9E6Yb3PiDkj30mOA7FAdy3S1IN
	 4oDX/DpB64G9XdydRo/tntGZ6h03f9daKILB5Riu2/G7Eqg3phlMJoGGgYsR/1LPrp
	 NI5u+f7eTmYkQ==
Date: Sun, 1 Nov 2026 23:51:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?0KHQtdC80ZHQvSDQnNCw0YDRjNGP0YHQuNC9?= <simeon@maryasin.name>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Haoxiang Li
 <haoxiang_li2024@163.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [BUG] HID: sensor: custom: use-after-free of sensor_inst via
 open misc device after remove (hard lockup)
Message-ID: <20261101235150.5b7f1549@jic23-hlaptop>
In-Reply-To: <CAM2dg7dDTQDobkOfLt586ex9o+v0eQqGouyYdpG1KPdfD6uwyg@mail.gmail.com>
References: <CAM2dg7eZJEii+fJT1TG8XME-TJFqDtURCsr5XS71E5-5-mUV0A@mail.gmail.com>
	<CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com>
	<f3f50abbaea73cb84e43bbf811065b866fc4d7d1.camel@linux.intel.com>
	<CAM2dg7dDTQDobkOfLt586ex9o+v0eQqGouyYdpG1KPdfD6uwyg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 15:36:17 +0300
=D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=
=D0=BD <simeon@maryasin.name> wrote:

> Hello! Tested this patch (had to adapt it to apply it to 7.2.8 kernel;
> attaching the adapted version).
>=20
> Without patch: xxd running while intel_ishtp_hid module is removed ->
> xxd hangs, system either crashes or at least logs "hid-sensor-hub
> 001F:8087:0AC2.0004: timeout waiting for response from ISHTP device"
> With patch: xxd correctly closes with message "No such device", no
> error in kernel logs, no crashes =E2=80=94 checked for several times.

thanks!

I'm assuming that Srinivas will at somepoint post a version of
this patch as a formal submission.

Jonathan

>=20
> =D0=BF=D1=82, 23 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 17:12, S=
rinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>:
> >
> > Hi,
> > On Fri, 2026-10-23 at 13:42 +0300, =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=
=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD wrote: =20
> > > Hello,
> > >
> > > hid-sensor-custom frees its per-sensor state (sensor_inst,
> > > devm-allocated) on remove while userspace
> > > can still hold the misc device /dev/HID-SENSOR-2000e1.N.auto open. A
> > > reader blocked in read() stays
> > > queued on sensor_inst->wait in freed memory; when it wakes up,
> > > finish_wait() spins on a garbage
> > > wait-queue lock with interrupts disabled and the machine hard-locks.
> > > Any read()/poll()/release() on such
> > > an fd after remove is a use-after-free as well.
> > > =20
> >
> > Please give a try with the attached diff.
> >
> >
> > Thanks,
> > Srinivas
> >
> > =20
> > > The Sashiko AI review already flagged this as a pre-existing issue
> > > on Haoxiang Li's "Fix fields lifetime issues" series
> > > ("The /dev/HID-SENSOR-* character device operations do not
> > > synchronize
> > > with device
> > > removal,
> > > leading to Use-After-Free on devm-managed structures"):
> > > https://lore.kernel.org/linux-input/20260707071545.3087073-1-haoxiang=
_li2024@163.com/
> > > The applied patches don't touch it, and the current mainline is
> > > unchanged. Below is a real-world hit.
> > >
> > > Kernel: 7.2.8 (NixOS; drivers/hid/hid-sensor-custom.c is identical to
> > > current mainline,
> > >         including ad8fb82b0442 and 3789d0802ddb)
> > > Hardware: Dell Latitude 5420 (Tiger Lake, Intel ISH), BIOS 1.49.0;
> > > Dell's vendor ISH sensors appear as
> > >           HID-SENSOR-2000e1.N.auto (e.g. an ST VL53L1 time-of-flight
> > > sensor).
> > > Taint: O, from unrelated out-of-tree WWAN modules (qcserial,
> > > usb_wwan).
> > >
> > > How it was hit
> > > --------------
> > >
> > > 1. echo 1 > /sys/bus/platform/devices/HID-SENSOR-
> > > 2000e1.2.auto/enable_sensor
> > > 2. xxd /dev/HID-SENSOR-2000e1.2.auto        # streaming reader, left
> > > running
> > > 3. modprobe -r intel_ishtp_hid intel_ish_ipc && modprobe
> > > intel_ish_ipc
> > >
> > > The hub went away and was re-enumerated fine; ~30 s later CPU0
> > > hard-locked in the still-running xxd
> > > and the hard-lockup detector panicked the machine (log recovered from
> > > EFI pstore).
> > >
> > > Presumably a minimal reproducer is just a blocked reader plus
> > > unbinding the platform device
> > > (echo HID-SENSOR-2000e1.N.auto >
> > > /sys/bus/platform/drivers/hid_sensor_custom/unbind),
> > > but only the module-reload path above was actually tested so far.
> > >
> > > Log (trimmed)
> > > -------------
> > >
> > > [146608.877730] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> > > for response from ISHTP device
> > > [146611.885959] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> > > for response from ISHTP device
> > > [146614.893909] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> > > for response from ISHTP device
> > > [146617.901872] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> > > for response from ISHTP device
> > > [146619.972550] ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}:
> > > [hid-ish]: enum_devices_done OK, num_hid_devices=3D3
> > > [146620.031441] hid-sensor-hub 001F:8087:0AC2.0007: hidraw3: SENSOR
> > > HUB HID v2.00 Device [hid-ishtp 8087:0AC2] on
> > > [146643.503266] iwlwifi 0000:00:14.3: Queue 3 is stuck 46 70
> > > [146648.924391] watchdog: CPU0: Watchdog detected hard LOCKUP on cpu
> > > 0
> > > [146648.924796] CPU: 0 UID: 0 PID: 1316004 Comm: xxd Tainted: G
> > >    O        7.2.8 #1-NixOS PREEMPT(lazy)
> > > [146648.924804] Hardware name: Dell Inc. Latitude 5420/03P5X2, BIOS
> > > 1.49.0 09/01/2025
> > > [146648.924808] RIP: 0010:native_queued_spin_lock_slowpath+0x64/0x2c0
> > > [146648.924851] Call Trace:
> > > [146648.924855]  <TASK>
> > > [146648.924857]  _raw_spin_lock_irqsave+0x3d/0x50
> > > [146648.924872]  finish_wait+0x3b/0x90
> > > [146648.924886]  hid_sensor_custom_read+0x102/0x150
> > > [hid_sensor_custom]
> > > [146648.924901]  vfs_read+0xbf/0x390
> > > [146648.924934]  ksys_read+0xbf/0xf0
> > > [146648.924939]  do_syscall_64+0x134/0x6b0
> > > [146648.925010]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > [146648.925083]  </TASK>
> > > [146648.925086] Kernel panic - not syncing: Hard LOCKUP
> > >
> > > Also attaching a full dmesg log (with only wi-fi noise filtered out).
> > >
> > > Analysis (line numbers as in mainline 73bef5)
> > > ---------------------------------------------
> > >
> > > - hid_sensor_custom_probe() allocates sensor_inst with devm_kzalloc()
> > > (line 980), so it is freed right
> > >   after hid_sensor_custom_remove() returns, regardless of open files.
> > > - The misc device's fops reach sensor_inst through
> > > container_of(file->private_data, ..., custom_dev);
> > >   misc_deregister() does not revoke already-open files, so
> > > read/poll/release keep dereferencing it.
> > > - hid_sensor_custom_dev_if_remove() (lines 751-758) does wake_up(),
> > > misc_deregister(), kfifo_free().
> > >   The woken reader in hid_sensor_custom_read() (line 664) re-
> > > evaluates
> > >   wait_event_interruptible(sensor_inst->wait,
> > > !kfifo_is_empty(&sensor_inst->data_fifo)), finds the fifo
> > >   empty and goes back to sleep on sensor_inst->wait. Nothing tells it
> > > the device is gone.
> > > - Once sensor_inst is freed and reused, the next wakeup of that
> > > reader
> > > runs finish_wait() on the freed
> > >   wait_queue_head: spin_lock_irqsave() on garbage, hard lockup.
> > > hid_sensor_custom_release() similarly
> > >   does clear_bit() on freed sensor_inst->misc_opened when the fd is
> > > finally closed.
> > >
> > > Possible fix direction
> > > ----------------------
> > >
> > > Tie sensor_inst's lifetime to its users rather than to devres, the
> > > way
> > > hidraw handles disconnect:
> > > refcount it (kref: one reference for the device, one per open file;
> > > kfifo_free() and kfree() on the last
> > > put), add a "removed" flag set in remove() before
> > > wake_up_interruptible_all(), include it in the
> > > wait_event condition, and make read()/poll() return -ENODEV /
> > > EPOLLHUP =20
> > > > EPOLLERR once removed. =20
> > >
> > > The same review pointed out two more problems in this teardown path
> > > that a fix would naturally cover:
> > > remove() frees data_fifo before sensor_hub_remove_callback(), so a
> > > sample arriving in between is
> > > kfifo_in()'d into freed memory; and an enabled sensor is never
> > > sensor_hub_device_close()d on remove.
> > >
> > > I can test patches on this machine.
> > >
> > > Thanks,
> > > Semyon Maryasin
> > >
> > > P.S.: sorry for a possible duplicate, I think I messed with the
> > > headers. =20
>=20
>=20
>=20

