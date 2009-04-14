From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Apple Wireless Mighty Mouse HWheel quirk
Date: Tue, 14 Apr 2009 23:09:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904142307260.13028@wotan.suse.de>
References: <3aaafc130904141224w3bb76cc1ic39c8c4fd738a458@mail.gmail.com> <49E4E7E1.7040109@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59006 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164AbZDNVJT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2009 17:09:19 -0400
In-Reply-To: <49E4E7E1.7040109@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "J.R. Mauro" <jrm8005@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, linux-input@vger.kernel.org

On Tue, 14 Apr 2009, Jiri Slaby wrote:

> > I have an Apple bluetooth mouse (info below) and have noticed that the 
> > horizontal scrolling is inverted. I've noticed some bug reports from 
> > others getting the same behavior. I looked at drivers/hid/hid-apple.c 
> > , and around line 444 I see that APPLE_INVERT_HWHEEL gets ORed in. I 
> > tried to trace the origins of the code, but I lost track of it before 
> > 8c19a515, where you moved Apple quirks to their own file. Is this 
> > quirk definitely correct?
> > Mouse's entry in /proc/bus/input/devices
> > I: Bus=0005 Vendor=05ac Product=030c Version=0200
> > I'm running Gentoo, vanilla 2.6.29 with no patches.
> I have no idea whether the inversion is correct or not. Or where the
> information comes from :).
> It was added in
> cb3fecc2f29056e89658e7eb371e7f9be66cda6d
> by Jiri Kosina, maybe he may shed some light on it?

I created this patch based solely on a bugreport, I didn't physically own 
the hardware at that time.

I think I have it somewhere. I will try to find it tomorrow or the day 
after tomorrow and verify whether the quirk is really needed. Maybe the 
original bug reporter messed up, or he had different hardware revision.

-- 
Jiri Kosina
SUSE Labs
