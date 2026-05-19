Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F739D6DD
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198275; cv=none; b=O99gPzdMOrj89c11V2a+Osl2NT+wUQb5RTbVod8ZL2jhWmQUbNfbXCInjPV3dspwSOabcayPRNIF4Fgk5cI2QWN9NIz7vIBcCSMYb+NYYXcAPqCRzRbpjoyd+pxQBHId8D6lyLVLvmAPyhVed2GfB9fY6u+WQnW7NA0/yS6zJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198275; c=relaxed/simple;
	bh=6+EpED8BgI54lFDjfE7lMDRUbz6UR474COMQ1D+gPik=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/sKg0qZZrrl/6w1iTzIvI1ZIZi61mmqV2UejzVHQLHurthXjI5p5YEi2M0/o2SZyqt1t/Y6naExmi7pl7YHfCtLtYFXXdYOBfp38QFBnJzsnid+fmxANivYuFY/z8qXeX8ShNM0bkQK53dlOaIM4xMPwtZxGV1awuo2RYvVBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1r74H7k4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dq4g0LKO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1r74H7k4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dq4g0LKO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1r74H7k4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dq4g0LKO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1r74H7k4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dq4g0LKO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D3D76816F;
	Tue, 19 May 2026 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779198271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiPB+vWfauYy2aT1mdXFpUlpbFYKlxRvswfYHykqDlQ=;
	b=1r74H7k4pn6rrK3ctslt0dioeMlA4TEILrjuIsAXQ+xyjcSM8cOXvUg5eIwJhvJpppB5E7
	9lULYOSFjOUU7OG0yW6QBVrSmgiquK8czRHHh3hRjjmPbrbn55uFTa4bThIifm9ZipiJcA
	rtwM58F1GYdiEFI7LdO/7gadSQ6I+R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779198271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiPB+vWfauYy2aT1mdXFpUlpbFYKlxRvswfYHykqDlQ=;
	b=Dq4g0LKOgprIlwRE3POy9MnFGkGwjT+ElppZHK4YeuQvqng2Ll0mdcVPJiHJQ1e8Lum383
	6gebYUsGxH5fh3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779198271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiPB+vWfauYy2aT1mdXFpUlpbFYKlxRvswfYHykqDlQ=;
	b=1r74H7k4pn6rrK3ctslt0dioeMlA4TEILrjuIsAXQ+xyjcSM8cOXvUg5eIwJhvJpppB5E7
	9lULYOSFjOUU7OG0yW6QBVrSmgiquK8czRHHh3hRjjmPbrbn55uFTa4bThIifm9ZipiJcA
	rtwM58F1GYdiEFI7LdO/7gadSQ6I+R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779198271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiPB+vWfauYy2aT1mdXFpUlpbFYKlxRvswfYHykqDlQ=;
	b=Dq4g0LKOgprIlwRE3POy9MnFGkGwjT+ElppZHK4YeuQvqng2Ll0mdcVPJiHJQ1e8Lum383
	6gebYUsGxH5fh3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B720593A8;
	Tue, 19 May 2026 13:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yPkGCj9pDGqtRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 19 May 2026 13:44:31 +0000
Date: Tue, 19 May 2026 15:44:26 +0200
Message-ID: <871pf7ms3p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sean Brar <hello@seanbrar.com>
Cc: linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	roderick.colenbrander@sony.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [BUG] ALSA: usb-audio: use-after-free in snd_dualsense_ih_match during rapid USB reconnect
In-Reply-To: <909876aa-7498-4ca4-b3a6-6618fbc6209d@seanbrar.com>
References: <909876aa-7498-4ca4-b3a6-6618fbc6209d@seanbrar.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=BIG5
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 

