Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764770;
	b=gpzrpNrKof0o5JwF7kJNinU6ia1x+DwPQqWfLv++THnLdCwMd7mjK9ceOiFcEpR3/iK0
	 wBBxheveeJAID3hpmKx4f+iAyAA9JRQLY5z3wPw0JSHpy1WsojaJTjjeS2KowFu7xl/MT
	 BiMLuMezUIbG7ma9U69BicwWDterohgKFdt59qjGGYbkLNWr/y+hj5BGKMAHOTfO0YRjx
	 D+m2f4c52mb5gX8RUQmuWn6UTLwkcvvyyiODy+du97s18Edr+aL5F1HhD/X8XYeIH9URm
	 tJdFfFGHAHFD9u+S3jfzZ2SXLga9p/XapZ8f+536Z6Sfg0rVNca95hz3AhF7JbmcjTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764770;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:User-Agent:
	 MIME-Version;
	bh=auys8Xbssid4AaWp1O+JJ93D4Lnm3FMqZdCN61xvhnc=;
	b=tkKm7CBSzgUw6OSjmcvydfNEBX3O342bj1LDRTJq3G2oM8NGlbIFOuEfMmCHos1AdGES
	 8CGed98gtFfdt2EQ7yE+Wsl44/n4ssgbbRBJahP60H11rCaKPhUjEq+aX8N226SMkQxyU
	 fHvAdGgiX7p7yEF8q2YKM0UtO/xutZ7plBgTeeDUBzKPfq5SWWGLusZekTrbUsFgwdJ+x
	 x4v6PHgMP4upwgiB6PeN/CUSFTa82bLMtDt8k8ig7srFRuxDbtG9LvX7jffAB6ssVeJv4
	 WSNcLKB8Rhw2g9ZW+hPQIMYs6K55BMNVUQoGFs3OaREOShCyRZvoCJPDcvrzKoMs7NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=boXNl9Zb;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B6606A31B;
	Fri, 23 Oct 2026 14:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A3B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=boXNl9Zb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792764770; x=1824300770;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=auys8Xbssid4AaWp1O+JJ93D4Lnm3FMqZdCN61xvhnc=;
  b=boXNl9Zb0XERlCyut8BMr114xRYgc5LJP9mLl1WpI/YCaJUdRa4kdpV6
   bbjQ0W1FSUhUXBmUiNJN2HIVihkCXRPzQZGGZSyOaY6fksmv40gQSGtw9
   Nta7lPlsBw1QYFOMF0E7dbnvCbUYL5ACnKeixp2/jyhnROiYQ5RL4Yry9
   F91w6/rtg/afhSkVr68UjNBo1c4veg9Zu3mOilrZCea2aqskUflCzrBEW
   BsH/PBGJjqiFO6OrM1t1D+LJTYu/J47R6Jt2wRArlNA2a0Ivhva9Xhkc1
   6LbfmK5L5b5XP9rybOZOEjRHVsFGBwgZR2EloAd1xs1ffDlXF0d3BJcD9
   w==;
