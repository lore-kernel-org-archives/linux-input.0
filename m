From: Christopher Heiny <christopherheiny@gmail.com>
Subject: Re: [PATCH 1/2] Input: synaptics - add second variant of two-button clickpad
Date: Thu, 01 Mar 2012 16:59:46 -0800
Message-ID: <1480064.SeUIWcqsCr@brontomerus.synaptics.com>
References: <1329193273-12486-1-git-send-email-chase.douglas@canonical.com> <4F4224EC.5000400@gmail.com> <20120301194503.GA3854@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63503 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab2CBA7v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Mar 2012 19:59:51 -0500
Received: by pbcup15 with SMTP id up15so1512933pbc.19
        for <linux-input@vger.kernel.org>; Thu, 01 Mar 2012 16:59:50 -0800 (PST)
In-Reply-To: <20120301194503.GA3854@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chase Douglas <chasedouglas@gmail.com>, linux-input@vger.kernel.org

On Thursday, March 01, 2012 11:45:03 AM Dmitry Torokhov wrote:
> On Mon, Feb 20, 2012 at 11:48:12AM +0100, Chase Douglas wrote:
> > On 02/14/2012 05:21 AM, Chase Douglas wrote:
> > > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> > > ---
> > > There are two models of Dell netbooks (Inspiron 1011 and 1012 IIRC)
> > > with two-button clickpads that do not match the current two-button
> > > clickpad bit mask. I don't have any docs to tell me which bits are
> > > which, but this bit seems the most probably. For reference, the
> > > caps bits for these netbooks are:
> > > 
> > > caps: 0xd04713/0xa40000/0x2a0000
> > > 
> > >  drivers/input/mouse/synaptics.h |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/input/mouse/synaptics.h
> > > b/drivers/input/mouse/synaptics.h index fd26ccc..816d7bd 100644
> > > --- a/drivers/input/mouse/synaptics.h
> > > +++ b/drivers/input/mouse/synaptics.h
> > > @@ -80,6 +80,7 @@
> > > 
> > >   */
> > >  
> > >  #define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100000) /* 1-button
> > >  ClickPad */ #define SYN_CAP_CLICKPAD2BTN(ex0c)	((ex0c) &
> > >  0x000100) /* 2-button ClickPad */> > 
> > > +#define SYN_CAP_CLICKPAD2BTN2(ex0c)	((ex0c) & 0x200000) /* 2-button
> > > ClickPad */> > 
> > >  #define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x020000)
> > >  #define SYN_CAP_MIN_DIMENSIONS(ex0c)	((ex0c) & 0x002000)
> > >  #define SYN_CAP_ADV_GESTURE(ex0c)	((ex0c) & 0x080000)
> > 
> > Dmitry, would you be able to comment on this soon? We're approaching
> > kernel freeze in Ubuntu and I want to have this patch in there if it
> > makes sense.
> 
> According to the data sent by Synaptics (ex0c & 0x60000) identifies
> algorithm used to count fingers, and not device type, at least not
> directly...
> 
> Christopher, any insight you could share?

Dmitry - I think you dropped a zero in the mask.  If that's the case, then you 
are correct, (ex0c & 0x600000) identifies the multifinger mode, independent of 
clickpad or not.

Chase - those capability bits look a bit wacky to me.  Can you tell me the TM 
number or product ID info for those pads?