On Mon, 11 May 2026 23:58:30 +0200,
Sean Brar wrote:
> 
> A rapid USB disconnect/reconnect cycle on a DualSense controller
> (054c:0ce6) triggers a use-after-free in snd_dualsense_ih_match()
> (sound/usb/mixer_quirks.c), resulting in a general protection fault
> and leaving the USB subsystem in an unrecoverable state requiring a
> hard reboot.
> 
> Kernel version: 7.0.5-arch1-1 (also reproduced the trigger on
> 7.0.3-arch1-2; affected code in sound/usb/mixer_quirks.c is
> unchanged on current mainline)
> 
> Hardware:
>   - Sony DualSense Wireless Controller (054c:0ce6, bcdDevice=1.00)
>   - hw_version=0x00000711, fw_version=0x0110002a
>   - Host: Gigabyte B550 AORUS PRO AC, BIOS F17 03/22/2024
> 
> Trigger condition:
> 
> When connected to a degraded USB port (intermittent electrical
> contact), the DualSense enters a rapid disconnect/reconnect cycle.
> snd_usb_audio times out (ETIMEDOUT, -110) querying mixer controls
> during probe, each timeout triggers a USB reset, and the device
> reconnects every 1¡V2 seconds. This is not a driver bug, it's the
> expected kernel behavior when USB communication is unreliable, but
> it creates a race window for the use-after-free described below.
> 
> The bug:
> 
> In sound/usb/mixer_quirks.c, snd_dualsense_ih_match() is invoked as
> an input handler match callback from input_register_device() during
> ps_probe() (hid_playstation). At line 575, it obtains a pointer to
> the USB device struct:
> 
>     snd_dev = mei->info.head.mixer->chip->dev;
> 
> It then uses this pointer in dev_warn() calls at lines 579 and 585:
> 
>     dev_warn(&snd_dev->dev, "Failed to get input dev path\n");
>     dev_warn(&snd_dev->dev, "Failed to get USB dev path\n");
> 
> No reference is taken on snd_dev. If the USB device is concurrently
> disconnected and freed while snd_dualsense_ih_match() is executing,
> snd_dev becomes a dangling pointer. The dev_warn() call dereferences
> snd_dev->dev.kobj.name via dev_vprintk_emit() ¡÷ strnlen(), faulting
> on the freed memory.
> 
> The OOPS offset (snd_dualsense_ih_match.cold+0xf/0x2b) corresponds
> to the first dev_warn() at line 579. The compiler placed both error
> branches in a cold section, and the offset is consistent with the
> earlier branch.
> 
> OOPS:
> 
>   Oops: general protection fault, probably for non-canonical address
> 0x441f0ffa1e0ff3: 0000 [#1] SMP NOPTI
>   CPU: 14 UID: 0 PID: 108 Comm: kworker/14:0 Not tainted 7.0.5-arch1-1
> #1 PREEMPT(full)
>   Hardware name: Gigabyte Technology Co., Ltd. B550 AORUS PRO AC/B550
> AORUS PRO AC, BIOS F17 03/22/2024
>   Workqueue: usb_hub_wq hub_event
>   RIP: 0010:strnlen+0x29/0x40
>   RSP: 0018:ffffce3f40537378 EFLAGS: 00010202
>   RAX: 00441f0ffa1e0ff3 RBX: 00441f0ffa1e0ff3 RCX: 0000000000000000
>   RDX: 00441f0ffa1e1003 RSI: 0000000000000010 RDI: 00441f0ffa1e0ff3
>   RBP: ffffce3f40537408 R08: 0000000000000000 R09: ffffce3f40537478
>   R10: 0000000000000004 R11: ffffffffc20ebe12 R12: ffff8943511c80b0
>   R13: ffff8943511c80b0 R14: ffff894345daf028 R15: ffffce3f40537418
>   FS:  0000000000000000(0000) GS:ffff8962144e7000(0000)
> knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000055e7f9dc3c18 CR3: 0000000135ffe000 CR4: 0000000000f50ef0
> 
> Stack trace:
> 
>   Call Trace:
>    <TASK>
>    dev_vprintk_emit+0x70/0x1b0
>    dev_printk_emit+0x61/0x7b
>    __dev_printk+0x2d/0x70
>    _dev_warn+0x7f/0x99
>    snd_dualsense_ih_match.cold+0xf/0x2b [snd_usb_audio
> a3e71fdbdb8c7ccfdfdb57dadc854b1d1e18445c]
>    input_attach_handler.isra.0+0x4b/0xa0
>    input_register_device.cold+0xf8/0x1f0
>    ps_probe+0xf79/0x10dc [hid_playstation
> 0cc5feea5231aa914fe418c8a06b14588cd5f064]
>    hid_device_probe+0x1b8/0x270
>    hid_add_device+0xcd/0x130
>    usbhid_probe+0x49b/0x6c0
>    usb_probe_interface+0xf8/0x2f0
>    usb_set_configuration+0x738/0x920
>    usb_generic_driver_probe+0x4a/0x70
>    usb_probe_device+0x44/0x170
>    usb_new_device.cold+0x154/0x3fd
>    hub_event+0x129d/0x1ad0
>    process_one_work+0x19c/0x3a0
>    worker_thread+0x1b1/0x310
>    kthread+0xe1/0x120
>    ret_from_fork+0x2bc/0x350
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> Analysis:
> 
> The race is between two concurrent paths:
> 
>   1. Probe: hub_event ¡÷ usb_new_device ¡÷ ... ¡÷ ps_probe ¡÷
>      input_register_device ¡÷ input_attach_handler ¡÷
>      snd_dualsense_ih_match (accesses USB device struct at line 575)
> 
>   2. Disconnect: hub_event ¡÷ usb_disconnect ¡÷ ... ¡÷ USB device
>      struct freed
> 
> snd_dualsense_ih_match() retrieves snd_dev via the mixer¡÷chip¡÷dev
> chain at line 575 without taking a reference. A concurrent disconnect
> can free the USB device struct before the subsequent dev_warn() call
> dereferences it. The faulting RDI value (0x441f0ffa1e0ff3) is
> non-canonical and consistent with SLUB freed-object poisoning,
> confirming a use-after-free.
> 
> Impact:
> 
> After the OOPS, the USB subsystem is left in an unrecoverable state:
> all USB ports stop enumerating devices (including ports not involved
> in the reconnect cycle), and a clean shutdown hangs in USB driver
> teardown. A hard reset is required. The trigger condition (rapid USB
> reconnection due to a degraded port) is a normal hardware failure
> mode.
> 
> Workaround:
> 
>   # /etc/modprobe.d/dualsense.conf
>   options snd_usb_audio ignore_ctl_error=1
> 
> This suppresses the mixer control timeouts that drive the reconnect
> cycle, preventing the race window from opening. DualSense headphone
> jack audio controls may not function correctly with this option.
> 
> Steps to reproduce:
> 
>   Disconnect/reconnect loop (the trigger condition):
>   1. Load hid_playstation and snd_usb_audio (default on standard
>      desktop kernels)
>   2. Connect a DualSense (054c:0ce6) via USB to a port with
>      unreliable electrical contact
>   3. Observe rapid disconnect/reconnect in dmesg -w, with device
>      number incrementing each cycle
> 
>   The OOPS:
>   The OOPS was observed after the loop ran for several minutes. Exact
>   timing-dependent reproduction beyond triggering the loop is not
>   confirmed; this was observed once and not retested to avoid the
>   unrecoverable USB hang.
> 
> Kernel .config (7.0.5-arch1-1):
> https://gist.github.com/seanbrar/d97a577efc3f48098d300105c4de398b
> dmesg with OOPS (7.0.5-arch1-1):
> https://gist.github.com/seanbrar/994ed882ca6f25b93e4763a8906d0fd5
> dmesg with reconnect loop (7.0.3-arch1-2):
> https://gist.github.com/seanbrar/188a75bf69fffe0d089f7aa82c6aebb6

Thanks for the report.

As this is involved with two individual devices, I wonder the bug is
triggered at which timing -- has the sound interface been already
disconnected (or being disconnected) while the input is being probed?

In such a case, does the change below help?


Takashi

-- 8< --
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -705,14 +705,15 @@ static int snd_dualsense_resume_jack(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
-static void snd_dualsense_mixer_elem_free(struct snd_kcontrol *kctl)
+static void snd_dualsense_mixer_free(struct usb_mixer_interface *mixer)
 {
-	struct dualsense_mixer_elem_info *mei = snd_kcontrol_chip(kctl);
+	struct dualsense_mixer_elem_info *mei = mixer->private_data;
 
-	if (mei->ih.event)
+	if (mei && mei->ih.event) {
 		input_unregister_handler(&mei->ih);
-
-	snd_usb_mixer_elem_free(kctl);
+		mei->ih.event = NULL;
+	}
+	mixer->private_data = NULL;
 }
 
 static int snd_dualsense_jack_create(struct usb_mixer_interface *mixer,
@@ -744,7 +745,7 @@ static int snd_dualsense_jack_create(struct usb_mixer_interface *mixer,
 	}
 
 	strscpy(kctl->id.name, name, sizeof(kctl->id.name));
-	kctl->private_free = snd_dualsense_mixer_elem_free;
+	kctl->private_free = snd_usb_mixer_elem_free;
 
 	err = snd_usb_mixer_add_control(&mei->info.head, kctl);
 	if (err)
@@ -774,6 +775,9 @@ static int snd_dualsense_jack_create(struct usb_mixer_interface *mixer,
 		dev_warn(&mixer->chip->dev->dev,
 			 "Could not register input handler: %d\n", err);
 		mei->ih.event = NULL;
+	} else {
+		mixer->private_free = snd_dualsense_mixer_free;
+		mixer->private_data = mei;
 	}
 
 	return 0;
