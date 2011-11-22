From: simon@mungewell.org
Subject: Re: joydev: support for Saitek PS1000 gamepad
Date: Tue, 22 Nov 2011 12:13:39 -0500
Message-ID: <95ab6669b51867deb14cdd81c79dead1.squirrel@host171.canaca.com>
References: <20111122102832.GA22152@v36691.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:51939 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757978Ab1KVRNk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Nov 2011 12:13:40 -0500
In-Reply-To: <20111122102832.GA22152@v36691.1blu.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Andreas_H=FCbner=22?= <andreas@k4n.de>
Cc: linux-input@vger.kernel.org

Hi Andreas,
I'm not involved with that bit of code, but here are some hints for you...

> I was trying to contact who I think is the maintainer of the joydev
> module (vojtech@suze.cz), but had no success. Apologies if this list is
> not the right target audience, I would appreciate any hints about who is
> currently maintaining the module.

You are asking in exactly the right place :-)

> It's also possible, that the issue is not related to joydev module
> itself. usb-hid could also be involved.

If the device is a HID device, it is quite possible that the HID
descriptor it is providing is 'wrong' (not properly understood by Linux).
We have to 'correct' these on a number of devices.

If you can post/decode the descriptor that might provide some insight into
the problem.

On newer kernels the descriptor can be found under the '/sys' directory.

For example (a HID gaming wheel I have):
--
simon@ubuntu:/sys/bus/hid/devices/0003:046D:C294.000B$ ls
driver  hidraw  power  range  report_descriptor  subsystem  uevent
simon@ubuntu:/sys/bus/hid/devices/0003:046D:C294.000B$ hexdump -C
report_descriptor
00000000  05 01 09 04 a1 01 a1 02  95 01 75 0a 15 00 26 ff 
|..........u...&.|
00000010  03 35 00 46 ff 03 09 30  81 02 95 0c 75 01 25 01 
|.5.F...0....u.%.|
00000020  45 01 05 09 19 01 29 0c  81 02 95 02 06 00 ff 09 
|E.....).........|
00000030  01 81 02 05 01 09 31 26  ff 00 46 ff 00 95 01 75 
|......1&..F....u|
00000040  08 81 02 25 07 46 3b 01  75 04 65 14 09 39 81 42 
|...%.F;.u.e..9.B|
00000050  75 01 95 04 65 00 06 00  ff 09 01 25 01 45 01 81 
|u...e......%.E..|
00000060  02 95 02 75 08 26 ff 00  46 ff 00 09 02 81 02 c0 
|...u.&..F.......|
00000070  a1 02 26 ff 00 46 ff 00  95 07 75 08 09 03 91 02 
|..&..F....u.....|
00000080  c0 0a ff ff 95 08 b1 02  c0                       |.........|
00000089
--

There are tools to capture and decode the binary block here:
http://digimend.sourceforge.net/

Simon


