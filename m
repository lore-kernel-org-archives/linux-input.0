Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0793F1AA3
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720458; cv=none; b=M7WTw+XF/+V96VzJAwDgI5+9D0TxgPyM96y71vw/6nW6g7bhfVfO1YxT3RslcBS+f7XKiNKz4V5PZUyKcndxaHDXusqSjX6TbmkpxodEVsXxwDMZ9IkCRTcU6yjdAF1oj9Ryhy9l5hwkMw5CgSfEkkKvPfUruvgiUZFpaPCM10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720458; c=relaxed/simple;
	bh=mkD8QRIn3JuV7yNqESYw+zlQwNg2kLRlGDD48mqyjAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3m5Drt9ITzrRL7bk6tP1e7AYE/pX3toX5FviQePVgtq1XzMVfQjig8dDMVipY2iNfBtt4oHYE0MQNCBD+uNAXzxxPR+GUl1uxfsiQNuIZGHFgdCv4UYa8R4sc9z+ZAAKtEqHV84HExv2IfDr4Eguj3PJ9dSbQwAOtKOadk2/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ijd5WoWd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2lns6D7x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ijd5WoWd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2lns6D7x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ijd5WoWd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2lns6D7x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ijd5WoWd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2lns6D7x"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 617296B3BC;
	Mon, 25 May 2026 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779720454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CnHL+v/fE86ihARb1ECVNTWnZ5X648OkJeYAiSoEL8Y=;
	b=Ijd5WoWdAE3mBlUTqNpc3V7/JOqVrr+FSiPhAQIN9fyI8fRhTwZ41u48Lklt+h+A5Z6qW2
	ctFR3B7UFW5F5xB2ueOiKeBdAv61DicfIlZ4Jrlc44SBnp1F0BQL2yViJXHqcEtB7ac7S9
	sgLzPSppS3m2apHx2nN7S7J5TWrhtIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779720454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CnHL+v/fE86ihARb1ECVNTWnZ5X648OkJeYAiSoEL8Y=;
	b=2lns6D7xP8m4STOLWt97aEAI2Cuxw6VLffi7HNLn4cIAJZtQG6AU9rEZjRImuPTTrmDjdf
	k72g8QaIqR3EePAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ijd5WoWd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2lns6D7x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779720454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CnHL+v/fE86ihARb1ECVNTWnZ5X648OkJeYAiSoEL8Y=;
	b=Ijd5WoWdAE3mBlUTqNpc3V7/JOqVrr+FSiPhAQIN9fyI8fRhTwZ41u48Lklt+h+A5Z6qW2
	ctFR3B7UFW5F5xB2ueOiKeBdAv61DicfIlZ4Jrlc44SBnp1F0BQL2yViJXHqcEtB7ac7S9
	sgLzPSppS3m2apHx2nN7S7J5TWrhtIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779720454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CnHL+v/fE86ihARb1ECVNTWnZ5X648OkJeYAiSoEL8Y=;
	b=2lns6D7xP8m4STOLWt97aEAI2Cuxw6VLffi7HNLn4cIAJZtQG6AU9rEZjRImuPTTrmDjdf
	k72g8QaIqR3EePAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5508559CCA;
	Mon, 25 May 2026 14:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yaa8FAZhFGpURQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 14:47:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EBAE2A08D7; Mon, 25 May 2026 16:47:29 +0200 (CEST)
Date: Mon, 25 May 2026 16:47:29 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+27ce6cc06c1311c152f5@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [usb?] [input?] INFO: rcu detected stall in
 __fsnotify_parent (3)
