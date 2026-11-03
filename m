Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671130;
	b=NAsY99YoFpcfE6xSVWXn6XG1sEBANw5tz1cDjhOBxcblVtR7L7xGxShyD+4feFCXkfzb
	 oj1po0m6nwB2H73Dn892h+MLTr02p+fjSNjDArpbmeJQEFyQ8Ivlo5lNmRQ3+r7ptmj8+
	 F4GaQ7lfFqG9kVv5VEehHJavNdxsksmL7VoMaSVb4X/QXoMNlItN7uxLZXjHxYZWIbcY9
	 UEp/ngkxT1GA9ubknFv0axV94fRIAjYn/1Y3yy+jkcdRXJcvBqQLUEY40X0VG4gR0oEVU
	 j9pB/hFjyrd+v8ADxlS6Qj9T81a6QBDi1E5iOTHigJ9zcYDUiFx3A7Mf/cH6G/KWE2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671130;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=WJC4KoCyioS7zYZsj3QH5TBSWwVCsuUPF09yPAEl9Zc=;
	b=F/wOXsk/7cAenJHEJvFFMXlW5Td3ti6Ok/FVzy7oEYdD0jmEApp4SnkKL3J8t8ZoF46x
	 1IRmAJGdi0cYk0Eb4HY8OM7uHKrzlQ8vwUQB4fcXzGiE2pnBGhH/G8F5Q3K7voZlc5v+9
	 2Y+4SMtSk+GVwhdf4cnbnLHfhlaLWfcEbWw0m4s5VYqZsky7aNPpEtkD+HxBlX01oySOK
	 2ukiPpNIiJ9U5ifdEJOvD2qdtNmFqiZY7S89CMRc8hj3aUt1RvQIXNkRCfU9h4KaxQGri
	 qQk8f/5K7ErJYcJCEjhP9WQoj6ZBdzKsCgdKQGjJC8OJol7m4WR2x8R2+0CkTJ1Yt1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="RZf7/gh3";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD88606A324;
	Tue,  3 Nov 2026 01:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCD88606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RZf7/gh3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793671130; x=1825207130;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WJC4KoCyioS7zYZsj3QH5TBSWwVCsuUPF09yPAEl9Zc=;
  b=RZf7/gh3P8I+MnM5JdBPOpPmSKABWt3x8liOS71i5zjH5fxRh4yq6/eh
   hI1XzIIT7UuZsKF1XUZc1gWAFcEeKNfiqWKgU05eSOGYK+/hwyYCGXkYv
   pO1H0YpgAWLec3QnMdnamCrsEapBpNzV0okCmPeghss7cx3wS7RY0Pzlb
   KfM0xgvbvfcePOlzaWQBLx3fWlG7LYUB36LY4DFKh042arvJkOY1Avpxw
   hqiuVG5ynIlFidz7ak+7/qREBNsdUT10Kb+feHyshPNYqNgez/Mj5k/YP
   Kz1FXCBZSaAWzY/uUPNfQteZJk2nurIOud37k85tgEJXM4gpthDkGu+cZ
   Q==;
X-CSE-ConnectionGUID: qv5SQdi2SdWGyUHKyZ9tkA==
X-CSE-MsgGUID: hgO/fefSRkWDfvDzX/Nh2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2285571"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2285571"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 17:58:50 -0800
X-CSE-ConnectionGUID: 4Jwn+i8FRkmK7d6oxGehLg==
X-CSE-MsgGUID: k0URBF5iRI2Gfil1sLl5pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6609442"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.189]) ([10.125.109.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 17:58:48 -0800
Message-ID: <e222f3c9e69b08908a13c766c87bb58508871cee.camel@linux.intel.com>
Subject: Re: Fwd: [BUG] HID: sensor: custom: use-after-free of sensor_inst
 via open misc device after remove (hard lockup)
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: =?UTF-8?Q?=D0=A1=D0=B5=D0=BC=D1=91=D0=BD_?=
 =?UTF-8?Q?=D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD?=
	 <simeon@maryasin.name>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Benjamin Tissoires
	 <bentiss@kernel.org>, Haoxiang Li <haoxiang_li2024@163.com>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Date: Mon, 02 Nov 2026 17:58:48 -0800
