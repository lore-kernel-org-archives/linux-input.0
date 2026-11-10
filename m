Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299670;
	b=dH28MdCgKLQ+k1B2vKg1/xsmIjKFP4YZfWEV83nXZSlVhkG6XsTNtmv84IKd4vZxyqB6
	 XHLmN3zHZbKqsjmFAiXKSgz8EufzePJxNu97Sa1R153FiRqaUYgnEmfm5xAeJsMlOsiJ3
	 BX8nKJQ0juFeAAkbMbT3RvFVAe6F0uWOotXIl8qBw2hhU9hyJpnosclFtBdV9CPU14WE2
	 oiU89mAK+0tzl7ILkIWqM8r0pD6BXjzTJiAqnwUv/9L35ekz5ArC+vUMdp0ItuUk6Zf+v
	 wpcaGm2caXGfc1Jae5yf8jbv6i0EGu1Wj3RLS9GPMQSJCaLP48g+hWrlfQwOjqAx2HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299670;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+0DFsat6HGEG0Ui1VpQrxBAhenhjb9E7KcBuhAvNLeY=;
	b=nL7g7p8HABVJIsNVnIcUactKdj4rpblS7DqnU9UQ4p7yCFWKEYvYeaqFRrwdgLgo9nr5
	 l95CFYJGiaywBKcG7wwbcw8J0JmN1BnCePQdBvw7HFwGHJ0qKSMR8ClTv8XfafkNpoNPt
	 6r9FionxfzKxZfeu9GXtmbXYaCTCElBTtC0OdBWvlM/GzP0CtRNFFmB7KN5CGQN3HdmUj
	 O96kViMSkqI44YGScYj1VNXBpQiJM/f3pGexByInVM0Oq9kwTKgsTet1rqbNreirAzDCb
	 rHJ+8s6BjgrCSBOFNNPooRyAu2QmHckjmRmSm6/T49aK5Nzn6dKU4MprTgTm9hyCAcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bfy6FPpM;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A95606A325;
	Tue, 10 Nov 2026 08:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A95606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bfy6FPpM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794299669; x=1825835669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B3p61jrf+nsQC7sIOAEE7VMzoMSJIUaY/w/demMcwOU=;
  b=bfy6FPpM9kl9HMQU35kwjQymfj3M9gvavf7gmdCS0TO5SLFs6zV4qBFz
   mE+bDtRCEJxexMJsJk6FiZy1WOERl2QCUy0DeaTz/t6g5Q/B/7OAVVD1j
   PogCgIqCIHSekw95eeNx4N7fcJC6JO0T7RKXtEZhk1FHnffS15RHDh4Cx
   2Qwt0BZoIbGGbNpDf12fPaWDovDnSOjKbZjSnJUiE3GjZpZv9DlTAj5pB
   CDn/T4OhHqQExh2ugqKDxVF1rBdYGGrXwSQ7fKkbG0+FNkzzw1fK+YopM
   TiywJ1wjLTwGdlupI9Zvsr6GzRMK/hRd4amOMuviXXlXSa5o4II2J5eT0
   g==;
X-CSE-ConnectionGUID: Nla0e7YTTIaixBnwVsUWnA==
X-CSE-MsgGUID: YufTclOJSLGvEbQlablDxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2931172"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2931172"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 00:34:29 -0800
X-CSE-ConnectionGUID: Dys+fUCcQEyOupHilPHr7w==
X-CSE-MsgGUID: UY7VI49FRUy7l0bZ9JjQWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7918904"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.1]) ([10.245.245.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 00:34:27 -0800
Message-ID: <079cf13d-542b-4084-9023-06a89fa4ea97@linux.intel.com>
Date: Tue, 10 Nov 2026 10:34:24 +0200
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [BUG] HID: steelseries-arctis: NULL deref in
 xhci_urb_enqueue from status timer during resume from suspend (Arctis 9) ->
 system hang
To: Olli Salenius <opsalenius@gmail.com>, linux-input@vger.kernel.org,
 bentiss@kernel.org, jikos@kernel.org
Cc: linux-usb@vger.kernel.org, git@mayer-bgk.de,
 "hadess@hadess.net" <hadess@hadess.net>,
 "srimanachanta@gmail.com" <srimanachanta@gmail.com>,
 "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
 =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
