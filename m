From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] HID: apple: Add another device ID for the mid-2013
 Macbook Air
Date: Sun, 25 Aug 2013 08:56:39 +0200
Message-ID: <20130825065639.GA12562@polaris.bitmath.org>
References: <1377353873-17000-1-git-send-email-darkstarsword@gmail.com>
 <1377353873-17000-2-git-send-email-darkstarsword@gmail.com>
 <20130824232630.GA4454@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130824232630.GA4454@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ian Munsie <darkstarsword@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Aug 24, 2013 at 04:26:30PM -0700, Dmitry Torokhov wrote:
> Hi Ian,
> 
> On Sun, Aug 25, 2013 at 12:17:52AM +1000, Ian Munsie wrote:
> > This patch adds a device ID found for mid-2013 Macbook Air 6,1 from
> > lsusb:
> > 
> > Bus 001 Device 003: ID 05ac:0290 Apple, Inc.
> > 
> > Since IDs already exist for this generation Macbook air as WELLSPRING8,
> > name this one WELLSPRING8A. This only adds an ANSI version since it's
> > device ID is only one less than the existing WELLSPRING8 IDs.
> > 
> > Signed-off-by: Ian Munsie <darkstarsword@gmail.com>
> 
> Thank you for the patch!
> 
> Jiri, can I take it through my tree for 3.11?

Wait, we probably want to resolve the USB ID inconsistency first. :-)

Thanks,
Henrik
