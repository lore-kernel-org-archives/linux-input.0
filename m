From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
Date: Wed, 15 Apr 2015 10:32:45 +0100
Message-ID: <20150415093245.GV12732@n2100.arm.linux.org.uk>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <20150414162210.GA29874@dtor-ws>
 <20150414223029.GU12732@n2100.arm.linux.org.uk>
 <20150414235822.GA22757@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:58836 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbbDOJcz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 05:32:55 -0400
Content-Disposition: inline
In-Reply-To: <20150414235822.GA22757@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Tue, Apr 14, 2015 at 04:58:22PM -0700, Dmitry Torokhov wrote:
> On Tue, Apr 14, 2015 at 11:30:29PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 14, 2015 at 09:22:10AM -0700, Dmitry Torokhov wrote:
> > > On Tue, Apr 14, 2015 at 12:41:48PM +0200, Ulf Hansson wrote:
> > > > The legacy system PM support has long time ago been dropped from the
> > > > AMBA bus. Align to that by converting to the modern system PM
> > > > callbacks.
> > > > 
> > > > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > 
> > > If this has not been noticed since end of 2013 maybe we should drop the
> > > driver?
> > 
> > That's rather silly.  It isn't a build breakage, and it's not a
> > functional breakage.  In fact, this driver gets build and boot tested
> > every evening on hardware I have here in my autobuild system.
> 
> OK.
> 
> > 
> > The regression is only visible if it is used on a platform with power
> > management support, and that's probably close to none - unless hibernate
> > support is enabled.  I'm just pushing up some patches which fix long
> > term hibernation issues on ARM.
> > 
> > If we apply your "lets drop stuff" argument, maybe we should drop ARM
> > hibernation support because its been broken for many years... obviously
> > that's also a rediculous suggestion.
> 
> Why is it a ridiculous suggestion? If it has been broken for  many
> years I do not see why it has to be kept? Is there someone who is
> actively working on making it functional?

I *didn't* say it was broken everywhere - it's exactly the same situation
as ambakmi.  It doesn't work in a certain scenario, but that doesn't mean
it doesn't work at all, and it doesn't mean that there are no users of it.

The lesson I'm trying to teach you is that a patch or a report which says
something is broken does not _necessarily_ mean it's broken everywhere,
and jumping on the "oh we can remove it then" bandwagon immediately without
taking the time to understand the nature of the breakage is a totally
rediculous attitude for a kernel maintainer to take.  In fact, it's
positively harmful.

Had I not noticed your message, you would have probably ended up removing
a driver which is very much in use, is functional, and therefore is not
as broken as Ulf claims.

The other lesson to come away from this is that just because someone claims
something is broken does *not* make it broken.  It means _they_ are seeing
some problem which maybe no one else is seeing.  Again, that's no basis to
jump on the "lets remove the whole driver then" bandwagon.

And I doubt that Ulf even has the hardware to be able to test this change,
which makes it even worse.

So please, stop this idiotic "someone reports something broken, lets remove
the driver" attitude without first analysing whether the breakage actually
prevents anyone from using the driver.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
