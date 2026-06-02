Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EF39021B;
	Tue,  2 Jun 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398441; cv=none; b=JFbzhzwsj1mQE0fhfbj0QMVfFBvZ3OBjXz8NzvbStTL0JBBt1kcZwZhSAlkprGuGiwOtVcukvYXWunLhxE3AGyRy7NSyxXBBahxlynrw88+1vKUkpkUGBif9TqrtjWCb4uYjtKjhnDvNb5UY1pLz3WI2RYQfKlI+7I7kiWkiObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398441; c=relaxed/simple;
	bh=1qzmhBhHc1ChB3XRzqrfwnaRoNmEoaSKgqyZdZ8pq7A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQoSPRIq8DJue/SaBUNM6yt0AnaOC4qn0M+SpJum8kVhwCFnPwslnrvJnj7fzIGhzDuIN2BW/CA8Kab001E/VTMoPhauhqMVC9chUP+qQxncT3dYqGllNqm5BHE57WpDN6qJHnXNpDSI0F6PJHK4MvtrkPoYGw0Ax8fmmjx2xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Onb5kYr6; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Onb5kYr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780398427; x=1780657627;
	bh=v01/alylbHJjCYWLYbLJhhJYmKJQqRdAcaqyreYlIBE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Onb5kYr6fsrAHNBSDvHgHAPk9/DpLjHij88k/GKEHL3m0NWrXsuGqPSvA5S+ga+vZ
	 uQlZsbLYY4WsbAmz6t772dZqCzqsRl6JcuiZKnknss9+rBzj3+A1DhLNnSAlfGrLn7
	 yvtyJkktbGe/Isz/dIntljGQXtLq29qQg9wY4SrgHgY5rpWfzWNOuYwDkbj15w3anX
	 1ch/n689fC9gZ2XzF2PwE2SRWHY8/yz2o1QunR23//IC9D5eV1oljNwPNZ8VBr8LB0
	 t3DDyrf3sLdfCMrGKnQssfY4TMqwobVl9YSyiI1/Y5FL8We8Nq/kAm9k2BT2jjg/Ty
	 Qz8zWQ5U5GnRA==
Date: Tue, 02 Jun 2026 11:07:03 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev
From: Tj <tj.iam.tj@proton.me>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Rafael Passos <rafael@rcpassos.me>
Subject: Re: [REGRESSION] RIP: 0010:hidinput_setup_battery.isra.0+0x6d/0x370 [hid]
Message-ID: <9fb130e7-29ab-485f-81aa-e3ecfd9eb1de@proton.me>
In-Reply-To: <b84a408c-b12c-40e5-b44b-62aa072cb285@leemhuis.info>
References: <ah6vRH9J9LSvnKWW@mail.iam.tj> <b84a408c-b12c-40e5-b44b-62aa072cb285@leemhuis.info>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: b3a3ad67b3807b3c9f8b2c7939da36ecb4947666
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks once again! That does look likely. Added this and the amdgpu=20
patch and doing a build now. Will report back for both if any progress,

