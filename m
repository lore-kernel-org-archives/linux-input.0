Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343601;
	b=tdd5O+CIEZmw7gHfmr0MBsZj2t6Z7fynV0Ucshb8RzOmDdmHNLbmpJ0hS/VtTytXhiXh
	 xV431xCJoq19AeZ7uz0CyObhFlg3FW7Ej7h7L8WJwT5DYY8abULHZpeHWr094QyGAaeDP
	 Bx4fMMwHSxGf8zqZfCnJyVksPgFpDoFKBdA7RGejJ9R8ysjOmZLmecZ5MksRfnU2wjH53
	 lA5jZPTkQhiNsPkv3sjY5RQsomOA4QDG/qXAbz7WMU7wsfz5gd6yQf3b9RP0klmEanJNV
	 hNebYhDMrYmIJhCzCeNqEmRgiPN19qOJ0LSv3+aZfFjpPK71J7Ya1MWsFzZNEI06DGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2AEjSPpjI0vVjMnpxE1zy6eIgOBMo2T5zRzY4+tWIVI=;
	b=WWa/5vlDgmcofVtBHmS1abrGz9/W1xx0WMZPdsQYar9Bwj2/s69OwvpCHnIcWuViqM9O
	 JM+FQE3bMgqpAV1y60I9b/Mj3z6+c0R5ZkZp4RnHs7/R4WWfmk/izfXn2cS5vky3La2KU
	 4jeKsobiYFSBpX0Z0jzF/S06xFftkaq75NnubNasOPxKQFFKcfy1HPBZ9L+59p6uNzoKJ
	 FvrSsFSvoAX7IH0EspquH15UUOZqzu/gnNX8FfRdKyx/nKtCs6K3LmpzSH8QmSQSKjk2j
	 +TDhrSK/tfAJrdGpAqtqdRazCerVofPkaDV3uGvHvHD3kLQKip1tB2IxoQd2FV+YthQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y0pqPp3A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1A606A326
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 20:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01D1A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y0pqPp3A
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso18387605e9.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 12:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794343599; cv=none;
        d=google.com; s=arc-20260327;
        b=l7ZA4Yd51OVARRubG+AtyTrousWZplYExFe4BHWyzTkdfuTXUNloQ2FGI7MgtEqIyq
         t3lX+aUhyUY5bRke05cVzA8ju2pZMXhA/dF5T+O4JcPfw/Ebaj62VrgvPopa9LUYoGue
         jqM8wNRBtnVvU7HgJQELYr6qROrj/mZwB/8IwMeh1/6EJViOR/ubVwF/ju682K9iysG8
         uARNKS8+D7pfc/OWoXvnKSk/3aBfzgZPRt+RQ3xinHkcwqEMNXVtPwv0Cdu+9/heCtpE
         fPrmRmq/9kZWNWg57xkVRwU+h9e8ExneUxAnjLiTo9JHyhXaMi6qIjXiUvJRqPL4/0n0
         4qkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2AEjSPpjI0vVjMnpxE1zy6eIgOBMo2T5zRzY4+tWIVI=;
        fh=Hb05LXysEVYTGHDQiF4YyPsGUL6u1S4Zqjz0uqk2FKc=;
        b=lrVNNXpo19kFxdxzprTotb4/5GXF9GpOnLn4M86t6FHJcVMtnEwKaN/nCmO8oIF7Qq
         O26E+w00LM+DE/ufntOU1tGFrXS5d4LTq/XXxmWf0PC52AUD8ym7IKEdFLn5qzoQ9snz
         ywFjanKHPL8m3LON1oNWR6LFQ4JwGHZUC6kqIc4OcTfDdtFj/CKBNrDGtiKhvJEdzEQ0
         XrurCGjaGJhL3aMIkJCcNmGkVWdAlp/Ai0WUFXe8mRzIEH8/4Syz3dqFe8vbwL7h+W1A
         uk3UFMQoA0ULg/9btsipwbMqo4EBjHsM64JSJ2EQkdJM5FT3NFSDBJcbqScO4LUqXdX/
         yVQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794343599; x=1794948399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2AEjSPpjI0vVjMnpxE1zy6eIgOBMo2T5zRzY4+tWIVI=;
        b=Y0pqPp3Az9BlN9yyKw6T4ttK5lQOoRCY7zoVcpGsnr+ux/c4WACgN7jV/fcV155SaW
         EkhyHB8UKbSD1GaGKvrb1vWKr8Zc9MnuNDYj90tK9hb8E7QN2FwXtiGuzb0lyZWJkYhx
         5505u06BlElSPzI3bnSyuecAANpZTRRpvHTF+EgvUNkhLeRwZa9q2dNVsT9+WSSN9YBC
         3MqWe1y7V8AS4BMZ9fTWhqujOhnRXc55dqs/iGbmMrp3MuBMPkaOE3qgjWjQnGH5/iW+
         0N8ls9l2YmoKXa3GtiWI+9C+ShOoqf9TAudUMbEwkhujhsQzgmlOlO+52yAnGzyBRQy2
         fJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794343599; x=1794948399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2AEjSPpjI0vVjMnpxE1zy6eIgOBMo2T5zRzY4+tWIVI=;
        b=sW4339uxUjMAVYXitN1ZT7fay3BAP5OxwIOpleUGUPqvx8IcnjsSmHTApe4KFtfH7V
         LM0eUl3bUCm4caDeB5xieas9UyPzF9ii+Av6CpMWQw5b2FpVFKMNuYMN7SelsBFdoavO
         MEM4aI1HuaCm4DdM87Gk2M6LkxirzcHqKKBlcyZumLsA/+qGrcnjE5znEwYU/wMYe1fi
         gE2PU/GCnDBVvxjQjF4jvm7M87lk+IC3MHY3U6zoGNrK4f96ZRy1kv1n6F+lc7u2oKDr
         HrkTjx3XloGvrjRPwToibwp7L3WF2Vab9bzZidnFcbOra0DilBV5dZORkcYa09hYIIbv
         A0bg==
