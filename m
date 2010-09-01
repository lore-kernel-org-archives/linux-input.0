From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 2/7 v3] HID: magicmouse: simplify multitouch feature
 request
Date: Wed, 01 Sep 2010 09:50:42 -0400
Message-ID: <1283349042.2255.400.camel@mini>
References: <1283306184-28833-1-git-send-email-chase.douglas@canonical.com>
	 <1283306184-28833-3-git-send-email-chase.douglas@canonical.com>
	 <4C7E0433.8010008@euromail.se> <1283344475.2255.368.camel@mini>
	 <4C7E51AA.2050004@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:34633 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185Ab0IANu5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2010 09:50:57 -0400
In-Reply-To: <4C7E51AA.2050004@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2010-09-01 at 15:14 +0200, Henrik Rydberg wrote:
> On 09/01/2010 02:34 PM, Chase Douglas wrote:
> 
> > On Wed, 2010-09-01 at 09:43 +0200, Henrik Rydberg wrote:
> >> On 09/01/2010 03:56 AM, Chase Douglas wrote:
> >>
> >>> From: Chase Douglas <chase.douglas@ubuntu.com>
> >>>
> >>> Only the first feature request is required to put the Magic Mouse into
> >>> multitouch mode. This is also the case for the Magic Trackpad, for which
> >>> support will be added in a later commit.
> >>>
> >>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> >>> Acked-by: Michael Poole <mdpoole@troilus.org>
> >>> ---
> >>
> >>
> >> Since this is starting to look awfully similar to the mode switch found in
> >> appletouch and bcm5974, I wonder what happens to the stream from the device when
> >> the connection to hid is closed. It could be that the mode switch should be
> >> moved to open/close instead.
> > 
> > I don't really understand what you are proposing. It sounds like maybe
> > you want the device to continue to function in a non-multitouch way
> > after hid disconnection, but the device needs hid to function at all.
> 
> 
> Suspend/resume, broken bt connections, etc. There was an issue with the bcm5974
> macbook trackpads not functioning properly after a close unless returned to
> normal mode. The mode switch code was moved to the open/close functions for that
> reason.

I'm not sure how applicable this is to a bluetooth device though. On
suspend, the device is disconnected. On resume, the device should
reconnect through the hid layer again.

> > The closest thing I can think to what you are saying is to do whatever
> > it takes on module removal so that it goes back to functioning in the
> > non-multitouch mode. That may be possible.
> 
> 
> Sounds like a good start. Doing a suspend test just now I could not get the
> device up again, for whatever reason.

I'm having some sporadic issues too, but when I hit issues and I use
ftrace I see that the hid layer isn't doing everything it should. I'm
not sure how much is the fault of hid vs the driver.

-- Chase

