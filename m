From: Jonas Jelten <jelten@in.tum.de>
Subject: Re: HID: wacom: regression - system freezes when resuming from S3
 suspend
Date: Wed, 24 Sep 2014 03:31:43 +0200
Message-ID: <54221EFF.2060501@in.tum.de>
References: <542039C1.1000605@in.tum.de> <CAN+gG=EfKHqo2++ejxJMqDxpOnav5qiVRJMRjXoDOrbWQVMnBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:61351 "EHLO
	smtp1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757322AbaIXBbt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 21:31:49 -0400
In-Reply-To: <CAN+gG=EfKHqo2++ejxJMqDxpOnav5qiVRJMRjXoDOrbWQVMnBQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

On 2014-09-22 17:52, Benjamin Tissoires wrote:
> On Mon, Sep 22, 2014 at 11:01 AM, Jonas Jelten <jelten@in.tum.de> wrote:
>> Hi!
>>
>> I encountered that my system freezes when resuming my Lenovo X220t with
>> integrated Wacom ISDv4 tablet from S3 suspend.
>>
>> Currently running 3.17.0-rc6, I started to bisect and found that this
>> commit causes the issue:
>>
>> commit 29b4739134c73a2873adec93346f09bb76d6a794
>> Author: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Date:   Thu Jul 24 12:52:23 2014 -0700
>>
>>     Input: wacom - switch from an USB driver to a HID driver
>>
>>
>> Running 3.17.0-rc6, right after boot, this shows up in the log:
>>
>> [   25.843484] wacom 0003:056A:00E6.0001: usb_submit_urb(ctrl) failed: -1
>> [   25.843531] wacom 0003:056A:00E6.0001: timeout initializing reports
>> [   25.843886] wacom 0003:056A:00E6.0001: hidraw0: USB HID v1.11 Device
>> [Tablet ISD-V4] on usb-0000:00:1d.0-1.5/input0
>> [   25.846036] input: Wacom ISDv4 E6 Finger as
>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.1/0003:056A:00E6.0002/input/input18
>>
>> When suspending, the screen goes off and about 8 seconds later, the
>> machine actually suspends.
>>
>> Right after the (instant) resume, I can see the frame buffer I had when
>> suspending (X screen) for about 10 seconds. During that time, no sysrq
>> works. After this short period, the tty1-framebuffer appears, with
>> messed up linebreaks (no carriage returns occur any more), and the
>> capslock-led starts blinking. Sysrq keys still don't work. The system is
>> completely frozen.
>>
>> Running the kernel from the bisected first good commit, the suspend is
>> faster (under 1 second) and the resume does not crash.
>>
>> I just saw the "HID: wacom: fix timeout on probe for some wacoms" mail,
>> which probably has to do something with my problem.
>>
>> Any ideas?
> 
> Yes, this commit will fix your problem. It has just been delayed for
> 3.17.1 as mentioned by Jiri today.
> 

Are you sure it's a good idea to let the kernel crash into 3.17.0 and
fix it later in stable? I suspect many X220t users could be affected.

Cheers,
Jonas

