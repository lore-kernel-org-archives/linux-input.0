Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DE357CE6;
	Tue,  2 Jun 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397711; cv=none; b=nVZphmLINjELsXuu84JVCaNJ8CaMI4OAwm3CSjEMFDBUV9W43mks859uxZbluD1Yry7Y6r53GlNsXmRTvS5wfOejd2b1zN+aYy/M9jK7oeQ/r8Rab3GpuMdkiw6U1c9uZJD/0SSYZoOGvNMLEjwfAj/8KUtVBdnGVNGnRdOAZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397711; c=relaxed/simple;
	bh=6O05YZPJUFmUOwudJDLOABddZoi2JOiBBFH0cddSNwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AN0oqAjQFFM2fVsZIy/jy7EGqEtosLcpjYYHqBcR2bGij/s0Xq7uyyE/ddx1X8M5CGRPUxmhuqrj0UCrz15jzLYXKVwdgYlF5m5UV9H0l2OlYIxHF/OSeiQpOovtQcZAaijF5ibRWAn4j8HiwGJg9FhYhVVJxVPKPiEVHpycap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LYVNPiba; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LYVNPiba"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gV75P35g2z4H87;
	Tue,  2 Jun 2026 12:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1780397705;
	bh=6O05YZPJUFmUOwudJDLOABddZoi2JOiBBFH0cddSNwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LYVNPibaaAaIsI6bNb6tWm0CkoxGtcJsJJBXupBUI+idtzYuPjf+911xlZ+B8Jnjp
	 0IcSliuw8saEAyDkGAbnJ1Mkqavrw7biidLybLQnCef95pNS83qji+sYn/0LOTvI9l
	 ZjJlidxFK3kTFZ2sL/5b0MxnVi45fT/9Cq/1sineRog8vifEcMB+0JfxN+oF69B7Cb
	 bdoS5CAegywwOcjp/umayqrp7F516qHizwztm350037QzmXotpkDxSwGGaTxMtWmVo
	 +77auH+pfxBzdCjdCP6fxJyJp4PtOFY+pIYRhtLOL13cJyUNKXHLABnw/XwPHSHpDx
	 Gj1eIY++OB5Qg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gV74M23CSz80VK;
	Tue,  2 Jun 2026 12:54:11 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gV74L6C4vz8sZP;
	Tue,  2 Jun 2026 12:54:10 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 156EF6031E;
	Tue,  2 Jun 2026 12:54:10 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b84a408c-b12c-40e5-b44b-62aa072cb285@leemhuis.info>
Date: Tue, 2 Jun 2026 12:54:08 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] RIP: 0010:hidinput_setup_battery.isra.0+0x6d/0x370
 [hid]
To: Tj <tj.iam.tj@proton.me>, regressions@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Rafael Passos <rafael@rcpassos.me>
References: <ah6vRH9J9LSvnKWW@mail.iam.tj>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <ah6vRH9J9LSvnKWW@mail.iam.tj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178039765041.3991024.10222344159118989624@mxe9fb.netcup.net>
X-NC-CID: ms0fy9AcbUV1ZKmfy3jVYM3mDLwG10RKKemgACObS3X+vwJswTk=

On 6/2/26 12:24, Tj wrote:
> Hitting this repeatedly with v7.1-rc6. Do not have time right now to
> bisect it (and there are two other regressions at the same time).

Again, not my area of expertise, but this looks somewhat similar (but
also somewhat different!) to this recent regression report from Rafael:
https://lore.kernel.org/all/20260602011949.2825852-1-rafael@rcpassos.me/

Rafael (CCed) sent a fix for it already applied:
HID: Input: Add battery list cleanup with devm action
https://lore.kernel.org/all/20260602030519.3097058-1-rafael@rcpassos.me/

Might be worth trying.

Ciao, Thorsten

