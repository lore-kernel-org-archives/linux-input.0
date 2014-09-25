From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: wacom: regression - system freezes when resuming from S3
 suspend
Date: Thu, 25 Sep 2014 02:24:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409250223240.22196@pobox.suse.cz>
References: <542039C1.1000605@in.tum.de> <CAN+gG=EfKHqo2++ejxJMqDxpOnav5qiVRJMRjXoDOrbWQVMnBQ@mail.gmail.com> <54221EFF.2060501@in.tum.de> <alpine.LNX.2.00.1409241032490.32397@pobox.suse.cz> <CAN+gG=HqiV1omKjhUEV22sWO8DVjiTY0t04qxmO7YtE540RsOw@mail.gmail.com>
 <54235FB9.5040706@in.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51432 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbaIYAZB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2014 20:25:01 -0400
In-Reply-To: <54235FB9.5040706@in.tum.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonas Jelten <jelten@in.tum.de>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Thu, 25 Sep 2014, Jonas Jelten wrote:

> I have no idea about the reasons yet, however my kernel indeed panics 10
> seconds after resume from S3. During the 10 seconds, the on-suspend X
> screen is visible, but frozen (no mouse/keyboard input) and no sysrqs
> are possible. After the 10s passed, I see old tty1 framebuffer parts
> from the init system log, the kernel seems to have paniced as the
> capslock led starts blinking, but I can't see any backtrace.

Is there any way you could setup serial console or at least netconsole on 
that system?

> I could not test whether "HID: wacom: fix timeout on probe for some
> wacoms" fixes the panic, as it does not apply for 3.17-rc6.

Just compiling for-3.18/wacom branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git

should be enough.

I still fail to see how this would be fixing any panic, so either there is 
a very strange race condition somewhere, or this is a different problem 
that still needs to be solved.

Thanks,

-- 
Jiri Kosina
SUSE Labs
