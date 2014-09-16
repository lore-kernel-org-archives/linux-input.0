From: simon@mungewell.org
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Mon, 15 Sep 2014 22:00:46 -0400
Message-ID: <8227f0fc35950a902241a8e053924ef3.squirrel@mungewell.org>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
    <CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
    <CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
    <20140915215728.GB13468@core.coreip.homeip.net>
    <CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
    <20140915225809.GA31798@core.coreip.homeip.net>
    <CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39806 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbaIPCAt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 22:00:49 -0400
In-Reply-To: <CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Wright <michaelwr@android.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>


> Even if I did add the plumbing for HID over into the LED subsystem, is
> there an
> easy way to correlate input devices and their LEDs from userspace?

You can follow the symlinks through the '/sys' filesystem. For example the
following all point to the same LED.
--
simon@womble:~$ ls
/sys/class/input/js0/device/device/leds/0003\:054C\:0268.0001\:\:sony1
brightness  device  max_brightness  power  subsystem  trigger  uevent
simon@womble:~$ ls /sys/class/leds/0003\:054C\:0268.0001\:\:sony1/
brightness  device  max_brightness  power  subsystem  trigger  uevent
simon@womble:~$ ls
/sys/bus/hid/devices/0003\:054C\:0268.0001/leds/0003\:054C\:0268.0001\:\:sony1/
brightness  device  max_brightness  power  subsystem  trigger  uevent
--

One problem that exists is that many HID devices don't have an (embedded)
serial number, so identification can be confused if you have more that one
identical device.

Simon.

