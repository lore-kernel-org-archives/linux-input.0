Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C914D9913;
	Mon, 11 May 2026 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536798; cv=pass; b=uctoGgbY68Umw4lq+4WV7ZhdXewMc1+e6Nokv2s9CRO/vqR0prL3wlXie+fMr0y+7EeDAYf2bu4yD/FeIpqz6de4k/PEBMN2kQZjbB5JrlU4hLk98iYoU7TBiU+aw2+c+7hNU2BSItfxAnBDef2kdTVky3ze6MU2WohnOpkCaII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536798; c=relaxed/simple;
	bh=Phz6Xxlfb3d0IUFFCQMNCNI6hQ9U1/xKGaCprxgq5aQ=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Sj4D2d0tqXQGqN1MVwKK1w0u8kaEEswwweNeyQ4GKnSVzUJ5imlcpMQA1+Xy4y0+MWVxIL1SuoiAd5TFrwTSpMpy+Ptoc2uMSLh0iZhxUPZEDuZbUt/SCp8kKv15r/M8X7/wM0dtStuLTlH1o4TfXvgq2pU3mI8/AL5EFajvufg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seanbrar.com; spf=pass smtp.mailfrom=seanbrar.com; dkim=pass (1024-bit key) header.d=seanbrar.com header.i=hello@seanbrar.com header.b=PJrwUMtl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seanbrar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanbrar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seanbrar.com header.i=hello@seanbrar.com header.b="PJrwUMtl"
ARC-Seal: i=1; a=rsa-sha256; t=1778536787; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ccha1UEbzJpbdu2G1emnelh29EfTWv1RU33ouJxfewBCNV36DGJqkfbc8pVXS9KiLGk1TEHyghY8GqBu7+cW1WdtQ0+OcRNO4mhQi8xYpM+xihSQyll4UYlZNvl2Mld70WLagWocqJtzaeXerqQqHuyfrekG47euxreY18Q5hRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778536787; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mKcO1By3Rx7/K+xjO9536EewRIAVvzfiD5RjLwoi0V8=; 
	b=aCdrAA6v6/AC2lPh0dxZEvkWh7NDFXpABoyQFTZgbO+G2kfMdmj4QdJsBPrLVQZu0WAKgKA+9VkkGYnuSOphatJ969P13crrLG3ylpFI8i413wEYfR1Dgs0J/RzBR8ccuaje9SomFzc5srytaZzuqAnzlD2Yrtga+4VcZ0gzvuw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=seanbrar.com;
	spf=pass  smtp.mailfrom=hello@seanbrar.com;
	dmarc=pass header.from=<hello@seanbrar.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778536786;
	s=zmail; d=seanbrar.com; i=hello@seanbrar.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:To:To:Cc:Cc:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mKcO1By3Rx7/K+xjO9536EewRIAVvzfiD5RjLwoi0V8=;
	b=PJrwUMtly64tmsS7BF8cUCEUz5umzRcMIEitr86iFgFDN4o+jDWNn4/iEVMk3qLI
	TQm07VAI1YrSXrT/w9JKXsDDrxesYG/X6XzxEYG3HEZmiROJmpFNr1HnYwy05mWJaVp
	1QGx4l6EKym1yub3pj0E7POgrbBTixrObeZVA7M8=
Received: by mx.zohomail.com with SMTPS id 1778536783779690.4321626851674;
	Mon, 11 May 2026 14:59:43 -0700 (PDT)
Message-ID: <909876aa-7498-4ca4-b3a6-6618fbc6209d@seanbrar.com>
Date: Mon, 11 May 2026 14:58:30 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sean Brar <hello@seanbrar.com>
Content-Language: en-US
To: linux-input@vger.kernel.org, linux-sound@vger.kernel.org
Cc: roderick.colenbrander@sony.com, jikos@kernel.org, bentiss@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [BUG] ALSA: usb-audio: use-after-free in snd_dualsense_ih_match
 during rapid USB reconnect
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

A rapid USB disconnect/reconnect cycle on a DualSense controller
(054c:0ce6) triggers a use-after-free in snd_dualsense_ih_match()
(sound/usb/mixer_quirks.c), resulting in a general protection fault
and leaving the USB subsystem in an unrecoverable state requiring a
hard reboot.

Kernel version: 7.0.5-arch1-1 (also reproduced the trigger on
7.0.3-arch1-2; affected code in sound/usb/mixer_quirks.c is
unchanged on current mainline)

Hardware:
   - Sony DualSense Wireless Controller (054c:0ce6, bcdDevice=1.00)
   - hw_version=0x00000711, fw_version=0x0110002a
   - Host: Gigabyte B550 AORUS PRO AC, BIOS F17 03/22/2024

Trigger condition:

When connected to a degraded USB port (intermittent electrical
contact), the DualSense enters a rapid disconnect/reconnect cycle.
snd_usb_audio times out (ETIMEDOUT, -110) querying mixer controls
during probe, each timeout triggers a USB reset, and the device
reconnects every 1–2 seconds. This is not a driver bug, it's the
expected kernel behavior when USB communication is unreliable, but
it creates a race window for the use-after-free described below.

The bug:

In sound/usb/mixer_quirks.c, snd_dualsense_ih_match() is invoked as
an input handler match callback from input_register_device() during
ps_probe() (hid_playstation). At line 575, it obtains a pointer to
the USB device struct:

     snd_dev = mei->info.head.mixer->chip->dev;

It then uses this pointer in dev_warn() calls at lines 579 and 585:

     dev_warn(&snd_dev->dev, "Failed to get input dev path\n");
     dev_warn(&snd_dev->dev, "Failed to get USB dev path\n");

