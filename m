From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: How write driver for gamepad, that detected by usbhid but not
 work correctly?
Date: Sun, 29 Sep 2013 11:39:47 +0200
Message-ID: <20130929113947.38ddbf1b@neptune.home>
References: <5247F168.10008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:45674 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab3I2Jjx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Sep 2013 05:39:53 -0400
In-Reply-To: <5247F168.10008@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "v1kt0p.rus@gmail.com" <v1kt0p.rus@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, 29 September 2013 "v1kt0p.rus@gmail.com" <v1kt0p.rus@gmail.com> wrote:
> I have "Genesis to USB adapter" and two genesis gamepads. On windows it 
> is work correctly. On linux do not work "left" and "up" buttons on 
> D-pad, and two gamepads appear as one with double buttons.
> At first I tried to write usb driver(usb_register), but when I connect 
> gamepad system choose usbhid driver not my. When I unplug gamepad system 
> call "probe" in my driver, but then immediately call "disconnect". Is 
> there a way to force the system to choose my driver first?
> Than I tried to write hid driver(hid_register_driver), but "probe" is 
> not called. I can not find documentation describing how to make a 
> working driver for hid, it exists at all?
> What is the correct way to write a driver for the gamepad? What am I 
> doing wrong?

You can have a look at all the drivers located under drivers/hid/ for
how they do it.

Two drivers that represent gamepads:
  hid-pl.c
  hid-saitek.c

Depending on how your gamepad shows up when there are two pads connected
you may need to register a second input device to send buttons from the
first pad to first input device, buttons from second to the extra input
device.

A good start to find out what your device does is to enable debugging
in your kernel and cat /sys/kernel/debug/hid/<your device>/events
to determine what happens on button presses.
You can then check how that output matches events sent from /dev/input/event*
matching your device and determine if all that is needed is proper
scancode translation of if more tuning is needed.

Bruno
