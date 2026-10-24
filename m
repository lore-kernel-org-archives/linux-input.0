Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792855674;
	b=MDchpYb6AaEPDBcXlgRHibOEjBKm3JbI2apGV+V62wSP7iF4OYsVnVwHBaKhlFwpRie7
	 cc7BuM+i+cKXgbBU7jWMfPGv1WssNosdjogUdfyTzEpRy54gcbfZ1MVERNAkJOoF6cJEr
	 8bdogBzNz683QmpxHxWoribBJybk95a0IkUxsDShLfOnIZICNiukXDJnucwoGaUq1Aj+k
	 l3DJkF9OdvuU962qOXs4c8U7nDs1JZQ48PdFHK4oZRQfA06ciW7syYRvIsfJ1fvh5Kqkg
	 krB71QiPwXgzRFkN75nLgeEy9raKQvGgxNgKthgKv4wDmR0IZ10UxC1UgxrCy/HZAgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=iS5Zhc+sE4ByxA9kwUHmzNU0QIBxCDiMbckbwoc+qx0=;
	b=38bb9SN9ahmK5aABeG/Z8M+0h/S2fMN0iwtl0K9iHbOErv8ZaJrzEVBAzkfB1fJTnS6H
	 mmxfz5tFHqj+0c1TMOlye/ycn2DNKDccu9Dwnb2RDF3aY/uCBa3HKMQCpPtSctzb/VEtQ
	 WPL8Lqvj9esJe/cTPdeTsP8egIZXnfGlti2ljW7ZPGngrcPhmCV6VzflxcmHfO/RODGj7
	 pmUMGI2w1bpSCMmSwAgLj2m1Gw/xWqm+o0smseOwQDcUfSILz8ZN5hhvHgArUpEFvzPIi
	 bYjFPyuRve3FS7Hphus+OSLmOGw62ZT1Akgq12VAhIGpmWH24AyT/HN0ROl+cgYQoow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pVR7sNZ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7EF606A31D
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 15:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B7EF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pVR7sNZ9
Received: by mail-lr2-f5.google.com with SMTP id 38308e7fff4ca-3ab2a40750fso9657571fa.1
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 08:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792855672; cv=none;
        d=google.com; s=arc-20260327;
        b=HJGcWL0t2vVoeEW9CE9RZmaF83JANqU5a3N5VSvmoP26dTv2+wtraeoduCLpSBUmsH
         g2/dRP35dB7knIwnif7pV+e9dm5QoOCP9wuEbxj9LFwEd94aMlnAdKWH4oSCZlFRQonG
         RNo2wYZLMiV803rp10w8GdkGlKU/Sp6IifLd5TBTRMg/xqP+sK1I3CtZmNPsZRhECo3X
         R/PA2kvLS8DoigXA93/VD1kfeuTvXsxs2U8mnU1YJZ0+IEdf+2WmCN8+9JJd0npSwMgF
         aULIGKiNb8DuuO4/sDMwP7KX2FFh71mVG+Ezamc3wFQSIoiqjqIkF2gN8hE0dvIwo3wZ
         fbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iS5Zhc+sE4ByxA9kwUHmzNU0QIBxCDiMbckbwoc+qx0=;
        fh=n8fEYuoevx8wint4JRVLdZaRBNq9V5jjrPagPkQhSpw=;
        b=DXoLDTwMA0BvkU8t/318a+9jd4XbDOV6C/h6PkSYycRAGjc0VqyijPTXNlBQC/uUk+
         THLELZMVRex9fgIjdSANQu8Gr3uvDsrzICHRXWSYkoBKueIvwvkEXu5aRADkpPA3nnxb
         Du26y7GUK5mZ1gQo8MDtmhFt4LAyo34awSo29MQo5GEuXLuclfDoMoVckMA4HoBlMkcO
         Vs2BqU5oJ3qCTgN3xYcddVAEihbRO7KD6yq0zY9zGUfvmNlpNK3y3pCi7+dckCUbDmuv
         S7n0lTaiXmmJq6JCS39a4rm9U1RlFZGEwoXL8WelM/D+YKG2vdjs0uJ5SpG/HsqSRbrg
         zC8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855672; x=1793460472; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iS5Zhc+sE4ByxA9kwUHmzNU0QIBxCDiMbckbwoc+qx0=;
        b=pVR7sNZ9N6WDehhguAyrK91c2UB0tKytAYwmpy7MfNAUKA2sOxyBdPWo1PxpSrRutB
         uyRaKD1XMcEhoVWuw78Zw8C9LzxsoFGfONR6nDUPwGjj6LJLCj/2ZdjFFGvlhtBvrWUU
         PIyNw2a46gPfGRQA0zWK6vA2YtJD5szoqp178MUzCwzgv/N61rc6Sde3r64tx/OdgjE6
         k6O37GSOeVA4tyghAOnafFZy4atT8B+/E0/EbQi9plDA3ceOTUU8lDka7avKJ7KRotgG
         tiDZWx5uKjUGNX0vmhnURmRdiXMPc32LkWRUpvJf60xn11RQ0j76QXgorsno1EAMFC/y
         VAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855672; x=1793460472;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iS5Zhc+sE4ByxA9kwUHmzNU0QIBxCDiMbckbwoc+qx0=;
        b=z4GVJGmmHYTUuXpAczSyBjTFV8hxKmKPU1Imx/XhPJgt7y7GUXYX3MGHs/Bp5qsepc
         ozECltm+CIJ8b1Yp7Mw0vjWbTLYsLBe41as2k+fPgymGdrTPzl9160Yb7XbvDcrHr0G7
         FASChbJq5nCrk43xZFuUZsRWkMBVHHKs0SJKn54kEm8Ojedgx/Yg/BPLNU0ssOU1oTXj
         nUUtTrpIFHt55IyZiJBfrVLK9D5vghlThJSSayiDlxFSp8J5AN6SVCAiIESR/WlEyd+e
         6o3Ah9URNqdECYrE/pn9LwpSslEOk4k7Oxo3H/IDcTjyPHeXY1TTyWOAI9B7Q+xAkhDO
         N9FQ==
