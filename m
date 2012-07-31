From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: New Alps protocol in the wild?
Date: Tue, 31 Jul 2012 01:19:24 -0400
Message-ID: <87obmwld7n.fsf@gmail.com>
References: <87vch9w51w.fsf@gmail.com> <87hasp6x21.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48832 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916Ab2GaFT1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jul 2012 01:19:27 -0400
Received: by vcbfk26 with SMTP id fk26so5446967vcb.19
        for <linux-input@vger.kernel.org>; Mon, 30 Jul 2012 22:19:26 -0700 (PDT)
In-Reply-To: <87hasp6x21.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Andrew Skalski <askalski@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, opensource@dell.com, Neil Brown <neilb@cse.unsw.edu.au>, Sebastian Kapfer <sebastian_kapfer@gmx.net>

Ben Gamari <bgamari.foss@gmail.com> writes:

> Just to keep everyone in the loop, I've tried both VirtualBox and Qemu
> now and the Alps driver appears to work under neither. After some
> reflection, I finally resolved to brave the jungle that is Windows
> driver development and now have the beginnings of a PS/2 filter
> driver[1]. It's quite hacked together and is likely a textbook example
> of how not to write a Windows driver, but it's nearly working. That
> being said, if anyone has experience with NT kernel development, feel
> free to assist in any way you can.
>
> That being said, I'd recommend you don't install it at the moment; it
> currently BSODs from use of DebugPrint in an ISR. Before breaking it,
> however, I was able to get incoming data from the trackpad. The breaking
> changes were an attempt to gather outgoing commands to the device so I'm
> (hopefully) not far from having traces.
>
Sadly, this avenue of investigation is apparently a dead-end. After
seeing nothing outbound to the mouse and hacking around enough to
convince myself that filter driver is catching all traffic passed
through the i8042prt driver, I finally decided to disassemble
apfiltr.sys. Perhaps not unexpectedly, it seems they do some direct port
I/O without going through the driver stack. Whether this is incompetance
or malice we will never know, but it seems that the "clean" filter
driver approach will not work here.

Thankfully, it seems that an I/O port sniffer driver[1] has been written
which might save me. Sadly, this isn't supported on 64-bit machines as
Microsoft's compiler inexplicably lacks support for inline assembler on
amd64. I've found a 32-bit copy of Vista lying around so we'll see how
this works.

Of course, if anyone has any idea what might be breaking the
virtualization approach, I'd love to hear. Moreover, if anyone knows
someone (at Dell or elsewhere) who might be able to get a hold of an ear
at Alps, this would be greatly appreciated.

Cheers,

- Ben


[1] http://www.codeproject.com/Articles/96142/I-O-port-sniffer

