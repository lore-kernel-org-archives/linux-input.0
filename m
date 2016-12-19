From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: asus: Fix keyboard support
Date: Mon, 19 Dec 2016 11:26:31 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191125200.19203@cbobk.fhfr.pm>
References: <20161129091344.GD24670@mail.corp.redhat.com> <1481365242-13528-1-git-send-email-redmcg@redmandi.dyndns.org> <20161210211756.GE1919@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758772AbcLSK0e (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 05:26:34 -0500
In-Reply-To: <20161210211756.GE1919@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Brendan McGrath <redmcg@redmandi.dyndns.org>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Vlasenko <victor.vlasenko@sysgears.com>

On Sat, 10 Dec 2016, Benjamin Tissoires wrote:

> Sorry for breaking the existing device.
> 
> I have a few minor issues with your patch, but I'll let Jiri says
> whether or not you need a v2.
> 
> On Dec 10 2016 or thereabouts, Brendan McGrath wrote:
> > The previous submission which added Touchpad support broke the
> > Keyboard support of this driver. This patch:
> > 1. fixes the Keyboard support (by assigning drvdata->input);
> 
> This is actually what was breaking your keyboard (plus item 4 which is
> cosmetic). Ideally, this should be in a separate patch.
> 
> > 2. renames NOTEBOOK_QUIRKS to KEYBOARD_QUIRKS;
> > 3. adds the NO_INIT_REPORT quirk to the KEYBOARD_QUIRKS; and
> 
> Points 2 and 3 are actually improvements because I can't seem to find
> that previously the keyboard had this quirk. I understand it is
> valuable, but it should be in a different patch IMO.
> 
> > 4. sets the input->name to 'Asus Keyboard' for the keyboard 
> 
> Cosmetic, but so important :)
> 
> Anyway, the patch in its current form is:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> But it might be good to split it in 2 (it will depend on Jiri I guess).

Having it separate would be slightly better next time, but I don't 
consider that really to be a show stopper. Queuing in 
for-4.10/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

