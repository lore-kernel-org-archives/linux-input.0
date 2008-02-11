From: Erik Slagter <erik@slagter.name>
Subject: Re: event devices not released
Date: Mon, 11 Feb 2008 21:15:57 +0100
Message-ID: <47B0ACFD.7080808@slagter.name>
References: <47B043ED.3020309@slagter.name> <20080211115631.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:59639 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324AbYBKUP7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2008 15:15:59 -0500
In-Reply-To: <20080211115631.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Erik,

> On Mon, Feb 11, 2008 at 01:47:41PM +0100, Erik Slagter wrote:
>> Hi,

>> I think I've found a bug :-/

>> Symptoms: when I remove (unplug) a USB keyboard or mouse, the corresponding 
>> event device seems to be closed but not released; when I plug the device 
>> back in, it gets a new input device handle. This means that after several 
>> suspend/resume cycles (in which it seems all usb devices are virtually 
>> unplugged and replugged) the kernel is out of event devices and complains 
>> likewise. My nice little program that catches specific keystrokes also 
>> stops to get any interesting events from that moment on. After reboot 
>> everything works again as expected.

>> I've seen a similar bug report on linux-kernel but it wasn't followed up 
>> on. Also this only mentioned problems through suspend cycles while I also 
>> have the problem simply plugging in and out.

>> Environment: linux kernel 2.6.24 vanilla on i386. The event files are held 
>> open by one or more processes when the devices are unplugged. Unfortunatly 
>> my program is not the only one that has them open, but hald and Xorg also 
>> have some of the devices open, so I cannot prevent this situation. Upon 
>> POLLERR | POLLHUP my app closes all event devices and rescans the 
>> /dev/input directory, this should be enough imho? I don't know how the 
>> other apps handle unplugging.

> What happens if you kill HAL and X and leave only your application
> running? Do event devices get released/reused in this case? Do you
> see POLLERR or POLLHUP signals devlievered to your app?

So this is what I did, I rebooted the machine (to have a clean start), I 
  killed haldaemon (which unfortunately already had been started). X 
wasn't started yet. According to $(fuser) none of the event devices were 
in use. Then I pulled the USB cable out, that has my USB keyboard and 
mouse attached to it (via a hub of course) and plugged the cable back 
in. Dmesg now shows that the mouse and keyboard have had new event id's 
assigned. So it looks like the problem also manifests itself when the 
event devices are not open when the corresponding devices are removed.

I forgot to perform the other test with poll, and it's not so easy to 
perform, because I need to shutdown X for that and... without X I don't 
access to my mailbox :-/

It this enough information for you for the moment or do I need to do the 
poll test or do a check with "virgin" event devices (not been opened at 
all since boot time)?

BTW concerning my little app with the poll() call, poll works as 
expected, also after all event devices have been used up, it's just that 
no events are delivered for the devices that didn't get an event device 
assigned, if you get what I mean.

BTW2 problems with LCD-output switching using the keyboard (FN+F8 = 
CRT/LCD switch on my laptop) that used to work but doesn't anymore since 
2.6.23, is that also an "input" list issue or would I need to complain 
somewhere else ;-)