In-Reply-To: <CAM2dg7dDTQDobkOfLt586ex9o+v0eQqGouyYdpG1KPdfD6uwyg@mail.gmail.com>
References: 
	<CAM2dg7eZJEii+fJT1TG8XME-TJFqDtURCsr5XS71E5-5-mUV0A@mail.gmail.com>
	 <CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com>
	 <f3f50abbaea73cb84e43bbf811065b866fc4d7d1.camel@linux.intel.com>
	 <CAM2dg7dDTQDobkOfLt586ex9o+v0eQqGouyYdpG1KPdfD6uwyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

I sent a version as AI review complained about some change. Please try
again. You are CCed in patch.

Thanks,
Srinivas

On Tue, 2026-10-27 at 15:36 +0300, =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=
=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD wrote:
> Hello! Tested this patch (had to adapt it to apply it to 7.2.8
> kernel;
> attaching the adapted version).
>=20
> Without patch: xxd running while intel_ishtp_hid module is removed ->
> xxd hangs, system either crashes or at least logs "hid-sensor-hub
> 001F:8087:0AC2.0004: timeout waiting for response from ISHTP device"
> With patch: xxd correctly closes with message "No such device", no
> error in kernel logs, no crashes =E2=80=94 checked for several times.
>=20
> =D0=BF=D1=82, 23 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 17:12, S=
rinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>:
> >=20
> > Hi,
> > On Fri, 2026-10-23 at 13:42 +0300, =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=
=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD wrote:
> > > Hello,
> > >=20
> > > hid-sensor-custom frees its per-sensor state (sensor_inst,
> > > devm-allocated) on remove while userspace
> > > can still hold the misc device /dev/HID-SENSOR-2000e1.N.auto
> > > open. A
> > > reader blocked in read() stays
> > > queued on sensor_inst->wait in freed memory; when it wakes up,
> > > finish_wait() spins on a garbage
> > > wait-queue lock with interrupts disabled and the machine hard-
> > > locks.
> > > Any read()/poll()/release() on such
> > > an fd after remove is a use-after-free as well.
> > >=20
> >=20
> > Please give a try with the attached diff.
> >=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> >=20
> > > The Sashiko AI review already flagged this as a pre-existing
> > > issue
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
> > >=20
> > > Kernel: 7.2.8 (NixOS; drivers/hid/hid-sensor-custom.c is
> > > identical to
> > > current mainline,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 including ad8fb82b0442 and=
 3789d0802ddb)
