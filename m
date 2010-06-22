From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 3/3] HID: magicmouse: enable horizontal scrolling
Date: Mon, 21 Jun 2010 23:08:53 -0400
Message-ID: <1277176133.3242.237.camel@mini>
References: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
	 <1277083951-29137-4-git-send-email-chase.douglas@canonical.com>
	 <87eifzdfdn.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:35765 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758800Ab0FVDJD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 23:09:03 -0400
In-Reply-To: <87eifzdfdn.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Mon, 2010-06-21 at 21:29 -0400, Michael Poole wrote:
> Chase Douglas writes:
> 
> > Mimicks OS X behavior.
> >
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> > ---
> >  drivers/hid/hid-magicmouse.c |   25 +++++++++++++++++++------
> >  1 files changed, 19 insertions(+), 6 deletions(-)
> 
> I like this general idea, but Dmitry Torokhov didn't like my previous
> patch to achieve a similar effect:
> https://patchwork.kernel.org/patch/84201/

To be fair, that patch had a lot more in it. I'm not sure that appending
horizontal scroll to what's already in the driver is too much to ask.

> The only behavioral question I would have is whether a single
> touch/swipe should be locked in one direction or if it should be able to
> generate both horizontal and vertical scroll events.  That seems like a
> user preference thing to me.

Not that we should necessarily mimick OS X, but they scroll in both axes
simultaneously. I have no problem with it, and I've not heard of anyone
else gripe either.

Locking it in to one direction may not seem logical to an end user, and
would add more complexity to the code.

> (My real wish is for X and the various widget libraries to get decent
> multitouch support soon, so that the kernel doesn't have to address
> those policy questions.)

I'm trying to help out with that, and I realize it's the real end-game
here. However, like you said, there's no support quite yet. So while end
users twiddle their thumbs waiting for support above the kernel, we
should throw them a bone.

-- Chase

