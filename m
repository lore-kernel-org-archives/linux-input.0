Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304636;
	b=30pLnqNckcXJRYGX7fYRyhElcdumzKKIQF5+XNLXvAFyLUMR7LOywhGnjrfgFgYpfpdR
	 oDZ63Id0eJPcblZnUaBIddKqnlpO/llBrgE4B3ScxpNhlchjMzqwGIqLGjHDaIdR1mxOA
	 x0EDx/0x6j3KCADmsmLW+HlkipU9A5TWXipPh4p+q5QMhNfthA1v1Lb7h2cz01Pjam586
	 bzrQ4kxRrz9AKS17j/LdgSAA+Ou4rjs9FwFEhZlF5BlzXrMMVnzDicC15CPvn9mGSx1/H
	 zJir2wp8Yml1xjEOT6JJApCTfT8yFFx97FBk1Vm/lI/L9Tv5mOgO+DMOPueCI7AJvNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dlNXIhv6eqGscBTk6V4oYMM/cSYpSBGcNmWx8Y14Imc=;
	b=xexrwJGRyEpmiDugoZCM6u8yTYGy97wOkq6CVTF9icpmW2OpbVj0sovP0XlKxZA0C3ii
	 MqMXT5bYN3fwJ74GmH7w55C4Rgb/VoqM93+Xrbqd08EgP9Q5bu0jquAz77pZU0HStlMfW
	 9PLDjVAXEZHqS1VCNsY2pimpHwiRdMDXv/e0ByUoYrEGEhpTB5PrP04JvHF651Om319vG
	 VheoWCkhPA50nDmf9rqJ6SKZdhn0Ps2lcxHdX2EX7lbOndjgjGYDjo9nyHRr1MJwd4phb
	 GDRBu0AS55bXLDxXmf5gVyMCareI+Ag7MuUmp3nWaK7/mffgaVr6N9CSNe7PQ9GExEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QbIewryO;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C326606A33E
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 09:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C326606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QbIewryO
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e46e449e8so1200612f8f.3
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 01:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794304635; x=1794909435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dlNXIhv6eqGscBTk6V4oYMM/cSYpSBGcNmWx8Y14Imc=;
        b=QbIewryOXADThCJKESyB/mEZaODTY3TSpRho1nFLWL0pAx0MO221phtDSk3mI0m4Sq
         RadYaAh/mMG3AP+YzNkkvIiNbuL1St4FgJ8bMNOo2E26RF1OveTbRlUA2CV1y6f56K6v
         HcvzqleQ8XOmmJ72FMS455THY26dKCJt6rIoqneEM9yKZ4ocvTNgobEYbtJ51REZWp6S
         53LtokTK8iz3fAfQaKqHxRYEJp6yNbcU91qY5za8cwCigkalrlk3eY2cjUWU+Pzrcqi9
         +Tj7tiCjBjGvItC/4/w/HAAippFWyrZH6BBu8W4bamEe1rFrdJCwOv/bxfTVEC8llMkd
         HLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304635; x=1794909435;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlNXIhv6eqGscBTk6V4oYMM/cSYpSBGcNmWx8Y14Imc=;
        b=x/cOqv+htXRB2p4ns1xDm/pzVQuDjnULgei3bEghbJscG3fgMLoCoSTRt3tuPkKgVC
         gi7/bKYvr7J6pbUXBNCASAv2gvKYklX9MaEU2R6bBIHccIn7FKYrUJnaOhoB7CaaPew7
         ShgyRuej/FKfG4r6vwIFgrfdg7peFGbrX1d4KNaNmFguMDGzdkLz2Pmtt9/1olt67Qpa
         U/tR26ArarVG3bvPHEMdUEWCzoN9Frf9J1/JR8kJacwoYXaRJC9AnyJTlpPYyQLcBBc4
         dEQX/vHQkqLKHbXhLDjfPgv1BAByO9Kfz+04g224iQBVg4T7WeX4F2tKL1vf0DYiNOBd
         MphQ==
X-Forwarded-Encrypted: i=1; AL+hErFIcm2caL4IYRt3ryekyZpFL+UBV1dcHDbUyfxnvGSX+sG9X1WPhafmtM5p02EDQOwrhF9rVV3KNQ1KxQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bNtZVdUKUOx04jR3gpFnny4Uddzl1MCV84OM48SBPzXkvO0yw
	Ep+hf0yQu6Zcg2rzucx4e+/39TmEgWnZ5ofTAUDQBGQaEoPMl92gM1WaidJ+uk7+