X-Gm-Message-State: AFq9FYImhWhmS/PQQw+77PotZgcz/GHBgWCaLYp4uFLr3dewQQeeesWy
	bxWhEoBuYwzqPzUsuclDzD1j1oviAgBdKht5hhSeaT4fwcZXG0/pGVs4A91PGmNMD5pX4RGkBzf
	bI1BHXTuVB2K96cEcEnwsBz0oeE6rLsg=
X-Gm-Gg: AYBFou0yo6wIaJltmTU4MqsDaHUaVsviN2bhVw2SjOrS4O/bUTYw3hhWG9G0N6Ycrvh
	aL3/mFpm4i2HQuAr7deSjjF7O+Uk9RbDKXs2GzP1tBMNIJKadq34TPcPJyEcQjLII23VdzhKI3w
	9ZCDuK0rK0+yM9AJgqOXOCtCaK+qNjtHt7WXI1s8o23cVTtOVQVwSYj7tOEcNAaV6x3NnlQZ2Ty
	qOPOg5S4ItDkkHXflwYbw+yW5koEadk3Hlhpyd9YSsP5/jz8XqPxgcukPMdtpwwCLHIKjfC2spG
	u5zZTt8PvarTEIk3CTr0siuwrvof3J8LmZWr7P7v0nYK72+wUlI19V00ARRAJ3CCOqWzMlUhueZ
	ewE+nCEDQ0tW/KEZw1PVoro5JQUNPprd5eb1PpQ==
X-Received: by 2002:a2e:be84:0:b0:3a6:772c:2757 with SMTP id
 38308e7fff4ca-3ac6fcf0290mr4860011fa.12.1792855671222; Sat, 24 Oct 2026
 08:27:51 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Sat, 24 Oct 2026 23:27:38 +0800
X-Gm-Features: AclHuK_qYRdkUyULxjKJ3869VkCLl0Q0CBw_2CQv5y2-OinBDduVJe0yO0lVoy0
Message-ID: <CAO-4RZ28RXpMv-o0R9uxiuoSR7mB5OtFCc-_JjBK2UZLYZVWDA@mail.gmail.com>
Subject: [BUG] HID: uhid: general protection fault in synchronize_srcu on
 device-creation failure
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri and Benjamin,

I observed a general protection fault (KASAN null-ptr-deref) in
synchronize_srcu() while fuzzing HID/uhid with syzkaller. I reproduced it on
Linux 7.1.3 and on Linux 7.3.0.

