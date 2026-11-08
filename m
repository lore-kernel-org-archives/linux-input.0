Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794123360;
	b=nBfeU6kFy9n8rSJDNvy8pDaIxk1WS47XnSEfekoLFQb9E2yN+GPdpw5c7nxKqYbAf3x5
	 8yrS/z8YD/VTmUEp/sC8EoueyrFZg2jGn9MYPuB7Rlz4hqwWQyW3XewF+gPJ3/ORl00bW
	 rWi/ez+L/L0281P/vQmxLwer+aoeG7rr1RI1IAXVDPxXWAgITyYX2Q9Fef+AGYluQNMqR
	 K7uqndD9IbdTtU6+AlGos5d74WYJfkhQmVTT9OsNgfpBZrVrzdXgohYPGn1Bnkip0cSXc
	 4oc7AIhSSy7WBO241coIJqJtjitZ1JWF2xcjETRIMBJ9X0eu7UNzB63zzY1rie/8qlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=V7/ji8t0cWT3J3951WSmRP+FV5sNjxdyHX920D7x32I=;
	b=g3TRqybkPOlYXp7bbHWMzc1fJdUiIgPGFd4n4K2+hsIFNGZLR8TYnFrEOrT5CkSNX09W
	 a2aiDV82TPx5a8fqI7tplGa5uhKOoGSg86TN33T0jKCWThjsq9gGE9+OZNX9DiHU3hLuk
	 4R6J/+KGWdl1gtSdQ3stl5sBE5pwoZRlqzdu+ObZvUtEQrHt8tDB+aDeEae7wrVs5udk2
	 4WNSNvbuwXbjkS1UxFxtlCZ9hTQ/akJmiztIKk0Vhr1Ri9Pw0RWhWgkFz0w9BXQe3sNcq
	 CZ7Q0l4YMilynu3MGHlk19An30c0Yx0RENf9UHfWt6eAonBy23fd1RsL5O8M/4fw25g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlUxLaRj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E9606A320
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 07:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 056E9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wlUxLaRj
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so1988615e9.0
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 23:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794123358; cv=none;
        d=google.com; s=arc-20260327;
        b=Y9QYEBBFewdS3XoLsnQvLYtsSS34OK1or5WlD53Mxi/4w5PsjrKcHMYSPjMTvFT3c8
         AfqUfgJJEAGh40z2imEfGriFNrOi0EthAjmZyIg8OyqLdLg1jF8syQVMNaetGJg65jsV
         ASZ4PksAqQkXDMpgGR69Lx20IpYi2ymyeCOBq76kvdvvNhrYr2T1pCed0WZX7SIWZK+Q
         SoA30qQIPB8PvLYZDVnWlIKFVh78BezFIr1V4vsQls6qUem6H4OKbAR+9btBFfeMKR1a
         qezurfZNzt7luK7ldNItUP93A8LR9ec0iM/xgQsLuCRHA6Z2j7lNxwcequM9tz1a4uYP
         QE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V7/ji8t0cWT3J3951WSmRP+FV5sNjxdyHX920D7x32I=;
        fh=RTLi24bc9CTLPZSNFF7G64nCbHyVdEoJANWnZv2k+9M=;
        b=B7Oq+bvEUea0XJFzhPaslS2+kWrV0u9X2DYIWKwOytR0aOTd6GoTV6dWLQuBJ61BIA
         QBMcORJaMqwspGEgv+r32DsebYfqPmtoXfH35Qq4m5cwW+Q+bGF9r87sbK6HTtbhzzqc
         hS5XhhotE0UkctB+vtQJrvPbIKDH10MaU/cBxAeLDDg7VVqyolHdIff+EX22z/51qJYY
         GQjyAj1XZJ36f2zm7iHECs4D0++pJfmF4IbEHS710G/qz3pOow3SjWsN6bSUqzWX9EhR
         UleGdL3kt3Fvm7kvBEA19G9OX/T/40IL0O4EPNe1dVSnv9eAt2tdX1fWvKrmYnRdoGmT
         kmcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794123358; x=1794728158; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7/ji8t0cWT3J3951WSmRP+FV5sNjxdyHX920D7x32I=;
        b=wlUxLaRjD/pq9IMpU31SjBRdo8UKvP845gP+A1LoUWnpp0PG1qNKCDd1+nqLtqXLnY
         KQffVCKGqxLZLEjXZ8U7TPcj6mNU1Jwm7BXNjnVrIDu61ZxQDc1F4fCuK+WFYmZ84GD5
         ZsGuGxDfv/hMyuXpuUdQA8dOiYxIUpX5Vve5qx1dExarz9MY59Cht7y0IR8d/OW0KxmD
         1NgI/FrFcpDDPLM7vKHhaJ5gy9l0mQGgCu3fASNWFwyQ4dB8jPWtlhUg8nok/aJ9enND
         gnY0W8xM+/JAcv6nCPr7vVLZqsIt5WhBNZ2A9K42OrPJiG6knpSZCcyKMcJMkhTqEG8W
         F1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794123358; x=1794728158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V7/ji8t0cWT3J3951WSmRP+FV5sNjxdyHX920D7x32I=;
        b=qlHPyuTLVnUOV4Pcp9+TFXu+y8nfCi1mekR5SlTzx+EJ403D1sb86Enuc5W41ZKepg
         1lwWE0UJNywlfOplIkNclhnWiG8WtZZi55F4aW8qAa1Le0OTw0LxXxu5w33mRdyVdPtb
         55baNKlZvrPvuVdy+ZRJH0uPpE3SYY/5GJeRpcyN8jmxr21thrcf8TlGo98MjarXkdGT
         aibwhNRlVdNXQjXXPBKUgtYL3yg63xJ3crbVim1TTq7SrViCC+tj5IeNa7dinF0Z9BwI
         yonYTUB+7HkeuTxmeizvMlfdidCQiggMjoOw3KZtJY5XCsZOT7TXHY+mn1jXQKmmjmqx
         01cA==
