From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 0/7] hid driver transport cleanup
Date: Mon, 18 Feb 2013 21:49:41 +0100
Message-ID: <20130218204941.GA12214@polaris.bitmath.org>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
 <alpine.LNX.2.00.1302181012320.17024@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1302181012320.17024@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

> > so, here is the hid drivers cleanup. The aim is to remove as much as possible
> > direct calls to usbhid for hid drivers. Thus, other transport layers can use
> > the existing hid drivers (like I2C or uhid).
> > 
> > Henrik, patches 1 to 5 are yours. I just rebased and double-checked them. Please
> > add you Signed-off-by if you are happy with the rebase.
> 
> Henrik,
> 
> I can see your signoff in my inbox only for patches 1 and 2. Are you still 
> reviewing patches 3-5?

Yes, unfortunately the pipe is pretty full.

> Also, I'd like to make sure that we don't mess up the authorship, so 
> patches 1-5 should be applied with Henrik's authorship, right? (I can do 
> it after I receive signoffs from Henrik for those).

Benjamin has gone through the effort of keeping the patches
up-to-date, so I don't mind him being the author on most of
them. Maybe the first patch is actually identical to my earlier
submission, at least I seem to have it in my computer. :-)

Thanks,
Henrik