No reference is taken on snd_dev. If the USB device is concurrently
disconnected and freed while snd_dualsense_ih_match() is executing,
snd_dev becomes a dangling pointer. The dev_warn() call dereferences
snd_dev->dev.kobj.name via dev_vprintk_emit() → strnlen(), faulting
on the freed memory.

The OOPS offset (snd_dualsense_ih_match.cold+0xf/0x2b) corresponds
to the first dev_warn() at line 579. The compiler placed both error
branches in a cold section, and the offset is consistent with the
earlier branch.

OOPS:

   Oops: general protection fault, probably for non-canonical address 
0x441f0ffa1e0ff3: 0000 [#1] SMP NOPTI
   CPU: 14 UID: 0 PID: 108 Comm: kworker/14:0 Not tainted 7.0.5-arch1-1 
#1 PREEMPT(full)
   Hardware name: Gigabyte Technology Co., Ltd. B550 AORUS PRO AC/B550 
AORUS PRO AC, BIOS F17 03/22/2024
   Workqueue: usb_hub_wq hub_event
   RIP: 0010:strnlen+0x29/0x40
   RSP: 0018:ffffce3f40537378 EFLAGS: 00010202
   RAX: 00441f0ffa1e0ff3 RBX: 00441f0ffa1e0ff3 RCX: 0000000000000000
   RDX: 00441f0ffa1e1003 RSI: 0000000000000010 RDI: 00441f0ffa1e0ff3
   RBP: ffffce3f40537408 R08: 0000000000000000 R09: ffffce3f40537478
   R10: 0000000000000004 R11: ffffffffc20ebe12 R12: ffff8943511c80b0
   R13: ffff8943511c80b0 R14: ffff894345daf028 R15: ffffce3f40537418
   FS:  0000000000000000(0000) GS:ffff8962144e7000(0000) 
knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 000055e7f9dc3c18 CR3: 0000000135ffe000 CR4: 0000000000f50ef0

Stack trace:

   Call Trace:
    <TASK>
    dev_vprintk_emit+0x70/0x1b0
    dev_printk_emit+0x61/0x7b
    __dev_printk+0x2d/0x70
    _dev_warn+0x7f/0x99
    snd_dualsense_ih_match.cold+0xf/0x2b [snd_usb_audio 
a3e71fdbdb8c7ccfdfdb57dadc854b1d1e18445c]
    input_attach_handler.isra.0+0x4b/0xa0
    input_register_device.cold+0xf8/0x1f0
    ps_probe+0xf79/0x10dc [hid_playstation 
0cc5feea5231aa914fe418c8a06b14588cd5f064]
    hid_device_probe+0x1b8/0x270
    hid_add_device+0xcd/0x130
    usbhid_probe+0x49b/0x6c0
    usb_probe_interface+0xf8/0x2f0
    usb_set_configuration+0x738/0x920
    usb_generic_driver_probe+0x4a/0x70
    usb_probe_device+0x44/0x170
    usb_new_device.cold+0x154/0x3fd
    hub_event+0x129d/0x1ad0
    process_one_work+0x19c/0x3a0
    worker_thread+0x1b1/0x310
    kthread+0xe1/0x120
    ret_from_fork+0x2bc/0x350
    ret_from_fork_asm+0x1a/0x30
    </TASK>
   ---[ end trace 0000000000000000 ]---

Analysis:

The race is between two concurrent paths:

   1. Probe: hub_event → usb_new_device → ... → ps_probe →
      input_register_device → input_attach_handler →
      snd_dualsense_ih_match (accesses USB device struct at line 575)

   2. Disconnect: hub_event → usb_disconnect → ... → USB device
      struct freed

snd_dualsense_ih_match() retrieves snd_dev via the mixer→chip→dev
chain at line 575 without taking a reference. A concurrent disconnect
can free the USB device struct before the subsequent dev_warn() call
dereferences it. The faulting RDI value (0x441f0ffa1e0ff3) is
non-canonical and consistent with SLUB freed-object poisoning,
confirming a use-after-free.

Impact:

After the OOPS, the USB subsystem is left in an unrecoverable state:
all USB ports stop enumerating devices (including ports not involved
in the reconnect cycle), and a clean shutdown hangs in USB driver
teardown. A hard reset is required. The trigger condition (rapid USB
reconnection due to a degraded port) is a normal hardware failure
mode.

Workaround:

   # /etc/modprobe.d/dualsense.conf
   options snd_usb_audio ignore_ctl_error=1

This suppresses the mixer control timeouts that drive the reconnect
cycle, preventing the race window from opening. DualSense headphone
jack audio controls may not function correctly with this option.

Steps to reproduce:

   Disconnect/reconnect loop (the trigger condition):
   1. Load hid_playstation and snd_usb_audio (default on standard
      desktop kernels)
   2. Connect a DualSense (054c:0ce6) via USB to a port with
      unreliable electrical contact
   3. Observe rapid disconnect/reconnect in dmesg -w, with device
      number incrementing each cycle

   The OOPS:
   The OOPS was observed after the loop ran for several minutes. Exact
   timing-dependent reproduction beyond triggering the loop is not
   confirmed; this was observed once and not retested to avoid the
   unrecoverable USB hang.

Kernel .config (7.0.5-arch1-1): 
https://gist.github.com/seanbrar/d97a577efc3f48098d300105c4de398b
dmesg with OOPS (7.0.5-arch1-1): 
https://gist.github.com/seanbrar/994ed882ca6f25b93e4763a8906d0fd5
dmesg with reconnect loop (7.0.3-arch1-2): 
https://gist.github.com/seanbrar/188a75bf69fffe0d089f7aa82c6aebb6
