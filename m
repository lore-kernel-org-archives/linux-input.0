From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: New Alps protocol in the wild?
Date: Mon, 30 Jul 2012 12:19:50 -0400
Message-ID: <87hasp6x21.fsf@gmail.com>
References: <87vch9w51w.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48947 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab2G3QTw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jul 2012 12:19:52 -0400
Received: by vcbfk26 with SMTP id fk26so4823623vcb.19
        for <linux-input@vger.kernel.org>; Mon, 30 Jul 2012 09:19:52 -0700 (PDT)
In-Reply-To: <87vch9w51w.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Andrew Skalski <askalski@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <pekero2@telia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Just to keep everyone in the loop, I've tried both VirtualBox and Qemu
now and the Alps driver appears to work under neither. After some
reflection, I finally resolved to brave the jungle that is Windows
driver development and now have the beginnings of a PS/2 filter
driver[1]. It's quite hacked together and is likely a textbook example
of how not to write a Windows driver, but it's nearly working. That
being said, if anyone has experience with NT kernel development, feel
free to assist in any way you can.

That being said, I'd recommend you don't install it at the moment; it
currently BSODs from use of DebugPrint in an ISR. Before breaking it,
however, I was able to get incoming data from the trackpad. The breaking
changes were an attempt to gather outgoing commands to the device so I'm
(hopefully) not far from having traces.

Cheers,

- Ben


[1] https://github.com/bgamari/ps2log
