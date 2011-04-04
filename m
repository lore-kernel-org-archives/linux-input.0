From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] hid-magicmouse: Increase evdev buffer size
Date: Mon, 4 Apr 2011 14:39:10 -0700
Message-ID: <20110404213910.GD984@core.coreip.homeip.net>
References: <1301691819-2090-1-git-send-email-chase.douglas@canonical.com>
 <AANLkTim-tN=siA8tJVCzNZHs+oM0hN-N8Ckc+9ynnNpb@mail.gmail.com>
 <alpine.LNX.2.00.1104041441530.28516@pobox.suse.cz>
 <BANLkTikG-ku9mDebcaPKTwv3X0N+OKiyYQ@mail.gmail.com>
 <4D9A1407.6030308@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46716 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab1DDVjQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Apr 2011 17:39:16 -0400
Content-Disposition: inline
In-Reply-To: <4D9A1407.6030308@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jeffrey Brown <jeffbrown@android.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Simon Budig <simon@budig.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 04, 2011 at 02:55:03PM -0400, Chase Douglas wrote:
> On 04/04/2011 02:13 PM, Jeffrey Brown wrote:
> > On Mon, Apr 4, 2011 at 5:43 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> >> I'd happuly take Chase's patch, but want to make sure that we don't cause
> >> any changes that would make backwards compatilibity an issue later.
> > 
> > There should be no compatibility issues.  However, we might be better
> > off in the long term taking (some variation of) these patches instead.
> 
> I like the proposed changes, but I want to ensure stable kernel releases
> aren't left out of the fix for hid-magicmouse. I don't know the best way
> forward, but here's one possibility:
> 
> 1. Apply my patch to manually set the buffer size hint
> 2. It gets sent to stable trees due to the 'Cc: stable@kernel.org' line
> 3. Apply Jeffrey's patches, including a reversion of my buffer size hint
> 
> Obviously the extra application and reversion is odd, but this seems the
> easiest way forward given that the patches already exist and can be
> applied without issue.
> 

Or, once Jeffrey's patches hit mainline, send your change to stable with
the explanation why it is needed for stable but not for mainline.

Thanks.

-- 
Dmitry
