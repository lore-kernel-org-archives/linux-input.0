From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: HID: wacom: regression - system freezes when resuming from S3 suspend
Date: Wed, 24 Sep 2014 15:27:12 -0400
Message-ID: <CAN+gG=HqiV1omKjhUEV22sWO8DVjiTY0t04qxmO7YtE540RsOw@mail.gmail.com>
References: <542039C1.1000605@in.tum.de>
	<CAN+gG=EfKHqo2++ejxJMqDxpOnav5qiVRJMRjXoDOrbWQVMnBQ@mail.gmail.com>
	<54221EFF.2060501@in.tum.de>
	<alpine.LNX.2.00.1409241032490.32397@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:34402 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbaIXT1N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2014 15:27:13 -0400
Received: by mail-qa0-f53.google.com with SMTP id cm18so3611870qab.12
        for <linux-input@vger.kernel.org>; Wed, 24 Sep 2014 12:27:13 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1409241032490.32397@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jonas Jelten <jelten@in.tum.de>, linux-input <linux-input@vger.kernel.org>

On Wed, Sep 24, 2014 at 4:34 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 24 Sep 2014, Jonas Jelten wrote:
>
>> >> I encountered that my system freezes when resuming my Lenovo X220t with
>> >> integrated Wacom ISDv4 tablet from S3 suspend.
>> >>
>> >> Currently running 3.17.0-rc6, I started to bisect and found that this
>> >> commit causes the issue:
>> >>
>> >> commit 29b4739134c73a2873adec93346f09bb76d6a794
>> >> Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> >> Date:   Thu Jul 24 12:52:23 2014 -0700
>> >>
>> >>     Input: wacom - switch from an USB driver to a HID driver
>> >>
>> >>
>> >> Running 3.17.0-rc6, right after boot, this shows up in the log:
>> >>
>> >> [   25.843484] wacom 0003:056A:00E6.0001: usb_submit_urb(ctrl) failed: -1
>> >> [   25.843531] wacom 0003:056A:00E6.0001: timeout initializing reports
>> >> [   25.843886] wacom 0003:056A:00E6.0001: hidraw0: USB HID v1.11 Device
>> >> [Tablet ISD-V4] on usb-0000:00:1d.0-1.5/input0
>> >> [   25.846036] input: Wacom ISDv4 E6 Finger as
>> >> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.1/0003:056A:00E6.0002/input/input18
>> >>
>> >> When suspending, the screen goes off and about 8 seconds later, the
>> >> machine actually suspends.
>> >>
>> >> Right after the (instant) resume, I can see the frame buffer I had when
>> >> suspending (X screen) for about 10 seconds. During that time, no sysrq
>> >> works. After this short period, the tty1-framebuffer appears, with
>> >> messed up linebreaks (no carriage returns occur any more), and the
>> >> capslock-led starts blinking. Sysrq keys still don't work. The system is
>> >> completely frozen.
>> >>
>> >> Running the kernel from the bisected first good commit, the suspend is
>> >> faster (under 1 second) and the resume does not crash.
>> >>
>> >> I just saw the "HID: wacom: fix timeout on probe for some wacoms" mail,
>> >> which probably has to do something with my problem.
>> >>
>> >> Any ideas?
>> >
>> > Yes, this commit will fix your problem. It has just been delayed for
>> > 3.17.1 as mentioned by Jiri today.
>>
>> Are you sure it's a good idea to let the kernel crash into 3.17.0 and
>> fix it later in stable? I suspect many X220t users could be affected.
>
> Okay, my initial understanding was that this is just about the 10s delay.
> How exactly does it crash on resume, and do we have any idea why it
> crashes, and why "HID: wacom: fix timeout on probe for some wacoms" fixes
> it?
>

I am not sure (I can not see how actually) that there is a kernel oops
on resume (what you intend by "crash").
However, if the system disable/enable the USB ports both on suspend &
resume (this is where I do not understand), the hid core layer will
try to get the current report states from the device. The device does
not answer, so this adds the delay on both suspend and resume, which
can be quite annoying.

It's just a ugly lock with a 5-8 sec timeouts, not an actual crash.

Cheers,
Benjamin
