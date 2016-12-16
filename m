From: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: enable the Surface 4 Type Cover Pro
 (JP) to report multitouch data
Date: Fri, 16 Dec 2016 09:10:11 +0100
Message-ID: <20161216081011.GF31881@mail.corp.redhat.com>
References: <OSXPR01MB0791C4F683C0E619C7660BEEF29D0@OSXPR01MB0791.jpnprd01.prod.outlook.com>
 <20161215082634.GC31881@mail.corp.redhat.com>
 <alpine.LNX.2.00.1612152040200.16984@cbobk.fhfr.pm>
 <OSXPR01MB0791665ABC048023FE1E653EF29C0@OSXPR01MB0791.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753839AbcLPIKP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Dec 2016 03:10:15 -0500
Content-Disposition: inline
In-Reply-To: <OSXPR01MB0791665ABC048023FE1E653EF29C0@OSXPR01MB0791.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yuta Kobayashi <alu.ula@outlook.com>
Cc: Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

On Dec 16 2016 or thereabouts, Yuta Kobayashi wrote:
> Thank you for advice.
> 
> I found this thread.
> http://www.spinics.net/lists/linux-input/msg48065.html
> 
> I think special drivers for Type Cover will not be needed by the patches.
> So i removed some defines  such as patch below.
> http://www.spinics.net/lists/linux-input/msg48068.html 
> 
> Will not this be ground?
> 
> If so, my idea is just wrong, sorry.

Actually, your idea is right. The thing Jiri is asking is just a small
paragraph in the patch explaining why this is required. Both Jiri and I
know this is the good approach but it is purely for documentation
purpose.

Something along the lines would be:
---
Since commit 8fe89ef076fa1 ("HID: multitouch: enable the Surface 3 Type
Cover to report multitouch data"), the TypeCover can be properly handled
by hid-multitouch and don't require any special quirk in the kernel.

Remove the support of the Surface 4 Type Cover Pro (JP) from
hid-microsoft so it can properly report multitouch from the touchpad.
---

Add this paragraph below a blank line after the title of the commit and
before your signed-off-by and my reviewed-by, resubmit and we are good
to go.

Cheers,
Benjamin

> 
> Thanks.
> 
> 2016-12-16 15:46 GMT+09:00 Yuta Kobayashi <alu.ula@outlook.com>:
> > On Thu, 15 Dec 2016, benjamin.tissoires@redhat.com wrote:
> >
> >> On Dec 15 2016 or thereabouts, Yuta Kobayashi wrote:
> >> > From: Yuta Kobayashi <alu.ula@outlook.com>
> >> >
> >> > Signed-off-by: Yuta Kobayashi <alu.ula@outlook.com>
> >> > ---
> >> >  drivers/hid/hid-core.c          | 2 --
> >> >  drivers/hid/hid-ids.h           | 1 -
> >> >  drivers/hid/hid-microsoft.c     | 2 --
> >> >  drivers/hid/usbhid/hid-quirks.c | 1 -
> >> >  4 files changed, 6 deletions(-)
> >>
> >> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > Thanks. I still have one request though -- Yuta-san, could you please
> > resend the patch with a brief description in the patch changelog (what the
> > patch is achieving and why this way is the correct way to do so).
> >
> > We generally want brief description even for the simpliest changes;
> > future will be grateful.
> >
> > Thanks,
> >
> > --
> > Jiri Kosina
> > SUSE Labs
> >
