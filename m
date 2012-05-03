From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work in
 xorg or gpm
Date: Thu, 3 May 2012 00:50:51 -0500
Message-ID: <20120503055051.GA15960@burratino>
References: <20120503052000.GC15205@burratino>
 <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:32966 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab2ECFvK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 May 2012 01:51:10 -0400
Received: by yenm10 with SMTP id m10so945624yen.19
        for <linux-input@vger.kernel.org>; Wed, 02 May 2012 22:51:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA217B7.7070908@osvaldobarrera.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: linux-input@vger.kernel.org, Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>, Benjamin Tissoires <benjamin.tissoires@enac.fr>

Hi Nestor et al,

Huge Osvaldo Barrera writes, regarding a Logitech USB Receiver
(id 046d:c52b) attached to a PowerBook6,5 [1]:

> My mouse does not seem to work, either with Xorg, or gpm.  It's a
> Logitech Performance MX.
>
> It works fine on -stable after a clean installation of the 6.0.4
> netinst ISO, but does not work either on testing, or sid.

(For context: stable = 2.6.32.y, testing and sid = 3.2.y.)

> It did not work a week ago, and does not work today either (so this
> has been broken on both sid and testing for a week now).
[...]
> When I installed stable and upgraded to testing, the device node
> /dev/input/mouse1 did exist (mouse0 is the trackpad), but "cat
> /dev/input/mouse1" showed no output when moving the mouse (mouse0
> did when moving the trackpad). When doing a clean install of
> testing, the device node mouse1 is never created.
>
> After looking at the dmesg and lsusb, the device itself seems to be
> detected, however, it does not work.
>
> The mouse works fine on another linux-based computer (ArchLinux,
> with kernel 3.3.2), so the mouse is not the issue.  I additionally
> have another identical mouse, which exhibits the same behaviour (on
> both computers).

He later clarified that the machine with ArchLinux was an amd64
machine.  So my first guess is that this might be an endianness issue
in the driver (hid_logitech_dj, which was a new driver introduced
during the 3.2 merge window).

Kernel log snippet, module list, and some other info are at [1].
Known problem?  Any hints for tracking this down?

Thanks,
Jonathan

[1] http://bugs.debian.org/671292