X-Gm-Gg: AYBFou3JrG8r3YXiL0PV9JiKntsXh0cvosfHWcQsYqcfMoxDq3tYovLROi3eKzFPVH6
	vx7hYvwwRTvxvG0pFPUdbMzYvu8Ftgy+O4Ki69beB1l5TzXBJ7dONcCH+8LI3l3iB1Y0v83ZakA
	TWlBF5V3YihgadoIwj2mb6quyxSE/Is3QkMU59a0wpfRV0fvhV4oSuJfDMzoeSus2AFXp64Syhb
	mt2SfV5gCqIMLEdMR4jTO1ygzdmP1/4R7qTeFe54CvTnDuj2YQPND6mYLQFwMOJHwmGkcAKyXVy
	QHcAstPpdLRw5jTFSJb1YYR7/mroNm9+YLnzPqshDzEsq6VcqoCXDHHhXFvSzKZ+rTr+Fa8Dfff
	S7GLDOeyRuTv0gLfPLD1lDWp2SVsUjGEtcBCBQ7rpDFKH9iI/0nMTXCJVnnXEdaGVpyjRQt1F/1
	ITCMjqtJn8Yx10r/fAcH8IEVyUoGVR7wo5XcgFnldahG6tVLKdzovYSz1TkZZzmVk961zsy4KVn
	R9GQE0tbgFr+MifhO45xAZsmrEF1R9hzySbZgod8XgP3VCjr5mXPBrlEmyz//Yx0CJtHLEkNr36
	vaGqNNMPQKp3l8QeLMIiPCC8vZGeUozNYCJZcw==
X-Received: by 2002:a05:6000:38b:b0:491:620b:b60f with SMTP id ffacd0b85a97d-4983133e775mr4115106f8f.48.1794304634600;
        Tue, 10 Nov 2026 01:57:14 -0800 (PST)
