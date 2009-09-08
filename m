From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Tue, 8 Sep 2009 19:42:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de>
References: <bfb1bb1f0909061357m4006a61co1c1b4dfa483b947b@mail.gmail.com>  <alpine.LNX.2.00.0909071731120.23856@wotan.suse.de> <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47018 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbZIHRmE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Sep 2009 13:42:04 -0400
In-Reply-To: <bfb1bb1f0909071047h1a4cbc3dx175f89ecedc3555d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tim Cole <tim.cole@canonical.com>, Tim Gardner <tim.gardner@cano>


[ added some CCs

  In short -- Sergey has problem with his joystick not being properly 
  handled starting with 2.6.30 kernel (it used to work with 2.6.29 and 
  older). The problem is that joydev is not created. ]


On Mon, 7 Sep 2009, Sergey Kolesnikov wrote:

> Here goes /proc/bus/input/devices dump (VID/PID included):
> 
> I: Bus=0003 Vendor=06a3 Product=0762 Version=0111
> N: Name="Saitek Saitek X52 Pro Flight Control System"
> P: Phys=usb-0000:00:1d.7-6.3/input0
> S: Sysfs=/devices/pci0000:00/0000:00:1d.7/usb7/7-6/7-6.3/7-6.3:1.0/input/input10
> U: Uniq=
> H: Handlers=event6
> B: EV=1b
> B: KEY=7f ffffffff00000000 0 0 0 0
> B: ABS=3000003007f
> B: MSC=10

If I got my math right, this means that the KEY bitmask includes digitizer 
BTN_DIGI/BTN_TOOL_PEN, right?

Sergey, I believe that reverting commit d07a9cba6b (you can do so using 
git revert d07a9cba6b) will fix your joystick, is that correct?

> This could be compared to device successfully identified as joystick:
> 
> I: Bus=0003 Vendor=06a3 Product=5f0d Version=0110
> N: Name="Saitek PLC Saitek P2600 Rumble Force Pad"
> P: Phys=usb-0000:00:1d.7-6.4/input0
> S: Sysfs=/devices/pci0000:00/0000:00:1d.7/usb7/7-6/7-6.4/7-6.4:1.0/input/input11
> U: Uniq=
> H: Handlers=js0 event7
> B: EV=1b
> B: KEY=fff00000000 0 0 0 0
> B: ABS=300c3
> B: MSC=10

Yup, this device doesn't have BTN_DIGI in its keymask, so it's not 
blacklisted by joydev_blacklist[] entry.

It will be also interesting to obtain HID debugging output (*) from the 
time the device gets plugged in, so that we can check why is mapping of 
BTN_DIGI established and to check whether it makes any sense. What kind of 
joystick is that?

(*) configure the kernel with CONFIG_HID_DEBUG set, modprobe the 'hid' 
device with 'debug=2' parameter, plug the device in, and send the dmesg 
output.

-- 
Jiri Kosina
SUSE Labs
