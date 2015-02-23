From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: 3.19: Sony playstation controller causes kernel oops
Date: Mon, 23 Feb 2015 12:57:33 +0100
Message-ID: <CANq1E4Tb9waAsmJpkpjP-4rkHxDXjCGDQunsxxMRp1R4aX16uA@mail.gmail.com>
References: <20150222213513.GA15224@amd>
	<alpine.LNX.2.00.1502222247450.19920@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39070 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbbBWL5e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 06:57:34 -0500
In-Reply-To: <alpine.LNX.2.00.1502222247450.19920@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, rydberg@bitmath.org, Frank Praznik <frank.praznik@oh.rr.com>

Hi Jiri

On Sun, Feb 22, 2015 at 10:50 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> [ some CCs added and full dmesg kept for reference ]
>
> On Sun, 22 Feb 2015, Pavel Machek wrote:
>
>> Hi!
>>
>> I plugged in part of PS move to the PC, to let it charge. Got: full
>> dmesg in attachment. I believe I charged it in PC before, but it may
>> be year ago or more.
>>
>> Ideas?
>
> Ok, this is embarassing. I guess the patch below fixes it, right? (the
> spinlock got introduced in d2d782fccee, so I guess you didn't have it a
> year ago)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 31e9d25..3756a62 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2140,6 +2140,7 @@ static int __init sony_init(void)
>  {
>         dbg_hid("Sony:%s\n", __func__);
>
> +       spin_lock_init(&sony_dev_list_lock);
>         return hid_register_driver(&sony_driver);
>  }

Nice catch. I'd prefer the patch below, though. For both:
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

The bug is non-critical (global memory, so initialized to 0 which is
fine for spinlocks). It only spits out warnings if you enable
lock-debugging. We might mark it for stable 3.14+.

Thanks
David


diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 31e9d25..5d3e40a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -804,7 +804,7 @@ union sixaxis_output_report_01 {
 #define DS4_REPORT_0x81_SIZE 7
 #define SIXAXIS_REPORT_0xF2_SIZE 18

-static spinlock_t sony_dev_list_lock;
+static DEFINE_SPINLOCK(sony_dev_list_lock);
 static LIST_HEAD(sony_device_list);
 static DEFINE_IDA(sony_device_id_allocator);