X-Gm-Message-State: APuU4Z8BWbfkV7poQHp9BCD5dtKDePq6PcdkgfSsFKZ/CFHMueI1ZOPz
	nNtlQZ5nyylwv9ZyTcwPqFQU/A0q8j7gO4r/OAUeosD+Ahc8HYlgHvoXobFyOvjYHaNIHMDaZ0X
	gjQKShh1lN+piKDsb8d+9pJbJ/YCcx+xBBzTN
X-Gm-Gg: AYBFou3QoF2cRkD0VfEGFJM4e5ajVAOBounLqic6m755MITcbzbF77GL+XfC5XSFlCT
	xerdIaFN81h3OhaSZYJbiycKgIwA3tlJfChWHmZ+A2ZTY6c7y2bReaXRUDezEHHW5XrI8dD30LJ
	cW+HWJjlYIBQftuVGoHOK4vEyH9hs9JI4mEIzu2bWthyiEn2rH2XZ0G6y+bFUwBQMVAWOa8umak
	S6HABmmVa+MzubwV7RPAb1L9QCY68ErB3TFsrUbcdUQsYqLG2HR04Ja9pgP1weFtwD0v268JJut
	RyeleH4qUxaH6ayIZ/pn/BqDVl2oHDbM7y2/seLD8XSlnRc+oGqoNdMTysE/ufjP9agHs1VepsS
	XyM2gFijgB2P+SNGUcU88QssZsLsnreYQHBuy