The fault happens on the error path of hid_allocate_device(). With fault
injection making hid_bpf_device_init() fail (init_srcu_struct() allocation
failure, failslab), hid_allocate_device() jumps to out_err and calls
hid_destroy_device() -> hid_bpf_destroy_device(), which unconditionally calls
synchronize_srcu(&hdev->bpf.srcu) and cleanup_srcu_struct(). SRCU
initialization failed, but the error path still invokes synchronize_srcu() on
the unsuccessfully initialized SRCU structure; check_init_srcu_struct() then
dereferences it and the kernel takes a GPF:

  hid_bpf_destroy_device drivers/hid/bpf/hid_bpf_dispatch.c:632
  hid_destroy_device     drivers/hid/hid-core.c:3085
  hid_allocate_device    drivers/hid/hid-core.c:3056   (out_err path)
  uhid_dev_create2       drivers/hid/uhid.c:511

Related patch
-------------
The following posted patch appears to address this error path:

  "[PATCH] HID: core: fix device cleanup on allocation failure"
  by Tristan Madani (2026-09-04)
  https://lkml.iu.edu/2609.0/09658.html

The patch replaces hid_destroy_device() with put_device() in the
hid_allocate_device() error path; it also carries
Fixes: 6cd735f0e57a ("HID: bpf: protect HID-BPF prog_list access by a SRCU")
and Cc: stable.

The kernels I tested (7.1.3 and 7.3.0) do not include that fix:
hid_allocate_device() still calls hid_destroy_device() on the
hid_bpf_device_init() failure path, and the crash reproduces there. Please
confirm whether the patch has been queued for stable/backporting; I can test
the backport if useful.

Environment
-----------
- Kernel A (found and reproduced): 7.1.3-kernsight-kasan #13 SMP
  PREEMPT_DYNAMIC (2026-10-13), x86_64, KASAN/KCOV,
  CONFIG_FAULT_INJECTION=y, failslab enabled. No HID source changes.
- Kernel B (reproduced 2026-10-24): 7.3.0-kernsight-kasan #1 SMP
  PREEMPT_DYNAMIC (2026-10-20), x86_64. Vanilla 7.3.0 tarball
  (sha256 87363c24f10e06321eb362765521094e94471f6bff8bce2d6b3e40f39f004953),
  built with KASAN/KCOV and fault injection. No HID source changes.
- Guest: QEMU 6.2.0, 4 vCPU, 6 GiB, KVM, x86_64. A fresh VM per run.
- Syzkaller: revision 853b104bb454141a5b0fc0e4218ec78e9f34ffb1+ (2026-09-18).
  The "+" denotes local KernSight integration changes (seed ordering/state
  feedback: pkg/kernsight, prog/kernsight_*, syz-manager/kernsight_*,
  pkg/execbackend, snapshot support in vm/qemu). The executor used is the one
  built from this tree.
- Reproduction rate: 7.1.3: syz reproducer verified (no C reproducer was
  produced). 7.3.0: 1/1 with the stored 68-program sequence; the standalone
  two-call program did not reproduce in 2 runs. (1/1 does not establish
  stability.)
- Kernel command line (7.1.3; 7.3.0 is identical, see repository):
  root=/dev/sda console=ttyS0 fstab=no rw earlyprintk=serial
net.ifnames=0 oops=panic panic_on_warn=1 panic=86400 hung_task_panic=1
softlockup_panic=1 nmi_watchdog=panic
sysctl.kernel.hung_task_all_cpu_backtrace=1
sysctl.kernel.panic_on_rcu_stall=1
sysctl.kernel.max_rcu_stall_to_panic=1 rcupdate.rcu_expedited=1
rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on
sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4
secretmem.enable=1 msr.allow_writes=off coredump_filter=0xffff
vsyscall=native kvm-intel.nested=1 spec_store_bypass_disable=prctl
nopcid vivid.n_devs=64
vivid.multiplanar=1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2
netrom.nr_ndevs=32 rose.rose_ndevs=32 smp.csd_lock_timeout=100000
watchdog_thresh=55 workqueue.watchdog_thresh=140
sysctl.net.core.netdev_unregister_timeout_secs=140 dummy_hcd.num=16
max_loop=32 nbd.nbds_max=32 comedi.comedi_num_legacy_minors=4
kunit.autorun=0 vcan.echo=1