> > > Hardware: Dell Latitude 5420 (Tiger Lake, Intel ISH), BIOS
> > > 1.49.0;
> > > Dell's vendor ISH sensors appear as
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID-SENSOR-200=
0e1.N.auto (e.g. an ST VL53L1 time-of-
> > > flight
> > > sensor).
> > > Taint: O, from unrelated out-of-tree WWAN modules (qcserial,
> > > usb_wwan).
> > >=20
> > > How it was hit
> > > --------------
> > >=20
> > > 1. echo 1 > /sys/bus/platform/devices/HID-SENSOR-
> > > 2000e1.2.auto/enable_sensor
> > > 2. xxd /dev/HID-SENSOR-2000e1.2.auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # streaming reader,
> > > left
> > > running
> > > 3. modprobe -r intel_ishtp_hid intel_ish_ipc && modprobe
> > > intel_ish_ipc
> > >=20
> > > The hub went away and was re-enumerated fine; ~30 s later CPU0
> > > hard-locked in the still-running xxd
> > > and the hard-lockup detector panicked the machine (log recovered
> > > from
> > > EFI pstore).
> > >=20
> > > Presumably a minimal reproducer is just a blocked reader plus
> > > unbinding the platform device
> > > (echo HID-SENSOR-2000e1.N.auto >
> > > /sys/bus/platform/drivers/hid_sensor_custom/unbind),
> > > but only the module-reload path above was actually tested so far.
> > >=20
> > > Log (trimmed)
> > > -------------
> > >=20
> > > [146608.877730] hid-sensor-hub 001F:8087:0AC2.0003: timeout
> > > waiting
> > > for response from ISHTP device
> > > [146611.885959] hid-sensor-hub 001F:8087:0AC2.0003: timeout
> > > waiting
> > > for response from ISHTP device
> > > [146614.893909] hid-sensor-hub 001F:8087:0AC2.0003: timeout
> > > waiting
> > > for response from ISHTP device
> > > [146617.901872] hid-sensor-hub 001F:8087:0AC2.0003: timeout
> > > waiting
> > > for response from ISHTP device
> > > [146619.972550] ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}:
> > > [hid-ish]: enum_devices_done OK, num_hid_devices=3D3
> > > [146620.031441] hid-sensor-hub 001F:8087:0AC2.0007: hidraw3:
> > > SENSOR
> > > HUB HID v2.00 Device [hid-ishtp 8087:0AC2] on
> > > [146643.503266] iwlwifi 0000:00:14.3: Queue 3 is stuck 46 70
> > > [146648.924391] watchdog: CPU0: Watchdog detected hard LOCKUP on
> > > cpu
> > > 0
> > > [146648.924796] CPU: 0 UID: 0 PID: 1316004 Comm: xxd Tainted: G
> > > =C2=A0=C2=A0 O=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.2.8 #1-Nix=
OS PREEMPT(lazy)
> > > [146648.924804] Hardware name: Dell Inc. Latitude 5420/03P5X2,
> > > BIOS
> > > 1.49.0 09/01/2025
> > > [146648.924808] RIP:
> > > 0010:native_queued_spin_lock_slowpath+0x64/0x2c0
> > > [146648.924851] Call Trace:
> > > [146648.924855]=C2=A0 <TASK>
> > > [146648.924857]=C2=A0 _raw_spin_lock_irqsave+0x3d/0x50
> > > [146648.924872]=C2=A0 finish_wait+0x3b/0x90
> > > [146648.924886]=C2=A0 hid_sensor_custom_read+0x102/0x150
> > > [hid_sensor_custom]
> > > [146648.924901]=C2=A0 vfs_read+0xbf/0x390
> > > [146648.924934]=C2=A0 ksys_read+0xbf/0xf0
> > > [146648.924939]=C2=A0 do_syscall_64+0x134/0x6b0
> > > [146648.925010]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > [146648.925083]=C2=A0 </TASK>
> > > [146648.925086] Kernel panic - not syncing: Hard LOCKUP
> > >=20
> > > Also attaching a full dmesg log (with only wi-fi noise filtered
> > > out).
> > >=20
> > > Analysis (line numbers as in mainline 73bef5)
> > > ---------------------------------------------
> > >=20
> > > - hid_sensor_custom_probe() allocates sensor_inst with
> > > devm_kzalloc()
> > > (line 980), so it is freed right
> > > =C2=A0 after hid_sensor_custom_remove() returns, regardless of open
> > > files.
> > > - The misc device's fops reach sensor_inst through
> > > container_of(file->private_data, ..., custom_dev);
> > > =C2=A0 misc_deregister() does not revoke already-open files, so
> > > read/poll/release keep dereferencing it.
> > > - hid_sensor_custom_dev_if_remove() (lines 751-758) does
> > > wake_up(),
> > > misc_deregister(), kfifo_free().
> > > =C2=A0 The woken reader in hid_sensor_custom_read() (line 664) re-
> > > evaluates
> > > =C2=A0 wait_event_interruptible(sensor_inst->wait,
> > > !kfifo_is_empty(&sensor_inst->data_fifo)), finds the fifo
> > > =C2=A0 empty and goes back to sleep on sensor_inst->wait. Nothing
> > > tells it
> > > the device is gone.
> > > - Once sensor_inst is freed and reused, the next wakeup of that
> > > reader
> > > runs finish_wait() on the freed
> > > =C2=A0 wait_queue_head: spin_lock_irqsave() on garbage, hard lockup.
> > > hid_sensor_custom_release() similarly
> > > =C2=A0 does clear_bit() on freed sensor_inst->misc_opened when the fd
> > > is
> > > finally closed.
> > >=20
> > > Possible fix direction
> > > ----------------------
> > >=20
> > > Tie sensor_inst's lifetime to its users rather than to devres,
> > > the
> > > way
> > > hidraw handles disconnect:
> > > refcount it (kref: one reference for the device, one per open
> > > file;
> > > kfifo_free() and kfree() on the last
> > > put), add a "removed" flag set in remove() before
> > > wake_up_interruptible_all(), include it in the
> > > wait_event condition, and make read()/poll() return -ENODEV /
> > > EPOLLHUP
> > > > EPOLLERR once removed.
> > >=20
> > > The same review pointed out two more problems in this teardown
> > > path
> > > that a fix would naturally cover:
> > > remove() frees data_fifo before sensor_hub_remove_callback(), so
> > > a
> > > sample arriving in between is
> > > kfifo_in()'d into freed memory; and an enabled sensor is never
> > > sensor_hub_device_close()d on remove.
> > >=20
> > > I can test patches on this machine.
> > >=20
> > > Thanks,
> > > Semyon Maryasin
> > >=20
> > > P.S.: sorry for a possible duplicate, I think I messed with the
> > > headers.
>=20
>=20