X-Received: by 2002:a05:600c:a00d:b0:4a5:5fb9:5d35 with SMTP id
 5b1f17b1804b1-4b963c8e853mr12123795e9.21.1794123358203; Sat, 07 Nov 2026
 23:35:58 -0800 (PST)
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
In-Reply-To: <CACQx0bG8+c9+CjLRa-tbgGkc5_4Wxhmanbd2vToo8Aj8k_WUYw@mail.gmail.com>
From: Olli Salenius <opsalenius@gmail.com>
Date: Sun, 8 Nov 2026 09:35:47 +0200
X-Gm-Features: AclHuK_5UaOWJxHzPhoy03od0UF-SDuLhsyHQc3_7kD3tbKjQI9Wx9r79RgVpEc
Message-ID: <CACQx0bG4bvt4bHa+WG4u2UGmUc_YMUnhpWovz5+rzp76Jpb9ZA@mail.gmail.com>
Subject: Fwd: [BUG] HID: steelseries-arctis: NULL deref in xhci_urb_enqueue
 from status timer during resume from suspend (Arctis 9) -> system hang
To: linux-input@vger.kernel.org, bentiss@kernel.org, jikos@kernel.org
Cc: linux-usb@vger.kernel.org, git@mayer-bgk.de, 
	"hadess@hadess.net" <hadess@hadess.net>, "srimanachanta@gmail.com" <srimanachanta@gmail.com>, 
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

The hid-steelseries-arctis driver reliably-but-intermittently freezes the
whole machine on resume from suspend (S3 and s2idle). The battery/status
polling work submits a HID control request to the Arctis 9 dongle while
the device is still being reset/re-enumerated by the xHCI controller after
resume, which oopses in xhci_urb_enqueue(). The oops happens in a context
that takes down the system (keyboard dead, no log reaches disk); I could
only capture it via efi-pstore.

Blacklisting hid_steelseries_arctis fixes the hang completely.

Environment
-----------
Kernel:   7.3.1-1-cachyos (CachyOS build, x86_64, PREEMPT(full))
Board:    ASUS TUF GAMING B550-PLUS, BIOS 3645 09/10/2026
CPU/GPU:  AMD Ryzen 7 5800X3D, AMD Radeon RX 9070 (Navi 48)
Headset:  SteelSeries Arctis 9 wireless
          1038:12c2 (HID interface, bcdDevice 1.01) -> bound to
                     hid-steelseries-arctis
          1038:12c4 (audio + HID, bcdDevice 0.03)  -> snd-usb-audio
          both behind an Alcor Micro hub (058f:9254), on the AMD 500
          series chipset xHCI controller (0000:02:00.0, 1022:43ee)

Steps to reproduce
------------------
1. Arctis 9 dongle plugged in, hid-steelseries-arctis loaded.
2. systemctl suspend (deep/S3; also reproduced with s2idle).
3. Wake. In roughly half or more of the attempts the machine hangs: black
   screen (occasionally the desktop appears and then freezes), keyboard
   LEDs unresponsive, hard reset required.

Every resume on this controller logs:
  xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
  usb usb1: root hub lost power or was reset
after which the dongle is reset/disconnected and re-enumerated, sometimes
with "device descriptor read/64, error -71" retries taking ~2 s. The crash
happens inside that window.