X-Forwarded-Encrypted: i=1; AL+hErE4NUV/qo+2G1EB0wRnQtH/5RGeO4OG40jr/d2eXoqwthYn/MORQur5DyrkjeI0abUgCHTNFv+rcrME+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kredeY+jaim0vWx+4eu7MdWKzSxDmsStGdZwqHY/jxN6wziad
	f6jKTmW8EsZ0ij84wHuf9dnTwa4Gt3ctKUOcpNn/PTMneWFRxZ1kyGYRt8X5ByjrQ/YFqRrrIGS
	T4TVTu+bzIxUkb4mRsBS3BWPMKq5Prpc=
X-Gm-Gg: AYBFou0cBxkCLxJxLlPkS5suu7HXwNQwuMQFlyNsevZ8Ram0vY2h/hserkf8K01qZXE
	9FijNAxtHmznYpRhgn8gCVVBjoCcMNw+Hp6xpD4D0JU3dmo4eC3JKS8yElwInNKP8kG7nWQgbcq
	dOpQl7O2vAxOGhNvOw3eQ7B4JW0kKOvn77idyMLups3/x9RGmu0PC7yHqUUf+fa5UYv3qFxX7sa
	Mm8KtRiaG86fU0emXc8svs14dBKJtMFsCK6vvWl8HFrCKqmQoxHgiS77WOEPoJrZHrk13YyKdIH
	usu7lh+o5RCZLCpBNC6WcieaTJOBLNxDouLPRNU5jJbJeY+dalJ10wfuek8Qvonuh09wscgYxRZ
	Z000HkCqLE8bFC9hqT9tUvn7lN8pWFwjveJIV
X-Received: by 2002:a05:600c:3d8d:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4ba09380530mr4479275e9.26.1794343599080; Tue, 10 Nov 2026
 12:46:39 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CACQx0bG8+c9+CjLRa-tbgGkc5_4Wxhmanbd2vToo8Aj8k_WUYw@mail.gmail.com>
 <CACQx0bG4bvt4bHa+WG4u2UGmUc_YMUnhpWovz5+rzp76Jpb9ZA@mail.gmail.com>
 <079cf13d-542b-4084-9023-06a89fa4ea97@linux.intel.com> <20261110105709.5fdec4a9.michal.pecio@gmail.com>
In-Reply-To: <20261110105709.5fdec4a9.michal.pecio@gmail.com>
From: Olli Salenius <opsalenius@gmail.com>
Date: Tue, 10 Nov 2026 22:46:27 +0200
X-Gm-Features: AclHuK8g3lcx1WrWdNauYj_2Ui3km71_Hx-zKtaZgSXPzWghHzcJKeG07g8rrGM
Message-ID: <CACQx0bFrJYn60_QAogb23n0yiSy4hu5ZHQWXbRb_WBfS908tSQ@mail.gmail.com>
Subject: Re: [BUG] HID: steelseries-arctis: NULL deref in xhci_urb_enqueue
 from status timer during resume from suspend (Arctis 9) -> system hang
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, linux-input@vger.kernel.org, 
	bentiss@kernel.org, jikos@kernel.org, linux-usb@vger.kernel.org, 
	git@mayer-bgk.de, "hadess@hadess.net" <hadess@hadess.net>, 
	"srimanachanta@gmail.com" <srimanachanta@gmail.com>, 
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathias, Michal,

