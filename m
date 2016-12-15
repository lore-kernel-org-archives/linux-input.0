From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: enable the Surface 4 Type Cover Pro
 (JP) to report multitouch data
Date: Thu, 15 Dec 2016 20:42:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612152040200.16984@cbobk.fhfr.pm>
References: <OSXPR01MB0791C4F683C0E619C7660BEEF29D0@OSXPR01MB0791.jpnprd01.prod.outlook.com> <20161215082634.GC31881@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39577 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756446AbcLOTmO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Dec 2016 14:42:14 -0500
In-Reply-To: <20161215082634.GC31881@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Cc: Yuta Kobayashi <alu.ula@outlook.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, 15 Dec 2016, benjamin.tissoires@redhat.com wrote:

> On Dec 15 2016 or thereabouts, Yuta Kobayashi wrote:
> > From: Yuta Kobayashi <alu.ula@outlook.com>
> > 
> > Signed-off-by: Yuta Kobayashi <alu.ula@outlook.com>
> > ---
> >  drivers/hid/hid-core.c          | 2 --
> >  drivers/hid/hid-ids.h           | 1 -
> >  drivers/hid/hid-microsoft.c     | 2 --
> >  drivers/hid/usbhid/hid-quirks.c | 1 -
> >  4 files changed, 6 deletions(-)
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks. I still have one request though -- Yuta-san, could you please 
resend the patch with a brief description in the patch changelog (what the 
patch is achieving and why this way is the correct way to do so).

We generally want brief description even for the simpliest changes; 
future will be grateful.

Thanks,

-- 
Jiri Kosina
SUSE Labs

