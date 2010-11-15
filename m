From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] input: bcm5974: Add support for MacBookAir3
Date: Mon, 15 Nov 2010 14:18:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011151417290.7420@pobox.suse.cz>
References: <1289320722-1948-1-git-send-email-rydberg@euromail.se> <20101111083941.GE24415@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101111083941.GE24415@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Edgar (gimli) Hucek" <gimli@dark-green.com>, stable@kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 11 Nov 2010, Dmitry Torokhov wrote:

> On Tue, Nov 09, 2010 at 05:38:42PM +0100, Henrik Rydberg wrote:
> > From: Edgar (gimli) Hucek <gimli@dark-green.com>
> > 
> > This patch adds support for the MacBookAir3,1 and MacBookAir3,2
> > models.
> > 
> > [rydberg@euromail.se: touchpad range calibration]
> > Cc: stable@kernel.org
> > Signed-off-by: Edgar (gimli) Hucek <gimli@dark-green.com>
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> > Hi Dmitry, Jiri,
> > 
> > This patch was seen on lkml last week, and has now been excercised by
> > a larger set of users. As usual, this patch should go before or
> > together with the HID changes, so as not to break basic support from
> > the non-MT HID driver.
> > 
> 
> Jiri,
> 
> It looks like HID changes are more than simply adding USB device IDs so
> it woudl make sense to merge through your tree,

Hi guys,

makes sense. I already have the HID bits in my tree, and will apply the 
bcm5974 part as well.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
