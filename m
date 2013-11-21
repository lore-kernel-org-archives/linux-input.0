From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 1/3] Only process ABS_MT_SLOT where there are slots
 available
Date: Thu, 21 Nov 2013 11:25:02 +0100
Message-ID: <20131121112502.44e5fda717c28516e7808e5d@studenti.unina.it>
References: <1384983141-31019-1-git-send-email-benjamin.tissoires@redhat.com>
	<1384983141-31019-2-git-send-email-benjamin.tissoires@redhat.com>
	<20131121045620.GA4702@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:45000 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844Ab3KUKZb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Nov 2013 05:25:31 -0500
In-Reply-To: <20131121045620.GA4702@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, simon@mungewell.org, case@corpsmoderne.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 20 Nov 2013 20:56:21 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Benjamin, Antonio,
> 
> On Wed, Nov 20, 2013 at 04:32:19PM -0500, Benjamin Tissoires wrote:
> > From: Antonio Ospite <ospite@studenti.unina.it>
> > 
> > This fixes the case when a non-multitouch device happens to have a HID
> > code equal to ABS_MT_SLOT, like the Sony Sixaxis has for the left dpad
> > analog control.
> > 
> > Updated to latest tree by Benjamin Tissoires.
> 
> I do not think this is a proper way to address the issue. Generic HID
> driver should not encroach onto multitouch ABS range and either stop
> mapping absolute axis or map them properly.
> 
> Thanks.

Dmitry I'd agree with you in principle, and I trusted your judgment on
that in 2011 too when I first came up with this "hack", and in fact I
didn't insist to have it merged, but then I failed to properly address
the issue and users were left with a non functional device for a long
time.

Now I've got some more experience, I know how to do it, and if you
decide to drop Benjamin's _defensive_ solution I will be more than
happy to remap the axes of the joypad to fix the issue the way you like
it, the way _we_ like it.

But there were some concerns about backward compatibility:
http://www.spinics.net/lists/linux-input/msg28280.html and following.

My position is egoistical here:

  - if you will accept a patch which remaps the keys to match the
    gamepad API, even breaking the current interface I'd say we go for
    that (the current keymap is not fully working anyway because of
    the ABS_MT issue).

  - if really "we do not break user space" no matter what, then
    Benjamin's patch is OK by me.

I think I see what your fear is here: if there is such defensive
fallback mechanism in place there will be no motivation to enforce
proper fixes by driver authors at the HID level, am I right?

So Benjamin, an alternative could be to spit out warnings when a non MT
device uses MT codes and curse at lazy developers like me in the logs.
What about that?

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