X-CSE-ConnectionGUID: ZX6licLHQSaKqW/ILvIxQQ==
X-CSE-MsgGUID: z6HNmA+nQfCYvw2s7Q1bKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1540032"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="diff'?scan'208";a="1540032"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 07:12:50 -0700
X-CSE-ConnectionGUID: BnRemv/gQ0qSzcrDMVaTqQ==
X-CSE-MsgGUID: MAX4YASmSpSEXtHU4MUUcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="diff'?scan'208";a="3592778"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.221.86]) ([10.124.221.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 07:12:49 -0700
Message-ID: <f3f50abbaea73cb84e43bbf811065b866fc4d7d1.camel@linux.intel.com>
Subject: Re: Fwd: [BUG] HID: sensor: custom: use-after-free of sensor_inst
 via open misc device after remove (hard lockup)
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: =?UTF-8?Q?=D0=A1=D0=B5=D0=BC=D1=91=D0=BD_?=
 =?UTF-8?Q?=D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD?=
	 <simeon@maryasin.name>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Haoxiang Li
	 <haoxiang_li2024@163.com>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Fri, 23 Oct 2026 07:12:47 -0700
In-Reply-To: <CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com>
References: 
	<CAM2dg7eZJEii+fJT1TG8XME-TJFqDtURCsr5XS71E5-5-mUV0A@mail.gmail.com>
	 <CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=eUdbPthG2xrLqwQQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-uWxHwhaJA+w2d1CJPvLu"
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

--=-uWxHwhaJA+w2d1CJPvLu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
On Fri, 2026-10-23 at 13:42 +0300, =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=
=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD wrote:
> Hello,
>=20
> hid-sensor-custom frees its per-sensor state (sensor_inst,
> devm-allocated) on remove while userspace
> can still hold the misc device /dev/HID-SENSOR-2000e1.N.auto open. A
> reader blocked in read() stays
> queued on sensor_inst->wait in freed memory; when it wakes up,
> finish_wait() spins on a garbage
> wait-queue lock with interrupts disabled and the machine hard-locks.
> Any read()/poll()/release() on such
> an fd after remove is a use-after-free as well.
>=20

Please give a try with the attached diff.


Thanks,
Srinivas


> The Sashiko AI review already flagged this as a pre-existing issue
> on Haoxiang Li's "Fix fields lifetime issues" series
> ("The /dev/HID-SENSOR-* character device operations do not
> synchronize
> with device
> removal,
> leading to Use-After-Free on devm-managed structures"):
> https://lore.kernel.org/linux-input/20260707071545.3087073-1-haoxiang_li2=
024@163.com/
> The applied patches don't touch it, and the current mainline is
> unchanged. Below is a real-world hit.
>=20
> Kernel: 7.2.8 (NixOS; drivers/hid/hid-sensor-custom.c is identical to
> current mainline,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 including ad8fb82b0442 and 378=
9d0802ddb)
> Hardware: Dell Latitude 5420 (Tiger Lake, Intel ISH), BIOS 1.49.0;
> Dell's vendor ISH sensors appear as
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HID-SENSOR-2000e1.=
N.auto (e.g. an ST VL53L1 time-of-flight
> sensor).
> Taint: O, from unrelated out-of-tree WWAN modules (qcserial,
> usb_wwan).
>=20
> How it was hit
> --------------
>=20
> 1. echo 1 > /sys/bus/platform/devices/HID-SENSOR-
> 2000e1.2.auto/enable_sensor
> 2. xxd /dev/HID-SENSOR-2000e1.2.auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 # streaming reader, left
> running
> 3. modprobe -r intel_ishtp_hid intel_ish_ipc && modprobe
> intel_ish_ipc
>=20
> The hub went away and was re-enumerated fine; ~30 s later CPU0
> hard-locked in the still-running xxd
> and the hard-lockup detector panicked the machine (log recovered from
> EFI pstore).
>=20
> Presumably a minimal reproducer is just a blocked reader plus
> unbinding the platform device
> (echo HID-SENSOR-2000e1.N.auto >
> /sys/bus/platform/drivers/hid_sensor_custom/unbind),
> but only the module-reload path above was actually tested so far.
>=20
> Log (trimmed)
> -------------
>=20
> [146608.877730] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> for response from ISHTP device
> [146611.885959] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> for response from ISHTP device
> [146614.893909] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> for response from ISHTP device
> [146617.901872] hid-sensor-hub 001F:8087:0AC2.0003: timeout waiting
> for response from ISHTP device
> [146619.972550] ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}:
> [hid-ish]: enum_devices_done OK, num_hid_devices=3D3
> [146620.031441] hid-sensor-hub 001F:8087:0AC2.0007: hidraw3: SENSOR
> HUB HID v2.00 Device [hid-ishtp 8087:0AC2] on
> [146643.503266] iwlwifi 0000:00:14.3: Queue 3 is stuck 46 70
> [146648.924391] watchdog: CPU0: Watchdog detected hard LOCKUP on cpu
> 0
> [146648.924796] CPU: 0 UID: 0 PID: 1316004 Comm: xxd Tainted: G
> =C2=A0=C2=A0 O=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.2.8 #1-NixOS P=
REEMPT(lazy)
> [146648.924804] Hardware name: Dell Inc. Latitude 5420/03P5X2, BIOS
> 1.49.0 09/01/2025
> [146648.924808] RIP: 0010:native_queued_spin_lock_slowpath+0x64/0x2c0
> [146648.924851] Call Trace:
> [146648.924855]=C2=A0 <TASK>
> [146648.924857]=C2=A0 _raw_spin_lock_irqsave+0x3d/0x50
> [146648.924872]=C2=A0 finish_wait+0x3b/0x90
> [146648.924886]=C2=A0 hid_sensor_custom_read+0x102/0x150
> [hid_sensor_custom]
> [146648.924901]=C2=A0 vfs_read+0xbf/0x390
> [146648.924934]=C2=A0 ksys_read+0xbf/0xf0
> [146648.924939]=C2=A0 do_syscall_64+0x134/0x6b0
> [146648.925010]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [146648.925083]=C2=A0 </TASK>
> [146648.925086] Kernel panic - not syncing: Hard LOCKUP
>=20
> Also attaching a full dmesg log (with only wi-fi noise filtered out).
>=20
> Analysis (line numbers as in mainline 73bef5)
> ---------------------------------------------
>=20
> - hid_sensor_custom_probe() allocates sensor_inst with devm_kzalloc()
> (line 980), so it is freed right
> =C2=A0 after hid_sensor_custom_remove() returns, regardless of open files=
.
> - The misc device's fops reach sensor_inst through
> container_of(file->private_data, ..., custom_dev);
> =C2=A0 misc_deregister() does not revoke already-open files, so
> read/poll/release keep dereferencing it.
> - hid_sensor_custom_dev_if_remove() (lines 751-758) does wake_up(),
> misc_deregister(), kfifo_free().
> =C2=A0 The woken reader in hid_sensor_custom_read() (line 664) re-
> evaluates
> =C2=A0 wait_event_interruptible(sensor_inst->wait,
> !kfifo_is_empty(&sensor_inst->data_fifo)), finds the fifo
> =C2=A0 empty and goes back to sleep on sensor_inst->wait. Nothing tells i=
t
> the device is gone.
> - Once sensor_inst is freed and reused, the next wakeup of that
> reader
> runs finish_wait() on the freed
> =C2=A0 wait_queue_head: spin_lock_irqsave() on garbage, hard lockup.
> hid_sensor_custom_release() similarly
> =C2=A0 does clear_bit() on freed sensor_inst->misc_opened when the fd is
> finally closed.
>=20
> Possible fix direction
> ----------------------
>=20
> Tie sensor_inst's lifetime to its users rather than to devres, the
> way
> hidraw handles disconnect:
> refcount it (kref: one reference for the device, one per open file;
> kfifo_free() and kfree() on the last
> put), add a "removed" flag set in remove() before
> wake_up_interruptible_all(), include it in the
> wait_event condition, and make read()/poll() return -ENODEV /
> EPOLLHUP
> > EPOLLERR once removed.
>=20
> The same review pointed out two more problems in this teardown path
> that a fix would naturally cover:
> remove() frees data_fifo before sensor_hub_remove_callback(), so a
> sample arriving in between is
> kfifo_in()'d into freed memory; and an enabled sensor is never
> sensor_hub_device_close()d on remove.
>=20
> I can test patches on this machine.
>=20
> Thanks,
> Semyon Maryasin
>=20
> P.S.: sorry for a possible duplicate, I think I messed with the
> headers.

--=-uWxHwhaJA+w2d1CJPvLu
Content-Disposition: attachment; filename="test_patch.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="test_patch.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMgYi9kcml2ZXJzL2hp
ZC9oaWQtc2Vuc29yLWN1c3RvbS5jCmluZGV4IGFmZmZlYTg5NDAyMS4uYzEyNDE3Y2RkYWI0IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jCisrKyBiL2RyaXZlcnMv
aGlkL2hpZC1zZW5zb3ItY3VzdG9tLmMKQEAgLTExLDYgKzExLDcgQEAKICNpbmNsdWRlIDxsaW51
eC9pbml0Lmg+CiAjaW5jbHVkZSA8bGludXgvbWlzY2RldmljZS5oPgogI2luY2x1ZGUgPGxpbnV4
L2tmaWZvLmg+CisjaW5jbHVkZSA8bGludXgva3JlZi5oPgogI2luY2x1ZGUgPGxpbnV4L3NjaGVk
Lmg+CiAjaW5jbHVkZSA8bGludXgvd2FpdC5oPgogI2luY2x1ZGUgPGxpbnV4L3BvbGwuaD4KQEAg
LTM3LDYgKzM4LDggQEAgc3RydWN0IGhpZF9zZW5zb3JfY3VzdG9tX2ZpZWxkIHsKIAogc3RydWN0
IGhpZF9zZW5zb3JfY3VzdG9tIHsKIAlzdHJ1Y3QgbXV0ZXggbXV0ZXg7CisJc3RydWN0IGtyZWYg
cmVmOworCWJvb2wgcmVtb3ZlZDsKIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2OwogCXN0
cnVjdCBoaWRfc2Vuc29yX2h1Yl9kZXZpY2UgKmhzZGV2OwogCXN0cnVjdCBoaWRfc2Vuc29yX2h1
Yl9jYWxsYmFja3MgY2FsbGJhY2tzOwpAQCAtNjM2LDYgKzYzOSwxNSBAQCBzdGF0aWMgdm9pZCBo
aWRfc2Vuc29yX2N1c3RvbV9yZW1vdmVfYXR0cmlidXRlcyhzdHJ1Y3QgaGlkX3NlbnNvcl9jdXN0
b20gKgogCWtmcmVlKHNlbnNvcl9pbnN0LT5maWVsZHMpOwogfQogCitzdGF0aWMgdm9pZCBoaWRf
c2Vuc29yX2N1c3RvbV9mcmVlKHN0cnVjdCBrcmVmICpyZWYpCit7CisJc3RydWN0IGhpZF9zZW5z
b3JfY3VzdG9tICpzZW5zb3JfaW5zdCA9CisJCWNvbnRhaW5lcl9vZihyZWYsIHN0cnVjdCBoaWRf
c2Vuc29yX2N1c3RvbSwgcmVmKTsKKworCWtmaWZvX2ZyZWUoJnNlbnNvcl9pbnN0LT5kYXRhX2Zp
Zm8pOworCWtmcmVlKHNlbnNvcl9pbnN0KTsKK30KKwogc3RhdGljIHNzaXplX3QgaGlkX3NlbnNv
cl9jdXN0b21fcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAkJCQkg
ICAgICBzaXplX3QgY291bnQsIGxvZmZfdCAqZl9wcykKIHsKQEAgLTY0OSwyMiArNjYxLDM1IEBA
IHN0YXRpYyBzc2l6ZV90IGhpZF9zZW5zb3JfY3VzdG9tX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUs
IGNoYXIgX191c2VyICpidWYsCiAJaWYgKGNvdW50IDwgc2l6ZW9mKHN0cnVjdCBoaWRfc2Vuc29y
X3NhbXBsZSkpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JZG8gewotCQlpZiAoa2ZpZm9faXNfZW1w
dHkoJnNlbnNvcl9pbnN0LT5kYXRhX2ZpZm8pKSB7Ci0JCQlpZiAoZmlsZS0+Zl9mbGFncyAmIE9f
Tk9OQkxPQ0spCi0JCQkJcmV0dXJuIC1FQUdBSU47CisJZm9yICg7OykgeworCQlyZXQgPSBtdXRl
eF9sb2NrX2ludGVycnVwdGlibGUoJnNlbnNvcl9pbnN0LT5tdXRleCk7CisJCWlmIChyZXQpCisJ
CQlyZXR1cm4gcmV0OwogCi0JCQlyZXQgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoc2Vuc29y
X2luc3QtPndhaXQsCi0JCQkJIWtmaWZvX2lzX2VtcHR5KCZzZW5zb3JfaW5zdC0+ZGF0YV9maWZv
KSk7Ci0JCQlpZiAocmV0KQotCQkJCXJldHVybiByZXQ7CisJCWlmIChzZW5zb3JfaW5zdC0+cmVt
b3ZlZCkgeworCQkJcmV0ID0gLUVOT0RFVjsKKwkJCWdvdG8gdW5sb2NrOwogCQl9CiAJCXJldCA9
IGtmaWZvX3RvX3VzZXIoJnNlbnNvcl9pbnN0LT5kYXRhX2ZpZm8sIGJ1ZiwgY291bnQsCiAJCQkJ
ICAgICZjb3BpZWQpOworCQlpZiAocmV0IHx8IGNvcGllZCkKKwkJCWdvdG8gdW5sb2NrOworCQlt
dXRleF91bmxvY2soJnNlbnNvcl9pbnN0LT5tdXRleCk7CisKKwkJaWYgKGZpbGUtPmZfZmxhZ3Mg
JiBPX05PTkJMT0NLKQorCQkJcmV0dXJuIC1FQUdBSU47CisKKwkJcmV0ID0gd2FpdF9ldmVudF9p
bnRlcnJ1cHRpYmxlKHNlbnNvcl9pbnN0LT53YWl0LAorCQkJUkVBRF9PTkNFKHNlbnNvcl9pbnN0
LT5yZW1vdmVkKSB8fAorCQkJIWtmaWZvX2lzX2VtcHR5KCZzZW5zb3JfaW5zdC0+ZGF0YV9maWZv
KSk7CiAJCWlmIChyZXQpCiAJCQlyZXR1cm4gcmV0OworCX0KIAotCX0gd2hpbGUgKGNvcGllZCA9
PSAwKTsKK3VubG9jazoKKwltdXRleF91bmxvY2soJnNlbnNvcl9pbnN0LT5tdXRleCk7CisJaWYg
KHJldCkKKwkJcmV0dXJuIHJldDsKIAogCXJldHVybiBjb3BpZWQ7CiB9CkBAIC02NzcsNiArNzAy
LDcgQEAgc3RhdGljIGludCBoaWRfc2Vuc29yX2N1c3RvbV9yZWxlYXNlKHN0cnVjdCBpbm9kZSAq
aW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQogCQkJCSAgIHN0cnVjdCBoaWRfc2Vuc29yX2N1c3Rv
bSwgY3VzdG9tX2Rldik7CiAKIAljbGVhcl9iaXQoMCwgJnNlbnNvcl9pbnN0LT5taXNjX29wZW5l
ZCk7CisJa3JlZl9wdXQoJnNlbnNvcl9pbnN0LT5yZWYsIGhpZF9zZW5zb3JfY3VzdG9tX2ZyZWUp
OwogCiAJcmV0dXJuIDA7CiB9CkBAIC02ODQsMTQgKzcxMCwyMiBAQCBzdGF0aWMgaW50IGhpZF9z
ZW5zb3JfY3VzdG9tX3JlbGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZp
bGUpCiBzdGF0aWMgaW50IGhpZF9zZW5zb3JfY3VzdG9tX29wZW4oc3RydWN0IGlub2RlICppbm9k
ZSwgc3RydWN0IGZpbGUgKmZpbGUpCiB7CiAJc3RydWN0IGhpZF9zZW5zb3JfY3VzdG9tICpzZW5z
b3JfaW5zdDsKKwlpbnQgcmV0OwogCiAJc2Vuc29yX2luc3QgPSBjb250YWluZXJfb2YoZmlsZS0+
cHJpdmF0ZV9kYXRhLAogCQkJCSAgIHN0cnVjdCBoaWRfc2Vuc29yX2N1c3RvbSwgY3VzdG9tX2Rl
dik7Ci0JLyogV2UgZXNzZW50aWFsbHkgaGF2ZSBzaW5nbGUgcmVhZGVyIGFuZCB3cml0ZXIgKi8K
LQlpZiAodGVzdF9hbmRfc2V0X2JpdCgwLCAmc2Vuc29yX2luc3QtPm1pc2Nfb3BlbmVkKSkKLQkJ
cmV0dXJuIC1FQlVTWTsKKwltdXRleF9sb2NrKCZzZW5zb3JfaW5zdC0+bXV0ZXgpOworCWlmIChz
ZW5zb3JfaW5zdC0+cmVtb3ZlZCkgeworCQlyZXQgPSAtRU5PREVWOworCX0gZWxzZSBpZiAodGVz
dF9hbmRfc2V0X2JpdCgwLCAmc2Vuc29yX2luc3QtPm1pc2Nfb3BlbmVkKSkgeworCQlyZXQgPSAt
RUJVU1k7CisJfSBlbHNlIHsKKwkJa3JlZl9nZXQoJnNlbnNvcl9pbnN0LT5yZWYpOworCQlyZXQg
PSBzdHJlYW1fb3Blbihpbm9kZSwgZmlsZSk7CisJfQorCW11dGV4X3VubG9jaygmc2Vuc29yX2lu
c3QtPm11dGV4KTsKIAotCXJldHVybiBzdHJlYW1fb3Blbihpbm9kZSwgZmlsZSk7CisJcmV0dXJu
IHJldDsKIH0KIAogc3RhdGljIF9fcG9sbF90IGhpZF9zZW5zb3JfY3VzdG9tX3BvbGwoc3RydWN0
IGZpbGUgKmZpbGUsCkBAIC03MDUsNiArNzM5LDkgQEAgc3RhdGljIF9fcG9sbF90IGhpZF9zZW5z
b3JfY3VzdG9tX3BvbGwoc3RydWN0IGZpbGUgKmZpbGUsCiAKIAlwb2xsX3dhaXQoZmlsZSwgJnNl
bnNvcl9pbnN0LT53YWl0LCB3YWl0KTsKIAorCWlmIChSRUFEX09OQ0Uoc2Vuc29yX2luc3QtPnJl
bW92ZWQpKQorCQlyZXR1cm4gRVBPTExIVVAgfCBFUE9MTEVSUjsKKwogCWlmICgha2ZpZm9faXNf
ZW1wdHkoJnNlbnNvcl9pbnN0LT5kYXRhX2ZpZm8pKQogCQltYXNrID0gRVBPTExJTiB8IEVQT0xM
UkROT1JNOwogCkBAIC03MTIsNiArNzQ5LDcgQEAgc3RhdGljIF9fcG9sbF90IGhpZF9zZW5zb3Jf
Y3VzdG9tX3BvbGwoc3RydWN0IGZpbGUgKmZpbGUsCiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZmlsZV9vcGVyYXRpb25zIGhpZF9zZW5zb3JfY3VzdG9tX2ZvcHMgPSB7CisJLm93bmVyID0gVEhJ
U19NT0RVTEUsCiAJLm9wZW4gPSAgaGlkX3NlbnNvcl9jdXN0b21fb3BlbiwKIAkucmVhZCA9ICBo
aWRfc2Vuc29yX2N1c3RvbV9yZWFkLAogCS5yZWxlYXNlID0gaGlkX3NlbnNvcl9jdXN0b21fcmVs
ZWFzZSwKQEAgLTczNCwyMCArNzcyLDE3IEBAIHN0YXRpYyBpbnQgaGlkX3NlbnNvcl9jdXN0b21f
ZGV2X2lmX2FkZChzdHJ1Y3QgaGlkX3NlbnNvcl9jdXN0b20gKnNlbnNvcl9pbnN0KQogCXNlbnNv
cl9pbnN0LT5jdXN0b21fZGV2Lm5hbWUgPSBkZXZfbmFtZSgmc2Vuc29yX2luc3QtPnBkZXYtPmRl
dik7CiAJc2Vuc29yX2luc3QtPmN1c3RvbV9kZXYuZm9wcyA9ICZoaWRfc2Vuc29yX2N1c3RvbV9m
b3BzOwogCXJldCA9IG1pc2NfcmVnaXN0ZXIoJnNlbnNvcl9pbnN0LT5jdXN0b21fZGV2KTsKLQlp
ZiAocmV0KSB7Ci0JCWtmaWZvX2ZyZWUoJnNlbnNvcl9pbnN0LT5kYXRhX2ZpZm8pOwotCQlyZXR1
cm4gcmV0OwotCX0KLQlyZXR1cm4gMDsKKwlyZXR1cm4gcmV0OwogfQogCiBzdGF0aWMgdm9pZCBo
aWRfc2Vuc29yX2N1c3RvbV9kZXZfaWZfcmVtb3ZlKHN0cnVjdCBoaWRfc2Vuc29yX2N1c3RvbQog
CQkJCQkJCQkqc2Vuc29yX2luc3QpCiB7Ci0Jd2FrZV91cCgmc2Vuc29yX2luc3QtPndhaXQpOwor
CW11dGV4X2xvY2soJnNlbnNvcl9pbnN0LT5tdXRleCk7CisJV1JJVEVfT05DRShzZW5zb3JfaW5z
dC0+cmVtb3ZlZCwgdHJ1ZSk7CisJbXV0ZXhfdW5sb2NrKCZzZW5zb3JfaW5zdC0+bXV0ZXgpOwor
CXdha2VfdXBfaW50ZXJydXB0aWJsZV9hbGwoJnNlbnNvcl9pbnN0LT53YWl0KTsKIAltaXNjX2Rl
cmVnaXN0ZXIoJnNlbnNvcl9pbnN0LT5jdXN0b21fZGV2KTsKLQlrZmlmb19mcmVlKCZzZW5zb3Jf
aW5zdC0+ZGF0YV9maWZvKTsKLQogfQogCiAvKgpAQCAtOTcwLDggKzEwMDUsNyBAQCBzdGF0aWMg
aW50IGhpZF9zZW5zb3JfY3VzdG9tX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
CiAJaW50IHJldDsKIAljb25zdCBzdHJ1Y3QgaGlkX3NlbnNvcl9jdXN0b21fbWF0Y2ggKm1hdGNo
OwogCi0Jc2Vuc29yX2luc3QgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpzZW5z
b3JfaW5zdCksCi0JCQkJICAgR0ZQX0tFUk5FTCk7CisJc2Vuc29yX2luc3QgPSBremFsbG9jX29i
aigqc2Vuc29yX2luc3QpOwogCWlmICghc2Vuc29yX2luc3QpCiAJCXJldHVybiAtRU5PTUVNOwog
CkBAIC05ODEsNiArMTAxNSw3IEBAIHN0YXRpYyBpbnQgaGlkX3NlbnNvcl9jdXN0b21fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlzZW5zb3JfaW5zdC0+aHNkZXYgPSBoc2Rl
djsKIAlzZW5zb3JfaW5zdC0+cGRldiA9IHBkZXY7CiAJbXV0ZXhfaW5pdCgmc2Vuc29yX2luc3Qt
Pm11dGV4KTsKKwlrcmVmX2luaXQoJnNlbnNvcl9pbnN0LT5yZWYpOwogCXBsYXRmb3JtX3NldF9k
cnZkYXRhKHBkZXYsIHNlbnNvcl9pbnN0KTsKIAogCXJldCA9IGhpZF9zZW5zb3JfY3VzdG9tX2dl
dF9rbm93bihoc2RldiwgJm1hdGNoKTsKQEAgLTk5Miw3ICsxMDI3LDcgQEAgc3RhdGljIGludCBo
aWRfc2Vuc29yX2N1c3RvbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlp
ZiAocmV0KSB7CiAJCQlkZXZfZXJyKCZwZGV2LT5kZXYsCiAJCQkJInJlZ2lzdGVyX3BsYXRmb3Jt
X2RldmljZSBmYWlsZWRcbiIpOwotCQkJcmV0dXJuIHJldDsKKwkJCWdvdG8gZXJyX2ZyZWU7CiAJ
CX0KIAogCQlyZXR1cm4gMDsKQEAgLTEwMDIsNyArMTAzNyw3IEBAIHN0YXRpYyBpbnQgaGlkX3Nl
bnNvcl9jdXN0b21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJCQkJICAg
JnNlbnNvcl9pbnN0LT5jYWxsYmFja3MpOwogCWlmIChyZXQgPCAwKSB7CiAJCWRldl9lcnIoJnBk
ZXYtPmRldiwgImNhbGxiYWNrIHJlZyBmYWlsZWRcbiIpOwotCQlyZXR1cm4gcmV0OworCQlnb3Rv
IGVycl9mcmVlOwogCX0KIAogCXJldCA9IHN5c2ZzX2NyZWF0ZV9ncm91cCgmc2Vuc29yX2luc3Qt
PnBkZXYtPmRldi5rb2JqLApAQCAtMTAyNyw2ICsxMDYyLDggQEAgc3RhdGljIGludCBoaWRfc2Vu
c29yX2N1c3RvbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQkJICAgJmVu
YWJsZV9zZW5zb3JfYXR0cl9ncm91cCk7CiBlcnJfcmVtb3ZlX2NhbGxiYWNrOgogCXNlbnNvcl9o
dWJfcmVtb3ZlX2NhbGxiYWNrKGhzZGV2LCBoc2Rldi0+dXNhZ2UpOworZXJyX2ZyZWU6CisJa3Jl
Zl9wdXQoJnNlbnNvcl9pbnN0LT5yZWYsIGhpZF9zZW5zb3JfY3VzdG9tX2ZyZWUpOwogCiAJcmV0
dXJuIHJldDsKIH0KQEAgLTEwMzgsMTQgKzEwNzUsMTggQEAgc3RhdGljIHZvaWQgaGlkX3NlbnNv
cl9jdXN0b21fcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAKIAlpZiAoc2Vu
c29yX2luc3QtPmN1c3RvbV9wZGV2KSB7CiAJCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKHNl
bnNvcl9pbnN0LT5jdXN0b21fcGRldik7Ci0JCXJldHVybjsKKwkJZ290byBvdXQ7CiAJfQogCiAJ
aGlkX3NlbnNvcl9jdXN0b21fZGV2X2lmX3JlbW92ZShzZW5zb3JfaW5zdCk7CiAJaGlkX3NlbnNv
cl9jdXN0b21fcmVtb3ZlX2F0dHJpYnV0ZXMoc2Vuc29yX2luc3QpOwogCXN5c2ZzX3JlbW92ZV9n
cm91cCgmc2Vuc29yX2luc3QtPnBkZXYtPmRldi5rb2JqLAogCQkJICAgJmVuYWJsZV9zZW5zb3Jf
YXR0cl9ncm91cCk7CisJaWYgKHNlbnNvcl9pbnN0LT5lbmFibGUpCisJCXNlbnNvcl9odWJfZGV2
aWNlX2Nsb3NlKGhzZGV2KTsKIAlzZW5zb3JfaHViX3JlbW92ZV9jYWxsYmFjayhoc2RldiwgaHNk
ZXYtPnVzYWdlKTsKK291dDoKKwlrcmVmX3B1dCgmc2Vuc29yX2luc3QtPnJlZiwgaGlkX3NlbnNv
cl9jdXN0b21fZnJlZSk7CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
X2lkIGhpZF9zZW5zb3JfY3VzdG9tX2lkc1tdID0gewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQv
aGlkLXNlbnNvci1odWIuYyBiL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMKaW5kZXggOTA2
NjZmZjYyOWRlLi4yYmFjOGI4MmNlMzcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaGlkL2hpZC1zZW5z
b3ItaHViLmMKKysrIGIvZHJpdmVycy9oaWQvaGlkLXNlbnNvci1odWIuYwpAQCAtMTczLDcgKzE3
Myw4IEBAIGludCBzZW5zb3JfaHViX3JlbW92ZV9jYWxsYmFjayhzdHJ1Y3QgaGlkX3NlbnNvcl9o
dWJfZGV2aWNlICpoc2RldiwKIAlzdHJ1Y3Qgc2Vuc29yX2h1Yl9kYXRhICpwZGF0YSA9IGhpZF9n
ZXRfZHJ2ZGF0YShoc2Rldi0+aGRldik7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAotCXNwaW5f
bG9ja19pcnFzYXZlKCZwZGF0YS0+ZHluX2NhbGxiYWNrX2xvY2ssIGZsYWdzKTsKKwlzcGluX2xv
Y2tfaXJxc2F2ZSgmcGRhdGEtPmxvY2ssIGZsYWdzKTsKKwlzcGluX2xvY2soJnBkYXRhLT5keW5f
Y2FsbGJhY2tfbG9jayk7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeShjYWxsYmFjaywgJnBkYXRhLT5k
eW5fY2FsbGJhY2tfbGlzdCwgbGlzdCkKIAkJaWYgKGNhbGxiYWNrLT51c2FnZV9pZCA9PSB1c2Fn
ZV9pZCAmJgogCQkJCQkJY2FsbGJhY2stPmhzZGV2ID09IGhzZGV2KSB7CkBAIC0xODEsNyArMTgy
LDggQEAgaW50IHNlbnNvcl9odWJfcmVtb3ZlX2NhbGxiYWNrKHN0cnVjdCBoaWRfc2Vuc29yX2h1
Yl9kZXZpY2UgKmhzZGV2LAogCQkJa2ZyZWUoY2FsbGJhY2spOwogCQkJYnJlYWs7CiAJCX0KLQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZwZGF0YS0+ZHluX2NhbGxiYWNrX2xvY2ssIGZsYWdzKTsK
KwlzcGluX3VubG9jaygmcGRhdGEtPmR5bl9jYWxsYmFja19sb2NrKTsKKwlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZwZGF0YS0+bG9jaywgZmxhZ3MpOwogCiAJcmV0dXJuIDA7CiB9Cg==


--=-uWxHwhaJA+w2d1CJPvLu--
