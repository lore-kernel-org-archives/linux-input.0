From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
Date: Tue, 14 Apr 2015 16:58:22 -0700
Message-ID: <20150414235822.GA22757@dtor-ws>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <20150414162210.GA29874@dtor-ws>
 <20150414223029.GU12732@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f196.google.com ([209.85.223.196]:33911 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbDNX61 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 19:58:27 -0400
Received: by ierx19 with SMTP id x19so1559319ier.1
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2015 16:58:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150414223029.GU12732@n2100.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Tue, Apr 14, 2015 at 11:30:29PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 14, 2015 at 09:22:10AM -0700, Dmitry Torokhov wrote:
> > On Tue, Apr 14, 2015 at 12:41:48PM +0200, Ulf Hansson wrote:
> > > The legacy system PM support has long time ago been dropped from the
> > > AMBA bus. Align to that by converting to the modern system PM
> > > callbacks.
> > > 
> > > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > If this has not been noticed since end of 2013 maybe we should drop the
> > driver?
> 
> That's rather silly.  It isn't a build breakage, and it's not a
> functional breakage.  In fact, this driver gets build and boot tested
> every evening on hardware I have here in my autobuild system.

OK.

> 
> The regression is only visible if it is used on a platform with power
> management support, and that's probably close to none - unless hibernate
> support is enabled.  I'm just pushing up some patches which fix long
> term hibernation issues on ARM.
> 
> If we apply your "lets drop stuff" argument, maybe we should drop ARM
> hibernation support because its been broken for many years... obviously
> that's also a rediculous suggestion.

Why is it a ridiculous suggestion? If it has been broken for  many
years I do not see why it has to be kept? Is there someone who is
actively working on making it functional?

Thanks.

-- 
Dmitry
