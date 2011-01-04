From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: magicmouse: Don't report REL_{X,Y} for Magic
 Trackpad
Date: Tue, 4 Jan 2011 11:25:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101041124200.26685@pobox.suse.cz>
References: <1291849685-2623-1-git-send-email-chase.douglas@canonical.com> <alpine.LNX.2.00.1012091440410.508@pobox.suse.cz> <4D00F217.6050609@canonical.com> <4D224A0B.8010408@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D224A0B.8010408@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 3 Jan 2011, Chase Douglas wrote:

> >>> With the recent switch to having the hid layer handle standard axis
> >>> initialization, the Magic Trackpad now reports relative axes. This would
> >>> be fine in the normal mode, but the driver puts the device in multitouch
> >>> mode where no relative events are generated. Also, userspace software
> >>> depends on accurate axis information for device type detection. Thus,
> >>> ignoring the relative axes from the Magic Trackpad is best.
> >>
> >> Applied, thank you. I take it this should better go into .37 still, right?
> > 
> > Yes, please.
> 
> Jiri,
> 
> It looks like this never got pushed to .37. Can you add "Cc:
> stable@kernel.org" to the SOB area and push it?

Hi Chase,

I am not rebasing my tree, so it's not easy to add Cc: stable@kernel.org 
to the commit once it has been mirrored out.

But I have this commit in my list to send it to -stable once it goes to 
Linus, manually.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