Reproduction on 7.1.3
---------------------
Fresh KVM guest, kernel as above, from the guest's /tmp:

  scp syz-execprog syz-executor repro.prog root@guest:/tmp/
  ssh root@guest
  cd /tmp && chmod +x syz-execprog syz-executor
  ./syz-execprog -procs=1 -repeat=1 -disable=swap -executor
./syz-executor ./repro.prog

Settings: sandbox=none, threaded executor, procs=1, repeat=1, no additional
syzkaller features; a single program.

The program (2 calls; fail_nth: 5 on the UHID write):

  r0 = openat$uhid(0xffffffffffffff9c, &(0x7f0000000000), 0x2, 0x0)
  write$UHID_CREATE(r0, &(0x7f0000000140)={0x0, {'syz1\x00',
'syz0\x00', 'syz0\x00', &(0x7f0000001300)=""/191, 0xbf, 0x24, 0x2,
0x160e, 0x3, 0xffff8000}}, 0x120) (fail_nth: 5)

No C reproducer was produced for this report.

Reproduction on 7.3.0
---------------------
Same procedure with the 7.3.0 kernel and the stored execution sequence:

  scp syz-execprog syz-executor repro.kernsight.prog root@guest:/tmp/
  ssh root@guest
  cd /tmp && chmod +x syz-execprog syz-executor
  ./syz-execprog -procs=1 -repeat=1 -disable=swap -executor
./syz-executor ./repro.kernsight.prog

The sequence contains 68 programs replayed by a single executor process
(procs=1), one at a time in file order (repeat=1, sandbox=none, threaded
executor). Note that repro.prog retains the original syzkaller repro options in
its first line (Threaded:true Repeat:true Procs:6 ...); the manual replays used
the command above. The host/guest commands and console outputs of all three
runs are in RUNS.md in the repository. The UHID trigger is program #64
and appears again inside the final
program #67. There is no parallel replay, but earlier programs can leave
kernel-side asynchronous work behind, so their effects may persist.

Materials (programs, full logs, reports, kernel configs, command lines,
sha256 manifest, and a verify.sh that re-checks the numbers quoted here):
  https://github.com/Zheng-zheng-codes/hid-uhid-synchronize-srcu-repro

In our runs the sequence log contains exactly one GPF report, first printed at
t=276.2 s. In the two standalone 7.3.0 runs, syz-execprog exited with status 0
and neither serial log contains the GPF; the captured output does not include a
final executed-program count.

Fault injection was enabled for this reproduction
-------------------------------------------------
The write$UHID_CREATE() call is annotated with fail_nth: 5. During this
execution the kernel logged:

  FAULT_INJECTION: forcing a failure.
  name failslab, interval 1, probability 0, space 0, times 0

followed by the GPF report.

GPF report (7.3.0, latest verification)
---------------------------------------
Oops: general protection fault, probably for non-canonical address
0xdffffc000000002f: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
CPU: 3 UID: 0 PID: 12655 Comm: syz.4.84 Not tainted
7.3.0-kernsight-kasan #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:synchronize_srcu+0x53/0x3b0
Code: 48 83 ec 08 80 3c 02 00 0f 85 f1 02 00 00 48 b8 00 00 00 00 00
fc ff df 48 8b 5d 40 48 8d bb 78 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 c1 02 00 00 48 8b 83 78 01 00 00 a8 03 74 08 48
RSP: 0018:ffa000000519fa20 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000002f RSI: ffffffff88fa6f1c RDI: 0000000000000178
RBP: ff110001208be198 R08: 0000000000000000 R09: fffffbfff251b453
R10: ffffffff928da29f R11: 0000000000000001 R12: ff110001208be1d8
R13: ff110001208bdeb0 R14: ff11000110774098 R15: ff110001107740a0
FS:  00007fb68b6b0640(0000) GS:ff110001ef83e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001300 CR3: 000000011c3bd000 CR4: 0000000000753ef0
PKRU: 00000000
Call Trace:
 <TASK>
 hid_bpf_destroy_device+0x64/0x80
 hid_destroy_device+0x28/0x240
 hid_allocate_device+0x453/0x520
 uhid_dev_create2+0x16a/0x910
 uhid_dev_create+0x448/0x560
 ? __pfx_uhid_dev_create+0x10/0x10
 ? __might_fault+0xe5/0x190
 uhid_char_write+0xe06/0x1040
 vfs_write+0x2b6/0x1160
 ? __pfx_uhid_char_write+0x10/0x10
 ? __pfx_vfs_write+0x10/0x10
 ? __fget_files+0x1f6/0x3b0
 ? __fget_files+0x200/0x3b0
 ksys_write+0x1f4/0x240
 ? __pfx_ksys_write+0x10/0x10
 do_syscall_64+0x12e/0x7a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb68a7b2b7d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb68b6aff98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb68aa45fa0 RCX: 00007fb68a7b2b7d
