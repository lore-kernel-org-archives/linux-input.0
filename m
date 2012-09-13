From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synaptics Touchpad incorrectly detected as PS/2 mouse on clausoft MNW737 (aka meenee, aka PX1)
Date: Wed, 12 Sep 2012 21:48:56 -0700
Message-ID: <2638287.vWM0xnGHC0@dtor-d630.eng.vmware.com>
References: <CAMPG4Y-X9g8FUOYgfo4MBpLjKnnjf631=VriEZ30P+ML9f0Hcw@mail.gmail.com> <CAMPG4Y-2CJKHBTVQZPa1mRvHug5pyacr+XJ179wfVxfr0j-sHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42861 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab2IMEtB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 00:49:01 -0400
Received: by ieje11 with SMTP id e11so4236858iej.19
        for <linux-input@vger.kernel.org>; Wed, 12 Sep 2012 21:49:01 -0700 (PDT)
In-Reply-To: <CAMPG4Y-2CJKHBTVQZPa1mRvHug5pyacr+XJ179wfVxfr0j-sHg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ed Spittles <ed.spittles@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "755518@bugs.launchpad.net" <755518@bugs.launchpad.net>

On Wednesday, September 12, 2012 09:05:22 PM Ed Spittles wrote:
> The tpconfig tool is unable to adjust zthreshold or disable tap
> to click. tpconfig reports this:
> 
> # tpconfig -D1 -z0
> Probing mouse port [/dev/psaux].
> Grabbing mouse port [/dev/psaux].
> Trying Synaptics detection.
> [query 00 => 0x60 0x3 0xc8]
> Found Synaptics Touchpad.
> [query 0x3 => 0x60 0x3 0xc8]
> Firmware: 8.96 (multiple-byte mode).
> Z threshold set as "0".
> [query 0x1 => 0x60 0x3 0xc8]
> [query 0x1 => 0x60 0x3 0xc8]
> Z threshold: 6 of 7.
>

Please do not use tpconfig utility, it hasn't worked since 2.5 kernels.

> 
> OLD=/tmp/psmouse_debug1
> NEW=/tmp/psmouse_debug2
> sudo rmmod psmouse
> dmesg > $OLD
> echo 1 | sudo tee -a /sys/module/i8042/parameters/debug
> sudo modprobe -v psmouse
> echo 0 | sudo tee -a /sys/module/i8042/parameters/debug
> dmesg > $NEW
> diff $OLD $NEW

Can you please simply boot with i8042.debug kernel option and post your
entire dmesg instead?

Thanks.

-- 
Dmitry