Oops (captured via efi_pstore)
------------------------------
[  116.909249] PM: suspend entry (deep)
[  119.777239] ACPI: PM: Waking up from system sleep state S3
[  119.920603] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, Reinit
...
[  123.275980] usb 1-3.1: WARN: invalid context state for evaluate
context command.
[  123.300361] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  123.300363] #PF: supervisor read access in kernel mode
[  123.300365] #PF: error_code(0x0000) - not-present page
[  123.300367] PGD 0 P4D 0
[  123.300369] Oops: Oops: 0000 [#1] SMP NOPTI
[  123.300372] CPU: 1 UID: 0 PID: 287 Comm: kworker/1:2 Not tainted
7.3.1-1-cachyos #1 PREEMPT(full)
[  123.300375] Hardware name: ASUS System Product Name/TUF GAMING
B550-PLUS, BIOS 3645 09/10/2026
[  123.300377] Workqueue: events steelseries_status_timer_work_handler
[hid_steelseries_arctis]
[  123.300381] RIP: 0010:xhci_urb_enqueue+0x1c8/0x350
[  123.300386] Code: 0f 84 58 ff ff ff 48 8d bb 48 02 00 00 49 8b 44
24 40 8b 88 70 05 00 00 48 8b 83 a0 03 00 00 48 8b 04 c8 48 8b 90 88
12 00 00 <f6> 42 20 01 0f 85 c9 00 00 00 f6 83 d8 03 00 00 01 0f 85 f1
00 00
[  123.300388] RSP: 0018:ffffcde6417d3cd8 EFLAGS: 00010002
[  123.300390] RAX: ffff89fb0b84a000 RBX: ffff89fb01eb8800 RCX: 0000000000000002
[  123.300391] RDX: 0000000000000000 RSI: ffff89fb015f9800 RDI: ffff89fb01eb8a48
[  123.300392] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffffb8810860
[  123.300394] R10: 0000000000000001 R11: ffffffffb6e6a730 R12: ffff89fcb89bc780
[  123.300395] R13: ffff89fb01eb8800 R14: ffff89fd2854ee00 R15: 00000000ffffff94
[  123.300399] CR2: 0000000000000020 CR3: 00000002d7e75000 CR4: 0000000000f50ef0
[  123.300401] Call Trace:
[  123.300402]  <TASK>
[  123.300405]  usb_hcd_submit_urb+0x91/0x190
[  123.300408]  usb_start_wait_urb+0x8f/0x1d0
[  123.300412]  usb_control_msg+0xdd/0x150
[  123.300415]  usbhid_raw_request+0x11e/0x140
[  123.300419]  steelseries_arctis_9_request_status+0x63/0xb0
[hid_steelseries_arctis]
[  123.300422]  steelseries_status_timer_work_handler+0x21/0x70
[hid_steelseries_arctis]
[  123.300424]  process_scheduled_works+0x21f/0x650
[  123.300428]  worker_thread+0x193/0x3b0
[  123.300432]  kthread+0xfd/0x130
[  123.300436]  ret_from_fork+0xec/0x2b0
[  123.300441]  ret_from_fork_asm+0x1a/0x30
[  123.300446]  </TASK>
[  123.300527] CR2: 0000000000000020
[  123.300532] WARNING: kernel/printk/printk.c:4631 at
wake_up_klogd+0x64/0x80, CPU#1: kworker/1:2/287
               (console_irqwork_blocked)

Analysis
--------
The status timer/work keeps running across system suspend/resume and
fires while the USB device is being reset after the xHC "Reinit". The
control request then reaches xhci_urb_enqueue() for a device whose
endpoint state has not been rebuilt yet (NULL at offset 0x20).

Looking at drivers/hid/hid-steelseries-arctis.c (new in v7.3; unchanged
in current master, hid.git for-next and linux-next), the driver has no
.suspend/.resume/.reset_resume callbacks:

  static struct hid_driver steelseries_arctis_driver = {
          .name = "hid-steelseries-arctis",
          .id_table = steelseries_arctis_devices,
          .probe = steelseries_arctis_probe,
          .remove = steelseries_arctis_remove,
          .raw_event = steelseries_arctis_raw_event,
  };

and steelseries_status_timer_work_handler() unconditionally re-arms
status_work (for non-async devices such as the Arctis 9); it is only
cancelled in remove. So the poll keeps firing across system sleep.

Suggested fix: cancel_delayed_work_sync(&sd->status_work) in a .suspend
callback, and re-schedule it from .resume and .reset_resume. Separately,
it may be worth a look from the USB side whether xhci_urb_enqueue()
should reject rather than dereference in this state.

Possibly related: on the 6.18 LTS kernel, where the Arctis 9 (1038:12c2)
is handled by hid-steelseries instead, I also saw identical resume hangs,
but I did not capture a trace there.

Workaround
----------
  echo 'blacklist hid_steelseries_arctis' >
/etc/modprobe.d/no-steelseries-hid.conf
Several suspend/resume cycles since then have been clean.

I'm happy to test patches.

Resending in plain text
Apologies for the spam.

Thanks,
Olli
