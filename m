Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F372FFFBE
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363202; cv=none; b=mC2XL8VqL9TI580Xup9nlNoPfUwOKOnnC+mZ8XVt8xzCfZwxZrbfEtvt7lNYxrGunRXdlcSi7CrhMzfr7osWIH4pc44zNkfwFjCS/1Cpwf9+Fws/6IXREWUb0jhfa03BgQyLOEUnFRjvX3ui7lDCblKiO3n9cAWLiGbKslvbPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363202; c=relaxed/simple;
	bh=4A0fZHW/YDgspYkSvKdIkkjbXQsebYsZ06fT8CMU7NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghUmTBVMp0UAsHoHr+PLM3odU/23VBssayoxK+55Q2HweBFpb2lhwLhnv/O9g8jg0qKff9aEfpUuWo+SzI/EhDN8ZtZpMMu+dygU0E4wrqjZp2qLt9YmjDtWydWaocKhdhsSKcI4HWANOFirq9TxJlu3Kju6mvgJXpgfbIKJfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=HdIWoUQs; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RJLN+g+e; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="HdIWoUQs";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RJLN+g+e"
DKIM-Signature: a=rsa-sha256; b=HdIWoUQsKR+O7Jio3dbkhs/mH8WG2PfpMMUifZK40V1qe+dHG1PB9aVPzymu92Qy288iFkArPkau3wcIfpV/rWKeP3j0s/nTPSIhde1pUYxG11ovbvQCY+JiGACoSu1sPmB5U6RIOqTuSoLg0Vz0OpN5mVPkRbdXetH3r2aPn1ORA5n/CXJrwBIWPAqY3hOW6rB3FaCMCcJooUWlUOlmcgXkKqTISkUnXEUN6faYLfRXcTn8HeILc6yO/LZeKltKMrYsYmYJVBe4yR3yII3NJSuOVD2ub6UjPbS672srTGZNc9kPyJQbrjsSkilShu46sLzcyJ9fi5fK+ROGZRqcJw==; s=purelymail1; d=rcpassos.me; v=1; bh=4A0fZHW/YDgspYkSvKdIkkjbXQsebYsZ06fT8CMU7NI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=RJLN+g+e2K4Q+D9api0ll0oh4z3ae0FCL+ep0ZKRexPxJhMyBRp7IYSfj09OXTeTUrdd6xAf0GQd2XqCmfii2nfS7ujmE1FepwNblf31rhjLMd5VibP7cHSsyGEzLj3iWBWoyihTFwvObuHas5EhC9OZPC5BJAiJeiy+H7U7hQadvDhr+1vdovr0SaSCZ0nNGzA/QMYDWpf8s09EY8ueGaO/t8DeJfYi+dm5CDzxwC0azjx0iwqOYOtye4TO7AioufDL3P/fMBcED+pBoYCb7sumOXHUv8lgzytM5l6r/mcdvmzMJdIqCf6e2gT3/ZJy5R5SAdrJhy9JNXWmOqfgoA==; s=purelymail1; d=purelymail.com; v=1; bh=4A0fZHW/YDgspYkSvKdIkkjbXQsebYsZ06fT8CMU7NI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -15176502;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 02 Jun 2026 01:19:47 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: lcasmz54@gmail.com
Cc: bentiss@kernel.org,
	hadess@hadess.net,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sre@kernel.org
Subject: Bug report in HID: input: Add support for multiple batteries per device
Date: Mon,  1 Jun 2026 22:19:49 -0300
Message-ID: <20260602011949.2825852-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314010533.110278-4-lcasmz54@gmail.com>
References: <20260314010533.110278-4-lcasmz54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi, I found a bug preventing preventing my laptop from booting
the mainline, and my bisection led me to this patch.

I believe I found the issue already, and will send a patch
following this report.

Decoded trace:

