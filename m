From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: HID battery strength does not emit power_suppy udev events
Date: Thu, 27 Dec 2012 22:16:02 -0200
Message-ID: <CACo8zOc5QkhotrEPdeK23rfkjPeOa5PgXpXjBUeFPrPWbTAJ1w@mail.gmail.com>
References: <CACo8zOe7MFp_O_2rQhkSPc_+LaSUBxHvsQwSY38ukKRioDHusA@mail.gmail.com>
	<CAD2FfiEbqUvfuUYpgQFaXoUBAn_7TnV4FnGXNDeD-jHCCfpGVQ@mail.gmail.com>
	<CACo8zOeSf_0ump=ChJKvgLQL1_OVoOE5Ts0ybw=5S3ZFMzZcGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:58927 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab2L1AW0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Dec 2012 19:22:26 -0500
Received: by mail-we0-f182.google.com with SMTP id u54so4778256wey.27
        for <linux-input@vger.kernel.org>; Thu, 27 Dec 2012 16:22:24 -0800 (PST)
In-Reply-To: <CACo8zOeSf_0ump=ChJKvgLQL1_OVoOE5Ts0ybw=5S3ZFMzZcGw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Jiri Kosina <jkosina@suse.cz>, Przemo Firszt <przemo@firszt.eu>, linux-input@vger.kernel.org

Hi, I've sent this message a while ago but forgot to add
linux-input, I'm really willing to give it a final fix to the issue
but I need directions, I really can't see what's wrong with
the udev thing, so again (with linux-input):

The problem is that when a HID device that has a battery
is added to the system it doesn't emit the udev events
for the battery added or removed, which breaks upower..

I reviewed all my previous patch, looked at input-wacom
to see if they did it differently for the battery issue, but
I couldn't find any problem, since I don't have a wacom
tablet maybe it also has the udev bug.

Well I looked through a lots of kernel code paths,
but the best I could find was:

"int kobject_uevent(struct kobject *kobj, enum kobject_action action);

Use the KOBJ_ADD action for when the kobject is first added to the kernel.
This should be done only after any attributes or children of the kobject
have been initialized properly, as userspace will instantly start to look
for them when this call happens."

Which might mean that a call like
kobject_uevent(&dev->kobj, KOBJ_ADD);
that I could only find in base/core.c is called
before the hid power_supply is registered,
I'm not a kernel dev so I might be totally wrong,
I also don't know the exact code path when the
device is added, could someone please give me
a hand on this?

Thanks,

--
Daniel Nicoletti

KDE Developer - http://dantti.wordpress.com