Received: from foxbook (bfj76.neoplus.adsl.tpnet.pl. [83.28.47.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498367ba82csm4367740f8f.50.2026.11.10.01.57.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Nov 2026 01:57:14 -0800 (PST)
Date: Tue, 10 Nov 2026 10:57:09 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Olli Salenius <opsalenius@gmail.com>, linux-input@vger.kernel.org,
 bentiss@kernel.org, jikos@kernel.org, linux-usb@vger.kernel.org,
 git@mayer-bgk.de, "hadess@hadess.net" <hadess@hadess.net>,
 "srimanachanta@gmail.com" <srimanachanta@gmail.com>,
 "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Subject: Re: [BUG] HID: steelseries-arctis: NULL deref in xhci_urb_enqueue
 from status timer during resume from suspend (Arctis 9) -> system hang
Message-ID: <20261110105709.5fdec4a9.michal.pecio@gmail.com>
In-Reply-To: <079cf13d-542b-4084-9023-06a89fa4ea97@linux.intel.com>
References: <CACQx0bG8+c9+CjLRa-tbgGkc5_4Wxhmanbd2vToo8Aj8k_WUYw@mail.gmail.com>
	<CACQx0bG4bvt4bHa+WG4u2UGmUc_YMUnhpWovz5+rzp76Jpb9ZA@mail.gmail.com>
	<079cf13d-542b-4084-9023-06a89fa4ea97@linux.intel.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 10:34:24 +0200, Mathias Nyman wrote:
> On 11/8/26 09:35, Olli Salenius wrote:
> > The hid-steelseries-arctis driver reliably-but-intermittently freezes the
> > whole machine on resume from suspend (S3 and s2idle). The battery/status
> > polling work submits a HID control request to the Arctis 9 dongle while
> > the device is still being reset/re-enumerated by the xHCI controller after
> > resume, which oopses in xhci_urb_enqueue(). The oops happens in a context
> > that takes down the system (keyboard dead, no log reaches disk); I could
> > only capture it via efi-pstore.

This driver should stop submitting URBs to suspended devices.

> > Steps to reproduce
> > ------------------
> > 1. Arctis 9 dongle plugged in, hid-steelseries-arctis loaded.
> > 2. systemctl suspend (deep/S3; also reproduced with s2idle).
> > 3. Wake. In roughly half or more of the attempts the machine hangs: black
> >     screen (occasionally the desktop appears and then freezes), keyboard
> >     LEDs unresponsive, hard reset required.
> > 
> > Every resume on this controller logs:
> >    xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
> >    usb usb1: root hub lost power or was reset

We are resetting the host controller, all devices will be reset-resumed,
all xhci-hcd per-device state is being freed now.

(BTW, this happening to AMD chipsets every time should be fixed soon.)

> > after which the dongle is reset/disconnected and re-enumerated, sometimes
> > with "device descriptor read/64, error -71" retries taking ~2 s. The crash
> > happens inside that window.

At this point xhci_resume() should have completed and USB core is
performing those reset-resumes. The device has been resumed and reset,
its xhci-hcd state should have been reallocated, and now it's being
enumerated again (with mixed success, apparently).

> > Oops (captured via efi_pstore)
> > ------------------------------
> > [  116.909249] PM: suspend entry (deep)
> > [  119.777239] ACPI: PM: Waking up from system sleep state S3
> > [  119.920603] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
> > ...
> > [  123.275980] usb 1-3.1: WARN: invalid context state for evaluate
> > context command.

This bug is unrelated and likely harmless here. But this tells us that
xhci-hcd device state may be freed and recreated a few more times.

> > [  123.300361] BUG: kernel NULL pointer dereference, address: 0000000000000020
> > [  123.300363] #PF: supervisor read access in kernel mode
> > [  123.300365] #PF: error_code(0x0000) - not-present page
> > [  123.300367] PGD 0 P4D 0
> > [  123.300369] Oops: Oops: 0000 [#1] SMP NOPTI
> > [  123.300372] CPU: 1 UID: 0 PID: 287 Comm: kworker/1:2 Not tainted
> > 7.3.1-1-cachyos #1 PREEMPT(full)
> > [  123.300375] Hardware name: ASUS System Product Name/TUF GAMING
> > B550-PLUS, BIOS 3645 09/10/2026
> > [  123.300377] Workqueue: events steelseries_status_timer_work_handler
> > [hid_steelseries_arctis]
> > [  123.300381] RIP: 0010:xhci_urb_enqueue+0x1c8/0x350
> > [  123.300386] Code: 0f 84 58 ff ff ff 48 8d bb 48 02 00 00 49 8b 44
> > 24 40 8b 88 70 05 00 00 48 8b 83 a0 03 00 00 48 8b 04 c8 48 8b 90 88
> > 12 00 00 <f6> 42 20 01 0f 85 c9 00 00 00 f6 83 d8 03 00 00 01 0f 85 f1
> > 00 00
> > [  123.300388] RSP: 0018:ffffcde6417d3cd8 EFLAGS: 00010002
> > [  123.300390] RAX: ffff89fb0b84a000 RBX: ffff89fb01eb8800 RCX: 0000000000000002
> > [  123.300391] RDX: 0000000000000000 RSI: ffff89fb015f9800 RDI: ffff89fb01eb8a48
> > [  123.300392] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffffb8810860
> > [  123.300394] R10: 0000000000000001 R11: ffffffffb6e6a730 R12: ffff89fcb89bc780
> > [  123.300395] R13: ffff89fb01eb8800 R14: ffff89fd2854ee00 R15: 00000000ffffff94
> > [  123.300399] CR2: 0000000000000020 CR3: 00000002d7e75000 CR4: 0000000000f50ef0
> > [  123.300401] Call Trace:
> > [  123.300402]  <TASK>
> > [  123.300405]  usb_hcd_submit_urb+0x91/0x190
> > [  123.300408]  usb_start_wait_urb+0x8f/0x1d0
> > [  123.300412]  usb_control_msg+0xdd/0x150

Offending URB is submitted to ep0, which generally "always exists".

> xhci should not crash even if something is misbehaving and sending
> URBs during resume. The timer should also be fixed, but I'm now only
> looking at the xhci side
> 
> There are some pending xhci fixes in this area. Michal just posted a
> patch that touches the "WARN: invalid context state for evaluate
> context command" case in your log.
> 
> I added another patch for the NULL pointer deref.
> 
> All relevant patches for this case are now in a test branch named
> "fix_null_deref_reset_resume" in my tree. (based on Greg's usb-linus
> branch)
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git fix_null_deref_reset_resume
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=fix_null_deref_reset_resume

The log looks like core switched to "old scheme" enumeration after
getting a few -EPROTO on "new scheme" attempts to read the device
descriptor (maybe device isn't ready yet).

If core were submitting URBs concurrently with xhci_resume() we would
probably know about it already. Core should have called reset_device(),
which allocates a slot and recreates vdev. This should exist now.

Hard to tell why urb_enqueue() crashes here without debug info and
line numbers, but I would guess it's something like:

1. It crashes if URBs are submitted after reset_device() but before
   enable_device() or address_device(). That normally doesn't happen.
2. The HID driver submits URB concurrently with xhci_setup_deice()
   which frees vdev, possibly after the NULL check in urb_enqueue().

If 2 is possible it may be tricky to protect from.

Regards,
Michal
