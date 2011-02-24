From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: bcm5974 - Report button also for zero fingers
Date: Thu, 24 Feb 2011 23:31:59 +0100
Message-ID: <20110224223159.GA6173@polaris.bitmath.org>
References: <1298576264-1563-1-git-send-email-rydberg@euromail.se>
 <20110224222058.GA2448@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:60616 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754399Ab1BXWa7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Feb 2011 17:30:59 -0500
Content-Disposition: inline
In-Reply-To: <20110224222058.GA2448@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 24, 2011 at 02:20:59PM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 24, 2011 at 08:37:44PM +0100, Henrik Rydberg wrote:
> > With the current code, pressing the integrated button with an
> > isolating tool does not result in any button report. Fixed
> > with this this patch.
> > 
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > ---
> > Hi Dmitry,
> > 
> > that nobody every complained about this bug is beyond me...
> 
> I guess nobody uses styluses to work with the touchpad... I'll apply it
> of course, but since I do not recall bug reports I'll hold it till .39 I
> think.

I was hoping it could slip into 2.6.38 - I can even produce a bug
report if needed. :-)

Henrik
