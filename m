From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 0/5] HID: sony: misc fixes and cleanups
Date: Mon, 16 Feb 2015 23:29:10 +0100
Message-ID: <20150216232910.f909144a0459bf053402fc4e@ao2.it>
References: <20150216150659.db522f3d.cand@gmx.com>
	<1424106744-12872-1-git-send-email-ao2@ao2.it>
	<54E265C5.7050002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:8437 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbbBPW3R (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 17:29:17 -0500
In-Reply-To: <54E265C5.7050002@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

On Mon, 16 Feb 2015 16:48:53 -0500
Frank Praznik <frank.praznik@gmail.com> wrote:

> On 2/16/2015 12:12, Antonio Ospite wrote:
> > Hi,
> >
> > here are a few cleanups for hid-sony.
> >
> > Changes are meant to follow the patch titled:
> > [PATCHv4] HID: sony: Enable Gasia third-party PS3 controllers
> >
> > Frank, hi, I'd like to have your explicit ack at least for patch 1 and
> > 2.
> >
> > Thanks,
> >     Antonio
> >
> >
> > Antonio Ospite (5):
> >    HID: sony: Fix a WARNING shown when rmmod-ing the driver
> >    HID: sony: Use the minimum accepted size for feature report 0xf2
> >    HID: sony: Don't use magic numbers in sixaxis_set_operational_usb()
> >    HID: sony: Use __u8 * for the buffer in sixaxis_set_operational_usb()
> >    HID: sony: Coding style cleanups in sixaxis_set_operational_usb()
> >
> >   drivers/hid/hid-sony.c | 21 +++++++++++----------
> >   1 file changed, 11 insertions(+), 10 deletions(-)
> >
> Hi Antonio, could you resend patch #1?  It didn't show up in my email 
> and it's not on any of the web-based lists either.
> 

Done. Let me know if you didn't get it this time either.

I noticed that git-send-email set a later date, it shouldn't be a
problem but if it is patch 1/5 could be applied as 6/5 instead.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