> Symptom is unable to use the Bluetooth keyboard.
> 
> It *seems* to be related to the Bluetooth keyboard - trying to shutdown
> hangs for 6 minutes whilst systemd tries to kill bluetooth.service but fails
> and then fails to power-off (see end of log extracts).
> 
> I'm not sure why I see 'samsung_probe' in the call trace since neither the Bluetooth host
> adapter nor the keyboard are Samsung but maybe some change related to
> that is causing this.
> 
> Jun 02 09:25:54 sunny kernel: BUG: unable to handle page fault for address: ffffffffffffffe4
> Jun 02 09:25:54 sunny kernel: #PF: supervisor read access in kernel mode
> Jun 02 09:25:54 sunny kernel: #PF: error_code(0x0000) - not-present page
> Jun 02 09:25:54 sunny kernel: Oops: Oops: 0000 [#1] SMP NOPTI
> Jun 02 09:25:54 sunny kernel: CPU: 11 UID: 0 PID: 4009 Comm: (udev-worker) Tainted: G        W  OE       7.1.0-rc6+debian+tj #446 PREEMPT(lazy)
> Jun 02 09:25:54 sunny kernel: Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Jun 02 09:25:54 sunny kernel: Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 6254 01/05/2026
> Jun 02 09:25:54 sunny kernel: RIP: 0010:hidinput_setup_battery.isra.0+0x6d/0x370 [hid]
> Jun 02 09:25:54 sunny kernel: Code: 48 ab 48 8b 42 68 48 8b 95 18 1c 00 00 8b 48 30 48 39 d3 74 45 48 8d 42 c8 eb 0f 66 90 48 8b 50 38 48 8d 42 c8 48 39 d3 74 30 <3b> 48 1c 75 ee 48 85 c0 74 26>
> Jun 02 09:25:54 sunny kernel: RSP: 0018:ffffceacce2c7628 EFLAGS: 00010286
> Jun 02 09:25:54 sunny kernel: RAX: ffffffffffffffc8 RBX: ffff8b4856a83c18 RCX: 0000000000000003
> Jun 02 09:25:54 sunny kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffceacce2c7680
> Jun 02 09:25:54 sunny kernel: RBP: ffff8b4856a82000 R08: ffffceacce2c7730 R09: ffffceacce2c772c
> Jun 02 09:25:54 sunny kernel: R10: ffff8b488f290488 R11: ffff8b478bec9000 R12: ffffceacce2c7650
> Jun 02 09:25:54 sunny kernel: R13: 0000000000000000 R14: 0000000000000000 R15: ffff8b47e6307b00
> Jun 02 09:25:54 sunny kernel: FS:  00007f6ee16439c0(0000) GS:ffff8b4ed8fd0000(0000) knlGS:0000000000000000
> Jun 02 09:25:54 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 02 09:25:54 sunny kernel: CR2: ffffffffffffffe4 CR3: 000000010b1c1000 CR4: 0000000000350ef0
> Jun 02 09:25:54 sunny kernel: Call Trace:
> Jun 02 09:25:54 sunny kernel:  <TASK>
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  ? dev_set_name+0x5c/0x80
> Jun 02 09:25:54 sunny kernel:  hidinput_connect+0x935/0x5fb0 [hid]
> Jun 02 09:25:54 sunny kernel:  hid_connect+0x3d5/0x6a0 [hid]
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  ? __wake_up_common+0x78/0xa0
> Jun 02 09:25:54 sunny kernel:  hid_hw_start+0x40/0x70 [hid]
> Jun 02 09:25:54 sunny kernel:  samsung_probe+0x31/0x70 [hid_samsung]
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  hid_device_probe+0x18d/0x220 [hid]
> Jun 02 09:25:54 sunny kernel:  ? __pfx___device_attach_driver+0x10/0x10
> Jun 02 09:25:54 sunny kernel:  really_probe+0xde/0x380
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  __driver_probe_device+0x84/0x150
> Jun 02 09:25:54 sunny kernel:  driver_probe_device+0x1f/0xa0
> Jun 02 09:25:54 sunny kernel:  __device_attach_driver+0x89/0x130
> Jun 02 09:25:54 sunny kernel:  bus_for_each_drv+0x97/0xf0
> Jun 02 09:25:54 sunny kernel:  __device_attach+0xaf/0x1c0
> Jun 02 09:25:54 sunny kernel:  ? __pfx___hid_bus_reprobe_drivers+0x10/0x10 [hid]
> Jun 02 09:25:54 sunny kernel:  device_reprobe+0x4e/0x90
> Jun 02 09:25:54 sunny kernel:  ? __hid_bus_reprobe_drivers+0x3c/0x60 [hid]
> Jun 02 09:25:54 sunny kernel:  bus_for_each_dev+0x8e/0xe0
> Jun 02 09:25:54 sunny kernel:  ? __pfx___hid_bus_driver_added+0x10/0x10 [hid]
> Jun 02 09:25:54 sunny kernel:  __hid_bus_driver_added+0x2f/0x40 [hid]
> Jun 02 09:25:54 sunny kernel:  bus_for_each_drv+0x97/0xf0
> Jun 02 09:25:54 sunny kernel:  __hid_register_driver+0x74/0x80 [hid]
> Jun 02 09:25:54 sunny kernel:  ? __pfx_samsung_driver_init+0x10/0x10 [hid_samsung]
> Jun 02 09:25:54 sunny kernel:  do_one_initcall+0x5c/0x320
> Jun 02 09:25:54 sunny kernel:  do_init_module+0x60/0x250
> Jun 02 09:25:54 sunny kernel:  init_module_from_file+0xd6/0x130
> Jun 02 09:25:54 sunny kernel:  idempotent_init_module+0x114/0x310
> Jun 02 09:25:54 sunny kernel:  __x64_sys_finit_module+0x71/0xe0
> Jun 02 09:25:54 sunny kernel:  do_syscall_64+0xea/0x640
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  ? do_fault+0x341/0x530
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  ? __handle_mm_fault+0x977/0xf80
> Jun 02 09:25:54 sunny kernel:  ? __memcg_slab_free_hook+0x16d/0x1c0
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  ? count_memcg_events+0xe5/0x1b0
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  ? __seccomp_filter+0x42/0x5d0
> Jun 02 09:25:54 sunny kernel:  ? handle_mm_fault+0x1e2/0x2e0
> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
> Jun 02 09:25:54 sunny kernel:  ? do_syscall_64+0x9f/0x640
> Jun 02 09:25:54 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Jun 02 09:25:54 sunny kernel: RIP: 0033:0x7f6ee111a7b9
> Jun 02 09:25:54 sunny kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48>
> Jun 02 09:25:54 sunny kernel: RSP: 002b:00007ffe6dd96398 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> Jun 02 09:25:54 sunny kernel: RAX: ffffffffffffffda RBX: 0000556830869b90 RCX: 00007f6ee111a7b9
> Jun 02 09:25:54 sunny kernel: RDX: 0000000000000004 RSI: 00007f6ee16ed44d RDI: 0000000000000012
> Jun 02 09:25:54 sunny kernel: RBP: 0000000000000004 R08: 0000000000000000 R09: 0000556830667bd0
> Jun 02 09:25:54 sunny kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6ee16ed44d
> Jun 02 09:25:54 sunny kernel: R13: 0000000000020000 R14: 00005568307db670 R15: 0000000000000000
> Jun 02 09:25:54 sunny kernel:  </TASK>
> Jun 02 09:25:54 sunny kernel: Modules linked in: hid_samsung(+) snd_seq_dummy snd_hrtimer snd_seq snd_seq_device uinput rpcsec_gss_krb5 nfsv4 dns_resolver nfs netfs rdma_ucm ib_uverbs rdma_cm i>
> Jun 02 09:25:54 sunny kernel:  uvcvideo wmi_bmof watchdog snd_timer igb rfkill uas mii pcspkr mxm_wmi videobuf2_vmalloc snd ccp k10temp uvc i2c_piix4 dca videobuf2_memops soundcore videobuf2_v4>
> Jun 02 09:25:54 sunny kernel: CR2: ffffffffffffffe4
> Jun 02 09:25:54 sunny kernel: ---[ end trace 0000000000000000 ]---
> Jun 02 09:25:54 sunny kernel: RIP: 0010:hidinput_setup_battery.isra.0+0x6d/0x370 [hid]
> Jun 02 09:25:54 sunny kernel: Code: 48 ab 48 8b 42 68 48 8b 95 18 1c 00 00 8b 48 30 48 39 d3 74 45 48 8d 42 c8 eb 0f 66 90 48 8b 50 38 48 8d 42 c8 48 39 d3 74 30 <3b> 48 1c 75 ee 48 85 c0 74 26>
> Jun 02 09:25:54 sunny kernel: RSP: 0018:ffffceacce2c7628 EFLAGS: 00010286
> Jun 02 09:25:54 sunny kernel: RAX: ffffffffffffffc8 RBX: ffff8b4856a83c18 RCX: 0000000000000003
> Jun 02 09:25:54 sunny kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffceacce2c7680
> Jun 02 09:25:54 sunny kernel: RBP: ffff8b4856a82000 R08: ffffceacce2c7730 R09: ffffceacce2c772c
> Jun 02 09:25:54 sunny kernel: R10: ffff8b488f290488 R11: ffff8b478bec9000 R12: ffffceacce2c7650
> Jun 02 09:25:54 sunny kernel: R13: 0000000000000000 R14: 0000000000000000 R15: ffff8b47e6307b00
> Jun 02 09:25:54 sunny kernel: FS:  00007f6ee16439c0(0000) GS:ffff8b4ed8fd0000(0000) knlGS:0000000000000000
> Jun 02 09:25:54 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jun 02 09:25:54 sunny kernel: CR2: ffffffffffffffe4 CR3: 000000010b1c1000 CR4: 0000000000350ef0
> Jun 02 09:25:54 sunny systemd-udevd[1703]: 0005:04E8:7021.0006: Worker [4009] terminated by signal 9 (KILL).
> 
> Jun 02 09:29:16 sunny rpc.idmapd[3093]: exiting on signal 15
> Jun 02 09:30:45 sunny systemd[1]: bluetooth.service: State 'stop-sigterm' timed out. Killing.
> Jun 02 09:32:15 sunny systemd[1]: bluetooth.service: Processes still around after SIGKILL. Ignoring.
> Jun 02 09:33:45 sunny systemd[1]: bluetooth.service: State 'final-sigterm' timed out. Killing.
> Jun 02 09:35:15 sunny systemd[1]: bluetooth.service: Processes still around after final SIGKILL. Entering failed mode.
> Jun 02 09:35:15 sunny systemd[1]: bluetooth.service: Failed with result 'timeout'.
> 
> 

