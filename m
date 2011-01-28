From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 2/2] input: evdev: Add EVIOC mechanism to extract the MT
 slot state
Date: Fri, 28 Jan 2011 09:39:37 -0800
Message-ID: <20110128173936.GD6252@core.coreip.homeip.net>
References: <1296124547-3323-1-git-send-email-benjamin.tissoires@enac.fr>
 <1296124547-3323-3-git-send-email-benjamin.tissoires@enac.fr>
 <20110127120945.GC15626@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59771 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab1A1Rjt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 12:39:49 -0500
Content-Disposition: inline
In-Reply-To: <20110127120945.GC15626@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Ping Cheng <pingc@wacom.com>, Jiri Kosina <jkosina@suse.cz>, Chris Bagwell <chris@cnpbagwell.com>, Rafi Rubin <rafi@seas.upenn.edu>, Stephane Chatty <chatty@lii-enac.fr>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 27, 2011 at 01:09:45PM +0100, Henrik Rydberg wrote:
> On Thu, Jan 27, 2011 at 11:35:47AM +0100, Benjamin Tissoires wrote:
> > This patch adds the ability to extract the MT slot state sequentially
> > via EVIOCGABS. The slot parameter is first selected by calling
> > EVIOCSABS with ABS_MT_SLOT as argument, followed by a set of EVIOCGABS
> > calls. The slot selection is local to the evdev client handler, and
> > does not affect the actual input state.
> 
> Ok - it seemed like a reasonable idea at the time, but..
> 
> > @@ -767,9 +769,10 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
> >  			if (size < sizeof(struct input_absinfo))
> >  				abs.resolution = 0;
> >  
> > -			/* We can't change number of reserved MT slots */
> > -			if (t == ABS_MT_SLOT)
> > -				return -EINVAL;
> > +			if (t == ABS_MT_SLOT) {
> > +				client->slot = abs.value;
> > +				return 0;
> > +			}
> 
> ...this just does not look right. Perhaps there should really be a
> different ioctl to retrieve the slot values instead. Dmitry?
> 

Yes, a separate ioctl with explicit slot number is much better option.
Then it is automatically multi-thread safe and just does not look
ugly as hell.

Thanks.

-- 
Dmitry