RDX: 0000000000000120 RSI: 0000200000000140 RDI: 0000000000000003
RBP: 00007fb68b6b0010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fb68aa46038 R14: 00007fb68aa45fa0 R15: 00007fb68b690000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:synchronize_srcu+0x53/0x3b0
Code: 48 83 ec 08 80 3c 02 00 0f 85 f1 02 00 00 48 b8 00 00 00 00 00
fc ff df 48 8b 5d 40 48 8d bb 78 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 c1 02 00 00 48 8b 83 78 01 00 00 a8 03 74 08 48
RSP: 0018:ffa000000519fa20 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000002f RSI: ffffffff88fa6f1c RDI: 0000000000000178
RBP: ff110001208be198 R08: 0000000000000000 R09: fffffbfff251b453
R10: ffffffff928da29f R11: 0000000000000001 R12: ff110001208be1d8
R13: ff110001208bdeb0 R14: ff11000110774098 R15: ff110001107740a0
FS:  00007fb68b6b0640(0000) GS:ff110001ef83e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001300 CR3: 000000011c3bd000 CR4: 0000000000753ef0
PKRU: 00000000
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
Rebooting in 86400 seconds..

The 7.1.3 report is included in the repository (logs/report-7.1.3.txt) and has
the same path:

  RIP: synchronize_srcu+0x53/0x3b0 kernel/rcu/srcutree.c:1576
  check_init_srcu_struct ... srcutree.c:441 [inline]
  hid_bpf_destroy_device+0x64/0x80 drivers/hid/bpf/hid_bpf_dispatch.c:632
  hid_destroy_device+0x28/0x240 drivers/hid/hid-core.c:3085
  hid_allocate_device+0x453/0x520 drivers/hid/hid-core.c:3056
  uhid_dev_create2+0x16a/0x910 drivers/hid/uhid.c:511

Analysis
--------
hid_allocate_device() initializes the HID-BPF SRCU via hid_bpf_device_init();
when that fails, the error path calls hid_destroy_device(), whose BPF teardown
runs synchronize_srcu()/cleanup_srcu_struct() on the unsuccessfully initialized
SRCU structure. The posted patch proposes to address this by releasing
the device directly
with put_device() on the error path, which matches this analysis.

Could you confirm whether this is the issue addressed by the patch above, or
whether a separate fix is needed for the hid_allocate_device() error path? I am
happy to test proposed patches.

Attachments / repository contents
---------------------------------
  repro/repro.prog               syz program, includes fail_nth: 5 (7.1.3)
  repro/repro.kernsight.prog     68-program execution sequence (7.3.0)
  logs/report-7.1.3.txt          original 7.1.3 report
  logs/repro-report-7.1.3.log    7.1.3 reproduction report
  logs/gpf-7.3.txt               7.3.0 GPF report (also inline)
  logs/serial-7.3.log            full 7.3.0 console (sequence replay)
  logs/serial-7.3-minimal1.log   7.3.0 standalone run 1 (no trigger)
  logs/serial-7.3-minimal2.log   7.3.0 standalone run 2 (no trigger)
  kernel/kernel-7.1.3.config, kernel/kernel-7.3.config
  cmdline/cmdline-7.1.3.txt, cmdline/cmdline-7.3.0.txt
  verify.sh                      re-checks the numbers quoted in this mail
  scripts/replay-kernsight-prog.sh   the exact run script used for the replays
  MANIFEST.sha256                sha256 of every file

Best regards,
Zheng Zheng
