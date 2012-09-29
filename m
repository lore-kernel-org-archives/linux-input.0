From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [GIT PULL] Input and HID updates for 3.7
Date: Sat, 29 Sep 2012 11:02:17 +0200
Message-ID: <20120929090217.GA1290@polaris.bitmath.org>
References: <20120919185605.GA778@polaris.bitmath.org>
 <alpine.LNX.2.00.1209192351120.22959@pobox.suse.cz>
 <20120928173539.GB6356@core.coreip.homeip.net>
 <alpine.LNX.2.00.1209282218350.17437@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1209282218350.17437@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > Hmm, it looks like the work on making evdev using dynamic device numbers
> > will clash with Henrik's changes. I think I will also pull this into my
> > tree and then git should be able to resolve it all properly in -next.
> 
> That should work. Alternatively you can pull 'from-henrik' branch from my 
> tree in case Henrik has already ditched/rebased his tree.

The tree will remain the same until after 3.7-rc1 is out, so pulling
should be fine.

Thanks,
Henrik
