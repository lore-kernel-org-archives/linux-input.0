Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120259;
	b=mIc+bipymyWAV2RvnzQ4i1WL4JjGA/9VUBgmjdhNrhVFZENOvr2idA9bdf3FURaFCaul
	 7LNMQIeevaewecTw93VGF8O5v1YFdbreUD8iqpEyT8A/XmPzOEncikEhJP8NWgDfa7xnf
	 4Lr7ngQgTREUgaEkpr+W92pDwZqT2gkzHTSK5E2UdsYP3lnkMax9J09Zj2yQdRKqc8hTo
	 uvnv1WdcOoRq5hYdSDeaSacCTBi4KQC6FT31DoyK27DTmZ4oOqGcrkrV6VAo3+R91QdcC
	 4TXNsipYjKAnddbu/nK1Fo+pjywSkQoPuizrodZPl4CShSpYTbtc5tiR7f+/fCDVcOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120259;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=q3eQTb4176tQ/XYFb8kn65EXV9uC6ppEQ1yWUG1qw9A=;
	b=moIe0uLb/nes8IrsASHNPfM+gLXr152Mjne770z8B6/rAk/xrhCMJKdziDGO0KemKJ8b
	 8SPModQedYR+9puGH112wEiZmygereXlXVJ6WCAxboV/hDGmCIfca3DntJxIqL4VBrz4r
	 +YsslLGSoWvi6sl7KvoUvAIQtL7rT4P37dfk2b7TBT17sTGURzrXug4Nj3NVccY9xPcpZ
	 uL5IJtT1np59P9ogHv0saSmLpmiSPHLNQU0jjgE93ms8zaumALS7wtk+yjLqm3Oa7WOte
	 4rSTz8rhTq6dib11iNGYlC/aav0yKlWuUbaceOWChdAt8mSmEfsxIZ6d57wjS7L0wqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpYPyHlt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386C606A335;
	Thu, 19 Nov 2026 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpYPyHlt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA671F000D8;
	Thu, 19 Nov 2026 20:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120259;
	bh=q3eQTb4176tQ/XYFb8kn65EXV9uC6ppEQ1yWUG1qw9A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=MpYPyHltmvmB+yUf6dgiauc9S9WVw7Y3iM2aWljpnU8HU+byjsFlTX9C57xjrUOXk
	 IKJLff6YOjcbXtKQk0xjdBQkp+gjAHgHbTPB2nCaCRDNlvrlK4ud/XvpfQWAE9yMib
	 1DD6tftm//dDGVwoloQSBLHtqPbDInu3NHBPY4K3cDGPyLLEv7Njp++C0WTrIHurWD
	 NSdpOKCk7Q78Z9NqPbX5Q2v6bfvgK9dbU2WaEyJMub22krEehTdbPaXP3OVYU1sKQG
	 2CAnEfXaktNQOezjYieX5KNnnKFj+jdICA1gnCbpKAi5wcSOOTJ+VRrPmX/eShvJOs
	 cuFvNmOdiAplg==
Date: Thu, 19 Nov 2026 21:30:56 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: andreas@aclaesson.com
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Chen Changcheng <chenchangcheng@kylinos.cn>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: corsair: cancel LED work again after unregistering
 the LED
In-Reply-To: <20261109-hid-corsair-k90-uaf-v1-1-0621c2c5c451@aclaesson.com>
Message-ID: <30po4s0s-7n8n-1q84-40r3-623n6n45p005@xreary.bet>
References: <20261109-hid-corsair-k90-uaf-v1-1-0621c2c5c451@aclaesson.com>
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

On Mon, 9 Nov 2026, Andreas Claesson via B4 Relay wrote:

> From: Andreas Claesson <andreas@aclaesson.com>
> 
> Commit eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering
> LED to fix use-after-free") moved cancel_work_sync() in front of
> led_classdev_unregister() in k90_cleanup_backlight() and
> k90_cleanup_macro_functions().
> 
> led_classdev_unregister() turns the LED off unless
> LED_RETAIN_AT_SHUTDOWN is set. That calls k90_brightness_set(), which
> unconditionally does schedule_work() on the same work item. The work is
> therefore queued again after it was cancelled, and the structure that
> embeds it is freed right afterwards:
> 
>   k90_cleanup_macro_functions()
>     cancel_work_sync(&k90->record_led.work)
>     led_classdev_unregister(&k90->record_led.cdev)
>       led_set_brightness(LED_OFF)
>         k90_brightness_set()
>           schedule_work(&led->work)        <-- re-queued
>     kfree(k90)                             <-- frees the queued work_struct
> 
> When the work later runs, the workqueue dereferences the freed
> work_struct and k90_record_led_work() reads led->removed from freed
> memory. A USB device that enumerates as a K90 and is then unplugged
> triggers this reliably. With CONFIG_DEBUG_OBJECTS_WORK it shows up as:
> 
>   ODEBUG: free active (active state 0) object: ffff88803b8772c8 object type: work_struct hint: k90_record_led_work+0x0/0x1e0
>   WARNING: lib/debugobjects.c:632 at debug_print_object+0xec/0x230
>   Workqueue: usb_hub_wq hub_event
>   Call Trace:
>    debug_check_no_obj_freed+0x2e3/0x450 lib/debugobjects.c:1201
>    kfree+0x13e/0x650 mm/slub.c:6923
>    k90_cleanup_macro_functions drivers/hid/hid-corsair.c:547 [inline]
>    corsair_remove+0xfd/0x260 drivers/hid/hid-corsair.c:602
>    hid_device_remove+0xc5/0x1c0 drivers/hid/hid-core.c:2897
>    ...
>    usbhid_disconnect+0x9f/0xc0 drivers/hid/usbhid/hid-core.c:1486
> 
> (with ODEBUG enabled, work_fixup_free() cancels the work and hides the
> use-after-free. Without it, the freed work item is executed.)
> 
> Keep the existing cancel_work_sync() before unregistering, which waits
> for a worker that may already be past the 'removed' check, and cancel
> the work once more after led_classdev_unregister() so the work queued
> by the LED-off request is gone before the memory is freed. A re-queued
> work that manages to run before the second cancel still sees
> 'removed == true' while the structure is alive and returns early.
> 
> Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andreas Claesson <andreas@aclaesson.com>
> ---
> Found with syzkaller (USB emulation, KASAN + ODEBUG) on mainline
> f66469d9905b. Both the record LED and the backlight paths reproduce
> (hint: k90_record_led_work / k90_backlight_work); a minimised
> 3-call syzkaller reproducer is available on request. With this patch,
> 200 probe/removal cycles per path gave no ODEBUG or KASAN reports,
> against ODEBUG on roughly half of removals without it.

Applied to hid.git#for-7.4/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

