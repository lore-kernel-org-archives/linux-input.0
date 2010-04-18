From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Sun, 18 Apr 2010 13:19:24 -0700
Message-ID: <201004181319.25318.dmitry.torokhov@gmail.com>
References: <1271434792.2045.5.camel@localhost.localdomain> <20100418194328.GA17565@core.coreip.homeip.net> <1271620177.19833.3471.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:55576 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab0DRUTd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Apr 2010 16:19:33 -0400
Received: by yxe29 with SMTP id 29so2136710yxe.4
        for <linux-input@vger.kernel.org>; Sun, 18 Apr 2010 13:19:33 -0700 (PDT)
In-Reply-To: <1271620177.19833.3471.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sunday 18 April 2010 12:49:37 pm Bastien Nocera wrote:
> On Sun, 2010-04-18 at 12:43 -0700, Dmitry Torokhov wrote:
> > On Sat, Apr 17, 2010 at 10:44:55PM +0100, Bastien Nocera wrote:
> > > On Sat, 2010-04-17 at 01:12 -0700, Dmitry Torokhov wrote:
> > > > HI Bastien,
> > > > 
> > > > On Fri, Apr 16, 2010 at 05:19:52PM +0100, Bastien Nocera wrote:
> > > > > This driver was originally written by James McKenzie, updated by
> > > > > Greg Kroah-Hartman, further updated by myself, with suspend support
> > > > > added.
> > > > > 
> > > > > More recent versions of the IR receiver are also supported through
> > > > > a patch by Alex Karpenko.
> > > > > 
> > > > > Tested on a MacbookAir1,1
> > > > 
> > > > A few comments...
> > > 
> > > All fixed. I removed the suspend/resume code as it worked fine without
> > > it (I was working of an old patch).
> > > 
> > > Sent the new patch separately.
> > 
> > Hmm, I am curious why suspend and resume is not necessary for this
> > device... Are you relying on the USB core to tear down and re-create the
> > device? Then you may lose user-applied settings (like changed keymap).
> 
> How could I test that?

Change the keymap (with keyfuzz or something similar), suspend. resume and see 
if the mapping persisted.
 
> 
> > But if suspend and resume are really not needed then you need to
> > complete cleanup and get rid of APPLIEIR_OPENED and APPLEIR_SUSPENDED
> > and their handling in applieir_open() and appleir_close().
> 
> My mistake. I'll clean that up now.
> 
> > Right. I was just saying that Jiri needs to either take HID parts
> > through his tree or give OK for me to take through mine.
> 
> OK.

-- 
Dmitry
