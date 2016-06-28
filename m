From: Yu Chen <yu.chen.surf@gmail.com>
Subject: Re: [RFC] Can we bypass the timeout when resetting Synaptics device?
Date: Tue, 28 Jun 2016 10:10:27 +0800
Message-ID: <CADjb_WQjg-aqpN_h2yO4rh9SPFbsUts_jHVOrNBqFHA=msHg2Q@mail.gmail.com>
References: <CADjb_WTNJJpmpNCOGxdUOd1AZ8S7iEf2NnSHC=VC6TzAOTbP_w@mail.gmail.com>
 <20160627170544.GA22620@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34652 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbcF1CK3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2016 22:10:29 -0400
In-Reply-To: <20160627170544.GA22620@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.com>, Dmitry Vyukov <dvyukov@google.com>

Hi Dmitry,
thanks very much for your reply,

On Tue, Jun 28, 2016 at 1:05 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Yu,
>
> On Mon, Jun 27, 2016 at 09:04:58PM +0800, Yu Chen wrote:
>> Hi All,
>> Currently I'm doing some tunings on the speed of suspend/resume,
>> it looks like my serio driver tooks a 200ms to finish, which is
>> too long:
>
> Well, PS/2 is not fast, that is why we do not actually do any IO in
> resume handler, but rather schedule work to execute actions in a
> separate thread. You probably need to instrument the call to
> serio_queue_event() in serio_resume() and see what took so long.
Here's the systemtap track result when doing suspend:
In process [rtcwake]
on CPU [3]
 0xffffffff81650f00 : __ps2_command+0x0/0x4b0 [kernel]
 0xffffffff816513da : ps2_command+0x2a/0x40 [kernel]
 0xffffffff8165bc5e : atkbd_cleanup+0x4e/0x60 [kernel]
 0xffffffff8164dfc8 : serio_cleanup+0x38/0x50 [kernel]
 0xffffffff8164dff5 : serio_suspend+0x15/0x20 [kernel]
 0xffffffff815392fe : dpm_run_callback+0x4e/0x130 [kernel]
 0xffffffff8153a022 : __device_suspend+0x122/0x350 [kernel]
 0xffffffff8153b9e3 : dpm_suspend+0x133/0x2e0 [kernel]
 0xffffffff8153bfcf : dpm_suspend_start+0x4f/0x60 [kernel]
 0xffffffff810c7709 : suspend_devices_and_enter+0x89/0x6c0 [kernel]
 0xffffffff810c7e32 : pm_suspend+0xf2/0x3a0 [kernel]
 0xffffffff810c68d5 : state_store+0x75/0xe0 [kernel]
 0xffffffff813b2abf : kobj_attr_store+0xf/0x20 [kernel]
 0xffffffff8127766a : sysfs_kf_write+0x3a/0x50 [kernel]
 0xffffffff81276c8b : kernfs_fop_write+0x11b/0x1a0 [kernel]
 0xffffffff811fbff8 : __vfs_write+0x28/0x120 [kernel]
 0xffffffff811fcc32 : vfs_write+0xb2/0x1b0 [kernel]
 0xffffffff811fdf76 : sys_write+0x46/0xa0 [kernel]
 0xffffffff810039d9 : do_syscall_64+0x69/0x110 [kernel]
 0xffffffff817fbde5 : return_from_SYSCALL_64+0x0/0x6a [kernel]

But actually the overall suspend time will not be impact by serio too much,
because we can let the pm suspend callbacks running parallelly.

>
> Also, IIRC, there might be some issue when serio_reconnect_driver()
> fails and serio_reconnect_port() forcibly unbinds driver and rescans the
> device for new drivers. If this happens in the middle of PM transition
> there might be some contention on PM locks.
>
>>
>> [ 1120.255783] calling  serio0+ @ 2764, parent: i8042
>> [ 1120.452976] call serio0+ returned 0 after 192472 usecs
>>
>> So further investigation shows that the time cost is in
>> drivers/input/serio/libps2.c: __ps2_command
>>
>>         /*
>>          * Some devices (Synaptics) peform the reset before
>>          * ACKing the reset command, and so it can take a long
>>          * time before the ACK arrives.
>>          */
>>         if (ps2_sendbyte(ps2dev, command & 0xff,
>>                          command == PS2_CMD_RESET_BAT ? 1000 : 200)) {
>>                 serio_pause_rx(ps2dev->serio);
>>                 goto out_reset_flags;
>>         }
>> If I understand correctly, if it is a Synaptics device, then we have to wait
>> at least 200ms for ATKBD_CMD_RESET_DEF, although this device has already
>> been reset.
>
> No, you are misreading the code. If the command is PS2_CMD_RESET_BAT
> then we will be waiting for up to 1 sec for the reste to complete,
> because Synaptics touchpads may take that long to re-calibrate after
> reset. All other commands have timeout of 200 msec, but that does not
> mean that we wait that long - we'll continue if device responds faster.
Oh, I see. So I guess I did not have a Synaptics device, but it still
waits at least
200ms, maybe it is because of my hardware issue.
>
>>
>> So my question is, could we add flags to distinguish Synaptics device, and
>> if it is a Synaptics device, just do not wait that long time and
>> return after the command
>> has been sent out?
>
> No, because that's not how protocol works.
>
Got it.


-- 
thanks,
Yu
