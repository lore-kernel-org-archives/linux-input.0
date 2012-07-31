From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: New Alps protocol in the wild?
Date: Tue, 31 Jul 2012 15:17:07 -0400
Message-ID: <87boivu4ek.fsf@gmail.com>
References: <87vch9w51w.fsf@gmail.com> <87hasp6x21.fsf@gmail.com> <87obmwld7n.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40483 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab2GaTRK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jul 2012 15:17:10 -0400
Received: by vcbfk26 with SMTP id fk26so6210857vcb.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jul 2012 12:17:09 -0700 (PDT)
In-Reply-To: <87obmwld7n.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>, Andrew Skalski <askalski@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, opensource@dell.com, Neil Brown <neilb@cse.unsw.edu.au>, Sebastian Kapfer <sebastian_kapfer@gmx.net>
Cc: linux-input@vger.kernel.org

Ben Gamari <bgamari.foss@gmail.com> writes:

> Sadly, this avenue of investigation is apparently a dead-end. After
> seeing nothing outbound to the mouse and hacking around enough to
> convince myself that filter driver is catching all traffic passed
> through the i8042prt driver, I finally decided to disassemble
> apfiltr.sys. Perhaps not unexpectedly, it seems they do some direct port
> I/O without going through the driver stack. Whether this is incompetance
> or malice we will never know, but it seems that the "clean" filter
> driver approach will not work here.
>
> Thankfully, it seems that an I/O port sniffer driver[1] has been written
> which might save me. Sadly, this isn't supported on 64-bit machines as
> Microsoft's compiler inexplicably lacks support for inline assembler on
> amd64. I've found a 32-bit copy of Vista lying around so we'll see how
> this works.
>
Unfortunately, it seems that this approach too may be a dead end. The
iosniffer driver appears to cause an immediate reboot (triple fault?) on
installing its hooks. Given the low-level nature of the crash, the
thought of tracking it down makes me shudder. If anyone else wants to
try installing the driver, it would be nice to have a second opinion. I
guess it's back to the virtualization approach.

Cheers,

- Ben