```
jun 01 20:03:15 debbook kernel: Oops: Oops: 0000 [#1] SMP NOPTI
jun 01 20:03:15 debbook kernel: CPU: 4 UID: 0 PID: 257 Comm: (udev-worker) =
Not tainted 7.1.0-rc6rcpassos #85 PREEMPT(lazy)
jun 01 20:03:15 debbook kernel: Hardware name: HP HP ProBook x360 435 G7/87=
35, BIOS S80 Ver. 01.17.02 06/07/2024
jun 01 20:03:15 debbook kernel: RIP: 0010:hidinput_setup_battery.isra.0 (/m=
edia/wd/code/kernel-dev/linux/drivers/hid/hid-input.c:412 /media/wd/code/ke=
rnel-dev/linux/drivers/hid/hid-input.c:523) hid
jun 01 20:03:15 debbook kernel: Code: f3 48 ab 48 8b 85 18 1c 00 00 48 39 c=
3 74 4b 48 8b 52 68 48 83 e8 38 8b 4a 30 eb 0e 90 48 8b 50 38 48 8d 42 c8 4=
8 39 d3 74 30 <3b> >
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:=09f3 48 ab             =09rep stos %rax,(%rdi)
   3:=0948 8b 85 18 1c 00 00 =09mov    0x1c18(%rbp),%rax
   a:=0948 39 c3             =09cmp    %rax,%rbx
   d:=0974 4b                =09je     0x5a
   f:=0948 8b 52 68          =09mov    0x68(%rdx),%rdx
  13:=0948 83 e8 38          =09sub    $0x38,%rax
  17:=098b 4a 30             =09mov    0x30(%rdx),%ecx
  1a:=09eb 0e                =09jmp    0x2a
  1c:=0990                   =09nop
  1d:=0948 8b 50 38          =09mov    0x38(%rax),%rdx
  21:=0948 8d 42 c8          =09lea    -0x38(%rdx),%rax
  25:=0948 39 d3             =09cmp    %rdx,%rbx
  28:=0974 30                =09je     0x5a
  2a:*=093b 00                =09cmp    (%rax),%eax=09=09<-- trapping instr=
uction

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:=093b 00                =09cmp    (%rax),%eax
jun 01 20:03:15 debbook kernel: RSP: 0018:ffffce87407c76c0 EFLAGS: 00010286
jun 01 20:03:15 debbook kernel: RAX: ffffffffffffffc8 RBX: ffff8db823bb7c18=
 RCX: 0000000000000007
jun 01 20:03:15 debbook kernel: RDX: 0000000000000000 RSI: 0000000000000000=
 RDI: ffffce87407c7718
jun 01 20:03:15 debbook kernel: RBP: ffff8db823bb6000 R08: ffffce87407c77c0=
 R09: ffffce87407c77bc
jun 01 20:03:15 debbook kernel: R10: ffff8db80df756c0 R11: ffff8db81f7b3000=
 R12: ffffce87407c76e8
jun 01 20:03:15 debbook kernel: R13: ffff8db80df756c0 R14: ffff8db823bb6000=
 R15: ffff8db823119600
jun 01 20:03:15 debbook kernel: FS:  00007fe5afebfd80(0000) GS:ffff8dbf6807=
b000(0000) knlGS:0000000000000000
jun 01 20:03:15 debbook kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
jun 01 20:03:15 debbook kernel: CR2: ffffffffffffffe4 CR3: 000000011ffe4000=
 CR4: 0000000000350ef0
jun 01 20:03:15 debbook kernel: Call Trace:
jun 01 20:03:15 debbook kernel:  <TASK>
jun 01 20:03:15 debbook kernel:  ? input_alloc_absinfo (./include/linux/sla=
b.h:950 ./include/linux/slab.h:1188 drivers/input/input.c:442)
jun 01 20:03:15 debbook kernel: hidinput_connect (/media/wd/code/kernel-dev=
/linux/drivers/hid/hid-input.c:1294 /media/wd/code/kernel-dev/linux/drivers=
/hid/hid-input.c:2278 /media/wd/code/kernel-dev/linux/drivers/hid/hid-input=
.c:2345) hid
jun 01 20:03:15 debbook kernel: hid_connect (/media/wd/code/kernel-dev/linu=
x/drivers/hid/hid-core.c:2308 (discriminator 1)) hid
jun 01 20:03:15 debbook kernel:  ? vfree.part.0 (mm/vmalloc.c:3475)
jun 01 20:03:15 debbook kernel: hid_hw_start (/media/wd/code/kernel-dev/lin=
ux/drivers/hid/hid-core.c:2426 /media/wd/code/kernel-dev/linux/drivers/hid/=
hid-core.c:2417) hid
jun 01 20:03:15 debbook kernel: mt_probe (/media/wd/code/kernel-dev/linux/d=
rivers/hid/hid-multitouch.c:2028) hid_multitouch
jun 01 20:03:15 debbook kernel:  ? devres_open_group (./include/linux/spinl=
ock.h:408 ./include/linux/spinlock.h:619 drivers/base/devres.c:263 drivers/=
base/devres.c:617)
jun 01 20:03:15 debbook kernel: hid_device_probe (/media/wd/code/kernel-dev=
/linux/drivers/hid/hid-core.c:2822 /media/wd/code/kernel-dev/linux/drivers/=
hid/hid-core.c:2859) hid
jun 01 20:03:15 debbook kernel:  really_probe (drivers/base/dd.c:631 driver=
s/base/dd.c:709)
jun 01 20:03:15 debbook kernel:  ? __pfx___device_attach_driver (drivers/ba=
se/dd.c:908 (discriminator 1))
jun 01 20:03:15 debbook kernel:  __driver_probe_device (drivers/base/dd.c:8=
71)
jun 01 20:03:15 debbook kernel:  driver_probe_device (drivers/base/dd.c:901=
)
jun 01 20:03:15 debbook kernel:  __device_attach_driver (drivers/base/dd.c:=
1029)
jun 01 20:03:15 debbook kernel:  bus_for_each_drv (drivers/base/bus.c:500)
jun 01 20:03:15 debbook kernel:  __device_attach (drivers/base/dd.c:1101)
jun 01 20:03:15 debbook kernel:  ? __pfx___hid_bus_reprobe_drivers (/media/=
wd/code/kernel-dev/linux/drivers/hid/hid-core.c:3111) hid
jun 01 20:03:15 debbook kernel:  device_reprobe (drivers/base/bus.c:847 dri=
vers/base/bus.c:881)
jun 01 20:03:15 debbook kernel:  ? __hid_bus_reprobe_drivers (/media/wd/cod=
e/kernel-dev/linux/drivers/hid/hid-core.c:3094) hid
jun 01 20:03:15 debbook kernel:  bus_for_each_dev (drivers/base/bus.c:383)
jun 01 20:03:15 debbook kernel:  ? __pfx___hid_bus_driver_added (/media/wd/=
code/kernel-dev/linux/drivers/hid/hid-core.c:2900) hid
jun 01 20:03:15 debbook kernel: __hid_bus_driver_added (/media/wd/code/kern=
el-dev/linux/drivers/hid/hid-core.c:3106) hid
jun 01 20:03:15 debbook kernel:  bus_for_each_drv (drivers/base/bus.c:500)
jun 01 20:03:15 debbook kernel:  ? __pfx_sensor_hub_driver_init (hid-sensor=
-hub.mod.c:?) hid_sensor_hub
jun 01 20:03:15 debbook kernel: __hid_register_driver (/media/wd/code/kerne=
l-dev/linux/drivers/hid/hid-core.c:3134 /media/wd/code/kernel-dev/linux/dri=
vers/hid/hid-core.c:3118) hid
jun 01 20:03:15 debbook kernel:  do_one_initcall (init/main.c:1392)
jun 01 20:03:15 debbook kernel:  do_init_module (kernel/module/main.c:3106)
jun 01 20:03:15 debbook kernel:  init_module_from_file (kernel/module/main.=
c:3777)
jun 01 20:03:15 debbook kernel:  idempotent_init_module (kernel/module/main=
.c:3789)
jun 01 20:03:15 debbook kernel:  __x64_sys_finit_module (kernel/module/main=
.c:3815 kernel/module/main.c:3799 kernel/module/main.c:3799)
jun 01 20:03:15 debbook kernel:  do_syscall_64 (arch/x86/entry/syscall_64.c=
:63 arch/x86/entry/syscall_64.c:94)
jun 01 20:03:15 debbook kernel:  ? do_sys_openat2 (./include/linux/fs.h:255=
3 fs/open.c:1363)
jun 01 20:03:15 debbook kernel:  ? __x64_sys_openat (fs/open.c:1370 fs/open=
.c:1386 fs/open.c:1381 fs/open.c:1381)
jun 01 20:03:15 debbook kernel:  ? do_syscall_64 (./arch/x86/include/asm/en=
try-common.h:63 ./include/linux/irq-entry-common.h:210 ./include/linux/irq-=
entry-common.h:230 ./include/linux/entry-common.h:318 arch/x86/entry/syscal=
l_64.c:100)
jun 01 20:03:15 debbook kernel:  ? do_syscall_64 (./arch/x86/include/asm/en=
try-common.h:63 ./include/linux/irq-entry-common.h:210 ./include/linux/irq-=
entry-common.h:230 ./include/linux/entry-common.h:318 arch/x86/entry/syscal=
l_64.c:100)
jun 01 20:03:15 debbook kernel:  ? do_syscall_64 (./arch/x86/include/asm/en=
try-common.h:63 ./include/linux/irq-entry-common.h:210 ./include/linux/irq-=
entry-common.h:230 ./include/linux/entry-common.h:318 arch/x86/entry/syscal=
l_64.c:100)
jun 01 20:03:15 debbook kernel:  ? __x64_sys_openat (fs/open.c:1370 fs/open=
.c:1386 fs/open.c:1381 fs/open.c:1381)
jun 01 20:03:15 debbook kernel:  ? __fput (./include/linux/percpu_counter.h=
:71 ./include/linux/percpu_counter.h:272 fs/file_table.c:99 fs/file_table.c=
:523)
jun 01 20:03:15 debbook kernel:  ? __x64_sys_close (fs/open.c:1507 fs/open.=
c:1492 fs/open.c:1492)
jun 01 20:03:15 debbook kernel:  ? do_syscall_64 (./arch/x86/include/asm/en=
try-common.h:63 ./include/linux/irq-entry-common.h:210 ./include/linux/irq-=
entry-common.h:230 ./include/linux/entry-common.h:318 arch/x86/entry/syscal=
l_64.c:100)
jun 01 20:03:15 debbook kernel:  ? from_kgid_munged (kernel/user_namespace.=
c:406 kernel/user_namespace.c:512 kernel/user_namespace.c:536)
jun 01 20:03:15 debbook kernel:  ? __do_sys_getgid (kernel/sys.c:1042 (disc=
riminator 2))
jun 01 20:03:15 debbook kernel:  ? do_syscall_64 (./arch/x86/include/asm/en=
try-common.h:63 ./include/linux/irq-entry-common.h:210 ./include/linux/irq-=
entry-common.h:230 ./include/linux/entry-common.h:318 arch/x86/entry/syscal=
l_64.c:100)
jun 01 20:03:15 debbook kernel:  ? do_syscall_64 (./include/linux/randomize=
_kstack.h:57 arch/x86/entry/syscall_64.c:92)
jun 01 20:03:15 debbook kernel:  entry_SYSCALL_64_after_hwframe (arch/x86/e=
ntry/entry_64.S:121)
jun 01 20:03:15 debbook kernel: RIP: 0033:0x7fe5affd3c69
jun 01 20:03:15 debbook kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0=
f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4=
c 24 08 0f 05 <48> >
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:=09ff c3                =09inc    %ebx
   2:=0966 2e 0f 1f 84 00 00 =09cs nopw 0x0(%rax,%rax,1)
   9:=0900 00 00
   c:=090f 1f 44 00 00       =09nopl   0x0(%rax,%rax,1)
  11:=0948 89 f8             =09mov    %rdi,%rax
  14:=0948 89 f7             =09mov    %rsi,%rdi
  17:=0948 89 d6             =09mov    %rdx,%rsi
  1a:=0948 89 ca             =09mov    %rcx,%rdx
  1d:=094d 89 c2             =09mov    %r8,%r10
  20:=094d 89 c8             =09mov    %r9,%r8
  23:=094c 8b 4c 24 08       =09mov    0x8(%rsp),%r9
  28:=090f 05                =09syscall
  2a:*=0948                   =09rex.W=09=09<-- trapping instruction
=09...

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:=0948                   =09rex.W
=09...
jun 01 20:03:15 debbook kernel: RSP: 002b:00007ffc4716a3d8 EFLAGS: 00000246=
 ORIG_RAX: 0000000000000139
jun 01 20:03:15 debbook kernel: RAX: ffffffffffffffda RBX: 0000555df96b8430=
 RCX: 00007fe5affd3c69
jun 01 20:03:15 debbook kernel: RDX: 0000000000000004 RSI: 00007fe5afd7344d=
 RDI: 0000000000000050
jun 01 20:03:15 debbook kernel: RBP: 0000000000000004 R08: 0000000000000000=
 R09: 0000555df962b170
jun 01 20:03:15 debbook kernel: R10: 0000000000000000 R11: 0000000000000246=
 R12: 0000000000020000
jun 01 20:03:15 debbook kernel: R13: 00007fe5afd7344d R14: 0000555df96bb2e0=
 R15: 0000000000000000
jun 01 20:03:15 debbook kernel:  </TASK>
jun 01 20:03:15 debbook kernel: Modules linked in: hid_sensor_hub(+) drm_bu=
ddy amdxcp drm_panel_backlight_quirks gpu_sched drm_ttm_helper ttm drm_exec=
 i2c_algo_bit drm_s>
```

Thanks,
Rafael Passos