On 02/06/2026 10:54, Thorsten Leemhuis wrote:
> On 6/2/26 12:24, Tj wrote:
>> Hitting this repeatedly with v7.1-rc6. Do not have time right now to
>> bisect it (and there are two other regressions at the same time).
> Again, not my area of expertise, but this looks somewhat similar (but
> also somewhat different!) to this recent regression report from Rafael:
> https://lore.kernel.org/all/20260602011949.2825852-1-rafael@rcpassos.me/
>
> Rafael (CCed) sent a fix for it already applied:
> HID: Input: Add battery list cleanup with devm action
> https://lore.kernel.org/all/20260602030519.3097058-1-rafael@rcpassos.me/
>
> Might be worth trying.
>
> Ciao, Thorsten
>
>> Symptom is unable to use the Bluetooth keyboard.
>>
>> It *seems* to be related to the Bluetooth keyboard - trying to shutdown
>> hangs for 6 minutes whilst systemd tries to kill bluetooth.service but f=
ails
>> and then fails to power-off (see end of log extracts).
>>
>> I'm not sure why I see 'samsung_probe' in the call trace since neither t=
he Bluetooth host
>> adapter nor the keyboard are Samsung but maybe some change related to
>> that is causing this.
>>
>> Jun 02 09:25:54 sunny kernel: BUG: unable to handle page fault for addre=
ss: ffffffffffffffe4
>> Jun 02 09:25:54 sunny kernel: #PF: supervisor read access in kernel mode
>> Jun 02 09:25:54 sunny kernel: #PF: error_code(0x0000) - not-present page
>> Jun 02 09:25:54 sunny kernel: Oops: Oops: 0000 [#1] SMP NOPTI
>> Jun 02 09:25:54 sunny kernel: CPU: 11 UID: 0 PID: 4009 Comm: (udev-worke=
r) Tainted: G        W  OE       7.1.0-rc6+debian+tj #446 PREEMPT(lazy)
>> Jun 02 09:25:54 sunny kernel: Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=
=3DUNSIGNED_MODULE
>> Jun 02 09:25:54 sunny kernel: Hardware name: System manufacturer System =
Product Name/PRIME X370-PRO, BIOS 6254 01/05/2026
>> Jun 02 09:25:54 sunny kernel: RIP: 0010:hidinput_setup_battery.isra.0+0x=
6d/0x370 [hid]
>> Jun 02 09:25:54 sunny kernel: Code: 48 ab 48 8b 42 68 48 8b 95 18 1c 00 =
00 8b 48 30 48 39 d3 74 45 48 8d 42 c8 eb 0f 66 90 48 8b 50 38 48 8d 42 c8 =
48 39 d3 74 30 <3b> 48 1c 75 ee 48 85 c0 74 26>
>> Jun 02 09:25:54 sunny kernel: RSP: 0018:ffffceacce2c7628 EFLAGS: 0001028=
6
>> Jun 02 09:25:54 sunny kernel: RAX: ffffffffffffffc8 RBX: ffff8b4856a83c1=
8 RCX: 0000000000000003
>> Jun 02 09:25:54 sunny kernel: RDX: 0000000000000000 RSI: 000000000000000=
0 RDI: ffffceacce2c7680
>> Jun 02 09:25:54 sunny kernel: RBP: ffff8b4856a82000 R08: ffffceacce2c773=
0 R09: ffffceacce2c772c
>> Jun 02 09:25:54 sunny kernel: R10: ffff8b488f290488 R11: ffff8b478bec900=
0 R12: ffffceacce2c7650
>> Jun 02 09:25:54 sunny kernel: R13: 0000000000000000 R14: 000000000000000=
0 R15: ffff8b47e6307b00
>> Jun 02 09:25:54 sunny kernel: FS:  00007f6ee16439c0(0000) GS:ffff8b4ed8f=
d0000(0000) knlGS:0000000000000000
>> Jun 02 09:25:54 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
>> Jun 02 09:25:54 sunny kernel: CR2: ffffffffffffffe4 CR3: 000000010b1c100=
0 CR4: 0000000000350ef0
>> Jun 02 09:25:54 sunny kernel: Call Trace:
>> Jun 02 09:25:54 sunny kernel:  <TASK>
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  ? dev_set_name+0x5c/0x80
>> Jun 02 09:25:54 sunny kernel:  hidinput_connect+0x935/0x5fb0 [hid]
>> Jun 02 09:25:54 sunny kernel:  hid_connect+0x3d5/0x6a0 [hid]
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  ? __wake_up_common+0x78/0xa0
>> Jun 02 09:25:54 sunny kernel:  hid_hw_start+0x40/0x70 [hid]
>> Jun 02 09:25:54 sunny kernel:  samsung_probe+0x31/0x70 [hid_samsung]
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  hid_device_probe+0x18d/0x220 [hid]
>> Jun 02 09:25:54 sunny kernel:  ? __pfx___device_attach_driver+0x10/0x10
>> Jun 02 09:25:54 sunny kernel:  really_probe+0xde/0x380
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  __driver_probe_device+0x84/0x150
>> Jun 02 09:25:54 sunny kernel:  driver_probe_device+0x1f/0xa0
>> Jun 02 09:25:54 sunny kernel:  __device_attach_driver+0x89/0x130
>> Jun 02 09:25:54 sunny kernel:  bus_for_each_drv+0x97/0xf0
>> Jun 02 09:25:54 sunny kernel:  __device_attach+0xaf/0x1c0
>> Jun 02 09:25:54 sunny kernel:  ? __pfx___hid_bus_reprobe_drivers+0x10/0x=
10 [hid]
>> Jun 02 09:25:54 sunny kernel:  device_reprobe+0x4e/0x90
>> Jun 02 09:25:54 sunny kernel:  ? __hid_bus_reprobe_drivers+0x3c/0x60 [hi=
d]
>> Jun 02 09:25:54 sunny kernel:  bus_for_each_dev+0x8e/0xe0
>> Jun 02 09:25:54 sunny kernel:  ? __pfx___hid_bus_driver_added+0x10/0x10 =
[hid]
>> Jun 02 09:25:54 sunny kernel:  __hid_bus_driver_added+0x2f/0x40 [hid]
>> Jun 02 09:25:54 sunny kernel:  bus_for_each_drv+0x97/0xf0
>> Jun 02 09:25:54 sunny kernel:  __hid_register_driver+0x74/0x80 [hid]
>> Jun 02 09:25:54 sunny kernel:  ? __pfx_samsung_driver_init+0x10/0x10 [hi=
d_samsung]
>> Jun 02 09:25:54 sunny kernel:  do_one_initcall+0x5c/0x320
>> Jun 02 09:25:54 sunny kernel:  do_init_module+0x60/0x250
>> Jun 02 09:25:54 sunny kernel:  init_module_from_file+0xd6/0x130
>> Jun 02 09:25:54 sunny kernel:  idempotent_init_module+0x114/0x310
>> Jun 02 09:25:54 sunny kernel:  __x64_sys_finit_module+0x71/0xe0
>> Jun 02 09:25:54 sunny kernel:  do_syscall_64+0xea/0x640
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  ? do_fault+0x341/0x530
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  ? __handle_mm_fault+0x977/0xf80
>> Jun 02 09:25:54 sunny kernel:  ? __memcg_slab_free_hook+0x16d/0x1c0
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  ? count_memcg_events+0xe5/0x1b0
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  ? __seccomp_filter+0x42/0x5d0
>> Jun 02 09:25:54 sunny kernel:  ? handle_mm_fault+0x1e2/0x2e0
>> Jun 02 09:25:54 sunny kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 02 09:25:54 sunny kernel:  ? do_syscall_64+0x9f/0x640
>> Jun 02 09:25:54 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Jun 02 09:25:54 sunny kernel: RIP: 0033:0x7f6ee111a7b9
>> Jun 02 09:25:54 sunny kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 =
0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b =
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48>
>> Jun 02 09:25:54 sunny kernel: RSP: 002b:00007ffe6dd96398 EFLAGS: 0000024=
6 ORIG_RAX: 0000000000000139
>> Jun 02 09:25:54 sunny kernel: RAX: ffffffffffffffda RBX: 0000556830869b9=
0 RCX: 00007f6ee111a7b9
>> Jun 02 09:25:54 sunny kernel: RDX: 0000000000000004 RSI: 00007f6ee16ed44=
d RDI: 0000000000000012
>> Jun 02 09:25:54 sunny kernel: RBP: 0000000000000004 R08: 000000000000000=
0 R09: 0000556830667bd0
>> Jun 02 09:25:54 sunny kernel: R10: 0000000000000000 R11: 000000000000024=
6 R12: 00007f6ee16ed44d
>> Jun 02 09:25:54 sunny kernel: R13: 0000000000020000 R14: 00005568307db67=
0 R15: 0000000000000000
>> Jun 02 09:25:54 sunny kernel:  </TASK>
>> Jun 02 09:25:54 sunny kernel: Modules linked in: hid_samsung(+) snd_seq_=
dummy snd_hrtimer snd_seq snd_seq_device uinput rpcsec_gss_krb5 nfsv4 dns_r=
esolver nfs netfs rdma_ucm ib_uverbs rdma_cm i>
>> Jun 02 09:25:54 sunny kernel:  uvcvideo wmi_bmof watchdog snd_timer igb =
rfkill uas mii pcspkr mxm_wmi videobuf2_vmalloc snd ccp k10temp uvc i2c_pii=
x4 dca videobuf2_memops soundcore videobuf2_v4>
>> Jun 02 09:25:54 sunny kernel: CR2: ffffffffffffffe4
>> Jun 02 09:25:54 sunny kernel: ---[ end trace 0000000000000000 ]---
>> Jun 02 09:25:54 sunny kernel: RIP: 0010:hidinput_setup_battery.isra.0+0x=
6d/0x370 [hid]
>> Jun 02 09:25:54 sunny kernel: Code: 48 ab 48 8b 42 68 48 8b 95 18 1c 00 =
00 8b 48 30 48 39 d3 74 45 48 8d 42 c8 eb 0f 66 90 48 8b 50 38 48 8d 42 c8 =
48 39 d3 74 30 <3b> 48 1c 75 ee 48 85 c0 74 26>
>> Jun 02 09:25:54 sunny kernel: RSP: 0018:ffffceacce2c7628 EFLAGS: 0001028=
6
>> Jun 02 09:25:54 sunny kernel: RAX: ffffffffffffffc8 RBX: ffff8b4856a83c1=
8 RCX: 0000000000000003
>> Jun 02 09:25:54 sunny kernel: RDX: 0000000000000000 RSI: 000000000000000=
0 RDI: ffffceacce2c7680
>> Jun 02 09:25:54 sunny kernel: RBP: ffff8b4856a82000 R08: ffffceacce2c773=
0 R09: ffffceacce2c772c
>> Jun 02 09:25:54 sunny kernel: R10: ffff8b488f290488 R11: ffff8b478bec900=
0 R12: ffffceacce2c7650
>> Jun 02 09:25:54 sunny kernel: R13: 0000000000000000 R14: 000000000000000=
0 R15: ffff8b47e6307b00
>> Jun 02 09:25:54 sunny kernel: FS:  00007f6ee16439c0(0000) GS:ffff8b4ed8f=
d0000(0000) knlGS:0000000000000000
>> Jun 02 09:25:54 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
>> Jun 02 09:25:54 sunny kernel: CR2: ffffffffffffffe4 CR3: 000000010b1c100=
0 CR4: 0000000000350ef0
>> Jun 02 09:25:54 sunny systemd-udevd[1703]: 0005:04E8:7021.0006: Worker [=
4009] terminated by signal 9 (KILL).
>>
>> Jun 02 09:29:16 sunny rpc.idmapd[3093]: exiting on signal 15
>> Jun 02 09:30:45 sunny systemd[1]: bluetooth.service: State 'stop-sigterm=
' timed out. Killing.
>> Jun 02 09:32:15 sunny systemd[1]: bluetooth.service: Processes still aro=
und after SIGKILL. Ignoring.
>> Jun 02 09:33:45 sunny systemd[1]: bluetooth.service: State 'final-sigter=
m' timed out. Killing.
>> Jun 02 09:35:15 sunny systemd[1]: bluetooth.service: Processes still aro=
und after final SIGKILL. Entering failed mode.
>> Jun 02 09:35:15 sunny systemd[1]: bluetooth.service: Failed with result =
'timeout'.
>>
>>


