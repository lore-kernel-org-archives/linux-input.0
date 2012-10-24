From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Multiple clients reading from /dev/input/eventX
Date: Tue, 23 Oct 2012 22:07:10 -0700
Message-ID: <20121024050710.GA13826@core.coreip.homeip.net>
References: <e6193392fbe49d7236b39e3b17b8fa81.squirrel@mungewell.org>
 <20121019223210.GA10915@core.coreip.homeip.net>
 <e603df72a1ba52e724eb72802bd93f48.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59324 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab2JXFHP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Oct 2012 01:07:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so111880pad.19
        for <linux-input@vger.kernel.org>; Tue, 23 Oct 2012 22:07:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e603df72a1ba52e724eb72802bd93f48.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On Wed, Oct 24, 2012 at 12:26:17AM -0400, simon@mungewell.org wrote:
> >> Can anyone here confirm the behaviour under the situation that one
> >> client
> >> is busy? What is the maximum time it can be 'away' or what is the size
> >> of
> >> the inline buffer?
> >
> > Every user of event device has a buffer that can hold up at least 64
> > input events and is completely independent from other users. Newer
> > kernels generate EV_SYN/SYN_DROPPED event to indicate that user was too
> > slow reading data and there was buffer overrun.
> >
> > Hope this helps.
> 
> Yes, very helpful.... I am seeing 'SYN_DROPPED' on my system, so the next
> question is how to work around this?
> 
> In the event of an overflow is there any method of reading/polling the
> last (correct) event value for each of the axis?

EVIOCGABS() and other ioctls allow to query state of the device.

> 
> In my case on the G27 wheel when your foot transitions from the brake to
> accelerator, you get no more 'brake events' to 'refresh' the value.
> 
> I see that I could use QUIRK to enlarge the buffer for this device, would
> that be an acceptable workaround?
> http://www.spinics.net/lists/linux-input/msg15497.html

With 3.7 Henrik just put in code that would better estimate number of
events in devices event packet, so hopefully quirk is not needed.

> 
> Attached is a little log showing SDL 'missing' 68 events, which are
> correctly reported by 'evtest'. The time stamps in log will give you an
> idea about how quickly the events are coming in from this wheel.

You need to figure out why SDL takes such a long time to get around
reading device data

Thanks.

-- 
Dmitry
