From: Patrik Fimml <patrikf@chromium.org>
Subject: Re: Power-managing devices that are not of interest at some point in
 time
Date: Fri, 18 Jul 2014 12:23:34 -0700
Message-ID: <20140718192334.GA10631@google.com>
References: <20140718174712.GA3156@google.com>
 <Pine.LNX.4.44L0.1407181439560.979-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40107 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbaGRTXh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jul 2014 15:23:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so6001854pab.33
        for <linux-input@vger.kernel.org>; Fri, 18 Jul 2014 12:23:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1407181439560.979-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrik Fimml <patrikf@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dtor@google.com>, Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org, Benson Leung <bleung@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 18, 2014 at 03:00:46PM -0400, Alan Stern wrote:
> "Quiescing" is the wrong word.  "Quiescing a device" means stopping the
> device from doing anything, which isn't what you want.  You want to
> ignore any activity the device may generate and reduce the device's
> power consumption as much as possible.  A better word would be
> "deactivating".

Yeah, I agree that terminology is a bit tricky here, and we have some
words conveying a specific idea already ("suspend"). To me, deactivating
suggests a more permanent condition. FWIW, I've used "inhibit" in this
context before and think it captures the idea well, to add another
choice to the list.

> You mentioned that handles to the device would remain open.  So when 
> the user opens the lid again, the old handles would start functioning, 
> right?

That's the idea, yes, and I think this would be desirable for the input
device class at least.

> This has the disadvantage that the class device could not be
> unregistered, because doing so would invalidate the open handles.  
> Under such circumestances, how would a userspace video program know not
> to list a camera built into the lid among the possible video sources
> (an example given earlier in this discussion)?  The program would have
> to make an explicit test of the "deactivate" property -- it wouldn't
> automatically become aware that the camera wasn't available.
> 
> Would it sometimes be okay to unregister the class device and
> invalidate the old handles, forcing programs to open new handles when
> the lid is opened?  This would reduce the number of changes user 
> programs would need.

I guess we could potentially leave this for the device class to decide.

I'm not sure what the appropriate action for a video camera is anyway.
Should it go away completely, including its device? Should it be there,
but certainly not be the default choice when there is an external
camera? I'm thinking along the lines of some application's settings
dialog here, where it might be desirable to still be able to select the
internal camera for future recordings.

Of course, userspace could still decide simply not to
quiesce|deactivate|inhibit the device if that was desired.

Regards,
Patrik
