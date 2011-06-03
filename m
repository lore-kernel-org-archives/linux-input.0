From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Fri, 3 Jun 2011 12:02:09 +0800
Message-ID: <BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
	<20110602144146.GB3508@nautilus.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43390 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab1FCECL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jun 2011 00:02:11 -0400
Received: by wwa36 with SMTP id 36so1268674wwa.1
        for <linux-input@vger.kernel.org>; Thu, 02 Jun 2011 21:02:09 -0700 (PDT)
In-Reply-To: <20110602144146.GB3508@nautilus.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

2011/6/2 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> It depends on your userspace. It should work properly with X.org drivers
> evdev and evtouch. Are you trying this with Android?

Yes, exactly.

Actually the touchscreen is detected, but it appears twice:

[    3.408922] input: HID TOUCH HID Touch Panel as
/devices/pci0000:00/0000:00:1d.3/usb5/5-2/5-2:1.0/input/input6
[    3.412345] input: HID TOUCH HID Touch Panel as
/devices/pci0000:00/0000:00:1d.3/usb5/5-2/5-2:1.0/input/input7
[    3.415386] generic-usb 0003:1BFD:1688.0003: input: USB HID v1.01
Mouse [HID TOUCH HID Touch Panel] on usb-0000:00:1d.3-2/input0

I tried to use getevent, a debug tool of android,
to get the touch events.
I found touch events appear in /dev/event7,
not in /dev/event6.
Is it the desired behavior?

But the Android framework seems only detect
/dev/event6 and ignore /dev/event7,
probably because they have the same name.

Any suggestion how to solve the problem?

Regards,
-- 
Chih-Wei
Android-x86 project
http://www.android-x86.org