References: <CACQx0bG8+c9+CjLRa-tbgGkc5_4Wxhmanbd2vToo8Aj8k_WUYw@mail.gmail.com>
 <CACQx0bG4bvt4bHa+WG4u2UGmUc_YMUnhpWovz5+rzp76Jpb9ZA@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CACQx0bG4bvt4bHa+WG4u2UGmUc_YMUnhpWovz5+rzp76Jpb9ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 11/8/26 09:35, Olli Salenius wrote:
> Hi,
> 
> The hid-steelseries-arctis driver reliably-but-intermittently freezes the
> whole machine on resume from suspend (S3 and s2idle). The battery/status
> polling work submits a HID control request to the Arctis 9 dongle while
> the device is still being reset/re-enumerated by the xHCI controller after
> resume, which oopses in xhci_urb_enqueue(). The oops happens in a context
> that takes down the system (keyboard dead, no log reaches disk); I could
> only capture it via efi-pstore.
> 
> Blacklisting hid_steelseries_arctis fixes the hang completely.
> 
> Environment
> -----------
> Kernel:   7.3.1-1-cachyos (CachyOS build, x86_64, PREEMPT(full))
> Board:    ASUS TUF GAMING B550-PLUS, BIOS 3645 09/10/2026
> CPU/GPU:  AMD Ryzen 7 5800X3D, AMD Radeon RX 9070 (Navi 48)
> Headset:  SteelSeries Arctis 9 wireless
>            1038:12c2 (HID interface, bcdDevice 1.01) -> bound to
>                       hid-steelseries-arctis
>            1038:12c4 (audio + HID, bcdDevice 0.03)  -> snd-usb-audio
>            both behind an Alcor Micro hub (058f:9254), on the AMD 500
>            series chipset xHCI controller (0000:02:00.0, 1022:43ee)
> 
> Steps to reproduce
> ------------------
> 1. Arctis 9 dongle plugged in, hid-steelseries-arctis loaded.
> 2. systemctl suspend (deep/S3; also reproduced with s2idle).
> 3. Wake. In roughly half or more of the attempts the machine hangs: black
>     screen (occasionally the desktop appears and then freezes), keyboard
>     LEDs unresponsive, hard reset required.
> 
> Every resume on this controller logs:
>    xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
>    usb usb1: root hub lost power or was reset
> after which the dongle is reset/disconnected and re-enumerated, sometimes
> with "device descriptor read/64, error -71" retries taking ~2 s. The crash
> happens inside that window.
> 
> Oops (captured via efi_pstore)
> ------------------------------
> [  116.909249] PM: suspend entry (deep)
> [  119.777239] ACPI: PM: Waking up from system sleep state S3
> [  119.920603] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
> ...
> [  123.275980] usb 1-3.1: WARN: invalid context state for evaluate
> context command.
> [  123.300361] BUG: kernel NULL pointer dereference, address: 0000000000000020
> [  123.300363] #PF: supervisor read access in kernel mode
> [  123.300365] #PF: error_code(0x0000) - not-present page
> [  123.300367] PGD 0 P4D 0
> [  123.300369] Oops: Oops: 0000 [#1] SMP NOPTI
> [  123.300372] CPU: 1 UID: 0 PID: 287 Comm: kworker/1:2 Not tainted
> 7.3.1-1-cachyos #1 PREEMPT(full)
> [  123.300375] Hardware name: ASUS System Product Name/TUF GAMING
> B550-PLUS, BIOS 3645 09/10/2026
> [  123.300377] Workqueue: events steelseries_status_timer_work_handler
> [hid_steelseries_arctis]
> [  123.300381] RIP: 0010:xhci_urb_enqueue+0x1c8/0x350
> [  123.300386] Code: 0f 84 58 ff ff ff 48 8d bb 48 02 00 00 49 8b 44
> 24 40 8b 88 70 05 00 00 48 8b 83 a0 03 00 00 48 8b 04 c8 48 8b 90 88
> 12 00 00 <f6> 42 20 01 0f 85 c9 00 00 00 f6 83 d8 03 00 00 01 0f 85 f1
> 00 00
> [  123.300388] RSP: 0018:ffffcde6417d3cd8 EFLAGS: 00010002
> [  123.300390] RAX: ffff89fb0b84a000 RBX: ffff89fb01eb8800 RCX: 0000000000000002
> [  123.300391] RDX: 0000000000000000 RSI: ffff89fb015f9800 RDI: ffff89fb01eb8a48
> [  123.300392] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffffb8810860
> [  123.300394] R10: 0000000000000001 R11: ffffffffb6e6a730 R12: ffff89fcb89bc780
> [  123.300395] R13: ffff89fb01eb8800 R14: ffff89fd2854ee00 R15: 00000000ffffff94
> [  123.300399] CR2: 0000000000000020 CR3: 00000002d7e75000 CR4: 0000000000f50ef0
> [  123.300401] Call Trace:
> [  123.300402]  <TASK>
> [  123.300405]  usb_hcd_submit_urb+0x91/0x190
> [  123.300408]  usb_start_wait_urb+0x8f/0x1d0
> [  123.300412]  usb_control_msg+0xdd/0x150
> [  123.300415]  usbhid_raw_request+0x11e/0x140
> [  123.300419]  steelseries_arctis_9_request_status+0x63/0xb0
> [hid_steelseries_arctis]
> [  123.300422]  steelseries_status_timer_work_handler+0x21/0x70
> [hid_steelseries_arctis]
> [  123.300424]  process_scheduled_works+0x21f/0x650
> [  123.300428]  worker_thread+0x193/0x3b0
> [  123.300432]  kthread+0xfd/0x130
> [  123.300436]  ret_from_fork+0xec/0x2b0
> [  123.300441]  ret_from_fork_asm+0x1a/0x30
> [  123.300446]  </TASK>
> [  123.300527] CR2: 0000000000000020
> [  123.300532] WARNING: kernel/printk/printk.c:4631 at
> wake_up_klogd+0x64/0x80, CPU#1: kworker/1:2/287
>                 (console_irqwork_blocked)
> 
> Analysis
> --------
> The status timer/work keeps running across system suspend/resume and
> fires while the USB device is being reset after the xHC "Reinit". The
> control request then reaches xhci_urb_enqueue() for a device whose
> endpoint state has not been rebuilt yet (NULL at offset 0x20).
> 
> Looking at drivers/hid/hid-steelseries-arctis.c (new in v7.3; unchanged
> in current master, hid.git for-next and linux-next), the driver has no
> .suspend/.resume/.reset_resume callbacks:
> 
>    static struct hid_driver steelseries_arctis_driver = {
>            .name = "hid-steelseries-arctis",
>            .id_table = steelseries_arctis_devices,
>            .probe = steelseries_arctis_probe,
>            .remove = steelseries_arctis_remove,
>            .raw_event = steelseries_arctis_raw_event,
>    };
> 
> and steelseries_status_timer_work_handler() unconditionally re-arms
> status_work (for non-async devices such as the Arctis 9); it is only
> cancelled in remove. So the poll keeps firing across system sleep.
> 
> Suggested fix: cancel_delayed_work_sync(&sd->status_work) in a .suspend
> callback, and re-schedule it from .resume and .reset_resume. Separately,
> it may be worth a look from the USB side whether xhci_urb_enqueue()
> should reject rather than dereference in this state.
> 
> Possibly related: on the 6.18 LTS kernel, where the Arctis 9 (1038:12c2)
> is handled by hid-steelseries instead, I also saw identical resume hangs,
> but I did not capture a trace there.
xhci should not crash even if something is misbehaving and sending URBs during
resume. The timer should also be fixed, but I'm now only looking at the xhci side

There are some pending xhci fixes in this area. Michal just posted a patch that
touches the "WARN: invalid context state for evaluate context command" case in
your log.

I added another patch for the NULL pointer deref.

All relevant patches for this case are now in a test branch named
"fix_null_deref_reset_resume" in my tree. (based on Greg's usb-linus branch)

git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git fix_null_deref_reset_resume
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=fix_null_deref_reset_resume

Much appreciated if you can give that a try

Thanks
Mathias

