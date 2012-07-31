From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: New Alps protocol in the wild?
Date: Tue, 31 Jul 2012 16:50:11 -0400
Message-ID: <877gtju03g.fsf@gmail.com>
References: <87vch9w51w.fsf@gmail.com> <87hasp6x21.fsf@gmail.com> <87obmwld7n.fsf@gmail.com> <20120731060156.GA32327@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61435 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab2GaUuO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jul 2012 16:50:14 -0400
Received: by vbbff1 with SMTP id ff1so6250219vbb.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jul 2012 13:50:13 -0700 (PDT)
In-Reply-To: <20120731060156.GA32327@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, opensource@dell.com
Cc: linux-input@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Andrew Skalski <askalski@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>, Neil Brown <neilb@cse.unsw.edu.au>, Sebastian Kapfer <sebastian_kapfer@gmx.net>

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> Given how unwilling they are to share details of their protocol I would
> not be surprised if they tried to detect virtual environment on purpose.
>
Sadly, you very well could be right.

That being said, I don't know what they could be checking for. I'm
passing "-cpu host" to qemu which should eliminate the CPUID
hint. Otherwise, the only obvious hint I can find is the hard drive
which mentions Qemu in its vendor string. Taking a quick look at the
apfiltr.sys I can't find any strings that might imply it's looking at
device/vendor strings. Perhaps they could be using ACPI tables (although
I see no ACPI-ish strings in the driver)? I guess SMBIOS and DMI are
also targets although I know little about their implementation.

Anyways, I suppose at this point it is probably time to bring this
discussion over to the qemu list to discuss future directions for
virtualization. Unfortunately, it becomes very difficult to maintain
motivation on problems like this when Alps will likely render whatever
reverse engineering knowledge gained now obsolete in the next iteration
of hardware. It seems clear that the only sustainable way to get
open-source support for these and future Alps devices is with some
cooperation from Alps and/or a major customer. It seems that Dell is in
an ideal position to help here.

Cheers,

- Ben