Disclaimer, I am not well versed kernel level stuff and using Claude
Opus 5.5 in debugging this issue, so the following info may not be
accurate, however the patch did seem to fix the hang at least on a few
test suspend/resume -cycles.

Thanks for the quick patches and the analysis.

Michal wrote:
> Hard to tell why urb_enqueue() crashes here without debug info and
> line numbers

I got the matching debug vmlinux for the crashing kernel
(linux-cachyos-dbg 7.3.1-1, build ID 86590b412f55... matches the oops)
and resolved the RIP:

  xhci_urb_enqueue+0x1c8/0x350 -> drivers/usb/host/xhci.c:1668 (v7.3.1)

    if (xhci->devs[slot_id]->rhub_port->link_inactive) {

  ; xhci.c:1668
  mov  0x3a0(%rbx),%rax
  mov  (%rax,%rcx,8),%rax      ; xhci->devs[slot_id], slot_id =3D RCX =3D 2
  mov  0x1288(%rax),%rdx       ; ->rhub_port, RDX =3D 0
  testb $0x1,0x20(%rdx)        ; ->link_inactive  <-- fault, CR2 =3D 0x20

So the virt device exists and xhci_check_args() passed, but its
rhub_port is still NULL. As far as I can tell rhub_port is only set
in xhci_setup_addressable_virt_dev(), so this looks like Michal's
case 1: the URB arrives after the virt device was (re)allocated, e.g.
via xhci_discover_or_reset_device() -> xhci_alloc_dev() after the
Reinit, but before address_device() set it up. Since the host isn't
halted at that point, I don't think the XHCI_STATE_HALTED check in
e44fcfdabcd2 would catch it; the same dereference is still at
xhci.c:1688 on the test branch.

The fault also happens under spin_lock_irqsave(&xhci->lock) (EFLAGS
0x10002, IF clear), which would explain why the whole machine froze
instead of just USB dying.

Testing the branch
------------------
I tested fix_null_deref_reset_resume (e44fcfdabcd2) with
hid-steelseries-arctis loaded and bound to the Arctis 9 (1038:12c2).
4 S3 suspend/resume cycles so far: no hang, no oops, no "invalid
context state" warning.

However, the controller reset no longer happens on this branch. On
7.3.1 every resume logged:

  xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
  usb usb1: root hub lost power or was reset

On the test branch this is gone and only the individual devices are
reset. My controller is the AMD 500 series chipset xHCI (1022:43ee),
so I suspect 555040535 ("usb: pci-quirks: always assert xHCI OS
ownership"), which is in the usb-linus base, fixes the restore error
here too, as Michal mentioned. So the crash path wasn't exercised in
my testing.

If it helps, I can rebuild with 555040535 reverted so the Reinit path
is active, and test any patch for the rhub_port case. I'm away for a
couple of days, so I can test again from Friday on.

Thanks,
Olli


On Tue, Nov 10, 2026 at 11:57=E2=80=AFAM Michal Pecio <michal.pecio@gmail.c=
om> wrote:
>
> On Tue, 10 Nov 2026 10:34:24 +0200, Mathias Nyman wrote:
> > On 11/8/26 09:35, Olli Salenius wrote:
> > > The hid-steelseries-arctis driver reliably-but-intermittently freezes=
 the
> > > whole machine on resume from suspend (S3 and s2idle). The battery/sta=
tus
> > > polling work submits a HID control request to the Arctis 9 dongle whi=
le
> > > the device is still being reset/re-enumerated by the xHCI controller =
after
> > > resume, which oopses in xhci_urb_enqueue(). The oops happens in a con=
text
> > > that takes down the system (keyboard dead, no log reaches disk); I co=
uld
> > > only capture it via efi-pstore.
>
> This driver should stop submitting URBs to suspended devices.
>
> > > Steps to reproduce
> > > ------------------
> > > 1. Arctis 9 dongle plugged in, hid-steelseries-arctis loaded.
> > > 2. systemctl suspend (deep/S3; also reproduced with s2idle).
> > > 3. Wake. In roughly half or more of the attempts the machine hangs: b=
lack
> > >     screen (occasionally the desktop appears and then freezes), keybo=
ard
> > >     LEDs unresponsive, hard reset required.
> > >
> > > Every resume on this controller logs:
> > >    xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
> > >    usb usb1: root hub lost power or was reset
>
> We are resetting the host controller, all devices will be reset-resumed,
> all xhci-hcd per-device state is being freed now.
>
> (BTW, this happening to AMD chipsets every time should be fixed soon.)
>
> > > after which the dongle is reset/disconnected and re-enumerated, somet=
imes
> > > with "device descriptor read/64, error -71" retries taking ~2 s. The =
crash
> > > happens inside that window.
>
> At this point xhci_resume() should have completed and USB core is
> performing those reset-resumes. The device has been resumed and reset,
> its xhci-hcd state should have been reallocated, and now it's being
> enumerated again (with mixed success, apparently).
>
> > > Oops (captured via efi_pstore)
> > > ------------------------------
> > > [  116.909249] PM: suspend entry (deep)
> > > [  119.777239] ACPI: PM: Waking up from system sleep state S3
> > > [  119.920603] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x4=
01, Reinit
> > > ...
> > > [  123.275980] usb 1-3.1: WARN: invalid context state for evaluate
> > > context command.
>
> This bug is unrelated and likely harmless here. But this tells us that
> xhci-hcd device state may be freed and recreated a few more times.
>
> > > [  123.300361] BUG: kernel NULL pointer dereference, address: 0000000=
000000020
> > > [  123.300363] #PF: supervisor read access in kernel mode
> > > [  123.300365] #PF: error_code(0x0000) - not-present page
> > > [  123.300367] PGD 0 P4D 0
> > > [  123.300369] Oops: Oops: 0000 [#1] SMP NOPTI
> > > [  123.300372] CPU: 1 UID: 0 PID: 287 Comm: kworker/1:2 Not tainted
> > > 7.3.1-1-cachyos #1 PREEMPT(full)
> > > [  123.300375] Hardware name: ASUS System Product Name/TUF GAMING
> > > B550-PLUS, BIOS 3645 09/10/2026
> > > [  123.300377] Workqueue: events steelseries_status_timer_work_handle=
r
> > > [hid_steelseries_arctis]
> > > [  123.300381] RIP: 0010:xhci_urb_enqueue+0x1c8/0x350
> > > [  123.300386] Code: 0f 84 58 ff ff ff 48 8d bb 48 02 00 00 49 8b 44
> > > 24 40 8b 88 70 05 00 00 48 8b 83 a0 03 00 00 48 8b 04 c8 48 8b 90 88
> > > 12 00 00 <f6> 42 20 01 0f 85 c9 00 00 00 f6 83 d8 03 00 00 01 0f 85 f=
1
> > > 00 00
> > > [  123.300388] RSP: 0018:ffffcde6417d3cd8 EFLAGS: 00010002
> > > [  123.300390] RAX: ffff89fb0b84a000 RBX: ffff89fb01eb8800 RCX: 00000=
00000000002
> > > [  123.300391] RDX: 0000000000000000 RSI: ffff89fb015f9800 RDI: ffff8=
9fb01eb8a48
> > > [  123.300392] RBP: 0000000000000000 R08: 0000000000000001 R09: fffff=
fffb8810860
> > > [  123.300394] R10: 0000000000000001 R11: ffffffffb6e6a730 R12: ffff8=
9fcb89bc780
> > > [  123.300395] R13: ffff89fb01eb8800 R14: ffff89fd2854ee00 R15: 00000=
000ffffff94
> > > [  123.300399] CR2: 0000000000000020 CR3: 00000002d7e75000 CR4: 00000=
00000f50ef0
> > > [  123.300401] Call Trace:
> > > [  123.300402]  <TASK>
> > > [  123.300405]  usb_hcd_submit_urb+0x91/0x190
> > > [  123.300408]  usb_start_wait_urb+0x8f/0x1d0
> > > [  123.300412]  usb_control_msg+0xdd/0x150
>
> Offending URB is submitted to ep0, which generally "always exists".
>
> > xhci should not crash even if something is misbehaving and sending
> > URBs during resume. The timer should also be fixed, but I'm now only
> > looking at the xhci side
> >
> > There are some pending xhci fixes in this area. Michal just posted a
> > patch that touches the "WARN: invalid context state for evaluate
> > context command" case in your log.
> >
> > I added another patch for the NULL pointer deref.
> >
> > All relevant patches for this case are now in a test branch named
> > "fix_null_deref_reset_resume" in my tree. (based on Greg's usb-linus
> > branch)
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git fix_null_=
deref_reset_resume
> > https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=
=3Dfix_null_deref_reset_resume
>
> The log looks like core switched to "old scheme" enumeration after
> getting a few -EPROTO on "new scheme" attempts to read the device
> descriptor (maybe device isn't ready yet).
>
> If core were submitting URBs concurrently with xhci_resume() we would
> probably know about it already. Core should have called reset_device(),
> which allocates a slot and recreates vdev. This should exist now.
>
> Hard to tell why urb_enqueue() crashes here without debug info and
> line numbers, but I would guess it's something like:
>
> 1. It crashes if URBs are submitted after reset_device() but before
>    enable_device() or address_device(). That normally doesn't happen.
> 2. The HID driver submits URB concurrently with xhci_setup_deice()
>    which frees vdev, possibly after the NULL check in urb_enqueue().
>
> If 2 is possible it may be tricky to protect from.
>
> Regards,
> Michal