Message-ID: <jyhoqyjypehmngnxaqr7f3kwmrzuz7n32wijzezedbvmc4gv4r@zj2s4igmugtm>
References: <6a0cce0d.170a0220.3cbd30.0138.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a0cce0d.170a0220.3cbd30.0138.GAE@google.com>
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 617296B3BC
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org,googlegroups.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[27ce6cc06c1311c152f5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO

Hello!

On Tue 19-05-26 13:54:37, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    6916d5703ddf Merge tag 'drm-fixes-2026-05-16' of https://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13437cc8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
> dashboard link: https://syzkaller.appspot.com/bug?extid=27ce6cc06c1311c152f5
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123e8596580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/637181391a5c/disk-6916d570.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bfbefc8a3671/vmlinux-6916d570.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a419831b32a6/bzImage-6916d570.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+27ce6cc06c1311c152f5@syzkaller.appspotmail.com
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P4963/1:b..l
> 
> rcu: 	(detected by 1, t=10506 jiffies, g=15565, q=1900 ncpus=2)
> task:acpid           state:R
>   running task     stack:22856 pid:4963  tgid:4963  ppid:1      task_flags:0x400040 flags:0x00080001

FWIW all the reproducer does is some games with USB, no signs of fsnotify.
Bisection has failed, the problem was hit only once more than a week ago.
I'm going to sign this off to some random fluctuation.

								Honza

> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5388 [inline]
>  __schedule+0x1295/0x67a0 kernel/sched/core.c:7189
>  preempt_schedule_irq+0x50/0x90 kernel/sched/core.c:7513
>  irqentry_exit_to_kernel_mode_preempt include/linux/irq-entry-common.h:476 [inline]
>  irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:547 [inline]
>  irqentry_exit+0x205/0x7e0 kernel/entry/common.c:164
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> RIP: 0010:lock_acquire+0x5e/0x370 kernel/locking/lockdep.c:5872
> Code: 05 3b a2 26 12 83 f8 07 0f 87 d9 02 00 00 48 0f a3 05 46 41 f3 0e 0f 82 a4 02 00 00 8b 35 ce 74 f3 0e 85 f6 0f 85 bf 00 00 00 <48> 8b 44 24 30 65 48 2b 05 dd a1 26 12 0f 85 ed 02 00 00 48 83 c4
> RSP: 0018:ffffc9000342fb30 EFLAGS: 00000206
> 
> RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8defcf06 RDI: ffffffff8c1c3a00
> RBP: ffffffff8e7e57a0 R08: 0000000086db7919 R09: 0000000000000007
> R10: 0000000000000200 R11: 0000000000000000 R12: 0000000000000002
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  rcu_read_lock include/linux/rcupdate.h:838 [inline]
>  dput.part.0+0x4c/0x570 fs/dcache.c:971
>  dput+0x1f/0x30 fs/dcache.c:968
>  __fsnotify_parent+0x694/0xca0 fs/notify/fsnotify.c:242
>  fsnotify_parent include/linux/fsnotify.h:96 [inline]
>  fsnotify_path include/linux/fsnotify.h:113 [inline]
>  fsnotify_file include/linux/fsnotify.h:127 [inline]
>  fsnotify_file include/linux/fsnotify.h:116 [inline]
>  fsnotify_access include/linux/fsnotify.h:425 [inline]
>  vfs_read+0x486/0xb30 fs/read_write.c:578
>  ksys_read+0x1f8/0x250 fs/read_write.c:717
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7feac7fb3407
> RSP: 002b:00007ffc6dd51e00 EFLAGS: 00000202
>  ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007feac7f29780 RCX: 00007feac7fb3407
> RDX: 0000000000000018 RSI: 00007ffc6dd51e50 RDI: 000000000000000b
> RBP: 00007ffc6dd51e50 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000556e2f8031e4
> R13: 0000556e4a9f2380 R14: 0000000000000007 R15: 000000000000000b
>  </TASK>
> rcu: rcu_preempt kthread starved for 4298 jiffies! g15565 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R
>   running task     stack:27992 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5388 [inline]
>  __schedule+0x1295/0x67a0 kernel/sched/core.c:7189
>  __schedule_loop kernel/sched/core.c:7268 [inline]
>  schedule+0xdd/0x390 kernel/sched/core.c:7283
>  schedule_timeout+0x127/0x280 kernel/time/sleep_timeout.c:99
>  rcu_gp_fqs_loop+0x1a9/0x900 kernel/rcu/tree.c:2095
>  rcu_gp_kthread+0x179/0x230 kernel/rcu/tree.c:2297
>  kthread+0x370/0x450 kernel/kthread.c:436
>  ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> rcu: Stack dump where RCU GP kthread last ran:
> CPU: 1 UID: 0 PID: 5978 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> RIP: 0010:write_comp_data+0x40/0x90 kernel/kcov.c:246
> Code: 02 12 a9 00 01 ff 00 74 1b f6 c4 01 74 07 a9 00 00 ff 00 74 05 c3 cc cc cc cc 8b 87 d4 16 00 00 85 c0 74 f1 8b 87 b0 16 00 00 <83> f8 03 75 e6 48 8b 87 b8 16 00 00 8b bf b4 16 00 00 48 8b 30 48
> RSP: 0018:ffffc900024af648 EFLAGS: 00000246
> 
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81fc2bcd
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff88805a5e0000
> RBP: ffff8880b8443320 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000003
> R13: ffffed1017088665 R14: 0000000000000001 R15: ffff8880b853c5c0
> FS:  0000000000000000(0000) GS:ffff88812446d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8c6e1b56e8 CR3: 0000000059a89000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  csd_lock_wait kernel/smp.c:342 [inline]
>  smp_call_function_many_cond+0x5ad/0x1700 kernel/smp.c:892
>  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1057
>  __flush_tlb_multi arch/x86/include/asm/paravirt.h:46 [inline]
>  flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
>  flush_tlb_mm_range+0x45f/0x16f0 arch/x86/mm/tlb.c:1451
>  tlb_flush arch/x86/include/asm/tlb.h:23 [inline]
>  tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:509 [inline]
>  tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:499 [inline]
>  tlb_flush_mmu mm/mmu_gather.c:423 [inline]
>  tlb_finish_mmu+0x3fe/0x810 mm/mmu_gather.c:549
>  exit_mmap+0x454/0xa10 mm/mmap.c:1313
>  __mmput+0x12a/0x410 kernel/fork.c:1178
>  mmput+0x67/0x80 kernel/fork.c:1201
>  exit_mm kernel/exit.c:582 [inline]
>  do_exit+0x8b2/0x2af0 kernel/exit.c:964
>  do_group_exit+0xd5/0x2a0 kernel/exit.c:1119
>  get_signal+0x20ff/0x2210 kernel/signal.c:3037
>  arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
>  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
>  exit_to_user_mode_loop+0x8b/0x4f0 kernel/entry/common.c:98
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>  do_syscall_64+0x706/0xf80 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7a9eb5d68e
> Code: Unable to access opcode bytes at 0x7f7a9eb5d664.
> RSP: 002b:00007fffdcda5708 EFLAGS: 00000246
>  ORIG_RAX: 00000000000000e6
> RAX: 0000000000000000 RBX: 000055558fc36500 RCX: 00007f7a9eb5d68e
> RDX: 00007fffdcda5760 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffdcda58b0
> R13: 00007f7a9ee15fac R14: 000000000002bbe6 R15: 00007f7a9ee15fa0
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
